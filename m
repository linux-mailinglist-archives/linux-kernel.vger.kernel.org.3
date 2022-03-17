Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972DC4DCD2C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbiCQSIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiCQSIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:08:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF10F21C723
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:07:01 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647540419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DKtLreFNfDkaVIzxRPztqpk0QQ8I0r7dODIntaDjqI8=;
        b=NkfdkERP5tikDAlUI0lmmfPaPiGUo+EC2RATlGoqJKO+uzzxbCLTMzswCIhkoZ6pb0TDxd
        QMGVqB5i990bBDVMAR8oXfWH0+6taOiOnmN3BHLy95yt+QHJZm7QHxtO9ufOQcUMRfdM7O
        V4WEB3+p199m9r2imEc6wTdAX1ACqkJE5C7bxdGJfSNgMMGcdFTDXGD9iREIYJdcZuZ7Ih
        v2CD6fHzSubvXYDFatFO3M6tVPzDOmAgxtKDEv2XeilcWjue8lnfXxUtQE0xhfpLxvgh9o
        oswQi5/CKDTDv/1Mk44Gro2EQg6LBiHAm2SfIOBAIJ00MYY4GDX24oAaAOdF5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647540419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DKtLreFNfDkaVIzxRPztqpk0QQ8I0r7dODIntaDjqI8=;
        b=/CTg0XareM9Adjxh9wZQFDKM97X4dp7EbFNeLx1CQaw9RNGZmDmkg4vNL2GqdyBRbJMgQ/
        dQg2KKC8eJLdaWAw==
To:     Pavel Machek <pavel@denx.de>, Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v2 1/2] x86/split_lock: Make life miserable for split
 lockers
In-Reply-To: <20220317111305.GB2237@amd>
References: <20220217012721.9694-1-tony.luck@intel.com>
 <20220310204854.31752-1-tony.luck@intel.com>
 <20220310204854.31752-2-tony.luck@intel.com> <20220317111305.GB2237@amd>
Date:   Thu, 17 Mar 2022 19:06:58 +0100
Message-ID: <87fsngcv25.ffs@tglx>
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

On Thu, Mar 17 2022 at 12:13, Pavel Machek wrote:
>> In https://lore.kernel.org/all/87y22uujkm.ffs@tglx/ Thomas
>> said:
>> 
>>   Its's simply wishful thinking that stuff gets fixed because of a
>>   WARN_ONCE(). This has never worked. The only thing which works is to
>>   make stuff fail hard or slow it down in a way which makes it annoying
>>   enough to users to complain.
>> 
>> He was talking about WBINVD. But it made me think about how we
>> use the split lock detection feature in Linux.
>> 
>> Existing code has three options for applications:
>> 1) Don't enable split lock detection (allow arbitrary split locks)
>> 2) Warn once when a process uses split lock, but let the process
>>    keep running with split lock detection disabled
>> 3) Kill process that use split locks
>
> I'm not sure what split locks are, and if you want applications to
> stop doing that maybe documentation would help.

Split locks are lock prefixed operations which cross a cache line
boundary. The way how they are implemented is taking the bus lock, which
is the largest serialization hammer.

Bus locks are also triggered by lock prefixed operations on uncached
memory and on MMIO.

> Anyway, you can't really introduce regressions to userspace to "get
> stuff fixed" in applications.

Split locks can be triggered by unpriviledged user space and can be used
to run a local DoS attack. A very effective DoS to be clear.

We have no indication whether a process is malicious or just doing
stupid things. The only reason to not kill the offending process
instantly is that there can be legacy binary only executables which
trigger that due to stupidity.

But that opens up DoS at the same time. So the only way to "protect"
against that is to slow down the freqeuncy of buslocks unconditionally.
If you don't like that after analysing the situation you can turn split
lock detection off.

The only binary I've seen so far triggering this, is some stoneage "value
add" blob from HP which is also doing totally nuts other things.

Thanks,

        tglx
