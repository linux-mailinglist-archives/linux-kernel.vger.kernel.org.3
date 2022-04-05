Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4274F527E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1850533AbiDFCyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443195AbiDFAYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 20:24:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 557C9114DF8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 15:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649198567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+8N2nEftHorXiQZo04N/kjaENlnJ2VuHv0uZxFWXn7Q=;
        b=OpgUHNPklJcN7SGlfBjO1+iBSI7J48WKVPfLGBO7Zr1R3MH2EkPZOymj9+BV0mCz4Ci4jI
        QzHF1ZHDljdO6rxjcL5f1tRSM8DnJ8sllATyM18K0pbfASl393IRMqkm5OD+9C8v96rPoz
        AjYpOQ/B4a0hjZdbue3VzJrIHtaws74=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-ulcX9o16N36BonBWGaQJAw-1; Tue, 05 Apr 2022 18:42:46 -0400
X-MC-Unique: ulcX9o16N36BonBWGaQJAw-1
Received: by mail-il1-f198.google.com with SMTP id a2-20020a056e020e0200b002ca4850353fso568484ilk.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 15:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+8N2nEftHorXiQZo04N/kjaENlnJ2VuHv0uZxFWXn7Q=;
        b=idp2CTl5gUKMVEw/JAvH1a1PlF3/VXd1wJGFuCCtqIzXRnyWLAz9EXbg9hkL+TUNL0
         dFmP+vDbK4p9doJnfMd9jvqRXfJZJrIl41m/VpJRzFwM0hgD1ZvheIS9utsibeeA77rm
         3KeMVV1XdtexTiaf/9AaxGIvEfKSxycBG/3IlP6CEEhC7QtHP8wE01DRUgJgH37nSQQC
         rupxPAua1lkT8po70Tle4VlUhwFOR4sWlR/N021i2pu8m75Z+BWEcD7B2SX1fPssGC/2
         1lMuies6pxj8o8Yt434H6w7kPqi/sB8yL/QJQnlbPsiBh53NsqPXskOaDw1/c5vN4FrC
         tspQ==
X-Gm-Message-State: AOAM532wYU0vA0wSO9Z+DshuzBNUoseG1LCa1nrgsfYzS2Y3bWzO76j5
        1Mybmb7Hp4tb37PGmyG9mJvMDSeOZkRvJMyhgSiNeyJ0HL06MH0Z7t0IkC9CbvxkB6XNbnLwvyQ
        wiVXlyud3xmeRWkdMKabp89OG
X-Received: by 2002:a02:90c9:0:b0:323:98e6:1ae8 with SMTP id c9-20020a0290c9000000b0032398e61ae8mr3235678jag.15.1649198565920;
        Tue, 05 Apr 2022 15:42:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7beoc4Wjg2CM343vNV6LoH7yBntkh+W+VyThAA0YDKfNeShAjU3T1xFae52SNC/tCZoFpsw==
X-Received: by 2002:a02:90c9:0:b0:323:98e6:1ae8 with SMTP id c9-20020a0290c9000000b0032398e61ae8mr3235670jag.15.1649198565687;
        Tue, 05 Apr 2022 15:42:45 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id b12-20020a6be70c000000b00648f61d9652sm9162595ioh.52.2022.04.05.15.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 15:42:45 -0700 (PDT)
Date:   Tue, 5 Apr 2022 18:42:43 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v8 00/23] userfaultfd-wp: Support shmem and hugetlbfs
Message-ID: <YkzF4/e86qwcuXiA@xz-m1.local>
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405151616.bf25fa4aad55536cd031e1ab@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220405151616.bf25fa4aad55536cd031e1ab@linux-foundation.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 03:16:16PM -0700, Andrew Morton wrote:
> On Mon,  4 Apr 2022 21:46:23 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > This is v8 of the series to add shmem+hugetlbfs support for userfaultfd
> > write protection. 
> 
> Various compilation catastrophes with x86_64 allnoconfig.  I poked at
> the include ordering for a while but other things quickly became more
> attractive ;)

Sorry about that.  I still don't know what's the problem, but I'll give it
a shot soon.

I think I only tried out with the new configs but not all the rest configs.
I thought there're some bot looking after that one, from which I used to
receive build reports. And IIRC I fixed some build issues in early versions
from those reports.  Maybe I was wrong..

Any more hints on the latter?

Thanks,

-- 
Peter Xu

