Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1633B58D161
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 02:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244668AbiHIAcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 20:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbiHIAci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 20:32:38 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5A019C13
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 17:32:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id z187so9449645pfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 17:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=+HUkPvuuOTk15ciD228fegwLapHu71WyDv7F8CnSYGY=;
        b=VyTvIIKo32Ts14uZj4gGJQgFNn6PxunBV0AToi9VGIWi7EL6AdRczj8mEy6bWULths
         flHjCXT75SfRoJUeLfyEBmwFOSurufSgfe2FC9XVzvvv8+xfCpTqG1Rup+IKt8iikJX6
         nFSgMEsAbGOy0pdnVq+6hM9WWfTyL+sUhnUxBwukd0qGXf/U6HNxF34IPWQBs1VJKxEI
         bcgBNhWQ0+OAkk70nzQIroovFAeCtwm6MQcloyL4wFvYMrpY2O6F+krn0g5XEAjIFVzk
         Al5GB6yvEq710fqPAaCrQU9L3wsfrRj9TuQOY08QIjZ0Jn0IZu4a10Qaeaxbsbps2hd0
         w/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=+HUkPvuuOTk15ciD228fegwLapHu71WyDv7F8CnSYGY=;
        b=dyhRBVeLyvibCJrn7dEN0UjKbs0hW+c/i7vhog2mn8BrzIAuhza6zRScL4rj39TpXt
         lve39VPAG1j0rB494o7Ed3bzDnYsM/u9K7mKAF3ho7VqWa1Wwj7SZgd1TMElcDk58WpA
         gcTM0mYqlXEL5MmadOnsE9gsq3M+zMQC/kV4J6Ka+Qj12ckVAgbd+sPIxJ6w3gpybKOW
         RhXRD8Xjbo9qbTrx2JECKc9Izv69htuzlHf1kd55822888UU619k1877lt+eWxicpOb6
         5O4thNThcBOkLmtEvHFFr5adl0i9yCuoAmzeuApG4HiMkkW7lZyEGRw7Yzwqtaat5wSH
         g9Xg==
X-Gm-Message-State: ACgBeo131LSb6rMSLj4RVDnL2p3tZImJSNCja1JFnaj9juqcm7PH41u6
        ZFbgx3TIQ+8l1eZVq1pUtId6GQ==
X-Google-Smtp-Source: AA6agR7jgM8JWZBNu1rsmqJnQn/jphTPiG4ismAXtRvvJsZ/fP8mhLlgJgwJ7VMAi8Mw3Z2KTh1qtw==
X-Received: by 2002:aa7:8d04:0:b0:52e:1778:bcde with SMTP id j4-20020aa78d04000000b0052e1778bcdemr21125368pfe.58.1660005157295;
        Mon, 08 Aug 2022 17:32:37 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id y3-20020aa793c3000000b005289fad1bbesm9539394pff.94.2022.08.08.17.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 17:32:36 -0700 (PDT)
Date:   Tue, 9 Aug 2022 00:32:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Coleman Dietsch <dietschc@csp.edu>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Pavel Skripkin <paskripkin@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        stable@vger.kernel.org,
        syzbot+e54f930ed78eb0f85281@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/2] KVM: x86/xen: Initialize Xen timer only once
Message-ID: <YvGrIRlJThFoLPsb@google.com>
References: <20220808190607.323899-2-dietschc@csp.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808190607.323899-2-dietschc@csp.edu>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022, Coleman Dietsch wrote:
> Add a check for existing xen timers before initializing a new one.
> 
> Currently kvm_xen_init_timer() is called on every
> KVM_XEN_VCPU_ATTR_TYPE_TIMER, which is causing the following ODEBUG
> crash when vcpu->arch.xen.timer is already set.
> 
> ODEBUG: init active (active state 0)
> object type: hrtimer hint: xen_timer_callbac0
> RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:502
> Call Trace:
> __debug_object_init
> debug_hrtimer_init
> debug_init
> hrtimer_init
> kvm_xen_init_timer
> kvm_xen_vcpu_set_attr
> kvm_arch_vcpu_ioctl
> kvm_vcpu_ioctl
> vfs_ioctl
> 
> Fixes: 536395260582 ("KVM: x86/xen: handle PV timers oneshot mode")
> Cc: stable@vger.kernel.org
> Link: https://syzkaller.appspot.com/bug?id=8234a9dfd3aafbf092cc5a7cd9842e3ebc45fc42
> Reported-by: syzbot+e54f930ed78eb0f85281@syzkaller.appspotmail.com
> Signed-off-by: Coleman Dietsch <dietschc@csp.edu>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
