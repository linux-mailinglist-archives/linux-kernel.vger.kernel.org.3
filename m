Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B14056A6A0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 17:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbiGGPHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 11:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbiGGPHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 11:07:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B77A62F03C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657206416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UinEqYT5P2BUTkxNTDp3jNgzt4lAPnjhnDB8MAsyPX4=;
        b=MVaVvIycFuwozBrnB4hWejJs5k8Fh7sCF1QLW1r/CaVTxSDg9Tv6KZ6joTgI7RcGWtl+wt
        KUcJmc8t5FBuhqrCEfUCfFKz3M5DijNlvmYPp8II/gN88TeJxQ5a6pR09tH6sqT67lmQQn
        ks0JWAah3B3A74W+BMFzxZYmm0zH3mY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-z5NZvASGPCOJNCzHmLOF3w-1; Thu, 07 Jul 2022 11:06:54 -0400
X-MC-Unique: z5NZvASGPCOJNCzHmLOF3w-1
Received: by mail-qt1-f198.google.com with SMTP id j29-20020ac8405d000000b0031e9bb077dfso1445201qtl.15
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 08:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UinEqYT5P2BUTkxNTDp3jNgzt4lAPnjhnDB8MAsyPX4=;
        b=Kp+kqAM8+PjoRGnC2m5t2sumKT5cKuX94Rui/4iC3eCdflXMOY32nZhaiAHVCpCJw9
         5xghZts0v3WZi5n9VWHJvTezHTN/lg5sZuHZdWS5KBQBGstskIHJaWClsdXR2aTg8jkP
         YBcOVFrIyJSZIAci7leALpZ1uI61DO8o+4S3WyyXlCpva3P4QKhUp1hes+VAOPXQGVZ7
         3tPzScni5yRyesHIfnx3yh7k/J+e28E7JU64X/l+obQdr+QKBfptRXKrnk/k/bJLFwSi
         LAZM2gxPqcquWSL1LTXIPifXn7ysMRn1sW0pusro/PnoGxYkB1IXNJWf7ao55wlA0KjF
         XoXQ==
X-Gm-Message-State: AJIora9n4jN8M6tCxJ2liYqL8zSZnRCg0Ylo8P/3Za4cdLvgwSBKvWOA
        Cdc9I3gjoT3nIglILddhGS84lVSpfVuXVgPAx+NFDMSuF9CyL23sWb688eSi+D7WGf4xddS4loC
        McvFIiZxnnK2g9CS9NptheNau
X-Received: by 2002:a05:620a:1ed:b0:6b5:51ef:a01b with SMTP id x13-20020a05620a01ed00b006b551efa01bmr2234442qkn.672.1657206413984;
        Thu, 07 Jul 2022 08:06:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1veVQQ17tD7Ufgu37nRA9WzoyJWV+Q9os145bMm7/zYt0YRDhjZ/MSZMr+nKljNFfFJ65mMdA==
X-Received: by 2002:a05:620a:1ed:b0:6b5:51ef:a01b with SMTP id x13-20020a05620a01ed00b006b551efa01bmr2234378qkn.672.1657206413610;
        Thu, 07 Jul 2022 08:06:53 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-85.dsl.bell.ca. [74.12.30.85])
        by smtp.gmail.com with ESMTPSA id j17-20020ac84c91000000b002f39b99f6a4sm20992646qtv.62.2022.07.07.08.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 08:06:52 -0700 (PDT)
Date:   Thu, 7 Jul 2022 11:06:49 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 1/4] mm/gup: Add FOLL_INTERRUPTIBLE
Message-ID: <Ysb2iW/MniHX6BXL@xz-m1.local>
References: <20220622213656.81546-1-peterx@redhat.com>
 <20220622213656.81546-2-peterx@redhat.com>
 <YsNuMSuneND6KW3o@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsNuMSuneND6KW3o@casper.infradead.org>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 11:48:17PM +0100, Matthew Wilcox wrote:
> On Wed, Jun 22, 2022 at 05:36:53PM -0400, Peter Xu wrote:
> > +/*
> > + * GUP always responds to fatal signals.  When FOLL_INTERRUPTIBLE is
> > + * specified, it'll also respond to generic signals.  The caller of GUP
> > + * that has FOLL_INTERRUPTIBLE should take care of the GUP interruption.
> > + */
> > +static bool gup_signal_pending(unsigned int flags)
> > +{
> > +	if (fatal_signal_pending(current))
> > +		return true;
> > +
> > +	if (!(flags & FOLL_INTERRUPTIBLE))
> > +		return false;
> > +
> > +	return signal_pending(current);
> > +}
> 
> This should resemble signal_pending_state() more closely, if indeed not
> be a wrapper of signal_pending_state().

Could you be more specific?  Note that the only thing that should affect
the signal handling here is FOLL_INTERRUPTIBLE, we don't allow anything
else being passed in, e.g. we don't take TASK_INTERRUPTIBLE or TASK_*.

Thanks,

-- 
Peter Xu

