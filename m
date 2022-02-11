Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152D94B2B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352031AbiBKRTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:19:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350205AbiBKRTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:19:43 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF2C9E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:19:42 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v4so8703390pjh.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Soyj3aZvT5q9ejG6zFoQCWtEuSPJG4bJZO5/tkCuRZI=;
        b=l0dH7pI8n6Rz9X9dAE7DNWfHZHn7mDUiMqKR4VQq/s8FNNCstRZGLzVIpiT2rmqnHQ
         krJYvyxgZf2HxGGEoZPj39YzLA5hVopgKsaLJHuhJJWPJtryCaHIpcy38+ivlTMBtk0p
         JqA30MaVBmymqVydgdG8xzvp4Obl7X98ZtWakVALDkRORaxQoJfhaBc9IrtbsURJUnBr
         kxO6vZuWPghwpV7PYadgVTBsgAJvxxoXaB7g0W9cGBHYE3Pr8ZSa8BM6P3YWwQsLkmWX
         JsDIBK+N9X1skp7rCrQ7r1CsDK8HKpVBTmtUDCuikPopbJMzGiFzmFADnE6H63HgpgRl
         2E8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Soyj3aZvT5q9ejG6zFoQCWtEuSPJG4bJZO5/tkCuRZI=;
        b=naeKBP/R3oAc3+GzfrT7n2bK/zfc3hm1zhk96UQhxXTjud8WknxrS607/MLN+yCApL
         D21OatFedFvpqZCDqDmP1ZT94Lc/Id8qDcFmCM6OqW5z7ZKYj1LwdEuESO9EdIQZ9ZlR
         EIznPTgtevfuFwbPSkuwausqmPVLJafSrIcxPcAiNO4Lcc1dQ8ZYnx5osiNHxXKfVbxk
         3fPuVSTAuT0VuPnde5USuMpAdRFZeJp3VfRHFsx5xQYEdscl9qrZezxgH3dyiaOUakQl
         DD5TTvTJHAdxMmeP9kCdMZotwmeq1vE+2VNkzcaEnm0BYxaflVminBXv1wsEI+TY16jd
         LT4A==
X-Gm-Message-State: AOAM531GySow6m30cOGLzr7XXto/q9sJAY9GjnanqDrp5/EdyHEnnVPc
        CzqYGD+fqrW8P++0ANMrbWI4AQ==
X-Google-Smtp-Source: ABdhPJwd2aQOWYn3MhHGc7gq2LezIAgDQzOs9tUl0Uzlbz/oe+1rAzsM4ZCojfexaCnwCPW1e4KgJw==
X-Received: by 2002:a17:902:b414:: with SMTP id x20mr2505165plr.14.1644599981408;
        Fri, 11 Feb 2022 09:19:41 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 19sm5828412pjb.42.2022.02.11.09.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 09:19:40 -0800 (PST)
Date:   Fri, 11 Feb 2022 17:19:36 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Yury Norov <yury.norov@gmail.com>,
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
Message-ID: <YgaaqJNPyGvw9uKi@google.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-8-yury.norov@gmail.com>
 <ea4efad6-a15c-3749-f177-640396b52857@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea4efad6-a15c-3749-f177-640396b52857@wanadoo.fr>
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

On Fri, Feb 11, 2022, Christophe JAILLET wrote:
> Le 10/02/2022 à 23:48, Yury Norov a écrit :
> > In some places kvm/hyperv.c code calls bitmap_weight() to check if any bit
> > of a given bitmap is set. It's better to use bitmap_empty() in that case
> > because bitmap_empty() stops traversing the bitmap as soon as it finds
> > first set bit, while bitmap_weight() counts all bits unconditionally.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > ---
> >   arch/x86/kvm/hyperv.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> > index 6e38a7d22e97..06c2a5603123 100644
> > --- a/arch/x86/kvm/hyperv.c
> > +++ b/arch/x86/kvm/hyperv.c
> > @@ -90,7 +90,7 @@ static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
> >   {
> >   	struct kvm_vcpu *vcpu = hv_synic_to_vcpu(synic);
> >   	struct kvm_hv *hv = to_kvm_hv(vcpu->kvm);
> > -	int auto_eoi_old, auto_eoi_new;
> > +	bool auto_eoi_old, auto_eoi_new;
> >   	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
> >   		return;
> > @@ -100,16 +100,16 @@ static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
> >   	else
> >   		__clear_bit(vector, synic->vec_bitmap);
> > -	auto_eoi_old = bitmap_weight(synic->auto_eoi_bitmap, 256);
> > +	auto_eoi_old = !bitmap_empty(synic->auto_eoi_bitmap, 256);
> 
> I think that you can also remove the "!" here, ...
> 
> >   	if (synic_has_vector_auto_eoi(synic, vector))
> >   		__set_bit(vector, synic->auto_eoi_bitmap);
> >   	else
> >   		__clear_bit(vector, synic->auto_eoi_bitmap);
> > -	auto_eoi_new = bitmap_weight(synic->auto_eoi_bitmap, 256);
> > +	auto_eoi_new = !bitmap_empty(synic->auto_eoi_bitmap, 256);
> 
> ... and there...
> 
> > -	if (!!auto_eoi_old == !!auto_eoi_new)
> > +	if (auto_eoi_old == auto_eoi_new)
> 
> ... because this test would still give the same result.

It would give the same result, but the variable names would be inverted as they
track if "auto EOI" is being used.  So yes, it's technically unnecessary, but
also very deliberate.
