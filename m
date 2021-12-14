Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76D9473ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 03:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243848AbhLNC1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 21:27:14 -0500
Received: from out162-62-57-137.mail.qq.com ([162.62.57.137]:44735 "EHLO
        out162-62-57-137.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229616AbhLNC1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 21:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639448830;
        bh=fWND/bY1kAzRn1LQyKfik7kT6re3gh2wAiYEuG8ZPyo=;
        h=From:To:Cc:Subject:Date;
        b=TVLhJm3vVKPwxnZZdUoIrihwuj1J0fTR8BYrHlfgp+g0KQUb94w0F/dlQCyYOjFNv
         2mtVpOiMoa1K9I5rS0ekqyVe86BVAaYU3qE2TdmSa2nqtS5ZTwEs/HLnVmGs1aOvQ2
         zavsHBHUJY2CkDBnueAIiwsvCAQUckzi4lgA7hVE=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza9.qq.com (NewEsmtp) with SMTP
        id 6C7A247A; Tue, 14 Dec 2021 10:27:07 +0800
X-QQ-mid: xmsmtpt1639448827t0uxrfrao
Message-ID: <tencent_4D6E270731456EB88712ED7F13883C334906@qq.com>
X-QQ-XMAILINFO: NqN/wpVFVRYXHD6GCVb24hKzWYsht1tMm0NBIo+XjTzsGn/1bk3RuDwIlusLXl
         mnokN2NuJHFLCQmS14KAyAjB5FLYOvUazFXrKXYIXNOEDc8P9OiVUMJNf6AyXAnpzPQ4chUi79t8
         hKEYa1vAkneHmBoIvcXnynnRKMA+HfZBUBg2kwRrKlb9Oo/TNO2zXuOBr9pFBsiZCBkFBocNnlpY
         vbFXNs5MAW/bPMgtEtCxSsH14uwNvBCwZYrSvSJh1zvr155BXG3Qq9m/QbCZuHFjwUeUT3z4axaQ
         kgxkjWb705kuaXfIXO1Re2FQAI4CReeXV9C8h5L5/CXHe7IAvV/1MSFsw7DMKYpRPoSwUO0GoZVV
         TdaRucrPEY9PsxmlZzHYjuKWvdaiKVIEgUxQzjE3GMAumhyFYwfRzMBq07s0sXYjT5K0n9CXKmwG
         oWvbFdRaSFSfPDRZAxUWDH+RDZqwZWHls9dnUSaO2WTE2p5IYbBmoBjcPt/oZ2+kiHQd+kXTf819
         AviyUK6pSb6W23MGAG3OIzHy+cUyzOH2kBVeOIWQ2wWgjDhak69HZJ8/ipW5FpAQlKZlgFH0Fyp9
         RTYEQ4P0jAWTzYotgTLz5DVh3YH4lc6g56hKgdQt545SccsUFZ36GAYuGuVxEU8By9kdAgJDLOMd
         2WbEoNEHARTsRMM4yWNTLAq3uisrjTo27p4QyuySOMm/8QuvgRsLTDMwbxRjJSwxEIhKjf7I2FgE
         XxVU73enRwomiQk7G2ey6FMFJyLKnipkpm4hdPTqBBzbh0PYjIVGow6oHbEXMqOdHl5yM74vhjwI
         9iM7WcJEOOqH6A1svRHkrYl7RIGgrY0+d+sMAryOSp5mJPiPb6x0hwkKmVQ5pIQMPkRpjpt+oNYU
         O4Gp+bk4Mo95jxC8xw7+nlr6Xw3jj3NswnetoZsA/LN/PuteONAu4=
From:   xkernel.wang@foxmail.com
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] tracing: check the return value of kstrndup()
Date:   Tue, 14 Dec 2021 10:26:46 +0800
X-OQ-MSGID: <20211214022646.1641-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kstrndup() is a memory allocation-related function, it returns NULL when
some internal memory errors happen. It is better to check the return
value of it so to catch the memory error in time.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 kernel/trace/trace_probe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 3ed2a3f..bb4605b 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -356,6 +356,8 @@ static int __parse_imm_string(char *str, char **pbuf, int offs)
 		return -EINVAL;
 	}
 	*pbuf = kstrndup(str, len - 1, GFP_KERNEL);
+	if (!*pbuf)
+		return -ENOMEM;
 	return 0;
 }
 
-- 
