Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7D74BBE36
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbiBRRR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:17:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238508AbiBRRRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:17:01 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5552B8ADB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:16:03 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5650F1EC0304;
        Fri, 18 Feb 2022 18:15:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645204557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SwNBtYXWJ8xiYRb8tX389TEN1/KTpft305R1guyh4Rg=;
        b=HEND9/BS0oJ+LlJZKY72NIJltRz8k1VKVsnwXtG8WtQwT3M+tPyNBD+n0D2FIl6MOFucH8
        lCqIHoXJuQoRZSDukk2xSsnoWFOtWMVwQDeCDbmLAZy/APHak5P6PN3LisZ8Qw2JPj+3xu
        BzIEgPNmQUQSZTjoLmt4OvG8iuyjNxw=
Date:   Fri, 18 Feb 2022 18:16:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jue Wang <juew@google.com>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v2] x86/mce: work around an erratum on fast string copy
 instructions.
Message-ID: <Yg/UUHuVvd9AOJ94@zn.tnic>
References: <Yg54nse5qNQO3sbW@zn.tnic>
 <20220218013209.2436006-1-juew@google.com>
 <Yg+2Hc78nfSRmh/j@zn.tnic>
 <CAPcxDJ4c3eGXTB9UPJmZ8dzyCNPW4Lv9s1QSeoCWq_LdNWTrJw@mail.gmail.com>
 <Yg/FyrvLWhZHB/UC@zn.tnic>
 <CAPcxDJ72dMOpbKXxyb__OeMaEyjYSPtsL_ubVsKOuRXefAQ3_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPcxDJ72dMOpbKXxyb__OeMaEyjYSPtsL_ubVsKOuRXefAQ3_w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 08:21:36AM -0800, Jue Wang wrote:
> My concern was that here returns 0 instead the value read from the msr.

You'd walk into that code only if you're doing MCE injections. In that
case, it won't read or write MSR_IA32_MISC_ENABLE because the injection
code writes into the injection mce struct only.

So it won't disable fast strings when you manage to inject the exact
error type which triggers this erratum.

I think that's actually a good thing - you don't want to disable fast
strings just because you injected a particular MCE type.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
