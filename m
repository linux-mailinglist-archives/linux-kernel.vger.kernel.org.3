Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96F3535D45
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350316AbiE0JLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351190AbiE0JKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:10:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64A8129EE1
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:07:32 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t13so5027756wrg.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=UJBVTCBlNfR7o09N0raMnnAoU4I40RWN+o0wJzKlzU0=;
        b=WeZWffED+tMab/OrHobFFtlpXTsAMJvGbzi3dM+zScWwPiUQ7S0lF6qZBnFqwrRxxL
         hkFIA1JE/hJpYS3YK/JCqrIpSp52Tzl2HFK9/Cd7yse0iC/mH9oboIFB0exsW5o/orSw
         Bz5noAWELeLtI7Njk0G91/ssZpXG8NrTUV88kvEok1JYfKJ+yD9t44ZIKlMEQLnCPC2E
         iWUCQGwJM1PX1zra+SBu2xFnk8O0SV5BIyiOtdQKAB40lDCChWtgXGqNPqJuK3NL2Vtm
         RxzMs3+sqn0odx5EeWHyWxq2fa5boWzIHfZDn6WCls9vPW6Ub8huPRFt7SfN4XjEiLac
         kD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=UJBVTCBlNfR7o09N0raMnnAoU4I40RWN+o0wJzKlzU0=;
        b=WEa4s1D3oTsWqhxId+ZqulwDZuSWL7lHd9Zg8OZuNPI+DGt8+5ijKWFDvebECYrJZT
         X9CDjW4VQAKMw+tSyd+F1SA5bDnWj3gRYOPvIPQiPagKn5KVuWvpCGEBmyHoKFc+acma
         nR2rj8nshhG2C0zl0fsKsDMLKgz223BkXWI5GwJ9fkW8gnWqQ14rQHoNEEC0TmiNo5cG
         ZrgTM4i9quUuA9RAJrVgwdC5q8s3XUK9z7SV2+Chl5BVOZ0Ww91CB2ClGlkOxg6TLMwC
         HNgn+nQeFJOp1E6WH3aNpV2rljkh8PwMoZOHSSfbM5WDW7hsHhMXb9nW7AY454CA7W/H
         P/0A==
X-Gm-Message-State: AOAM533Zs7ijoPJ+9gkf+LQVn2W4X1NYdah+MeWW7e/iL2Jj8J/yjqDq
        xVLE13BanKTUBuObKuCoKRsbMu0FvJ8=
X-Google-Smtp-Source: ABdhPJzKi6ymP17wa0aiakShx7mBScEEzVt8jOCTIL08pDTzC/n6niDrTNiBe36KvCaVyQe+EDWedg==
X-Received: by 2002:a5d:4351:0:b0:20c:f52c:f869 with SMTP id u17-20020a5d4351000000b0020cf52cf869mr34472072wrr.516.1653642449999;
        Fri, 27 May 2022 02:07:29 -0700 (PDT)
Received: from debian (host-2-98-37-191.as13285.net. [2.98.37.191])
        by smtp.gmail.com with ESMTPSA id t8-20020adfe448000000b0020fe7f7129fsm1133340wrm.100.2022.05.27.02.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 02:07:28 -0700 (PDT)
Date:   Fri, 27 May 2022 10:07:25 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: mainline build failure due to f1e4c916f97f ("drm/edid: add EDID
 block count and size helpers")
Message-ID: <YpCUzStDnSgQLNFN@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build for arm spear3xx_defconfig
with the error:

In function 'edid_block_data',
    inlined from 'drm_edid_is_valid' at drivers/gpu/drm/drm_edid.c:1904:25:
././include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert_250'
	declared with attribute error: BUILD_BUG_ON failed: sizeof(*edid) != EDID_LENGTH
  352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)

git bisect pointed to f1e4c916f97f ("drm/edid: add EDID block count and size helpers")

And, reverting it on top of mainline branch has fixed the build failure.


--
Regards
Sudip
