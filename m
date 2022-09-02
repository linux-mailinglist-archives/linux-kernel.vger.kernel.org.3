Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEEF5AB367
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbiIBO0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbiIBO0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:26:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C6713973E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662126795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ap6F3iUwG0XwvBvhq4auq9CyYIKW5QhAfRS88ukOs0=;
        b=KOolh7sBAfFXejkUPlm+YB5oqz1/Sn/Kl25k/VDaGXoOQWm4yC3WSFL2xmehCzyQ7qmvFJ
        GnX7bLDALVCTMuXG1XP6w63fF8++/4XDiTGTVSI2pgy8FDqticgd5+ubFbtlSckjkQoSJM
        WcwXkDPJj1mPOdUz58j28TL882M4Ztg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-605-U6xb6Ws3OgqYX7saadfHaQ-1; Fri, 02 Sep 2022 09:53:15 -0400
X-MC-Unique: U6xb6Ws3OgqYX7saadfHaQ-1
Received: by mail-qt1-f200.google.com with SMTP id bq11-20020a05622a1c0b00b003434f125b77so1580502qtb.20
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 06:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=+ap6F3iUwG0XwvBvhq4auq9CyYIKW5QhAfRS88ukOs0=;
        b=bDPqx3GAnPu8pX2dQb+FApxttG1OjnZB+70YmvTPkfNO3iNU0w60CrFtt4x5jETMQb
         g8wRLO4CpyaAu9dPJjmBbgPoCjS6Q3vZTIWoL3NWOcNNAqwMAbXjyoAX1skSDG0eqxmu
         c63XJLk6CRKceaatojtZ6DfoKeKem/Ab/+E/u3KV7O906dPnR/NiVc6RgXmdzPBwpNFW
         7NsQIXaemMd0eLk/PD6yG7NL18WZVWI8aVW8hORujDb/iRqL48O1fZA4hxUKvW9G5ZzK
         AuaxG0/FzeWXCtjFt/EhE+zMDD9c9Fg7drb+cdsd65GHcsRhESHzFamiWbrMnJhcnuRD
         MOHQ==
X-Gm-Message-State: ACgBeo3LZpAhZDGyPyHgUi+CjkewdgPrOpZTVF56lojJWH61p1/ocrZs
        KVqOGSwCuG8aazhXegjXGaqv3i7cTMEezsb4wIDY92yERslS8Dhb22u7IyD3YSWg70+e0no9MUz
        wL8a/1PmVRxVwySJTc5WAAJ4/
X-Received: by 2002:a05:6214:5005:b0:472:e6b0:1fb2 with SMTP id jo5-20020a056214500500b00472e6b01fb2mr28503189qvb.124.1662126794261;
        Fri, 02 Sep 2022 06:53:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7eXEaiAmq13RGGl+GkCbnlSnbZ4ozlFXTcz8QgSNrp2IcyLtHYanUGZZ1bg6lGbFXp1eBnBg==
X-Received: by 2002:a05:6214:5005:b0:472:e6b0:1fb2 with SMTP id jo5-20020a056214500500b00472e6b01fb2mr28503172qvb.124.1662126794029;
        Fri, 02 Sep 2022 06:53:14 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id b184-20020a37b2c1000000b006bb6c63114fsm1443338qkf.110.2022.09.02.06.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 06:53:13 -0700 (PDT)
Date:   Fri, 2 Sep 2022 09:53:11 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Yang Shi <shy828301@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v1] mm/gup: adjust stale comment for RCU GUP-fast
Message-ID: <YxIKxy5RIp36HuOf@xz-m1.local>
References: <20220901072119.37588-1-david@redhat.com>
 <YxDdycTur733hMgt@xz-m1.local>
 <fa0bb4b1-3edd-eb5a-7ad6-dff785d88d8f@redhat.com>
 <YxDghv54uHYMGCfG@xz-m1.local>
 <c9dc3f22-4a72-9b9d-7a74-ad77fe4f3b6e@redhat.com>
 <CAHbLzkpdUMq2fMxqx-NgSZ2VLBU5RGqSpJRWH6eRrYymErAbaw@mail.gmail.com>
 <YxD00K1lv151X/eq@xz-m1.local>
 <CAHbLzkrA-jKzTBq_Mn3NZYc91exovv1gH2LNzetCNiVu8+W6Kg@mail.gmail.com>
 <2368d91f-8442-076f-f33a-64b51b44825c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2368d91f-8442-076f-f33a-64b51b44825c@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 08:32:42AM +0200, David Hildenbrand wrote:
> Note that this matches ptep_get_and_clear() behavior on s390x. Quoting the comment in there:
> 
> 
> /*
>  * This is hard to understand. ptep_get_and_clear and ptep_clear_flush
>  * both clear the TLB for the unmapped pte. The reason is that
>  * ptep_get_and_clear is used in common code (e.g. change_pte_range)
>  * to modify an active pte. The sequence is
>  *   1) ptep_get_and_clear
>  *   2) set_pte_at
>  *   3) flush_tlb_range
>  * On s390 the tlb needs to get flushed with the modification of the pte
>  * if the pte is active. The only way how this can be implemented is to
>  * have ptep_get_and_clear do the tlb flush. In exchange flush_tlb_range
>  * is a nop.
>  */

Ah, now I kind of see why s390 has its own world of pte operations.

But then we really should be noted on reworking the generic tlb code
because s390 is always special; people will think the generic tlb API is
for tlb but no-op for s390, e.g.  anyone optimizes generic tlb flushing
it'll probably never apply to s390.

Besides performance, hopefully there'll be no case where the tlb change
will be functional then it may affect s390 too.  But I don't see any since
as long as tlb was flushed earlier than the API then it seems always safe.
Just trickier.

-- 
Peter Xu

