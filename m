Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC37589871
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239123AbiHDHfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239126AbiHDHfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:35:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D862AF
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 00:35:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j1so15821307wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 00:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=5EU04U6zAYyIYzGGcwcDfmg2hMhuz1M0NEedR2ivuW0=;
        b=RszuOa+odpEaiEJy45G5YW+s0j47TpRmy+lEDVUwPVP6JcsPJrwMo8tspfvRb7fMre
         W99E7nWmRNZSwcQhGwF7U5/tPYQqr8NnwO1Jj52xEZHtAju58FkRMFQifV7yjHz4R7uZ
         m+nMVKawX5MR5rLXmzXaeUmOP9JPQ/GTqa8O616Ny/hVj/FzIVxzhR4i5VxzKP4Uxs2N
         NNcVAj7HwHwKi4SGOn+kAUk7hOVyYV9XW6b6mu/ZbjjRwmTOHtMXIMuyrNK1WhC89ZXv
         +7u8jVSkbkWWd/rROPN/oXOkKdOy+nWLplYIFpAPipSroyvbydNn4zA69ceObU+QdJu0
         2W5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=5EU04U6zAYyIYzGGcwcDfmg2hMhuz1M0NEedR2ivuW0=;
        b=PYTgZsLxLqPcrCETfI8TH5yFET9M8BDWvvSNnk84M57ZRHNBvLEDrKNu3sP0y5oJQl
         1qaztorxnAXz2HM5xKZcJaK5ebjGTMnFmIaCjnGmDmuuqs03q4LxIySGOPsKvVPrf3H5
         W1HnhTuIOUMs10vsMlAoSv4IvRW/m8IPPgjpf05Ow8vD1ghoWgkTYOTgTKTNWp0slOG/
         qkv+UgXuMMPx6w+bNdlq0LRbB8zc87+3Z1sieMkexFVnNvR11LrCFbKbXgPt4Nt8ebK3
         1zW7bAv+pEAjNFxOpoV10PCe2beXEN2+meWb3RbY2O7rK8ON4x3wqYNtUabc/yb3iZMT
         YiTw==
X-Gm-Message-State: ACgBeo0vnWt2HDm7LCIHAwEDAdCKZivZUQ5XdibTqWPxlPfWMPqq8GJo
        81kJGEVLGeNd/a5//8FKfl4=
X-Google-Smtp-Source: AA6agR7QyZrRl97ERrAkEom1RkOvNNl2TGMuPIkZIfvXeehObd0r+4cGJ+S6KNmKW/eNfqqc4NTEgg==
X-Received: by 2002:a5d:64c1:0:b0:220:83fd:521e with SMTP id f1-20020a5d64c1000000b0022083fd521emr435672wri.428.1659598509871;
        Thu, 04 Aug 2022 00:35:09 -0700 (PDT)
Received: from debian ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id d14-20020adfe84e000000b0021badf3cb26sm309913wrn.63.2022.08.04.00.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 00:35:08 -0700 (PDT)
Date:   Thu, 4 Aug 2022 08:34:58 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Chengming Gui <Jack.Gui@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: mainline build failure due to 6fdd2077ec03 ("drm/amd/amdgpu: add
 memory training support for PSP_V13")
Message-ID: <Yut2otE1h2xtC79o@debian>
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

The latest mainline kernel branch fails to build for alpha and mips
allmodconfig with the error:

drivers/gpu/drm/amd/amdgpu/psp_v13_0.c: In function 'psp_v13_0_memory_training':
drivers/gpu/drm/amd/amdgpu/psp_v13_0.c:534:23: error: implicit declaration of function 'vmalloc'; did you mean 'kvmalloc'? [-Werror=implicit-function-declaration]
  534 |                 buf = vmalloc(sz);
      |                       ^~~~~~~
      |                       kvmalloc
drivers/gpu/drm/amd/amdgpu/psp_v13_0.c:534:21: error: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
  534 |                 buf = vmalloc(sz);
      |                     ^
drivers/gpu/drm/amd/amdgpu/psp_v13_0.c:545:33: error: implicit declaration of function 'vfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
  545 |                                 vfree(buf);
      |                                 ^~~~~
      |                                 kvfree

git bisect pointed to 6fdd2077ec03 ("drm/amd/amdgpu: add memory training support for PSP_V13").

And, reverting that commit has fixed the build failure.

I will be happy to test any patch or provide any extra log if needed.

--
Regards
Sudip
