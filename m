Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067904D851D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 13:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbiCNMfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 08:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245425AbiCNMc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:32:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355D22BDB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 05:29:47 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id s42so14240651pfg.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 05:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=+61bL8B55NzgOqf7v3x/0YUtZZbl/U3fuc66QbGFfZE=;
        b=kvbcNPZ8AU8hjjuMqdRRJzfMRv9vW8WHAUkY0BVtWGuE3kTb2M4e2gubEeWWT3UWNM
         ub1mHQaSYRCvHmV3w6vPMALxasxRXBwnlkMu0mtMA/6ATHNOhXl3fUf/zEHhELFD4gS3
         NPxGMJs4sTMyyzyc7F7hI8WXN65iCmKowwK80REtHveYu/PMyu0qbIyC6pk5GXx4OC05
         Pdo04W7EK1ip99+LHKQTb0BVPCB8WRnNgC85WGyhoFcT8wREdfnjmSBNMiGLdB2fCNtw
         swRVXL/zeFAoU1HWhyIkVructY4qmGlbFQPr2lA4uR/hy9u9dYY+Ryl8iuqsuuRtAZFb
         KJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+61bL8B55NzgOqf7v3x/0YUtZZbl/U3fuc66QbGFfZE=;
        b=Y+2qKnMHCAttpBj1iI34AkWQF3f6z6y2auzfpD6ujeN8xVq5LFw8Mm8iu/MSQOWx6j
         BMVnLKCSpXyNzM9HL/d09RGWGkiUiKsxADo7//nxZGeTx3f97U/1yXX/4B104K4dt3av
         FEOqPrsifylW/BjwqjmDYu0x24H5NRgR2CI/8KhzkKhG0XqPVXdF8aZ6KEQUhkGCW3N5
         j26WX0SDPk2axFmh+vczm76NGL2XTLkOBW7WNW/08swRECT4Hcxfmjg2cTqFMe7krpiN
         gfAoNhzDWyt2N1wB2Azm22AHtKNnD8/Ib5upO4FWGiIMigJUyKdMlAtzI9z//fUhxBqO
         smmw==
X-Gm-Message-State: AOAM53036IIayflzuyZizNkUTngfVUrIo5sPgxWrJZDgnS1NOjplRRlL
        k9Si/Djpn4LWz8PTiyhCFcb2eeIubEWQDw==
X-Google-Smtp-Source: ABdhPJzvp/C8q1A8LG8IwnlOs9l/uNHFJyL0CoGXtylHk+itAljLyE1slZmcSiRQaO8klIv83082Ng==
X-Received: by 2002:a65:41cc:0:b0:380:6f53:a550 with SMTP id b12-20020a6541cc000000b003806f53a550mr19757301pgq.471.1647260986752;
        Mon, 14 Mar 2022 05:29:46 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.19])
        by smtp.googlemail.com with ESMTPSA id 8-20020a056a00070800b004e14ae3e8d7sm20552263pfl.164.2022.03.14.05.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 05:29:46 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [RESEND PATCH v2] vt_ioctl: fix potential spectre v1 in VT_DISALLOCATE
Date:   Mon, 14 Mar 2022 20:29:21 +0800
Message-Id: <20220314122921.31223-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In VT_ACTIVATE an almost identical code path has been patched
with array_index_nospec. In the VT_DISALLOCATE path, the arg is
the user input from a system call argument and lately used as a index
for vc_cons[index].d access, which can be reached through path like
vt_disallocate->vc_busy or vt_disallocate->vc_deallocate.
For consistency both code paths should have the same mitigations
applied. Also, the code style is adjusted as suggested by Jiri.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>

---

v1 -> v2:
- Add Reviewed-by
https://lore.kernel.org/lkml/20220222081101.21233-1-xiam0nd.tong@gmail.com/

RFC -> v1:
- Adjust code style [Jiri Slaby]
https://lore.kernel.org/lkml/20220222073954.20212-1-xiam0nd.tong@gmail.com/

RFC:
https://lore.kernel.org/lkml/20220222035648.17984-1-xiam0nd.tong@gmail.com/

---
 drivers/tty/vt/vt_ioctl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 580136986..8c685b501 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -898,11 +898,13 @@ int vt_ioctl(struct tty_struct *tty,
 		if (arg > MAX_NR_CONSOLES)
 			return -ENXIO;
 
-		if (arg == 0)
+		if (arg == 0) {
 			vt_disallocate_all();
-		else
-			return vt_disallocate(--arg);
-		break;
+			break;
+		}
+
+		arg = array_index_nospec(arg - 1, MAX_NR_CONSOLES);
+		return vt_disallocate(arg);
 
 	case VT_RESIZE:
 	{
-- 
2.17.1

