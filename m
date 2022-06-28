Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8927955DAB0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245220AbiF1GEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiF1GEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:04:52 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5691B2315F;
        Mon, 27 Jun 2022 23:04:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D354681BC;
        Tue, 28 Jun 2022 05:59:38 +0000 (UTC)
Date:   Tue, 28 Jun 2022 09:04:49 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Liang He <windhl@126.com>
Cc:     linux@armlinux.org.uk, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] arm/mach-omap2: Fix refcount leak bug in omap_hwmod.c
Message-ID: <YrqaAXkreWHg0MVc@atomide.com>
References: <20220618014747.4055279-1-windhl@126.com>
 <YrqKKBflkZKRHwXW@atomide.com>
 <4b994fd6.3db9.181a8ddb1e9.Coremail.windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b994fd6.3db9.181a8ddb1e9.Coremail.windhl@126.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liang He <windhl@126.com> [220628 05:47]:
> 
> 
> At 2022-06-28 12:57:12, "Tony Lindgren" <tony@atomide.com> wrote:
> >Hi,
> >
> >* Liang He <windhl@126.com> [220618 04:43]:
> >> In _init(), of_find_node_by_name() will return a node pointer with
> >> refcount incremented. We should use of_node_put() in fail path or
> >> when it is not used anymore.
> >> 
> >> NOTE: As the ref will be passed from 'bus' to 'np' by the xx_lookup(),
> >> in normal exit path, we should call of_node_put() at the end use of 'np',
> >> not the end use of 'bus'.
> >
> >Looks correct to me. What about missing of_node_put() for
> >of_get_next_child() also in the _init() function?
> >
> >Regards,
> >
> >Tony
> 
> Thanks, Tony.
> 
> I have found this bug but not send the patch for of_get_next_child()
> as I am collecting other OF function related bugs and I have been told that it is better 
> to collect all similar bugs in same directory, then finally report them.

Well in this case while you review a single function, it's usually better
to fix similar issues to avoid having to review the same function multiple
times. Of course if the patch becomes hard to read, then it makes sense
to split it into several patches.

> So I will send a new patch for both of the two missing 'put' bugs caused by
> of_find_xxx() and of_get_xxx() in omap_hwmod.c

Please just update this patch so we have _init() completely reviewed for
similar issues and is not left only partially patched.

Regards,

Tony
