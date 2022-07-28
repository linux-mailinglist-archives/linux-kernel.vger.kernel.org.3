Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B1258448E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 19:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiG1RCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiG1RCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:02:07 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A884953D32
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:02:05 -0700 (PDT)
Received: from quatroqueijos (1.general.cascardo.us.vpn [10.172.70.58])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 47D25416EC;
        Thu, 28 Jul 2022 17:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1659027723;
        bh=eJFVXCtA/nJevHAQEgQ8T/YTuTveTIvqgwNCM/uhRKs=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=BjTP/uyZp7aD9rA17SRyJYGVEchnk5xL/j+S+UEUrkAosmZJbOOrAZ3S2UQc4YVBN
         s6soNx5Ch8N9eylVJCXhA9AMQMjZLE+MyF4RsCWO8sWkiUTTZdTcxvMKeSUGHSn+HH
         ffBuOhBEsqpWu5MqxgDPlAA3HyDjTo8sNkpbIfmlBo8ZG6ra+HRwAxJEVPjbWdexfz
         U60Wd9jauPD5vFpqvsBkvIdDeSRhhPVDnipCRaeSi2/A2T25QN2rHr5UpVPbmXg03R
         cjH240bdyfXBD/NTpzhPk2EUa88d+3MUG38BWrDmwHMd75FIcTxWv3qtL6ER0aCGL7
         R/YcbCIcl0q7Q==
Date:   Thu, 28 Jul 2022 14:01:57 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/bugs: Do not enable IBPB at firmware entry when IBPB
 is not available
Message-ID: <YuLBBe2BXrC7CNiu@quatroqueijos>
References: <20220728122602.2500509-1-cascardo@canonical.com>
 <YuKCpLOLeDOI7GII@zn.tnic>
 <CADWks+aosM99jv9WwLvFo3LPEnsqts+2bJPzMnRqJX70qz51cg@mail.gmail.com>
 <YuKoxyUdAWsTfKez@zn.tnic>
 <YuKwLnYlzC0R8xrF@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuKwLnYlzC0R8xrF@zn.tnic>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 05:50:06PM +0200, Borislav Petkov wrote:
> + Cooper to sanity-check me.
> 
> On Thu, Jul 28, 2022 at 05:18:31PM +0200, Borislav Petkov wrote:
> > On Thu, Jul 28, 2022 at 03:33:35PM +0100, Dimitri John Ledkov wrote:
> > > Azure public cloud (so it is Azure custom hyper-v hypervisor) these
> > > instance types https://docs.microsoft.com/en-us/azure/virtual-machines/dav4-dasv4-series
> > 
> > Thank you both for the info.
> > 
> > Virt is an awful piece of sh*t when it goes and emulates all kinds of
> > imaginary CPUs. And AMD machine *without* an IBPB which is affected by
> > retbleed. Well, f*ck that.
> > 
> > Does that say somewhere on azure that those guests need to even enable
> > the mitigation or does the HV mitigate it for them?
> > 
> > Because I wouldn't mind to simply disable the mitigation when on a
> > hypervisor which doesn't support IBPB.
> 
> So for 5.19 we probably should take the one-liner just so that we
> release with all known issues fixed.
> 
> Going forward, I'm thinking all that FW-mitigation selection should go
> into a function called something like firmware_select_mitigations()
> which gets called at the end of check_bugs(), after all mitigation
> selectors have run.
> 
> And in there, the first check should be if X86_FEATURE_HYPERVISOR and if
> set, not set any mitigations for firmware calls.
> 
> Because, frankly, is there any point in protecting against firmware
> calls in the guest? The guest firmware is part of the hypervisor which
> gets supplied by the guest owner or cloud provider or so.
> 
> In the former case you probably don't need protection and in the latter,
> you don't have a choice.
> 
> But I'm unclear on the fw-in-the-guest thing - I'm sure Andy has a
> better idea...
> 

I may be completely wrong here, so excuse me throwing out this idea.

But isn't it also possible that userspace attacks the kernel by leveraging
speculative execution when in firmware? So even when firmware is trusted, it
might not have mitigations like retpoline and rethunks. So userspace will train
the BTB in order to make a RET in the firmware speculate to a firmware gadget
that may spill out kernel bits to the cache.

Even though there is some limited mapping when doing the firmware calls, there
are still some kernel pages mapped.

Cascardo.

> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
