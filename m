Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6401B4B96F6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiBQDtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:49:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbiBQDtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:49:01 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA1BC0506
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:48:47 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id t6so2173756ioj.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=losT24laQK9QPGecBoWrVc+10iJJY8vD90LsvY3Cts8=;
        b=YDLt3Q4XVCU3SNY6uD7/FtoBt1YQ4vttc8gh9hCegP9KTPTewYcgxbnMNm35qs3sAN
         83UuPyJiUycHSA5bqOW/TvnLpQ8ZL3hOV9hye+FMmwPZAsKyYaddsz4SNiz5qTk7zw+B
         V3zhfseOndqMAok28xM0o/fGD/E3AZIxhNC/DXcYBPUGtMnP1DEgi34hn45krZaAVCYh
         A0krsFznnlGBVOsrhLynW7/WtLAXCEiEqme6dgmGmAzf2kxKEThugOK0qfV1r2FpW2mD
         r8HYUa4v0OFsi6wanQA50eghIq6p284MDyFzJ4I76OeLxkDX1pmk806sJvl9H4j4X1Ln
         gf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=losT24laQK9QPGecBoWrVc+10iJJY8vD90LsvY3Cts8=;
        b=z5L2Cm7JJYyRpXtzS01KdXoFt+UeNhtOMQnQxwtPJi3ZRtB8Eho2MgpQltm5N70jH1
         IIx4eON4H0GgTY9kQXJemggYHl5QG3mMfT7hu59Fv0tBBuP9ZYsTLfSV/Swyk+u70vHE
         ndH4UMbSlbYLM9QxJM9o/2FXPi8UDZAFz39cOtUxRd+EnZLM4dwljcQILYl+kisfmEd5
         EzOyCY+78APS2Ow7o3dQh7kVCCLthWI/MES69NjHeTCfyXi6SuCXUULo7eCefynlfy3q
         Gno2oLBq+4j49w1cfN8ymPvBuAV6c6GXkUEC59KO8jAdqKuauPMNtnwLIDfcR/U/6tlQ
         I++g==
X-Gm-Message-State: AOAM5324oEehOx36d/uXv1BDsBhBZD/X2+Ltc/EPeEU6XKLEoFomSTw7
        rDVGhUHsDdTnFkO8pSI0Jfk=
X-Google-Smtp-Source: ABdhPJx/Tr8OkP8qQpMLDvFxZS1XzdR9P911qy0L55Cd/GZXU+ZPYahqdvxDhccEVXq+mEUJ/as2nA==
X-Received: by 2002:a05:6638:2387:b0:314:7ce4:1be8 with SMTP id q7-20020a056638238700b003147ce41be8mr745234jat.286.1645069726592;
        Wed, 16 Feb 2022 19:48:46 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::1b19])
        by smtp.googlemail.com with ESMTPSA id l16sm1127874ilc.54.2022.02.16.19.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 19:48:46 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 05/13] dyndbg: improve change-info to have old and new
Date:   Wed, 16 Feb 2022 20:48:21 -0700
Message-Id: <20220217034829.64395-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217034829.64395-1-jim.cromie@gmail.com>
References: <20220217034829.64395-1-jim.cromie@gmail.com>
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

move site.flag update after the v4pr_info("change") message, and
improve the message to print both old and new flag values.

Heres new form:
  dyndbg: changed net/ipv4/tcp.c:2424 [tcp]tcp_recvmsg_locked pT -> _

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index b72632212a65..77db640396a8 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -158,7 +158,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	struct ddebug_table *dt;
 	unsigned int newflags;
 	unsigned int nfound = 0;
-	struct flagsbuf fbuf;
+	struct flagsbuf fbuf, nbuf;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -223,11 +223,12 @@ static int ddebug_change(const struct ddebug_query *query,
 				static_branch_enable(&dp->key.dd_key_true);
 			}
 #endif
+			v4pr_info("changed %s:%d [%s]%s %s -> %s\n",
+				  trim_prefix(dp->filename), dp->lineno,
+				  dt->mod_name, dp->function,
+				  ddebug_describe_flags(dp->flags, &fbuf),
+				  ddebug_describe_flags(newflags, &nbuf));
 			dp->flags = newflags;
-			v4pr_info("changed %s:%d [%s]%s =%s\n",
-				 trim_prefix(dp->filename), dp->lineno,
-				 dt->mod_name, dp->function,
-				 ddebug_describe_flags(dp->flags, &fbuf));
 		}
 	}
 	mutex_unlock(&ddebug_lock);
-- 
2.35.1

