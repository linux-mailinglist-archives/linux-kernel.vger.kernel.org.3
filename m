Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF2E55E04A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbiF0P36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbiF0P3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A904F19289
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656343791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h1/trUpMNLnNGyxwx4diC/Ki/CZLIBKxLxUT9R2hz7A=;
        b=ZolJ/8IonSKWTE/g4XrGF9Nz9tot6da63w181aiJOV2bN/CcDz3x0PSu3CuuNxvLBQEGzD
        xpNbn0nB5d+BK0mnJQtJ1NdDjnk+6H/Te0d9PX0MpAHiJKaAcJZMJvn/SJV3Ytp1YVzUUx
        iolnPZ8H1PEyR+Dzg72qpzLLUyKMLUE=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-Lzli3YyYMr6unj7vwSEWew-1; Mon, 27 Jun 2022 11:29:50 -0400
X-MC-Unique: Lzli3YyYMr6unj7vwSEWew-1
Received: by mail-il1-f197.google.com with SMTP id a6-20020a92a306000000b002da987fc9f2so1395867ili.17
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h1/trUpMNLnNGyxwx4diC/Ki/CZLIBKxLxUT9R2hz7A=;
        b=JB1x/x8+rdqjQCBXWyaFTT2LqVXeED65EyT8nntZb6LQgtj68KKoEVhS3cGTzgmDZ3
         gZ3y/ngQs4xnYkBuE2xG8Nqdv46R6VpOkIpbOWy+x8OfPxWaWRheelSJl7ML016QA4fv
         yoHZx1SNdsj7EXNYmwAIelGMAsSAOakLFLFbZ25mi8nGMUIoNDPLzEjx053vY8E6qdza
         i3sG35VVf6szTQxkW1TiL43Kx8Do+eANui9NN7IyIBNewJ5A7IvYbBwHKGL8by6AtlhH
         S/sf4lDFL865qPnsupJGmjDrIuixndxe62z/iLCdEYop4IWHv1eAzQPnvtPKb+ZgK9Ge
         B43Q==
X-Gm-Message-State: AJIora/hbhqg2NjuJCOZg6+EWpcIEZG1VdO9gtujaJS73MhaeAwRuSGQ
        ZJli9+RBgHu+FdBc0fUKw1FrAMMB6/n33jOl1R8+ofQzGpgZK8k+lsckPk0glxATRSrS2VbPEmw
        x6hE1pJb0h2oElIACUdQPqLGE
X-Received: by 2002:a05:6638:13d5:b0:331:a6f2:3dbf with SMTP id i21-20020a05663813d500b00331a6f23dbfmr8013033jaj.9.1656343789724;
        Mon, 27 Jun 2022 08:29:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uGpsqgUWS6Ce0E8mwLwamXIm8UbctHTOly4JQ9TWGUiHMN6AjyXmJH3vXAr+/oepx37YDf+Q==
X-Received: by 2002:a05:6638:13d5:b0:331:a6f2:3dbf with SMTP id i21-20020a05663813d500b00331a6f23dbfmr8013019jaj.9.1656343789476;
        Mon, 27 Jun 2022 08:29:49 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id d1-20020a026041000000b00331f63a3dfasm4808082jaf.122.2022.06.27.08.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:29:48 -0700 (PDT)
Date:   Mon, 27 Jun 2022 11:29:47 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 1/4] mm/gup: Add FOLL_INTERRUPTIBLE
Message-ID: <YrnM6x7QWo6NmFqf@xz-m1.local>
References: <20220622213656.81546-1-peterx@redhat.com>
 <20220622213656.81546-2-peterx@redhat.com>
 <20220625003554.GJ23621@ziepe.ca>
 <YrZjeEv1Z2IDMwgy@xz-m1.local>
 <20220625235904.GK23621@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220625235904.GK23621@ziepe.ca>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 08:59:04PM -0300, Jason Gunthorpe wrote:
> On Fri, Jun 24, 2022 at 09:23:04PM -0400, Peter Xu wrote:
> > If to go back to the original question with a shorter answer: if the ioctl
> > context that GUP upon a page that will never be with a uffd context, then
> > it's probably not gonna help at all.. at least not before we use
> > FAULT_FLAG_INTERRUPTIBLE outside uffd page fault handling.
> 
> I think I would be more interested in this if it could abort a swap
> in, for instance. Doesn't this happen if it flows the interruptible
> flag into the VMA's fault handler?

The idea makes sense, but it doesn't work like that right now, afaict. We
need to teach lock_page_or_retry() to be able to consume the flag as
discussed.

I don't see a major blocker for it if lock_page_or_retry() is the only one
we'd like to touch.  Say, the only caller currently is do_swap_page()
(there's also remove_device_exclusive_entry() but just deeper in the
stack). Looks doable so far but I'll need to think about it..  I can keep
you updated if I get something, but it'll be separate from this patchset.

Thanks,

-- 
Peter Xu

