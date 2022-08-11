Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509505905B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbiHKRU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbiHKRUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:20:08 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AC3BC2;
        Thu, 11 Aug 2022 10:16:26 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u14so13959148oie.2;
        Thu, 11 Aug 2022 10:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=KfbvK1kB8bEVX+Bg3v0uAmAH4X0cmlYYTnpUW0qFVPQ=;
        b=TnkO0E874E+5j6klJFh8ek6SsnENd71jthFGsFpua2yYT5NQw0Pv81Jxt31gT4bW9s
         LGjKTwHL4DnMsXhZGXPm7oRcS1kxvSfp9nPTnkDeRFvTFAEvAEL91hOJjq1rtDMOIFfb
         s0fRKqkufOEOskCOyspzuYGiEfIItVxs2JEQUq/WJcHWwk+196JVL/HUR2MwC4pMNx+j
         Msb5XcCNOW/JcgNCVUdQpR8GgZWFNKvkmC42KDjfxols2OkYZTqs+8xeN8BtGI+8+Ic9
         EStOeW5RQE2g8nWdb71bmJELef5l4vE55QoC9yf4CSX2xmLd81W6QP/uq10mflmWZMfH
         zHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KfbvK1kB8bEVX+Bg3v0uAmAH4X0cmlYYTnpUW0qFVPQ=;
        b=vYDL4WbuAsQXRpS2Pj3px78pyP+09QHED2SrO1OauXTKd64lUI8pSdQ5SnwVDvgOmq
         zM+kPKZZeBPmGceVXbypBwoS52qiDR4td1/okkt7qswQTjvzJx7o8DM8fFbNxCxpoSqL
         owuzjc2lAigT6REWfiXOVb+2E0j8H4ovs9atRdIJzZbiYUzuovc6K14//M1Swxxml9Qc
         VYD+XP1Y4gp1ydVES56gK/A7Adv3pznMTLR9Hp5fWCPAur1Wxn5Km/Cp7inNOXeudV83
         CdJ4dmPeSFyX14JleVOsKbN/1jiq7U+uDyciwQdbv6j9xSAI1xEyNcYKrje84Vwlx+Op
         lhVQ==
X-Gm-Message-State: ACgBeo0MyrBoCzqy6FkVs75PgJibFERjwy1jXaN6F80cp8BEHImY75Zx
        SBDaYrrM9ggSzeCqWb1RVq3WJd3jgqA0ai5B/kA=
X-Google-Smtp-Source: AA6agR4Bzynj5rmJ8wCQm3W9k/cxzVFKyJgGxa2jF7SPAmi/iTivBeW/gA2Idukm9kGS55zj0zOhNVtOD/B82NJlMXc=
X-Received: by 2002:a05:6808:19a3:b0:33e:1525:3fb4 with SMTP id
 bj35-20020a05680819a300b0033e15253fb4mr106057oib.106.1660238185376; Thu, 11
 Aug 2022 10:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <YvU4GD8HtZ1A4dhI@debian>
In-Reply-To: <YvU4GD8HtZ1A4dhI@debian>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 11 Aug 2022 13:16:14 -0400
Message-ID: <CADnq5_PwbwjmvvKedpZeeQHk7N+kawKpXywjNGqa=1jSKRcw0A@mail.gmail.com>
Subject: Re: build failure of next-20220811 due to b1a63a0b48ad
 ("drm/amd/display: consider DSC pass-through during mode validation")
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-next@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 1:11 PM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi All,
>
> Not sure if it has been reported, builds of riscv, alpha, s390, arm,
> arm64, xtensa, mips, csky allmodconfig have failed to build next-20220811
> with the error:
>
> ERROR: modpost: "dc_dsc_compute_bandwidth_range" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "dc_dsc_get_policy_for_timing" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>
> git bisect pointed to b1a63a0b48ad ("drm/amd/display: consider DSC pass-through during mode validation")
> And, reverting that commit has fixed the build failure.
>
> I will be happy to test any patch or provide any extra log if needed.

https://patchwork.freedesktop.org/patch/497116/

Alex

>
>
> --
> Regards
> Sudip
