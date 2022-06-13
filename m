Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6EF5488DC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241746AbiFMPld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240757AbiFMPlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:41:11 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1777915EA7D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:16:15 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id y15so3830963qtx.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vTUVTphSjRqOLzEAq4AJERTLad8wEOEYyPCB9Gzzk28=;
        b=Z169z99Yp60K3L6aH53aQYSmZcelvnNMLnX6tk8ht16Qm3uhvNctCnuYXhB9g6O/q0
         VW23qE0clRf2Tx7RkHvrw0Z19LAJl409ZqBMjtbHki8NbU1rC9G2tVDVWsVIOzCBe8K1
         NHx+bQy9cdLqi1lJmzjAqJBcgbdwrY1m+tUWfsyOC2AoI3iiY/iT9WHSZWdTf5YYcX7Y
         dggVXOle1k/XyLx6L+6HJjWQiXV2jHvKGD3lC4DaN58vsWfdtyB0D3rDtvwxSaAhkxsm
         Mby8KDNhq7UOKe5INfIXGLt9kEqKVBHK8kgGhQR9wPB56YYA4luoneloQhreLU4m9B5A
         bE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vTUVTphSjRqOLzEAq4AJERTLad8wEOEYyPCB9Gzzk28=;
        b=yreJsYtqVdE3qb1dMMQFxnM5eSjm7brJAfPM0EPoGjhkLUFpB+L8v5KHRilkIYkrB8
         U14WwVvsV3/gd8lhIqcFc2hFlN+oyeA6foO8cMNsv+gn0E2vYXRDffLx1HGLEmopyJN+
         KtHuVuCeOKRGlfetEyEPvmNQn6Tvksh2hx/iR+R1Taqg0voj0hwFD+QtZBN1FJdtX8rF
         bgiWpZl+2N5pWECuLOLKZD2yIFRTPRto2SNSJw4xw2VIzXjd6NoFR0aeep4pL1XVPQk9
         zVaEG3qeLqdj+kwqONMVsjHxb/JuT2QbChARdVqBQ+fuHWZZRid3JOolkXSYJ7TQ5ADX
         whig==
X-Gm-Message-State: AOAM530eIkl0bD4rbVcZKxeWqQg5U8qfPozbmZmLqLzVVSPMz7oYYZUV
        DnbLOTpBGgklrPfmr4bOekXj+g==
X-Google-Smtp-Source: ABdhPJzFFYlc+aUgNHTgBjeN9WztvX9umq/ubQjpI0Exn2k9kqqMaI4dseFm9ZjnGVt5/mmQVLXb/A==
X-Received: by 2002:ac8:7d4d:0:b0:305:307a:6562 with SMTP id h13-20020ac87d4d000000b00305307a6562mr4897401qtb.481.1655126174749;
        Mon, 13 Jun 2022 06:16:14 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-00ea-7f88-5fd9-01cd.res6.spectrum.com. [2603:7000:c01:2716:ea:7f88:5fd9:1cd])
        by smtp.gmail.com with ESMTPSA id b128-20020ae9eb86000000b006a7137330e2sm6105984qkg.132.2022.06.13.06.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 06:16:14 -0700 (PDT)
Date:   Mon, 13 Jun 2022 09:16:13 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Ying Huang <ying.huang@intel.com>
Cc:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Wei Xu <weixugc@google.com>,
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
Subject: Re: [PATCH v6 01/13] mm/demotion: Add support for explicit memory
 tiers
Message-ID: <Yqc4nSEuso+YmPE7@cmpxchg.org>
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
 <20220610135229.182859-2-aneesh.kumar@linux.ibm.com>
 <7e0b41422dbd0976cb43c2f126e9371d5e311e77.camel@intel.com>
 <48096ad7-ce6d-79b7-1edd-7e6652ab2a4d@linux.ibm.com>
 <a88bd25fc77252dee4f895f3a9b2c1f6ebb5169e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a88bd25fc77252dee4f895f3a9b2c1f6ebb5169e.camel@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 01:30:08PM +0800, Ying Huang wrote:
> On Mon, 2022-06-13 at 09:01 +0530, Aneesh Kumar K V wrote:
> > On 6/13/22 8:52 AM, Ying Huang wrote:
> > > On Fri, 2022-06-10 at 19:22 +0530, Aneesh Kumar K.V wrote:
> > > > +config TIERED_MEMORY
> > > > +	def_bool NUMA
> > > > +
> > > 
> > > As Yang pointed out, why not just use CONFIG_NUMA?  I suspect the
> > > added value of CONIFIG_TIRED_MEMORY.
> > 
> > I decided to use TIERED_MEMORY to bring more clarity. It should be same 
> > now that we have moved CONFIG_MIGRATION dependencies to runtime. IMHO 
> > having CONFIG_TIERED_MEMORY is better than using CONFIG_NUMA.
> 
> I don't think CONFIG_TIERED_MEMORY bring no much value.  It's better
> to use CONFIG_NUMA directly.  But this is just my opinion.

I agree. As long as it's always built with CONFIG_NUMA, it's simply
NUMA code. Easy enough to modularize it later if somebody really wants
this to be configurable separately.
