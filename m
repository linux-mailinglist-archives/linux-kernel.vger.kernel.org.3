Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0A652865E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbiEPODg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237279AbiEPODd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:03:33 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FE539170
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:03:32 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id j6so14087017pfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z2ZfS+9I/wy5JN0Sq7cHmJHxuA7sRrJdvs6Dlp91gDo=;
        b=gBL9REUt+JUXaQa8pxDv1sRIJQFSQTUfql9JI+c9aQj6dJqthI27vp5ESB4Ck90e4n
         sAAaCcF/IW8soholXn8GLNigLp7AoHvBksA/pIkTX6b8CxuSaU7Hvk2TPSS4hprgic5m
         2dew7nuz4aXhZ9HbqUgiT6Np2s6BfB2z5dH7aBAIh2vk3d3QYuFDcbWqpEAqmvQjC4LM
         o5xOOaOLKz4A2OwLYMcUmR9A8s+sWYNbBRDDjELF0WFnubC4o8gb4kga9LnoJZ5R9YK4
         X6mZWixuwrNdiGn6VvpkjmVhmCnctpWe+Ed+7oTq8ywN1CkqEormhLpjn1N0YL2mawZ8
         mYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z2ZfS+9I/wy5JN0Sq7cHmJHxuA7sRrJdvs6Dlp91gDo=;
        b=Nti96XJN2WLG09jjWbeAl5SBKtXeZ4KgIIvUuQ1IKwNucVhMXz839dt/tHvqrAlkRp
         oP9aXSv4pmcBhLfqA/eICXS3WU75FC3FUd3vxs32Bz4H4sJoLXpZnIQc3yvHjVeRt0yH
         lESc82DGc0phDCQ184ISqOaKol9tvJblkwXOHo8YMQDfkyFLCfmf0ICebEYsKEPH8Lw8
         90wS8ppRzLaElB0WQaEPa/4ldV9QfX9lcrKR+hm80AQemferYlwRU+jLFM52O12BcSF4
         z+DDOwr3RCEa9vMuZsIhBdW/dbgKX8hwDakSwK6b1FTKqbigo0pwJYKSOS8mOlbhSzye
         VhYg==
X-Gm-Message-State: AOAM5323PwkmYcAWRKEUazfdWBtz9UpcE+OLiqFiee4mdiw8Fm2MeUnD
        ldGYmPTeDnaDESusm4SP6IWKwA==
X-Google-Smtp-Source: ABdhPJy2NKfocT0FlvBFbTqqn7/P9nwZ7had2nn7lhxLdZ4ljNIiqZN3BfYR70FMmWIwNiXkahbCbg==
X-Received: by 2002:a63:534b:0:b0:3db:aa8f:ff1e with SMTP id t11-20020a63534b000000b003dbaa8fff1emr12358168pgl.570.1652709811941;
        Mon, 16 May 2022 07:03:31 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b1-20020a056a000a8100b0050dc76281c1sm6929535pfl.155.2022.05.16.07.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 07:03:31 -0700 (PDT)
Date:   Mon, 16 May 2022 14:03:28 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] KVM: x86: fix a typo in __try_cmpxchg_user that caused
 cmpxchg to be not atomic
Message-ID: <YoJZsJvq3YQ4xTWN@google.com>
References: <20220202004945.2540433-5-seanjc@google.com>
 <20220512101420.306759-1-mlevitsk@redhat.com>
 <87e16c11-d57b-92cd-c10b-21d855f475ef@redhat.com>
 <Yn17urxf7vprODed@google.com>
 <f05dcf66ed2bfb7d113ce0d9a261569959265c68.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f05dcf66ed2bfb7d113ce0d9a261569959265c68.camel@redhat.com>
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

On Mon, May 16, 2022, Maxim Levitsky wrote:
> On Thu, 2022-05-12 at 21:27 +0000, Sean Christopherson wrote:
> > On Thu, May 12, 2022, Paolo Bonzini wrote:
> > > On 5/12/22 12:14, Maxim Levitsky wrote:
> > > > Yes, this is the root cause of the TDP mmu leak I was doing debug of in the last week.
> > > > Non working cmpxchg on which TDP mmu relies makes it install two differnt shadow pages
> > > > under same spte.
> > > 
> > > Awesome!  And queued, thanks.
> > 
> > If you haven't done so already, can you add 
> > 
> >   Cc: stable@vger.kernel.org
> 
> When I posted my patch, I checked that the patch didn't reach mainline yet,
> so I assumed that it won't be in -stable either yet, although it was CCed there.

Yeah, it should hit stable trees because of the explicit stable@.  The Fixes: on
this patch is likely enough, but no harm in being paranoid.

> > Also, given that we have concrete proof that not honoring atomic accesses can have
> > dire consequences for the guest, what about adding a capability to turn the emul_write
> > path into an emulation error?
> > 
> 
> 
> This is a good idea. It might though break some guests - I did see that
> warning few times, that is why I wasn't alert by the fact that it started
> showing up more often.

It mostly shows up in KUT, one of the tests deliberately triggers the scenario.
But yeah, there's definitely potential for breakage.  Not sure if a capability or
debug oriented module param would be best.  In theory, userspace could do a better
job of emulating the atomic access than KVM, which makes me lean toward a capability,
but practically speaking I doubt a userspace will ever do anything besides
terminate the guest.
