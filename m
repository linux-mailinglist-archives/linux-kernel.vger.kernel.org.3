Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BB6562309
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbiF3TVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiF3TVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A0C942EDA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656616904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yj8iosy8U/f1ypWqLjINVM+KTBwE3jaAB2bUYT/BGYg=;
        b=RgOyCg/Ief2sLiWFJte8+SXeP7mLf0Keuaba2rf0G9TsSxqs77CJfuGZY7Ky6YutmWoI/o
        DuAGWASOWurOj7T3OE7/DccVIRygAwK26kLJ9CUhTtnD4hu3L84wzeDDuVTVpyegegHQCf
        OyaUnakrZsDIG1x794uGKg9bcVF6QJ8=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-FH5xiAmfNf6dQetljrHf5Q-1; Thu, 30 Jun 2022 15:21:39 -0400
X-MC-Unique: FH5xiAmfNf6dQetljrHf5Q-1
Received: by mail-il1-f197.google.com with SMTP id w15-20020a056e021a6f00b002d8eef284f0so19520ilv.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yj8iosy8U/f1ypWqLjINVM+KTBwE3jaAB2bUYT/BGYg=;
        b=4fe+1RMgr+dLhyXla9LqVzllwcirbBr2M88EYQJZTDLHJiNrArgX50tthQptI0kFxn
         wwE/3E5nlFdsRLDRhkw9Lxv1AJ6Mvn1jxtOele2yO7ohv1XhCJa8ADHDMep0F5kdS/h3
         HvtqL/V07dqGzQRcQgEFpvlKGV88IxkEtqR1HzVENWaKIZPU4wHd9fcPEcHcb+Sed+sg
         3ODVyDYV7A+fLzFwHS3281JsW/rTVAEujWhyfYAPm6QAG24uCRRvbIJcpdp9UtkZIpp+
         urJSzOXtaFIIfzn/anYM59j4HLnE/VmvzUiBpFxeayLV1m6bY9XRbGDp6viD5LexFs4H
         4A0w==
X-Gm-Message-State: AJIora8LrM7+es3tB9c/9D0pTIeW3hxHD8r5Qhp68crIFMKBDJIkvl9Y
        eFg4lYnugwijEbAWvZT7YnVK2WM3ERcXUK8RAJiApx3FSAwfi5QWEKYekRODYHoZguWA7byzw0S
        SC6GUftB/hFdisKHM+SJKVe/C
X-Received: by 2002:a05:6638:440a:b0:339:f275:a19 with SMTP id bp10-20020a056638440a00b00339f2750a19mr6361804jab.99.1656616899022;
        Thu, 30 Jun 2022 12:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uUISQBDB8B+2KF+MHHGH7vogq+OVRsHfoquZP8RhSPqUEuLrQ3by+zLvmXzXDm48W62Dd/CQ==
X-Received: by 2002:a05:6638:440a:b0:339:f275:a19 with SMTP id bp10-20020a056638440a00b00339f2750a19mr6361791jab.99.1656616898762;
        Thu, 30 Jun 2022 12:21:38 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id n3-20020a02a183000000b003316f4b9b26sm8918454jah.131.2022.06.30.12.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 12:21:38 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:21:35 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     James Houghton <jthoughton@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/26] hugetlb: Introduce HugeTLB high-granularity
 mapping
Message-ID: <Yr33v+ag6Bv6wExa@xz-m1.local>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <YrYCeYy0rjfGhT/W@casper.infradead.org>
 <CADrL8HUtdd=yEtY=bhHRYVjA30O1CAd6XEj+oTNjviWkSmzowQ@mail.gmail.com>
 <YrnvORvPKbzgxLCu@work-vm>
 <CADrL8HX4eNREyiuDPSoQpZPObTe7Kto3UurMHYeeO-3TdTo87w@mail.gmail.com>
 <0125BDEB-0848-41DF-A9D4-CDCAC2893972@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0125BDEB-0848-41DF-A9D4-CDCAC2893972@vmware.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 12:04:28AM +0000, Nadav Amit wrote:
> > [1] commit 824ddc601adc ("userfaultfd: provide unmasked address on page-fault")
> 
> Indeed this change of behavior (not aligning to huge-pages when flags is
> not set) was unintentional. If you want to fix it in a separate patch so
> it would be backported, that may be a good idea.

The fix seems to be straightforward, though.  Nadav, wanna post a patch
yourself?

That seems to be an accident and it's just that having sub-page mapping
rely on the accident is probably not desirable..  So irrelevant of the
separate patch I'd suggest we keep the requirement on enabling the exact
addr feature for sub-page mapping.

Thanks,

-- 
Peter Xu

