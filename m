Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1BA543251
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241084AbiFHOQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239694AbiFHOQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:16:16 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886B83B025
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:16:14 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id hf10so14961849qtb.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 07:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h7N335UFTXnHO0leC4IVZEdPoke4t13sB0ujYHwtWyk=;
        b=zodZYwDc6rWs8ZvzUFT3Om/6LcXy+l8BJIKcShifIxQQkwi6e+Op/p2WMi5fveqegX
         jRbtQH5mEzH4yGo7sj1s+nO6z/XVMoAxauIgSBcsrCSkWbrB+7cPf4B9w8oK5eYrR8bI
         vT0zN0kw+nWPmXd3Ux5P+bxGrWjN9kZSXuDS0f5bbtyQYusME83pKFdSwEPLl8QCpwyq
         IoYQ3x1cUjpf8NI6Riml2WnWuQBSeFsjzMBG6U8LEXQerMRwKal/n/T7ZoSKwCVJLkgU
         YlK8Ut8upBm1j6DRmDWzVZydXzfxgQ9V9RtQaqzozO4a79IiNzTu+MsTYYsbFKUwwNNm
         YT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h7N335UFTXnHO0leC4IVZEdPoke4t13sB0ujYHwtWyk=;
        b=XlLON0OF+KGH8fFNaZTgAflZ+7eZAK2k0KvDn/qJEHSdPLmBFXIYZ2q03jQYvratyY
         0Tsb5vRMILQuEW9jT699hq/TaacrgiXg6o4YTMxWcjVG00xrtlOl66PVzlr8rMSbvLJy
         uQblxwxXkGdjC22DcJ3UT/u2cHK85ab0tnPsCaQGPfotAPyKNwXe1c3Wlv7CJuROcOi1
         DXupAGqP7panJZq1WSQv5yjvXg6c6zGSv6S1MqKmEWdflcl4KQyurJ/4rJt42n+bEwgr
         ji4HYqoTO+mrjcc8RumCnWOyj2h/Qk7dkf3PW4Ac6wYnPcxi8VJzy/dFlLNF1aOUGspX
         2+1A==
X-Gm-Message-State: AOAM533o4DQcjzaytrxrVfeEHR0eS86no9hqAVUySYeSFZMAeD5xhhdo
        fczYYA/j1GFFGchGcn9RFwe/Pg==
X-Google-Smtp-Source: ABdhPJxVj0WsWXId7O8rVRKJ3c5Bgp+IUhbOfvsP/9LHyLgbkhXYY1p5hwNBNfBiykdYX+DJR5WB1g==
X-Received: by 2002:a05:622a:11c5:b0:304:d8cd:2058 with SMTP id n5-20020a05622a11c500b00304d8cd2058mr25095671qtk.324.1654697773504;
        Wed, 08 Jun 2022 07:16:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4759])
        by smtp.gmail.com with ESMTPSA id ca21-20020a05622a1f1500b0030504576cbfsm926861qtb.61.2022.06.08.07.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 07:16:12 -0700 (PDT)
Date:   Wed, 8 Jun 2022 10:16:12 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Ying Huang <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, Hao Wang <haowang3@fb.com>,
        Abhishek Dhanotia <abhishekd@fb.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Hasan Al Maruf <hasanalmaruf@fb.com>,
        Wei Xu <weixugc@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH] mm: mempolicy: N:M interleave policy for tiered memory
 nodes
Message-ID: <YqCvLM/ZMupRPpXP@cmpxchg.org>
References: <20220607171949.85796-1-hannes@cmpxchg.org>
 <dece66a05bb63a04706d25ca86f75bfc875c27fd.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dece66a05bb63a04706d25ca86f75bfc875c27fd.camel@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 12:19:52PM +0800, Ying Huang wrote:
> In general, I think the use case is valid.

Excellent!

> But we are changing memory tiering now, including
> 
> - make memory tiering explict
> 
> - support more than 2 tiers
> 
> - expose memory tiering via sysfs
> 
> Details can be found int the following threads,
> 
> https://lore.kernel.org/lkml/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com/
> https://lore.kernel.org/lkml/20220603134237.131362-1-aneesh.kumar@linux.ibm.com/
> 
> With these changes, we may need to revise your implementation.  For
> example, put interleave knobs in memory tier sysfs interface, support
> more than 2 tiers, etc.

Yeah, I was expecting the interface to be the main sticking point ;)
I'll rebase this patch as the mentioned discussions find consensus.

Thanks!
