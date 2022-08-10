Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DDF58E56F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 05:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiHJDVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 23:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiHJDUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 23:20:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC99647CC
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 20:16:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v3so16356659wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 20:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=84NRcLKFfe/6XQq15qNZMiBSNFJ+/AXaHO09WwjXOT0=;
        b=PrqePyJw637rEQIgXaT5QRPPe8o+bbDEL8SJeUu+NzC/ASKCeew3qy5DdUr5Jrh8iN
         BDvJIsZtCJa6EyY4lqbG7Lbo/KvV0y2QqHhfDRhCpC/ZMwPQEv/2spQM6FFukn/3Hsyh
         0LRW38JmCm3jdEh5uMQREhhdhoc5BqyGEq/mz/6KI44alJ7sffbjToVgrTUYTdkXXy80
         qpcqPrtzkOEl4/4KJUQGUk8xwFfKK99En3egrrKrmbjPGlMppD0z/Z4KNDCrr7iranpi
         P3EZK+5MPIFMJe3A5iID2tNdkiB+tHElTRp/ierU2zSSrle/bckLJVm8BSr+UZL1Zdfd
         CDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=84NRcLKFfe/6XQq15qNZMiBSNFJ+/AXaHO09WwjXOT0=;
        b=RWuR4BP0ZSDtA5m/MMXDYgtqfmFu4venGUpZFarF0ncWwKyQ27KG82kky1unGggVdj
         mK2MrNp65NZiefSRs7jCHzifX3JfBB1nWign1G/hK2IBqf9sbV+Lq7sf5lo+wqHP0KvU
         wv5x6aKOI/erecj9Bx4PUzRmgB3JF/CzXM3MAr53ylQDaEUpmoabBa9t/5lqQop6GZV4
         E6hRfNGpLhSE42OP1roccdYHNQ+rBTkoExVQe1RAUY52D8GnQCiIumPwRytuZGPi1pX6
         SOFqykasYWYI4z4Gy512Eo/q9f2Yb7N4NqpsXMQlRE/tvcraaxdXe/qyWv3s3JDWY2u/
         B6iw==
X-Gm-Message-State: ACgBeo2PVaE4j4cJgBB2QjfJaxhT8O9SjbcSXYaU2/wCcDE+mJeqtHY4
        Dqpl6a+KvKWUpwfknQkFix8=
X-Google-Smtp-Source: AA6agR6vbi9PzSN4LXg7Z8Hv8wrETrEAOO6ZTjf85QXAaPac7lJ9PgZj6Gek3NzO0bdQJbVRiaSzVg==
X-Received: by 2002:a5d:64e2:0:b0:220:7dfb:ab6f with SMTP id g2-20020a5d64e2000000b002207dfbab6fmr15514382wri.664.1660101396774;
        Tue, 09 Aug 2022 20:16:36 -0700 (PDT)
Received: from localhost.localdomain ([84.255.184.228])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d698b000000b0021eff2ecb31sm15575961wru.95.2022.08.09.20.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 20:16:36 -0700 (PDT)
From:   Mazin Al Haddad <mazinalhaddad05@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, daniel.starke@siemens.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, paskripkin@gmail.com,
        Mazin Al Haddad <mazinalhaddad05@gmail.com>,
        syzbot+e3563f0c94e188366dbb@syzkaller.appspotmail.com
Subject: [PATCH] tty: n_gsm: fix missing assignment of gsm->receive() in gsmld_attach_gsm()
Date:   Wed, 10 Aug 2022 06:12:52 +0300
Message-Id: <20220810031251.91291-1-mazinalhaddad05@gmail.com>
X-Mailer: git-send-email 2.37.1
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

Fixes a bug reported by syzbot. A null pointer dereference can
happen when attempting to access the "gsm->receive()" function in
gsmld_receive_buf(). Currently, the "gsm->receive()" function is only set
after a call to the GSMIO_SETCONF ioctl. Since the gsmld_receive_buf()
function can be accessed without the need to call the line discipline
ioctl (GSMIO_SETCONF), the gsm->receive() function will not be set and a
NULL pointer dereference will occur.

Fix this by setting the gsm->receive() function when the line discipline
is being attached to the terminal device, inside gsmld_attach_gsm(). This
will guarantee that the function is assigned and a call to TIOCSTI,
which calls gsmld_receive_buf(), will not reference a null pointer.

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
Reported-and-tested-by: syzbot+e3563f0c94e188366dbb@syzkaller.appspotmail.com
Signed-off-by: Mazin Al Haddad <mazinalhaddad05@gmail.com>
---
 drivers/tty/n_gsm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index caa5c14ed57f..1d74dd9d70d0 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2825,6 +2825,11 @@ static void gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 	/* Turn off tty XON/XOFF handling to handle it explicitly. */
 	gsm->old_c_iflag = tty->termios.c_iflag;
 	tty->termios.c_iflag &= (IXON | IXOFF);
+
+	if (gsm->encoding == 0)
+		gsm->receive = gsm0_receive;
+	else
+		gsm->receive = gsm1_receive;
 }
 
 /**
-- 
2.37.1

