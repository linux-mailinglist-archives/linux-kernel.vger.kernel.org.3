Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C915032CC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiDPCIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiDPCGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFB0D2627
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 19:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650074461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sMCjJkvqww4TEQNfOVtThKzjaCAIlsjnZPfM7Zr40XE=;
        b=Uu+cXTHsNvTzdNPQTWoK9KvlywleRX5D/xdhr8a8CAJIHvR21ZYGjxHVpCBmd7kOD+P55e
        kHmVdBfAg21Fhb3BMkdj4trjlUaPHlQ+96WW3rY3dotZuQ5sxkVj9wMdF7vJ3E2DXsUAEo
        VOzXfSLKmxkVG2HmeH/TMXJNKRQAEDs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-c2DVSNQqPM6IMXbDdLMl_A-1; Fri, 15 Apr 2022 20:49:51 -0400
X-MC-Unique: c2DVSNQqPM6IMXbDdLMl_A-1
Received: by mail-qt1-f198.google.com with SMTP id o6-20020a05622a138600b002f1ebce54cfso2264387qtk.18
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 17:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sMCjJkvqww4TEQNfOVtThKzjaCAIlsjnZPfM7Zr40XE=;
        b=iYARGLf+lLT0/uHOK9BEOm2FP7BVX0ce8R2nexmV0JUNAz5bqiVWpwoUlG9TYZWzyH
         fkXWkp+BGlB8BmjOXh6WXTrl1sfjW3+xQy4LFBlArLj8zY7yUWWJttO4+zou0ZIiREh2
         xB+fAj3v9KTai6MK3tKTVsfzUwwauonB0vdnpu+5/rbfy0ZzfLmsrS0mjmWD7erW6V9/
         LcOPBNnCEAl6M+afiHJpra8aYq6+7lqH80walihFNQEg77nHtqm4GxfK+FjZSFnCyYop
         yGmPeICpe+rbslnNTMs641JHEMRplDttDEsNeUHvBiYGq/HQzWxU3PDRFGtqekIHANc/
         OwYw==
X-Gm-Message-State: AOAM530/oIx86P0WEoYLwCUHHidwX55498IZIgFzuaBUnOreOWoFdbPj
        H+Swva9inJkS9BD5D0cS/fAIQQEiRl0gNXl+ZmVhuhiXnWO+L+AxvAyh9mTik+XkMf4khu7BVDh
        /niYUd8Rxkigl/I7wmHiUYu/J
X-Received: by 2002:a05:6214:1c48:b0:443:6e40:13cc with SMTP id if8-20020a0562141c4800b004436e4013ccmr958486qvb.106.1650070190561;
        Fri, 15 Apr 2022 17:49:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvbt0JtayRx0Xw8p0OXEwGz3kVU24hvlbWFZFIw0iTwGerAt2JWScLCNG/OI5KlLgVjBWL0g==
X-Received: by 2002:a05:6214:1c48:b0:443:6e40:13cc with SMTP id if8-20020a0562141c4800b004436e4013ccmr958479qvb.106.1650070190354;
        Fri, 15 Apr 2022 17:49:50 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id q123-20020a378e81000000b0067eb3d6f605sm3159123qkd.0.2022.04.15.17.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 17:49:49 -0700 (PDT)
Date:   Fri, 15 Apr 2022 17:49:46 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
        kim.phillips@amd.com
Subject: Re: [PATCH 1/2] x86/unwind/orc: recheck address range after stack
 info was updated
Message-ID: <20220416004946.tydhjaewitocy2cn@treble>
References: <1649749204-186363-1-git-send-email-dmtrmonakhov@yandex-team.ru>
 <YlVPpVC8chepOdzJ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YlVPpVC8chepOdzJ@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 12:08:37PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 12, 2022 at 10:40:03AM +0300, Dmitry Monakhov wrote:
> > get_stack_info() detects stack type only by begin address, so we must
> > check that address range in question is fully covered by detected stack
> > 
> > Otherwise following crash is possible:
> > -> unwind_next_frame
> >    case ORC_TYPE_REGS:
> >      if (!deref_stack_regs(state, sp, &state->ip, &state->sp))
> >      -> deref_stack_regs
> >        -> stack_access_ok  <- here addr is inside stack range, but addr+len-1 is not, but we still exit with success
> >      *ip = READ_ONCE_NOCHECK(regs->ip); <- Here we hit stack guard fault
> > OOPS LOG:
> > <0>[ 1941.845743] BUG: stack guard page was hit at 000000000dd984a2 (stack is 00000000d1caafca..00000000613712f0)
> 
> 
> > <4>[ 1941.845751]  get_perf_callchain+0x10d/0x280
> > <4>[ 1941.845751]  perf_callchain+0x6e/0x80
> > <4>[ 1941.845752]  perf_prepare_sample+0x87/0x540
> > <4>[ 1941.845752]  perf_event_output_forward+0x31/0x90
> > <4>[ 1941.845753]  __perf_event_overflow+0x5a/0xf0
> > <4>[ 1941.845754]  perf_ibs_handle_irq+0x340/0x5b0
> > <4>[ 1941.845757]  perf_ibs_nmi_handler+0x34/0x60
> > <4>[ 1941.845757]  nmi_handle+0x79/0x190
> 
> Urgh, this is another instance of trying to unwind an IP that no longer
> matches the stack.
> 
> Fixing the unwinder bug is good, but arguable we should also fix this
> IBS stuff, see 6cbc304f2f36 ("perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)")

I remember that nastiness well.  So it's still broken?  Or is this a
regression?  Maybe we wouldn't notice it except for this triggered
unwinder bug?

-- 
Josh

