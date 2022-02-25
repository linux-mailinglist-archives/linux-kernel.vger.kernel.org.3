Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C514C4F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbiBYU0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbiBYU0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:26:12 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FE22177CB;
        Fri, 25 Feb 2022 12:25:39 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id ay5so2910012plb.1;
        Fri, 25 Feb 2022 12:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BvDoeq2u/2/duKShEemTMjq5MiVNSY0a+G2ydC7I2To=;
        b=o1OzQU49xzdYXAIsISiigma1Fn1Py86Q0QNyrGPPa0fv+WsPYfNfXr1B1+bxBehh14
         s0qbzbLhDuZvMkoj6/IVcPxbkTVZDTOdaxhMm6kyhQJwTjhMffNp20HpAf9iKwWiNdXv
         /2N0LtfkO1twBvlK3a7WAavAY5YFq3yfwdmhw246OSen3fLSUyyh9xbIEmV/u9SMJKIx
         DkQ5dQfIvMX040iewmWXjUyH34DDlYnG2NKoA2ySHhLZhARVAo+0XxXXWm1K7W03u4nn
         t0eUtmYJEgm9lOgtb0AZ8HJX60KtMwgTEmBK78I7a0kfIu+IsRV9N051e62+xc+9SzG1
         hmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BvDoeq2u/2/duKShEemTMjq5MiVNSY0a+G2ydC7I2To=;
        b=x/vsM7lIAayQEaeifF9cyM4i10EvmpkbLlmhkGufh9aoHsVzDvijhMkb2ktyzenSvB
         olxeG6ru3w9nPkrraD0CRGQUvnlus5OtDms9AtVRvpHdVX4QoQkq8LVsjRMEBD/++hvS
         NCipPzTIeiXRuo28qRptAZKfhstGgYiEEK5Js/gFML/1i4hBuhmc8oBd4Bt1XFI0lk7d
         DpnadkFOHoPZXDVNNQf9i+qfg1YDAtELv7gsTvqhxifntFKj3FYTCbL+Uha7hBmRCuK9
         AapA0eP4SNu6R2Y5FMCxwj3+R3cb3zqKlg9ZBjFd17y6HtL4ajzP338htSlKnb1FRHB1
         Cfjw==
X-Gm-Message-State: AOAM533zfdu53idlj0nVc7MaHuojJ1xR9Ydm3DZN/eQiwv8HO+Pb9oAT
        WJaqMSR344qtNkWe4OPqE/4=
X-Google-Smtp-Source: ABdhPJx1OEwFFgxKLCQGCjpGEvJKL0DuprEa4VCYsCHFLhVId9kxLr0Y7/KAYE9GBz6ewotnoJPTCg==
X-Received: by 2002:a17:90a:c6:b0:1bc:c0be:4696 with SMTP id v6-20020a17090a00c600b001bcc0be4696mr4856224pjd.7.1645820738785;
        Fri, 25 Feb 2022 12:25:38 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id q3-20020a634303000000b00374da8cb24fsm3319914pga.50.2022.02.25.12.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 12:25:37 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] drm: Extend DEFINE_DRM_GEM_FOPS() for optional fops
Date:   Fri, 25 Feb 2022 12:26:12 -0800
Message-Id: <20220225202614.225197-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Extend the helper macro so we don't have to throw it away if driver adds
support for optional fops, like show_fdinfo().

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 include/drm/drm_gem.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 35e7f44c2a75..987e78b18244 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -327,7 +327,7 @@ struct drm_gem_object {
  * non-static version of this you're probably doing it wrong and will break the
  * THIS_MODULE reference by accident.
  */
-#define DEFINE_DRM_GEM_FOPS(name) \
+#define DEFINE_DRM_GEM_FOPS(name, ...) \
 	static const struct file_operations name = {\
 		.owner		= THIS_MODULE,\
 		.open		= drm_open,\
@@ -338,6 +338,7 @@ struct drm_gem_object {
 		.read		= drm_read,\
 		.llseek		= noop_llseek,\
 		.mmap		= drm_gem_mmap,\
+		##__VA_ARGS__\
 	}
 
 void drm_gem_object_release(struct drm_gem_object *obj);
-- 
2.35.1

