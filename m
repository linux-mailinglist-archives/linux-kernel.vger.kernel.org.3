Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5FD4F5CF0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiDFLqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiDFLph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:45:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA8E4A8303
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:34:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k23so2047067wrd.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 01:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sy9/diqlZ0NjRt8BB+2epNWQYn7jivSudBIkV/TeeDI=;
        b=mU0swcop93ykjhIFQc1HeJkfpBJNU+vMxOeRu2S5JC1WYBV36R3sdMTzqO9vVKqvp3
         venFCmkPp0YgHq/LoCrw/dvgdt9YL1Y5I26Xlg0RE4FtILLuQCr+JaywByn6B6WBj26D
         zvXEmvz1+gIakaAfIFEUXQ9WDl4SUGNoC1HlE5M0OBa9P4tii83UDSZ32dRAtjpZsTKA
         gqUkxoShMobW3tZ2EIPpEuauu/NMiG3Wy2C/q5h6NLZalpDp94EomL9ipuhsKHSC4T5y
         x7u5TKafUHzR4BQyYn6g6X+dyd0+Q5TBEn4JmgC8zoq9tFRyjWmXgEYy6ZQXCM7K9XT5
         ygYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sy9/diqlZ0NjRt8BB+2epNWQYn7jivSudBIkV/TeeDI=;
        b=J8yJSfgQc/nNhsNZ91I2sgsCRsz8/VjNqS/HY3+7HbrDFj3WI1thaPCRuLXGOewdkC
         ZX+hbTiFsjKxTMMObZThtpT5ZClcxNf6emDe2YDIpBSwEJ26x+tBJnRBJsbO4GA6EQB8
         6syOMFtammCtCzejL+KYNxwVXOxOrpwPz/KalOuIySe/IEsFL/POTYDrA3vYz22YujiV
         E9UGAr/RN4eLok9DstRfgLJKXf/Wq8q0sb4FLO2vmXbjDFxlJ+xi0UwaPNO0Cs3C5RR3
         O075dQVgepaVkqwg9LHOupTGwMZDOPNH1aO4ikdweFdc4AbFOKQFFipgZ5189jFyiHrQ
         aRUA==
X-Gm-Message-State: AOAM532/zF5Udm0u6hB1Qh/p+vBEAHNKcyFcnofVIrgaZSj2AIon8dku
        Xvw+oZhQ3N7EzVjhYttO6qDErA==
X-Google-Smtp-Source: ABdhPJya+dxfdK2PFIRuCcN2FYfCo74pr//WUnFxZQTKLVuUDPAnVDeF/C8ts/Bmi8pzFIy878zhZQ==
X-Received: by 2002:adf:fd04:0:b0:206:1cb8:7061 with SMTP id e4-20020adffd04000000b002061cb87061mr5689742wrr.314.1649234054926;
        Wed, 06 Apr 2022 01:34:14 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:5d29:f2b6:6b0b:ac46])
        by smtp.gmail.com with ESMTPSA id b3-20020adfd1c3000000b00205820686dasm16163941wrd.5.2022.04.06.01.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 01:34:14 -0700 (PDT)
Date:   Wed, 6 Apr 2022 10:34:07 +0200
From:   Marco Elver <elver@google.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
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
Message-ID: <Yk1Qf73cufW6LjOW@elver.google.com>
References: <20220323090520.GG16885@xsang-OptiPlex-9020>
 <20220324095218.GA2108184@odroid>
 <YkcfNjZJSXNsAlLt@hyeyoo>
 <YkpgjgM/aSXd29uj@hyeyoo>
 <Ykqn2z9UVfxFwiU+@elver.google.com>
 <8368021e-86c3-a93f-b29d-efed02135c41@suse.cz>
 <CANpmjNMupGGbTDD-ZEY=acTbqguvWgLzb1ZVRbG9TyuF50Ch+Q@mail.gmail.com>
 <Ykui2prpzkMvaWBa@hyeyoo>
 <YkwjCUbTbRqslphe@elver.google.com>
 <YkzHG64zxu+nWbg3@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkzHG64zxu+nWbg3@hyeyoo>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 07:47AM +0900, Hyeonggon Yoo wrote:
> On Tue, Apr 05, 2022 at 01:07:53PM +0200, Marco Elver wrote:
> > On Tue, Apr 05, 2022 at 11:00AM +0900, Hyeonggon Yoo wrote:
> > > On Mon, Apr 04, 2022 at 05:18:16PM +0200, Marco Elver wrote:
> > > > On Mon, 4 Apr 2022 at 16:20, Vlastimil Babka <vbabka@suse.cz> wrote:
> > [...]
> > > > > But here we are in mem_dump_obj() -> kmem_dump_obj() -> kmem_obj_info().
> > > > > Because kmem_valid_obj() returned true, fooled by folio_test_slab()
> > > > > returning true because of the /* Set required slab fields. */ code.
> > > > > Yet the illusion is not perfect and we read garbage instead of a valid
> > > > > stackdepot handle.
> > > > >
> > > > > IMHO we should e.g. add the appropriate is_kfence_address() test into
> > > > > kmem_valid_obj(), to exclude kfence-allocated objects? Sounds much simpler
> > > > > than trying to extend the illusion further to make kmem_dump_obj() work?
> > > > > Instead kfence could add its own specific handler to mem_dump_obj() to print
> > > > > its debugging data?
> > > > 
> > > > I think this explanation makes sense!  Indeed, KFENCE already records
> > > > allocation stacks internally anyway, so it should be straightforward
> > > > to convince it to just print that.
> > > >
> > > 
> > > Thank you both! Yeah the explanation makes sense... thats why KASAN/KCSAN couldn't yield anything -- it was not overwritten.
> > > 
> > > I'm writing a fix and will test if the bug disappears.
> > > This may take few days.
> >
> 
> I did check the bug is not reproduced after simple fix. (reproduced 0 of 373)
> This approach was right.
> 
> > The below should fix it -- I'd like to make kmem_obj_info() do something
> > useful for KFENCE objects.
> >
> 
> Agreed.
> 
[...]
> > +	i = get_stack_skipnr(track->stack_entries, track->num_stack_entries, NULL);
> > +	for (j = 0; i < track->num_stack_entries && j < KS_ADDRS_COUNT - 1; ++i, ++j)
> 
> why KS_ADDRS_COUNT - 1 instead of KS_ADDRS_COUNT?

For `kp_stack[j] = NULL` because KFENCE's stack_entries does not have a
NULL-delimiter (we have num_stack_entries). But it seems for kp_stack
it's only added if `j < KS_ADDR_COUNT`, so I've fixed that.

> > +		kp_stack[j] = (void *)track->stack_entries[i];
> > +	kp_stack[j] = NULL;
[...]
> > +	kpp->kp_objp = (void *)meta->addr;
> > +
> 
> no need to take meta->lock here?

Yes, in case state is KFENCE_OBJECT_FREED there could be a race.

> > +	kfence_to_kp_stack(&meta->alloc_track, kpp->kp_stack);
> > +	if (meta->state == KFENCE_OBJECT_FREED)
> > +		kfence_to_kp_stack(&meta->free_track, kpp->kp_free_stack);
> > +	/* get_stack_skipnr() ensures the first entry is outside allocator. */
> > +	kpp->kp_ret = kpp->kp_stack[0];
> > +
> > +	return true;
> > +}
> 
> kfence_kmem_obj_info() does not set kp_data_offset. kp_data_offset
> may not be zero when e.g.) mem_dump_obj(&rhp->func); in rcutorture case. 

kp_data_offset is the offset e.g. when SLUB has added a redzone:

|		objp0 = kasan_reset_tag(object);
|	#ifdef CONFIG_SLUB_DEBUG
|		objp = restore_red_left(s, objp0);
|	#else
|		objp = objp0;
|	#endif
|		objnr = obj_to_index(s, slab, objp);
|		kpp->kp_data_offset = (unsigned long)((char *)objp0 - (char *)objp);

In !CONFIG_SLUB_DEBUG and !(s->flags & SLAB_RED_ZONE) cases it's always
0, and otherwise it's

	`objp0 - restore_red_left(objp0)` ==
	`object - (object - s->red_left_pad)` ==
	`s->red_left_pad`.

This matters if kp_objp is not the object start accessible by the user.
But in the KFENCE case this is always the case so kp_data_offset=0.

> BTW, I would prefer implementing something like kfence_obj_info()
> (called by kmem_dump_obj() and called instead of kmem_obj_info())
> for better readability.

Hmm, I guess that saves us from having to fix up both slab.c/slub.c. But
it makes kmem_obj_info() error-prone to use. What if someone calls
kmem_obj_info() in future somewhere else? That caller then would have to
remember to also call kfence_obj_info().

I'd prefer fixing it as close to the root-cause (in kmem_obj_info()) to
avoid that.

What do you prefer?

> And when mem_dump_obj() is called, I guess it's for debugging purpose.
> I think it would be better to let user know the object is allocated
> from kfence pool. maybe adding if (is_kfence_address(object)) pr_cont(" kfence");
> in kmem_dump_obj() would be enough?

We can add that.

Thanks,
-- Marco
