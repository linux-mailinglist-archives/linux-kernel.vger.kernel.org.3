Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB7C4A7B9E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348065AbiBBXRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:17:31 -0500
Received: from mx-lax3-2.ucr.edu ([169.235.156.37]:57261 "EHLO
        mx-lax3-2.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348060AbiBBXR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1643843846; x=1675379846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XA4HzDe0AEvwI/VRCaorqRe1KBJyowOMBeCxGfa6hn4=;
  b=UJWUhAZrWyXAP+iT7Hu1cZeUORsgK3W4Aa6F3Dp+HPb4XbJWYsDMFSA6
   afS+nLWDE3dGenebC7rBjhWqpop/aQSHAPmMUsBNvQmdxDMQYDaz+nw26
   6YF+ay62FaFXr8ALF72+RUvniH4lUxvRyPS52A0eI+BHiHGpuwTBfYpux
   8cfFORojDAT8sMOSv2VBDCEIVIRAF8heUNR53ASnxiPCfCiFUzl9xwrIM
   EkId7y/pzYVctHaKQ1I3JviIL2T3YIVfXGuDxIGDzOonhzR5n22jpBgs/
   2zv3deDxVFS6KmiZqA8JR8kKIQ1pSQbIhEJttbEX3kU3KFyGkiPc1AVVh
   A==;
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="102063261"
Received: from mail-pj1-f72.google.com ([209.85.216.72])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Feb 2022 15:17:18 -0800
Received: by mail-pj1-f72.google.com with SMTP id f60-20020a17090a704200b001b51d88e887so3415094pjk.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 15:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x0gpjDLXaul+KimMP/te05qJYZBYJvmQ+lbw67iuhZI=;
        b=iG0hqIojQ+Btn3YyfJz0zIh+ids2UdHlcdajOgKekWODbOVBE25xUjQthNVNVCYJZL
         ziLiUrKHuhoXAKfwZ6C7H0nGSqSQhiN5jcNjOymYda/yMkGSCQpR8Jg0jBCRvZRWu7Ly
         FY1UCAwviBYMivvY4GLNBbBng5j7VlxTHZzhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x0gpjDLXaul+KimMP/te05qJYZBYJvmQ+lbw67iuhZI=;
        b=0GbmxhSm7hsEwuVrY10E99sfYEY+fPuWxL7rPMNU1/gq6rjXf/HIaUwu0/hHQhi0Oo
         SYOuBlHpxiWM/Z8yRyJ1/6Bw7UyAmRXrshAjkXa9dDDHeVF2VlXmE80adqQlZbG1csXS
         MpBKyy2Brm7SgcUbVUCa2HZHQty7PwKnxH5exI4PqXO3q5cmslON+G9I+0C3enQVYJ/o
         exhGPpITnnpaP0vlmYF2z4RQVYRhzFjTAZtBHPUGPVuJFOStC2Dhu4Yl0T4abBFFqgpa
         ibYeES/x9mwEPhEO7V4SAwuRPthMP3mgfmYp9+wHmC3lr5KCDRd21d32bF89xmYr0IGI
         YnmA==
X-Gm-Message-State: AOAM5315w1w4FRWIN1Eri+A1Or9IbG1Im/mDnTieT9rtDVp0to72L082
        0ooU7wLTV/dzNQNenGihmGigtlDvJZ8KVPWsggygbi3vYxGXzXg/uUW6ryIsReyhx09UNPuXrVD
        5qS5pZajtDK0sVtOHMPanVmEKYQ==
X-Received: by 2002:a05:6a00:114e:: with SMTP id b14mr32122975pfm.31.1643843838877;
        Wed, 02 Feb 2022 15:17:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOOE+HHe74jnu6gkVO3QanT2cNSA16ZEnCIFi4F5dLBKqCPSoK9K2Dq+OswSZYFwgxrT9+zw==
X-Received: by 2002:a05:6a00:114e:: with SMTP id b14mr32122959pfm.31.1643843838640;
        Wed, 02 Feb 2022 15:17:18 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id j14sm27383525pfj.218.2022.02.02.15.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 15:17:18 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] fbdev: fbmem: Fix the implicit type casting
Date:   Wed,  2 Feb 2022 15:16:33 -0800
Message-Id: <20220202231636.1433050-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <882bfe4e-a5b6-2b2c-167b-eda8c08419e3@gmx.de>
References: <882bfe4e-a5b6-2b2c-167b-eda8c08419e3@gmx.de>
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
 drivers/video/fbdev/core/fbmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 0fa7ede94fa6..b3352e23caaa 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1162,6 +1162,8 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	case FBIOBLANK:
 		console_lock();
 		lock_fb_info(info);
+		if (arg > FB_BLANK_POWERDOWN)
+			return -EINVAL;
 		ret = fb_blank(info, arg);
 		/* might again call into fb_blank */
 		fbcon_fb_blanked(info, arg);
-- 
2.25.1

