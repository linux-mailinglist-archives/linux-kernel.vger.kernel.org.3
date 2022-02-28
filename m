Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4DB4C6D65
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbiB1NGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiB1NF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:05:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067F758388;
        Mon, 28 Feb 2022 05:05:21 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9D5AE2197F;
        Mon, 28 Feb 2022 13:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646053519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EGyRPRJIpDnI4KGJdXL5GmjwMNnIG6JNSwMxITOgGUo=;
        b=dbePSzv6701PxPA9P7l85kE97XexBm780M6pFmAJcw9KHylON1VSAWXCKn5SYnjDjzBDkm
        2ZlsIRmV5WTId5yZpyA/VYn1WoIgCJajVXXu/45UJi25VHIkkJwR4YHy9nmoKFa4iwY7r7
        rcQxa0lpu3jl3r7++1KDLuk6fE9wO3U=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 579AEA3B83;
        Mon, 28 Feb 2022 13:05:19 +0000 (UTC)
Date:   Mon, 28 Feb 2022 14:05:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Subject: Re: [PATCH v8 04/13] module: Move livepatch support to a separate
 file
Message-ID: <YhzIjPYNw2tA4GmS@alley>
References: <20220222141303.1392190-1-atomlin@redhat.com>
 <20220222141303.1392190-5-atomlin@redhat.com>
 <Yhiik2ledqAfGuN2@alley>
 <fb1bb248-bd3f-0990-cdfd-d186b7579411@csgroup.eu>
 <YhyqaGO+vbGOifpR@alley>
 <ed8bb968-0a88-39cf-f388-032e8c205df7@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed8bb968-0a88-39cf-f388-032e8c205df7@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-28 11:46:33, Christophe Leroy wrote:
> 
> 
> Le 28/02/2022 à 11:56, Petr Mladek a écrit :
> > On Fri 2022-02-25 16:49:31, Christophe Leroy wrote:
> >> Le 25/02/2022 à 10:34, Petr Mladek a écrit :
> >>>
> >>> Please do not do these small coding style changes. It complicates the
> >>> review and increases the risk of regressions. Different people
> >>> have different preferences. Just imagine that every half a year
> >>> someone update style of a code by his personal preferences. The
> >>> real changes will then get lost in a lot of noise.
> >>
> >> I disagree here. We are not talking about people's preference here but
> >> compliance with documented Linux kernel Codying Style and handling of
> >> official checkpatch.pl script reports.
> > 
> > Really?
> > 
> > 1. I restored
> > 
> > 	+	if (mod->klp_info->secstrings == NULL) {
> > 
> >     and checkpatch.pl is happy.
> 
> On mainline's kernel/module.c checkpatch.pl tells me:
> 
> CHECK: Comparison to NULL could be written "!mod->klp_info->secstrings"
> #2092: FILE: kernel/module.c:2092:
> +	if (mod->klp_info->secstrings == NULL) {

Only with --strict option. Alias of this option is --subjective...

> By the way some maintainers require checkpatch' clean patches even when 
> this is only code move. I remember being requested to do that in the 
> past, so now I almost always do it with my own patches.

I see.

From my POV, checkpatch is an useful tool for finding obvious mistakes.
But it is just a best effort approach. It has false positives. And
some complains are controversial.

BTW: I have never heard about --strict/--subjective option. I wonder
if some maintainer requires it.

> > I would not have complained if it did not complicate my review.
> > But it did!
> 
> Reviewing partial code move is not easy anyway, git is not very 
> userfriendly with that.

Exactly. It is a real pain to find changes in moved functions. It is
much easier when the author just shuffled the code. Anyway, the less
changes the better.

Best Regards,
Petr
