Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4745389CA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 04:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243475AbiEaCEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 22:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiEaCEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 22:04:35 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B957A813
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 19:04:33 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so851745pjq.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 19:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0rUpiaaAumJQHZ2NkgE4OtbYqIKcbspra9WP2rXAErY=;
        b=Dqx2RXLRsbRyQCJvVUvEIK951cc8Lk5L8nZraZQKbjv9j30rL44DZLtO0F6LcWeUIi
         VzbfUgYYjRZ5giAK9UN2+MUputllcs/bf27mS3Y/JVTAA1DDUeSDmTf5V2QQXhWQHfUR
         SW7xB6AetVIDOK+kpvzCaj3UIT6XnnRof3HvX7bO9c+2KcYh/xJxOaGvDo+LQMBMIEPQ
         bOJoRkRooVNe1cRQkQ4ULn1k8PCT1KK5hMGd0YkX+MRE+zqDkC5mqAfmAfyWb4IugxWo
         SkFCREfMVTSarMgbJwuGgPVnsvMnkvLWB5qX70MaUy//KEtg3tKj6IF+vggZ/OqIY6V2
         hJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0rUpiaaAumJQHZ2NkgE4OtbYqIKcbspra9WP2rXAErY=;
        b=iu7Ro7/U3KAZsrdKRiaEY5aZRKDKksmDrWtTpFTIZQkUoXu/jOPpVoJoF+72AkV7Ta
         x6m3lAdZib+i50e1BgmZNP7/xWQ63xhmWghUuKmhYU4clzxLTRgA4k6IatgGokllIZzm
         pLON9+rYYkxDV5MM005Jf/8A5MlSuH/9oJyWm0WjL5YpYwUqyx5xeQrZ45ibU73/Ber0
         fLn1N/cJzJKhgZis/WzviihmFEPhk+sXp8dqFW2Msw1JuRcILwUp0ZTLiJKSP1gqureF
         V2rR/JFMDq3s/Ctvfj2ODfFTvIvYH4N4NsHp4ZG6NLkHQXu9FLXmOA2KrEx6p/5yAX/G
         G4Ug==
X-Gm-Message-State: AOAM531jfai2qbdp0vw0Kx2DhFM39Ninp42AP++veDt/rsxCgXohEBMM
        FnyuaxpY0KebMnbSzM9mc7r1ng==
X-Google-Smtp-Source: ABdhPJzjdEbJLrtya8nVyD+MufcjXBFv8zXPpvNY45MyBTk8VcnJdbGnpc5+wN1L71F2EgRHB7UTEA==
X-Received: by 2002:a17:90a:5291:b0:1e0:cf4a:b6fa with SMTP id w17-20020a17090a529100b001e0cf4ab6famr26405737pjh.197.1653962672802;
        Mon, 30 May 2022 19:04:32 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:7163:3a36:783f:6d4a])
        by smtp.gmail.com with ESMTPSA id p3-20020a170903248300b00161955fe0d5sm2486044plw.274.2022.05.30.19.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 19:04:32 -0700 (PDT)
Date:   Tue, 31 May 2022 10:04:26 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/3] hugetlb: skip to end of PT page mapping when pte
 not present
Message-ID: <YpV3qrSHGsIuvifX@FVFYT0MHHV2J.googleapis.com>
References: <20220527225849.284839-1-mike.kravetz@oracle.com>
 <20220527225849.284839-2-mike.kravetz@oracle.com>
 <YpUhe6BSfflOVz7b@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpUhe6BSfflOVz7b@xz-m1.local>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 03:56:43PM -0400, Peter Xu wrote:
> Hi, Mike,
> 
> On Fri, May 27, 2022 at 03:58:47PM -0700, Mike Kravetz wrote:
> > +unsigned long hugetlb_mask_last_hp(struct hstate *h)
> > +{
> > +	unsigned long hp_size = huge_page_size(h);
> > +
> > +	if (hp_size == P4D_SIZE)
> > +		return PGDIR_SIZE - P4D_SIZE;
> > +	else if (hp_size == PUD_SIZE)
> > +		return P4D_SIZE - PUD_SIZE;
> > +	else if (hp_size == PMD_SIZE)
> > +		return PUD_SIZE - PMD_SIZE;
> > +
> > +	return ~(0);
> > +}
> 
> How about:
> 
> unsigned long hugetlb_mask_last_hp(struct hstate *h)
> {
> 	unsigned long hp_size = huge_page_size(h);
> 
> 	return hp_size * (PTRS_PER_PTE - 1);
> }
>

+1
 
> ?
> 
> This is definitely a good idea, though I'm wondering the possibility to go
> one step further to make hugetlb pgtable walk just like the normal pages.
> 
> Say, would it be non-trivial to bring some of huge_pte_offset() into the
> walker functions, so that we can jump over even larger than PTRS_PER_PTE
> entries (e.g. when p4d==NULL for 2m huge pages)?  It's very possible I
> overlooked something, though.
> 
> Thanks,
> 
> -- 
> Peter Xu
> 
> 
