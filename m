Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9020C525190
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356110AbiELPrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356102AbiELPro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:47:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C6555232
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:47:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652370460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1x7wVfzZR5vEE+FzOQRh31T9dG7OXNeCql6dwGT6KVA=;
        b=K1SduvBv3uZ/V1FrjcMXk16KbVexETxHeLRlZ2UTXu4HELI3KNqQLnQFFJsr+ec+IaN3CW
        Ffg61w5mwVAvKTwvDbMMfS+IIGz+J2OzE6j5yqFwWmCYtJAVLMPZMWOPlA7ZeiBSg7O/NR
        +Zg5r6ms3XMUMmB8SReffeUtdOvdHomABr1KxRnt+cZdprn4SRxfKOnC8+T1tOl7oOZ6bn
        I48yJvAVZDTvNBThhuEEZhe0Pi1FMAjcnY1bq5tbxiMBsF2WIMbjJRTqn42I3RvbXTCXzM
        gfupJP9bUoezETeI9x3N4xdjSN6sSvOk7nqyMwvVG/KR84ecdgF6B/MNrH6oaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652370460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1x7wVfzZR5vEE+FzOQRh31T9dG7OXNeCql6dwGT6KVA=;
        b=v8Kx1Qby10c75oq1414JE1Dvc6mLAYDrZ26yaNx/EXBQ8gG+SckjDUjZTKC2lA6AdQdJAq
        XXcgV7AAhmE7KRCA==
To:     Sean Christopherson <seanjc@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] x86/reboot: Disable virtualization in an emergency
 if SVM is supported
In-Reply-To: <Yn0cCl+C+BE2yfPb@google.com>
References: <20220511234332.3654455-1-seanjc@google.com>
 <20220511234332.3654455-3-seanjc@google.com> <87tu9vvx19.ffs@tglx>
 <Yn0cCl+C+BE2yfPb@google.com>
Date:   Thu, 12 May 2022 17:47:40 +0200
Message-ID: <87mtfmvjkz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12 2022 at 14:39, Sean Christopherson wrote:
> What about leaving cpu_crash_disable_virtualization() inside the if-statement?
> It feels wierd to "disable" virtualization on the current CPU but ignore others,
> e.g. if there's some newfangled type of virtualization in the future, I would be
> quite surprised if only the CPU doing the transfer needed to disable virtualization.

No real preference, though you have the unconditional invocation already
in the crash code IIRC.

Thanks,

        tglx
