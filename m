Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999E54C4F61
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbiBYUQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiBYUQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:16:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8BA91FEDB0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645820129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3wyEvhfoz7fe65ABd71afm21cEKtIkBLwwX527dAVxU=;
        b=XkW6jF8n5YJIP6OOrlq1sq1gAsMiONOcEfwWbXNrC7QLjFy786Hh/GhWnOhJLtPnRZtxd8
        nU4bM7t/O19TZygMZCr2fjn4iy7QZOZq2BPdDYtfxxtIIWIYbqPHeaKjOm8SJ6BMcGC8HD
        ptwRSe7Kdwf/k/M91VoDMYlv8Dq0mBE=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-I52I4E-LN_-XLEr-FuHRwQ-1; Fri, 25 Feb 2022 15:15:28 -0500
X-MC-Unique: I52I4E-LN_-XLEr-FuHRwQ-1
Received: by mail-oo1-f70.google.com with SMTP id a142-20020a4a4c94000000b0031a9acddae9so3507000oob.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:15:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3wyEvhfoz7fe65ABd71afm21cEKtIkBLwwX527dAVxU=;
        b=OkkKqUiYUXgpYxwEK+Z7PuTrcWNu5E2VG5av+Aei9zRmQ+0PXTKL1dqDwffGIyulpV
         GDxX1xjettFkavDSyNxB8r9P2nk4M5eFkLPc2Arm5a9oX4LlS2/3S56WNmdlpYsRzQ1y
         n1WYmdoFZPWIPIMo1Z9hD39w4corC7jwUc0G2RqR8nu9HBfXCQl4+9VYDvlBNkUs4tVO
         3uAuUXr6pmq+FVAf0z5TEPtjvTZBa4AGRyJ7HYuZdaM4X/pkYMdEydT7QaDa2umPgC9Y
         Vo7bEBTCzKCH30rOJ0wrm1HEvq7FNFg6NIdV2a42o1Vm2J+OqcOiFY61uaK2sa1+m7jL
         D/BA==
X-Gm-Message-State: AOAM530snU2T/raE94F6GqSX3mlDA/VI3S3CpaBwgzhz4yu97qvN2Q6X
        pBikC1hJwmaiTBjVefYhhhuwkMGSzntq8rWCJKKSID1QrTjFyHatAa/G4/NREgEbOkzC63lsaZa
        yvlpDfxQDyEBXh6Xrb9gS2ZB2
X-Received: by 2002:a05:6870:8995:b0:ce:c0c9:6a1 with SMTP id f21-20020a056870899500b000cec0c906a1mr2121436oaq.243.1645820127686;
        Fri, 25 Feb 2022 12:15:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw28Y5A4magCJIuSDVjHzTMjbMEWL9xORduUQosQoNWhn1Bfw3d9udKzRnPSC1AFVr0I6RBzA==
X-Received: by 2002:a05:6870:8995:b0:ce:c0c9:6a1 with SMTP id f21-20020a056870899500b000cec0c906a1mr2121410oaq.243.1645820127373;
        Fri, 25 Feb 2022 12:15:27 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id x12-20020a056830244c00b005ad233e0ba3sm1580063otr.48.2022.02.25.12.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 12:15:26 -0800 (PST)
Date:   Fri, 25 Feb 2022 12:15:23 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 00/39] x86: Kernel IBT
Message-ID: <20220225201523.tuc2pb4bhuichey3@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224202602.3gvz5tnxvwb4maod@treble>
 <Yhj1oFcTl2RnghBz@hirez.programming.kicks-ass.net>
 <Yhj5GKLfyxbNCGua@hirez.programming.kicks-ass.net>
 <20220225172644.76fyxjximjrcdbzt@treble>
 <20220225123238.5ceeaae1@gandalf.local.home>
 <20220225195303.GA11184@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220225195303.GA11184@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 08:53:03PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 25, 2022 at 12:32:38PM -0500, Steven Rostedt wrote:
> > On Fri, 25 Feb 2022 09:26:44 -0800
> > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> > > > Damn, I just realized this makes KERNEL_IBT hard depend on KALLSYMS :-(  
> > > 
> > > Why should the jump label patching code even care whether there's an
> > > ENDBR at the jump target?  It should never jump to the beginning of a
> > > function anyway, right?  And objtool presumably doesn't patch out ENDBRs
> > > in the middle of a function.
> > 
> > Perhaps Peter confused jump labels with static calls?
> 
> The code is shared between the two.

Then just have a text_gen_insn_dont_skip_endbr() or so... ?

-- 
Josh

