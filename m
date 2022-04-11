Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF924FBF06
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347261AbiDKO2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347183AbiDKO2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:28:04 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7553D38181
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:25:50 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r66so14342140pgr.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sns/MvLMLn0yGtKjZZVTM2sMuhywLDT5QG/H5jOX8eU=;
        b=Z3Ux/44QgNYQkA0TED9DfN8/3CH/FV74I6O6NHbIbPpLIM757WSxs5b36VLT+8MFGQ
         lmpNzUl0GuiEQTTe25IVQtdbXCUKE5yiEABr6Qo9UPYTp0YUAN6GBWsjxOcL/9Z1MKfV
         1pGsENHotN1eR/QFZx1GZZcqdX/SPBKrizub/ahbCxvxaDbvBhgu6+UTE/FpWNaCp10A
         txb9lPoI1Co6ZtPP58xkVPEifFwiXhQqT9GFBFmH67RTmpO1FmDqRQbWNAqAIJyxfg02
         NeWL7OaNNUPWTwLLo365zXcz1exjmqe9KMFawEdhZo+QoRpkPnJS4dhxH7Va7+kyZv+9
         PiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sns/MvLMLn0yGtKjZZVTM2sMuhywLDT5QG/H5jOX8eU=;
        b=u+YQWO+EdpRpQF+BHcP8onLe5fxNBnaDqo+Jrk17DGwWwjbFfROQ4/ERMgm7RE6epp
         HyKGXT5fLL9nMb01A1zteTyWLLGGFQNppI6oJJAM0CN8gIF2iFaWgCs8QJRS4emNvk8y
         Ow69t8l51eMeLV94aC2+XkDR3tE/LrB+akMUhhycp5tn8GNi+a5P2zpiSOtUtmP+5qQV
         xmOeQeiTXMN2QJE2nSmBd3Mdu72a2yA0UV2LuH/kTLMQwp+cx5YklY5J64nrbeMKBeYm
         i7tPsCqd7WjivYjxK3I6+XXzGZVUxzVr4oeq6syYnyg2zH7XacdIDwnvx2eQCED6IjG7
         L9lw==
X-Gm-Message-State: AOAM532Rd1vP38BneswLKp8oP52ISZTWgZv/ATD7/dcHe8zPa7DaOU7d
        puWCu3cf9GAfgY5XkhoXJDz0Cw==
X-Google-Smtp-Source: ABdhPJw7Gknjju8PCnagcxI8t3XHkB5GkXIJH8Fsh2IFs/OjXu5dbyJCeKZJ6MSc6BjOaa0Yg47aJw==
X-Received: by 2002:a63:6c8a:0:b0:398:5208:220a with SMTP id h132-20020a636c8a000000b003985208220amr26701346pgc.176.1649687149751;
        Mon, 11 Apr 2022 07:25:49 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s10-20020a63a30a000000b003987eaef296sm5653pge.44.2022.04.11.07.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 07:25:49 -0700 (PDT)
Date:   Mon, 11 Apr 2022 14:25:45 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Peter Gonda <pgonda@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4.1] KVM, SEV: Add KVM_EXIT_SHUTDOWN metadata for SEV-ES
Message-ID: <YlQ6afg11dVGhUBB@google.com>
References: <20220407210233.782250-1-pgonda@google.com>
 <20220408165641.469961-1-pbonzini@redhat.com>
 <87czhoar7k.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czhoar7k.wl-maz@kernel.org>
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

On Mon, Apr 11, 2022, Marc Zyngier wrote:
> On Fri, 08 Apr 2022 17:56:42 +0100,
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> > 
> > Queued, thanks.  But documentation was missing:
> > 
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > index e7a0dfdc0178..72183ae628f7 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -6088,8 +6088,12 @@ should put the acknowledged interrupt vector into the 'epr' field.
> >    #define KVM_SYSTEM_EVENT_SHUTDOWN       1
> >    #define KVM_SYSTEM_EVENT_RESET          2
> >    #define KVM_SYSTEM_EVENT_CRASH          3
> > +  #define KVM_SYSTEM_EVENT_SEV_TERM       4
> > +  #define KVM_SYSTEM_EVENT_NDATA_VALID    (1u << 31)
> >  			__u32 type;
> > +                        __u32 ndata;
> >  			__u64 flags;
> > +                        __u64 data[16];
> >  		} system_event;
> > 
> >  If exit_reason is KVM_EXIT_SYSTEM_EVENT then the vcpu has triggered
> > @@ -6099,7 +6103,7 @@ HVC instruction based PSCI call from the vcpu. The 'type' field describes
> >  the system-level event type. The 'flags' field describes architecture
> >  specific flags for the system-level event.
> > 
> > -Valid values for 'type' are:
> > +Valid values for bits 30:0 of 'type' are:
> > 
> >   - KVM_SYSTEM_EVENT_SHUTDOWN -- the guest has requested a shutdown of the
> >     VM. Userspace is not obliged to honour this, and if it does honour
> > @@ -6112,12 +6116,18 @@ Valid values for 'type' are:
> >     has requested a crash condition maintenance. Userspace can choose
> >     to ignore the request, or to gather VM memory core dump and/or
> >     reset/shutdown of the VM.
> > + - KVM_SYSTEM_EVENT_SEV_TERM -- an AMD SEV guest requested termination.
> > +   The guest physical address of the guest's GHCB is stored in `data[0]`.
> > 
> >  Valid flags are:
> > 
> >   - KVM_SYSTEM_EVENT_RESET_FLAG_PSCI_RESET2 (arm64 only) -- the guest issued
> >     a SYSTEM_RESET2 call according to v1.1 of the PSCI specification.
> > 
> > +Extra data for this event is stored in the `data[]` array, up to index
> > +`ndata-1` included, if bit 31 is set in `type`.  The data depends on the
> > +`type` field.  There is no extra data if bit 31 is clear or `ndata` is zero.
> > +
> 
> This has the potential to break userspace as it expects a strict match
> on the whole of 'type', and does not expect to treat it as a bitfield.
> 
> Case in point, QEMU:
> 
> accel/kvm/kvm-all.c::kvm_cpu_exec()
> 
>         case KVM_EXIT_SYSTEM_EVENT:
>             switch (run->system_event.type) {
> 
> CrosVM and kvmtool have similar constructs, and will break as soon as
> KVM_SYSTEM_EVENT_NDATA_VALID is or'ed into 'type'.

Yeah, if we go this route, we'd have to make sure to document that only new types
can use the flag.
