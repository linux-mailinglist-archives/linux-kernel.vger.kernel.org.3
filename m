Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1AFA4935CE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352207AbiASHsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:48:39 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38378
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352177AbiASHsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:48:24 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3583B3F1E9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642578503;
        bh=iCsbKRFYtpy96brOq0zYi/PpCyfWdxoLfUAjSC23KxI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=LYruI4o3oOooY1r/kR2VfxLKhZUqwMGoFJgtzXmQKZVT2N2UrXLlxfh3oj9i2b6gC
         DfuVev4w1YS9GDU4MIC5zj++oV+9PorFGA5eG659Wc+ca84ubiMiQd8wMyjDlxHq19
         FYhxfqInMikmx/LJOESdE+0UayGvsJ+HVjIqm/tU+iBieFSqjZXuBpKsQSLJ7ux1q7
         yspVX07RldUmgHkdTQMX80eULcooc8SAzMnRSztpCCG79WWjfQE0jsa6kuFJshcSMQ
         RgOpN9jXNERMr+23oYJUXjSrS/kM/qrLrhmNlYEHpCw4StDhHvOGZwFNr+Q/D2PRO3
         fJ1LjobMB/E2w==
Received: by mail-ed1-f69.google.com with SMTP id t13-20020a05640203cd00b00403cefbefe7so1490716edw.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 23:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iCsbKRFYtpy96brOq0zYi/PpCyfWdxoLfUAjSC23KxI=;
        b=gHR6HMTTm6h0mJVNY5qLxRkQQSKc6j2wvO6Qu+2jfGL/X0PTeEyvqFl8plwOVZujyL
         JZriM9UlHag72/P1h9ISIZx09nvh6h8EC4/ZKI721BpZbw68aLs3VCyOp+iqDkdKfLzM
         US4nVkbcfyR0WYbA2M5v4MJat4AwG8nZlrRhaNF4gFx/g6bAeSlJw29+dMYfrEWpdu4j
         LuzxPdcl+UHozmJWgpoJ3ovHR3Y9r0YbWjHcQI+UVttHIO2iSk1HqsqYFmxGVWNZXAAn
         gbQDjTjP08zipYJ5SRrVp94wSfxrWNqmaU6GQP1H7InXCyWCAhHShL6+PUsWY1GbfmYp
         /s8Q==
X-Gm-Message-State: AOAM533qs1HivdLP/AHvsBFT4DLZpLVFGlOel+XNgNif6V+G4BsQgFdV
        2lOz6011aNhHhnL/hElr7dy1EnI3z9L9qII4OFkyqAoUxXRzdOWTxFfHB8O8udPLap871X4MLb8
        681+xschH18/htI7k1f11D+YOubhnXpmJATi3rNsCAg==
X-Received: by 2002:a05:6402:84c:: with SMTP id b12mr7507201edz.243.1642578502816;
        Tue, 18 Jan 2022 23:48:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy92l9OELb/JNLf9Srkc2YlRT5NXMskJoriRhm94S0jCBqI7jA0MER7CYMeGjMbYmb4t8IWrQ==
X-Received: by 2002:a05:6402:84c:: with SMTP id b12mr7507191edz.243.1642578502593;
        Tue, 18 Jan 2022 23:48:22 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id zo4sm1104996ejb.143.2022.01.18.23.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 23:48:22 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     syzbot+7f23bcddf626e0593a39@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: [PATCH v2 1/1] nfc: llcp: fix NULL error pointer dereference on sendmsg() after failed bind()
Date:   Wed, 19 Jan 2022 08:48:16 +0100
Message-Id: <20220119074816.6505-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220119074816.6505-1-krzysztof.kozlowski@canonical.com>
References: <20220119074816.6505-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot detected a NULL pointer dereference of nfc_llcp_sock->dev pointer
(which is a 'struct nfc_dev *') with calls to llcp_sock_sendmsg() after
a failed llcp_sock_bind(). The message being sent is a SOCK_DGRAM.

KASAN report:

  BUG: KASAN: null-ptr-deref in nfc_alloc_send_skb+0x2d/0xc0
  Read of size 4 at addr 00000000000005c8 by task llcp_sock_nfc_a/899

  CPU: 5 PID: 899 Comm: llcp_sock_nfc_a Not tainted 5.16.0-rc6-next-20211224-00001-gc6437fbf18b0 #125
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x45/0x59
   ? nfc_alloc_send_skb+0x2d/0xc0
   __kasan_report.cold+0x117/0x11c
   ? mark_lock+0x480/0x4f0
   ? nfc_alloc_send_skb+0x2d/0xc0
   kasan_report+0x38/0x50
   nfc_alloc_send_skb+0x2d/0xc0
   nfc_llcp_send_ui_frame+0x18c/0x2a0
   ? nfc_llcp_send_i_frame+0x230/0x230
   ? __local_bh_enable_ip+0x86/0xe0
   ? llcp_sock_connect+0x470/0x470
   ? llcp_sock_connect+0x470/0x470
   sock_sendmsg+0x8e/0xa0
   ____sys_sendmsg+0x253/0x3f0
   ...

The issue was visible only with multiple simultaneous calls to bind() and
sendmsg(), which resulted in most of the bind() calls to fail.  The
bind() was failing on checking if there is available WKS/SDP/SAP
(respective bit in 'struct nfc_llcp_local' fields).  When there was no
available WKS/SDP/SAP, the bind returned error but the sendmsg() to such
socket was able to trigger mentioned NULL pointer dereference of
nfc_llcp_sock->dev.

The code looks simply racy and currently it protects several paths
against race with checks for (!nfc_llcp_sock->local) which is NULL-ified
in error paths of bind().  The llcp_sock_sendmsg() did not have such
check but called function nfc_llcp_send_ui_frame() had, although not
protected with lock_sock().

Therefore the race could look like (same socket is used all the time):
  CPU0                                     CPU1
  ====                                     ====
  llcp_sock_bind()
  - lock_sock()
    - success
  - release_sock()
  - return 0
                                           llcp_sock_sendmsg()
                                           - lock_sock()
                                           - release_sock()
  llcp_sock_bind(), same socket
  - lock_sock()
    - error
                                           - nfc_llcp_send_ui_frame()
                                             - if (!llcp_sock->local)
    - llcp_sock->local = NULL
    - nfc_put_device(dev)
                                             - dereference llcp_sock->dev
  - release_sock()
  - return -ERRNO

The nfc_llcp_send_ui_frame() checked llcp_sock->local outside of the
lock, which is racy and ineffective check.  Instead, its caller
llcp_sock_sendmsg(), should perform the check inside lock_sock().

Reported-and-tested-by: syzbot+7f23bcddf626e0593a39@syzkaller.appspotmail.com
Fixes: b874dec21d1c ("NFC: Implement LLCP connection less Tx path")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. Only split to independent set and updating Syzbot tested tag.
---
 net/nfc/llcp_sock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 6cfd30fc0798..0b93a17b9f11 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -789,6 +789,11 @@ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	lock_sock(sk);
 
+	if (!llcp_sock->local) {
+		release_sock(sk);
+		return -ENODEV;
+	}
+
 	if (sk->sk_type == SOCK_DGRAM) {
 		DECLARE_SOCKADDR(struct sockaddr_nfc_llcp *, addr,
 				 msg->msg_name);
-- 
2.32.0

