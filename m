Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB69C54C3A4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245420AbiFOIhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245041AbiFOIhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:37:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6437530569
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:37:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 130E81F9C1;
        Wed, 15 Jun 2022 08:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655282221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=343BjbVrfUTKzzHDVLHqseRRkhRTJ4iUhaXrlwxZiWE=;
        b=JwS6DDQX2RGdWgg0Cr+sejnqN8TPFxcewf3S4wQLVCY4BGU/41MNiYN2FCE6z18JOzilWD
        W45AYhEcyQrMsjs0fM/CMhjq7EH6I1mF+xZ/tK6bRmysCweEJUenLegEmxe6FL4YlcxJlH
        ZUlKLtTg1qFYTwTNaGYBW2MnZoXCn/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655282221;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=343BjbVrfUTKzzHDVLHqseRRkhRTJ4iUhaXrlwxZiWE=;
        b=WK++0ZKoz4bR/QN29E/RMdgJnhuI7sQDFR6aJSRw5PlQuB+oWybsAOvl0tMPyjTzeIz+E3
        O9n8exw0hoMEUlAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DAD2013A35;
        Wed, 15 Jun 2022 08:37:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a3PQNCyaqWJRKQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 15 Jun 2022 08:37:00 +0000
Message-ID: <e5ebc952-af17-321f-5343-bc914d47c931@suse.cz>
Date:   Wed, 15 Jun 2022 10:37:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] mm/slub: Simplify __kmem_cache_alias()
Content-Language: en-US
To:     Xiongwei Song <sxwjean@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Xiongwei Song <sxwjean@me.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xiongwei Song <xiongwei.song@windriver.com>
References: <20220603143555.41914-1-sxwjean@me.com>
 <YpspHqZM27DeEhNR@n2.us-central1-a.c.spheric-algebra-350919.internal>
 <CAEVVKH_WM321zQPC-xjchqjySi4kngo6CFz-A6HY2tCjNCZ3SA@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAEVVKH_WM321zQPC-xjchqjySi4kngo6CFz-A6HY2tCjNCZ3SA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/22 09:04, Xiongwei Song wrote:
> On Sat, Jun 4, 2022 at 5:43 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>>
>> On Fri, Jun 03, 2022 at 10:35:55PM +0800, sxwjean@me.com wrote:
>> > From: Xiongwei Song <xiongwei.song@windriver.com>
>> >
>> > There is no need to do anything if sysfs_slab_alias() return nonzero
>> > value after getting a mergeable cache.
>> >
>> > Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
>> > Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>> > ---
>> > v2: Collect Reviewed-by tag from Muchun.

Hmm I added v1 (with the Reviewed tag) before getting to the v2 thread. But
I think it's fine, see below.

>> > ---
>> >  mm/slub.c | 8 +++-----
>> >  1 file changed, 3 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/mm/slub.c b/mm/slub.c
>> > index d8d5abf49f5f..9444277d669a 100644
>> > --- a/mm/slub.c
>> > +++ b/mm/slub.c
>> > @@ -4861,6 +4861,9 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
>> >
>> >       s = find_mergeable(size, align, flags, name, ctor);
>> >       if (s) {
>> > +             if (sysfs_slab_alias(s, name))
>> > +                     return NULL;
>> > +
>> >               s->refcount++;
>> >
>>
>> I think we should not expose sysfs attributes before initializing
>> what can be read via sysfs attribute (object_size).

Hmm I don't think they are unitialized. They have an old value from the
cache we are merging with, which is updated if the new aliased cache has a
larger one.
So yeah we might briefly during creation expose an alias that will have an
incorrect value, but I doubt anything will break. The values are not stable
anyway as new aliases are added, as we are bumping them for the 'root' cache
and all aliases that share it already.

>> >               /*
>> > @@ -4869,11 +4872,6 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
>> >                */
>> >               s->object_size = max(s->object_size, size);
>>
>> this calculation should be done before sysfs_slab_alias().
> 
> Yeah, understood. Should we restore s->object_size and s->inuse if
> sysfs_slab_alias() returns non zero value?

And by bailing out early this patch effectively achieves that, so I'd say
it's a better state than before the patch so I'll keep it unless proven
otherwise. Thanks!

> Regards,
> Xiongwwei
> 
>>
>> Thanks,
>> Hyeonggon
>>
>> >               s->inuse = max(s->inuse, ALIGN(size, sizeof(void *)));
>> > -
>> > -             if (sysfs_slab_alias(s, name)) {
>> > -                     s->refcount--;
>> > -                     s = NULL;
>> > -             }
>> >       }
>> >
>> >       return s;
>> > --
>> > 2.30.2
>> >
>>

