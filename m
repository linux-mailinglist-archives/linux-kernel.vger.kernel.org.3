Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3140F4E3A34
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiCVIKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiCVIKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:10:06 -0400
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4352AEB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1647936509;
        bh=xj3turLHj1+ZCP9WjX9RjyOgZj7/g+f5TXLsbJ08Z6M=;
        h=From:To:Cc:Subject:Date;
        b=xqVD+HGcJkCFOyljoIp7AMoNMKPGUu99PpNUIOlf+DvxjAJPPrI4fduHOJFacVYVr
         GRuaYrjbg2nt5PsivERMq27ia9NEQ3IS16tfouF9eIDXJgAr3fXx+Bvj7l7kCGkCdw
         kbZMhRo0T1ELx91QaoWHBT8Fl4UppkgV+gR7LG+U=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrsza7.qq.com (NewEsmtp) with SMTP
        id 2198E433; Tue, 22 Mar 2022 16:08:25 +0800
X-QQ-mid: xmsmtpt1647936505ts0dqrfgq
Message-ID: <tencent_010A807048A5F97F0A900866A35C648E2E07@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0amHFt3Tv8ZnikjPM7gbCsdRyJBbsvvF8MDJx4K0X2JtCTAGGCU0
         USVhMFfAWjMjApTDU0aOobRK8pKYK3+RP3AW3nqaJpQDuEo3v+6XHgfjIidbeMx/M4EjU5yn3OBg
         T1nJpiqqVxcWjX2wgfoZUT4d0K3/3Fn0ijEvxk4UYsL4gjD5JdZq/xB2vVpgTfR7qoaeyyWys8h3
         GIxWb0I7I7iL6FCZfpKxoW+td9hHBy9cxxgmgapMa80vA6nSAuSyuoWnO5VwcirEQxNxDzspaFTc
         Wzu9tf93C7pxlsPW9gYCxOV3rtvgNjp1P/Z1Jp9cktsS/4WE1j0EyR6N3Rw8N9Vq81jRNOqDxyNW
         QsooJ8v+Ve1uqvfFswT+ZlDrIi/nOA5sfc5npycGs0faGzseuP8x+j8gP3C0uv/aGkcRcQ9NMqpr
         ONKu3/KSyHZJKOpn5hM2FDv/AHegPeJPxfb0F1BAnIlUm3Uw4Dm9R0144DjFZQ1KrF4mT2qB6+bU
         V1SsSXP2n6/OTq7FLHWbK2cWqLCMcB0hOxaUfTySxM4ExWp6XWT9DuIiQm8THsHfux+j3TFS/DGQ
         xyo5dXyXvFCp2cLOTiO9r+v4QcU2zV//beLzq6LxW3hLz5TN1tHe64Or2BTg63qLl8o/vFWw8qKM
         FtR1ZHdzjowCuoI5QPr/BkDrdodtZhjsET7o2lU2x9coG97wJYM8SrQZfjY6wghWAcRGx0q3IdjA
         s0wa1nHLCU0GWlrnKN7w1Xp8vP8Ki2+qBF7Fji2KrB91QsrGWps/NIuvvemUGFtW/qTncFAhQi/M
         1QmnJlQFv4lP8HuAjJk337DjfCMwrQQw8AFYhHkM3WbbR4R/y6L4ISkyHjUKjbtmyWHKu89AO8pn
         j8RUABvcj64AYPpaYlnhmxhD/T1XOSZhApA9AxkzHkL9hvz+6Io18NpxRgiXT4EbP9MdGe3vxO
From:   xkernel.wang@foxmail.com
To:     xiang@kernel.org, chao@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] erofs: fix a potential NULL dereference of alloc_pages()
Date:   Tue, 22 Mar 2022 16:08:12 +0800
X-OQ-MSGID: <20220322080812.1574-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

alloc_pages() returns the page on success or NULL if allocation fails,
while set_page_private() will dereference `newpage`. So it is better to
catch the memory error in case other errors happen.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 fs/erofs/zdata.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 11c7a1a..36a5421 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -735,11 +735,15 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		struct page *const newpage =
 				alloc_page(GFP_NOFS | __GFP_NOFAIL);
 
-		set_page_private(newpage, Z_EROFS_SHORTLIVED_PAGE);
-		err = z_erofs_attach_page(clt, newpage,
-					  Z_EROFS_PAGE_TYPE_EXCLUSIVE);
-		if (!err)
-			goto retry;
+		if (!newpage) {
+			err = -ENOMEM;
+		} else {
+			set_page_private(newpage, Z_EROFS_SHORTLIVED_PAGE);
+			err = z_erofs_attach_page(clt, newpage,
+						Z_EROFS_PAGE_TYPE_EXCLUSIVE);
+			if (!err)
+				goto retry;
+		}
 	}
 
 	if (err)
-- 
