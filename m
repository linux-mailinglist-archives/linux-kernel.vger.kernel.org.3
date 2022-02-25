Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B774C3A3D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbiBYAUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiBYAUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:20:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EEC726F4E7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645748392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S8A75tz/sgM2oz4IJwzQkkBvOOSDrrNdQ/Z7KwsYmpg=;
        b=E7eR6Vc6NTAJb/myh4DKuVipj0XH3hXMOiYByutAxfY1bCAi7ITnro6U1aKNv4GcsuFpRz
        7zQvDIoCi8lXyjoU5V8/x254A03+puHqpShC6aLW2UmvO5dP+v0bLUhaeyCDiNZe5GZvTP
        9nUxz3Nk7pI6yTfP2tXRQg2znA28O+I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-_okePoLNOEWRNvX1GC_LSw-1; Thu, 24 Feb 2022 19:19:50 -0500
X-MC-Unique: _okePoLNOEWRNvX1GC_LSw-1
Received: by mail-qk1-f197.google.com with SMTP id bj2-20020a05620a190200b005084968bb24so4141357qkb.23
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:19:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S8A75tz/sgM2oz4IJwzQkkBvOOSDrrNdQ/Z7KwsYmpg=;
        b=pJUh23tHI7cImVzz085NL3zfddyNITMA54HHYYkVUyrfw16LjsqiyjPeqxfvEVFfTr
         Lhb7t9ZTjfbQ/imCH1y0mdM80TmU0vLFGwFrgvDLLlifAOkcTfJvk8yejUo0jlyaimmy
         j5+jFrPv0klNjqN9hqX9PdaB1DV66MkpdlE5/XTDFOUSuY96ZBkkqYgsu32NvyRBSQ12
         RbEjif7LY6ZvojUYbQIHS4XXJdK839O+Jcejc8/v9Eqy6t/kyMFi4Lo8CDgJYt0rQSS/
         2zy+Jnt9Ef8/SSRp5nTNJesLkshC1rQu/YEAPb/kSxB935DqHcEf02t6NwT1vbwT2SOU
         orAg==
X-Gm-Message-State: AOAM532LLr/piQzRZrujckWmzHG+U3KBh1JEZoDVbAdUXSp7epGhqh6C
        g/JabDps04mfoHew421t/tub1GMAKLaB6S3P5wiK6WPS2NpiA5XpH38ZPn0umQ0pjfo2hDjfp1S
        BkMY/3I/nkY2/M4e+wLslnehZ
X-Received: by 2002:ac8:708e:0:b0:2de:23e3:62d7 with SMTP id y14-20020ac8708e000000b002de23e362d7mr4806512qto.35.1645748390198;
        Thu, 24 Feb 2022 16:19:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyN6LzLTYpJfyUGU1s3xm3lfwJ9rwwn7X/HV9iwC0QP6NHTU/WYcHUGGnr0v2Am7uEFBJiE/Q==
X-Received: by 2002:ac8:708e:0:b0:2de:23e3:62d7 with SMTP id y14-20020ac8708e000000b002de23e362d7mr4806501qto.35.1645748389965;
        Thu, 24 Feb 2022 16:19:49 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id e9-20020a05620a014900b005084ce66b44sm514213qkn.88.2022.02.24.16.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:19:49 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:19:46 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 16/29] x86/bugs: Disable Retpoline when IBT
Message-ID: <20220225001946.huzoeixgkqpx6zpt@treble>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.520731494@infradead.org>
 <20220219021530.hq6po7uexc4w36qo@treble>
 <YhT6gthym/jCUME4@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YhT6gthym/jCUME4@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 04:00:18PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 18, 2022 at 06:15:30PM -0800, Josh Poimboeuf wrote:
> 
> > This code is confusing, not helped by the fact that the existing code
> > already looks like spaghetti.
> 
> I'd say that's an insult to spaghetti.

:-)

> > Assuming IBT systems also have eIBRS (right?), I don't think the above
> > SPECTRE_V2_CMD_{FORCE,AUTO} cases would be possible.
> 
> Virt FTW.. if I don't handle it, some idiot will create a virtual
> machine that doesn't expose eIBRS but does do IBT just to spite me.

Ok, but in such a case, why not still do the warning, since the spectre
v2 mitigation isn't what the user might expect based on previous
behavior?

> 
> > AFAICT, if execution reached the retpoline_generic label, the user
> > specified either RETPOLINE or RETPOLINE_GENERIC.
> 
> Only RETPOLINE_GENERIC;

Hm?

	case SPECTRE_V2_CMD_RETPOLINE:
		if (IS_ENABLED(CONFIG_RETPOLINE))
			goto retpoline_auto;

retpoline_auto:
	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
		...
	} else {
	retpoline_generic:


> > I'm not sure it makes sense to put RETPOLINE in the "silent" list.  If
> > the user boots an Intel system with spectre_v2=retpoline on the cmdline,
> > they're probably expecting a traditional retpoline and should be warned
> > if that changes, especially if it's a "demotion".
> 
> too friggin bad as to expectations; retpoline == auto. Not saying that
> makes sense, just saying that's what it does.

Note quite.  Today it means "on Intel use the Intel retpoline; on AMD
use the AMD retpoline."

Intel doesn't recommend the AMD retpoline.  If you change that behavior
then it should be warned about so the user can adjust their mitigation
strategy accordingly.

> > In that case the switch statement isn't even needed.  It can instead
> > just unconditinoally print the warning.
> > 
> > 
> > Also, why "demote" retpoline to LFENCE rather than attempting to
> > "promote" it to eIBRS?  Maybe there's a good reason but it probably at
> > least deserves some mention in the commit log.
> 
> The current code will never select retpoline if eibrs is available.

Hm?  What do you think "spectre_v2=retpoline" does?

> The alternative is doing this in apply_retpolines(), but that might be
> even more nasty.

Hm?  Doing what in apply_retpolines()?

-- 
Josh

