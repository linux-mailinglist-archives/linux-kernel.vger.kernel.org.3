Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BBB55895A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiFWTl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiFWTlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:41:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0C21CCA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656012764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cEzj9L77P8v8qoCIIdtw9E/V13id72lLb1/JCaB9X5o=;
        b=T8PD7VS4Mt14OLNaPx1i7aE5/aYwqgT/zKTly9N4D2xlC4dBzT3MpjH96yuljide0upx9E
        /bXagSDS66f4219AQeDaZH+uEHSL9Vfk2pANrFqOJQQbiU3O4jHAfXVQZBM7w2XTGqPT+k
        ivqR42bT27+AtYKM1aefLqae51hLzQQ=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636--W7e8FeiMfCNfznZxVuMNA-1; Thu, 23 Jun 2022 15:32:43 -0400
X-MC-Unique: -W7e8FeiMfCNfznZxVuMNA-1
Received: by mail-io1-f69.google.com with SMTP id e195-20020a6bb5cc000000b0066cc9ece80fso216860iof.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cEzj9L77P8v8qoCIIdtw9E/V13id72lLb1/JCaB9X5o=;
        b=yDEawDEjAfkMaVpDVKXaHnPWodGqSxp00UXblas0R9rnySjK/HlCsY+Z8GD+LlXraH
         qGBYx1mq/roCML/pwpgQrVeBB03GPBqNpgTLhb0MipN5e2cUhxkLonYCD4sNtyUlC125
         8fDruLj84zD32sFYqwo5JT9cEZ5GCmEAdzddZsQia1BHS6hQ7S7mOrpUSFhpUjsW2WIs
         aGYsEpRUuvK0WP6x6mfCz01IdrAo7OglNdBTLLDZLJJzvwIFM5fSjC4utZx2iwTTdRAe
         aYxngTwXHlk5TK/WLyIPO1E/ECPgeXsEGVHXT7hUAq+KmyHsseO539bmIQMrtyMQvjRq
         jKRQ==
X-Gm-Message-State: AJIora+p5WUnIuyeEhst+pQ4GfoDHjE5z/BU4mVJ0Z3OgxeP55ms3oME
        NCAZHPyNgZGqPLSgoG9/JjkDGXHpnrinGOsg0AqSGieuawag3WHEVlU3SAGCC5l3FgYTHCEWvet
        fb8qqKqum13+OvDwOkNC68V+a
X-Received: by 2002:a05:6638:1301:b0:331:f2f0:a17e with SMTP id r1-20020a056638130100b00331f2f0a17emr6002358jad.141.1656012762856;
        Thu, 23 Jun 2022 12:32:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s65EoE7PAH6kAoTAtGR4qw5bac4MpVebXW5cXpFV1QXeylyQ+L/Y/fNAavK3gdSfdi9iPExw==
X-Received: by 2002:a05:6638:1301:b0:331:f2f0:a17e with SMTP id r1-20020a056638130100b00331f2f0a17emr6002319jad.141.1656012761972;
        Thu, 23 Jun 2022 12:32:41 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id z7-20020a923207000000b002d1d3b1abbesm173633ile.80.2022.06.23.12.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 12:32:41 -0700 (PDT)
Date:   Thu, 23 Jun 2022 15:32:39 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM Mailing List <linux-mm@kvack.org>
Subject: Re: [PATCH 3/4] kvm: Add new pfn error KVM_PFN_ERR_INTR
Message-ID: <YrS/13dBmSIpvd3C@xz-m1.local>
References: <20220622213656.81546-1-peterx@redhat.com>
 <20220622213656.81546-4-peterx@redhat.com>
 <YrR5U1mHP9fYQ1k9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrR5U1mHP9fYQ1k9@google.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 02:31:47PM +0000, Sean Christopherson wrote:
> On Wed, Jun 22, 2022, Peter Xu wrote:
> > Add one new PFN error type to show when we cannot finish fetching the PFN
> > due to interruptions.  For example, by receiving a generic signal.
> > 
> > This prepares KVM to be able to respond to SIGUSR1 (for QEMU that's the
> > SIGIPI) even during e.g. handling an userfaultfd page fault.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/linux/kvm_host.h | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index b646b6fcaec6..4f84a442f67f 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -96,6 +96,7 @@
> >  #define KVM_PFN_ERR_FAULT	(KVM_PFN_ERR_MASK)
> >  #define KVM_PFN_ERR_HWPOISON	(KVM_PFN_ERR_MASK + 1)
> >  #define KVM_PFN_ERR_RO_FAULT	(KVM_PFN_ERR_MASK + 2)
> > +#define KVM_PFN_ERR_INTR	(KVM_PFN_ERR_MASK + 3)
> >  
> >  /*
> >   * error pfns indicate that the gfn is in slot but faild to
> > @@ -106,6 +107,16 @@ static inline bool is_error_pfn(kvm_pfn_t pfn)
> >  	return !!(pfn & KVM_PFN_ERR_MASK);
> >  }
> >  
> > +/*
> > + * When KVM_PFN_ERR_INTR is returned, it means we're interrupted during
> > + * fetching the PFN (e.g. a signal might have arrived), so we may want to
> > + * retry at some later point and kick the userspace to handle the signal.
> > + */
> > +static inline bool is_intr_pfn(kvm_pfn_t pfn)
> > +{
> > +	return pfn == KVM_PFN_ERR_INTR;
> 
> What about is_sigpending_pfn() and KVM_PFN_ERR_SIGPENDING?  "intr" is too close to
> a real thing KVM will encounter, and I think knowing that KVM is effectively
> responding to a pending signal is the most important detail for KVM developers
> encountering this code for this first time.  E.g. from KVM_PFN_ERR_INTR alone, one
> might think that any interrupt during GUP will trigger this.

Sounds good; INTR could be too general for KVM indeed.  Thanks,

-- 
Peter Xu

