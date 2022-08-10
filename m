Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0427058F421
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiHJWGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiHJWGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:06:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274966C106
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:06:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660169171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/hIPshU0EsW9aMzf1duqb+3/3CdS263Kxr8Wldx7RvQ=;
        b=YC5/5gk/89XiDB30z53bP1WRtsu9PPDrf7UMkiafkBcKgeBcvJLC/p/66UOZyAwGHK0Qsl
        QWrwsma98sSRIcUu0cNZKgDY7Ri+uJ1nXwATlsBySe7fTPxQYo3Pv8iA4E5OYpdU1dwsNy
        GM3nD3L9JU8LRaNzzcrZ3D1pU83+UZ3FVHcHWQY6oBJhHrcvG6fOVESbn0oZK2oEdwE62p
        avv5EdRh/Y0ImH79Z/oQRLkT+BoEkWp6/vjRm4ApsXiPKKX37yCkKR5y5OuVEkTLlqIaL7
        wd3/cuXH6kV7GSKdzSmcppQkJ99e6kIrkIS3XNgeRd4I4mSuA6T6M74/q5KYHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660169171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/hIPshU0EsW9aMzf1duqb+3/3CdS263Kxr8Wldx7RvQ=;
        b=gwnrze5uO+uiMdNm1kAq5/sSNZzGwR7+oas9q/GvokeevAhYo2teW7NYHX9YWpa437qnmJ
        yBqKGZcpGBFmCGBw==
To:     Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Gomez Iglesias, Antonio" <antonio.gomez.iglesias@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH] x86/apic: Don't disable x2APIC if locked
In-Reply-To: <341ea6e9-d8f3-ee7a-6794-67408abbf047@linux.intel.com>
References: <20220809234000.783284-1-daniel.sneddon@linux.intel.com>
 <d6ffb489-7024-ff74-bd2f-d1e06573bb82@intel.com>
 <238ea612-5a25-9323-b31f-0a14493db2f7@linux.intel.com>
 <d4bcb22e-224c-d256-cb93-3ff6ed89a7d0@intel.com>
 <341ea6e9-d8f3-ee7a-6794-67408abbf047@linux.intel.com>
Date:   Thu, 11 Aug 2022 00:06:10 +0200
Message-ID: <87r11nu52l.ffs@tglx>
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

On Wed, Aug 10 2022 at 12:40, Daniel Sneddon wrote:
> On 8/10/22 11:52, Dave Hansen wrote:
>> On 8/10/22 11:30, Daniel Sneddon wrote:
>>>> If it's going to be on one server CPU that's coming out in ten years,
>>>> then we can hold off.
>>> SPR will certainly be sooner than 10 years, and with distros running on LTS
>>> kernels, it is probably worth backporting.  Since this isn't a bug fix (not a sw
>>> bug anyway), is this something I can just CC stable or is there a better way to
>>> say "Yes, this is a new feature, BUT, you really want it anyway"?
>> 
>> It it going to be *forced* on those SPR system?  In other words, is it a
>> little BIOS switch that users can flip?  Is there any non-kernel
>> workaround if a user hits this, or is the entire burden of this going to
>> be foisted on the kernel?
> It won't be forced, BUT, certain features won't be available if the APIC isn't
> locked.  According to the documentation SGX and TDX won't be available if you
> don't lock the APIC.  So, yes, you don't have to fix it in the kernel, but you
> may lose access to features if you don't.
>> 
>> The worst case scenario would be if a user has managed to compile a
>> CONFIG_X86_X2APIC=n kernel and is happily running along until they get a
>> microcode update, reboot and can't boot any more.
> That _shouldn't_ happen as it is only on new hardware, so a ucode update
> _shouldn't_ cause a crash.

Only on new hardware? The lock mechanism has to be available on _all_
affected systems which support SGX. See

 https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/resources/intel-sgx-software-and-tcb-recovery-guidance.html

That means at some point in the future the locked x2APIC will be a
prerequisite for attestating a SGX enclave independent of SPR.

So this affects already deployed systems and we have to

  - backport the x2apic lock changes

  - provide proper diagnostics

  - make SGX and TDX depend on X2APIC support

There is not much we can do about an older kernel which fails to boot or
explodes once a BIOS update locks down X2APIC.

Thanks,

        tglx

