Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B642535163
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347395AbiEZP0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiEZP0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:26:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C975DF20
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:26:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC9091688;
        Thu, 26 May 2022 08:26:17 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.27.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55F523F66F;
        Thu, 26 May 2022 08:26:16 -0700 (PDT)
Date:   Thu, 26 May 2022 16:26:13 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        elver@google.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org
Subject: Re: [PATCH 7/7] context_tracking: Always inline empty stubs
Message-ID: <Yo+cFQkX9fVTOmrv@FVFF77S0Q05N.cambridge.arm.com>
References: <20220526105252.440440893@infradead.org>
 <20220526105958.134113388@infradead.org>
 <20220526150206.rqdiyouxmkdgm2jq@treble>
 <Yo+YfEWLiCVekG5l@FVFF77S0Q05N.cambridge.arm.com>
 <20220526151654.k3mxzp5so25we7y3@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526151654.k3mxzp5so25we7y3@treble>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 08:16:54AM -0700, Josh Poimboeuf wrote:
> On Thu, May 26, 2022 at 04:10:52PM +0100, Mark Rutland wrote:
> > On Thu, May 26, 2022 at 08:02:06AM -0700, Josh Poimboeuf wrote:
> > > On Thu, May 26, 2022 at 12:52:59PM +0200, Peter Zijlstra wrote:
> > > > Because GCC is seriously challenged..
> > > 
> > > Or are these CONFIG_DEBUG_SECTION_MISMATCH?
> > 
> > Does it matter?
> 
> Yes, because I believe the only thing this option is good for is
> creating a bunch of useless '__always_inline' patches:
> 
>   https://lore.kernel.org/all/7fad83ecde03540e65677959034315f8fbb3755e.1649434832.git.jpoimboe@redhat.com/

Sure, but as I said, there are other reasons why the compiler can generate code
in this way, even if that's unlikely. Without `__always_inline` we don't
actually have a guarantee of inlining, so those warning *is* legitimate, even
if 99.99% of the time the compiler doesn't decide to generate code in a silly
way.

Thanks,
Mark.
