Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C254A5114
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381199AbiAaVIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380109AbiAaVG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:06:57 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204C2C061744
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:06:50 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n8so11190448wmk.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zvAncPlENd1mkArHeBkA576DDmIGdQX94f0ukCjnIXQ=;
        b=U2t8kjkQ/Vt2HJQRdamapjasWFD4c3zJbcxURpYTYrPL2cbDmMJxvxEJJMlW99DO/4
         HUhOQG+NtbaKJIqcJQ1bk77wmHdiXo6RDrFZUBjDjoYa1m3+m13Io4vvAUPU/RdXN4pI
         fBNkESnc3jQO0p8GldNWuLNg+S4Y098h1Fh7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zvAncPlENd1mkArHeBkA576DDmIGdQX94f0ukCjnIXQ=;
        b=uqy3QlX1HINhNi4R6yBoRBIfbgPUWh4//iMbtKo1/NjiYW/27j6JVYbHyzq55m+8V6
         mw0XZ8EyX7JEyehmctU6u+UXPXdFOMCZVjxAG2irFIBcfvTz2SuGZFfgii97NmGRIBgk
         4JPnIMBEhjbAy1NnGebrZIZn8bX+LnkinsXGmoENI27A3JuVBb7oGcWHtMdNWmRhaibh
         cqzvLPGo45beC3hfxvq3o0ht9Z37fu9339e6LvawnCP7bRs3Wj9VcAciDHl4ZRUobRBV
         LwPlVENfXSSw4E1akvRx25QOctk2w15zA0L8R5021Lj447ipd6DZOKGjV799dtIPZG3t
         rfaQ==
X-Gm-Message-State: AOAM530CDtwYXpR2VTP216znTZ98TVB6Rs6IxjYuDGhx2nxgdUml8fZy
        5muKl/0gLY+wHpMjd/qnbMvcpw==
X-Google-Smtp-Source: ABdhPJw4OlP2ZiGsyZ53C2rKU+S/VlUSh/yp+iwZxn0Bz//sDKkThBEktGnYMjV7P/SFzkmcbMEHWA==
X-Received: by 2002:a05:600c:19d0:: with SMTP id u16mr28683628wmq.35.1643663208709;
        Mon, 31 Jan 2022 13:06:48 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b11sm314961wmq.46.2022.01.31.13.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:06:48 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Claudio Suarez <cssk@net-c.es>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 15/21] fbcon: Consistently protect deferred_takeover with console_lock()
Date:   Mon, 31 Jan 2022 22:05:46 +0100
Message-Id: <20220131210552.482606-16-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This shouldn't be a problem in practice since until we've actually
taken over the console there's nothing we've registered with the
console/vt subsystem, so the exit/unbind path that check this can't
do the wrong thing. But it's confusing, so fix it by moving it a tad
later.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Du Cheng <ducheng2@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Claudio Suarez <cssk@net-c.es>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbcon.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 496bc5f2133e..11b9f962af6f 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3247,6 +3247,9 @@ static void fbcon_register_existing_fbs(struct work_struct *work)
 
 	console_lock();
 
+	deferred_takeover = false;
+	logo_shown = FBCON_LOGO_DONTSHOW;
+
 	for_each_registered_fb(i)
 		fbcon_fb_registered(registered_fb[i]);
 
@@ -3264,8 +3267,6 @@ static int fbcon_output_notifier(struct notifier_block *nb,
 	pr_info("fbcon: Taking over console\n");
 
 	dummycon_unregister_output_notifier(&fbcon_output_nb);
-	deferred_takeover = false;
-	logo_shown = FBCON_LOGO_DONTSHOW;
 
 	/* We may get called in atomic context */
 	schedule_work(&fbcon_deferred_takeover_work);
-- 
2.33.0

