Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88384561FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiF3QJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbiF3QJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:09:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 787991BE80
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656605351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P6L8uC01GwQiAV6RdRK9BzdNht1S61slyDLTSeTcpAU=;
        b=YeqWCHuvvnNQ9pXb1DZzm9UEBx2jF0CdtqzMuqowZOe+8EaVbXAEFxpLUMirvxCEbq9gcs
        51bZRKXTdzfhkWYV+h+TCUTC/kr2F2jkGFn3Vn7wRzxx6fGR8Bu9K5yl80YJF143hh2PEy
        zxFMo2mFWYmKb4UO3iXfd2boEUcJk0I=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-j6JR7v-sMoGw7XGSiwlGFA-1; Thu, 30 Jun 2022 12:09:10 -0400
X-MC-Unique: j6JR7v-sMoGw7XGSiwlGFA-1
Received: by mail-il1-f199.google.com with SMTP id o17-20020a056e02115100b002d95d6881e4so10744635ill.19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P6L8uC01GwQiAV6RdRK9BzdNht1S61slyDLTSeTcpAU=;
        b=3g1b6PNdx0LulkGKUK5EaPLEj5QtCDAsl5I+zyTNwtymEjGZ6d8FGzFqIjnPF8CwZJ
         qY/I38MXRuTitrC2ldJ3+Zu3rRTWpRMnywWDwPNMbBC1U1phPLL600Hz0wrJkMSAmmOB
         vyqNDFi3azAb82+WXmzoPrLw+csWhDJYkr7XpTj2LCoagHHUu4Mi6p4cYqQWFuEcMOP1
         0ZVKJTS2+wI4y9hk0n6QiMRLKhMr+GlWu8Vib6NMGutC/KgF7HZjrV9hFniXNCKYDc6U
         8bb8cIniBtO7VBA6k/4fihnEVX48Su0XC6QiFzNoONl27tSEgUJLBU7Bnva1WLZ2z2S7
         XHcQ==
X-Gm-Message-State: AJIora8Ba4+BD++PQQkLIyQBJzSbTuF+8kevyKF6Qm+MRgNX07UaQr60
        f6v1fqVyLgY5I86O56BNBS/PB+/nAeizZphKT5yqwPUXN9DioTomxVV1STqv3xlc6rxUVBNJVMA
        GvIFRyk0y+0tn8vPgcF/gqB6T
X-Received: by 2002:a05:6e02:2168:b0:2da:a170:5b6 with SMTP id s8-20020a056e02216800b002daa17005b6mr5438807ilv.321.1656605349252;
        Thu, 30 Jun 2022 09:09:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vYs4hpmFf8NNNcZENp1x0RUK/4W/wnRloQB873SdxXYOvH1nEO/bmbYREOBpnUXfKVyFsahg==
X-Received: by 2002:a05:6e02:2168:b0:2da:a170:5b6 with SMTP id s8-20020a056e02216800b002daa17005b6mr5438789ilv.321.1656605348961;
        Thu, 30 Jun 2022 09:09:08 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id e39-20020a022127000000b0032e49fcc241sm8698697jaa.176.2022.06.30.09.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 09:09:06 -0700 (PDT)
Date:   Thu, 30 Jun 2022 12:09:04 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     James Houghton <jthoughton@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>
Subject: Re: [RFC PATCH 00/26] hugetlb: Introduce HugeTLB high-granularity
 mapping
Message-ID: <Yr3KoCpuc4iYseOP@xz-m1.local>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <YrYCeYy0rjfGhT/W@casper.infradead.org>
 <CADrL8HUtdd=yEtY=bhHRYVjA30O1CAd6XEj+oTNjviWkSmzowQ@mail.gmail.com>
 <YrnvORvPKbzgxLCu@work-vm>
 <CADrL8HX4eNREyiuDPSoQpZPObTe7Kto3UurMHYeeO-3TdTo87w@mail.gmail.com>
 <Yrq52SCUa6KN4LsR@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yrq52SCUa6KN4LsR@work-vm>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 09:20:41AM +0100, Dr. David Alan Gilbert wrote:
> One other thing I thought of; you provide the modified 'CONTINUE'
> behaviour, which works for postcopy as long as you use two mappings in
> userspace; one protected by userfault, and one which you do the writes
> to, and then issue the CONTINUE into the protected mapping; that's fine,
> but it's not currently how we have our postcopy code wired up in qemu,
> we have one mapping and use UFFDIO_COPY to place the page.
> Requiring the two mappings is fine, but it's probably worth pointing out
> the need for it somewhere.

It'll be about CONTINUE, maybe not directly related to sub-page mapping,
but indeed that's something we may need to do.  It's also in my poc [1]
previously (I never got time to get back to it yet though..).

It's just that two mappings are not required.  E.g., one could use a fd on
the file and lseek()/write() to the file to update content rather than
using another mapping.  It might be just slower.

Or, IMHO an app can legally just delay faulting of some mapping using minor
mode and maybe the app doesn't even need to modify the page content before
CONTINUE for some reason, then it's even not needed to have either the
other mapping or the fd.  Fundamentally, MINOR mode and CONTINUE provides
another way to trap page fault when page cache existed.  It doesn't really
define whether or how the data will be modified.

It's just that for QEMU unfortunately we may need to have that two mappings
just for this use case indeed..

[1] https://github.com/xzpeter/qemu/commit/41538a9a8ff5c981af879afe48e4ecca9a1aabc8

Thanks,

-- 
Peter Xu

