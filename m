Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAE04A7BBD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348096AbiBBXd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:33:57 -0500
Received: from mx2.ucr.edu ([138.23.62.3]:65387 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344512AbiBBXd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1643844836; x=1675380836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uavpFDxmGoKjrnyH0fVmnFMq2r7aGr052ubiJDv8DR8=;
  b=ZsxCq6VOaQejAGfXqnHIWmlwIuEB4pxItn+JB1W4ncCaPhZ2r2IBXdh4
   2kZteC8ShzrpOIU9vHkDHQ7n2Bdn2sldRgIKGJQmkfp7sV3d3Et63NvKO
   8pszNq3npGUncSCLRbHO63Rcedsyob3CCFOpEYOHZtp0wVFJtbvKZ3/mx
   INZ9pL0UhkI62EGNbEmqa77Gg2ZpX3mNDJGO5yAfsJWFHtPVuE6BgkbI5
   bZUj951b8czRPlvVmXulBRxA66yzhYIcPdpO/ZaT0ethyWvPV+mXAxqWi
   PeoS+8BnJ9menTwL4hSSOuKjjfgvUo6H9UMKIO+ioZCVdiEa17R8+a0/O
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="217252391"
Received: from mail-pl1-f198.google.com ([209.85.214.198])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Feb 2022 15:33:56 -0800
Received: by mail-pl1-f198.google.com with SMTP id k7-20020a170902ba8700b0014c7e2870d4so156434pls.21
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 15:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LoPhiSf2j9AFlf81eKG6xH4TR1F1QmboBbxydv3xQ7Y=;
        b=xDmZHe7b0lAJqRV03cgiwQiq8aVyFS9aT+B3OaOw+dR+d9mfsO5WhWIS1hey9PxQ/8
         pnHAutlDAUGni9R+QOz9ct54DuHYBVVF5lAGy+MaQvBMrHnR7tpJyTD+Ji0/d05HnW3U
         zPGVsGrgSzCJ8Zj7ELBZ7A+GpZsIoy7zxD5Ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LoPhiSf2j9AFlf81eKG6xH4TR1F1QmboBbxydv3xQ7Y=;
        b=jdP8oQItgXvc1RcoGYY0QSx9OBdkEI/bnTzPwux52gGlogdY1Z+DFRupCVJzLevtjw
         R2Z2OO3/hG74SwlRq7I6nTV4yuNvTq9sheGUYtq0W+SAuq1GTFlK59ns1hDFsXv4TYEg
         rTrQ2q/7dJqS2+e0yiNvc73li0rTll6Pj7ZPPRjDg5TMw9deXtmRlbW/cjwU6DaL3Ipg
         3D6kDc6s6rXZUgkclIZ2TVf3ioXhGaKpbhm1IW9Qd5hoLMl2MI46k4QeF+MPjmDO/JuS
         OOIlT5xdjGZqS+OurHkER7wkFSlM7RbtNdE2zLs+1tel6Uko8OTYLhUzCT4AYYseJKSN
         PMvA==
X-Gm-Message-State: AOAM533UYTnUMgyljpC0Jkt6hYdblRKktxmmWN9z9QFfcWQ4b3Q5+Ik1
        aK2E3+ok0pyIH00sJ6bFkYCPEAKVn5nYrYfTEvEwpvNzfbDA7FXB+FJC3MKMkV6oZ63A11y2sa3
        NMI1GqmYtDHr/oBiSkCn4/oNXAw==
X-Received: by 2002:a17:90b:3841:: with SMTP id nl1mr10901898pjb.50.1643844835691;
        Wed, 02 Feb 2022 15:33:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKw43I55RvXKUF5Oc0gQfOIu6GaU+jb9Uz6QfMkQXdHo2WKNl3sIP6kqSgU/6tvpMjh2bLug==
X-Received: by 2002:a17:90b:3841:: with SMTP id nl1mr10901883pjb.50.1643844835458;
        Wed, 02 Feb 2022 15:33:55 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id s2sm26380387pgq.38.2022.02.02.15.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 15:33:55 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] fbdev: fbmem: Fix the implicit type casting
Date:   Wed,  2 Feb 2022 15:33:58 -0800
Message-Id: <20220202233402.1477864-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <83e46d8d-ec7a-6cbd-010e-7f50f88dcf96@I-love.SAKURA.ne.jp>
References: <83e46d8d-ec7a-6cbd-010e-7f50f88dcf96@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function do_fb_ioctl(), the "arg" is the type of unsigned long,
and in "case FBIOBLANK:" this argument is casted into an int before
passig to fb_blank(). In fb_blank(), the comparision
if (blank > FB_BLANK_POWERDOWN) would be bypass if the original
"arg" is a large number, which is possible because it comes from
the user input. Fix this by adding the check before the function
call.

Signed-off-by: Yizhuo Zhai <yzhai003@ucr.edu>
---
 drivers/video/fbdev/core/fbmem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 0fa7ede94fa6..d5dec24c4d16 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1162,6 +1162,11 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	case FBIOBLANK:
 		console_lock();
 		lock_fb_info(info);
+		if (arg > FB_BLANK_POWERDOWN) {
+			unlock_fb_info(info);
+			console_unlock();
+			return -EINVAL;
+		}
 		ret = fb_blank(info, arg);
 		/* might again call into fb_blank */
 		fbcon_fb_blanked(info, arg);
-- 
2.25.1

