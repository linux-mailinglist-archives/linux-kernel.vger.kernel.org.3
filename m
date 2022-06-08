Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9D6543825
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244664AbiFHPzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244561AbiFHPzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:55:17 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CAE2C67F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:55:16 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 15so10603241qki.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 08:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qPt4iZhleoIm2SUINneNwOWCL7eWnDd1KTUorYUI5+8=;
        b=0vi4pcXfTgM09EU78281Lr4S0ERJFDyhmbMmqENiB7mf4kZug4ZZJ4yL8xLN9+e7xJ
         PHCM5u6rVIsGfIdv9pDERZF5BnqTufGNvi4yF4O5gt+43loOqdYpLML7haRlBK0ehdlL
         Qaod6qGB6widDIE5cUAzyF2mBFJMus4CnwCYRU+j3f89q2wy2UbNdUEuC716TU7I8XRc
         9077m0OAS8EWKue/D1bXMOS2Pg2Ao2WdT37FrBlX6uc9hnLBL/TOpVt7jS6ZF5IXElVP
         zw9wn6s6SCel9q2qGmqsclaYdj5lcFIKAkGPetvQQvu5/+Fp1BZ+OSGA6csqW8pLB5JO
         C65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qPt4iZhleoIm2SUINneNwOWCL7eWnDd1KTUorYUI5+8=;
        b=a0sQN2DFdKyGz4L6SCiADF3eS1a9wvc1lL8m7OwwdGyyV/g1QpG118u9Wr+fbl4Kw+
         Ei4OAcLQQ8LaIPe2GCbg2shvIufnt99oz8f/9tIyKloZ26QGqOjh/RrAjMNKss7+m+bx
         XJTSBVIqt4B1bXTifqTTudDvzF85GmWF1R6FksI2naBJdwC9BBEgSAbSm34Vdc0+UdU3
         oPvW1rG5gSrxjLksPy1G1h4vkiUHtXbW342CvtcSZ5GbGjLk5kQtkO8va1zL+/o8XHTd
         w3Z7o/ZhCzQdlHVLRVEkqOn/b7TYqblXAfnCemrY7P5CieW+3yN3onAQu/w7lst9Pc7x
         c2KQ==
X-Gm-Message-State: AOAM533LsXQ4crkfsArFZ2cxkTYWjF4GYLpv+fPrOxAG7dZ2ovcAYZWq
        +rgHqRHcMFNZ4Gb48yV3dvok0Q==
X-Google-Smtp-Source: ABdhPJyTRv0J9Td1OgSBrw4WrYRRwBBgiPUsV6qhumqhrw6lci8vXx3V2YZ4cXBsiniaGpDhKaLbcg==
X-Received: by 2002:a05:620a:2046:b0:6a6:b8d1:7ddf with SMTP id d6-20020a05620a204600b006a6b8d17ddfmr11702965qka.380.1654703715300;
        Wed, 08 Jun 2022 08:55:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4759])
        by smtp.gmail.com with ESMTPSA id s3-20020a05620a0bc300b006a66f3d3708sm18349784qki.129.2022.06.08.08.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 08:55:14 -0700 (PDT)
Date:   Wed, 8 Jun 2022 11:55:14 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
Message-ID: <YqDGYjgjcS5OoS3P@cmpxchg.org>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
 <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
 <YqCuE87gCcrnAiXG@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqCuE87gCcrnAiXG@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jun 08, 2022 at 10:11:31AM -0400, Johannes Weiner wrote:
> On Fri, Jun 03, 2022 at 07:12:29PM +0530, Aneesh Kumar K.V wrote:
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_MEMORY_TIERS_H
> > +#define _LINUX_MEMORY_TIERS_H
> > +
> > +#ifdef CONFIG_TIERED_MEMORY
> > +
> > +#define MEMORY_TIER_HBM_GPU	0
> > +#define MEMORY_TIER_DRAM	1
> > +#define MEMORY_TIER_PMEM	2
> > +
> > +#define MEMORY_RANK_HBM_GPU	300
> > +#define MEMORY_RANK_DRAM	200
> > +#define MEMORY_RANK_PMEM	100
> > +
> > +#define DEFAULT_MEMORY_TIER	MEMORY_TIER_DRAM
> > +#define MAX_MEMORY_TIERS  3
> 
> I understand the names are somewhat arbitrary, and the tier ID space
> can be expanded down the line by bumping MAX_MEMORY_TIERS.
> 
> But starting out with a packed ID space can get quite awkward for
> users when new tiers - especially intermediate tiers - show up in
> existing configurations. I mentioned in the other email that DRAM !=
> DRAM, so new tiers seem inevitable already.
> 
> It could make sense to start with a bigger address space and spread
> out the list of kernel default tiers a bit within it:
> 
> MEMORY_TIER_GPU		0
> MEMORY_TIER_DRAM	10
> MEMORY_TIER_PMEM	20

Forgive me if I'm asking a question that has been answered. I went
back to earlier threads and couldn't work it out - maybe there were
some off-list discussions? Anyway...

Why is there a distinction between tier ID and rank? I undestand that
rank was added because tier IDs were too few. But if rank determines
ordering, what is the use of a separate tier ID? IOW, why not make the
tier ID space wider and have the kernel pick a few spread out defaults
based on known hardware, with plenty of headroom to be future proof.

  $ ls tiers
  100				# DEFAULT_TIER
  $ cat tiers/100/nodelist
  0-1				# conventional numa nodes

  <pmem is onlined>

  $ grep . tiers/*/nodelist
  tiers/100/nodelist:0-1	# conventional numa
  tiers/200/nodelist:2		# pmem

  $ grep . nodes/*/tier
  nodes/0/tier:100
  nodes/1/tier:100
  nodes/2/tier:200

  <unknown device is online as node 3, defaults to 100>

  $ grep . tiers/*/nodelist
  tiers/100/nodelist:0-1,3
  tiers/200/nodelist:2

  $ echo 300 >nodes/3/tier
  $ grep . tiers/*/nodelist
  tiers/100/nodelist:0-1
  tiers/200/nodelist:2
  tiers/300/nodelist:3

  $ echo 200 >nodes/3/tier
  $ grep . tiers/*/nodelist
  tiers/100/nodelist:0-1	
  tiers/200/nodelist:2-3

etc.
