Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224CD591D7C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 03:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiHNBzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 21:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiHNBzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 21:55:36 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D2413DFD
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 18:55:34 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j7so5191477wrh.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 18:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=TNitijqiLWD8N0q+QjMXs+eaMvvzYslxu1nXPHeU+Ic=;
        b=FnPMYv53dzLScK8FwJaJSD6pM5/QMCnzb8PSymP17lig+ulpqphrfTK2MAtdzAuNfA
         kLZiHwqJpmi2lIUCgXjQaJeg9pk/M5cWuP0qo4nR4zX8qJaIweMI+4l/yidgA73Uq0bk
         oVEJOEhFQ8fPaV3G1qk7zi0vzv+j/hWN/djRGHS10xXc4+WQvd0RGrJVXoggVnTwoQg7
         WHoVk0mzVGtaYYfs3K7jDLsL/hHqtS1VECCmz0RQlvdCzo5LCGg/1JgFw8iItP9mQaRY
         c5VMlFdOr21yzIMfIEsc/9OSi8WfBf7UN4GxOBuq+pZkGZmSpEpvvW7BHkQXdzzm3nDg
         kWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=TNitijqiLWD8N0q+QjMXs+eaMvvzYslxu1nXPHeU+Ic=;
        b=CELhAc6JZYJgg22P2NtVgKJWpc7DlpUxKfbM6g9mws6yTAZIEvjfYMtzaC+TgqEbdo
         SCSi2MrTRWbJIM5/8AbLguq3H2lmYWSAiJNoGaahJBDyUVvJ+fYNF073GDF+okF6U4TL
         fzXPegC5R/ZiZ2MjskAnRZrxrFUZ8/MrM+pckCp1667DISY8XW4+czU6xuAQ/mzvq+04
         vbhNkYq9GUFcTt5SRUP8FcKHLkzaN1jvlmrbZ2+sorPmCEGuiR45Iiz6g+/SdH4WM3Zj
         rfUj5DSKfE+QzE0DoM95/ynD8KXJ6VaUF6ZF2QWA4dEdcLO6sjcOVBvSG5eDdkndAuqd
         SCuQ==
X-Gm-Message-State: ACgBeo3TxWO+iz6knmGfo+wjTMHK3sAXiqfca4HcwTAvWyo/Xw7JMfen
        7h+tfjqj8KnT6v7e5f8dJnA=
X-Google-Smtp-Source: AA6agR4YBcFca/UDOlp8gjODh6JVGCJykTj6AJCW21OE2srC/zsZpZzUt9pGZd2DCjb887IpZnLr2Q==
X-Received: by 2002:a05:6000:381:b0:221:7542:61bb with SMTP id u1-20020a056000038100b00221754261bbmr5264691wrf.305.1660442133117;
        Sat, 13 Aug 2022 18:55:33 -0700 (PDT)
Received: from localhost.localdomain ([84.255.184.228])
        by smtp.gmail.com with ESMTPSA id l9-20020a5d5609000000b0021f1ec8776fsm3247558wrv.61.2022.08.13.18.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 18:55:32 -0700 (PDT)
From:   Mazin Al Haddad <mazinalhaddad05@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, daniel.starke@siemens.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, paskripkin@gmail.com,
        Mazin Al Haddad <mazinalhaddad05@gmail.com>,
        syzbot+e3563f0c94e188366dbb@syzkaller.appspotmail.com
Subject: [PATCH v2] tty: n_gsm: add sanity check for gsm->receive in gsm_receive_buf()
Date:   Sun, 14 Aug 2022 04:52:12 +0300
Message-Id: <20220814015211.84180-1-mazinalhaddad05@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A null pointer dereference can happen when attempting to access the
"gsm->receive()" function in gsmld_receive_buf(). Currently, the code
assumes that gsm->recieve is only called after MUX activation.
Since the gsmld_receive_buf() function can be accessed without the need to
initialize the MUX, the gsm->receive() function will not be set and a
NULL pointer dereference will occur.

Fix this by avoiding the call to "gsm->receive()" in case the function is
not initialized by adding a sanity check.

Call Trace:
 <TASK>
 gsmld_receive_buf+0x1c2/0x2f0 drivers/tty/n_gsm.c:2861
 tiocsti drivers/tty/tty_io.c:2293 [inline]
 tty_ioctl+0xa75/0x15d0 drivers/tty/tty_io.c:2692
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: 01aecd917114 ("tty: n_gsm: fix tty registration before control channel open")
Link: https://syzkaller.appspot.com/bug?id=bdf035c61447f8c6e0e6920315d577cb5cc35ac5
Reported-and-tested-by: syzbot+e3563f0c94e188366dbb@syzkaller.appspotmail.com
Signed-off-by: Mazin Al Haddad <mazinalhaddad05@gmail.com>
---
v1->v2:
- Change commit title and description, removing unneeded and 
unclear references to syzbot bug.
- Use a sanity check instead of reinitializing gsm->receive in
	gsmld_attach_gsm() 

 drivers/tty/n_gsm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index caa5c14ed57f..38688cb16c20 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2858,7 +2858,8 @@ static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			flags = *fp++;
 		switch (flags) {
 		case TTY_NORMAL:
-			gsm->receive(gsm, *cp);
+			if (gsm->receive)
+				gsm->receive(gsm, *cp);
 			break;
 		case TTY_OVERRUN:
 		case TTY_BREAK:
-- 
2.37.2

