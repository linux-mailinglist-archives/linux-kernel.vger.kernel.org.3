Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B28527E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241028AbiEPHVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241090AbiEPHVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:21:45 -0400
X-Greylist: delayed 907 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 May 2022 00:21:41 PDT
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6439D17076
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1652684772; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=Ngw7i+0UWu7Qdbil8j+grmG8yJ1wunVJtZJGAOxIqr/+JVsg6BMwqoocN/3bRvzdiiMgziQxTSHQEMO8cUSsqBFTE7PB93xr79hBNJBI7Vz5anbq0rGrrmrXd0LvNzvdd+OxhFfYcZ67TMi8yChrNpZLPGIRpH7T8V4GnDlRqnk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1652684772; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=LehfBAU/QvIra7OAgcW4TPq9bLABt9XwCeJZGewh1TA=; 
        b=X0RAg8jgQ/SeF7bxmUVmj8bn3Vc4WNbf1DexcrxorAZL8Evkq7kfTL0l5WLmD/+dRgmS/6OuU5KJKI3FnkpiPX+t2YUnpT/gquf6W35yk5g6G/WB8ZuZCFAsHggzZW7vevpPk1hgwYsuLGrR3/TmyJNE4jW0PhP5PF0M2PQG5fA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=kempniu.pl;
        spf=pass  smtp.mailfrom=kernel@kempniu.pl;
        dmarc=pass header.from=<kernel@kempniu.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1652684772;
        s=zmail; d=kempniu.pl; i=kernel@kempniu.pl;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=LehfBAU/QvIra7OAgcW4TPq9bLABt9XwCeJZGewh1TA=;
        b=QhGQBq5FWlhvbilFYEJvQteh6s5HQJjUrrvUDpGtDn8+UoVoHhbNe0XKO9RCWXYb
        PdTjTIww0Dg+n3cg3TvhkvnClCqcwIbfzMsJs6b5Xs4UZKSGV/j2XdSQ3GpmqH4Pg0k
        /OMz2Ipt1wHfGC7YOPXBFIXL+jfIwiZGpl8ATyyc=
Received: from larwa.hq.kempniu.pl (212.180.138.61 [212.180.138.61]) by mx.zoho.eu
        with SMTPS id 16526847706676.485162993223867; Mon, 16 May 2022 09:06:10 +0200 (CEST)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <20220516070601.11428-3-kernel@kempniu.pl>
Subject: [PATCH 2/2] mtdchar: use kvmalloc() for potentially large allocations
Date:   Mon, 16 May 2022 09:06:01 +0200
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516070601.11428-1-kernel@kempniu.pl>
References: <20220516070601.11428-1-kernel@kempniu.pl>
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

mtdchar_write_ioctl() calls kmalloc() with the 'size' argument set to
the smaller of two values: the write request's data/OOB length provided
by user space and the erase block size of the MTD device.  If the latter
is large, kmalloc() may not be able to serve such allocation requests.
Use kvmalloc() instead.  Correspondingly, replace kfree() calls with
kvfree() calls.

Suggested-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Micha=C5=82 K=C4=99pie=C5=84 <kernel@kempniu.pl>
---
 drivers/mtd/mtdchar.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index b2700f8467ff..05860288a7af 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -623,16 +623,16 @@ static int mtdchar_write_ioctl(struct mtd_info *mtd,
=20
 =09datbuf_len =3D min_t(size_t, req.len, mtd->erasesize);
 =09if (datbuf_len > 0) {
-=09=09datbuf =3D kmalloc(datbuf_len, GFP_KERNEL);
+=09=09datbuf =3D kvmalloc(datbuf_len, GFP_KERNEL);
 =09=09if (!datbuf)
 =09=09=09return -ENOMEM;
 =09}
=20
 =09oobbuf_len =3D min_t(size_t, req.ooblen, mtd->erasesize);
 =09if (oobbuf_len > 0) {
-=09=09oobbuf =3D kmalloc(oobbuf_len, GFP_KERNEL);
+=09=09oobbuf =3D kvmalloc(oobbuf_len, GFP_KERNEL);
 =09=09if (!oobbuf) {
-=09=09=09kfree(datbuf);
+=09=09=09kvfree(datbuf);
 =09=09=09return -ENOMEM;
 =09=09}
 =09}
@@ -682,8 +682,8 @@ static int mtdchar_write_ioctl(struct mtd_info *mtd,
 =09=09usr_oob +=3D ops.oobretlen;
 =09}
=20
-=09kfree(datbuf);
-=09kfree(oobbuf);
+=09kvfree(datbuf);
+=09kvfree(oobbuf);
=20
 =09return ret;
 }
--=20
2.36.1


