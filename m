Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1635B2554
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiIHSIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiIHSHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:07:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCF1EA60C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 11:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662660473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XOiQMUC0eykppoN7iesoA/Zyk8TgTL7xhVonR4jGpV8=;
        b=SO+YhVse3wysCzKhj5ZyUCQAuYReLnzFONZ4c4IXZn72s07EgZqj8oKw+z1BWqtv+nVSGe
        u6JQxMoN3R6q0LO30ZC+xF9zTLISPKMgReIodIRxNHdM5/5nXvC+6j1WV8Xyt61KoXBxfd
        QzYZ2cRhNQv70Qm7fUH4eJKDQVxeA30=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-29-WNaq2jhCO4qY15DEqQ-jhA-1; Thu, 08 Sep 2022 14:07:52 -0400
X-MC-Unique: WNaq2jhCO4qY15DEqQ-jhA-1
Received: by mail-qt1-f197.google.com with SMTP id a29-20020ac8435d000000b0035a990943ddso234160qtn.15
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 11:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=XOiQMUC0eykppoN7iesoA/Zyk8TgTL7xhVonR4jGpV8=;
        b=sj+fpeYsxj5x7ZfVbl5Vr6+NLqogwx3POK6en0wMul4ggyJjXtfCNK/pw6QUGysAWk
         IIMhu/vk/ojv37aWlT/YvKF0zipIbID8oJO33HybuRG7Jd7H5qoLyfx4kfErz+k3dRKV
         SbVHUOhbN3Xk/PADXFaD3vQrqCpGcvKE+jxtfHuTxMKb9EynljsDIMY4BQoopN0UrG2h
         2VRvXx6pwdzoZDSZ5WijS3D0X6z2uuu+seify0cvL61uRduJY28l9QtMuw9fdDigXKQK
         jvGtr8sED/DJN2F9fNnCG218UpZEB/+aFx7sBsDnam0D4IOnNhv9rbfzMwQ4M0Pyt+HY
         0LkA==
X-Gm-Message-State: ACgBeo09gNKdreeTP8wqMEP3v1mHeqpptqAquKVKZREW5J6aTZVLbcws
        WbZHJ8UyXfIiojYua2E8nrT25uNodRe2QA1nxAoFBpyUr2qGXwepBq/f/inG5+NcdFGHdzxijDu
        BYsEXC92E1tdT+hyviHW0iQwZ
X-Received: by 2002:a05:6214:1cce:b0:474:60f:18f0 with SMTP id g14-20020a0562141cce00b00474060f18f0mr8729237qvd.106.1662660471246;
        Thu, 08 Sep 2022 11:07:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4ShN4ZriISlkNihCRT9UneKcyfjn7m2julSQZDvT5VWiC/SRhFP8rVzbu7xyxcMgzdQGFNPA==
X-Received: by 2002:a05:6214:1cce:b0:474:60f:18f0 with SMTP id g14-20020a0562141cce00b00474060f18f0mr8729221qvd.106.1662660471044;
        Thu, 08 Sep 2022 11:07:51 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id j17-20020a05620a289100b006b5d9a1d326sm18302465qkp.83.2022.09.08.11.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 11:07:50 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:07:49 -0400
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 09/26] hugetlb: add hugetlb_hgm_enabled
Message-ID: <YxovdUbObkjVVKMl@xz-m1.local>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-10-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220624173656.2033256-10-jthoughton@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 05:36:39PM +0000, James Houghton wrote:
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> +{
> +	/* All shared VMAs have HGM enabled. */
> +	return vma->vm_flags & VM_SHARED;
> +}
> +#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */

Another nitpick: suggest to rename this to "hugetlb_***_supported()" (with
whatever the new name could be..), as long as it cannot be "disabled". :)

-- 
Peter Xu

