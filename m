Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB5C583857
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbiG1F77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 01:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiG1F75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 01:59:57 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B635C371
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 22:59:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w5so839187edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 22:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rH1rWR5ceTocR8VYoz9QhZ22rfTktTyDsu+u/jdxD/Q=;
        b=jzHtRPaAaJDnpz9SiuozBQxsMBqdeJjMfVgqccRSJ+MblMg7rHVBhDZ4UE9478uH4O
         z/EA9vkBxik9lBdxRsPyVZhvCMMtlmo51p/Il0Aryrh7H4HApIBsYLMjhhFaAA+05A5J
         l4gX+6bbiPv2mP4DWUukI9aV1Gp4dRhqbogTJv6htXYXKgXAlsFAdEvlneq2jssNRtwJ
         yWLI9V6GdjrUOlrEblpSiitXvOWbZ2Zm1T2+HPwdRlaC4Pr/pEdsmFN73Z/dNXZyydOT
         ee0eBg3/5oq2BszaE3buaDIj2fO/kdrevm7T2sj2V5a03q2GYkx32iWl15Hy7YyQvZLG
         q2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rH1rWR5ceTocR8VYoz9QhZ22rfTktTyDsu+u/jdxD/Q=;
        b=duisqj3FmyRfd81b4q9+q5Z0mos9puoeupDE+bCVUphD41nOZOg/WG523qeDbEkuKs
         9++tqqbU0DAaXifJjhQniE8/N/o+ze2XJsgBJg30bz9BoxVmc/qGKHyczyYLXaAy4i5r
         3ynSHSnp4WGWY6ZmCb0tHal5yO4Nk5oC8YZnDNkJ9oBvcODn4SLFVBt8T7lypBdrISMS
         nFQoS7bzWpmz7+Nxh3xcDzCXxC/mjnHt1vTs0TPYYGXXh3fO4lnyyNIrXGeNJeA1OpX3
         0SwKAhUVPBVp7qaZG7GXLlYiUL35FcmZI5cKAE9eBx0bsVrY++Ec/elXaalK9Sh+469m
         WmGg==
X-Gm-Message-State: AJIora80VT7zK8mwilH22/MjdlbtJpLCv6RDEFcXO5eIRJzR0G0A7oqr
        +A7bY7eEU3NZpVAUUUXXZPE=
X-Google-Smtp-Source: AGRyM1tNRoBAGcwHk4I42NrE7AFYYHSvBxuMDhDuUsRdnvfCvBHD/tpsn0YsNBYhExzd0QHq/FAm9Q==
X-Received: by 2002:a05:6402:11c9:b0:43b:b905:cb88 with SMTP id j9-20020a05640211c900b0043bb905cb88mr26000024edw.102.1658987995255;
        Wed, 27 Jul 2022 22:59:55 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id bx13-20020a0564020b4d00b0043a75f62155sm73395edb.86.2022.07.27.22.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 22:59:54 -0700 (PDT)
Date:   Thu, 28 Jul 2022 07:59:45 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] staging: vt6655: Convert macro
 vt6655_mac_clear_stck_ds to function
Message-ID: <cbfe5cc170b68564ff45bb7f45c63de241c2a664.1658986804.git.philipp.g.hortmann@gmail.com>
References: <cover.1658986804.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1658986804.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert once used macro to static function. Multiline macros are not
liked by kernel community. Rename variable byOrgValue to reg_value to
avoid CamelCase which is not accepted by checkpatch.pl. Change variable
declaration to u8 as this improves readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Combind patch "Rename byOrgValue to reg_val..." with this one
          Removed function declaration
          Changed variable declaration
          Improved patch description
---
 drivers/staging/vt6655/mac.c | 9 +++++++++
 drivers/staging/vt6655/mac.h | 8 --------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index d7ee42df7062..dcc649532737 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -70,6 +70,15 @@ void vt6655_mac_word_reg_bits_off(void __iomem *iobase, const u8 reg_offset, con
 	iowrite16(reg_value & ~(bit_mask), iobase + reg_offset);
 }
 
+static void vt6655_mac_clear_stck_ds(void __iomem *iobase)
+{
+	u8 reg_value;
+
+	reg_value = ioread8(iobase + MAC_REG_STICKHW);
+	reg_value = reg_value & 0xFC;
+	iowrite8(reg_value, iobase + MAC_REG_STICKHW);
+}
+
 /*
  * Description:
  *      Test if all test bits off
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 3d6d53d5b383..467c599a3289 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -537,14 +537,6 @@
 
 /*---------------------  Export Macros ------------------------------*/
 
-#define vt6655_mac_clear_stck_ds(iobase)				\
-do {									\
-	unsigned char byOrgValue;					\
-	byOrgValue = ioread8(iobase + MAC_REG_STICKHW);			\
-	byOrgValue = byOrgValue & 0xFC;					\
-	iowrite8(byOrgValue, iobase + MAC_REG_STICKHW);			\
-} while (0)
-
 #define MACvSelectPage0(iobase)				\
 	iowrite8(0, iobase + MAC_REG_PAGE1SEL)
 
-- 
2.37.1

