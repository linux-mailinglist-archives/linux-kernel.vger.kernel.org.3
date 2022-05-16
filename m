Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260EB527E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbiEPHV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241087AbiEPHVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:21:45 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F73B17587
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1652684771; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=HDr/FFQNBXFV8vicf1l6hjE/A2euDlDbK5kQQYtyPTuLmMQqU/gKfjTrACJrx6jR0/CphquX5DkFCkfb4mKb17jLNVK6awizQlmXdS8N6x1JkCyZx+FUZQayLSP8wZ0JnbUjhh4MOo8cVEWIkwyGZbYX/XxTP0yUj5Z555DD3k0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1652684771; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=NIcPko3O8gQnfcEw2wD+BsSr/fE+oPhDVo1xC1CrC1M=; 
        b=PGL1v/cVRuZhLvAQSBDwMj9g/YkOcUM9aSIA+6MRAtfYksxcG1mKGGGc1poV7hAQeBQxpwRRHi7sZnP4QTYSXQPfnrWrh92ORJlGgbOaCEv4K3ykSpe4lnfmn7+wDue+g/p9S5R4BfKnQzv1MgZoRBnE4mkDPfGsX7YRaa5hFQQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=kempniu.pl;
        spf=pass  smtp.mailfrom=kernel@kempniu.pl;
        dmarc=pass header.from=<kernel@kempniu.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1652684771;
        s=zmail; d=kempniu.pl; i=kernel@kempniu.pl;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=NIcPko3O8gQnfcEw2wD+BsSr/fE+oPhDVo1xC1CrC1M=;
        b=LSJOdimXKmYqlmtuFAB+yt/QK2YcoZWZgWEf0df6TxO+n3JV+wtMfFNbdcbDfBKz
        cOcJ4c5O0peEsmbMjgDNhagL8Mt3JIeII1kLsiSWTlPcwQxwQ+kbRhHxAMxfB7Ygh9p
        ZSNIFxvQFACfRI0D/BwhyZ1wPe8ADa0TcZrCt6Rk=
Received: from larwa.hq.kempniu.pl (212.180.138.61 [212.180.138.61]) by mx.zoho.eu
        with SMTPS id 1652684770360299.9570452205538; Mon, 16 May 2022 09:06:10 +0200 (CEST)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <20220516070601.11428-2-kernel@kempniu.pl>
Subject: [PATCH 1/2] mtdchar: prevent integer overflow in a safety check
Date:   Mon, 16 May 2022 09:06:00 +0200
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

Commit 6420ac0af95d ("mtdchar: prevent unbounded allocation in MEMWRITE
ioctl") added a safety check to mtdchar_write_ioctl() which attempts to
ensure that the write request sent by user space does not extend beyond
the MTD device's size.  However, that check contains an addition of two
struct mtd_write_req fields, 'start' and 'len', both of which are u64
variables.  The result of that addition can overflow, allowing the
safety check to be bypassed.

The arguably simplest fix - changing the data types of the relevant
struct mtd_write_req fields - is not feasible as it would break user
space.

Fix by making mtdchar_write_ioctl() truncate the value provided by user
space in the 'len' field of struct mtd_write_req, so that only the lower
32 bits of that field are used, preventing the overflow.

While the 'ooblen' field of struct mtd_write_req is not currently used
in any similarly flawed safety check, also truncate it to 32 bits, for
consistency with the 'len' field and with other MTD routines handling
OOB data.

Update include/uapi/mtd/mtd-abi.h accordingly.

Suggested-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Micha=C5=82 K=C4=99pie=C5=84 <kernel@kempniu.pl>
---
 drivers/mtd/mtdchar.c      | 3 +++
 include/uapi/mtd/mtd-abi.h | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index d0f9c4b0285c..b2700f8467ff 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -615,6 +615,9 @@ static int mtdchar_write_ioctl(struct mtd_info *mtd,
 =09if (!usr_oob)
 =09=09req.ooblen =3D 0;
=20
+=09req.len &=3D 0xffffffff;
+=09req.ooblen &=3D 0xffffffff;
+
 =09if (req.start + req.len > mtd->size)
 =09=09return -EINVAL;
=20
diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
index b869990c2db2..890d9e5b76d7 100644
--- a/include/uapi/mtd/mtd-abi.h
+++ b/include/uapi/mtd/mtd-abi.h
@@ -69,8 +69,8 @@ enum {
  * struct mtd_write_req - data structure for requesting a write operation
  *
  * @start:=09start address
- * @len:=09length of data buffer
- * @ooblen:=09length of OOB buffer
+ * @len:=09length of data buffer (only lower 32 bits are used)
+ * @ooblen:=09length of OOB buffer (only lower 32 bits are used)
  * @usr_data:=09user-provided data buffer
  * @usr_oob:=09user-provided OOB buffer
  * @mode:=09MTD mode (see "MTD operation modes")
--=20
2.36.1


