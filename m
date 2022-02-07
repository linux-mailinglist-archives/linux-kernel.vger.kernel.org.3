Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6594AB670
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344568AbiBGIQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244831AbiBGIQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:16:33 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8616C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:16:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4B7AECE0EDB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B42C004E1;
        Mon,  7 Feb 2022 08:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644221787;
        bh=Kdxt9TG6w4mznLHfPVGseD6vMZkNjtF5T6/d0pfwnqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=oR/CVOljIOBGcSA1HZSzszU3jy5etyzW/C2sR8e6qItzw0s1DGNsrFmgDsY8Dq6AW
         SXvRTPOvoes2IKsG1ZFNYXApkr+k19WDWTz7qamlRjHETmS+GvqIrWW4K9+aZTB0U1
         uu0oFDRmnPUcuot6Rzl99A8xPKWOLojPxWaJlOgOz0LLndc7kvF/Ln1upevFaRB0K2
         dv2Ro/VK1Dok48c9CYaPtHuDOpUPQDqFwMDGcJ43JB9ax4wptBT402FqMXS+ZDrwpp
         rOskMr/ipInl9t3nGDmvgQUQ2fIUOj1vPKw47jUASAhUAaiUfgxGQ4045aN7lsjDQk
         sbfPa2tBO607g==
From:   SeongJae Park <sj@kernel.org>
To:     Pedro Gomes <pedrodemargomes@gmail.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Add option to monitor only writes
Date:   Mon,  7 Feb 2022 08:16:25 +0000
Message-Id: <20220207081625.3579-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CACpbsfZN2fExaTReJG1anDQjCd3i24_0wG-oU42dSHD5bAon7A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2022 12:11:44 -0300 Pedro Gomes <pedrodemargomes@gmail.com> wrote:

> On Thu, Feb 3, 2022 at 10:39 AM SeongJae Park <sj@kernel.org> wrote:
> 
> > I think this would be better to be implemented as another monitoring primitive
> > based on the virtual address space monitoring primitives, e.g., vaddr-writes?
> > Then the implementation would be simpler and changes to other files will be
> > minimized.  For the user space interface, we could use a prefix to target_ids
> > debugfs file.  For example,
> >
> >     # echo "vaddr-writes $(pidof workload)" > $debugfs/damon/target_ids
> 
> I will do that.

Thanks!

> 
> > > This patch also adds the actions mergeable and unmergeable to damos schemes.
> > > These actions are used by KSM as explained in [1].
> >
> > Please do that in a separate patch, and also update the document
> > (Documentation/admin-guide/mm/damon/usage.rst).  And, what's the expected usage
> > of the action and benefits?
> 
> The idea is to use this action to all areas that are not written too frequently,
> this way KSM can save more memory without too much overhead.
> But I have to test it better and collect some data to see if it really
> makes sense,
> perhaps it is better to leave this patch for later.
> I would like to know your opinion on this, do you think it makes sense?

Yes, that idea makes sense to me :)


Thanks,
SJ

> 
> 
> -- 
> Atenciosamente,
> Pedro Demarchi Gomes.
