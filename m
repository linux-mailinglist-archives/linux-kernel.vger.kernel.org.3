Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3347253BA53
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiFBN6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiFBN6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:58:36 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF0D87A20
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 06:58:33 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-f2cd424b9cso6821570fac.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 06:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2L2ObJyA5aSAMYg/ooYObOJj991nQteSKXjuDuNhvCw=;
        b=Bb5NTBROxJdLUTbonbdi14UD9v3tDr1oU1S+IeAYUwTUdbHPQY26Dc/kvLzg2pqCd/
         aCT00EyhkTQ1jkzHf8yho+GP8PJTRZuwgSj5UlVuueawgQHOoZBPTDm3mPxzul+JW7iU
         /cwQvwAzepsY8lWF4DVXDJ2B8ERuGFTuCS3ovLQc15pqWz1Cj2GpxPBm2YKjDoSD7eZ7
         RNzMo5oRBELVXe2Rz02E403frVUxGrE2xjamoela22Ll9uqnQmJvpE/3Ud17uYMBEI87
         W6Rrx5UpQ3s4+hw1lS1VATGpvr8Bjs7POrF36N9A0NtkIHUyNIJY60qvhp6FiiFBmKQl
         YRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2L2ObJyA5aSAMYg/ooYObOJj991nQteSKXjuDuNhvCw=;
        b=PVNkE170Sb1LAooZ/ed23LH41BPT4eupvoiL9rWRMZzb2UhLV+OLVVXVFkOoDbi5u7
         CDE0+KIR381hUHBZrMG/vQuPLm1EAPHnyVqhbLNuHlfbmC7kIfCHpmKcbHiZkHzJl4NL
         KWNBFtQNj93XMqNEiLGQtzmMNXabBs+8cRxjfBgHJ8TYClvooJasroYMt85XGFyh3oy4
         6qJYuAv3d9VHJtkewMRkUVelyIOdeD8AZ1p+yQTmMoMjR7+hsjhqbPm5mC3SIL7bHony
         qVjfMXMh6PblgxdU+RI8BAZwDgd6qGg2jnYZNNDvqKPt14o61dxTtbyKR3FwxxvqlRtU
         k+xA==
X-Gm-Message-State: AOAM5337Q9LM2EmWs2F2FzHUhEYXKy12iRxgTawCrlSxtmgot+PJZ3rX
        7qXjFkmoZkQYSJ7Y9h5NZ8N1V+PtymjCcKsAdrc=
X-Google-Smtp-Source: ABdhPJwDy6DJ5qiR0rFGMNl9Es1ZF1OGqrTAAVs3U0JDV3pUTwhOg+jdn03Umz0Fe1sVdCzwIFWA7VgzMu7kRZ7N63s=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr2810070oap.253.1654178312926; Thu, 02
 Jun 2022 06:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220527090039.pdrazo5e6mwgo3d3@lion.mk-sys.cz> <20220527124459.mfo4tjdsjohamsvy@lion.mk-sys.cz>
In-Reply-To: <20220527124459.mfo4tjdsjohamsvy@lion.mk-sys.cz>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 2 Jun 2022 09:58:22 -0400
Message-ID: <CADnq5_Pr-FKfhuXT9DR2rYD=dMfD=+Dfev+CO-xeaPGnhwSQaA@mail.gmail.com>
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
> I should also mention that most commits tested as "bad" during the
> bisect did behave much worse than current mainline (errors starting as
> early as with sddm, visibly damaged screen content, sometimes even
> crashes). But all of them issued messages similar to those above into
> kernel log.

Can you verify that the kernel you tested has this patch:
https://cgit.freedesktop.org/drm/drm/commit/?id=5be323562c6a699d38430bc068a3fd192be8ed0d

Alex
