Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A988C560108
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiF2NNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiF2NNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:13:23 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019C795BC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:13:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1656507467; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=bPEkODpH1BrWoLzj49AsqL2wDhtErpYfYCEC3rk/571uPh9DsExjBAV1AJegaCEX7QFwx0l20Yx+jDDhsdFZpzzHNf6lm3vLghA8zmF9hbGqCBe/pgs0/GCjEV7588Cn3vr20lVy6F9zdl/IYfXFEYzXPV9cF8pYyCGqPR6L/Xk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1656507467; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=dDOt+WPyVtaeSWilL0VTH0dNyV4Wzq9NV94huwKX8M4=; 
        b=duuSXOPTCtwfaDuXawVdRim6hRvNpAhu8caNpME3a14Xgl3crmcd4bVHJ4CgAsCh82nqV8oVio7rCH/EtMrNQnt5KKGRty8qO5GSU7NMmEOtmDOn60mHA+bYi5FpP6bc9m+06T7cajO4EYTAhmj8h7AoW9e96uwcmfhpXEaPG0U=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=kempniu.pl;
        spf=pass  smtp.mailfrom=kernel@kempniu.pl;
        dmarc=pass header.from=<kernel@kempniu.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1656507467;
        s=zmail; d=kempniu.pl; i=kernel@kempniu.pl;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=dDOt+WPyVtaeSWilL0VTH0dNyV4Wzq9NV94huwKX8M4=;
        b=bqY3W2KZn3mLzgc5vPFx02+p91frXe4AxfU3RPvg5CsFacoKiwhv7J/zpdCW3DPo
        uv5w9O7UTIu6gkn6iHQdQr8B+HNQHZ1OJQ0QisWhIcef42Z7hf+0/wQw14UlklhvPqI
        cId4iVO5VqoKCwR7zt+vI6xmbLefvb3DJ4kzvUv4=
Received: from larwa.hq.kempniu.pl (212.180.138.61 [212.180.138.61]) by mx.zoho.eu
        with SMTPS id 1656507466084174.89340666810722; Wed, 29 Jun 2022 14:57:46 +0200 (CEST)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <20220629125737.14418-2-kernel@kempniu.pl>
Subject: [PATCH v4 1/4] mtd: track maximum number of bitflips for each read request
Date:   Wed, 29 Jun 2022 14:57:34 +0200
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220629125737.14418-1-kernel@kempniu.pl>
References: <20220629125737.14418-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtd_read_oob() callers are currently oblivious to the details of ECC
errors detected during the read operation - they only learn (through the
return value) whether any corrected bitflips or uncorrectable errors
occurred.  More detailed ECC information can be useful to user-space
applications for making better-informed choices about moving data
around.

Extend struct mtd_oob_ops with a pointer to a newly-introduced struct
mtd_req_stats and set its 'max_bitflips' field to the maximum number of
bitflips found in a single ECC step during the read operation performed
by mtd_read_oob().  This is a prerequisite for ultimately passing that
value back to user space.

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Micha=C5=82 K=C4=99pie=C5=84 <kernel@kempniu.pl>
---
 drivers/mtd/mtdcore.c   | 5 +++++
 include/linux/mtd/mtd.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 6fafea80fd98..80c98e546d72 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1622,6 +1622,9 @@ int mtd_read_oob(struct mtd_info *mtd, loff_t from, s=
truct mtd_oob_ops *ops)
 =09if (!master->_read_oob && (!master->_read || ops->oobbuf))
 =09=09return -EOPNOTSUPP;
=20
+=09if (ops->stats)
+=09=09memset(ops->stats, 0, sizeof(*ops->stats));
+
 =09if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
 =09=09ret_code =3D mtd_io_emulated_slc(mtd, from, true, ops);
 =09else
@@ -1639,6 +1642,8 @@ int mtd_read_oob(struct mtd_info *mtd, loff_t from, s=
truct mtd_oob_ops *ops)
 =09=09return ret_code;
 =09if (mtd->ecc_strength =3D=3D 0)
 =09=09return 0;=09/* device lacks ecc */
+=09if (ops->stats)
+=09=09ops->stats->max_bitflips =3D ret_code;
 =09return ret_code >=3D mtd->bitflip_threshold ? -EUCLEAN : 0;
 }
 EXPORT_SYMBOL_GPL(mtd_read_oob);
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 955aee14b0f7..fccad1766458 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -40,6 +40,10 @@ struct mtd_erase_region_info {
 =09unsigned long *lockmap;=09=09/* If keeping bitmap of locks */
 };
=20
+struct mtd_req_stats {
+=09unsigned int max_bitflips;
+};
+
 /**
  * struct mtd_oob_ops - oob operation operands
  * @mode:=09operation mode
@@ -70,6 +74,7 @@ struct mtd_oob_ops {
 =09uint32_t=09ooboffs;
 =09uint8_t=09=09*datbuf;
 =09uint8_t=09=09*oobbuf;
+=09struct mtd_req_stats *stats;
 };
=20
 /**
--=20
2.37.0


