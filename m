Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D916553BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354304AbiFUUjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354188AbiFUUj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:39:28 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30BE21E06
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:39:27 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id bm2-20020a056a00320200b0052531ca7c1cso1976629pfb.15
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=TBTJUKxXl6/CoGemYB3REqJFiIeblmjK8L2EWRNC3hI=;
        b=JkQhyN+x8xO9p13An8lNUc3EIJj4b6DAyE7xZpJ7T7EpKBDtW2fZkVhM7DfjEQtJ7p
         6DI2hX0snVjQiA0cxY+7w2K5CTkr1lE3ImkqKi/WeJg/2eU2RAl8vDaQsC0iRPCfzc6j
         dlM/IwEY/mGrodbwRYQ7PCbIAARUeEMGzqkUlBnGmfAk0fTq+Uvm2QhpJjNQOJBhcqyW
         ucYnMt380S0hDSbNup1QcqxPAAZYvor5zrk7qQToX1oy754i1V3nPdifsyF+w3/bW7+1
         pf8oBBosJG04k2+FrshmyenC1ATMgUdchPUs2TRnmHb907CjwN2ckgEoG60OSv3zc/9z
         mI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=TBTJUKxXl6/CoGemYB3REqJFiIeblmjK8L2EWRNC3hI=;
        b=p2+o3tvXw/USvSo4gQeN2Ykz5nwDHjOVwV39rJXkLF0DDAzn4wIxndtV7+SfNle+Yh
         Gib5KoPdEZOP9GNm4+9tD+5x793MjnFLD0HGqPzThMi6HD3VHJdcojIaCM+qiSWul16K
         HlICHi133bjhqJMq/Adf1Hz29gzuvXHbvO0GQMwjjvc5Sr7MGnvyykiSM3Mt/FUkfBau
         EgROrSdXo4YWJryWx7A/Y5/Q05AOPMQRPiCHYmvJXSFZqJBLLv+ZZ/pbUOUMuuKy+ndY
         QwZ0t5c4W9w8lM+SBqSDp0pF/Joc+lKdr01utkLkQyxp81tGXOuO2UBReTBZBL9sfNHI
         FYbQ==
X-Gm-Message-State: AJIora9epd1SdMFvBvpQeL4TSD75H8PFit6MzdDWptpQUbChVmQllWaV
        GGODnyxID/2yeSuX5Lfjm/R12rWuJ9n+DQ==
X-Google-Smtp-Source: AGRyM1ssb1j9pdEhTyuXhD8tWoHrkikkmhIQybOMDN7v+xBmjMvp9r+GQEe+ZTCmcx6n2GR7vd6pM9Lx6nqQHg==
X-Received: from zllamas.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c])
 (user=cmllamas job=sendgmr) by 2002:a17:902:d5c3:b0:168:f037:98d7 with SMTP
 id g3-20020a170902d5c300b00168f03798d7mr30454468plh.117.1655843967320; Tue,
 21 Jun 2022 13:39:27 -0700 (PDT)
Date:   Tue, 21 Jun 2022 20:39:21 +0000
Message-Id: <20220621203921.3594920-1-cmllamas@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH] drm/fourcc: fix integer type usage in uapi header
From:   Carlos Llamas <cmllamas@google.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel uapi headers are supposed to use __[us]{8,16,32,64} types defined
by <linux/types.h> as opposed to 'uint32_t' and similar. See [1] for the
relevant discussion about this topic. In this particular case, the usage
of 'uint64_t' escaped headers_check as these macros are not being called
here. However, the following program triggers a compilation error:

  #include <drm/drm_fourcc.h>

  int main()
  {
  	unsigned long x =3D AMD_FMT_MOD_CLEAR(RB);
  	return 0;
  }

gcc error:
  drm.c:5:27: error: =E2=80=98uint64_t=E2=80=99 undeclared (first use in th=
is function)
      5 |         unsigned long x =3D AMD_FMT_MOD_CLEAR(RB);
        |                           ^~~~~~~~~~~~~~~~~

This patch changes AMD_FMT_MOD_{SET,CLEAR} macros to use the correct
integer types, which fixes the above issue.

  [1] https://lkml.org/lkml/2019/6/5/18

Fixes: 8ba16d599374 ("drm/fourcc: Add AMD DRM modifiers.")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 include/uapi/drm/drm_fourcc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index f1972154a594..0980678d502d 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -1444,11 +1444,11 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 mod=
ifier)
 #define AMD_FMT_MOD_PIPE_MASK 0x7
=20
 #define AMD_FMT_MOD_SET(field, value) \
-	((uint64_t)(value) << AMD_FMT_MOD_##field##_SHIFT)
+	((__u64)(value) << AMD_FMT_MOD_##field##_SHIFT)
 #define AMD_FMT_MOD_GET(field, value) \
 	(((value) >> AMD_FMT_MOD_##field##_SHIFT) & AMD_FMT_MOD_##field##_MASK)
 #define AMD_FMT_MOD_CLEAR(field) \
-	(~((uint64_t)AMD_FMT_MOD_##field##_MASK << AMD_FMT_MOD_##field##_SHIFT))
+	(~((__u64)AMD_FMT_MOD_##field##_MASK << AMD_FMT_MOD_##field##_SHIFT))
=20
 #if defined(__cplusplus)
 }
--=20
2.37.0.rc0.104.g0611611a94-goog

