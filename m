Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFCF54F249
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380692AbiFQH5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380428AbiFQH5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:57:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C642F50031
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:57:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9C92E21DE9;
        Fri, 17 Jun 2022 07:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655452626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CIbGaD2Xgfeb6uOIFzrsQuZy1/dwLd9NUE5dLf1lMwo=;
        b=yIeosKycFcz7rNIG0abjA3KNArY11mINNn7nwjuwz5lO3duyy/3CU/dLR5be4+8vAJAOos
        7DZdEVrR2m7LAAhlQ06S9cbuNx0/H5oOTpj6JvcdYcXHUWJi4QeRONTjQYFi826oQDQTvK
        4KPppXMVuV/R6MlUd8qvq5CC2R7PLRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655452626;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CIbGaD2Xgfeb6uOIFzrsQuZy1/dwLd9NUE5dLf1lMwo=;
        b=pjflmxhzeNRFbILF8zLdikXBcvmT9/T0gkPUfERYG+ajCyUAynP7Vj3nJ/qgd7DuqVezdr
        zE2JzWDBk1OnXPAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 797DE1348E;
        Fri, 17 Jun 2022 07:57:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NBsSHdIzrGIpCAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 17 Jun 2022 07:57:06 +0000
Message-ID: <8354ba5b-d1ce-90c7-be76-328ab9321550@suse.cz>
Date:   Fri, 17 Jun 2022 09:57:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 7/7] mm/page_alloc: Replace local_lock with normal
 spinlock
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220613125622.18628-1-mgorman@techsingularity.net>
 <20220613125622.18628-8-mgorman@techsingularity.net>
 <43033655-2e78-621b-cc76-c3dc53024d00@suse.cz>
 <CAOUHufaHV9Aua3sneOnQvPhrtuxxDuJ5+c+A-zy8RufoDkmeMQ@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAOUHufaHV9Aua3sneOnQvPhrtuxxDuJ5+c+A-zy8RufoDkmeMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/22 23:07, Yu Zhao wrote:
> On Thu, Jun 16, 2022 at 11:02 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>>
>> > @@ -3794,19 +3805,29 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
>> >       struct list_head *list;
>> >       struct page *page;
>> >       unsigned long flags;
>> > +     unsigned long __maybe_unused UP_flags;
>> >
>> > -     local_lock_irqsave(&pagesets.lock, flags);
>> > +     /*
>> > +      * spin_trylock_irqsave is not necessary right now as it'll only be
>> > +      * true when contending with a remote drain. It's in place as a
>> > +      * preparation step before converting pcp locking to spin_trylock
>> > +      * to protect against IRQ reentry.
>> > +      */
>> > +     pcp_trylock_prepare(UP_flags);
>> > +     pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
>> > +     if (!pcp)
>>
>> Besides the missing unpin Andrew fixed, I think also this is missing
>> pcp_trylock_finish(UP_flags); ?
> 
> spin_trylock only fails when trylock_finish is a NOP.

True, so it's not an active bug, but I would still add it, so it's not
confusing and depending on non-obvious details that might later change and
break the code.
