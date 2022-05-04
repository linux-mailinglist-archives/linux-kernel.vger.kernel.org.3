Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B30519C39
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347732AbiEDJuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347727AbiEDJuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:50:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C445726540
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:46:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4CF78210DC;
        Wed,  4 May 2022 09:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651657597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f2BU3+t5DYqkYThY0d1gO61pXwUsjhrMxVTtLHPwDPI=;
        b=DNW0smbOABig+ojoNBZ4DbJ6aEVK89nHBYWenqKldvaZyMeTKvPDNBJj/h5udOUsgAtqDP
        6YAU77GyISTlPJEktcS2MlvU9T+TVOPYGI112xJfidWHrRifGr2Y16wD2VFoiWSPI+nig3
        CfcoYgR6RMcExiGJfAaOkodK3ZSMqmY=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EC0192C141;
        Wed,  4 May 2022 09:46:36 +0000 (UTC)
Date:   Wed, 4 May 2022 11:46:36 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Marco Elver <elver@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH -printk] printk, tracing: fix console tracepoint
Message-ID: <20220504094636.GA8069@pathway.suse.cz>
References: <20220503073844.4148944-1-elver@google.com>
 <87r15ae8d7.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r15ae8d7.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-05-03 21:20:44, John Ogness wrote:
> On 2022-05-03, Marco Elver <elver@google.com> wrote:
> > One notable difference is that by moving tracing into printk_sprint(),
> > the 'text' will no longer include the "header" (loglevel and timestamp),
> > but only the raw message. Arguably this is less of a problem now that
> > the console tracepoint happens on the printk() call and isn't delayed.
> 
> Another slight difference is that messages composed of LOG_CONT pieces
> will trigger the tracepoint for each individual piece and _never_ as a
> complete line.
> 
> It was never guaranteed that all LOG_CONT pieces make it into the final
> printed line anyway, but with this change it will be guaranteed that
> they are always handled separately.
> 
> I am OK with this change, but like Steven, I agree the the users of that
> tracepoint need to chime in.

My feeling is that the feature is not used much. Otherwise people
would complain that it was asynchronous and hard to use.

I mean that the printk() messages appeared in the trace log
asynchronously. So it required some post processing to correctly
sort them against other tracing messages. The same result can be
achieved by processing printk log buffer, dmesg.log, journalctl.

I guess that we will only find the answer when we push the change
into linux-next and mainline. I am going to do so.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
