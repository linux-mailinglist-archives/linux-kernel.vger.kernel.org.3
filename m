Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D75E4C2BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbiBXM0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbiBXM0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:26:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521FA160FC2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:26:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 034F71F43D;
        Thu, 24 Feb 2022 12:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645705572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iRlluuQbnUld5s/Ic1hGKrSMGDqTXKB3g6TTm6f3L7Y=;
        b=P4+Atof8O39vObfzAjqg/Nzxqg4luBetNwbADlOtA/HKFS7YWpwMdwKB7c9c8j4YPgPG3/
        CubsBVR+ghLMjuOi29tKDCB7aoMwQwuEqhf/gCy7EcaU1ewg9NVt6db5FxNoAOyemU5lAT
        UkXbFafx4SCfmV9vpQYBTxzCQJFw7dE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645705572;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iRlluuQbnUld5s/Ic1hGKrSMGDqTXKB3g6TTm6f3L7Y=;
        b=TY7aQvrFUZfYzQXzzLbh5HZ0OfZnCp3NUxvJW4Sa1kA0MEP5PZFRvBodlXh7vdKD9rkxf8
        YBzGqKxWSvLfGKAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA82913AD9;
        Thu, 24 Feb 2022 12:26:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qdrBMGN5F2J8AQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 24 Feb 2022 12:26:11 +0000
Message-ID: <0e02416f-ef43-dc8a-9e8e-50ff63dd3c61@suse.cz>
Date:   Thu, 24 Feb 2022 13:26:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Marco Elver <elver@google.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
 <20220221105336.522086-2-42.hyeyoo@gmail.com>
 <4d42fcec-ff59-2e37-4d8f-a58e641d03c8@suse.cz>
 <CANpmjNMjgSKommNCrfyFuaz+3HQdW92ZSF_p26LQdmS0o3L98Q@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 1/5] mm/sl[au]b: Unify __ksize()
In-Reply-To: <CANpmjNMjgSKommNCrfyFuaz+3HQdW92ZSF_p26LQdmS0o3L98Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/22 20:06, Marco Elver wrote:
> On Wed, 23 Feb 2022 at 19:39, Vlastimil Babka <vbabka@suse.cz> wrote:
>> On 2/21/22 11:53, Hyeonggon Yoo wrote:
>> > Only SLOB need to implement __ksize() separately because SLOB records
>> > size in object header for kmalloc objects. Unify SLAB/SLUB's __ksize().
>> >
>> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> > ---
>> >  mm/slab.c        | 23 -----------------------
>> >  mm/slab_common.c | 29 +++++++++++++++++++++++++++++
>> >  mm/slub.c        | 16 ----------------
>> >  3 files changed, 29 insertions(+), 39 deletions(-)
>> >
>> > diff --git a/mm/slab.c b/mm/slab.c
>> > index ddf5737c63d9..eb73d2499480 100644
>> > --- a/mm/slab.c
>> > +++ b/mm/slab.c
>> > @@ -4199,27 +4199,4 @@ void __check_heap_object(const void *ptr, unsigned long n,
>> >  }
>> >  #endif /* CONFIG_HARDENED_USERCOPY */
>> >
>> > -/**
>> > - * __ksize -- Uninstrumented ksize.
>> > - * @objp: pointer to the object
>> > - *
>> > - * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
>> > - * safety checks as ksize() with KASAN instrumentation enabled.
>> > - *
>> > - * Return: size of the actual memory used by @objp in bytes
>> > - */
>> > -size_t __ksize(const void *objp)
>> > -{
>> > -     struct kmem_cache *c;
>> > -     size_t size;
>> >
>> > -     BUG_ON(!objp);
>> > -     if (unlikely(objp == ZERO_SIZE_PTR))
>> > -             return 0;
>> > -
>> > -     c = virt_to_cache(objp);
>> > -     size = c ? c->object_size : 0;
>>
>> This comes from commit a64b53780ec3 ("mm/slab: sanity-check page type when
>> looking up cache") by Kees and virt_to_cache() is an implicit check for
>> folio slab flag ...
>>
>> > -
>> > -     return size;
>> > -}
>> > -EXPORT_SYMBOL(__ksize);
>> > diff --git a/mm/slab_common.c b/mm/slab_common.c
>> > index 23f2ab0713b7..488997db0d97 100644
>> > --- a/mm/slab_common.c
>> > +++ b/mm/slab_common.c
>> > @@ -1245,6 +1245,35 @@ void kfree_sensitive(const void *p)
>> >  }
>> >  EXPORT_SYMBOL(kfree_sensitive);
>> >
>> > +#ifndef CONFIG_SLOB
>> > +/**
>> > + * __ksize -- Uninstrumented ksize.
>> > + * @objp: pointer to the object
>> > + *
>> > + * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
>> > + * safety checks as ksize() with KASAN instrumentation enabled.
>> > + *
>> > + * Return: size of the actual memory used by @objp in bytes
>> > + */
>> > +size_t __ksize(const void *object)
>> > +{
>> > +     struct folio *folio;
>> > +
>> > +     if (unlikely(object == ZERO_SIZE_PTR))
>> > +             return 0;
>> > +
>> > +     folio = virt_to_folio(object);
>> > +
>> > +#ifdef CONFIG_SLUB
>> > +     if (unlikely(!folio_test_slab(folio)))
>> > +             return folio_size(folio);
>> > +#endif
>> > +
>> > +     return slab_ksize(folio_slab(folio)->slab_cache);
>>
>> ... and here in the common version you now for SLAB trust that the folio
>> will be a slab folio, thus undoing the intention of that commit. Maybe
>> that's not good and we should keep the folio_test_slab() for both cases?
>> Although maybe it's also strange that prior this patch, SLAB would return 0
>> if the test fails, and SLUB would return folio_size(). Probably because with
>> SLUB this can be a large kmalloc here and with SLAB not. So we could keep
>> doing that in the unified version, or KASAN devs (CC'd) could advise
>> something better?
> 
> Is this a definitive failure case?

Yeah, if we called it on a supposed object pointer that turns out to be not
slab, it usually means some UAF, so a failure.

> My opinion here is that returning 0
> from ksize() in case of failure will a) provide a way to check for
> error, and b) if the size is used unconditionally to compute an
> address may be the more graceful failure mode (see comment added in
> 0d4ca4c9bab39 for what happens if we see invalid memory per KASAN
> being accessed).

Sounds good, thanks. Then the patch should be fixed up to keep checking for
slab flag and returning 0 otherwise for CONFIG_SLAB.
For SLUB we might fail to detect the failure case by assuming it was a large
kmalloc. Maybe we could improve and only assume that when folio_size() is
large enough that the corresponding allocation would actually be done as a
large kmalloc, and the object pointer is to the beginning of the folio?
