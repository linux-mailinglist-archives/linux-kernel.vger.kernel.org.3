Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175435963BD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 22:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbiHPUfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 16:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiHPUfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 16:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401786A4AB
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660682108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8qNWq56WcsAjV+d0DPWCWS43jEIePhWAAvwxxzNI+Yo=;
        b=PWUm55nNMex+zZxNub8oYd4hNMtzeQlNKTqQ1YjiwanSyO4hGdn5lKRA1ornHk/FsGXZBk
        kzRa2+2LZaz6Bb3Pssjnk6pxQaqf/1jM96Inrx+Hd4bdQXaBmyH8w3E2nzSa/owEWSVW2m
        swhjEbwVNDSA1eaPiHw7EBj0HY3cYUw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-260-VWnQoaQyOwO5gilPd29tFg-1; Tue, 16 Aug 2022 16:35:07 -0400
X-MC-Unique: VWnQoaQyOwO5gilPd29tFg-1
Received: by mail-qk1-f199.google.com with SMTP id w22-20020a05620a445600b006bb7f43d1cfso1214592qkp.16
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=8qNWq56WcsAjV+d0DPWCWS43jEIePhWAAvwxxzNI+Yo=;
        b=2rxsiknOEe37HhI2CFw2MAQUf8jAKGeZpSdMVNvEQSVkomkL7arXM0LWSdKTrY+D+G
         iX1kiLDt9MeCHO4SPQpgz/HfKXbk9ESdT8SWUPK0jnv1PjlDl+DhFBMupjhj94iWX4Ah
         HEuuhkOchXZ132bdKvv99jNA8SmgZzZFb4yLotGMn/rqEplvZrL8JpX1QvV9JLh9EHGc
         bBADlucXVF52RfLzvhjFfzDEvulYaVnsJu+mC1DV60K7eGbkUpZSCmYiwWjMH+ZLBpoO
         Yu6Eo0u1VEzTXu19lJdVgD5j0HeU6qePQpdLSmxDOH4RQOvWNGdsmUIDiOp9Hz9LFjzF
         HBaA==
X-Gm-Message-State: ACgBeo05erCORoeFjWpOjfXQjydAq7+Jh66mxbaxBDF6MoRl7cHE2j4h
        58QoxuHOquke/um8uQXQqU6Q0fE5mTTH8h7TQ1pUOW8ttU3FMAYmN5/kdHSVEKO/SG1uDNQ5Bck
        3+SUsJ2J+rxYqQyhJnlsLL5PL
X-Received: by 2002:a05:6214:2aa2:b0:477:1882:3dc with SMTP id js2-20020a0562142aa200b00477188203dcmr19064873qvb.11.1660682106683;
        Tue, 16 Aug 2022 13:35:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6sxNDlfRThn/rIz3JOnzmI+jYq7VbHmqoYMTVRKckqHUaSQxZWhXW5hA43Dz2DbrziOS2X+w==
X-Received: by 2002:a05:6214:2aa2:b0:477:1882:3dc with SMTP id js2-20020a0562142aa200b00477188203dcmr19064852qvb.11.1660682106470;
        Tue, 16 Aug 2022 13:35:06 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id l1-20020a05620a28c100b006b958c34bf1sm3222130qkp.10.2022.08.16.13.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 13:35:05 -0700 (PDT)
Date:   Tue, 16 Aug 2022 16:35:04 -0400
From:   Peter Xu <peterx@redhat.com>
To:     huang ying <huang.ying.caritas@gmail.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, paulus@ozlabs.org,
        linuxppc-dev@lists.ozlabs.org, Huang Ying <ying.huang@intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/migrate_device.c: Copy pte dirty bit to page
Message-ID: <Yvv/eGfi3LW8WxPZ@xz-m1.local>
References: <6e77914685ede036c419fa65b6adc27f25a6c3e9.1660635033.git-series.apopple@nvidia.com>
 <CAC=cRTPGiXWjk=CYnCrhJnLx3mdkGDXZpvApo6yTbeW7+ZGajA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC=cRTPGiXWjk=CYnCrhJnLx3mdkGDXZpvApo6yTbeW7+ZGajA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 04:10:29PM +0800, huang ying wrote:
> > @@ -193,11 +194,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
> >                         bool anon_exclusive;
> >                         pte_t swp_pte;
> >
> > +                       flush_cache_page(vma, addr, pte_pfn(*ptep));
> > +                       pte = ptep_clear_flush(vma, addr, ptep);
> 
> Although I think it's possible to batch the TLB flushing just before
> unlocking PTL.  The current code looks correct.

If we're with unconditionally ptep_clear_flush(), does it mean we should
probably drop the "unmapped" and the last flush_tlb_range() already since
they'll be redundant?

If that'll need to be dropped, it looks indeed better to still keep the
batch to me but just move it earlier (before unlock iiuc then it'll be
safe), then we can keep using ptep_get_and_clear() afaiu but keep "pte"
updated.

Thanks,

-- 
Peter Xu

