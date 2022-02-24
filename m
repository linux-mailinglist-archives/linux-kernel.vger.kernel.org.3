Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1014C3704
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiBXUts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiBXUtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:49:46 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7350C1B4017
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:49:16 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso6688839pjj.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kt0DflJYNGoK/9k7KHNe9BslzuEs8T188OhlBRiK1gE=;
        b=cmEe97r96xtkl/ei/J5ZMsEk3uTurAHKHy6ai6xzTlvTUEDJuVM/q7kBHCTxr/bMiM
         kLQCjgrf18Yr1uOSbAwDcB9FEXHd8CqAN04oFPNTLfI3nwGP8vwFvtgyX+0faYamyOc7
         8v38sJO3C6W1+l0l1xUaAeJWxzQtBFZ/NIPM7rhIIClPVSgKhb5pnl7N8NkjmBBmJ30U
         R22CiSw085apSh5bPwPGw45h1luALlBk69vBYB2NpDJRWoMN4s7QuoUF7L241Cqvp3f8
         iRYMbDPEbyYtRmYLEBxMG76YsLzws9O5HEZEEFSMqoCWUMLlUreSPSxUmbSVfcKUwzFG
         /yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kt0DflJYNGoK/9k7KHNe9BslzuEs8T188OhlBRiK1gE=;
        b=MFw3WSRuuCspPp/JpAi5nojAOiOGubjybgbOLR/DBN7usWSAdF4tmo0OSxjwsji/Dj
         hQ2+/VcQV6wLMfso+NioBouO1g+nwBumZ//whAHUJAD9ZEYrdbY3/uWkVIcACDS4cQK0
         /sfortSMWrdANTWcuygtnHPfmbA2eyxF8sZ3dF5y4lsBBaLaslyNtMsI0E8qS8QTNDDo
         qLKey9vRiI57GcnGn4BD+2NZndjVFTCSLae0Saj9aSZ37HZgu/5dgOFoDJPnrn9LH2T2
         jb8WbgBn3a5E/XZx7h2PitJecc2lAdPHU61IFKBf/eVISIqTJiHpp0aN7ehuriK3enX3
         2JiQ==
X-Gm-Message-State: AOAM532WYD8lg65wYHesvjwluO4KrKN1DMpOCtIe6TFcUTD+EOHbFZ9X
        7IQ6uUHkfC9AixoEqHZWfUhz+w==
X-Google-Smtp-Source: ABdhPJykhkWzHmF5xPxrF3cs7RdPTBS0whzZQqBMgqNI2GDMMdwLpts974Jq8PWZMhItbYsml12Dcw==
X-Received: by 2002:a17:902:e2d1:b0:14f:a24a:e48e with SMTP id l17-20020a170902e2d100b0014fa24ae48emr4450113plc.48.1645735755715;
        Thu, 24 Feb 2022 12:49:15 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id o14-20020a056a001bce00b004def1931fbcsm349292pfw.63.2022.02.24.12.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:49:15 -0800 (PST)
Date:   Thu, 24 Feb 2022 20:49:09 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <like.xu.linux@gmail.com>
Subject: Re: [PATCH] KVM: x86: Reacquire kvm->srcu in vcpu_run() if exiting
 on pending signal
Message-ID: <YhfvRRa56qQR9w5K@google.com>
References: <20220224190609.3464071-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224190609.3464071-1-seanjc@google.com>
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

On Thu, Feb 24, 2022, Sean Christopherson wrote:
> Reacquire kvm->srcu in vcpu_run() before returning to the caller if srcu
> was dropped to handle pending work.  If the task receives a signal, KVM
> will exit without reacquiring kvm->srcu, resulting in an unbalanced
> unlock kvm_arch_vcpu_ioctl_run(), and eventually hung tasks.
> 
>  =====================================
>  WARNING: bad unlock balance detected!
>  5.17.0-rc3+ #749 Not tainted
>  -------------------------------------
>  CPU 0/KVM/1803 is trying to release lock (&kvm->srcu) at:
>  [<ffffffff81042a19>] kvm_arch_vcpu_ioctl_run+0x669/0x1f60
>  but there are no more locks to release!
> 
>  other info that might help us debug this:
>  1 lock held by CPU 0/KVM/1803:
>   #0: ffff88810489c0b0 (&vcpu->mutex){....}-{3:3}, at: kvm_vcpu_ioctl+0x77/0x690
> 
>  stack backtrace:
>  CPU: 7 PID: 1803 Comm: CPU 0/KVM Not tainted 5.17.0-rc3+ #749
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x34/0x44
>   lock_release+0x1b4/0x240
>   kvm_arch_vcpu_ioctl_run+0x680/0x1f60
>   kvm_vcpu_ioctl+0x279/0x690
>   __x64_sys_ioctl+0x83/0xb0
>   do_syscall_64+0x3b/0xc0
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>   </TASK>
>  INFO: task stable:2347 blocked for more than 120 seconds.
>        Not tainted 5.17.0-rc3+ #749
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>  task:stable          state:D stack:    0 pid: 2347 ppid:  2340 flags:0x00000000
>  Call Trace:
>   <TASK>
>   __schedule+0x328/0xa00
>   schedule+0x44/0xb0
>   schedule_timeout+0x26f/0x300
>   wait_for_completion+0x84/0xe0
>   __synchronize_srcu.part.0+0x7a/0xa0
>   kvm_swap_active_memslots+0x141/0x180
>   kvm_set_memslot+0x2f9/0x470
>   kvm_set_memory_region+0x29/0x40
>   kvm_vm_ioctl+0x2c3/0xd70
>   __x64_sys_ioctl+0x83/0xb0
>   do_syscall_64+0x3b/0xc0
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>   </TASK>
>  INFO: lockdep is turned off.

Ugh, the task hung is actually a different mess introduced by the same patch.
I suspect I'm hitting the one Like reported.

I'll get a fix posted shortly...
