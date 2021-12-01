Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4183A46458E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 04:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346529AbhLADpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 22:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346505AbhLADpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 22:45:22 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D7AC061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 19:42:01 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id x131so22859865pfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 19:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NE9G2ogVvwUzEMtjRR0HuwtGydEfUCq3tkmJ5Vm6wmo=;
        b=UIJlPL3e3WF8Rct34RDg5d7TPLTmUDt7TweV4msP1SXPGal+nv992t25b0bOVxLKAV
         GMm3gGiiSijhGFcHnQ5rIHWH5qkg4e9CNQ6vBcwKK83B1oWwOuo4oBnCxBn8cZE6ctaB
         xMI6BthaHm8SRZQpfMpD9YaSsriVJFrFfaqUxr8QuyydwfA0+4zA8nsPRzjLkh+oTB0D
         HE7k7qxl8i3yLJbU55sp37sAKx5Wi3Ko4NpsSrGEYb12JwPXpXLgzbUd+fo5Nuc6It3Z
         Mux1VAHxMIV+2TL+7xOSrVE/1tzo2vV6nigg7ZGbUO60Jn6WV5nxWUt2ZraXbF2HvI+j
         HJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NE9G2ogVvwUzEMtjRR0HuwtGydEfUCq3tkmJ5Vm6wmo=;
        b=kI0oX1rNeiFYQXSP2k4Q/uoMCdDofBu6w/uGiLJ4ANJOsHir+c3XSH/hSNU9Hx/xk1
         PbuRzg9GgJ43npaHxGs0/FGHGodPoqRqIqMmgTHa9815QehEGiyCXApu6J4u1AmXbNqa
         fQTm+DrjMN9htcprZ6brXC0U7dI/FA2GR9yiv763URHaeg/kjkJusXIT7bZoyT4BYwhU
         9JrPBWHCx9aAfcZzRPme4hqKalFzD2LG3QPS/JEf35YUvhjqt/IAok6F8dxqVnBusZOz
         qVviyzol46Kd+EvjpxBe7mnToPvbRxuTyW+Z1owFufJ7HIThwgo9gBnoJMciKUxAXLYL
         IUWA==
X-Gm-Message-State: AOAM532qDBBD3LUcGkckXCl1bGw2nybydT37DHSnRTOsQNTNejaP2BP7
        dXRTOI8zgC1gJyBE4bRDh5q0lw==
X-Google-Smtp-Source: ABdhPJwPKMNm2/53g0E5ccPTs+CPHPUhyATcwHEuYdtFYkrZc2zlgCFugLVWeUF/qa5HdmDxkoYzzA==
X-Received: by 2002:a05:6a00:1693:b0:44c:64a3:d318 with SMTP id k19-20020a056a00169300b0044c64a3d318mr3260064pfc.81.1638330121243;
        Tue, 30 Nov 2021 19:42:01 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id ng9sm4517480pjb.4.2021.11.30.19.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 19:42:00 -0800 (PST)
Date:   Wed, 1 Dec 2021 03:41:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Igor Mammedov <imammedo@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        Ben Gardon <bgardon@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 26/29] KVM: Optimize gfn lookup in kvm_zap_gfn_range()
Message-ID: <YabvBW90COsfdoYx@google.com>
References: <cover.1638304315.git.maciej.szmigiero@oracle.com>
 <a39db04edcacfe955c660e2f139f948cf29362f5.1638304316.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a39db04edcacfe955c660e2f139f948cf29362f5.1638304316.git.maciej.szmigiero@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021, Maciej S. Szmigiero wrote:
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 41efe53cf150..6fce6eb797a7 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -848,6 +848,105 @@ struct kvm_memory_slot *id_to_memslot(struct kvm_memslots *slots, int id)
>  	return NULL;
>  }
>  
> +/* Iterator used for walking memslots that overlap a gfn range. */
> +struct kvm_memslot_iter {
> +	struct kvm_memslots *slots;
> +	gfn_t end;
> +	struct rb_node *node;
> +};

...

> +static inline struct kvm_memory_slot *kvm_memslot_iter_slot(struct kvm_memslot_iter *iter)
> +{
> +	return container_of(iter->node, struct kvm_memory_slot, gfn_node[iter->slots->node_idx]);

Having to use a helper in callers of kvm_for_each_memslot_in_gfn_range() is a bit
ugly, any reason not to grab @slot as well?  Then the callers just do iter.slot,
which IMO is much more readable.

And if we do that, I'd also vote to omit slots and end from the iterator.  It would
mean passing in slots and end to kvm_memslot_iter_is_valid() and kvm_memslot_iter_next(),
but that's more idiomatic in a for-loop if iter is considered to be _just_ the iterator
part.  "slots" is arguable, but "end" really shouldn't be part of the iterator.

> +}
> +
> +static inline bool kvm_memslot_iter_is_valid(struct kvm_memslot_iter *iter)
> +{
> +	struct kvm_memory_slot *memslot;
> +
> +	if (!iter->node)
> +		return false;
> +
> +	memslot = kvm_memslot_iter_slot(iter);
> +
> +	/*
> +	 * If this slot starts beyond or at the end of the range so does
> +	 * every next one
> +	 */
> +	return memslot->base_gfn < iter->end;
> +}
> +
> +static inline void kvm_memslot_iter_next(struct kvm_memslot_iter *iter)
> +{
> +	iter->node = rb_next(iter->node);
> +}
> +
> +/* Iterate over each memslot at least partially intersecting [start, end) range */
> +#define kvm_for_each_memslot_in_gfn_range(iter, slots, start, end)	 \
> +	for (kvm_memslot_iter_start(iter, slots, start, end);		 \
> +	     kvm_memslot_iter_is_valid(iter);				 \
> +	     kvm_memslot_iter_next(iter))
> +
>  /*
>   * KVM_SET_USER_MEMORY_REGION ioctl allows the following operations:
>   * - create a new memory slot
