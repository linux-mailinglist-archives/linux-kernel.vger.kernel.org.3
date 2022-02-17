Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703204BA93C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244972AbiBQTGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:06:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiBQTGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:06:37 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2218118D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:06:22 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id u25-20020a4ad0d9000000b002e8d4370689so690896oor.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0eT1lxfoq5qyDbp5eIAnsQwboX33oLO1Gz2b8VOV9eQ=;
        b=piI/0gpwz6MmcTd1tH7GT+KhCfmXjeZWejCehWfMxd3GxACkkdyeFdtCc38MyaMz1F
         v4spK69iBJM7RoH0lhLqBr7gJycoTylK4cLqx1R0wY7R72Q8x1R6NRv8PMzlN69v2arP
         RSz8EyYI7sepd0OP8Efx20nT1hJx5EZ4/BSEMMA291KGWneP9sU38hgNORJEMtFYf+1z
         MNTpoT0RFr/Q87ZJCYHxoztOoY6em6llwZ7lprlPMp0W2Had5rQUwtDSr5D4k68dR5l3
         z30Uyie+549zmipggxcR3Q79WDaehA57h3NuDLc/hyaQzlcVdelcTNmc9jKp56Y7l35A
         fCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0eT1lxfoq5qyDbp5eIAnsQwboX33oLO1Gz2b8VOV9eQ=;
        b=f8rr1acXjxmaWbys5or9xVPOaavL0OrhSADqr3TuPPFFuzrWD94FxOoElXJ8+/Mg/D
         7oCSlhW0YBVNqBQrGTHb7trmF3dG5Av80I2mYR7bLa+c1vK7rGK4CSgDlfNu8K+2QvIv
         12tSwP1SI4SUbXtaMJ+liv/kA/RMGo7ZhcvXMTGjCZk3xp89Y7m25H2KVe9uK0Xa+rbG
         vt4aVdAYgslnpGIp9WYrtvMg70hIta7Ur7Yv0M0A6RjIi90YceYyDX2GfxTWLYbMcNhu
         MmCK/kCfZ7grDbYraHZmtu+6TcsqxxB3LL7Qu1zbO76ugMCwQ0QS3ZL+koKn2l/Nwt7d
         quVQ==
X-Gm-Message-State: AOAM532bhOMhz1Y3BkhoWxFs5ykAfH1+cjL5hZOed3HTlJTV5kMJhNcS
        6OTYSQBFgij8GOfeXavIyk3/+eQFfm8Pk5J2K50=
X-Google-Smtp-Source: ABdhPJzTVo0BLlHY7QOaP5AWF+/HgAkv4O3cf3iw2UsClSnH35LOu7yMNCVBBMkTCxKrTWxKi1E4tGf81mwXJX3Csrw=
X-Received: by 2002:a05:6870:b281:b0:d3:e9c:811d with SMTP id
 c1-20020a056870b28100b000d30e9c811dmr1565142oao.225.1645124781997; Thu, 17
 Feb 2022 11:06:21 -0800 (PST)
MIME-Version: 1.0
References: <20220217153842.3252424-1-trix@redhat.com> <51018469-3bab-e56d-7407-b16170b5d74c@amd.com>
 <CADnq5_OGEURo76mzc4Sb2Jar465Xt4vkSMECDi5jCMH332zUAg@mail.gmail.com> <CAKwvOdnYTC7mku1=eVaDLGQFHdoN3u8Afoo582OAQ+ApJmfhQQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnYTC7mku1=eVaDLGQFHdoN3u8Afoo582OAQ+ApJmfhQQ@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 17 Feb 2022 14:06:10 -0500
Message-ID: <CADnq5_PniW+-8G5AhOSwuovESpfeMxL4r6P30b3F1coa_NmMEQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_ras_block_late_init error handler
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Luben Tuikov <luben.tuikov@amd.com>, Tom Rix <trix@redhat.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <john.clements@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        "Chai, Thomas" <YiPeng.Chai@amd.com>,
        "Stanley.Yang" <Stanley.Yang@amd.com>,
        Dennis Li <Dennis.Li@amd.com>,
        "Joshi, Mukul" <mukul.joshi@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>, llvm@lists.linux.dev,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, Feb 17, 2022 at 2:04 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Feb 17, 2022 at 8:16 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > Applied.  Thanks!
> >
> > Alex
>
> Alex,
> Has AMD been able to set up clang builds, yet?

No.  I think some individual teams do, but it's never been integrated
into our larger CI systems as of yet as far as I know.

Alex


>
> --
> Thanks,
> ~Nick Desaulniers
