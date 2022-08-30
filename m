Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E605A687C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiH3Qeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiH3Qes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:34:48 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960B8B56
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:34:46 -0700 (PDT)
Date:   Tue, 30 Aug 2022 12:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661877285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Hy+KFwBBKLmtUSa078qE49L3B7yFOyDVxa6QI1pOFY=;
        b=FEYouHdP++9VpIPAWybJugu43qI+bKmM/MnmSbFITd+HDrfTankOdy8g8nigQOkSYy65GV
        BQlo5FtTycWMCo3kvWf/ywoN+gELKmMPq+xmAWIcFBXdtEkTs8XvCUaG19cZ4OzRmKCFvv
        4kfv6SuR2A4V0p6K6s3JAgVsJ+8s70A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] lib/test_printf.c: Add ip6 tests
Message-ID: <20220830163441.q272do6lred23iqw@moria.home.lan>
References: <20220830003119.1793219-1-kent.overstreet@linux.dev>
 <20220830003119.1793219-2-kent.overstreet@linux.dev>
 <Yw1sKTOEs1Nrdb2S@google.com>
 <cac2eaf0-2a56-d750-3508-7b5ed03e1eb5@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cac2eaf0-2a56-d750-3508-7b5ed03e1eb5@rasmusvillemoes.dk>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 09:32:19AM +0200, Rasmus Villemoes wrote:
> On 30/08/2022 03.47, Sergey Senozhatsky wrote:
> > On (22/08/29 20:31), Kent Overstreet wrote:
> >> diff --git a/lib/test_printf.c b/lib/test_printf.c
> >> index 4bd15a593f..6a56dbf076 100644
> >> --- a/lib/test_printf.c
> >> +++ b/lib/test_printf.c
> >> @@ -18,6 +18,7 @@
> >>  #include <linux/dcache.h>
> >>  #include <linux/socket.h>
> >>  #include <linux/in.h>
> >> +#include <linux/in6.h>
> >>  
> >>  #include <linux/gfp.h>
> >>  #include <linux/mm.h>
> >> @@ -61,6 +62,9 @@ do_test(int bufsize, const char *expect, int elen,
> >>  		pr_warn("vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
> >>  			bufsize, fmt, ret, elen);
> >>  		return 1;
> >> +		pr_warn("vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d (%s != %s)\n",
> >> +			bufsize, fmt, ret, elen, test_buffer, expect);
> >> +		return 1;
> >>  	}
> > 
> > I assume you intended to replace first pr_warn() with the second one?
> 
> Probably, but that's not ok. The test framework does not trust
> vsnprintf(), especially not when it does not behave as expected. So I
> very much carefully do not treat the buffer as a nul-terminated string
> until I have verified that it does have a nul character (that's tested a
> few lines below), and then when I compare the buffer contents can I pass
> it as a %s argument. Also note how that test takes the 'we may be
> testing a truncated write' into consideration, by printing the expect
> string via %.*s.
> 
> tl;dr, please just remove that hunk.

Debugging code I meant to remove, whoops.
