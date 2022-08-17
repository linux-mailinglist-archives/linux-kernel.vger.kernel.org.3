Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3330596B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiHQIJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiHQIJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:09:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9714DB53
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:09:10 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9855329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9855:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 197031EC04F0;
        Wed, 17 Aug 2022 10:09:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660723745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qlPkcxRy4ZJb+EMBeXEPqEVOfMJIxW5z9MfZL5ESkDs=;
        b=YlGe+1PSvPXqohy4NdbITSwV/iRUBQyRgqReMEFKmizYBMlJZ0ov/p+bDscV6xaRMGf6TY
        IuBNJSn9IJ12ClrTiHD5lA5RU7T+WB7Kdy3EKoyvVm1Ajbc5IertnsfwOqwPI3W1xaXV81
        3VV+EBkGwqcgonfOhAyjwLwR15ldgpM=
Date:   Wed, 17 Aug 2022 10:09:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v3 3/5] x86/microcode: Avoid any chance of MCE's during
 microcode update
Message-ID: <YvyiHGMbp2MtV0Vr@zn.tnic>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-4-ashok.raj@intel.com>
 <Yvybq+hYT4tG/yAg@gmail.com>
 <Yvyfi9XC8bu0cOG+@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yvyfi9XC8bu0cOG+@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 09:58:03AM +0200, Ingo Molnar wrote:
> Also, Boris tells me that writing 0x0 to MSR_IA32_MCG_STATUS
> apparently shuts the platform down - which is not ideal...

Right, if you get an MCE raised while MCIP=0, the machine shuts down.

And frankly, I can't think of a good solution to this whole issue:

- with current hw, if you get an MCE and MCIP=0 -> shutdown

- in the future, even if you change the hardware to block MCEs from
being detected while the microcode update runs, what happens if a CPU
encounters a hw error during that update?

You raise it immediately after? What if there are multiple MCEs? Not
unheard of on a big machine...

Worse, what happens if there's a bitflip in the memory where the
to-be-updated microcode patch is?

You report the error afterwards?

Just thinking about this makes me real nervous.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
