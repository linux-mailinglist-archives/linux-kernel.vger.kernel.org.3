Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9C650E527
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243214AbiDYQJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239120AbiDYQJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:09:13 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0303D4A7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:06:05 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id z16so15209831pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oLqZ9c6sJzKGVM/TrMqjVTTMcQElvmSe6MdCuYk9x8Q=;
        b=Kl/Kuw7/AEkG7eQdk9S+05HGcLyCpNWYXhVVB2IJqCWiZn0qCxth0QAUBN9WCYGH2q
         KHTEkQv5NB1gyhlYsq6fcoAXcZ0sRGVJXqSy7uVnctT4IqSt3J1KbZRLh+A3HXd+1/Xw
         L/AWrHjhnCxxeO37Au6NcgvAFiJb7bb5OscK0lO8/zR5Jmgy5u2l0TORiJXO5ixPoHMs
         zJRugmb3sdUUlbc5NmqLDWJWTqRas9qlraFQhD1G/O0KFHutPKqzNv2r2OeI/vsg/+ZD
         e3vmoXhZeqIkne7m4mg69eNcbIJNjLoNtx+dAWKp3hxEIQHDBp+9uqGTn87ys0zkwJWp
         yD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLqZ9c6sJzKGVM/TrMqjVTTMcQElvmSe6MdCuYk9x8Q=;
        b=Jsond6UrvZjRe7Gvf2xHj/DG9hQFOd/cwtKArJaItNSXyhztnXMGz1PYBJaYXs80h1
         8+aBWSMoPd2D2NdOIKcKbvTYv4Q+xKZqsTdeIRsHriMwTaZtQJe1KlvCmjuBU4wo0e7D
         JZYKKVUcdylamqIcmVIZxeBst1ALmfUm7MvN1RlPGd+DFxdn/19M777wjfVaPypHymUC
         Z/k3QXsUCkYb1FmFjasTGOAzyYPMgVVIofGKrT24XGJSwlTBmEs91Xi8S3Sj8693Wt56
         /gku8XpgwirqfRpjSCBimq53xKXA5EUsD8cjLIVCbv/2R5b91JP3f4bKhtPHAYmFrvYn
         Gm6w==
X-Gm-Message-State: AOAM5308v9Y1ZGsq+qlY+0k4vEV1IksY+vJ0Lz9ljN+ZmB8bRP+k2kJw
        xAMPU0NVe0eSTYI++y4SIocvbUrfXq0g6TNuI7RJfw==
X-Google-Smtp-Source: ABdhPJwFK8ld7Fwmr2XzFlKxbva0mlpLg8j05RBrmyALHC9dgyLruIqa1nUtcD2iqd9rDwtnLmR2eEiosc52IWwKarM=
X-Received: by 2002:a05:6a02:283:b0:342:703e:1434 with SMTP id
 bk3-20020a056a02028300b00342703e1434mr15676482pgb.74.1650902764645; Mon, 25
 Apr 2022 09:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <165055518776.3745911.9346998911322224736.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165055519869.3745911.10162603933337340370.stgit@dwillia2-desk3.amr.corp.intel.com>
 <YmNBJBTxUCvDHMbw@iweiny-desk3> <CAPcyv4jtNgfjWLyu6MtBAjwUiqe2qEBW802AzZZeg2gZ_wU9AQ@mail.gmail.com>
 <CAPcyv4hhD5t-qm_c_=bRjbJZFg9Mjkzbvu_2MEJB87fKy3hh-g@mail.gmail.com> <20220425103307.GI2731@worktop.programming.kicks-ass.net>
In-Reply-To: <20220425103307.GI2731@worktop.programming.kicks-ass.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 25 Apr 2022 09:05:53 -0700
Message-ID: <CAPcyv4i9ONW5w6p2P+E5rpw25_kmzpYf6SbmRM4+eP5hK4si-A@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] cxl/acpi: Add root device lockdep validation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 3:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, Apr 23, 2022 at 10:27:52AM -0700, Dan Williams wrote:
>
> > ...so I'm going to drop it and just add a comment about the
> > expectations. As Peter said there's already a multitude of ways to
> > cause false positive / negative results with lockdep so this is just
> > one more area where one needs to be careful and understand the lock
> > context they might be overriding.
>
> One safe-guard might be to check the class you're overriding is indeed
> __no_validate__, and WARN if not. Then the unconditional reset is
> conistent.
>
> Then, if/when, that WARN ever triggers you can revisit all this.

Ok, that does seem to need a dummy definition of lockdep_match_class()
in the CONFIG_LOCKDEP=n case, but that seems worth it to me for the
sanity check.
