Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707C1575620
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbiGNUEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239294AbiGNUEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:04:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF04459B9;
        Thu, 14 Jul 2022 13:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D0ZF7bGNwfXPpVkRJhiYEDl+fP+Itn4qvemvT7DOAp4=; b=idX7TS06FJtsC5q6fNjIZU+8DK
        fi6wGmWNsiAkkNaggYUfUdC0UguPwCst7hxBnJ/hWt8KvFcsGCXCbcFYcTGEBymTyJ5FGx+l7OErV
        VcrCdXglRj1a971GrpKYVEUOl4mjuX76h695iteXLiusgSsijQQ0XN7fOVqtSafvEiDUKGb3d94c4
        o9aJU89jPXbzYd4tEF6tMWT/ohyqHiRiVMmNU2jbyoaZbYTQdVy4ndiBLzc66GjxvGzevvnkccQWR
        2o/Tv/M7YwT7HcQF7Qy4cxOl++uIeFgrmxrhywcKUWAaKLk6xcaYMgYrpCZaYoxwao/nfz85vBcSg
        4p0+1P0g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oC54Q-003vi2-Ij; Thu, 14 Jul 2022 20:04:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 322D0980185; Thu, 14 Jul 2022 22:04:20 +0200 (CEST)
Date:   Thu, 14 Jul 2022 22:04:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        pawan.kumar.gupta@linux.intel.com,
        antonio.gomez.iglesias@linux.intel.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/speculation: Add BHI_DIS support
Message-ID: <YtB2xJdsOHSJV7Py@worktop.programming.kicks-ass.net>
References: <20220714195236.9311-1-daniel.sneddon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714195236.9311-1-daniel.sneddon@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 12:52:35PM -0700, Daniel Sneddon wrote:
> Branch History Injection (BHI) attacks can be mitigated using the
> BHI_DIS_S indirect predictor control bit located in MSR_IA32_SPEC_CTRL
> register. Set BHI_DIS in MSR_IA32_SPC_CTRL to prevent predicted
> targets of indirect branches executed in CPL0, CPL1, or CPL2 from
> being selected based on branch history from branches executed in CPL3.
> Support for this feature is enumerated by CPUID.7.2.EDX[BHI_CTRL] (bit 4).

What actual hardware will have this?

> Users wanting BHI protection can specify spectre_v2=eibrs,bhi_dis to
> enable hardware BHI protections.  On platforms where BHI protections
> are not available in the hardware revert to eibrs,retpoline
> mitigations.

AFAICT this doesn't get auto-selected; how bad is performance for this
to not be so?
