Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEBF4FF2D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbiDMJEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiDMJEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:04:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1474C275D2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:01:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id i24-20020a17090adc1800b001cd5529465aso935429pjv.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QWIk+CChBFcaS/yL43f8uA+otFvOW4g6Y06AGrF6F8I=;
        b=M+bmwZ4mlAvW6R10zBHFqcMrzr7jlF7skopxY7yLRZlU6c/aqMhj+QpkU3/c2S38s4
         RzsEcTONt1Egvsg8rsXgjlqVzJS55KOfU9yeAVNTouOUb+58hJp/K8f7q9UpeW05Qebd
         S96NiqCtnEUX/1Pn5hh99feSHhAS79MlQxDOf+I2OYwX+K/Iv6MmYRHM6xNlWg9ZC+iD
         9GKKiOE37tjTvS+VtdnyU61/3vCw9oC99NC1jb3u6uejGvI+n+dkMfGSr5WQg0SAF/It
         viuz0h5IpLWBY6HjHN9vH6Pajaj0k1xbdzLgRdANeupCAPhZPkqTE31tQZ24ZywLKrtF
         NsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QWIk+CChBFcaS/yL43f8uA+otFvOW4g6Y06AGrF6F8I=;
        b=uDenZSqRbBMYnyyjidAQK35wFgRXIo9dphlm3oRLCW7VAtESK7Su8n0bbi0tjTBhC6
         ShDj5h8gcRGuM7fpwSGxaLhPciP48ZGKVqoHTnqGH7wpmF1nm4+tCn2e6NL3i9DgebYC
         J3xPY2K3cYyaHao4C2j9V3BqeQgOngEzw44a6bhylnhNskqmhfahNUKi/TObvDzfE19z
         hLswj8/foeQvz7L4J237S0PL2BbSVgzBbHKtazj+/mH9KOifB0EuFp2u0N8h93Ua0IrI
         jLuxwu4tuvm7/iTWG13oLZ+EGbjvfvRfBRzSg9mpXbYsNQrGjplZzriVzI+SIkA+Mht1
         wgDg==
X-Gm-Message-State: AOAM5332ID9riIosmvXTNXXAQMt72rC7xPat4JSHPDTYasb1/YXHiedS
        LkjkTeDpX9Dczb7V3KhME3FvFA==
X-Google-Smtp-Source: ABdhPJxg1IM/2LikVUfawCtR20Quwj8feqc02hb51z7TmFTz8tHmBatmmisODexqsbPtpm4QlGUS7g==
X-Received: by 2002:a17:90b:4c44:b0:1c7:1326:ec90 with SMTP id np4-20020a17090b4c4400b001c71326ec90mr9509276pjb.87.1649840512608;
        Wed, 13 Apr 2022 02:01:52 -0700 (PDT)
Received: from localhost ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id y7-20020a056a00180700b00506f420e62asm1170055pfa.11.2022.04.13.02.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:01:52 -0700 (PDT)
Date:   Wed, 13 Apr 2022 17:01:48 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     "liupeng (DM)" <liupeng256@huawei.com>, mike.kravetz@oracle.com,
        david@redhat.com, akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        baolin.wang@linux.alibaba.com, liuyuntao10@huawei.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] hugetlb: Fix return value of __setup handlers
Message-ID: <YlaRfDSYCrPJbOIH@FVFYT0MHHV2J.usts.net>
References: <20220413032915.251254-1-liupeng256@huawei.com>
 <20220413032915.251254-4-liupeng256@huawei.com>
 <YlaCA6kqjN5nYNSH@FVFYT0MHHV2J.usts.net>
 <5bbf45e7-1d92-f543-5cfc-bc0141999d46@huawei.com>
 <YlaIFL8TCRfiFFgR@FVFYT0MHHV2J.usts.net>
 <b6920f9f-4a0d-ec51-9f88-9fb3012a05d1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6920f9f-4a0d-ec51-9f88-9fb3012a05d1@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 04:45:30PM +0800, Kefeng Wang wrote:
> 
> On 2022/4/13 16:21, Muchun Song wrote:
> > On Wed, Apr 13, 2022 at 04:16:11PM +0800, liupeng (DM) wrote:
> > > On 2022/4/13 15:55, Muchun Song wrote:
> > > > On Wed, Apr 13, 2022 at 03:29:14AM +0000, Peng Liu wrote:
> > > > > When __setup() return '0', using invalid option values causes the
> > > > > entire kernel boot option string to be reported as Unknown. Hugetlb
> > > > > calls __setup() and will return '0' when set invalid parameter
> > > > > string.
> > > > > 
> > > > > The following phenomenon is observed:
> > > > >    cmdline:
> > > > >     hugepagesz=1Y hugepages=1
> > > > >    dmesg:
> > > > >     HugeTLB: unsupported hugepagesz=1Y
> > > > >     HugeTLB: hugepages=1 does not follow a valid hugepagesz, ignoring
> > > > >     Unknown kernel command line parameters "hugepagesz=1Y hugepages=1"
> > > > > 
> > > > > Since hugetlb will print warning/error information before return for
> > > > > invalid parameter string, just use return '1' to avoid print again.
> > > > > 
> > > > Can't return -EINVAL? It is weird to return 1 on failure.
> > > > 
> > > > Thanks.
> > > > 
> > > > .
> > > Not against "return -EINVAL", but consistent with:
> > > 1d02b444b8d1 ("tracing: Fix return value of __setup handlers")
> > I think it is better not return 1.  I don't think it's a good habit we
> > should follow.
> /*
>  * NOTE: __setup functions return values:
>  * @fn returns 1 (or non-zero) if the option argument is "handled"
>  * and returns 0 if the option argument is "not handled".
>  */
> #define __setup(str, fn)               \
>        __setup_param(str, fn, fn, 0)
> 
> 
> 1 or -EINVAL should ok, and  most __setup return 1 for know ;)
>

Got it. Thanks.  Seems like a lot of users make mistakes in
this regard [1].

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

[1] https://lore.kernel.org/all/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru/ 
