Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECE755898A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiFWTto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiFWTtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:49:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E457D5F9A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656013580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BFyjSv4yqYoLPIUfIrUH6yAVaXDxfw3QohX9kRJWVng=;
        b=C95qOfpSfHRZmNz2T7jzCLWNhf00NJhrPVKv2+w1xIiDCVheyyZAHCDSuf8iff7Gd8eUMh
        iNoMx7SsaFYNvl5XC9KE4wh7vtB7v5y2kqqQD6mrt3UV86cdtQp6JizQY1gSpsJwbptpZ/
        SeRZfgjfOgLf8YcfDJcrGRwaP6Nsmew=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-EpyvQDwNMp-H1f82-_FdqQ-1; Thu, 23 Jun 2022 15:46:19 -0400
X-MC-Unique: EpyvQDwNMp-H1f82-_FdqQ-1
Received: by mail-io1-f69.google.com with SMTP id n85-20020a6b8b58000000b00672792497b8so236463iod.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BFyjSv4yqYoLPIUfIrUH6yAVaXDxfw3QohX9kRJWVng=;
        b=zyUQj54EC+yiTpe5jkMkjoVIRsbr+ydG9/Rqa+nwFvxVNgtGRS5oOCuacIR7rIB0te
         5IP2QTKYxOPCY72bmjbDg7ZoWMnqTfAVAyZHjq4a+ZJsI24UnCYy9lEG9y/y9Ei+El7A
         8ekjQ5X4e59TeTSU91Qtm1NGT2QcODeW1Gfhzn9LUFssGxy1fLHrEW6CiyJEmKi84lH4
         qsb4rbDt4wEyO6ry82RoHcjWs1x7llyJO7xGu4pzGCV5LI/+51VbXY+sBaRABoNd3Esv
         X0xAvnYPkgm5cVrvtccehz570S+1bJKUBZp0C7pkeaXAUrfQ2vOCKNVTIPqA0/AeSJkH
         VmaA==
X-Gm-Message-State: AJIora8xzW+uhb8H6GdlzTSJDjVH9pFVAkhUMjpyKCgYEVayPdwjNIxO
        LLE0C5g+THnvxbyP0BcqLMdZl6FkdLIS57B1JGo32ibpq2lca1Z3djnWGIl++5ih1vMXbSjBRMl
        pyWp978fk3jxjFl+aFWIxYRjD
X-Received: by 2002:a05:6638:34a2:b0:339:eeed:e65e with SMTP id t34-20020a05663834a200b00339eeede65emr1844923jal.202.1656013578867;
        Thu, 23 Jun 2022 12:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s2jidDjwKi4+oOZL1EZ/+u6ihMVoMMf6fOmYdDweXZw+XLrQoYnmYeralcR2uOCBAxLGEwvw==
X-Received: by 2002:a05:6638:34a2:b0:339:eeed:e65e with SMTP id t34-20020a05663834a200b00339eeede65emr1844910jal.202.1656013578614;
        Thu, 23 Jun 2022 12:46:18 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id x42-20020a0294ad000000b00330c5581c03sm144313jah.1.2022.06.23.12.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 12:46:17 -0700 (PDT)
Date:   Thu, 23 Jun 2022 15:46:15 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM Mailing List <linux-mm@kvack.org>
Subject: Re: [PATCH 2/4] kvm: Merge "atomic" and "write" in
 __gfn_to_pfn_memslot()
Message-ID: <YrTDBwoddwoY1uSV@xz-m1.local>
References: <20220622213656.81546-1-peterx@redhat.com>
 <20220622213656.81546-3-peterx@redhat.com>
 <YrR9i3yHzh5ftOxB@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrR9i3yHzh5ftOxB@google.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 02:49:47PM +0000, Sean Christopherson wrote:
> On Wed, Jun 22, 2022, Peter Xu wrote:
> > Merge two boolean parameters into a bitmask flag called kvm_gtp_flag_t for
> > __gfn_to_pfn_memslot().  This cleans the parameter lists, and also prepare
> > for new boolean to be added to __gfn_to_pfn_memslot().
> 
> ...
> 
> > @@ -3999,8 +4000,8 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> >  	}
> >  
> >  	async = false;
> > -	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, &async,
> > -					  fault->write, &fault->map_writable,
> > +	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, flags,
> > +					  &async, &fault->map_writable,
> >  					  &fault->hva);
> >  	if (!async)
> >  		return RET_PF_CONTINUE; /* *pfn has correct page already */
> > @@ -4016,9 +4017,8 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> >  		}
> >  	}
> >  
> > -	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, NULL,
> > -					  fault->write, &fault->map_writable,
> > -					  &fault->hva);
> > +	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, flags, NULL,
> > +					  &fault->map_writable, &fault->hva);
> >  	return RET_PF_CONTINUE;
> >  }
> >  
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index c20f2d55840c..b646b6fcaec6 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -1146,8 +1146,15 @@ kvm_pfn_t gfn_to_pfn_prot(struct kvm *kvm, gfn_t gfn, bool write_fault,
> >  		      bool *writable);
> >  kvm_pfn_t gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn);
> >  kvm_pfn_t gfn_to_pfn_memslot_atomic(const struct kvm_memory_slot *slot, gfn_t gfn);
> > +
> > +/* gfn_to_pfn (gtp) flags */
> > +typedef unsigned int __bitwise kvm_gtp_flag_t;
> > +
> > +#define  KVM_GTP_WRITE          ((__force kvm_gtp_flag_t) BIT(0))
> > +#define  KVM_GTP_ATOMIC         ((__force kvm_gtp_flag_t) BIT(1))
> > +
> >  kvm_pfn_t __gfn_to_pfn_memslot(const struct kvm_memory_slot *slot, gfn_t gfn,
> > -			       bool atomic, bool *async, bool write_fault,
> > +			       kvm_gtp_flag_t gtp_flags, bool *async,
> >  			       bool *writable, hva_t *hva);
> 
> I completely agree the list of booleans is a mess, but I don't love the result of
> adding @flags.  I wonder if we can do something similar to x86's struct kvm_page_fault
> and add an internal struct to pass params.

Yep we can.  It's just that it'll be another goal irrelevant of this series
but it could be a standalone cleanup patchset for gfn->hpa conversion
paths.  Say, the new struct can also be done on top containing the new
flag, IMHO.

This reminded me of an interesting topic that Nadav used to mention that
when Matthew changed some of the Linux function parameters into a structure
then the .obj actually grows a bit due to the strong stack protector that
Linux uses.  If I'll be doing such a change I'd guess I need to dig a bit
into that first, but hopefully I don't need to for this series alone.

Sorry to be off-topic: I think it's a matter of whether you think it's okay
we merge the flags first, even if we want to go with a struct pointer
finally.

> And then add e.g. gfn_to_pfn_interruptible() to wrap that logic.

That helper sounds good, it's just that the major user I'm modifying here
doesn't really use gfn_to_pfn() at all but __gfn_to_pfn_memslot()
underneath.  I'll remember to have that when I plan to convert some
gfn_to_pfn() call sites.

> 
> I suspect we could also clean up the @async behavior at the same time, as its
> interaction with FOLL_NOWAIT is confusing.

Yeah I don't like that either.  Let me think about that when proposing a
new version.  Logically that's separate idea from this series too, but if
you think that'll be nice to have altogether then I can give it a shot.

Thanks,

-- 
Peter Xu

