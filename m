Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BA35B256A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiIHSOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiIHSOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:14:10 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710BFE55B6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 11:14:09 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 130so22084750ybz.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 11:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yIGQ1rsAiCTfDSyBYdyVPVyYlO9LImSP5xeSStH2FZ0=;
        b=pRUckrDB014z72ph6+Gz6wJWHEWKBfiaLi4wsYdQZDPkwzAG/b1AVpHgGh8RXCE+oq
         AQeaBo9euSonu1IHvOKnIOUfif2gLUjpuAdwul1l35/Ct3ruLEbUkux3Gfot9hCf+DYh
         W2c6fOkUxHaGwb6v23PHPtEVGkW0/borE1dH7CDUHyJdZNkosP18XXH7cuUPG/ZKtWkG
         BC0rHV9d5ZuFtPmBt2Vvl2xeLZrRZd69PahstEpaawCiJO2Xiyi1WgA9NwVdLalMrlir
         wYH8p4SuxorGTSSBGWHfpvJGm25XC/ikzKFvEOPb8sZj97ExgP2maYpg6Znoqs3w/ymX
         7H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yIGQ1rsAiCTfDSyBYdyVPVyYlO9LImSP5xeSStH2FZ0=;
        b=ZF8s9J2tNvs/Q8jOoiRYhGyjOFAlhSjaa82GtddTNMxEHAGXGEfhcsczmMcI+mwshF
         rtzdCsyI3H1BlUydfraNYOWDRIEFcyfTJP+YvRVN/RO04KS84wrK99UmirSAE1UZCV1l
         +9lEh3tH8wWGs6hDbqXJvQa5X7LaXpuFEoNMW4OfvFHlTL918vuNgtXpBADPak+9v70T
         dokPOooWwNA4MrKmECqByPr3LVWqnSOZ9ZQg6zGfPPaS/s4WJN56S8Rgfhq3FvPkutM6
         oHldjdmmwA88JxA+XWbUnijDaTI1zwDZgwB/i2DWBX04pX5mGZ4PgEp5spLOXSrd6ALD
         cDaA==
X-Gm-Message-State: ACgBeo0wLBM5qfg+bReTgkd7SkGUidFlSh9H3ewxatM6E4CyhE/aXYYC
        DoRKJrJP/aL1KyoODWp0iXx0KGm6CXcMHXyCuTN5zg==
X-Google-Smtp-Source: AA6agR7j8OY+h4Oql3K6L0ub3i+Dic+OMxkCNwt9XJdwoxGrEmWocMpg0Oz5l8/cyWBM/VTSKYC2kfOutoj2QFe/T1U=
X-Received: by 2002:a5b:88a:0:b0:6ad:5eca:575b with SMTP id
 e10-20020a5b088a000000b006ad5eca575bmr6464622ybq.577.1662660848578; Thu, 08
 Sep 2022 11:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-10-jthoughton@google.com> <YxovdUbObkjVVKMl@xz-m1.local>
In-Reply-To: <YxovdUbObkjVVKMl@xz-m1.local>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 8 Sep 2022 11:13:56 -0700
Message-ID: <CADrL8HXVOwNnjiGaAMoT0PaL_FUpz=j0HQ2MvycbBjnp--uNWA@mail.gmail.com>
Subject: Re: [RFC PATCH 09/26] hugetlb: add hugetlb_hgm_enabled
To:     Peter Xu <peterx@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 11:07 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Jun 24, 2022 at 05:36:39PM +0000, James Houghton wrote:
> > +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> > +bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> > +{
> > +     /* All shared VMAs have HGM enabled. */
> > +     return vma->vm_flags & VM_SHARED;
> > +}
> > +#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
>
> Another nitpick: suggest to rename this to "hugetlb_***_supported()" (with
> whatever the new name could be..), as long as it cannot be "disabled". :)
>

Will do. :)

- James

> --
> Peter Xu
>
