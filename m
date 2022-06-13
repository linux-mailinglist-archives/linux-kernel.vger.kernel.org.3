Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A647254978E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243845AbiFMQNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 12:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238939AbiFMQMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 12:12:22 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83A62BB3E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 07:05:08 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id x75so4046782qkb.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2uvE+96AE40B5D9SEjeoO7wUD1uHjMFwPLFqz90kcxE=;
        b=dhkeAwwgmJlGzbqP5cKO5yLsH/U26Gg3xkWAY1YDtWkEqWqqMDu4/K2hbstXMpqTSt
         GevejCeT7ehQNUzIuilK4w9PZtRdFNTH26tQfyXq+7VhTmBIyKexpdsgAhhEf7dGSY9A
         e2P9ajY9fxHp4OjbsaXhXua5poKwvGYLlLNYZUXSnHx4lpV41r1OhdF3rxdM8XF4lMa7
         Z7qKbIm4tZMzoIGOoDyqnTUxCEq9zf9du61mze01jJwzOslP5UDhE8fwTbL6GzbdbDFU
         F/zYbS7/c4ljC/t6b+yADrrzc3m1CbW5quBJDoo4LKkAUMF9JuPAjFv9J3fRQk2Wy/TB
         x38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2uvE+96AE40B5D9SEjeoO7wUD1uHjMFwPLFqz90kcxE=;
        b=ySo8QW0XA4IBHByngbBmIFmYCgNakPiN6jd0XQjpYnPJ64rr0I29C5bg09TehGPrn/
         BPhHJeuICkPBNY+KpTAuBItfmfamdguwEaNM3PrLWIsgquTxariZ6EXf6ZqJh1Fuapdh
         IgKJIOtnU3vrlnrOTX8iQUjNY1jNVTDD4npq0KjAleirK3DKLUcGzubsqdSiSe5gJqQ3
         1aSgr/KULwSkHnZxhzoqN8cfIZXylmDfAjTAytG3uDGGZOSdcwpH3rXimpF4+RYBL7Pj
         xqtAZlN+YsHzNcnm8ZuDLS0lPyWSJBmbO92e8VBbPVyjsHu2/SRpYtjnuWkAu7t/WAt/
         RvXQ==
X-Gm-Message-State: AOAM530Yrxr/f7m6giexVtLbeUyhipgOyKehuW10aF8SvS2MrwsnxIbL
        JkZRhW8Bs5uVvKMLaVBrAvqkFg==
X-Google-Smtp-Source: ABdhPJyntuMEPzVmsjPDsujYll/edMXAZwa1KP/bBEQ5QkN5fmiDoOpCV9ywmDfGrdr9D/Utn3G6Og==
X-Received: by 2002:a05:620a:4409:b0:6a7:8480:a89d with SMTP id v9-20020a05620a440900b006a78480a89dmr45807qkp.9.1655129107199;
        Mon, 13 Jun 2022 07:05:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2c45])
        by smtp.gmail.com with ESMTPSA id q14-20020a05620a024e00b0069fc13ce1f2sm6565301qkn.35.2022.06.13.07.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 07:05:06 -0700 (PDT)
Date:   Mon, 13 Jun 2022 10:05:06 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Wei Xu <weixugc@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
Message-ID: <YqdEEhJFr3SlfvSJ@cmpxchg.org>
References: <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
 <YqCuE87gCcrnAiXG@cmpxchg.org>
 <YqDGYjgjcS5OoS3P@cmpxchg.org>
 <a4af7598-7bd3-0e70-a434-b1237ca403d6@linux.ibm.com>
 <YqDncfLeEeBaosrY@cmpxchg.org>
 <02ee2c97-3bca-8eb6-97d8-1f8743619453@linux.ibm.com>
 <YqH74WaUzJlb+smt@cmpxchg.org>
 <20220609152243.00000332@Huawei.com>
 <YqJa4N/VlS4zN4vf@cmpxchg.org>
 <20220610105708.0000679b@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610105708.0000679b@Huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 10:57:08AM +0100, Jonathan Cameron wrote:
> On Thu, 9 Jun 2022 16:41:04 -0400
> Johannes Weiner <hannes@cmpxchg.org> wrote:
> > On Thu, Jun 09, 2022 at 03:22:43PM +0100, Jonathan Cameron wrote:
> > Would it make more sense to have the platform/devicetree/driver
> > provide more fine-grained distance values similar to NUMA distances,
> > and have a driver-scope tunable to override/correct? And then have the
> > distance value function as the unique tier ID and rank in one.
> 
> Absolutely a good thing to provide that information, but it's black
> magic. There are too many contradicting metrics (latency vs bandwidth etc)
> even not including a more complex system model like Jerome Glisse proposed
> a few years back. https://lore.kernel.org/all/20190118174512.GA3060@redhat.com/
> CXL 2.0 got this more right than anything else I've seen as provides
> discoverable topology along with details like latency to cross between
> particular switch ports.  Actually using that data (other than by throwing
> it to userspace controls for HPC apps etc) is going to take some figuring out.
> Even the question of what + how we expose this info to userspace is non
> obvious.

Right, I don't think those would be scientifically accurate - but
neither is a number between 1 and 3. The way I look at it is more
about spreading out the address space a bit, to allow expressing
nuanced differences without risking conflicts and overlaps. Hopefully
this results in the shipped values stabilizing over time and thus
requiring less and less intervention and overriding from userspace.

> > Going further, it could be useful to separate the business of hardware
> > properties (and configuring quirks) from the business of configuring
> > MM policies that should be applied to the resulting tier hierarchy.
> > They're somewhat orthogonal tuning tasks, and one of them might become
> > obsolete before the other (if the quality of distance values provided
> > by drivers improves before the quality of MM heuristics ;). Separating
> > them might help clarify the interface for both designers and users.
> > 
> > E.g. a memdev class scope with a driver-wide distance value, and a
> > memdev scope for per-device values that default to "inherit driver
> > value". The memtier subtree would then have an r/o structure, but
> > allow tuning per-tier interleaving ratio[1], demotion rules etc.
> 
> Ok that makes sense.  I'm not sure if that ends up as an implementation
> detail, or effects the userspace interface of this particular element.
> 
> I'm not sure completely read only is flexible enough (though mostly RO is fine)
> as we keep sketching out cases where any attempt to do things automatically
> does the wrong thing and where we need to add an extra tier to get
> everything to work.  Short of having a lot of tiers I'm not sure how
> we could have the default work well.  Maybe a lot of "tiers" is fine
> though perhaps we need to rename them if going this way and then they
> don't really work as current concept of tier.
> 
> Imagine a system with subtle difference between different memories such
> as 10% latency increase for same bandwidth.  To get an advantage from
> demoting to such a tier will require really stable usage and long
> run times. Whilst you could design a demotion scheme that takes that
> into account, I think we are a long way from that today.

Good point: there can be a clear hardware difference, but it's a
policy choice whether the MM should treat them as one or two tiers.

What do you think of a per-driver/per-device (overridable) distance
number, combined with a configurable distance cutoff for what
constitutes separate tiers. E.g. cutoff=20 means two devices with
distances of 10 and 20 respectively would be in the same tier, devices
with 10 and 100 would be in separate ones. The kernel then generates
and populates the tiers based on distances and grouping cutoff, and
populates the memtier directory tree and nodemasks in sysfs.

It could be simple tier0, tier1, tier2 numbering again, but the
numbers now would mean something to the user. A rank tunable is no
longer necessary.

I think even the nodemasks in the memtier tree could be read-only
then, since corrections should only be necessary when either the
device distance is wrong or the tier grouping cutoff.

Can you think of scenarios where that scheme would fall apart?
