Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB785642BB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 22:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiGBUip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 16:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGBUin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 16:38:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B531B6567
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 13:38:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5696361046
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C131C34114;
        Sat,  2 Jul 2022 20:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656794321;
        bh=pAkGP5Cg5E1df2IcZoJVD9X7N2JCAGNkvied0qjBj+4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m/RTjuQsBPJUmVuA0HXs7hT49OWs7nIYkxguZXH3UyeU35kXpDaqYF58yYmXk7AaL
         mqFcvlkBQfjlzYCbDlhDuP2mCbBC4ens4KAbG5SCHmofP0kW0dM8AW2Q5Dr4oZpXXZ
         BZ5EA6H8rks5T/sNBPeqssEuEf4Tq2b6oTNf4FI8=
Date:   Sat, 2 Jul 2022 13:38:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        elver@google.com, gregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, vschneid@redhat.com,
        Yury Norov <yury.norov@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 0/5] cpumask: Fix invalid uniprocessor assumptions
Message-Id: <20220702133840.943817a7694406a135bb48a9@linux-foundation.org>
In-Reply-To: <cover.1656777646.git.sander@svanheule.net>
References: <cover.1656777646.git.sander@svanheule.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  2 Jul 2022 18:08:23 +0200 Sander Vanheule <sander@svanheule.net> wrote:

> On uniprocessor builds, it is currently assumed that any cpumask will
> contain the single CPU: cpu0. This assumption is used to provide
> optimised implementations.
> 
> The current assumption also appears to be wrong, by ignoring the fact
> that users can provide empty cpumask-s. This can result in bugs as
> explained in [1].

It's a little unkind to send people off to some link to explain the
very core issue which this patchset addresses!  So I enhanced this
paragraph:

: The current assumption also appears to be wrong, by ignoring the fact that
: users can provide empty cpumasks.  This can result in bugs as explained in
: [1] - for_each_cpu() will run one iteration of the loop even when passed
: an empty cpumask.

> This series introduces some basic tests, and updates the optimisations
> for uniprocessor builds.
> 
> The x86 patch was written after the kernel test robot [2] ran into a
> failed build. I have tried to list the files potentially affected by the
> changes to cpumask.h, in an attempt to find any other cases that fail on
> !SMP. I've gone through some of the files manually, and ran a few cross
> builds, but nothing else popped up. I (build) checked about half of the
> potientally affected files, but I do not have the resources to do them
> all. I hope we can fix other issues if/when they pop up later.
> 
> [1] https://lore.kernel.org/all/20220530082552.46113-1-sander@svanheule.net/
> [2] https://lore.kernel.org/all/202206060858.wA0FOzRy-lkp@intel.com/

