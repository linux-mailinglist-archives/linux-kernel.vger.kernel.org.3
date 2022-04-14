Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAF4500C59
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242765AbiDNLt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiDNLt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:49:26 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4013CA55
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 04:47:02 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so9077467pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 04:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I4Ax15jC8NnVZwecST708pDmHH3endbmV/A+QAcQDXk=;
        b=VTKGC4GU/h3jcWzqni4siu6RzvhvBschAcPdHBRc9lvYS1SrLmAs6BsOib0sOOC9n9
         mPAvQhcYfa/SaI3Vy2SUKGJTBOWljBuEvQuqxIAS+PIYLjY+DJBtcExbtVRxxottNg22
         W2fZJthM/suuUQTulb1/oCvYpDRXsmSrysTzxtK9gwzlz3hSm10tb0AcvNa2lyCC6vpd
         diZX7L4Ti6YA0P9RvIPxXpfBaxn0uqV0MLAwtWvyWcvEA1ARVvCZKziZUsYALiZBo3Kz
         h8LarTqCDePq0UgHtwIQ1s/lLxD2pnWwf2JVUpGgDtIQ6XlQ0+TQDIyHXOdLc4Q+d9MB
         Uruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I4Ax15jC8NnVZwecST708pDmHH3endbmV/A+QAcQDXk=;
        b=Ufhx5t0ttipVf6RoEfZ23Qz/2jnvFQmBlCdxg/sdQVyzJ2GROIhTvbKWIjbRm6sFw0
         Ik191hCIxVgE6UwqyG/Lhc2kQ1xPVltUaMjSKu314z1GYTvIcECZe+TUUNp0DfifpcTI
         qdewfod0HOxlqSV70YZOIpyRClMghIrpJZMGk3mJU4PTb/DmRT3pvPZdLXDdRiS/IXMw
         eIL+CA0ENT6vIA+4SUw5aS1vPPAQJeGSq0EB+2ANTsJfrvC6J933G7nF4cgZGqBidkTL
         FmFcaTUzUHWsBEAEXml5SfqsJbiT4mN7MB/gJKTI9YomnIJ/MdCb7bUZfw/F+I6HXb0U
         eJUg==
X-Gm-Message-State: AOAM53240cnICQjjTryhu2I6DwfxXVVbZLPffn8eyY60lfoBO9Af1iHl
        tuxYWQo/RVFD7egbh4nkSTs=
X-Google-Smtp-Source: ABdhPJzsQvDicR9vwSUGgBVhv/HT7C7tQGE07WXlBZk/XE2dqgREhp4zs+OMYXlmvsED1JY9uw6BDw==
X-Received: by 2002:a17:90a:fac:b0:1ca:5eb8:f3b2 with SMTP id 41-20020a17090a0fac00b001ca5eb8f3b2mr3340533pjz.37.1649936822021;
        Thu, 14 Apr 2022 04:47:02 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id g15-20020aa7818f000000b00505ce2e4640sm1959117pfi.100.2022.04.14.04.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 04:47:00 -0700 (PDT)
Date:   Thu, 14 Apr 2022 20:46:54 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 23/23] mm/sl[au]b: check if large object is valid in
 __ksize()
Message-ID: <YlgJrjDcfQDKqHym@hyeyoo>
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
 <20220414085727.643099-24-42.hyeyoo@gmail.com>
 <alpine.DEB.2.22.394.2204141156160.690844@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2204141156160.690844@gentwo.de>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 11:58:01AM +0200, Christoph Lameter wrote:
> On Thu, 14 Apr 2022, Hyeonggon Yoo wrote:
> 
> > If address of large object is not beginning of folio or size of
> > the folio is too small, it must be invalid. Return zero in such cases.
> 
> This looks like a slab usage error on the part of the caller that would
> benefit from a kernel log entry. A warning or an error?


I think a WARN_ON() would be sufficient. here, will do in v3.
Thanks!

-- 
Thanks,
Hyeonggon
