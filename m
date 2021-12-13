Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BB247223A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhLMIRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:17:04 -0500
Received: from out162-62-58-211.mail.qq.com ([162.62.58.211]:38543 "EHLO
        out162-62-58-211.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229483AbhLMIRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639383419;
        bh=WGyFzZjUpaoyHy9VQmJZshDUhmGUMzPm0ir4zv3soA0=;
        h=From:To:Cc:Subject:Date;
        b=MaHX5FXEkX6QUhQ9wkfN3PFay8f/UI9VSUDEJOf7OCA8nEROKaNoJp5/ZLaQvPmIW
         6RyeLqh02vlw+fjkWPJpqrbJGvLCrpfEK+GfWDi4861ubfELplYKsAeHi20csFU1NY
         Uf6KQ0M4tg5bCekom8Sl4woPA+dP9o2HGHRmqj3E=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrszb7.qq.com (NewEsmtp) with SMTP
        id 438110A2; Mon, 13 Dec 2021 16:16:56 +0800
X-QQ-mid: xmsmtpt1639383416t1u3u6951
Message-ID: <tencent_713C9C4229EF3F0CE48CF93A9794C3862205@qq.com>
X-QQ-XMAILINFO: NS0ZUBiNXRl8//ewNrbkJlya9s+2WHjopqdKCYooRxUEWpBXYIn4oPigi+gRor
         Et92LSzaXjm1rwlVMTEXgU38gn2XO/9KbNo+l3/yopeEM4+z8oRgbIsIsWq0pAoG7IKmdlpCNL1e
         jRJaaux0B5weXYk5FqesMvXMBZ5GxPjgCKLlHeasr5u4OpvmW29dtL0FSQ33M/tTF6LCPO1Amdpo
         3fEKRLIV5NlpT9O9Ss4BIvMfQsWtAKv6UxJt3JOFG5qeE+kH2HCbDYheOc7rSITSIwVQbhT98reg
         qkYXrEBafTCMyUgA52qKAB6n0ueI0mbZYNHYzrAu0sfPwN+WJcxLODJUzFSkMcTrm6ndH+pd0J9N
         ORCmF77qHb/ngad63y5iVTlKYIHyRfEQgkfkYDU6klifKGFg7ZV3pyURIp5vLxE2IAjTPbOTfOiF
         39lbEWBx/OCO5I02wuLUnypd62NQ7imHP/KbNphyxVAx9kAPDJU3kWJSPVt1bz7v1wDlNi7DStWU
         rYfvyxcT9DuMdG9Wg/IwnjRPh1YOmEXUnOJBC/hdIdwbSJUQmJeDW1iiyBmdPVN2ECxcpsH0+Goj
         xk5pwcUDVlsEMIMwaqE8Ffes1UC3UYTFbDtBi0Sj5d8fDT4/aZJny5Q7aU3nMYoYMH9Q0G/6TsTl
         CHqTvjZLMFpTdM1Gbx96HXz0+26qNVMw6kL3BYltz2HhXbcxTSZHMdS7xVeBk0u0ak7IgnPN2lnu
         S4B0+1AhJCZPx5EYOf1qPA1HbK149FruYi8q3LJbowHFDbfy6sBTNDoum9/vSFhiNGzHh6CFqZsw
         kygGfY/oLx5zxFqxOd2nT3TRM35xlCSA29m9yOeKg3huQCRztmARGptDYXUsvIwkxXIPvxGXwb1N
         FSqvsecE2lxuX+sw1uei83aSAm4s6NTll/YntppW+v
From:   Xiaoke Wang <xkernel.wang@foxmail.com>
To:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: Re: [PATCH] pstore/platform: check the return value of kstrdup()
Date:   Mon, 13 Dec 2021 16:16:31 +0800
X-OQ-MSGID: <20211213081631.4423-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: Compare with the last email, this one is using my full name.
kstrdup() returns NULL when some internal memory errors happen, it is
better to checkk the return value of it. Otherwise, some memory errors
will not be catched in time and may also further result in wrong memory
access.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 fs/pstore/platform.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index b9614db..f7c8732 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -620,6 +620,11 @@ int pstore_register(struct pstore_info *psi)
 	 * through /sys/module/pstore/parameters/backend
 	 */
 	backend = kstrdup(psi->name, GFP_KERNEL);
+	if (!backend) {
+		pr_err("out of memory duplicating '%s'\n", psi->name);
+		mutex_unlock(&psinfo_lock);
+		return -ENOMEM;
+	}
 
 	pr_info("Registered %s as persistent store backend\n", psi->name);
 
-- 
