Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0177564DF2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 08:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiGDGsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 02:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiGDGsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 02:48:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE16D6409
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 23:48:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 74718227D8;
        Mon,  4 Jul 2022 06:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656917288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9u7T45ClUffv42dPmfx3ngMwVaZJ6r1BiFszAAErmvI=;
        b=es4urU8VLsurTkIH16OTZYKTzyFmjLUfe7wkeSaUJcpgX2SYHJ7TF6X/luADMNeyNAYiIH
        fsi/Lolns0/6MfRveLTOrHoTzbSjfPyIYTeMDOffHmWzq7htPi86VGtSkloC07y3pJ909n
        9urZLvuOKK6MsAa/eOz78MfjHi10itQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C01B42C142;
        Mon,  4 Jul 2022 06:48:06 +0000 (UTC)
Date:   Mon, 4 Jul 2022 08:48:06 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     cgel.zte@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, minchan@kernel.org,
        oleksandr@redhat.com, xu xin <xu.xin16@zte.com.cn>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH linux-next] mm/madvise: allow KSM hints for
 process_madvise
Message-ID: <YsKNJiGA/ruLRS27@dhcp22.suse.cz>
References: <20220701084323.1261361-1-xu.xin16@zte.com.cn>
 <Yr66Uhcv+XAPYPwj@dhcp22.suse.cz>
 <93e1e19a-deff-2dad-0b3c-ef411309ec58@redhat.com>
 <c9de1c34-2a39-e4a2-c9b0-9790c5ffab13@redhat.com>
 <Yr7h/E/6A+tsjU9r@dhcp22.suse.cz>
 <203548a6-cf70-30ce-6756-f6c909e7ef21@redhat.com>
 <Yr7qQsWQGb0dhkxr@dhcp22.suse.cz>
 <54b67d6b-f600-1b9b-3d3f-e91b13d04c91@redhat.com>
 <Yr70ZwUAIHNz5VNy@dhcp22.suse.cz>
 <11d28e6d-edb0-7d11-b476-c5808f3b7c5d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11d28e6d-edb0-7d11-b476-c5808f3b7c5d@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-07-22 21:12:56, David Hildenbrand wrote:
> On 01.07.22 15:19, Michal Hocko wrote:
> > On Fri 01-07-22 14:39:24, David Hildenbrand wrote:
> >>> I am not sure about exact details of the KSM implementation but if that
> >>> is not a desirable behavior then it should be handled on the KSM level.
> >>> The very sam thing can easily happen in a multithreaded (or in general
> >>> multi-process with shared mm) environment as well.
> >>
> >> I don't quite get what you mean.
> > 
> > I meant to say that if KSM needs to be aware of a special CoW semantic
> > then it should be handled on the KSM layer regardless whether the KSM
> > has been set by the process itself or any other process that has acccess
> > to the MM. process_madvise is just another way to access a remote MM
> > other than sharing the full MM.
> 
> Okay.
> 
> KSM has been a corner case feature that was restricted to well-defined
> and well-tested environments. Until recently, R/O pins of any KSM pages
> was essentially completely unreliably. And applications don't expect
> such surprises. The shared zeropage is most probably the last
> problematic piece.
> 
> Yes, we're getting there that it's a real feature that can see more
> (forced) wide-spread use. However, until the known issues in KSM have
> been fixed (e.g., below -- there is a whole list of papers regarding
> attacks on memory deduplication), it should be limited to well defined
> environments and applications only -- IMHO.

Very much agreed on all this! To be completely honest I am not really
sure that all those consequences are widely understood and optmizing
solely on memory savings is a very short sighted strategy IMO. But, it
seems that there is a demand for this feature and previous attempts for
APIs were much worse both from the semantic and maintainability POV. I
am not sure we can get anything more sane than madvise.

I also very much agree that current shortcomings have to be adressed
first before we open this can of worms to 3rd party actors. I was not
aware of those so thank for bringing them up. Maybe I was overly
optimistic here.

So I guess we have following questions to answer:
1) Do we really want to support KSM triggered by 3rd party? Does it
impose new challenges other than existing ones in multi "threaded"
environemnts?
2) If yes, is the process_madvise the most appropriate existing API? Or
do we need a new one?
3) Should this be a highly privileged operation or we want to allow
userspace to shoot its feet because consequences are subtle and not very
well understood?

> So what I want to express here is that if we're adding an interface that
> can be used to just enable KSM on the whole system easily, it might be a
> bit to soon for that. No matter what you document, people will ignore it.

Agreed.

> OTOH, if this is a real debug feature that will only be available in
> specific debug/test scenarios (kernel config? toggle? whatsoever?), then
> it's "better". If that is already the case, good.

No, I think this is aimed to real production deployments.

Thanks!
-- 
Michal Hocko
SUSE Labs
