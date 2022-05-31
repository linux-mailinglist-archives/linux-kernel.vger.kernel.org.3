Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9586539363
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 16:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345353AbiEaOxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 10:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345345AbiEaOxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 10:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1A6311C1F
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 07:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654008791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CosQOXhpUwW4qBTygKC8TqaJAP5LsJrbCYmmeiens3A=;
        b=OcGd8VOmuNIV5iXbeOwzUw1D7cSOavhD7ZhzF1LrH0VWCbaR+X+7UEBZQM8JQ6j7vqYYiy
        Rm3+IhOaT9gFvng39fwoOA33r1lbo3YBeYfr9+pH2rz7u+vyUpSwoNz8vsCB/JtAprgl7Q
        p2ztnEwhe4F3aavCSuIY1+cQ0ylmrbQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232--dEKEocINVOxISVNyewSjA-1; Tue, 31 May 2022 10:53:09 -0400
X-MC-Unique: -dEKEocINVOxISVNyewSjA-1
Received: by mail-pj1-f72.google.com with SMTP id 92-20020a17090a09e500b001d917022847so8179690pjo.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 07:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CosQOXhpUwW4qBTygKC8TqaJAP5LsJrbCYmmeiens3A=;
        b=u006oM3O4wUebQ74JAsdwFO5L31bW3hdzGPV3mSTEaCK6xebQxtqpzmMhb1DnHZrWM
         +V/2DICcjZbWDEirnzq5kIWF5P3k5/yjLvFFnKw23m+vFgExv1uNN2xTk79vNWgECYzM
         htIdmftqsouibiUthoKJaX3q1Fjvii9rZ+HWra9I5Orr9kunYtv9OkHdrL6vLdm4Wzm9
         obtPXl/0a5uvDZ30Uls2KWimvBzELND+2qfUjGxsRcdo64Ujdz3ASta5CtnM8Xs33m2Q
         OO2K2lguYuxYDwv6nldrYI/15DgmiFY1Z+TIXFVZgTlpblVXVzpvjZd2U0r74JD4gLOx
         kDOA==
X-Gm-Message-State: AOAM532EYeJ+tqc5vhZRIZ17OfHzXVncVKUVoqVqlkwT4mwnWMRBUf3D
        VqairUQc09mEBG276ePRoV2cJmIAq7ge2AtD/LlW8pLRCQEmc5hDUD6TjSeU1MJoXPbLBTZVJAh
        98zGvqKzNM+i48wWfAP0Uk6GPXasPTZ5eG8HSSJWD
X-Received: by 2002:a17:902:ec8a:b0:161:7ca5:ece7 with SMTP id x10-20020a170902ec8a00b001617ca5ece7mr61794814plg.141.1654008788504;
        Tue, 31 May 2022 07:53:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHmcdc9Tpt0JfpNtczpvUBH8pZKWErDmglIEuDX5h0caL7y0qcpiAn9XHXZ8/Waiv9L3TrJgADoWegDE+HUy0=
X-Received: by 2002:a17:902:ec8a:b0:161:7ca5:ece7 with SMTP id
 x10-20020a170902ec8a00b001617ca5ece7mr61794784plg.141.1654008788172; Tue, 31
 May 2022 07:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <YpYaYK7a28DFT5Ne@hirez.programming.kicks-ass.net>
 <20220531140236.1435-1-jalliste@amazon.com> <YpYpxzt4rmG+LFy9@hirez.programming.kicks-ass.net>
In-Reply-To: <YpYpxzt4rmG+LFy9@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 31 May 2022 16:52:56 +0200
Message-ID: <CABgObfYYUNb_pEVA2xdUm_U39Wc1=AahJKDx2=9P+aK5=z202w@mail.gmail.com>
Subject: Re: ...\n
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jack Allister <jalliste@amazon.com>,
        Borislav Petkov <bp@alien8.de>, diapop@amazon.co.uk,
        "Anvin, H. Peter" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>,
        Metin Kaya <metikaya@amazon.co.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 4:45 PM Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, May 31, 2022 at 02:02:36PM +0000, Jack Allister wrote:
> > The reasoning behind this is that you may want to run a guest at a
> > lower CPU frequency for the purposes of trying to match performance
> > parity between a host of an older CPU type to a newer faster one.
>
> That's quite ludicrus. Also, then it should be the host enforcing the
> cpufreq, not the guest.

It is a weird usecase indeed, but actually it *is* enforced by the
host in Jack's patch.

On the other hand doing it by writing random MSRs, with no save and
load when the task is scheduled or migrated, will not fly outside
Amazon datacenters. The patch also has traces of the Amazon kernel and
doesn't apply upstream.

Paolo

