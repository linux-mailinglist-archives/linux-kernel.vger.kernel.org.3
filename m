Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DCF5612CA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiF3Gzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiF3Gzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:55:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619A0326DE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:55:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1155021C17;
        Thu, 30 Jun 2022 06:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1656572133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=okYFeQHCpEqkIDhwEg2qpMDyzApIEQNLhlCs/1wRbT8=;
        b=IR4PmIpGWNfzHgXJeBDOJgxDGd2GV2hVt52Pr+5Oi2R3dRfjC60TkJdxm8EdAm0YDA9n1T
        e6t5FqpjyCHUsB0BxCG3IUIFuR2e9HBWVrnqYU9vuPlWAOJziwlvXc88359angqNk6Ip+E
        3sAadl12d8N4HMmarUk5bvnsJ6EwcJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1656572133;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=okYFeQHCpEqkIDhwEg2qpMDyzApIEQNLhlCs/1wRbT8=;
        b=EQAdbyOGd9xMJFKrx8gvnMBF/SL6fFGcf3+4IiqJpDIuJCh/ZtD0B7mR87q/JhX7zfLEwn
        SZpTY1eWQ1KI2+CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEFB8139E9;
        Thu, 30 Jun 2022 06:55:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GBWkOORIvWLeIwAAMHmgww
        (envelope-from <iivanov@suse.de>); Thu, 30 Jun 2022 06:55:32 +0000
Date:   Thu, 30 Jun 2022 09:55:32 +0300
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: Add initial set of stack unwinder self tests
Message-ID: <20220630065532.i3alwmaenkooiwxw@suse>
References: <20220624141000.88120-1-iivanov@suse.de>
 <20220624141000.88120-2-iivanov@suse.de>
 <Yrx2xwbYMfcl8Qok@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrx2xwbYMfcl8Qok@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06-29 16:59, Mark Brown wrote:
> 
> On Fri, Jun 24, 2022 at 05:10:00PM +0300, Ivan T. Ivanov wrote:
> > Add kunit tests for obvious cases where stack unwind could be needed.
> > Like these:
> > 
> >  * Unwind a separate task
> >  * Unwind starting from caller
> >  * Unwind from irq context
> >  * Unwind from kprobe handler called via ftrace
> >  * Unwind from ftrace handler
> >  * Unwind through kretprobed function
> >  * Unwind from kretprobe handler
> > 
> > Tests are completely based on code used in s390 unwinder tests.
> > Cases which where not relevant to aarch64 where removed and
> > some places where adjusted to address aarch64 specifics.
> 
> I think this would be a bit easier to digest if it were a series which
> builds things up with the test cases in individual patches, or at least
> things like ftrace and kprobes split out a bit more, rather than every
> single test all at once.  I've got a few *very* superficial comments
> below, I think the code is fine but there's several moving pieces to
> check.

Ok. I will split and resend.

> 
> > +/*
> > + * Calls test_arch_stack_walk() which is handy wrapper of aarch64 unwind
> > + * functionality, and verifies that the result contains unwindme_func2
> > + *followed by unwindme_func1.
> 
> Missing space.

Sure.

> 
> > +	ret = register_ftrace_function(fops);
> > +	if (!ret) {
> > +		ret = test_unwind_ftraced_func(u);
> > +		unregister_ftrace_function(fops);
> > +	} else {
> > +		kunit_err(current_test,
> > +			  "failed to register ftrace handler (%d)\n", ret);
> > +	}
> 
> Shouldn't we return an error here?

Error will be returned once we remove test_unwind_ftraced_func
address from ftrace filters.

Regards,
Ivan

