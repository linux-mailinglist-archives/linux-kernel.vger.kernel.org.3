Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EDC4BA92C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244956AbiBQTEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:04:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbiBQTEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:04:34 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADD78093D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:04:19 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id t14so865332ljh.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=76YOh3whmbn2kqx1NwBv+Kz6cPFzAMtnxeUYyfGd/q8=;
        b=OBKQaFy2RxcRVMpclPmkX40fNiFA9xZ1M06FDambm/VZj3ozimFF9yfzH/IPJFXzHa
         qPjqXTszFuUqE8TXV1lXww3Z667n79ql/oVQlDLn/oPHQ1q/MexRIVFEQUMJkqybd5yQ
         coR1wSQC3lcRhRR4h+/kGuDvBV++mr9JoSg5cN8MQEDDTqmKmqhx2F5cUR8utIGnHpPd
         kmum6m1HYQZH2kpVGKNMISBRkNbXw++ofNJuZD/jMGHUPGgRC7pUf8Ab3eN89o28jljd
         u57aRQ73nEt0EatfpZNV56RywMxL2P8tNMiOUBwvv1qfch/8IBOiO6cKTMbJlUsm+71L
         78sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=76YOh3whmbn2kqx1NwBv+Kz6cPFzAMtnxeUYyfGd/q8=;
        b=LPIYy6AbbbBrA7foTvtIkByzbno6kqt8gG2wV46KZlDry2drQtfcQ15Aad7MleGzaF
         ezWn6gQn9TYNf/K1Efqa69mIwo6YuaDfOTXbgND4yjd4q7ZlU66+iU0pr7OUBxYVCjKl
         hSW5ykuPblhlLi8bq5bvrixD7Cm7z4h6jKBl0Ajo3rcZw3m+YIElUX4RmTewb1ugq6/C
         Rw+o5JL2mIYRLIf6gVCLzou3mHowWuD6I2bfolYJLephvbjBZQII7GWiEGDPT2RSni16
         ioRGCWJSPtaeNP/x2H6M1kiqlVRRxlmgtbSi8ArYzwulSzmmoAQfurDoJfdoGblvzNT1
         kL1Q==
X-Gm-Message-State: AOAM533j1lw/2pT5piPYz4Ji4vic9W9P8M5EJe9uyyIM/LcLmGSzHQbL
        KNWu7/cf3rANH2a9tsO7KBtaa7V8qirJQNoJnQ8MIQ==
X-Google-Smtp-Source: ABdhPJwh4DkU47MNBi0jwQYcYgp6ASpJqNbuKqJzALTbNGbz8cXoRGuLMjThUw0rnBxNBoUoQBdM0fjAD/6dT0KFPOY=
X-Received: by 2002:a2e:9206:0:b0:244:c5e5:977c with SMTP id
 k6-20020a2e9206000000b00244c5e5977cmr2981200ljg.339.1645124657897; Thu, 17
 Feb 2022 11:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20220217153842.3252424-1-trix@redhat.com> <51018469-3bab-e56d-7407-b16170b5d74c@amd.com>
 <CADnq5_OGEURo76mzc4Sb2Jar465Xt4vkSMECDi5jCMH332zUAg@mail.gmail.com>
In-Reply-To: <CADnq5_OGEURo76mzc4Sb2Jar465Xt4vkSMECDi5jCMH332zUAg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 17 Feb 2022 11:04:05 -0800
Message-ID: <CAKwvOdnYTC7mku1=eVaDLGQFHdoN3u8Afoo582OAQ+ApJmfhQQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_ras_block_late_init error handler
To:     Alex Deucher <alexdeucher@gmail.com>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 8:16 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Applied.  Thanks!
>
> Alex

Alex,
Has AMD been able to set up clang builds, yet?

-- 
Thanks,
~Nick Desaulniers
