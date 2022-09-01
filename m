Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36EC5A9EA1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiIASHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbiIASHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288FF20BC6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 11:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662055636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W2tBVosZJdi+ecAm8FBwm9AwoZE5y1iiOsRB8iRR70c=;
        b=SxZehDUGNvWOcRw4mThs0RTT6NgLBcTX1lhi2QJ8eJw1DGSaocoXoL8ZB5gljIu839iZ3v
        EnzffbWg2TazdgQxuSUKQfVBee+W511C49DpODj1+e0PsyhpZUC2HUTk65GzAwTsZWPO+8
        BHR5PkOluy418Hx0gSnqJzIoiQS+iFo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-447-3HtCxW3YOEORE_Sec57-mg-1; Thu, 01 Sep 2022 14:07:15 -0400
X-MC-Unique: 3HtCxW3YOEORE_Sec57-mg-1
Received: by mail-qv1-f72.google.com with SMTP id u4-20020a0c8dc4000000b00498f6359b6dso9737375qvb.17
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 11:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=W2tBVosZJdi+ecAm8FBwm9AwoZE5y1iiOsRB8iRR70c=;
        b=UIiHWSaMaWn/DGDHeK7Q1ksYIqf0LsOmbQ0LZBcqOuB2y1J0BFzY4lZwtnISBVd9qI
         2sXhSUvbAPPT5RhBDmC6c/BsT9b9gyL+Eii7IgJaYfVBN4Dq30xLqC4Orpj74GP5lWrs
         /pfDk/ukL9m29jHMyl0nJd/jvpZz9/C0KbOf6snyWR3PKqak8xPD2jGygm8/DWSTTrsr
         hjwua4W4HWufiBxuLuarZJHfSuBwrgjRwLSvGC2CxIe6fVPEDx6DThGhrx0Cs0PKoxaj
         t1rwvATgJYq+uxUSlAHq/OUbHnIJ9HPQkkDp1Byhgfn781aevg2fUbI0q9zr029YvM/c
         C3eg==
X-Gm-Message-State: ACgBeo3rDjt0stHz/suaDzFVFVVkUVMVgqT7nk9is9CpSMZ5oirZLBDG
        KC6P2C/RJJtLlptL2St0448RED7cH43f9+PgAzqqSRkHfBjV+A2hMIKut871yGnFdHAt4yYBMNR
        cU/pLctr5CEU2804lQ5mmQtut
X-Received: by 2002:ad4:5cc5:0:b0:499:2b4:8909 with SMTP id iu5-20020ad45cc5000000b0049902b48909mr19239750qvb.127.1662055634550;
        Thu, 01 Sep 2022 11:07:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5mUIP4VOZzlWTTQeu7Bx6rwimn4BcdAW+eSzUnzv3npqB0SZ5VHxR2LwhMMlFuX5IQwIJUrQ==
X-Received: by 2002:ad4:5cc5:0:b0:499:2b4:8909 with SMTP id iu5-20020ad45cc5000000b0049902b48909mr19239725qvb.127.1662055634367;
        Thu, 01 Sep 2022 11:07:14 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id i7-20020ae9ee07000000b006a6ab259261sm12287379qkg.29.2022.09.01.11.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 11:07:13 -0700 (PDT)
Date:   Thu, 1 Sep 2022 14:07:12 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v1] mm/gup: adjust stale comment for RCU GUP-fast
Message-ID: <YxD00K1lv151X/eq@xz-m1.local>
References: <20220901072119.37588-1-david@redhat.com>
 <YxDdycTur733hMgt@xz-m1.local>
 <fa0bb4b1-3edd-eb5a-7ad6-dff785d88d8f@redhat.com>
 <YxDghv54uHYMGCfG@xz-m1.local>
 <c9dc3f22-4a72-9b9d-7a74-ad77fe4f3b6e@redhat.com>
 <CAHbLzkpdUMq2fMxqx-NgSZ2VLBU5RGqSpJRWH6eRrYymErAbaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkpdUMq2fMxqx-NgSZ2VLBU5RGqSpJRWH6eRrYymErAbaw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:50:48AM -0700, Yang Shi wrote:
> Yeah, because THP collapse does copy the data before clearing pte. If
> we want to remove pmdp_collapse_flush() by just clearing pmd, we
> should clear *AND* flush pte before copying the data IIRC.

Yes tlb flush is still needed.  IIUC the generic pmdp_collapse_flush() will
still be working (with the pte level flushing there) but it should just
start to work for all archs, so potentially we could drop the arch-specific
pmdp_collapse_flush()s, mostly the ppc impl.

This also reminded me that the s390 version of pmdp_collapse_flush() is a
bit weird, since it doesn't even have the tlb flush there.  I feel like
it's broken but I can't really tell whether something I've overlooked.
Worth an eye on.

-- 
Peter Xu

