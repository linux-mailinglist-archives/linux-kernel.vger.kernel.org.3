Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974824B2C0E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352303AbiBKRtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:49:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345022AbiBKRtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:49:17 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993DC2C9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:49:16 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id y84so12411547iof.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ik2y23ex7UvkAohqkU716AwejNLp20RatBHLDCgOFXY=;
        b=D5A5Exk1ZOsRPNTm5yFWdRYfTdu0wAI6+ohF/3KIUWZ6KEZJRT9EbblyIcggQdsaFF
         lLKajO4gSLXNMBNG1S2yxebjV3b348F5AENwKg3ghYQuSX890bo3FOzZEuQOGDIxZ6DN
         mwcAw6Rjb7nGDCyKYdsegEB2Axg1E4iHdRDXj/tKzMhA1UdbWKFBWzu8Q3LYwy16AhGa
         lwD0MB4vi3d4MP+bx4oGZA2LWBCHFm0Cihqc5z/kwh7WK1hSpaA5zGV0UrzgWEFrJN/5
         j2P1Q2R06y02OkvNvM8FiHIpstBhp66X9hLEYh73x5gllsddo0egJlIP2LkQ6X1KZ+7n
         e0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ik2y23ex7UvkAohqkU716AwejNLp20RatBHLDCgOFXY=;
        b=1Ub58wUg0we0Gkg3sIe3wRCba0mEv/o4tHx3YpJF5iYkFW6H/zKtvE1JZxA31ZZ158
         SPlW4RKBkQDzIXymZG07FbCeyuBHp3m3SvKZJuICzJG3370vZFJMEcFZbqdF9pmO3ueg
         3NA5jg23icLaf8FdTBx69v3/g3fpqJrZGnnaZbM6ZS0Jf2rhBYFqM4FUo9hH/wGDZCzr
         9adiUBwdgu13r/C4rropS+HG0n7AouosJJ9fpQjB4JTo+sdOJeogGJbX+0Y4N2YyFwz9
         aM9MO0ebkRk6/SM81nSVrTYHRNOQePf1MwLpGOSde2gtLvuMuLqTpmsLyzDuVbj8xJh8
         EX7g==
X-Gm-Message-State: AOAM533Fr+k2QZdR2z8xV8wusnc08XoWTn+qBroRzmYQR6ivqNLChba6
        ItrmCSYhRnPLeNEMABkW5bw=
X-Google-Smtp-Source: ABdhPJyrKXdrO1F+YSAIpLlDPjuyEzL5x1GDfgm89yW+CNfM8kQNdtk//y+pzL4a2D9bgGp9SnOSYw==
X-Received: by 2002:a02:9429:: with SMTP id a38mr1440857jai.43.1644601754764;
        Fri, 11 Feb 2022 09:49:14 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id p5sm5419030ilo.37.2022.02.11.09.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 09:49:14 -0800 (PST)
Date:   Fri, 11 Feb 2022 09:47:03 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH 07/49] KVM: x86: replace bitmap_weight with bitmap_empty
 where appropriate
Message-ID: <YgahFz55dJpofbkR@yury-laptop>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-8-yury.norov@gmail.com>
 <ea4efad6-a15c-3749-f177-640396b52857@wanadoo.fr>
 <YgaaqJNPyGvw9uKi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgaaqJNPyGvw9uKi@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 05:19:36PM +0000, Sean Christopherson wrote:
> On Fri, Feb 11, 2022, Christophe JAILLET wrote:
> > Le 10/02/2022 à 23:48, Yury Norov a écrit :
> > > In some places kvm/hyperv.c code calls bitmap_weight() to check if any bit
> > > of a given bitmap is set. It's better to use bitmap_empty() in that case
> > > because bitmap_empty() stops traversing the bitmap as soon as it finds
> > > first set bit, while bitmap_weight() counts all bits unconditionally.
> > > 
> > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > ---
> > >   arch/x86/kvm/hyperv.c | 8 ++++----
> > >   1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> > > index 6e38a7d22e97..06c2a5603123 100644
> > > --- a/arch/x86/kvm/hyperv.c
> > > +++ b/arch/x86/kvm/hyperv.c
> > > @@ -90,7 +90,7 @@ static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
> > >   {
> > >   	struct kvm_vcpu *vcpu = hv_synic_to_vcpu(synic);
> > >   	struct kvm_hv *hv = to_kvm_hv(vcpu->kvm);
> > > -	int auto_eoi_old, auto_eoi_new;
> > > +	bool auto_eoi_old, auto_eoi_new;
> > >   	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
> > >   		return;
> > > @@ -100,16 +100,16 @@ static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
> > >   	else
> > >   		__clear_bit(vector, synic->vec_bitmap);
> > > -	auto_eoi_old = bitmap_weight(synic->auto_eoi_bitmap, 256);
> > > +	auto_eoi_old = !bitmap_empty(synic->auto_eoi_bitmap, 256);
> > 
> > I think that you can also remove the "!" here, ...
> > 
> > >   	if (synic_has_vector_auto_eoi(synic, vector))
> > >   		__set_bit(vector, synic->auto_eoi_bitmap);
> > >   	else
> > >   		__clear_bit(vector, synic->auto_eoi_bitmap);
> > > -	auto_eoi_new = bitmap_weight(synic->auto_eoi_bitmap, 256);
> > > +	auto_eoi_new = !bitmap_empty(synic->auto_eoi_bitmap, 256);
> > 
> > ... and there...
> > 
> > > -	if (!!auto_eoi_old == !!auto_eoi_new)
> > > +	if (auto_eoi_old == auto_eoi_new)
> > 
> > ... because this test would still give the same result.

This is how it was in v3. Vitaly asked to add '!' to keep variables
names correct.
https://lore.kernel.org/lkml/CAAH8bW_u6oNOkMsA_jRyWFHkzjMi0CB7gXmvLYAdjNMSqrrY7w@mail.gmail.com/t/#m51d28c03eafed5754a69f95f24c7d0a0510cc5c0
> 
> It would give the same result, but the variable names would be inverted as they
> track if "auto EOI" is being used.  So yes, it's technically unnecessary, but
> also very deliberate.

auto_eoi_old_not_used = bitmap_empty() is worse to me than
auto_eoi_old = !bitmap_empty().

Thanks,
Yury
