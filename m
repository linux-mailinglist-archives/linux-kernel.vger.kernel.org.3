Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F15358FB10
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 13:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiHKLC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 07:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiHKLCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 07:02:55 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A566E93522
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 04:02:54 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id j3so11750614ljo.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 04:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=iwbijT25JOQabEJoAdZbUrL+K+nZlUlywCNjAPaRkPY=;
        b=Zwmv+zhwDMR2nSKdFJwP2quzKJ6loGMdS1t7skyjM7Np9UwvBEvxE06ihAie/nti4/
         diw7tb/KgC66OQQK6thMASgGBL0BBl5jJtfOlAFyaWnCzCsKUra2xCgo3eC6liJpPAlX
         iombHyCRKc/M6HnExt6By5qPTL9bSeEfccm4nS96YDwPAuj3qnRos8hU3C4VE09A+O0s
         OgyLJHo6Uq1ZGqoC+XdYzhesM/6b/GagdS7N6IYe/V3+fm5KMrMsOG5yrDi2RM6N4EU+
         ldv3wgvnqCU9DkoAzWQbGewePPsQ1LEKFFMG4HLp/o8Hmj+9EcuygvsNiQt0TNnN9ETn
         o7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=iwbijT25JOQabEJoAdZbUrL+K+nZlUlywCNjAPaRkPY=;
        b=1dMwuQP0hAhal5lgbN+GWHy6BtHOCdvmD8oGsUQZU0L1p1dtv9R3S+Mv+iWSsdYtuA
         NOnPCyX/awvjZPu6uHWucMkqF95Syr2B0TSKmf8IvrDtIENUCuBpdqFEoZ6MHAT5qRaH
         h9kIEwCCnJwJTXH7x+XUuUPKDGYBIRDkJfnfFDg8gTqfNubzoyqxjrD6eGgIpY8opHST
         8VM1n0RQoNU9Ex5eio8UpXPYVfnTVObdG8eLm/tKXwVfDrQVqObtxK9J/rqfV8LICzwp
         xq6KMrfkpbM6qPANG2lbHSomY6sWd83Pj+bUcPcV1wLQc187LXWYbr0fm6zdkuT4ogoM
         FoHw==
X-Gm-Message-State: ACgBeo03ClGDWPcPPdQ3R2daBTLhl4hIq86P7O4WmsJYWvOcv+bk/2Qi
        /8tqnbNZBwPXIRqEOQ+DSZVomw==
X-Google-Smtp-Source: AA6agR4ykeceqsDPELylN8UCyzrVw8F81lb8BHUuAicXDhJl8e5U6VRW1MUnNOJMxICZLpwoZ8cc/A==
X-Received: by 2002:a05:651c:3d9:b0:25e:505f:2355 with SMTP id f25-20020a05651c03d900b0025e505f2355mr10669447ljp.453.1660215772980;
        Thu, 11 Aug 2022 04:02:52 -0700 (PDT)
Received: from mutt (c-e429e555.07-21-73746f28.bbcust.telenor.se. [85.229.41.228])
        by smtp.gmail.com with ESMTPSA id q11-20020a2eb4ab000000b0025d75995a07sm781439ljm.24.2022.08.11.04.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 04:02:52 -0700 (PDT)
Date:   Thu, 11 Aug 2022 13:02:50 +0200
From:   Anders Roxell <anders.roxell@linaro.org>
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        hersenxs.wu@amd.com, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Claudio Suarez <cssk@net-c.es>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Roman Li <Roman.Li@amd.com>, Ian Chen <ian.chen@amd.com>,
        Colin Ian King <colin.king@intel.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@intel.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Imre Deak <imre.deak@intel.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/3] drm/amd/display: consider DSC pass-through during
 mode validation
Message-ID: <20220811110250.GA520@mutt>
References: <20220805211317.176672-1-hamza.mahfooz@amd.com>
 <20220805211317.176672-2-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220805211317.176672-2-hamza.mahfooz@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022-08-05 17:13, Hamza Mahfooz wrote:
> Add a mode validation routine for DSC pass-through. Both the link from
> source to hub, and the link from hub to monitor are checked, according
> to the current link training result and full pbn returned by enum path
> resource sideband message.
> 
> Pick up the minimum value as the bandwidth bottleneck for the end to
> end link bandwidth constraint, and check if the maximum DSC decompression
> bandwidth can fit.
> 
> Co-authored-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Hi,

Building an arm64 allmodconfig kernel from todays next tag, next-20220811.
I can see the following build error.

ERROR: modpost: "dc_dsc_compute_bandwidth_range" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "dc_dsc_get_policy_for_timing" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

When I reverted this patch I was able to build an arm64 allmodconfig
kernel.


Cheers,
Anders
