Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BBA4E6C65
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 03:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357742AbiCYCMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 22:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353106AbiCYCMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:12:13 -0400
Received: from out203-205-251-80.mail.qq.com (out203-205-251-80.mail.qq.com [203.205.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B94A995C;
        Thu, 24 Mar 2022 19:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648174141;
        bh=qFJ1QKKq9b1Aw/+2U+A/f4XMNjTre/xqecawonGmicU=;
        h=From:To:Cc:Subject:Date;
        b=c4eJk01iY7sxKK5+q9z5Wb8vUpugjzSujVMUFUpn2cm39Q+090n0pehB94FOVIlnE
         xtxUuIcpO/DEKB2yiWkMYtH/mLCo304dMCICUtrl0Zsmp2qmadYFFjjeLbbaPIjJXU
         ejp1uiu801+OwKMi/6tbrpMkzfI3LH5rnFKJJrb4=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrsza7.qq.com (NewEsmtp) with SMTP
        id 2390880F; Fri, 25 Mar 2022 10:08:57 +0800
X-QQ-mid: xmsmtpt1648174137ts0bx8q70
Message-ID: <tencent_6A5CCC9FB9221C4A1414E1534A3DFFC62008@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8lE/Tdyw2QdmN7BJTJJjH0Xf57GpNlk+aLRpaqo9Tnc8vn9EBQE
         uvvSIu0IG7AIMyM9syJpW+UFUsF0XzpelbwexNj+dRaQz1b+wEbZLcV33BnfV3ZFaYdb4SAN6BA7
         DHVnEuGP7p/4MKiGIY03JT6ORxftcQPmsq97w0UR/2dhN3yosWyqvCW200Tv8YgLgABBZ8ziYr1S
         Wq/q0ILL9wyolxRXjgkKNRjifi5xYFD5ZksOFU5m89G6/hT12dA5F8y4IcFRzJ3qiWXlEtvZvPL7
         EVp6sSa1Qz1kz5CQ0Qrc954Nb9JGHJwRJzzJiih2Ez/5rRiQ5Aovou33zGKiACdln7iUKbGnRMcs
         vafYTT7VRn9cWMVhSy0qDJ/sekeKDfZ05TrkTUBWOhIIPe5WtmX/UAthmVPgXhSvH/2tkRHpitB9
         Eu5273yxRzQV8l73jZ6UVkB0roovZqrfwCgESGaxRrJzX6qCiZIe+YAtnTf+/epRg4ggoWgVt67U
         /N/vZRWgJcnikZUaA7vbWqOyTpspDruICg7QqYKn2uUFWacjcjNFSrmGYDnXgdSHwQd+7qDofgHv
         rtq5SiFsctWlsIz/3qhQcVZ9qr+L5urfyY2MbiMzp6PO2aQlEzJX1yWr0FHzvKoJsSI05NJegCHV
         4GK5jq8UwNr+Op+55VIup7WnfkLnW8DPmqQ13yvGZS/EUHUt8QOk/sgOCyyvHDw5t6DDQeZywoOW
         n+tmWbesNhLRv+7HiW2GENUQHOgsE0JWXw3JBJzWF1HWShUTXP3kBPsWS90Xxr0KnKtu1DMAby+d
         cFZ0sCjF099qShf5pJWNN7/u4fQPNXAfd9Efw7Lj3Vb8KEeFV387Afij9QnDyL7Yky8oSWAc9sE+
         FaubL/NuDy+bzfGv4mvkkxb8Gr5w77SVzxLU3c6x4wRcmUXQqiuYPEiWZB1a3NFNS1zZHCt5WZ
From:   xkernel.wang@foxmail.com
To:     agross@kernel.org, bjorn.andersson@linaro.org, joro@8bytes.org,
        will@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] iommu/msm: add a check for the return of kzalloc()
Date:   Fri, 25 Mar 2022 10:08:01 +0800
X-OQ-MSGID: <20220325020801.3301-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
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

kzalloc() is a memory allocation function which can return NULL when
some internal memory errors happen. So it is better to check it to
prevent potential wrong memory access.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/iommu/msm_iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 3a38352..697ad63 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -597,6 +597,10 @@ static void insert_iommu_master(struct device *dev,
 
 	if (list_empty(&(*iommu)->ctx_list)) {
 		master = kzalloc(sizeof(*master), GFP_ATOMIC);
+		if (!master) {
+			dev_err(dev, "Failed to allocate iommu_master\n");
+			return;
+		}
 		master->of_node = dev->of_node;
 		list_add(&master->list, &(*iommu)->ctx_list);
 		dev_iommu_priv_set(dev, master);
-- 
