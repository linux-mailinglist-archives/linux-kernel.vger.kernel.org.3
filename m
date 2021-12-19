Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17AE479FB6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 07:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbhLSGC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 01:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbhLSGC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 01:02:58 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E4CC061574;
        Sat, 18 Dec 2021 22:02:58 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id mj19so6156919pjb.3;
        Sat, 18 Dec 2021 22:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VeIzwn0VgMnKX9gnyC1Mkc2qq1xhJpDfBgRDfzPafls=;
        b=H8pCBGHwfLGLpk4IiIU6WL/uI0DPtzloTDVHtooMpOtSFlCpkrvBbWuclvi/2COBBW
         eZS5yEppP+OVw5/bi5H074ZWkaZGAvTsmvbdp4Zv0f5ixzXJKWyq9vAgnZa/UJd9xeP+
         YXapvPwj8F9OokPlC+z/G8+YzZJGdoBPvl+J0hrAlGxVXoJJeDWSx6spbeY9qjNqWi/L
         Fm7tYL0iW22iQF8IhpqJNmfRXpSfMXJXE8t48cwsyadoyG0qi900dFVcApHA3uNfeei+
         kTdJo0Q+LbpaGIy+PBwkRbT7EnFMqERQkcwJvxeuO9pdDKSpl3d3rn3Ihf+vzk+apuce
         EV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VeIzwn0VgMnKX9gnyC1Mkc2qq1xhJpDfBgRDfzPafls=;
        b=LlU5HVEAtqRbnzwr03BK9xMG2+Qs6krbla7dJdllMQEIGt9WRH2KG37vKZl+7+jw/Q
         1RxLPhM2Cv1IpdZHDePQisgmDfzDPf0PbYvJK2ZM2KBDEQhCKUswXX13Qfj+XY4f3yam
         NrIC2bwsbtzpz82bEBai9RimTv+p/4l2Ry2UW/Q2gbbdQdlYoS7RZUwtSD33TWgAKofb
         ImCbOR+FgSuZmwPZZvKPubXg3n8d5lY+dzelHRzi3psbGlOBF6medNBLNqbndVw03L5c
         xGUOomMRS8s2BJ70boXZlZinxxrbFFTDJwFkP+3ti4zkDXD/5iXTKIRG4BpYbpgRx1W3
         rRKg==
X-Gm-Message-State: AOAM533mSNwttStuBLrFDPke/Z4r/KBfCep6eNu2zCpHyDPtsBKYaeHC
        6c9B7vSlpkMmJFpmq9gBIs0=
X-Google-Smtp-Source: ABdhPJxYscQCAY8rT7QEXufEq3Xe2azwvrucB6j8RIaF5gUj6x7SmDsY8eHr+VcEo/pfMzI+MrHfmA==
X-Received: by 2002:a17:902:f68b:b0:148:a923:6d3 with SMTP id l11-20020a170902f68b00b00148a92306d3mr10679018plg.97.1639893777672;
        Sat, 18 Dec 2021 22:02:57 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.36])
        by smtp.gmail.com with ESMTPSA id s3sm3724954pfm.0.2021.12.18.22.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 22:02:57 -0800 (PST)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Greg Kroah-Hartman <gregkh@suse.de>
Cc:     syzbot+9780d2b05ac158d32284@syzkaller.appspotmail.com,
        Dmitry Torokhov <dtor@insightbb.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] driver: powermate: kill urb in the disconnect function
Date:   Sun, 19 Dec 2021 14:02:15 +0800
Message-Id: <20211219060241.4125076-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In powermate_disconnect, powermate_pulse_led will invoke
powermate_sync_state and submit one urb with pm as its context.
If powermate disconnect before the execution of complete handler,
the pm will become a dangling pointer and lead to UAF.

Fix this by calling usb_kill_urb(pm->config) in the disconnect function.
Note that, the error handling error does not need to take care of this.

Reported-by: syzbot+9780d2b05ac158d32284@syzkaller.appspotmail.com
Fixes: ba0acb5ee318901 ("Input: move USB miscellaneous devices under drivers/input/misc")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/input/misc/powermate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
index c4e0e1886061..903993469fde 100644
--- a/drivers/input/misc/powermate.c
+++ b/drivers/input/misc/powermate.c
@@ -424,6 +424,7 @@ static void powermate_disconnect(struct usb_interface *intf)
 	if (pm) {
 		pm->requires_update = 0;
 		usb_kill_urb(pm->irq);
+		usb_kill_urb(pm->config);
 		input_unregister_device(pm->input);
 		usb_free_urb(pm->irq);
 		usb_free_urb(pm->config);
-- 
2.25.1

