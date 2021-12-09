Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE77E46E195
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 05:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhLIEmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 23:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhLIEmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 23:42:51 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE33C0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 20:39:18 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id k4so3988263pgb.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 20:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jCZfo737eIqYymDvP2I0a5WbCi1C4zoedhtPvFUy+O0=;
        b=N97S/VMMCfDqXQNGlOXuKapXV8DMeCT2OBm2ulgE+iNP8dKiGt2vva0mkRz1GCPaU1
         Jnud/ZRXYi2MNgP7UJ+uYpqPBUjS8uDSRui8CUn9uVUobKxowV/xCaeY63KOKoJlQ4Kf
         TbAZ9wLVq6jjQcCex2gjb7nqAswsziNd2jkck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jCZfo737eIqYymDvP2I0a5WbCi1C4zoedhtPvFUy+O0=;
        b=Mmzoo9whFbn/2m6HuEScfmf500yAZn78ok1Z9twAJVI1x+V215fgiFiPIIn1PMW5mX
         UAJLMNhUXdkbhRdNOKsN03z+VjR4yH4HmJxyQCJ1dCAWBtiv3ZkKFXt82BQv6ERiqx53
         JyNTKWnp+4J0XUo3BE8pIPx4BRzFMthPuxLB2Y4XYPrn8Ux5kSYICxCWqYWPVfQ9EcCM
         uYLn4kNv8dwJzbpsuLWWTTLK1YvN2QjrSQhQ9XdZiLcq5mjj/ZM9ouWJPuncBQ7/sLjC
         WmfSoSyUVwXSmcCWuHzbfyVCxMXLWGFKYPxa4CNF0dXRaxRkQE9DsJXWRUr/l8m6thPN
         /uQA==
X-Gm-Message-State: AOAM533XMoXJlgRuOFZOirvI3bp/oV326uQWbiVLAXAKPk9xJPqtecaF
        BrD9cx2wuIzNBDvIumZUffkcuQ==
X-Google-Smtp-Source: ABdhPJzYe1fOfNQQBb1cYonbf00InuoSvc6ETHSvTbgQnaWCy/3tiBy9ZBX1+4LZXqDyuX0VjaPskA==
X-Received: by 2002:a05:6a00:a23:b0:4a4:e9f5:d890 with SMTP id p35-20020a056a000a2300b004a4e9f5d890mr9750599pfh.82.1639024757920;
        Wed, 08 Dec 2021 20:39:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h8sm5566432pfh.10.2021.12.08.20.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 20:39:17 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Alessandro Zummo <a.zummo@towertech.it>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] rtc: Move variable into switch case statement
Date:   Wed,  8 Dec 2021 20:39:15 -0800
Message-Id: <20211209043915.1378393-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446; h=from:subject; bh=/Ww8OLLJSU5aHz7DArexGdWzbipcRlVe6LRWYhdbeaw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhsYhyueeQ9MVmpMGYuq8gt1pQqFSIQKjCzzjQUAdP 8E0C8JaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbGIcgAKCRCJcvTf3G3AJikgD/ 9/3GdVzi9NR+fpDE5+GBglcW+YcyEC9++7ry5SzE1bwcWsia8DrCVNV41CTWcPJw3xvnaZ2Svf57rN HuZEEKLXVzpdivG5NuY6l0etIGiRKdxz4ylUOwImJPJbin230ih8QzMryTTMEd8/uH8F+4v+eVCqft jmE9oRTybhhd2FbH9PuFoeNNV7vf2wt6L0Fv6HhvJ4oo9MJ4stF4TVm+8z0Fwo27gFbcPFGcBdDMtQ LWSSJiHfan72yqGcvdlm5ruu7sXjQI8VVPoR0RwFHS2fPj+cM8bbb/a4jhEBk06Tqvre9ilMBXB34g QmC9BiL3ZGrP4GZWU990JjXnZt+9zsluNofrXJO1Yvod+nQBjTRrFEu4SHHKCev3JEpyBJdzgDs8Gv spAMBKeO0xzJpqyVC8JNdkQ5dEvVnWKusGzCTYR6mXPLnxPIczx20LdHS9vvgyYbCcoaVC2AG2yDHx HjULEnhqYG/LlfqdwQYW4e0mdF4+L4ucUxtj8puwKnYOFThWXRrfvfdcMXAIa7JLCSmeYH/h/+RB00 3q+rokaYKKWCEjjyCzxjLRSYIxeXSbGF8zr/d19b3gksEqdTTHU5+b3JXjwzS4wKQIE+HlXgdtmNgh 3ggTF8ziCSAdIYjghZWklOsmSSgxOzbLsySgNzJFWDpF0lWkbSte9BBEaN2g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with automatic stack variable initialization, GCC 12
complains about variables defined outside of switch case statements.
Move the variable into the case that uses it, which silences the warning:

drivers/rtc/dev.c: In function 'rtc_dev_ioctl':
drivers/rtc/dev.c:394:30: warning: statement will never be executed [-Wswitch-unreachable]
  394 |                         long offset;
      |                              ^~~~~~

Fixes: 6a8af1b6568a ("rtc: add parameter ioctl")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/rtc/dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/dev.c b/drivers/rtc/dev.c
index e104972a28fd..69325aeede1a 100644
--- a/drivers/rtc/dev.c
+++ b/drivers/rtc/dev.c
@@ -391,14 +391,14 @@ static long rtc_dev_ioctl(struct file *file,
 		}
 
 		switch(param.param) {
-			long offset;
 		case RTC_PARAM_FEATURES:
 			if (param.index != 0)
 				err = -EINVAL;
 			param.uvalue = rtc->features[0];
 			break;
 
-		case RTC_PARAM_CORRECTION:
+		case RTC_PARAM_CORRECTION: {
+			long offset;
 			mutex_unlock(&rtc->ops_lock);
 			if (param.index != 0)
 				return -EINVAL;
@@ -407,7 +407,7 @@ static long rtc_dev_ioctl(struct file *file,
 			if (err == 0)
 				param.svalue = offset;
 			break;
-
+		}
 		default:
 			if (rtc->ops->param_get)
 				err = rtc->ops->param_get(rtc->dev.parent, &param);
-- 
2.30.2

