Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164484A50FC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380815AbiAaVHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379839AbiAaVGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:06:49 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB303C061758
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:06:42 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e8so27971157wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNEcCsAHbmO8BObbR0rzHcF3KU0XqbiUyO0AgqiLr9Q=;
        b=XB0If8d+oNzt5EGFOz/pJSfVqwossHreq5Z3/8sGNGT1tWVb8HeX+PuSX4HzuKCtxL
         85Ce3vd3TA/uayqURoZ6LVnYYD+zcPj1L3cM6aaDGzt5LCXHqB2YeYKof0DAcvGHjWoE
         WAj/NXLBP9zyNJqrR3yjJ4zw+CAjDKmq/tKN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNEcCsAHbmO8BObbR0rzHcF3KU0XqbiUyO0AgqiLr9Q=;
        b=wBfIWViVjVtpl4Ozd6xD3UXxXnKDo3sZO1qfgic4Ae9IF7z23R7G8/5z8LMIJib/4r
         ToX8S2JnSxjRunzKOSxjfVtjtxmULjL0sUAAqNC2p13qRfX6rWBoe6Q2SNoB9fYdijyS
         6NtdErApq6FK6JCrdZ2CgTe1yWl1no+DnEC01Yt1s0POjdDmEilKB+4TZSx2nwgVn9fc
         P8OEsYFojxtJTdjNPz2stZuSFMIdRaIeXPDG6w4Brad/SUCy5g/yKOxfRCacyrj3Pkvh
         tMBk4YERFtfJNYvm6ziq+XFROmHAgf6JRSErvE6kX+LKHOliAJdoCf40xyXQkNL8BJgf
         x8uA==
X-Gm-Message-State: AOAM531f/cYqwtFPXf0vrLvaK4Hg8uwHUmmzMey/H9yuB/rp4/FBm3VR
        h2RJvhtX7Lttit+McuaiEflVag==
X-Google-Smtp-Source: ABdhPJyCY4pMX5KDnbLHXSX+AzjieeB1bfyqYC6ZVcKQr80N8d2mwo0uPWz2LhfKAg4dG48zDem7wQ==
X-Received: by 2002:a05:6000:1d90:: with SMTP id bk16mr9737566wrb.217.1643663201557;
        Mon, 31 Jan 2022 13:06:41 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b11sm314961wmq.46.2022.01.31.13.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:06:41 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>,
        Qing Wang <wangqing@vivo.com>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 07/21] fbdev/sysfs: Fix locking
Date:   Mon, 31 Jan 2022 22:05:38 +0100
Message-Id: <20220131210552.482606-8-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fb_set_var requires we hold the fb_info lock. Or at least this now
matches what the ioctl does ...

Note that ps3fb and sh_mobile_lcdcfb are busted in different ways here,
but I will not fix them up.

Also in practice this isn't a big deal, because really variable fbdev
state is actually protected by console_lock (because fbcon just
doesn't bother with lock_fb_info() at all), and lock_fb_info
protecting anything is really just a neat lie. But that's a much
bigger fish to fry.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Qing Wang <wangqing@vivo.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/video/fbdev/core/fbsysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 26892940c213..8c1ee9ecec3d 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -91,9 +91,11 @@ static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
 
 	var->activate |= FB_ACTIVATE_FORCE;
 	console_lock();
+	lock_fb_info(fb_info);
 	err = fb_set_var(fb_info, var);
 	if (!err)
 		fbcon_update_vcs(fb_info, var->activate & FB_ACTIVATE_ALL);
+	unlock_fb_info(fb_info);
 	console_unlock();
 	if (err)
 		return err;
-- 
2.33.0

