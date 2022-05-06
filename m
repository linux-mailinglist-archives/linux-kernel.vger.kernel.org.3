Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90B851D503
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 11:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243727AbiEFJ5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 05:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236473AbiEFJ45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 05:56:57 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EDB67D28
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 02:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=urze1RM/gX18V878AZ6j/ivdQDVcYKjIqHZDW8Da1MA=;
  b=SFavKmlT8DEGi/9oCpAqWxugYXIgZwXkngrNq+97vEdi+coaSSh0yHPm
   Yw2auqqwRB25aoji3y1v03veYx/7frj0JPM2Xgd7EetJo8k288K+8NpSa
   XcgrCEvdcGj4/RXiPprKkK3JI0Oi0lHcR/Pf/ls2Dhq4vqYpJh2PrP0AL
   A=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,203,1647298800"; 
   d="scan'208";a="13371044"
Received: from 245.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.245])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 11:53:08 +0200
Date:   Fri, 6 May 2022 11:53:07 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Dan Carpenter <dan.carpenter@oracle.com>
cc:     ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        kbuild@lists.01.org, lkp@intel.com
Subject: Re: [Ksummit-discuss] uninitialized variables bugs
In-Reply-To: <20220506091338.GE4031@kadam>
Message-ID: <alpine.DEB.2.22.394.2205061150230.2845@hadrien>
References: <20220506091338.GE4031@kadam>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 May 2022, Dan Carpenter wrote:

> Ever since commit 78a5255ffb6a ("Stop the ad-hoc games with
> -Wno-maybe-initialized"), GCC's uninitialized variable warnings have
> been disabled by default.  Now, you have to turn on W=1 or W=2 to see
> the warnings which nobody except Arnd does.
>
> Disabling that has lead to a bunch of embarrassing bugs where variables
> are *never* initialized.  Very unsubtle bugs.  The bugs doesn't reach
> users because Nathan Chancellor and I review Clang and Smatch warnings
> respectively.  Also the kbuild-bot reports uninitialized variables.
>
> It's a lot to deal with.  Uninitialized variable bugs are probably the
> most common bug I have to deal with.
>
> It's frustrating.  Sometimes the false positives are hard to analyse
> because I have to read through multiple functions.  A lot of times
> when I write a patch and a commit message Nathan has already fixed it
> so it's just a waste of time.
>
> It's risky as well.  The Smatch check for uninitialized variables was
> broken for most of 2021.  Nathan sometimes goes on vacation.
>
> I guess I would hope that one day we can turn on the GCC uninitialized
> variable warnings again.  That would mean silencing false positives
> which a lot of people don't want to do...  Maybe Clang has fewer false
> positives than GCC?
>
> The Smatch check for uninitialized variable was deliberately written to
> be more strict than GCC because GCC was missing bugs.  So I think
> leaving Smatch false positives is fine.  There is a trade off between
> fewer false positives and missing bugs and Smatch is meant to err on the
> side of finding bugs but with the cost of false positives.
>
> Most of the Smatch uninitialized false positives are caused by loops:
>
> 	int i, ret;
>
> 	for (i = 0; i < bytes; i++) { // <-- what if bytes is zero?
> 		if (...)
> 			continue; // <-- can every iteration hit continue?
> 		ret = frob();
> 	}
>
> 	return ret;
>
> There is also stuff like this which is harmless:
>
> 	uint val;
>
> 	ret = read(&val);
> 	*p = val;  // <-- uninitialized variable if read() fails
> 	return ret;
>
> Btw, here is how to run Smatch on your code:
> https://staticthinking.wordpress.com/2022/04/25/how-to-run-smatch-on-your-code/

Could smatch inform the user that some results are likely false positives,
or even order the results according to their likely true positiveness?

julia
