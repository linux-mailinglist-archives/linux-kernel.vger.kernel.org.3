Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FDC58FA6A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbiHKKHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKKHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:07:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA488E9A2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 03:07:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 860A5204E2;
        Thu, 11 Aug 2022 10:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660212460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mCxIbVIOyyg/Zymr2tIkgto6cQ3worjVRRoTjkKlzPg=;
        b=ZNWqhyyQ3JjW94SuNhBv3arPNAEn48sHsyC4bc6kInzWlhdT4DnTntYnORQ76CzbaFaFQq
        9PgK8V/Hmy6xyOcF47pv5wQ4zAAMs5IpZa0uLYhY2BORYGmAKo0lkN4MMx3tEFecJdFeBj
        U4EEZa8P/G3uUaj/jZEHdu08EVmxpMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660212460;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mCxIbVIOyyg/Zymr2tIkgto6cQ3worjVRRoTjkKlzPg=;
        b=ijjg7SCgXM0l9/3G4pStwk0NYslTQW2C6OFiyUvr8jTO8AmBsyNUWx4EE0crdLr94EkXSV
        ObhhLYzHwhxjN0Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C97513A9B;
        Thu, 11 Aug 2022 10:07:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MhDqEezU9GJiAgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 11 Aug 2022 10:07:40 +0000
Message-ID: <6b41bb2c-6305-2bf4-1949-84ba08fdbd72@suse.cz>
Date:   Thu, 11 Aug 2022 12:07:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
From:   vbabka@suse.cz
Subject: Re: [PATCH v2] Introduce sysfs interface to disable kfence for
 selected slabs.
Content-Language: en-US
To:     Marco Elver <elver@google.com>
Cc:     Imran Khan <imran.f.khan@oracle.com>, glider@google.com,
        dvyukov@google.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
References: <20220811085938.2506536-1-imran.f.khan@oracle.com>
 <d3cd0f34-b30b-9a1d-8715-439ffb818539@suse.cz>
 <CANpmjNMYwxbkOc+LxLfZ--163yfXpQj69oOfEFkSwq7JZurbdA@mail.gmail.com>
In-Reply-To: <CANpmjNMYwxbkOc+LxLfZ--163yfXpQj69oOfEFkSwq7JZurbdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/22 11:52, Marco Elver wrote:
> On Thu, 11 Aug 2022 at 11:31, <vbabka@suse.cz> wrote:
>>
>> On 8/11/22 10:59, Imran Khan wrote:
>> > By default kfence allocation can happen for any slab object, whose size
>> > is up to PAGE_SIZE, as long as that allocation is the first allocation
>> > after expiration of kfence sample interval. But in certain debugging
>> > scenarios we may be interested in debugging corruptions involving
>> > some specific slub objects like dentry or ext4_* etc. In such cases
>> > limiting kfence for allocations involving only specific slub objects
>> > will increase the probablity of catching the issue since kfence pool
>> > will not be consumed by other slab objects.
>>
>> So you want to enable specific caches for kfence.
>>
>> > This patch introduces a sysfs interface '/sys/kernel/slab/<name>/skip_kfence'
>> > to disable kfence for specific slabs. Having the interface work in this
>> > way does not impact current/default behavior of kfence and allows us to
>> > use kfence for specific slabs (when needed) as well. The decision to
>> > skip/use kfence is taken depending on whether kmem_cache.flags has
>> > (newly introduced) SLAB_SKIP_KFENCE flag set or not.
>>
>> But this seems everything is still enabled and you can selectively disable.
>> Isn't that rather impractical?
> 
> A script just iterates through all the caches that they don't want,
> and sets skip_kfence? It doesn't look more complicated.

Well, yeah, it's possible.

>> How about making this cache flag rather denote that KFENCE is enabled (not
>> skipped), set it by default only for for caches with size <= 1024, then you
> 
> Where does 1024 come from? PAGE_SIZE?

You're right, the existing check in __kfence_alloc() uses PAGE_SIZE, not
1024, which probably came from lack of coffee :)

> The problem with that opt-in vs. opt-out is that it becomes more
> complex to maintain opt-in (as the first RFC of this did). With the

I see. There was a kfence_global_alloc_enabled and slub_kfence[=slabs] ...
that probably wouldn't be necessary even in an opt-in scenario as I described.

> new flag SLAB_SKIP_KFENCE, it also can serve a dual purpose, where
> someone might want to explicitly opt out by default and pass it to
> kmem_cache_create() (for whatever reason; not that we'd encourage
> that).

Right, not be able to do that would be a downside (although it should be
possible even with opt-in to add an opt-out cache flag that would just make
sure the opt-in flag is not set even if eligible by global defaults).

> I feel that the real use cases for selectively enabling caches for
> KFENCE are very narrow, and a design that introduces lots of
> complexity elsewhere, just to support this feature cannot be justified
> (which is why I suggested the simpler design here back in
> https://lore.kernel.org/lkml/CANpmjNNmD9z7oRqSaP72m90kWL7jYH+cxNAZEGpJP8oLrDV-vw@mail.gmail.com/
> )

I don't mind strongly either way, just a suggestion to consider.

