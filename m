Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FD446E345
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbhLIHje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:39:34 -0500
Received: from mail-m975.mail.163.com ([123.126.97.5]:52840 "EHLO
        mail-m975.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbhLIHjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DO6HU
        4EncOkezaglXGqkLLhu6c1P4IlS7DTPCfCsDuc=; b=GSa4+r+7zUSLR1dkLr9kz
        yC2TuYP++HudQDvv6dK5ZxTb0lcSWWn9h2GDonHmgjalJ2JtJTW7xMjhtmx1gYeb
        YiKL5LWDFEA9zvt1yyPqKA2Ud5l8VbAJEro3cuNGrB/T/tNfa+absBw3w3xyhk3h
        5JV1IgHG4zzKh/dXE1KhAM=
Received: from localhost.localdomain (unknown [218.106.182.227])
        by smtp5 (Coremail) with SMTP id HdxpCgBnp+t+sbFhxrJBAw--.16111S4;
        Thu, 09 Dec 2021 15:34:52 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] staging: r8188eu: fix a memory leak in rtw_mp_QueryDrv()
Date:   Thu,  9 Dec 2021 15:34:21 +0800
Message-Id: <20211209073421.126251-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgBnp+t+sbFhxrJBAw--.16111S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur4kZw1Utw4DZF13KrWfZrb_yoW8WryrpF
        WfK342kFW5tw17XryDtwnxZryYy3WIkFyF9rW5C39xur95ZrnYvFykCrWj9rsrC34UJF4I
        yFW8try5Xa1DtF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqwZ7UUUUU=
X-Originating-IP: [218.106.182.227]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbi6xxkjFXlyeZvSQAAsm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Line 6183 (#1) allocates a memory chunk for input by kmalloc().
Line 6204 (#3) frees the input before the function returns while
line 6190 (#2) forget to free it, which will lead to a memory leak.

We should kfree() input in line 6190 (#2).

6177 static int rtw_mp_QueryDrv(struct net_device *dev,
6178 			struct iw_request_info *info,
6179 			union iwreq_data *wrqu, char *extra)
6180 {
6182	char	*input = kmalloc(wrqu->data.length, GFP_KERNEL);
	// #1: kmalloc space

6186	if (!input)
6187		return -ENOMEM;

6189 	if (copy_from_user(input, wrqu->data.pointer, wrqu->data.length))
6190 			return -EFAULT; // #2: missing kfree

6204 	kfree(input); // #3: kfree space
6205 	return 0;
6206 }

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 1fd375076001..0524523910f0 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -6186,8 +6186,11 @@ static int rtw_mp_QueryDrv(struct net_device *dev,
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

