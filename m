Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEF64A7C0E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348216AbiBBX6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:58:14 -0500
Received: from mx-lax3-3.ucr.edu ([169.235.156.38]:60875 "EHLO
        mx-lax3-3.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348201AbiBBX6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1643846292; x=1675382292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xYvx8fe8wRHtOQTQUEuPl7xZb+NEUT35cy+DHSkqPn4=;
  b=h1wT+Q22xVIBdeTDaV9zETxtCvj7mlzMMxMgNQ32DnMpq5rtlzmuaneg
   DVbvF0qGSJG3Rggws5GZ71Eg7HmU3gvdbpzyBgxonP8poWRPgkUqwnP7q
   h88L/O+SUUoaM2auawhkd73pRo2mKB+iWfKCIsGOyUNX74VfdJ5VNLWhy
   6UmwbNdPAYXmVMb3E/m2Ftm81GsXOqjg873I8JdDMyPNsXbQop+5FBeJJ
   Zy06TkdY5YsWBrQ4HBr57MAy5kEADbMhUZEou7CaQAVdIUn7rT6FHNwmf
   CcGbjjCDoclrdsHRnn/aUpZ6ycbs8+eezL2WWmVvU/D+UHIbOEQAEvMLX
   A==;
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="105399220"
Received: from mail-pf1-f200.google.com ([209.85.210.200])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Feb 2022 15:58:11 -0800
Received: by mail-pf1-f200.google.com with SMTP id f24-20020aa782d8000000b004bc00caa4c0so415532pfn.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 15:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUOM8bvwC+la2NKqFvk2uI9Asw+K/wrTaRpdb2Kdz7U=;
        b=TOKLi1xV2VoAfEWpE5V83okRjedJuomWMncW4lik6VyhjCpHVot4ZXMBqgkJnTxt/b
         oXGo5UlO9ifjfReoAtoPe2/Nvn8No/cP8rGA+LA1D7RxUjku7PBWdN1Jjc6qECBlrFcO
         rjctdWIycnceaqeE20k2mgo8clQ4zuEqIjG90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUOM8bvwC+la2NKqFvk2uI9Asw+K/wrTaRpdb2Kdz7U=;
        b=BRdIXl56wSdIOTtE25ipKSLN6dsY5y6dhHo65I4m84RebVwgHAnYLcGKJt1+ocKGeX
         NydXLhewMmO2XDECYyOUp7PTZVCOfLmpOxjG4HRXObvI0gkgEhtcjltWzsQ2qf1GAow0
         kwrmJ2VPfIGZqTfH/UAZk48u34ExuP8ZAQFrI6zuRrsNExP9zSDUwjW/RrIZi15j+ika
         gy0GoqXnLaLwjGGe0XLjD1ZKl/Decqd/GyCUP5CgsZDGCPEMsepbrQaXQUlOC0qBGz/m
         Q0XnlPeKMoq2jFH5Ab8q5LO741lCntgAr+L6UQRI6ZynM62J1/P4wPiK8iEKKAs/10DL
         fqhw==
X-Gm-Message-State: AOAM530cx8KWbz51ViNF0uiAQeFbSAFisTSeC33hKN/z3DTJtNrZ0Uc0
        pgJMSt/FkzLQBqdIj9dRynkP+9DuHIBvgg6bnvq4PCQXTu7HamIdZWKyAkQcVn7AKYT85f3lBEq
        TYLucRsROLHrg4qd70Yk8j9gG8w==
X-Received: by 2002:a05:6a00:1256:: with SMTP id u22mr32510707pfi.82.1643846290846;
        Wed, 02 Feb 2022 15:58:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/rk+2PWsZGJZmsMuI52ixNCJbvxxZXhGBloxQkqqxkDky7OrWs3+DwSaQCwm+soYe+VmaFw==
X-Received: by 2002:a05:6a00:1256:: with SMTP id u22mr32510685pfi.82.1643846290619;
        Wed, 02 Feb 2022 15:58:10 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id b22sm27854781pfl.121.2022.02.02.15.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 15:58:10 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Guenter Roeck <linux@roeck-us.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alex Deucher <alexander.deucher@amd.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6] fbdev: fbmem: Fix the implicit type casting
Date:   Wed,  2 Feb 2022 15:58:09 -0800
Message-Id: <20220202235811.1621017-2-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220202235811.1621017-1-yzhai003@ucr.edu>
References: <f3b28143-5f59-ad77-f2b8-6274a6edbfdc@roeck-us.net>
 <20220202235811.1621017-1-yzhai003@ucr.edu>
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
index 0fa7ede94fa6..13083ad8d751 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1160,6 +1160,8 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		ret = fbcon_set_con2fb_map_ioctl(argp);
 		break;
 	case FBIOBLANK:
+		if (arg > FB_BLANK_POWERDOWN)
+			return -EINVAL;
 		console_lock();
 		lock_fb_info(info);
 		ret = fb_blank(info, arg);
-- 
2.25.1

