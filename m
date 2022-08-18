Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29D3598AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 20:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345325AbiHRSOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 14:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241491AbiHRSO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF076B9FBC
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 11:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660846465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W0yvrJCNySNCn52+IL1OETOtNI6hUhlyn5gBnr+tlWk=;
        b=ARbqba80eB7qM1voAbLfp5f2MUFtRbTzyBLJ/iDW7jpDgvr16TFy60VZdoi5Le1MgFRiQx
        ki6QFKmft03RXqQRP3BVa7Qni79JLCS/GHNLN64m5oXvA6JINEVFU09ZJikxFI5fg3F9nx
        TmBLBoyQOAqFjMV1c/mNF2nbHbMq3xw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-wTWxvxHwMdmY-rvIUJ7Y_g-1; Thu, 18 Aug 2022 14:14:23 -0400
X-MC-Unique: wTWxvxHwMdmY-rvIUJ7Y_g-1
Received: by mail-pj1-f72.google.com with SMTP id s5-20020a17090a2f0500b001fab8938907so1356531pjd.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 11:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=W0yvrJCNySNCn52+IL1OETOtNI6hUhlyn5gBnr+tlWk=;
        b=ecqgEEEqG4BW94JVdAyHZo16vQxoR+kYHys0ZL9wTT2CWW2dGmwLzrZqJ5CH1JRwIe
         Pb8ml2SOTouOoCcYq5Ytzr+Z3xycuqPRLycEtpv5AWzgoJBwVisLrhvHcqe9QxIh+xhv
         L5qECd89N4G77q+ci2tIDqM+nX/4tF9sSUyNOefTZyauUPGOJJm3RgCGlhiRG51gmy5R
         mNXuhC+NlCWsRNNsotdfFrmlwalmd+MQgd+sDeyEG3+elmg1mSZ1BFMg67oBsl4bzADb
         1ztAun6Pqx5UpfZVnDZJcNvMFN+sCR4+r9QmAyoFSRL8qo7H5CsfQIEeqZPHfpE58sDs
         LsTQ==
X-Gm-Message-State: ACgBeo2toOhh7ht0i1D5qjPfXSGqYLD1GXv1oAug/QU7gRJPEfNu2Ewl
        jMDidZScYIdhC1jpS/Pl+Et3B7+87S0bFFrRdwW4+zxE9IUlOh76A3puSETru26fxx2H3e0SOjW
        Sn0t4chkMUWF3+fC4rSCYPEUR
X-Received: by 2002:a17:90b:1c82:b0:1ee:eb41:b141 with SMTP id oo2-20020a17090b1c8200b001eeeb41b141mr4285207pjb.143.1660846462853;
        Thu, 18 Aug 2022 11:14:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6QokUB9XAiZHout1FdGj0TFG42x0+7uXqK5dl1kBebaN2yKIVrrTUm09/AgqN1PfwicrccCw==
X-Received: by 2002:a17:90b:1c82:b0:1ee:eb41:b141 with SMTP id oo2-20020a17090b1c8200b001eeeb41b141mr4285195pjb.143.1660846462606;
        Thu, 18 Aug 2022 11:14:22 -0700 (PDT)
Received: from xps13.. ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id c16-20020a056a00009000b0052dce4edceesm1960592pfj.169.2022.08.18.11.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 11:14:22 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>,
        syzbot+a168dbeaaa7778273c1b@syzkaller.appspotmail.com
Subject: [PATCH] fbcon: Properly revert changes when vc_resize() failed
Date:   Fri, 19 Aug 2022 03:13:36 +0900
Message-Id: <20220818181336.3504010-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fbcon_do_set_font() calls vc_resize() when font size is changed.
However, if if vc_resize() failed, current implementation doesn't
revert changes for font size, and this causes inconsistent state.

syzbot reported unable to handle page fault due to this issue [1].
syzbot's repro uses fault injection which cause failure for memory
allocation, so vc_resize() failed.

This patch fixes this issue by properly revert changes for font
related date when vc_resize() failed.

Link: https://syzkaller.appspot.com/bug?id=3443d3a1fa6d964dd7310a0cb1696d165a3e07c4 [1]
Reported-by: syzbot+a168dbeaaa7778273c1b@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 drivers/video/fbdev/core/fbcon.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index cf9ac4da0a82..825b012debe7 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2401,15 +2401,21 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
-	int resize;
+	int resize, ret, old_userfont, old_width, old_height, old_charcount;
 	char *old_data = NULL;
 
 	resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
 	if (p->userfont)
 		old_data = vc->vc_font.data;
 	vc->vc_font.data = (void *)(p->fontdata = data);
+	old_userfont = p->userfont;
 	if ((p->userfont = userfont))
 		REFCOUNT(data)++;
+
+	old_width = vc->vc_font.width;
+	old_height = vc->vc_font.height;
+	old_charcount = vc->vc_font.charcount;
+
 	vc->vc_font.width = w;
 	vc->vc_font.height = h;
 	vc->vc_font.charcount = charcount;
@@ -2425,7 +2431,9 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 		rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
 		cols /= w;
 		rows /= h;
-		vc_resize(vc, cols, rows);
+		ret = vc_resize(vc, cols, rows);
+		if (ret)
+			goto err_out;
 	} else if (con_is_visible(vc)
 		   && vc->vc_mode == KD_TEXT) {
 		fbcon_clear_margins(vc, 0);
@@ -2435,6 +2443,21 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	if (old_data && (--REFCOUNT(old_data) == 0))
 		kfree(old_data - FONT_EXTRA_WORDS * sizeof(int));
 	return 0;
+
+err_out:
+	p->fontdata = old_data;
+	vc->vc_font.data = (void *)old_data;
+
+	if (userfont) {
+		p->userfont = old_userfont;
+		REFCOUNT(data)--;
+	}
+
+	vc->vc_font.width = old_width;
+	vc->vc_font.height = old_height;
+	vc->vc_font.charcount = old_charcount;
+
+	return ret;
 }
 
 /*
-- 
2.37.1

