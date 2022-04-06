Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098E74F628F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbiDFPEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbiDFPDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:03:49 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CEE14B026
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:51:50 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o20so1703398pla.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 04:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LexSt4aevETZp9OYJUcU75mB3szv4z4iC4bK+kg4wrw=;
        b=RLEQBPKPm2Y+qKo1Y5nutRYAEJ5mnhdcakkUzgDrH6n5zbU8poEo1Z+Au767FbLKdH
         rvPcPSkwsQ8lKYXiANnZG5tIguNgo7izrATjlgpWdTNCpSSHWLKKoVj/xiOZX9gz7oOx
         KtdbBj2gm9IRc7h5vxNl3gLzLRkionLb9hsDjNnAlmfQC0yJotz/NuT1N1ymnXj4WGBL
         EmJSmr1BaLb54QF8IAr8sNYYOBQrPJ0zqFfA0ui5ca68eybQo2zlM8n+DwB8UGgmwacG
         VMX6uwfOg3TA1HDec392SkH8lOVMSCELlIsgj5Zv5n0JigeMiBY7aVbny8HTP/ksr8Of
         ZpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LexSt4aevETZp9OYJUcU75mB3szv4z4iC4bK+kg4wrw=;
        b=iEzSPSOWQBmIykY1vtRavo6CgqdEybDVwPeHNmwlk5zrjr7Z/+AdNqc2tkhJUCY43r
         dOH0TT12k+rnpfj4+Bj9r1wLlAwYLQ6foy8Q042IozE50s2s+raF8mgZJZoLLG+t6yEQ
         1fN1hyt+PKu4kLR6AFh/VPuFHbEDmcx6LGbAi7/do0fjDSQC51y8yA16U5JgjC1GLOLD
         A8ZDear3tv3z82DbYK6GyZX8C39O7jUyIgHxXxU99ylGb+AMq70mFOYMAq4xeFeu8DQq
         AnbJFBldbAYVA9WxC2YOPcY2RybynOZWLUiXZk8POjd0IrvLEZmi39nEgcVrjgXuktyu
         u0mg==
X-Gm-Message-State: AOAM532a6+5EKXeaHD4nM3JsgQ5OUYQiElQQuhb1NscTkV1Lg8IIpCIO
        xk5xqN4lwURsP2WuKvmkNys=
X-Google-Smtp-Source: ABdhPJwXJkv8T7an8WY+DDHwwAghsTTZPZLvCw/9PSzzyUVU7ISrUysJcUH2S+tJX1OZ+QT4k87b8g==
X-Received: by 2002:a17:902:c948:b0:156:c07d:8222 with SMTP id i8-20020a170902c94800b00156c07d8222mr8349170pla.30.1649245846123;
        Wed, 06 Apr 2022 04:50:46 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id f16-20020a056a001ad000b004fb358ffe86sm19212686pfv.137.2022.04.06.04.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 04:50:44 -0700 (PDT)
Date:   Wed, 6 Apr 2022 20:50:37 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        kernel test robot <oliver.sang@intel.com>,
        Oliver Glitta <glittao@gmail.com>, lkp@lists.01.org,
        lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
        Imran Khan <imran.f.khan@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zqiang <qiang.zhang@windriver.com>, linux-mm@kvack.org
Subject: Re: [mm/slub] 555b8c8cb3:
 WARNING:at_lib/stackdepot.c:#stack_depot_fetch
Message-ID: <Yk1+jZjfaJK3Jwwf@hyeyoo>
References: <20220324095218.GA2108184@odroid>
 <YkcfNjZJSXNsAlLt@hyeyoo>
 <YkpgjgM/aSXd29uj@hyeyoo>
 <Ykqn2z9UVfxFwiU+@elver.google.com>
 <8368021e-86c3-a93f-b29d-efed02135c41@suse.cz>
 <CANpmjNMupGGbTDD-ZEY=acTbqguvWgLzb1ZVRbG9TyuF50Ch+Q@mail.gmail.com>
 <Ykui2prpzkMvaWBa@hyeyoo>
 <YkwjCUbTbRqslphe@elver.google.com>
 <YkzHG64zxu+nWbg3@hyeyoo>
 <Yk1Qf73cufW6LjOW@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk1Qf73cufW6LjOW@elver.google.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 10:34:07AM +0200, Marco Elver wrote:
> On Wed, Apr 06, 2022 at 07:47AM +0900, Hyeonggon Yoo wrote:
> > On Tue, Apr 05, 2022 at 01:07:53PM +0200, Marco Elver wrote:
> > > On Tue, Apr 05, 2022 at 11:00AM +0900, Hyeonggon Yoo wrote:
> > > > On Mon, Apr 04, 2022 at 05:18:16PM +0200, Marco Elver wrote:
> > > > > On Mon, 4 Apr 2022 at 16:20, Vlastimil Babka <vbabka@suse.cz> wrote:
> > > [...]
> > > > > > But here we are in mem_dump_obj() -> kmem_dump_obj() -> kmem_obj_info().
> > > > > > Because kmem_valid_obj() returned true, fooled by folio_test_slab()
> > > > > > returning true because of the /* Set required slab fields. */ code.
> > > > > > Yet the illusion is not perfect and we read garbage instead of a valid
> > > > > > stackdepot handle.
> > > > > >
> > > > > > IMHO we should e.g. add the appropriate is_kfence_address() test into
> > > > > > kmem_valid_obj(), to exclude kfence-allocated objects? Sounds much simpler
> > > > > > than trying to extend the illusion further to make kmem_dump_obj() work?
> > > > > > Instead kfence could add its own specific handler to mem_dump_obj() to print
> > > > > > its debugging data?
> > > > > 
> > > > > I think this explanation makes sense!  Indeed, KFENCE already records
> > > > > allocation stacks internally anyway, so it should be straightforward
> > > > > to convince it to just print that.
> > > > >
> > > > 
> > > > Thank you both! Yeah the explanation makes sense... thats why KASAN/KCSAN couldn't yield anything -- it was not overwritten.
> > > > 
> > > > I'm writing a fix and will test if the bug disappears.
> > > > This may take few days.
> > >
> > 
> > I did check the bug is not reproduced after simple fix. (reproduced 0 of 373)
> > This approach was right.
> > 
> > > The below should fix it -- I'd like to make kmem_obj_info() do something
> > > useful for KFENCE objects.
> > >
> > 
> > Agreed.
> > 
> [...]
> > > +	i = get_stack_skipnr(track->stack_entries, track->num_stack_entries, NULL);
> > > +	for (j = 0; i < track->num_stack_entries && j < KS_ADDRS_COUNT - 1; ++i, ++j)
> > 
> > why KS_ADDRS_COUNT - 1 instead of KS_ADDRS_COUNT?
> 
> For `kp_stack[j] = NULL` because KFENCE's stack_entries does not have a
> NULL-delimiter (we have num_stack_entries). But it seems for kp_stack
> it's only added if `j < KS_ADDR_COUNT`, so I've fixed that.
>

Okay.

> > > +		kp_stack[j] = (void *)track->stack_entries[i];
> > > +	kp_stack[j] = NULL;
> [...]
> > > +	kpp->kp_objp = (void *)meta->addr;
> > > +
> > 
> > no need to take meta->lock here?
> 
> Yes, in case state is KFENCE_OBJECT_FREED there could be a race.
>

dumping object that is freed sounds like a bug?
but seems it's better to avoid a race in that case too.

> > > +	kfence_to_kp_stack(&meta->alloc_track, kpp->kp_stack);
> > > +	if (meta->state == KFENCE_OBJECT_FREED)
> > > +		kfence_to_kp_stack(&meta->free_track, kpp->kp_free_stack);
> > > +	/* get_stack_skipnr() ensures the first entry is outside allocator. */
> > > +	kpp->kp_ret = kpp->kp_stack[0];
> > > +
> > > +	return true;
> > > +}
> > 
> > kfence_kmem_obj_info() does not set kp_data_offset. kp_data_offset
> > may not be zero when e.g.) mem_dump_obj(&rhp->func); in rcutorture case. 
> 
> kp_data_offset is the offset e.g. when SLUB has added a redzone:
> 
> |		objp0 = kasan_reset_tag(object);
> |	#ifdef CONFIG_SLUB_DEBUG
> |		objp = restore_red_left(s, objp0);
> |	#else
> |		objp = objp0;
> |	#endif
> |		objnr = obj_to_index(s, slab, objp);
> |		kpp->kp_data_offset = (unsigned long)((char *)objp0 - (char *)objp);
> 
> In !CONFIG_SLUB_DEBUG and !(s->flags & SLAB_RED_ZONE) cases it's always
> 0, and otherwise it's
> 
> 	`objp0 - restore_red_left(objp0)` ==
> 	`object - (object - s->red_left_pad)` ==
> 	`s->red_left_pad`.
> 
> This matters if kp_objp is not the object start accessible by the user.
> But in the KFENCE case this is always the case so kp_data_offset=0.
>

Ah, right. confused "pointer offset" with "data offset".
it's always 0 in kfence case.

> > BTW, I would prefer implementing something like kfence_obj_info()
> > (called by kmem_dump_obj() and called instead of kmem_obj_info())
> > for better readability.
> 
> Hmm, I guess that saves us from having to fix up both slab.c/slub.c. But
> it makes kmem_obj_info() error-prone to use. What if someone calls
> kmem_obj_info() in future somewhere else? That caller then would have to
> remember to also call kfence_obj_info().
>

Valid point.

> I'd prefer fixing it as close to the root-cause (in kmem_obj_info()) to
> avoid that.
> 
> What do you prefer?

Then what about something like this?

kmem_obj_info(object) {
	if (object is from kfence)
		__kfence_obj_info()
	else
		__kmem_obj_info()
}

> 
> > And when mem_dump_obj() is called, I guess it's for debugging purpose.
> > I think it would be better to let user know the object is allocated
> > from kfence pool. maybe adding if (is_kfence_address(object)) pr_cont(" kfence");
> > in kmem_dump_obj() would be enough?
> 
> We can add that.
> 
> Thanks,
> -- Marco

-- 
Thanks,
Hyeonggon
