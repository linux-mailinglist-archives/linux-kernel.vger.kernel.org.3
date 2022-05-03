Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887C5518665
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbiECOVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbiECOVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:21:31 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FD413E10
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 07:17:59 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h12so15048752plf.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 07:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9TEicqUAE63I8+bhURtXZYPHnUpdWS7u5S5vguxpyrQ=;
        b=SvUvmzPnXmKqSMLga4gHcCBwanXiyia8gN9hvPGRlLu2ulpt8/vIgmTJjuCOGEOTmn
         j34uWuews12zyFcQYo2azjKqZTlqyAgiAW9KGyg/rroHrDqy4UcxVtJQM9GHICf4I9hF
         YX0+ySAO+0aArcPV2b3f7n7dU551X4uFF58Ye8CQKwcNpZLKkEALYpEq2YmEriMsq6/+
         kbQBuUtKlXihC92w+sIrdgXeEC/rs6dxjRW0lcaIwk9Ir8C9uWfv8vHMp5g5JRswMog2
         yCY95+ffcBTM791ByG3Rsnotl2nbewtT+jDQFLaYE8aHI9UB9z14PAztGdkeMLfU7dJP
         +E4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9TEicqUAE63I8+bhURtXZYPHnUpdWS7u5S5vguxpyrQ=;
        b=K/M0ip7v26R0bunFaYYf6J54ZlB3gVy/GXmdCPFfebTDdurO064XFULc92m1oejRkU
         U/+IZ1k2oHJt01k9CaQLn71iE0/RuzksUlAXrbIhs3edaZsnmld0PU7yNQUWEX5+O06e
         +bSt/68+T0w/ATmiAfssU4s9amxGXf7XJ33feFrDC4DQeBx6X2rezahlf3HnMtzsSn/o
         ZXCSKEast4F5UsTA7Euiw6BsLfSJV1HshQuKx8nDz7iIWCoMdoTylnSDh7EeK4YzsDOu
         J2nIXu9wrubl4hQZs5ko12SYd3VLvQDPbzMYKB8AzQE2ddQIJdF8YNaJWvoatAwuPYRl
         yRQQ==
X-Gm-Message-State: AOAM531mKRjwgGAvkTy84gzziTdfkumewI8K8eb7MdrhhqZkw0GxhqJq
        yWwff/8teFEd/PUGDMGtobhapw==
X-Google-Smtp-Source: ABdhPJyTwTDHJdiiDTN0Dsj4FBQNu42qUygQhMEnNazehdA1ziyJz/asbePyPbuIpLAhUBSYrSRl3w==
X-Received: by 2002:a17:90b:4b83:b0:1dc:93c0:b9fc with SMTP id lr3-20020a17090b4b8300b001dc93c0b9fcmr114780pjb.103.1651587477619;
        Tue, 03 May 2022 07:17:57 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id c24-20020a17090abf1800b001cd4989ff44sm1408334pjs.11.2022.05.03.07.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 07:17:57 -0700 (PDT)
Date:   Tue, 3 May 2022 14:17:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Seth Forshee <sforshee@digitalocean.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] entry/kvm: Make vCPU tasks exit to userspace when a
 livepatch is pending
Message-ID: <YnE5kTeGmzKkDTWx@google.com>
References: <20220503125729.2556498-1-sforshee@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503125729.2556498-1-sforshee@digitalocean.com>
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

On Tue, May 03, 2022, Seth Forshee wrote:
> A livepatch migration for a task can only happen when the task is
> sleeping or it exits to userspace. This may happen infrequently for a
> heavily loaded vCPU task, leading to livepatch transition failures.
> 
> Fake signals will be sent to tasks which fail to migrate via stack
> checking. This will cause running vCPU tasks to exit guest mode, but
> since no signal is pending they return to guest execution without
> exiting to userspace. Fix this by treating a pending livepatch migration
> like a pending signal, exiting to userspace with EINTR. This allows the
> migration to complete, and userspace should re-excecute KVM_RUN to
> resume guest execution.
> 
> In my testing, systems where livepatching would timeout after 60 seconds
> were able to load livepatches within a couple of seconds with this
> change.
> 
> Signed-off-by: Seth Forshee <sforshee@digitalocean.com>
> ---
>  kernel/entry/kvm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
> index 9d09f489b60e..efe4b791c253 100644
> --- a/kernel/entry/kvm.c
> +++ b/kernel/entry/kvm.c
> @@ -14,7 +14,12 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
>  				task_work_run();
>  		}
>  
> -		if (ti_work & _TIF_SIGPENDING) {
> +		/*
> +		 * When a livepatch migration is pending, force an exit to

Can the changelog and comment use terminology other than migration?  Maybe "transition"?
That seems to be prevelant through the livepatch code and docs.  There are already
too many meanings for "migration" in KVM, e.g. live migration, page migration, task/vCPU
migration, etc...

> +		 * userspace as though a signal is pending to allow the
> +		 * migration to complete.
> +		 */
> +		if (ti_work & (_TIF_SIGPENDING | _TIF_PATCH_PENDING)) {

_TIF_PATCH_PENDING needs to be in XFER_TO_GUEST_MODE_WORK too, otherwise there's
no guarantee KVM will see the flag and invoke xfer_to_guest_mode_handle_work().

>  			kvm_handle_signal_exit(vcpu);
>  			return -EINTR;
>  		}
> -- 
> 2.32.0
> 
