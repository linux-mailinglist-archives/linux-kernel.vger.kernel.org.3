Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F02756A7E8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbiGGQU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbiGGQUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:20:24 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8703A25EAF;
        Thu,  7 Jul 2022 09:20:23 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 23so19394930pgc.8;
        Thu, 07 Jul 2022 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQXT+Vn5CgtfH4Lkw1DN2mXJFuK6qLYy5tuOuFlvcck=;
        b=ep481detKf6cnRtYgWwYl8Ve2Q20j9MBngIbyhXi+uUiMyNsCkJPVNnqV4+9GEhQMI
         5r1BEG5VeuXECmy0qa1BEBQ6bsTHw3NZbroX0bjTLLy01n8EJ8mAk5kqew8XKjiFk3cX
         ppiMuPBWMYfwraZz6UOODNf3GAhRBmy/Assivb9cqXlaSodfiAa5hIapIWjlPEkelT98
         zVcpWRM4+ZtOZ382zBMtZJumB5PmIIl70vSgkIem6zVa5wnPbw+b+Lqs+D7k+ZnxBRJJ
         RcwcxN2L9fTv0LJKfZzwj/fnvwPHkHniErWhqoAe6s1/AeXORF3nj9RWw78U2egOuoEk
         ODqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQXT+Vn5CgtfH4Lkw1DN2mXJFuK6qLYy5tuOuFlvcck=;
        b=Ys45EREfiu6ntmgkG4aDQQx7MljEQBYLu/wYO7+3gsyhrCIcF3Dz1DRBWD+5SF8e8V
         6DJ0vkriYrUauEHFkQN924q5ri4nRpP0vtBW/niQhLo/NJRfWhZeQ3YKyk2BJq0qI211
         52Y3c04jKfX7mE1wlzT8jjRPiI2xHiXvoAnT3emk+wWk16ClyKaoHRnNCngi34J82OND
         rPeYBUTp8luotiR7cRD5iTidm9ZInLMc/Luib5bgeFxO/BocdNcTl3JsNKRGNN//QWga
         Q6Tvhct9Ekb/5ynWvG/BQaW+AkAwVoXXeLLZceHWuERGTuFthPPwyUHMdGFM9Wi4qP64
         CdJA==
X-Gm-Message-State: AJIora+1yEsTAGjMdfX8LhZD6YkLuRhoS53/oPeVyyEIPj5iVSd1+NG9
        9M459RlEso70NJaaBb7lMvk=
X-Google-Smtp-Source: AGRyM1u9SEtnL4jQMZBKg67l2QvltlcdhvaT46D8WMwmZH1uvR/26Gg6+iZyybeAlJ1r2Lx9Ozai7w==
X-Received: by 2002:a17:902:ea0e:b0:16b:f92b:a3c3 with SMTP id s14-20020a170902ea0e00b0016bf92ba3c3mr13342583plg.10.1657210822934;
        Thu, 07 Jul 2022 09:20:22 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id ik30-20020a170902ab1e00b0016bee668a5asm7138661plb.161.2022.07.07.09.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:20:21 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/mdp5: Fix global state lock backoff
Date:   Thu,  7 Jul 2022 09:20:37 -0700
Message-Id: <20220707162040.1594855-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
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

We need to grab the lock after the early return for !hwpipe case.
Otherwise, we could have hit contention yet still returned 0.

Fixes an issue that the new CONFIG_DRM_DEBUG_MODESET_LOCK stuff flagged
in CI:

   WARNING: CPU: 0 PID: 282 at drivers/gpu/drm/drm_modeset_lock.c:296 drm_modeset_lock+0xf8/0x154
   Modules linked in:
   CPU: 0 PID: 282 Comm: kms_cursor_lega Tainted: G        W         5.19.0-rc2-15930-g875cc8bc536a #1
   Hardware name: Qualcomm Technologies, Inc. DB820c (DT)
   pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
   pc : drm_modeset_lock+0xf8/0x154
   lr : drm_atomic_get_private_obj_state+0x84/0x170
   sp : ffff80000cfab6a0
   x29: ffff80000cfab6a0 x28: 0000000000000000 x27: ffff000083bc4d00
   x26: 0000000000000038 x25: 0000000000000000 x24: ffff80000957ca58
   x23: 0000000000000000 x22: ffff000081ace080 x21: 0000000000000001
   x20: ffff000081acec18 x19: ffff80000cfabb80 x18: 0000000000000038
   x17: 0000000000000000 x16: 0000000000000000 x15: fffffffffffea0d0
   x14: 0000000000000000 x13: 284e4f5f4e524157 x12: 5f534b434f4c5f47
   x11: ffff80000a386aa8 x10: 0000000000000029 x9 : ffff80000cfab610
   x8 : 0000000000000029 x7 : 0000000000000014 x6 : 0000000000000000
   x5 : 0000000000000001 x4 : ffff8000081ad904 x3 : 0000000000000029
   x2 : ffff0000801db4c0 x1 : ffff80000cfabb80 x0 : ffff000081aceb58
   Call trace:
    drm_modeset_lock+0xf8/0x154
    drm_atomic_get_private_obj_state+0x84/0x170
    mdp5_get_global_state+0x54/0x6c
    mdp5_pipe_release+0x2c/0xd4
    mdp5_plane_atomic_check+0x2ec/0x414
    drm_atomic_helper_check_planes+0xd8/0x210
    drm_atomic_helper_check+0x54/0xb0
    ...
   ---[ end trace 0000000000000000 ]---
   drm_modeset_lock attempting to lock a contended lock without backoff:
      drm_modeset_lock+0x148/0x154
      mdp5_get_global_state+0x30/0x6c
      mdp5_pipe_release+0x2c/0xd4
      mdp5_plane_atomic_check+0x290/0x414
      drm_atomic_helper_check_planes+0xd8/0x210
      drm_atomic_helper_check+0x54/0xb0
      drm_atomic_check_only+0x4b0/0x8f4
      drm_atomic_commit+0x68/0xe0

Fixes: d59be579fa93 ("drm/msm/mdp5: Return error code in mdp5_pipe_release when deadlock is detected")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c
index a4f5cb90f3e8..e4b8a789835a 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c
@@ -123,12 +123,13 @@ int mdp5_pipe_release(struct drm_atomic_state *s, struct mdp5_hw_pipe *hwpipe)
 {
 	struct msm_drm_private *priv = s->dev->dev_private;
 	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
-	struct mdp5_global_state *state = mdp5_get_global_state(s);
+	struct mdp5_global_state *state;
 	struct mdp5_hw_pipe_state *new_state;
 
 	if (!hwpipe)
 		return 0;
 
+	state = mdp5_get_global_state(s);
 	if (IS_ERR(state))
 		return PTR_ERR(state);
 
-- 
2.36.1

