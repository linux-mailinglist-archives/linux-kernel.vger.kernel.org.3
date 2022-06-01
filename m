Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B8953A96D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351764AbiFAOzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241149AbiFAOzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:55:40 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8F3674E6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 07:55:39 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-d39f741ba0so2992985fac.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 07:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gCLIA0GHMP+fHAx0HQaAHDI5dyXjR0CAfhrBwLepBPA=;
        b=TJVEE8jGHwkbEkPwlhCrEQz8ZVMyrOWNzrwTyarVu0HrPdBvwl0hoERVxWAFbPdzSK
         bJIfNV040zcfrrjpKBOeyLHFoHv3DMTJhDTsxXpupSCszGYyQ/7NHf/yUALMklBGE+0/
         ayLQW8qZxu+RveMIoRYyNZBQTVhhJiw0U+QzEYBhLPiC9vjyPebBXzGFoFR1N5F09bhF
         rEiTZmLPgGw0sdUj/RcyzwHv2LB+0YKUo/BiGGi2YGAmYx7Q8wrDqKcKQVsUVOsjTenY
         2iYUB96K/5v8wLMSdxVQ9L4PyjKfeIFs2COTzrbhyCf40RhMfGVrDkvkcriMJcGE7he7
         //9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCLIA0GHMP+fHAx0HQaAHDI5dyXjR0CAfhrBwLepBPA=;
        b=zoPJXzurWSNlPUiAR+yFo9oMmw5B7FCVLyCGZFNjvcZDSY6OR8rXsZ78WnwXbI+SIe
         ORGVfPkdqNPux9zspkz1FFPBSRswqi/u1NRdCw6BE/yFFivClaSp20NvhWHkx+Te4rUQ
         Skh5ZqoENIS9ZiSCvRwwySSxqfUCMfWqWYPesNEZZ6KC0d+IY1RPaeECJB3W5iR8o6yJ
         0r4BCmPc/bmFJsACd71nGBjkbQAn+MoiNDlcGPcyZXG2zYpy9g0xmdHIhLYiU+cqxqRM
         KB640YcXjQrZAIyUEFt/nD1ssJfib9mQf8pvFV0RH17qz6lzVZ4JwHBlAFxsUj6kVfUK
         TLbg==
X-Gm-Message-State: AOAM533ks5z3Z6fjxJd/er7w/tRayMGpnJeYIXzuQRa1AZqcXUWg9Zex
        tnlurscvpKl7fhs8HZt3FjFkeS20d9q7CwfPUfc=
X-Google-Smtp-Source: ABdhPJyN8wl9WYxOg8teVzGniYWLuSPtmHG+gVLKy1ll2nnIhUO67te72dw5fPtfUl5x6479YoilRtzYU2h8tdBoPEg=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr42477oap.253.1654095338886; Wed, 01 Jun
 2022 07:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220527090039.pdrazo5e6mwgo3d3@lion.mk-sys.cz> <20220527124459.mfo4tjdsjohamsvy@lion.mk-sys.cz>
In-Reply-To: <20220527124459.mfo4tjdsjohamsvy@lion.mk-sys.cz>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 1 Jun 2022 10:55:28 -0400
Message-ID: <CADnq5_PHR3NMhMAWDLy3SGyzn4bHedWDerXVmaFANbooYhZE0w@mail.gmail.com>
Subject: Re: (REGRESSION bisected) Re: amdgpu errors (VM fault / GPU fault
 detected) with 5.19 merge window snapshots
To:     Michal Kubecek <mkubecek@suse.cz>,
        "Yang, Philip" <Philip.Yang@amd.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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

On Fri, May 27, 2022 at 8:58 AM Michal Kubecek <mkubecek@suse.cz> wrote:
>
> On Fri, May 27, 2022 at 11:00:39AM +0200, Michal Kubecek wrote:
> > Hello,
> >
> > while testing 5.19 merge window snapshots (commits babf0bb978e3 and
> > 7e284070abe5), I keep getting errors like below. I have not seen them
> > with 5.18 final or older.
> >
> > ------------------------------------------------------------------------
> > [  247.150333] gmc_v8_0_process_interrupt: 46 callbacks suppressed
> > [  247.150336] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x00020802 for process firefox pid 6101 thread firefox:cs0 pid 6116
> > [  247.150339] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00107800
> > [  247.150340] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0D008002
> > [  247.150341] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 6, pasid 32780) at page 1079296, write from 'TC2' (0x54433200) (8)
> [...]
> > [  249.925909] amdgpu 0000:0c:00.0: amdgpu: IH ring buffer overflow (0x000844C0, 0x00004A00, 0x000044D0)
> > [  250.434986] [drm] Fence fallback timer expired on ring sdma0
> > [  466.621568] gmc_v8_0_process_interrupt: 122 callbacks suppressed
> [...]
> > ------------------------------------------------------------------------
> >
> > There does not seem to be any apparent immediate problem with graphics
> > but when running commit babf0bb978e3, there seemed to be a noticeable
> > lag in some operations, e.g. when moving a window or repainting large
> > part of the terminal window in konsole (no idea if it's related).
> >
> > My GPU is Radeon Pro WX 2100 (1002:6995). What other information should
> > I collect to help debugging the issue?
>
> Bisected to commit 5255e146c99a ("drm/amdgpu: rework TLB flushing").
> There seem to be later commits depending on it so I did not test
> a revert on top of current mainline.
>

@Christian Koenig, @Yang, Philip Any ideas?  I think there were some
fix ups for this.  Maybe those just haven't hit the tree yet?

Alex


> I should also mention that most commits tested as "bad" during the
> bisect did behave much worse than current mainline (errors starting as
> early as with sddm, visibly damaged screen content, sometimes even
> crashes). But all of them issued messages similar to those above into
> kernel log.
>
> Michal Kubecek
