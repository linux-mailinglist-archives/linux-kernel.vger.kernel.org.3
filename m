Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503B6540212
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343843AbiFGPEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244928AbiFGPEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:04:34 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805A76C0E9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:04:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id u18so15058721plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 08:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N/YUmVnmYsthzzaFQZZ4Bst/fMXvdLUPht7fpreWouI=;
        b=ZWsnbDvjYqPuMsq3/+SzQYIG6tiYq/zVkPHdiuBZZxSJwNB6JoW+oQCkbqtOWfN/c/
         2Qt1mQyJcugaeBuOnRYyZA5bWpw/0SrLKVwae6rOgTUQlrPmL05EESL+V/KdULhrdIhF
         0SnFsteseOP5yUfCP0gLNmvt1zj0cOaegcpNkGQ1L12PsATkjYKLkXJ/5gLf9R+zGnEg
         mvMLP8+fe1uip/BqwdoDBDHeXxhsu5gNSqW725GWVO4DbKrLz+BwuBBLvdJOJbMNv6cA
         iTwvAPI1GbU4ShwcLpoIMd4LwnmWAN+g0eCJb14FIr1Hv0G0yPAZ+xF4gWX7wBm7raOL
         3KmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N/YUmVnmYsthzzaFQZZ4Bst/fMXvdLUPht7fpreWouI=;
        b=rf9pqr545KFKkLWvW5RuRFnNQubNNg8Q9OD/oE40/4pB5D8fqmlYNws+NZ4dzX8mg2
         pzMjaPmgnobDH5WKnO31nz0PBj/6JaWfX4shmYXiVqzkV7DcWb0lMVKKPznlG/Gtj9Uz
         zwTFXzOJ95+BrP3Ei0pySrTZzQtfsNtTj4H5I++ESLrohLZQ4ziV72BltpBkGWU2zlwO
         gmTFYcWG9Kw8q5iPTO6O4mOgLpkPgCd2AoRoO3cyCyvaozNd5YmOia13/p6Vvh+pu/JD
         6kogg3qafKtRn2cplsHbr+cEaErgXzQMd7qYx0BeZbN/oMXx+YWziVJHAZ9Nwi1KYhkQ
         yeJA==
X-Gm-Message-State: AOAM532TJPWFZSw62xvlO2qshIODVlb0+E/sezWwsccMan2+fDYGEA+8
        dATB0FN6zfqLTv7RW++EU+a32Q==
X-Google-Smtp-Source: ABdhPJxg54fVmTgrN+w4bEorvIgskZph27oXJaV0Nn517UuJgkzofnAIF8b11bN77fiEAvhWptpJfQ==
X-Received: by 2002:a17:903:25c1:b0:167:93c0:ce04 with SMTP id jc1-20020a17090325c100b0016793c0ce04mr3884430plb.171.1654614271610;
        Tue, 07 Jun 2022 08:04:31 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902d59100b0016242b71e9fsm12577479plh.158.2022.06.07.08.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:04:30 -0700 (PDT)
Date:   Tue, 7 Jun 2022 15:04:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, Sasha Levin <sashal@kernel.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Leonardo Bras <leobras@redhat.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, chang.seok.bae@intel.com, luto@kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.16 07/28] x86/kvm/fpu: Limit guest
 user_xfeatures to supported bits of XCR0
Message-ID: <Yp9o+y0NcRW/0puA@google.com>
References: <20220301201344.18191-1-sashal@kernel.org>
 <20220301201344.18191-7-sashal@kernel.org>
 <5f2b7b93-d4c9-1d59-14df-6e8b2366ca8a@redhat.com>
 <YppVupW+IWsm7Osr@xz-m1.local>
 <2d9ba70b-ac18-a461-7a57-22df2c0165c6@redhat.com>
 <Yp5xSi6P3q187+A+@xz-m1.local>
 <9d336622-6964-454a-605f-1ca90b902836@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d336622-6964-454a-605f-1ca90b902836@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022, Paolo Bonzini wrote:
> On 6/6/22 23:27, Peter Xu wrote:
> > On Mon, Jun 06, 2022 at 06:18:12PM +0200, Paolo Bonzini wrote:
> > > > However there seems to be something missing at least to me, on why it'll
> > > > fail a migration from 5.15 (without this patch) to 5.18 (with this patch).
> > > > In my test case, user_xfeatures will be 0x7 (FP|SSE|YMM) if without this
> > > > patch, but 0x0 if with it.
> > > 
> > > What CPU model are you using for the VM?
> > 
> > I didn't specify it, assuming it's qemu64 with no extra parameters.
> 
> Ok, so indeed it lacks AVX and this patch can have an effect.
> 
> > > For example, if the source lacks this patch but the destination has it,
> > > the source will transmit YMM registers, but the destination will fail to
> > > set them if they are not available for the selected CPU model.
> > > 
> > > See the commit message: "As a bonus, it will also fail if userspace tries to
> > > set fpu features (with the KVM_SET_XSAVE ioctl) that are not compatible to
> > > the guest configuration.  Such features will never be returned by
> > > KVM_GET_XSAVE or KVM_GET_XSAVE2."
> > 
> > IIUC you meant we should have failed KVM_SET_XSAVE when they're not aligned
> > (probably by failing validate_user_xstate_header when checking against the
> > user_xfeatures on dest host). But that's probably not my case, because here
> > KVM_SET_XSAVE succeeded, it's just that the guest gets a double fault after
> > the precopy migration completes (or for postcopy when the switchover is
> > done).
> 
> Difficult to say what's happening without seeing at least the guest code
> around the double fault (above you said "fail a migration" and I thought
> that was a different scenario than the double fault), and possibly which was
> the first exception that contributed to the double fault.

Regardless of why the guest explodes in the way it does, is someone planning on
bisecting this (if necessary?) and sending a backport to v5.15?  There's another
bug report that is more than likely hitting the same bug.

https://lore.kernel.org/all/48353e0d-e771-8a97-21d4-c65ff3bc4192@sentex.net
