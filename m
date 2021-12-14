Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB745473F99
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhLNJe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:34:59 -0500
Received: from out203-205-251-27.mail.qq.com ([203.205.251.27]:55412 "EHLO
        out203-205-251-27.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230310AbhLNJe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:34:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639474495;
        bh=55kVr0dlRkSZXsR+36o/Om7tpdn03/ssVT7jqMxOOgw=;
        h=From:To:Cc:Subject:Date;
        b=dYrouJd/PkvB+OW+zVkbai99lcvKf2skr8T9aSQ49YRKM6fSt8d/4oa17K/rocJyS
         C8MxTBjcrIuOMYvBH0LYmwBaf/96d4dhMvfPyM8MJIjs0DV/MxLBo+BLGstPQnt3lo
         QQEH5NsBpZYvEZp2XBYGiXO+RSozegGUllIgt5KU=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza23.qq.com (NewEsmtp) with SMTP
        id 8B4AEE74; Tue, 14 Dec 2021 17:34:52 +0800
X-QQ-mid: xmsmtpt1639474492tf5grh2gf
Message-ID: <tencent_D6BF2948237359EE0A47338567B88512D106@qq.com>
X-QQ-XMAILINFO: OTiXS/gPSsXglOJF3mLFeOzLbS3UUL5y3JXRYQ8mK9XYqNnQMxmCJi7lYLHhgM
         bC/HxlsRN/59QASw2gt8sV6rtJlhVw3nWwHFGGkzI7kqge5NwX2xZyljQYveCSqknjSYlcUznOG0
         NGoEy7sSXHK8iBgDUS1ykQxzuiIZkICTMiGXrdlc+bRXjgO9OF2f1ZSbOoe/DyG85zk0lrdAuXtv
         LeVV5N3m8uVRASTKhVEmfRlCZa+NLWyvi9/tYMZ0Ne+q38HYy4SG7BMj7CPyD3igxrby0aLr3GO/
         sS+dt8ETSKSlYNcrKYsOnW/KcT5TcyjvfEYLDJsV78Aevbmx8/Cg3TQG8//ixe9dA9tHmwrJjaSu
         kcLaGDsLlNVaVRK6OP5duB8D0M7ro7vx8XcXwPgT8plbpKTfqEKATFTGq2+LleokB1LC5BZpoVVu
         PYyXMIMRl9QU73oxLcxEbSOP1mJ85Fm9PY2YPA2uRAgAUi23AMEx19PyeuHTEVgzwjBs56WLNPPo
         YJWfXKfbmMp4Fv8SSy+/tgPLZRXXNRv6ef9BHyQuyETZhf7z5P6XMsdlEwfH9w7eUl2Nm9vrVlFA
         vW1zJlaSfur5U96bLEQZtG67rrGlqPx0QRnQ15/t4+Z7ocNKR8H4KPIQLqT2qwdilIh7iAhUGnwk
         mxyP/lqP+7Xkj7TRLBA0xON8sBbqEybVl8dAuWOCYTWVBtQ4d/mpEE4qep5qWmygspKzuMFW2hDX
         deo1UHPteQEV0nUEo6AmoQ1eWRGXJ5CfKGo/s284z27QNkM1Ht+9M8KyYCI72DWSPYyn25pjBO1I
         7tBYd+CjdQXv6fwx2+WnhNgZ4+rVsFfx7LZLdm4VcxlFJsELtkQ/hCqTIWFhgFg1/CHQ8w8ic/OO
         Ze++wBXvwLSizpLhmb6+HlbHnwcFST1gqaTyA3NCK0i4i2a2c5ZYP2aNfeKDDC9w==
From:   xkernel.wang@foxmail.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] selinux: fix a wrong check condition of strcmp()
Date:   Tue, 14 Dec 2021 17:34:43 +0800
X-OQ-MSGID: <20211214093443.2415-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

strcmp() will return 0 when two strings(s1, s2 for example) are equal.
And if a negative number means s1 < s2. Here seems should use == 0 as
the condition. Otherwise, the value of genfs->fstype can not be
guaranteed.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 security/selinux/ss/services.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 759d878..c9f6c3a 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2883,7 +2883,7 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 
 	for (genfs = policydb->genfs; genfs; genfs = genfs->next) {
 		cmp = strcmp(fstype, genfs->fstype);
-		if (cmp <= 0)
+		if (cmp == 0)
 			break;
 	}
 
-- 
