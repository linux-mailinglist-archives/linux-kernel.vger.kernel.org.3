Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9935B4BEF64
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 03:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbiBVCG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 21:06:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiBVCGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 21:06:54 -0500
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4E9240B2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 18:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1645495584;
        bh=uGSXRskyGSjCdegTSUAsPooBnCz/sf0teMn+TYg1BzM=;
        h=From:To:Cc:Subject:Date;
        b=inMSIudDGEc/UQfadcjArDoIN3pYkQLH15wc6CjL6J10Zac+KTRZT+ppRcOKLT0jk
         S/GZwgNg4b/5uhaqobP/+tRzAMhRfN96xcVk0cFUCUt/GHFpicTfxxUEQCBUZrqlPe
         v45VUq4s8zrmFRI9hYjzxPKVn8gOMV9ZVnr2FBxI=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc11.qq.com (NewEsmtp) with SMTP
        id 89BF689; Tue, 22 Feb 2022 10:02:09 +0800
X-QQ-mid: xmsmtpt1645495329twjjodjhi
Message-ID: <tencent_D9887936F780A393C232DC48C9EC3F1D4405@qq.com>
X-QQ-XMAILINFO: NIbHSc2ysKlDIVpcczwrsD6Mk3E7W3mD0aSsBerJF+SdT1oIkxVMzSQMrWwRhg
         hoOwvP10MXXW/nsY0PXGEL8AKPsvXxqA9p/IUU/0kKMvz9UJiUoW5CJRCSn1DwfDCvaX+070h4aG
         9kCmmAfHtDvLcaWgkfetTwxSiuOxAUeQco0OPPf2fQgbXbkiyJ1ljZZpyIC3I5z440xmmOKjf3ql
         Jdlu8qJQJuyWkOk4n6QuRDaX8f77cauGW6YRi1tlJkbEfk+jOeoedaUPR5RJP/eKK3ejiD4r6xcd
         kEOSUDdwQ6njieO4GOkXOnDVzUnG7cDaBTRDGJbLcXYJgq/6mXKRsjPuz+cSxNzDscsk/t0FiYIh
         cc172OQBwxLI3vwMYdIGY5a6MP+mIQshXjFFJJA/nvF6He7U1an4eO+o4BaUoxHM/HHwa9AW76nF
         24/kUUAtUT1hm6MAqar58ORv7ThXbRSYX2jVhkw28DEAFgJY4EYXWv7h9AgLWMpcwy3rnMMsPIqJ
         awSVKhckn5FHPuHe26vw3Mv+olvHQJ+kKiHKfAp3AWMEgAaKAjLOFSr1gu1iEcrgTXJv/EyRvasT
         fi1Ljrg6vRnrIZ2fHqot9qZXKkZw4AFp08MCboyd7GDcHW9A5NbWhc9eeGYBMtX75vTc1eKmLzSX
         G+Fe/SPNW0BBlq1ip4H6FVnX2zqhwEzigzuEhOLhNsIa0f3vYfvgcLftbGG33pMZcAsVs/plONZG
         1IPp7GScdU41+WOGa9fJ536nqx9C6qZ2LbTQ7c8Hu2iNBE2tqX2iFovX40f+bfGw7OgxE1+cEZRN
         LZfiVcpqThcJ82mAtzCyw9fBsaBH53JKTwvdH1FoGR6zOuMbfhwKTSi1AP8IKJv/GAqauk6Bo8EE
         hVr7FCSv8h+l6OXlKj7OM=
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, jerome.pouiller@silabs.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v3 2/2] staging: wfx: check the return value of devm_kmalloc()
Date:   Tue, 22 Feb 2022 10:00:24 +0800
X-OQ-MSGID: <20220222020024.3620-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

devm_kmalloc() returns a pointer to allocated memory on success, NULL
on failure. While there is a memory allocation of devm_kmalloc()
without proper check. It is better to check the return value of it to
prevent wrong memory access.
And I use the err label which is introduced by the previous patch to
handle the error.

Link: https://lore.kernel.org/r/tencent_24A24A3EFF61206ECCC4B94B1C5C1454E108@qq.com
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
Note:
I only send this one as the another patch had been applied.
And I put the Link of the applied patch as a reference.
Changelog:
v1->v2 update the description.
v2->v3 resolve a conflict with the staging-testing tree.
 drivers/staging/wfx/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
index c4b062b..23ae7d4 100644
--- a/drivers/staging/wfx/main.c
+++ b/drivers/staging/wfx/main.c
@@ -293,6 +293,9 @@ struct wfx_dev *wfx_init_common(struct device *dev, const struct wfx_platform_da
 	hw->wiphy->n_iface_combinations = ARRAY_SIZE(wfx_iface_combinations);
 	hw->wiphy->iface_combinations = wfx_iface_combinations;
 	hw->wiphy->bands[NL80211_BAND_2GHZ] = devm_kmalloc(dev, sizeof(wfx_band_2ghz), GFP_KERNEL);
+	if (!hw->wiphy->bands[NL80211_BAND_2GHZ])
+		goto err;
+
 	/* FIXME: also copy wfx_rates and wfx_2ghz_chantable */
 	memcpy(hw->wiphy->bands[NL80211_BAND_2GHZ], &wfx_band_2ghz, sizeof(wfx_band_2ghz));
 
-- 
