Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F2E5856E8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 00:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbiG2WnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 18:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiG2WnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 18:43:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EB378C599
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 15:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659134588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MkC15PF7q6Qv3Sepf8HquYF3f+S1q84ieK1T4smZvQg=;
        b=eU4JfqkzSZuDVIfIebh/RXYI1cirPWCiUoW1Z0c0gub7kn7noxUVuzlnDt2U8Sjm34HVah
        xHYKJpgs0gTYMTZxoASobU1/cfWLnfICMZaNFL2+uZDHPmM4vM3Q7cyKf+WJ1Vi3anoOzN
        YejcFJc+iFIv+u1orN2o9Z1H/stVXqo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-V-h7zktpNsGpRofNgr0CZQ-1; Fri, 29 Jul 2022 18:43:05 -0400
X-MC-Unique: V-h7zktpNsGpRofNgr0CZQ-1
Received: by mail-qk1-f200.google.com with SMTP id s9-20020a05620a254900b006b54dd4d6deso4578489qko.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 15:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MkC15PF7q6Qv3Sepf8HquYF3f+S1q84ieK1T4smZvQg=;
        b=sFlT1iqr4blZh5B68MLOcfLDhRidK8e7j4FAn/87Hux0m00WvQLriVpsAxV7dx+xcg
         cEWrYPLMRJuR4eZDVfXqfWfY2N5B91tYZfkAVonKNMyB5mxJBAUf2YAcxnT5HG46IU0C
         +8TDYO5pb91bcLKaBTJgB9LS3hi+8OpL4JrLCjouX/CNy6/WLx0ds2c8Ds1eMPOZ6sbD
         6RGQYB/5OVs7tbJncagvFLDq4YUgLn5z7w5ymT+g3UKweEt1FpbnZuusekfeyccLMox3
         Sbct+6QE8vn3c6iq69SGe5+coJ6GBaENLY5v6wyKdC4dX+PETZsK/MjYlli3qPfw7oRc
         tP8Q==
X-Gm-Message-State: AJIora8SY5ZhIUykVs8N/CWmN0eHneqYKRHZi89TAmV37+JVKNqYtian
        YCgy2cLAGnDl0ynYScArgJoolHqiuBnCDxaH9Cppato1BlW2KUvABRGBc1F6FeOXuaqBMtfPhd4
        ltihKLmHkeLw7H4UvHnCobhx6
X-Received: by 2002:a05:622a:209:b0:320:7960:eae2 with SMTP id b9-20020a05622a020900b003207960eae2mr5411432qtx.239.1659134584904;
        Fri, 29 Jul 2022 15:43:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uG7n4r5EftF9w+1QyxPriRl9nrQYP7B8faEUrbCjv47fkaB6Nc2jItUbipdNlSUOY/LzwvsQ==
X-Received: by 2002:a05:622a:209:b0:320:7960:eae2 with SMTP id b9-20020a05622a020900b003207960eae2mr5411425qtx.239.1659134584668;
        Fri, 29 Jul 2022 15:43:04 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id az20-20020a05620a171400b006a5d2eb58b2sm3409261qkb.33.2022.07.29.15.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 15:43:03 -0700 (PDT)
Date:   Fri, 29 Jul 2022 18:43:02 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH RFC 0/4] mm: Remember young bit for migration entries
Message-ID: <YuRido87ud03JKxu@xz-m1.local>
References: <20220729014041.21292-1-peterx@redhat.com>
 <6C0B267E-E36D-4014-8308-B948247D7FED@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6C0B267E-E36D-4014-8308-B948247D7FED@gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 10:07:02AM -0700, Nadav Amit wrote:
> On Jul 28, 2022, at 6:40 PM, Peter Xu <peterx@redhat.com> wrote:
> 
> > [Marking as RFC; only x86 is supported for now, plan to add a few more
> > archs when there's a formal version]
> > 
> > Problem
> > =======
> > 
> > When migrate a page, right now we always mark the migrated page as old.
> > The reason could be that we don't really know whether the page is hot or
> > cold, so we could have taken it a default negative assuming that's safer.
> 
> Looks good to me.

Thanks for the quick review comment, Nadav.

> 
> I just wonder whether the order of the patches should be different. I always
> understood that separating the “enabling” patch from the others is not a
> good practice, since it complicates bisection. I guess it is more of a minor
> issue for such a small patch-set…

Yeah I'd guess you mean when there are a bunch of patches to form one
feature, then we may want to be able to know which part of the feature
break something.  But as you mentioned this feature is mostly implemented
in patch 2 only.

I can squash the enablement patch into the same patch, but when comes to
more archs it also means I'll squash all the archs into the same patch.
I'm just afraid it'll complicate that patch too much - I'd expect each
calculation of swp offset for any arch may not be that straightforward
enough, so it'll be good if they can be reviewed separately and carefully.

-- 
Peter Xu

