Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82ED2516B7B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383604AbiEBIBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376532AbiEBIBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:01:18 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA592A242
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 00:57:49 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id i22so87516ila.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 00:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1o9QvsSc9YvDxD2nqC58JtY0N0kXxGCwYzz2Lmsq/vM=;
        b=MNmDR6LjeUsEmew0Wgu4RMGdcP3a67dvAeYb3t+/boWi6E2nguLti110ZCe6hmqhAp
         WFYU9c+2WimTW4RRNJiQDX7UXlwzXXk9Ox1GSlRjaydYWLJHIkUsCJA4DcCdZn5SNWS/
         THwRA8qduVTQLbfKY8i7e0lO5jOqBYyNAhxmui6j3j3Tqq972XM0Hcx24DvRFgSVC6Vj
         3GoMrAJ3Ou16Wxf1hVIxob/akH9YmTbYFCyKtk/5BJ/WK8bYgc8wJp898qq71I3pXLzn
         3lblg+rpDU4+TNByilE5nE0Os1+C3y4pniRvZcg0a4d5YO2kspkG3Ci+jBKI5pXu6kRo
         Kadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1o9QvsSc9YvDxD2nqC58JtY0N0kXxGCwYzz2Lmsq/vM=;
        b=thmcRWnZsButPfXTDZq4eJYQokAVJgILJnbr+D5X2nVkv5oiVU97wM26FY2htSYs00
         v16Hcy8/0EhLlTbOMogQQtv2TXLfg5f957wmzpMZrMFAKJgdbFNjliZLg/ZXayiFhSiO
         Scz+NE+G16pE4rv8hTJYTVrLDAckrH1uBV+H9aqM+DyfA3cEnvr0onaUUcNkQ5Pm0Df2
         tDL6hzIEWcXoc13A4ewGqX/OIB4eooYrWxqXImzNtf4nw2HMPgHaumumauVF9e1Q3G2E
         livoPU02uth64ny5igVEy3BdegKIKE6ZosQy5cFSMwMhuH0nI3Ffhh9YDrA+B0bkS9cF
         69Wg==
X-Gm-Message-State: AOAM532xIDuqOtJsLYfFsTd5w++r97XiHG27nJjZctqRRBD+0bExZTJb
        Osf5Wg6hgmemRJ4ByOCV8ITNvQ==
X-Google-Smtp-Source: ABdhPJyz8XwenD+BQv29WOkJK8BBwVUoVg1aIa+1DN8PDqrLcq2aA8A7u2gdNelUEuD9J3o774/Ezw==
X-Received: by 2002:a05:6e02:1a29:b0:2cc:36d8:5d59 with SMTP id g9-20020a056e021a2900b002cc36d85d59mr4223708ile.137.1651478268460;
        Mon, 02 May 2022 00:57:48 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id o65-20020a022244000000b0032b3a7817d5sm2882449jao.153.2022.05.02.00.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 00:57:47 -0700 (PDT)
Date:   Mon, 2 May 2022 07:57:44 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        eauger@redhat.com, Jonathan.Cameron@huawei.com,
        vkuznets@redhat.com, will@kernel.org, shannon.zhaosl@gmail.com,
        james.morse@arm.com, mark.rutland@arm.com, maz@kernel.org,
        pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v6 03/18] KVM: arm64: Add SDEI virtualization
 infrastructure
Message-ID: <Ym+O+JLU5e9NUs39@google.com>
References: <YmMiyt/TDjJt0mdG@google.com>
 <36899ea9-e8bd-27b2-8dfb-75b76eab50d7@redhat.com>
 <YmRI7Bh7fWCYLUGT@google.com>
 <0e26da1a-00bb-3d63-a8bf-6cd3271b0a38@redhat.com>
 <Ymr45B+8xTlhi7vk@google.com>
 <96711526-c4f3-3b50-c015-beba8cc9fcc9@redhat.com>
 <Ym1EztjkJIHrg4Qz@google.com>
 <62f06a03-d6fc-3803-a2d2-7a85cf733459@redhat.com>
 <Ym9So9YariC0M7Zu@google.com>
 <2d631426-17fd-e7e3-5c62-eda547732bb7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d631426-17fd-e7e3-5c62-eda547732bb7@redhat.com>
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

On Mon, May 02, 2022 at 03:25:40PM +0800, Gavin Shan wrote:
> Oliver, how about to adjust struct kvm_sdei_vcpu like below. With the
> changes, struct kvm_sdei_vcpu::unregistering is dropped, to match with
> the specification strictly.
> 
>    struct kvm_sdei_vcpu {
>        unsigned long registered;
>        unsigned long enabled;
>        unsigned long running;        // renamed from 'active' to match the specification strictly
>        unsigned long pending;        // event pending for delivery
>           :
>    };
> 
>    state                          @registered  @enabled  @running  @pending
>    --------------------------------------------------------------------------------
>    unregistered                   0            0         0/1       0
>    registered-disabled            1            0         0         0/1
>    registered-enabled             1            1         0/1       0/1
>    handler-running                0/1          0/1       1         0/1
> 
> We can use the specific encoding to represent the unregistration-pending.
> 
>    state                          @registered  @enabled  @running  @pending
>    -------------------------------------------------------------------------
>    handler-running                0            0          1        0

Right, this is what I had in mind. This encodes the
'handler-unregister-pending' state.

> Thanks for your valuable comments, Oliver. I'm not starting to work on
> v7 yet. I also would like to make everything clear before that. In that
> case, it will be easier for you to review next revision :)
> 
> > > > >           unsigned long pending;       /* the event is pending for delivery and handling */
> > > > >           unsigned long active;        /* the event is currently being handled           */
> > > > > 
> > > > >           :
> > > > >           <this part is just like what you suggested>
> > > > >       };
> > > > > 
> > > > > I rename @pending to @unregister. Besides, there are two states added:
> > > > > 
> > > > >      @pending: Indicate there has one event has been injected. The next step
> > > > >                for the event is to deliver it for handling. For one particular
> > > > >                event, we allow one pending event in the maximum.
> > > > 
> > > > Right, if an event retriggers when it is pending we still dispatch a
> > > > single event to the guest. And since we're only doing normal priority
> > > > events, it is entirely implementation defined which gets dispatched
> > > > first.
> > > > 
> > > 
> > > Yep, we will simply rely on find_first_bit() for the priority. It means
> > > the software signaled event, whose number is zero, will have the highest
> > > priority.
> > > 
> > > > >      @active:  Indicate the event is currently being handled. The information
> > > > >                stored in 'struct kvm_sdei_event_context' instance can be
> > > > >                correlated with the event.
> > > > 
> > > > Does this need to be a bitmap though? We can't ever have more than one
> > > > SDEI event active at a time since this is private to a vCPU.
> > > > 
> > > 
> > > Yes, one event is active at most on one particular vCPU. So tt don't
> > > have to be a bitmap necessarily. The reason I proposed to use bitmap
> > > for this state is to having all (event) states represented by bitmaps.
> > > In this way, all states are managed in a unified fashion. The alternative
> > > way is to have "unsigned long active_event", which traces the active
> > > event number. It also consumes 8-bytes when live migration is concerned.
> > > So I prefer a bitmap :)
> > > 
> > 
> > The small benefit of using the event number is that we can address all
> > events in 8 bytes, whereas we'd need to extend the bitmap for >64
> > events. I suppose we'll run into that issue either way, since the
> > pending, registered, and enabled portions are also bitmaps.
> > 
> > When live migration is in scope we should probably bark at userspace if
> > it attempts to set more than a single bit in the register.
> > 
> 
> Even it's unlikely to support the shared event, bitmap will help in that
> case. I'm not sure about other VMM, the pseudo firmware registers are
> almost transparent to user space in QEMU. They're accessed and no one
> cares the values reading from and writing to these registers in QEMU ;-)

Regardless of whether userspace actually manipulates the registers we
should still reject unsupported values. For example:

Let's say the VM is started on a kernel that introduced yet another SDEI
widget outside of your series. The VM was migrated back to an older
kernel w/o the SDEI widget, and as such the VMM attempts to set the
widget bit. Since the old kernel doesn't know what to do with the value
it should return EINVAL to userspace.

--
Thanks,
Oliver
