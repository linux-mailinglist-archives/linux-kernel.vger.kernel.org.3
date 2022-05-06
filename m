Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B1F51E15F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358144AbiEFVy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355238AbiEFVyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:54:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D268613E9A
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 14:50:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A75C611EE
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 21:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CB8C385A8;
        Fri,  6 May 2022 21:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651873825;
        bh=C1WgvDTrsdFQDpie7GvorQalkinTyCMq4IOsxxaE93s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0vA0cSnSY8xX+24xCc0Gk0rX2+exhkFMnIoLQ1DWP3FgTGSMzx0YzRbHFS8jLRVG
         HH8xcJ4lj7fg8p4fWH+3S8SuQbqTzvJmUrZmTN1BZVyLSLxjoLbX4S2c7hD22GY5Hb
         059JfWfLHnfbcEJBxgK6/fxglazs7y55jlaYqnuG/tpSNJY4l/k+r8RrDt/p3sJEGc
         zcansRzWIAHShUvhrwKs+8ezR4guqYk/AeQunHWS/Awlpg5Xoit+W463JYvLNVhOwm
         u4qw34cRe1HaFmnfuhw6bSRU118Mc14GJ+1YvHp/XrFV3xVSxw3sltOMgMDAE2B4Dk
         yPy/srrMTzVgg==
Date:   Fri, 6 May 2022 14:50:23 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, kbuild@lists.01.org, lkp@intel.com,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Subject: Re: uninitialized variables bugs
Message-ID: <YnWYHzQC4Y55sOsT@dev-arch.thelio-3990X>
References: <20220506091338.GE4031@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506091338.GE4031@kadam>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Fri, May 06, 2022 at 12:13:38PM +0300, Dan Carpenter wrote:
> Ever since commit 78a5255ffb6a ("Stop the ad-hoc games with
> -Wno-maybe-initialized"), GCC's uninitialized variable warnings have
> been disabled by default.  Now, you have to turn on W=1 or W=2 to see
> the warnings which nobody except Arnd does.

Thank you a lot for bringing this up; the situation does leave much to
be desired from my side, as I am having to fix quite a number of these
issues because people just are not seeing them and they break our builds
because of CONFIG_WERROR (as they should).

> Disabling that has lead to a bunch of embarrassing bugs where variables
> are *never* initialized.  Very unsubtle bugs.  The bugs doesn't reach
> users because Nathan Chancellor and I review Clang and Smatch warnings
> respectively.  Also the kbuild-bot reports uninitialized variables.

Thankfully, I believe the situation is a lot less worse than it could be
because the kbuild test robot tests with clang and finds these before
they make it into any tree:

https://lore.kernel.org/llvm/?q=f%3Alkp%40intel.com+Wuninitialized
https://lore.kernel.org/llvm/?q=f%3Alkp%40intel.com+Wsometimes-uninitialized

> It's a lot to deal with.  Uninitialized variable bugs are probably the
> most common bug I have to deal with.

Agreed.

> It's frustrating.  Sometimes the false positives are hard to analyse
> because I have to read through multiple functions.  A lot of times
> when I write a patch and a commit message Nathan has already fixed it
> so it's just a waste of time.

Sorry :( I should be better about either cc'ing you directly or adding
the kernel-janitors mailing list, as there are others who would benefit
from seeing these patches fly by. I know that isn't really the point of
the email but I'll try to make your life easier in the future.

> It's risky as well.  The Smatch check for uninitialized variables was
> broken for most of 2021.  Nathan sometimes goes on vacation.
> 
> I guess I would hope that one day we can turn on the GCC uninitialized
> variable warnings again.  That would mean silencing false positives
> which a lot of people don't want to do...  Maybe Clang has fewer false
> positives than GCC?

Yes, clang does have fewer false positives than GCC for a couple of
reasons:

1. As Arnd touched on, Clang's -Wuninitialized and
-Wsometimes-uninitialized do not check for initializations across
function boundaries. In your example below with 'read(&val)', clang will
assume that read() initializes val. While that does mean that there is
slightly less coverage, it does drives the false positive rate way down,
almost to zero. There are occasionally times where clang fails to figure
out certain conditions which will avoid an uninitialized use but I
believe that means the code is not as clear as it could be. For example,
commit 118de6106735 ("net: ethernet: rmnet: Restructure if checks to
avoid uninitialized warning").

2. clang used to only have these warnings under
-Wconditional-uninitialized, which suffers from the same issue as
-Wmaybe-uninitialized ("maybe it is uninitialized?").
-Wsometimes-uninitialized was split off from that warning back in 2011
to be more assertive ("this IS uninitialized if these conditions hold"):

https://github.com/llvm/llvm-project/commit/4323bf8e2e5135c49f814940b2b546298c01ecbc

Perhaps GCC could consider something to this?

Clang's static analyzer, which Tom regularly runs, will check variables
across function boundaries. I am not sure what the false positive rate
on that check is but it does turn up issues like smatch does.

> The Smatch check for uninitialized variable was deliberately written to
> be more strict than GCC because GCC was missing bugs.  So I think
> leaving Smatch false positives is fine.  There is a trade off between
> fewer false positives and missing bugs and Smatch is meant to err on the
> side of finding bugs but with the cost of false positives.

I would agree with this too.

Cheers,
Nathan
