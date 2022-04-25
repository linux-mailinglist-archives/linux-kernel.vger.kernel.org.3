Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C2B50E8F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244641AbiDYTAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbiDYTAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:00:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6DE124D83
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:57:33 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id j6so13338963pfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6o+SI4yj6/1QuIDP6FADkDckBUMPioD3y38MqpuhkSo=;
        b=P1K4PYS25TS0Jd/Wx1fojI8IZ5I9h3+RLAY7MrwpwNS/97M2bik+Fzj4uCxSceTFqC
         By1zfFuX/dRkCdeEJYZr+gPWBQpJmKS+xMan4GPia2P7HYavXB/ti79lxVJxwM7d4LM4
         aPK1RRSJ/R9VAaoblJjSjAtxHnDWIJPEq87p8VBqlTtFdSmnFgJdFtRWqMM0h49u6xc9
         rhrP0KJj3lMgZHRcTs+tyLa2KjZgBcbNipfstGdWxKKlnvCyT2TaW1Syc4TU9KG3ibtj
         4zHlVZKN7G/200mOGcecQer5k4ANX/oi0/zChwRmOOQUjYp8HN+wmH5LUUnSU34FuuRS
         Hgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6o+SI4yj6/1QuIDP6FADkDckBUMPioD3y38MqpuhkSo=;
        b=n67zavTJEjzhIpn13pxrEI+pVvn6Cs0Q8Hr0uAY1UXKUXQcSeBDfa7tvC84SWw/mUA
         xBFyQRYdEajmKebjJDwdYRwOekbeqBHuE/UduSwS/jOqCRCOKsl92oRY4x5xPyLzgR2E
         7OlS5L3pMNx4N4Zy9L9CcBzjvnfLElNyic2zWL20mkk7m3ZlVX43RRpJGuJcF1GAzYML
         h4LG7w4IGo6EZoEyVgian609zu3BdtatSq34U1CEXN0Hxmh74N67dP8oEeODD86ouLcW
         f4OIV5XXiZc8+Y3FUpOBLxw5L6bPuXGzByilI6DLyAHkOdf4mPvSqssvkhZzBMPFpCTg
         +yeg==
X-Gm-Message-State: AOAM531ELiVk+lYx6QQ3rWQr8NOD4nR0jvR0+Vq+Sp/w8FyNOwBprmbn
        4emVuNgDuAEqcv0Ra2C7Zkk0Whq1Kv3KdIa+7smk0Q==
X-Google-Smtp-Source: ABdhPJyUxljZXNAY57tBgo6I/sBtSCxjGKyLUSTbY3/eBgitnlYZPc3dWMb2Osy5fBb0Ykt3C3DNXYRbEpXXGPyfmdk=
X-Received: by 2002:a05:6a00:e14:b0:4fe:3cdb:23f with SMTP id
 bq20-20020a056a000e1400b004fe3cdb023fmr20248514pfb.86.1650913052859; Mon, 25
 Apr 2022 11:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <165055518776.3745911.9346998911322224736.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165055519869.3745911.10162603933337340370.stgit@dwillia2-desk3.amr.corp.intel.com>
 <YmNBJBTxUCvDHMbw@iweiny-desk3> <CAPcyv4jtNgfjWLyu6MtBAjwUiqe2qEBW802AzZZeg2gZ_wU9AQ@mail.gmail.com>
 <CAPcyv4hhD5t-qm_c_=bRjbJZFg9Mjkzbvu_2MEJB87fKy3hh-g@mail.gmail.com>
 <20220425103307.GI2731@worktop.programming.kicks-ass.net> <CAPcyv4i9ONW5w6p2P+E5rpw25_kmzpYf6SbmRM4+eP5hK4si-A@mail.gmail.com>
In-Reply-To: <CAPcyv4i9ONW5w6p2P+E5rpw25_kmzpYf6SbmRM4+eP5hK4si-A@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 25 Apr 2022 11:57:21 -0700
Message-ID: <CAPcyv4hT7TcTxV_x1hhp8zVev21SMMUO7o2NkJw5OozjDRO4dQ@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 9:05 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Apr 25, 2022 at 3:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sat, Apr 23, 2022 at 10:27:52AM -0700, Dan Williams wrote:
> >
> > > ...so I'm going to drop it and just add a comment about the
> > > expectations. As Peter said there's already a multitude of ways to
> > > cause false positive / negative results with lockdep so this is just
> > > one more area where one needs to be careful and understand the lock
> > > context they might be overriding.
> >
> > One safe-guard might be to check the class you're overriding is indeed
> > __no_validate__, and WARN if not. Then the unconditional reset is
> > conistent.
> >
> > Then, if/when, that WARN ever triggers you can revisit all this.
>
> Ok, that does seem to need a dummy definition of lockdep_match_class()
> in the CONFIG_LOCKDEP=n case, but that seems worth it to me for the
> sanity check.

Thankfully the comment in lockdep.h to not define a
lockdep_match_class() for the CONFIG_LOCKDEP=n stopped me from going
that direction.
