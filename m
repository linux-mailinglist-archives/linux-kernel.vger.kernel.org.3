Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229C04A8FD9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355017AbiBCV0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiBCV0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:26:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3973EC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 13:26:43 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643923601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9DFDS9JhyUF86Y41tLO6aP5mVOqGZdKQURwSy9dj+Ao=;
        b=yC3pwUXEODXUg6vvKZsNFbeKPVAoVeVHxOPN7HJx91yFHiWJOzLb7B3apJO447Ur0Of9m8
        YSsUa/E8QxlN6fZyrDoaaGjPK1pN9XGDJ0FzP4wGLLV011AotjaP26S4612nJEDSNAZUN6
        NX8KDLkWf+kRtl1drLF4VzUmshDAc8fBrqM7np7c7HzMAEosW1/qmuw/rfso9pVWIK3ZUX
        1etHrjAhpCBYNNucTqiSqtcHnAIQjYMTD+hlc+D2XJSevZezWwjApabk/OCEcmdvLKm8I3
        WU2M4HIbIi4BdD7EgNWJiLLkHD03n6H1ZDPCLzjmdMovbXPi7wlK7bnpV4Xdgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643923601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9DFDS9JhyUF86Y41tLO6aP5mVOqGZdKQURwSy9dj+Ao=;
        b=xEpOwKzFJfdIDz+7Qef81PAuAv9Q3M4teanY86CIhfw8RRcao7XOqRFWfsAs/8vlleaIuj
        v1goAXMMLPpKEUCg==
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, dave.hansen@intel.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        seanjc@google.com, tony.luck@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 19/29] x86/topology: Disable CPU online/offline
 control for TDX guests
In-Reply-To: <YfvuFADTO/f1UTG1@zn.tnic>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-20-kirill.shutemov@linux.intel.com>
 <87o83qw2m5.ffs@tglx> <87leyuw2ib.ffs@tglx> <YfvuFADTO/f1UTG1@zn.tnic>
Date:   Thu, 03 Feb 2022 22:26:41 +0100
Message-ID: <87wnibd4ku.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03 2022 at 16:00, Borislav Petkov wrote:
> On Wed, Feb 02, 2022 at 01:11:56AM +0100, Thomas Gleixner wrote:
>> On Wed, Feb 02 2022 at 01:09, Thomas Gleixner wrote:
>> 
>> > On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:
>> >>  static bool intel_cc_platform_has(enum cc_attr attr)
>> >>  {
>> >> -	if (attr == CC_ATTR_GUEST_UNROLL_STRING_IO)
>> >> +	switch (attr) {
>> >> +	case CC_ATTR_GUEST_UNROLL_STRING_IO:
>> >> +	case CC_ATTR_HOTPLUG_DISABLED:
>> 
>> Not that I care much, but I faintly remember that I suggested that in
>> one of the gazillion of threads.
>
> Right, and yeah, adding a separate attribute is ok too but we already
> have a hotplug disable method. Why can't this call
>
> 	cpu_hotplug_disable()
>
> on the TDX init path somewhere and have this be even simpler?

That's daft. I rather have this explicit control which makes it obvious
what's going on.

Thanks,

        tglx
