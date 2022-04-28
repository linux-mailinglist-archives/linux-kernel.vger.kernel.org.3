Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F206513B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350568AbiD1Rqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbiD1Rqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:46:37 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0133B9F32
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:43:21 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r83so4574491pgr.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ULrmvXorhF3cY5GO7cnoA9I6iqq/Ra5FdhJ8iDTEuCo=;
        b=tASfAHylTnQAEFgGkHvPXmf/5ep74SGvwpRhqfCrDYNXFpSQwkDXB+pHd35rcdEwzg
         jXMWzSGkBXAgnHn1plmoTIH6tNP9HKJwaEP3UO+NkAT4BHkOC6SyDl9w7B2rzFtt+Nrm
         RIDaX3iSS1xNQwpQQo6j+Dy2mTfO9l/CDB9yH1EkakIBRXG5h3BYSlsmKhURBKZ2sITA
         5DjPoBFOqLH/9laJ3rzTowL09sxsOZiFrEv5ZfbB4ml1UpZ5/jyDK+qHo9OqxElcmVoU
         oKsiG3xnwOMxujGx1r4YCP1ltTCRBDupgyWiWYRenWIuguX7haVHBwz9UE4LAf6CIavA
         SBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ULrmvXorhF3cY5GO7cnoA9I6iqq/Ra5FdhJ8iDTEuCo=;
        b=yvWL/zR82ThYlrDV53P9ZqIMi0Rw1T2GZ0AlsWLr09br9TabwU59iQlzFehzsAU6gT
         VTch6zc/a8v1KP6j19l8Nq2RlctqeNlQLzImvuTmXX7zNuBR3mjcyWTonq+vUai1Z5CA
         eLQ6g6xsbjRXnK9pCmZ52y4/242sso5woqC9hN2ZfrHct5l251YstcCRSB7Qm/tIn33j
         OvLZvXnc96yzMTOPBnTCR+n2yRTlCD9URD0O7GX8gE5TEllolVlYBCqgterpqw7I+EeR
         po9j6Too46/0VHtASUMLpL4UxjCY2TUUicq9OGtfiJz54PtvlK+7u+W/yiuf7s4v5seE
         eqvw==
X-Gm-Message-State: AOAM533twPNMQjwkly3+3Qbi1E3NvMujCxBrwGXOokLsRDX4PB66j4sc
        Wp60gJ/oT5LMuHFd6gS2byiR1g==
X-Google-Smtp-Source: ABdhPJxwIojrIGKDQ+C6+iuYLgmV54t2ugrEy4aRWi9wdd2k+bXFXpBRSyhdEt03jrbglriUV5mM4w==
X-Received: by 2002:a63:2c0c:0:b0:3c1:a611:7ac1 with SMTP id s12-20020a632c0c000000b003c1a6117ac1mr146215pgs.485.1651167801061;
        Thu, 28 Apr 2022 10:43:21 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p1-20020a62b801000000b0050d5fc2cb7esm452741pfe.1.2022.04.28.10.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 10:43:20 -0700 (PDT)
Date:   Thu, 28 Apr 2022 17:43:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        syzbot <syzbot+a8ad3ee1525a0c4b40ec@syzkaller.appspotmail.com>,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        jmattson@google.com, joro@8bytes.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Subject: Re: [syzbot] WARNING in kvm_mmu_uninit_tdp_mmu (2)
Message-ID: <YmrSNB83b5sKLocw@google.com>
References: <00000000000082452505dd503126@google.com>
 <13b3235ef66f22475fd4059df95ad0144548ccd1.camel@redhat.com>
 <YmqzoFqdmH1WuPv0@google.com>
 <d1e4eaba-2dcd-ec08-4e23-98ab8ea6c37b@redhat.com>
 <47eb853424ef6c7dd6439ac33dfeb64a29f49c44.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47eb853424ef6c7dd6439ac33dfeb64a29f49c44.camel@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022, Maxim Levitsky wrote:
> On Thu, 2022-04-28 at 19:22 +0200, Paolo Bonzini wrote:
> > On 4/28/22 17:32, Sean Christopherson wrote:
> > > On Tue, Apr 26, 2022, Maxim Levitsky wrote:
> > > > I can reproduce this in a VM, by running and CTRL+C'in my ipi_stress test,
> > > 
> > > Can you post your ipi_stress test?  I'm curious to see if I can repro, and also
> > > very curious as to what might be unique about your test.  I haven't been able to
> > > repro the syzbot test, nor have I been able to repro by killing VMs/tests.
> > 
> > Did you test with CONFIG_PREEMPT=y?
> 
> yes, I test with CONFIG_PREEMPT but I only enabled it a day ago,
> I think I had seen this warning before, but could bit, I'll check
> if that fails without CONFIG_PREEMPT as well.

I have not tested with CONFIG_PREEMPT.  For some unknown reason the syzbot configs
don't play nice with my VM setup and so I never use them verbatim.  I didn't think
to pull over CONFIG_PREEMPTY.  I'll give that a shot.
