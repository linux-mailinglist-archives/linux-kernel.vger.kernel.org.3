Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E14539C8B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 07:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349609AbiFAFUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 01:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347482AbiFAFUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 01:20:40 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06826719C4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 22:20:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w2-20020a17090ac98200b001e0519fe5a8so986379pjt.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 22:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8Zs32ZPOynrEtHOmKf2nU4IhPW8qkjU7KLDsMZ2L2Ew=;
        b=twDGCdvFNk9jkCYmzOBb1DVlWctmg/B+8+Txv/QglxY9J+O93oyrVJtilTCvm/fZUy
         vxUbo7u1yKiy+Ae49ge9H3zjUnEye+wN1C2IfM1HrZYFhMsyVHgrfi6ZCDpRwaa+eBya
         CiPKd0aQkjizhIu3MzppaCCXFW3Q6oCC/BnyzNWn4w10aIRzQLemPa3UjNxV4kRNlyd0
         nFZ6cyJoViNDjf4NjOXJ3/sEuoUDgE2t1Loc7/MWBfU11WRqs+x8WZf5PBhXu/kMy/A8
         gRJXcLbgUdo3ZimnjrITqJ3xtXgJjtXdNG5eSZDDypWBqPXUzduIT/sQrnlIgeUD1meM
         pQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Zs32ZPOynrEtHOmKf2nU4IhPW8qkjU7KLDsMZ2L2Ew=;
        b=rqtbzMTxh/PQfL6x51PQirj5lGyT6m6I5cFv57seRbmgvsfLkpcHeDgXT5GQqvm14n
         IysvgrMZVYyTEtEQ3+M4T0oxCv2dYoEymj7lODU3plaEr+z54CMLzPdN6AGbYDAbVt6C
         5cYBihbF5/T+fJM29q9K544is7fii7FW2iGlP4m8twE9mUrfgMtgb5rcBkmRodMertFK
         i4tZ2gCdj6pUqaYx5g2PGCT1/yuCdNs+3fiIkTBiG0uqC3vrnQAj87n7fXvS1DRd6wGp
         GlG/0eeCO3/X9hhXrHvFBh/KLzM1CfdJVznyowT9Ds6sKxha/9Cr726Adyz1kDxQE2wh
         AjvQ==
X-Gm-Message-State: AOAM531x6VpbfVBFe8ygyXe1EJl36zdU8TXoG+0xrMWIfaFruXEnmifr
        iGLZHmaStqFolXpujcv2xPOQ5Q==
X-Google-Smtp-Source: ABdhPJw8u9k5GyAD5lEhgf42ZHRNtsyafUtU/fTyVQQ7UxXZgbH9ecYW/TIRlnOzmVQURtXdF0jZbA==
X-Received: by 2002:a17:902:ce87:b0:163:fc5e:398b with SMTP id f7-20020a170902ce8700b00163fc5e398bmr8413696plg.125.1654060838531;
        Tue, 31 May 2022 22:20:38 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:55b0:2d1a:e847:9fba])
        by smtp.gmail.com with ESMTPSA id v11-20020a62a50b000000b0051ba97b788bsm404566pfm.27.2022.05.31.22.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 22:20:38 -0700 (PDT)
Date:   Wed, 1 Jun 2022 13:20:30 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 3/3] hugetlb: Lazy page table copies in fork()
Message-ID: <Ypb3HhYU/bFL7yx7@FVFYT0MHHV2J.googleapis.com>
References: <20220527225849.284839-1-mike.kravetz@oracle.com>
 <20220527225849.284839-4-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527225849.284839-4-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 03:58:49PM -0700, Mike Kravetz wrote:
> Lazy page table copying at fork time was introduced with commit
> d992895ba2b2 ("Lazy page table copies in fork()").  At the time,
> hugetlb was very new and did not support page faulting.  As a result,
> it was excluded.  When full page fault support was added for hugetlb,
> the exclusion was not removed.
> 
> Simply remove the check that prevents lazy copying of hugetlb page
> tables at fork.  Of course, like other mappings this only applies to
> shared mappings.
> 
> Lazy page table copying at fork will be less advantageous for hugetlb
> mappings because:
> - There are fewer page table entries with hugetlb
> - hugetlb pmds can be shared instead of copied
> 
> In any case, completely eliminating the copy at fork time shold speed
> things up.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

