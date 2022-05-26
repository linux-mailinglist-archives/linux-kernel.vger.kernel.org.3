Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFA15350EA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343831AbiEZOoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiEZOo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:44:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDF9CFE00;
        Thu, 26 May 2022 07:44:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7E6A821A0F;
        Thu, 26 May 2022 14:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653576261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0yFRTzlOP5N16OSUpV/p1TUfusg1eqGKVAkgV3sElqE=;
        b=MCowPDIgEh6D1WWJx4EFfyi56Sz8jvfiNzdZi5MVl6Kdhyw18mJf9s/Y8J/zJR+yhjn/k7
        sWx/S69z76XxBKfpUfzaytqgSE6QLD3kbMp+FENcBAiP0qMt610ZcL0EJpwirBnxoJKMnA
        jRV14OSanw8InYM2WBsMgIkRO87fia4=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 17F772C141;
        Thu, 26 May 2022 14:44:21 +0000 (UTC)
Date:   Thu, 26 May 2022 16:44:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: Re: [PATCH v2 00/28] Printbufs (now with more printbufs!)
Message-ID: <Yo+SRBSu5OdRl0/J@alley>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519172421.162394-1-kent.overstreet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-05-19 13:23:53, Kent Overstreet wrote:
> So there's a lot of new stuff since the first posting:

>  - Printbufs have been broken up into multiple patches that each add distinct
>    functionality - this is intended to make it easier to review and to see
>    what's used for what

It is great that it is split. Also it is great to see all the ideas.
But I would really prefer to somehow split it to make it easier
for review and rebasing.

I see the following "independent" parts:

  1. Add simple API that allows to replace @len, @buf, @end in vsprintf.c
     by @printbuf. I agree that the code looks better and more safe.

  2. Clean up of printf_spec. It would be great. But I do not like
     some parts. For example, si_units, human_readable_units
     are not property of the buffer. They are specific for a
     particular substring.

  3. New %p(%p) format. It really needs deep thinking. It is a
     ticket for potential big troubles. It is one patch that
     might be introduced and discussed anytime once we have
     the simple buffer API.

  3. Replace seq_buf. Steven Rostedt has to agree with it. Honestly,
     I do not see any improvement. The patches mostly do 1:1 replacement
     of one API with another.

  4. Heap allocated buffer. I am not sure if it is really needed.
     The patchset adds 3 users. IMHO, small static buffer would be
     perfectly fine for 2 of them. I personally do not like the error
     handling and the need to call exit.

  5. All the fancy stuff (pr_tab(), pr_string_option()). The patchset
    does not add any user for them.


I am going to comment the particular patches. It might take some
time. The patchset is really huge. It would really help to split it.

Best Regards,
Petr
