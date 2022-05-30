Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6225387E9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 21:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243093AbiE3T5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 15:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbiE3T4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 15:56:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EA999FEC
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 12:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653940608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SrQHuKkuR8CrrdLyf+7/DQkTTkrKszGSGsUUA8WbICA=;
        b=ENhqMlIQCB8VmpWLc5cr+gknYoM7DjX6fLEfmaIAOejNn+69HrSIAJFahIHdKjCpnSsuwS
        i/TUwaAiiRp9/cS71k3khs60KWnRMSYfna4cIVSGe4wLlJBDZF88rlAxOCqzSVs0f2bycV
        /PofzANUgqzGn84h59sQSzczkPyw8ag=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-WA6lToafNQ-UsDriutUGUQ-1; Mon, 30 May 2022 15:56:47 -0400
X-MC-Unique: WA6lToafNQ-UsDriutUGUQ-1
Received: by mail-io1-f69.google.com with SMTP id y12-20020a5e920c000000b006657a63c653so5893386iop.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 12:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SrQHuKkuR8CrrdLyf+7/DQkTTkrKszGSGsUUA8WbICA=;
        b=Q+34h/4UJkY5nBrp/8vUEBlkULleHAkJ/18OLoBI6hpHmwwRDsOdBdmuyYQyG9ciDt
         tdXg3ouHpPhNkpgV0Wb5CtAcyi/DDJI9KVT/ukj+QT6GzaLzH1jhSKOJTFgD7/5XdVAn
         1hxkyFtoEaV2//xZ9LCBqU1+LAHHREjyGtdKjfliQTArMSwbbn6bdoLAcO5+EmMJKr9Y
         EhfQeNaELM12d2g4QbXnnEaIr4KOozTDL0YZCzpgiHnRtczaW5cXbrK58uf819pRu7oJ
         sxMjuoZzkC5nNCVRc13Q9MVriF2xWwQ6yAtkYMDan9nMdGUAaedixumtorXWgz/J3uok
         Iu2w==
X-Gm-Message-State: AOAM533RgXlSEhlDu09fKzODc+jMlKIv+6lL6hPFjQ2wTyRBL98Px6d4
        hiOG8CvF9RQKabwYdYHEJ+ARX0PvDPeJ+NXJnX6H16irsq51XlDtv6uLmSC88DD3UX+TDzXDsJi
        f7ifei15FM3FNP/vCzNa6i9in
X-Received: by 2002:a05:6638:25d3:b0:32e:e5ee:496c with SMTP id u19-20020a05663825d300b0032ee5ee496cmr16603121jat.52.1653940606493;
        Mon, 30 May 2022 12:56:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwx3+eDeVC1tEGsUjSxkWbRjFFdRh89vPjGO12nGBme87S4wjpsuBO4lyT0OcGY9695AehSpg==
X-Received: by 2002:a05:6638:25d3:b0:32e:e5ee:496c with SMTP id u19-20020a05663825d300b0032ee5ee496cmr16603114jat.52.1653940606320;
        Mon, 30 May 2022 12:56:46 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id b16-20020a6be710000000b00665f77d74d6sm3364787ioh.51.2022.05.30.12.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 12:56:45 -0700 (PDT)
Date:   Mon, 30 May 2022 15:56:43 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>,
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
Message-ID: <YpUhe6BSfflOVz7b@xz-m1.local>
References: <20220527225849.284839-1-mike.kravetz@oracle.com>
 <20220527225849.284839-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220527225849.284839-2-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mike,

On Fri, May 27, 2022 at 03:58:47PM -0700, Mike Kravetz wrote:
> +unsigned long hugetlb_mask_last_hp(struct hstate *h)
> +{
> +	unsigned long hp_size = huge_page_size(h);
> +
> +	if (hp_size == P4D_SIZE)
> +		return PGDIR_SIZE - P4D_SIZE;
> +	else if (hp_size == PUD_SIZE)
> +		return P4D_SIZE - PUD_SIZE;
> +	else if (hp_size == PMD_SIZE)
> +		return PUD_SIZE - PMD_SIZE;
> +
> +	return ~(0);
> +}

How about:

unsigned long hugetlb_mask_last_hp(struct hstate *h)
{
	unsigned long hp_size = huge_page_size(h);

	return hp_size * (PTRS_PER_PTE - 1);
}

?

This is definitely a good idea, though I'm wondering the possibility to go
one step further to make hugetlb pgtable walk just like the normal pages.

Say, would it be non-trivial to bring some of huge_pte_offset() into the
walker functions, so that we can jump over even larger than PTRS_PER_PTE
entries (e.g. when p4d==NULL for 2m huge pages)?  It's very possible I
overlooked something, though.

Thanks,

-- 
Peter Xu

