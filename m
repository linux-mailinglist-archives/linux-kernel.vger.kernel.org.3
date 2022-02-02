Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60DC4A7BBF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348104AbiBBXeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:34:02 -0500
Received: from mx.ucr.edu ([169.235.156.38]:56744 "EHLO mx-lax3-3.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348098AbiBBXeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1643844840; x=1675380840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uavpFDxmGoKjrnyH0fVmnFMq2r7aGr052ubiJDv8DR8=;
  b=dCWRywTQq0xKthzSJakoV4dzKPy9VPUC+xAWTzqyfDN7THLTayjBWw6A
   xdXXHAiGxKh3heuoGZZUrUlMsU8AcaGP5inAY8exTio1gm48nWrvrsbAa
   +pOeAgSnUYfHT/kc01kBfNISvKw8KWKKMC/hPnjCxQigl8uZXIcm8+SdW
   AndyqnxnKHdej8e/iIQxA6d561yAwV9q3QudwF+i96I7k1VWG2WtWTYbT
   1k+ULxwKmUObOkkNQSknNZnr3au9DnGZHnKzr649Oh/W8NlVNJvZDlWbg
   fWrRmuEPGG2gIKzAxslIM0uPYpWPXOxxJbpp9Su14fZQg+bHn63KDHN6p
   g==;
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="105394236"
Received: from mail-pj1-f69.google.com ([209.85.216.69])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Feb 2022 15:34:00 -0800
Received: by mail-pj1-f69.google.com with SMTP id a10-20020a17090abe0a00b001b4df1f5a6eso640482pjs.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 15:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LoPhiSf2j9AFlf81eKG6xH4TR1F1QmboBbxydv3xQ7Y=;
        b=Vi+u9jBD+QVIbMUO77wQyOqhnpPIQvWmztX0ACI8XT+Izg3ej/xW05bi3EpXKQmC5b
         n2YPYxIV9U/xOb7ZmjQpv3qNoS/YYE8CzEdnpG+tSda1iqZ+zUfQ64mA8a+I0O/SBnbh
         Q5tT4F4wSPQgCi1arxRFL3Dhz5HXvtylb9o7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LoPhiSf2j9AFlf81eKG6xH4TR1F1QmboBbxydv3xQ7Y=;
        b=c2sJVzDA5JelfZpsOKiEpNNe+KdOBKZCc7Q6JD7SKYbSnL9IBIWfk6VJxKUyIMWjSm
         0hupvG3gt1kjIr1x8mU6Peifmb1JjUbLpDDJzeViyacWibMp0GFxiIa6Nuk+jlkm+kmG
         xCypS2zin8U1HeqJzaYcLqjSQ2mN3BH/7cIUjkPtIMJZ6qnreCn08PFAxVzdgu4cXz3Z
         q4qyGeFTUp/TPa9Fa70jlqZMPoMoWUfqqcM0P1S/KYwNiP58lN1HohWrhe2Vw+4E74UL
         HmnclgrG0aLriP5ijkJFBNzuv66EvsGwd8TGoGad6rfEpKwlkDuGr2Fuu7/OIU+sJ6W4
         KbYA==
X-Gm-Message-State: AOAM532UPBetXAGpX3j1zckez2EdQxROjK7fAJ0s+0Bk/g/JYZhTsOZm
        Lw/bbVV9llzMTUAC/2FCaXW9HffL6LgAnIxc2FRJkaPTN4lWXiPhwz5ywpbwrTh5V1ic3EVuzek
        XhJZYY2aDEdKnEFIysfti03//oQ==
X-Received: by 2002:a17:903:2283:: with SMTP id b3mr31859673plh.0.1643844839719;
        Wed, 02 Feb 2022 15:33:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwz4/x8nWtBV0nXYgv98co1MlqgYrtI6GhpsU/PIcCVgrAG4WdSIF+YKtELNEJg4IP2qcHSQQ==
X-Received: by 2002:a17:903:2283:: with SMTP id b3mr31859649plh.0.1643844839488;
        Wed, 02 Feb 2022 15:33:59 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id s2sm26380387pgq.38.2022.02.02.15.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 15:33:59 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        William Kucharski <william.kucharski@oracle.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] fbdev: fbmem: Fix the implicit type casting
Date:   Wed,  2 Feb 2022 15:33:59 -0800
Message-Id: <20220202233402.1477864-2-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220202233402.1477864-1-yzhai003@ucr.edu>
References: <83e46d8d-ec7a-6cbd-010e-7f50f88dcf96@I-love.SAKURA.ne.jp>
 <20220202233402.1477864-1-yzhai003@ucr.edu>
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

