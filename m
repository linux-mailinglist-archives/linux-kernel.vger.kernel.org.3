Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A3846E91A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbhLIN3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:29:36 -0500
Received: from mail-m972.mail.163.com ([123.126.97.2]:56852 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237940AbhLIN3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=7wRsh
        NQsLZdNkHzo3yuc4foMvoY3OLsqH8zve+LQGV8=; b=eC92dGxFlLsxFQpCwm2ZI
        lGE0GSCiLXTMW1I+MO7FBV3Nbe0j+lLuw+tQyA/wh9vOSDtWm6VjUiSfwVx9fUFy
        0l5/7NOaP3y0w7qiCDnTWXsMXygdt7agt69niVTZwsPbgKPBiE7hGXAbrm+spY8r
        TfNf3dL1zh429cKVBhqhWU=
Received: from localhost.localdomain (unknown [218.106.182.227])
        by smtp2 (Coremail) with SMTP id GtxpCgBHYT2_A7JhoRISMQ--.43569S5;
        Thu, 09 Dec 2021 21:25:38 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] staging: r8188eu: fix a memory leak in rtw_mp_QueryDrv()
Date:   Thu,  9 Dec 2021 21:25:16 +0800
Message-Id: <20211209132516.8387-2-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211209132516.8387-1-niejianglei2021@163.com>
References: <20211209132516.8387-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgBHYT2_A7JhoRISMQ--.43569S5
X-Coremail-Antispam: 1Uf129KBjvPXoW8urWrZr1xKFy3Ar48CryUp5X_GrWfZoWfWr
        sxJ3WrXw1DJr93tw4qvFW5XanrCay3uayrXFZYvFWagFyIga43KF45Ja40qay5Ar1xC3Wf
        G34rXr97tw18n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3AaLa
        J3UbIYCTnIWIevJa73UjIFyTuYvjxUTJ3kDUUUU
X-Originating-IP: [218.106.182.227]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiQxJkjFc7WYwcBwAAsb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Line 6191 (#1) allocates a memory chunk for input by kmalloc().
Line 6213 (#3) frees the input before the function returns while
line 6199 (#2) forget to free it, which will lead to a memory leak.
This bug influences all stable versions from 5.15.1 to 5.15.7.

We should kfree() input in line 6199 (#2).

6186 static int rtw_mp_QueryDrv(struct net_device *dev,
6187 			struct iw_request_info *info,
6188 			union iwreq_data *wrqu, char *extra)
6189 {
6191	char	*input = kmalloc(wrqu->data.length, GFP_KERNEL);
	// #1: kmalloc space

6195	if (!input)
6196		return -ENOMEM;

6198 	if (copy_from_user(input, wrqu->data.pointer, wrqu->data.length))
6199 			return -EFAULT; // #2: missing kfree

6213 	kfree(input); // #3: kfree space
6214 	return 0;
6215 }

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 906a57eae1af..edc660f15436 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -6195,8 +6195,11 @@ static int rtw_mp_QueryDrv(struct net_device *dev,
 	if (!input)
 		return -ENOMEM;
 
-	if (copy_from_user(input, wrqu->data.pointer, wrqu->data.length))
-			return -EFAULT;
+	if (copy_from_user(input, wrqu->data.pointer, wrqu->data.length)) {
+		kfree(input);
+		return -EFAULT;
+	}
+
 	DBG_88E("%s:iwpriv in =%s\n", __func__, input);
 
 	qAutoLoad = strncmp(input, "autoload", 8); /*  strncmp true is 0 */
-- 
2.25.1

