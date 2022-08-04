Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5F058A092
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbiHDShO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238734AbiHDShL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:37:11 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD7E6A495
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 11:37:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j7so768256wrh.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 11:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=B8IeHwDJ6wqDm/ZlgAQSN22yY4qh5x2F6/SpKGeiUr4=;
        b=RFdiP7g41bMHSuMHMiydnwChvxj1DJWx5rXs+ZgU3/sQs9HhnLQlrPwdGj3Gqqnn9n
         5z9sg2V6E0k2bf4iy5j5GzNAwM16wjfIT7NubNfE2zdsNcVG//wlm3eQozf6aRqWwdzz
         A9oMzSdzLMARXzg3mKeGg+bpOPVKB4zBDazlwiZnS643LJda8iK3l0aclLgfHDlCKHCI
         oMFAW/cnYCqY8qwlYxGNfuu3xlFa0qGS9SKQXnT5H/8U7dkBN8yIo+ciPo49zlXrIu3S
         06w88Fnm55q4Mb2OZaKqYBm+mdk+9S5lzoytIKUoufIHrV/QdZKZjBo0VqJv6UoXJZ8Q
         5bEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=B8IeHwDJ6wqDm/ZlgAQSN22yY4qh5x2F6/SpKGeiUr4=;
        b=1wz3fj5ehkkOP+4BneuomYEkuYTRfD7tdRWAT8NYTd9Bi8uxWPL1zF2TqAjxBlX8pb
         /9HqIdgX3VVc/DpmqZQ0mMoQG6pj/lDf2pkYh2ur/Q3oJTi8szNAMkbVYazgz72XE+j1
         LeiJmzaNIwbKYfAw091PcvzQzRoVlnHxB7YLZyUiVvuavXopMfPh9vSCWPYu+6cNGOZ9
         IgYpbtt2iFIURgNnvDe7cxrDgFiNmhty5PzAVLIvp0Et9jFeV4OZ9uXDSyXfy/p6z9lW
         SLq8K5tJK3OQcT8tza3bV+VxWs/cNKOy0IgUXBUHTP0CeZYtyaDMzlilEcFl/Y78G+Hk
         Sm4g==
X-Gm-Message-State: ACgBeo3fR4zw7vNrBS1/Vcv+m0Eki/m49ia4sgHucxhTB8dkQ+aWxYj3
        7pTwcaAFQVWe6dVqnQDO/AA=
X-Google-Smtp-Source: AA6agR6BXtu4trhevGRN8TVyo6MRrwFBM4GRm3VN7u8yo8mEIkgNVkRgvawIxNMQllSvIRGPR7rAVA==
X-Received: by 2002:a5d:4f86:0:b0:21e:f78b:33f1 with SMTP id d6-20020a5d4f86000000b0021ef78b33f1mr2331775wru.38.1659638228064;
        Thu, 04 Aug 2022 11:37:08 -0700 (PDT)
Received: from debian ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id y10-20020adfe6ca000000b0021f0cf9e543sm2070037wrm.2.2022.08.04.11.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:37:07 -0700 (PDT)
Date:   Thu, 4 Aug 2022 19:36:57 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: mainline build failure for x86_64 allmodconfig with clang
Message-ID: <YuwRyQYPCb1FD+mr@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build for x86_64 allmodconfig
with clang. The errors are:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3596:6: error: stack frame size (2216) exceeds limit (2048) in 'dml30_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:3908:6: error: stack frame size (2184) exceeds limit (2048) in 'dml31_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1726:6: error: stack frame size (2176) exceeds limit (2048) in 'dml32_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)

git bisect points to 3876a8b5e241 ("drm/amd/display: Enable building new display engine with KCOV enabled").

My last good build for clang was with e2b542100719 ("Merge tag 'flexible-array-transformations-UAPI-6.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux").

I will be happy to test any patch or provide any extra log if needed.


--
Regards
Sudip
