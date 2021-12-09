Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B3146E341
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbhLIHit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:38:49 -0500
Received: from mail-m971.mail.163.com ([123.126.97.1]:50184 "EHLO
        mail-m971.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbhLIHis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:38:48 -0500
X-Greylist: delayed 916 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2021 02:38:48 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hQ/Nc
        Yr17qXJigIFKgNCs1BuxabXUu1zysX1Fq6jODY=; b=EORs5XONsBY2E6eGikMf6
        Q6CPXowSsLFRwHXXt/dh5ZOpcvwzBTn0O6Od1aQUlp+poQ9mE0BUC8ww+VItgL+G
        4r7hfjFF0BcLmtTtSzyiyzxMe15tNZwWI/lI8rXne9fGDqbCytbcURR6EMdcfgxI
        Nw8KidOHcFG+W5c0CiyW5s=
Received: from localhost.localdomain (unknown [218.106.182.227])
        by smtp1 (Coremail) with SMTP id GdxpCgC3CgTqrbFhcjxsAw--.9156S4;
        Thu, 09 Dec 2021 15:19:27 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] staging: r8188eu: fix a memory leak in rtw_mp_pwrtrk()
Date:   Thu,  9 Dec 2021 15:19:05 +0800
Message-Id: <20211209071905.125440-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgC3CgTqrbFhcjxsAw--.9156S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4rAw4DCr17KrW7XF1DKFg_yoW8Zw47pa
        yfAryUCrWvqw1rKas0kw17WrWF9w40vFWFga4Fkw43uryrurWrZa4UCryjkrs8AryxJF4Y
        kF45AFWUuw1qkrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jq89tUUUUU=
X-Originating-IP: [218.106.182.227]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbi6x9kjFXlyeZFbQAAsr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Line 5961 (#1) allocates a memory chunk for input by kmalloc().
Line 5966 (#2), line 5982 (#4) and line 5987 (#5) free the input
before the function returns while line 5979 (#3) forget to free it,
which will lead to a memory leak.

We should kfree() input in line 5979 (#3).

5953 static int rtw_mp_pwrtrk(struct net_device *dev,
5954 			struct iw_request_info *info,
5955 			struct iw_point *wrqu, char *extra)
5956 {
5961 	char	*input = kmalloc(wrqu->length, GFP_KERNEL);
	// #1: kmalloc space
5963 	if (!input)
5964 		return -ENOMEM;
5965 	if (copy_from_user(input, wrqu->pointer, wrqu->length)) {
5966 		kfree(input); // #2: kfree space
5967 		return -EFAULT;
5968	}

5973	if (strncmp(input, "stop", 4) == 0) {
5974		enable = 0;
5975		sprintf(extra, "mp tx power tracking stop");
5976	} else if (sscanf(input, "ther =%d", &thermal)) {
5977		ret = Hal_SetThermalMeter(padapter, (u8)thermal);
5978		if (ret == _FAIL)
5979			return -EPERM; // #3: missing kfree
5980		sprintf(extra, "mp tx power tracking start,
			target value =%d ok ", thermal);
5981	} else {
5982		kfree(input); // #4: kfree space
5983		return -EINVAL;
5984	}

5987	kfree(input); // #5: kfree space

5993	return 0;
5994 }

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 1fd375076001..8f9e0f12c51f 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -5975,8 +5975,10 @@ static int rtw_mp_pwrtrk(struct net_device *dev,
 			sprintf(extra, "mp tx power tracking stop");
 		} else if (sscanf(input, "ther =%d", &thermal)) {
 				ret = Hal_SetThermalMeter(padapter, (u8)thermal);
-				if (ret == _FAIL)
+				if (ret == _FAIL) {
+					kfree(input);
 					return -EPERM;
+				}
 				sprintf(extra, "mp tx power tracking start, target value =%d ok ", thermal);
 		} else {
 			kfree(input);
-- 
2.25.1

