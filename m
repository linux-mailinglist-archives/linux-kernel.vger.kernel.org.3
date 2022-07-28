Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5893858438E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiG1PuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiG1PuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:50:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297712642
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:50:18 -0700 (PDT)
Received: from zn.tnic (p57969665.dip0.t-ipconnect.de [87.150.150.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6B3DA1EC06A7;
        Thu, 28 Jul 2022 17:50:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659023412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XryKy09UuWtP8D8t3mI1EtihwsObFJOpejpf+3O7+6M=;
        b=N4atjYjSlxbOF970f9MDxwHhojViIeynh9Dl2VSqpOgL+/CYZAxHFs4Bq6csVhNq8/t9sT
        YMEgfe7Kg03FUPX48hjvuF6V2hbOFIwBBxpbWBoqkeWQHgrjnfX2nVLhjW15Rffh26XgrP
        bksM+hMcuIFae0xqM5mMfqmfZwHBE8I=
Date:   Thu, 28 Jul 2022 17:50:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/bugs: Do not enable IBPB at firmware entry when IBPB
 is not available
Message-ID: <YuKwLnYlzC0R8xrF@zn.tnic>
References: <20220728122602.2500509-1-cascardo@canonical.com>
 <YuKCpLOLeDOI7GII@zn.tnic>
 <CADWks+aosM99jv9WwLvFo3LPEnsqts+2bJPzMnRqJX70qz51cg@mail.gmail.com>
 <YuKoxyUdAWsTfKez@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YuKoxyUdAWsTfKez@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Cooper to sanity-check me.

On Thu, Jul 28, 2022 at 05:18:31PM +0200, Borislav Petkov wrote:
> On Thu, Jul 28, 2022 at 03:33:35PM +0100, Dimitri John Ledkov wrote:
> > Azure public cloud (so it is Azure custom hyper-v hypervisor) these
> > instance types https://docs.microsoft.com/en-us/azure/virtual-machines/dav4-dasv4-series
> 
> Thank you both for the info.
> 
> Virt is an awful piece of sh*t when it goes and emulates all kinds of
> imaginary CPUs. And AMD machine *without* an IBPB which is affected by
> retbleed. Well, f*ck that.
> 
> Does that say somewhere on azure that those guests need to even enable
> the mitigation or does the HV mitigate it for them?
> 
> Because I wouldn't mind to simply disable the mitigation when on a
> hypervisor which doesn't support IBPB.

So for 5.19 we probably should take the one-liner just so that we
release with all known issues fixed.

Going forward, I'm thinking all that FW-mitigation selection should go
into a function called something like firmware_select_mitigations()
which gets called at the end of check_bugs(), after all mitigation
selectors have run.

And in there, the first check should be if X86_FEATURE_HYPERVISOR and if
set, not set any mitigations for firmware calls.

Because, frankly, is there any point in protecting against firmware
calls in the guest? The guest firmware is part of the hypervisor which
gets supplied by the guest owner or cloud provider or so.

In the former case you probably don't need protection and in the latter,
you don't have a choice.

But I'm unclear on the fw-in-the-guest thing - I'm sure Andy has a
better idea...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
