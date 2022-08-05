Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2CE58B1DC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241837AbiHEV5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241774AbiHEVzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:55:31 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A7F7D1D7;
        Fri,  5 Aug 2022 14:54:52 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id c185so2857531iof.7;
        Fri, 05 Aug 2022 14:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=V3EmUW3uCJhVtlfIw0MXAC6Ylt2LCS6+A+4ZDgY1kTo=;
        b=ShBrGYIwiJ5Z5UFM4aatUf0XZbdzveqaHYzBMbd00rDzxakjjXMab/x0Q0YHiYMC5s
         PdQvJ3lkSWbzReG+11eWSG0qdPBf3i3lhEtcnYkfW++CfbyH1OiFePCxGAINrxxSSVGn
         Gp6W0nSfj5GQfhzkSYmhCOClGsvHRgvDIVz5I9VEINcxbayuH6yrjofEm0TmMkORLGUB
         HhuaGjdFI8t/lZ5V/9x/H7ZGQoC7FGsnXbpRULy73MmTkOf6MjhGLuVNmKpw0DNGeK+L
         jD74miLkviGk2LZHs3/D4xolo/pZN3NNYt/DoWJixqqM1WVZfLkt6FLfz6SqEVbrALGd
         T0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=V3EmUW3uCJhVtlfIw0MXAC6Ylt2LCS6+A+4ZDgY1kTo=;
        b=SiKZklQFZc+97Ivd6IzNE6amwargn4GGHbWpkb3ca+npffZbTz1OkN5QPnnLo7+rel
         ZEKW4tqEfvAhtQuux1QXKaKYj6LDoRQDodPV4pP2lNyKWeezKSLHaZ2tF6y11lr9NRLH
         o7A4nqgxhmzKs/LAafhcPaPQ7o7Wspk3KTjXFnVVbDukWJwpyMHZYpB/uGH98o3gc9/A
         8IpZUqLepbzYdJZpEB9sIHMok64NSJBRzYJ/ZbU+3Pm1+qhsoT4afn+KhY7iV7JIFeLe
         L/26ijD6O99LLlBgfSH7ni4jeXQuJK2f2QFtXsofJsFpZdPBYWjoPe+ea54M8qAd9W8X
         i//g==
X-Gm-Message-State: ACgBeo3LjQH2cI0ccgj1qSAyR/Sohd75ZQjbYIEbNHoWCtATN4kzubLW
        9eVLg8IiwPhEN9e9zSf9leNYniSG2rLhJQ==
X-Google-Smtp-Source: AA6agR5vaPMifnt//T6bSjIi//2udEDTd2tRxQPbcvsCKYwI5779ubMpxC1YlLcWEXL4yXw/5ukcsA==
X-Received: by 2002:a02:cb47:0:b0:342:8e65:7518 with SMTP id k7-20020a02cb47000000b003428e657518mr3942262jap.242.1659736490879;
        Fri, 05 Aug 2022 14:54:50 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b0067c09fd0b53sm1765532iov.21.2022.08.05.14.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:54:50 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 27/33] drm-print: add drm_dbg_driver to improve namespace symmetry
Date:   Fri,  5 Aug 2022 15:53:49 -0600
Message-Id: <20220805215355.3509287-28-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805215355.3509287-1-jim.cromie@gmail.com>
References: <20220805215355.3509287-1-jim.cromie@gmail.com>
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

drm_print defines all of these:
    drm_dbg_{core,kms,prime,atomic,vbl,lease,_dp,_drmres}

but not drm_dbg_driver itself, since it was the original drm_dbg.

To improve namespace symmetry, change the drm_dbg defn to
drm_dbg_driver, and redef grandfathered name to symmetric one.

This will help with nouveau, which uses its own stack of macros to
construct calls to dev_info, dev_dbg, etc, for which adaptation means
drm_dbg_##driver constructs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/drm/drm_print.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index f8bb3e7158c6..dfdd81c3287c 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -468,7 +468,7 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 
 #define drm_dbg_core(drm, fmt, ...)					\
 	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_CORE, fmt, ##__VA_ARGS__)
-#define drm_dbg(drm, fmt, ...)						\
+#define drm_dbg_driver(drm, fmt, ...)						\
 	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
 #define drm_dbg_kms(drm, fmt, ...)					\
 	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_KMS, fmt, ##__VA_ARGS__)
@@ -487,6 +487,7 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 #define drm_dbg_drmres(drm, fmt, ...)					\
 	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DRMRES, fmt, ##__VA_ARGS__)
 
+#define drm_dbg(drm, fmt, ...)	drm_dbg_driver(drm, fmt, ##__VA_ARGS__)
 
 /*
  * printk based logging
-- 
2.37.1

