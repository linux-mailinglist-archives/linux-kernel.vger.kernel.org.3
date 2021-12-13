Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471AF4721D9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhLMHkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:40:08 -0500
Received: from out203-205-221-233.mail.qq.com ([203.205.221.233]:58783 "EHLO
        out203-205-221-233.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230053AbhLMHkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639381206;
        bh=qH16UCbILLK1VIbn+YL3Zn3/Z/NDBg3u6EOmyyHF0tg=;
        h=From:To:Cc:Subject:Date;
        b=dPRrriv6ZYfP7/lOxqTKk83MCj+NQKV5kPtiY0rI+lypw7mhYyOpBTJwrrQxKN7hl
         GpcT8mU0Sw93e9Ls4CdGhaM7RPp+39kjMu008MrLWvjViuVGqhp0zS0GtJ1V+Lydfe
         YoReIzxfPNsYo2KBNVyC0M+0IuiYeqsN1T58vHYk=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrszb6.qq.com (NewEsmtp) with SMTP
        id A028B824; Mon, 13 Dec 2021 15:40:02 +0800
X-QQ-mid: xmsmtpt1639381202t5rjibsfn
Message-ID: <tencent_094816F3522E0DC704056C789352EBBF0606@qq.com>
X-QQ-XMAILINFO: M3ziZXKDk+iONkM+zBmL0oqMt2X16OZTTutED+JoujGCtiQ2z8gR+vGN3V/CI/
         GShe+Jsau0ry/h9XFHVauYxB4xEO0FcIxcXxTEIvyYZfXXiFAN18s4RXSn7wYklgYmu4M0MsSbG9
         yvqogXfzVLPKHisniYSaZxFhmcHf5Xy9jlGoidgAcUzHtQm6cHan3zKXzu3roKRmtrQd+4wqa2HM
         Lf5JbXKLRnWd5icoGFHyJaFTvAz2Rly6VwydGW4VbdSqv9plwzULhKPaCuPEmsTO7RkiBrLOmIpA
         YGkmwpVEIRrdbrX9Ptx7qaP6TJbClLtsVA75x8Oksa3NBhV3ZvvSpYH+ve8PdiHAw2ZrTF+cLHQY
         3d3xhvoujmdP2SCCXzV2zrchJvksqZI/CtI+gz63SsK4k4I7M368Haq9Qr1pJuLujSQv6rWv811U
         psDokJlv/ZAqJkx3gNTev4cb9N4Cq5JHQwBDARt0K/HUZqwjAVztiNT3BZsu7h75Qu7Iv3JBRXnV
         sK45mv7pK7rnlhsBriS9rmnLo+KU04v4Kj6pwzcN/0lQ82g/tBQV8DtBY+u4YGZwMF2037SuwJW3
         pMa5GuR7ahu0j3Of9HsqAs0nqK8IHAv5rn+omp2fx4ltewZ9xYNVDXg2vbmOMmGzE2Cc/MHfYwAP
         DGzUDeoZH2roDHGExUloMP7v5lwOrOsxZP10AO3hwrotLj8AEcVy7+2R8L6W0kXk/52En/jd7g6k
         S8+Btg7E7rYp9HyOQnO0xN7yAXl9eqwYjxwtv3b9a4YG4Hr++ZcvsicyLw+JolZBr1VZIVw/kToV
         lEqcpNPageHd0XKM+wLImlAn0CEF21xLwgFnlk83vLX+Kfl/btR0q+Hqce+tAWY0TOoHUPFk9Q9m
         oDJvziX/oxdEWukiW1MlE7n823vH2FrzfBi8+hcSeMTo3h5kfMa3s=
From:   Xiaoke Wang <xkernel.wang@foxmail.com>
To:     joe@perches.com, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: Re: [PATCH] ALSA: jack: Check the return value of kstrdup()
Date:   Mon, 13 Dec 2021 15:39:31 +0800
X-OQ-MSGID: <20211213073932.4240-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrdup() can return NULL, it is better to check the return value of it.
Fix: free jack and use my full name.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 sound/core/jack.c | 4 ++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/jack.c b/sound/core/jack.c
index 32350c6..5fd9954 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -509,6 +509,10 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 		return -ENOMEM;
 
 	jack->id = kstrdup(id, GFP_KERNEL);
+	if (jack->id == NULL) {
+		kfree(jack);
+		return -ENOMEM;
+	}
 
 	/* don't creat input device for phantom jack */
 	if (!phantom_jack) {
-- 

