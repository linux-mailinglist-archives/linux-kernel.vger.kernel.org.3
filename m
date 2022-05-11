Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE58522DA4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238592AbiEKHt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243181AbiEKHtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:49:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7942380CE
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652255381; x=1683791381;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b6gFhgmPfcp/OZxV5AdY/HulAh7d6sjI5KnIRmFjjnE=;
  b=br4FO2HeL03j8llWkjIqTlDDbBnRMNoQmIVE6ttP1askSQsNr/LDcfrz
   tKeHsv+WUTHAcPliV2smWSuOWbB5jfLMu5WI3ccNCLke0WvF9zw/FGhwY
   1vGu9Xyvk6hz+q8lw7J5LQ3n1UWus1+MhD666utouinUgu91pxuCYF6uK
   r/ePjJgT7g4MaIp6Ts5BrrAB3f5AnpiwESvdncQ5XaLdEMBetqisU1scS
   tmfTtHakNVJz1qVagmyYkj/Oa5fLXsm4IZIbTUUz40m2iWQWk3301/06k
   vd7AdeCOrCIa3iNgSSvCfvHe1vu0hpMIW6IzW8w4mYUSrjxAjQQyV40J6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269753785"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="269753785"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 00:49:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="593991837"
Received: from rliu1-mobl1.ccr.corp.intel.com ([10.254.213.20])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 00:49:37 -0700
Message-ID: <68333b21a58604f3fd0e660f1a39921ae22849d8.camel@intel.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Wei Xu <weixugc@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Date:   Wed, 11 May 2022 15:49:34 +0800
In-Reply-To: <CAAPL-u9FvCfgA7xsqStLNZ=W03iyWBmvHrpVzPKyitsGN2v_KQ@mail.gmail.com>
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
         <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com>
         <CAAPL-u-r2Pc_MaHQmKKNH_icAa_fH1COWb5qSPpr8xffREQ_cQ@mail.gmail.com>
         <87tua3h5r1.fsf@nvdebian.thelocal>
         <CAAPL-u-0HwL6p1SA73LPfFyywG55QqE9O+q=83fhShoJAVVxyQ@mail.gmail.com>
         <875ymerl81.fsf@nvdebian.thelocal> <87fslhhb2l.fsf@linux.ibm.com>
         <CAAPL-u9FvCfgA7xsqStLNZ=W03iyWBmvHrpVzPKyitsGN2v_KQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-10 at 22:30 -0700, Wei Xu wrote:
> On Tue, May 10, 2022 at 4:38 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
> > 
> > Alistair Popple <apopple@nvidia.com> writes:
> > 
> > > Wei Xu <weixugc@google.com> writes:
> > > 
> > > > On Thu, May 5, 2022 at 5:19 PM Alistair Popple <apopple@nvidia.com> wrote:
> > > > > 
> > > > > Wei Xu <weixugc@google.com> writes:
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > Tiering Hierarchy Initialization
> > > > > > > > `=============================='
> > > > > > > > 
> > > > > > > > By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).
> > > > > > > > 
> > > > > > > > A device driver can remove its memory nodes from the top tier, e.g.
> > > > > > > > a dax driver can remove PMEM nodes from the top tier.
> > > > > > > 
> > > > > > > With the topology built by firmware we should not need this.
> > > > > 
> > > > > I agree that in an ideal world the hierarchy should be built by firmware based
> > > > > on something like the HMAT. But I also think being able to override this will be
> > > > > useful in getting there. Therefore a way of overriding the generated hierarchy
> > > > > would be good, either via sysfs or kernel boot parameter if we don't want to
> > > > > commit to a particular user interface now.
> > > > > 
> > > > > However I'm less sure letting device-drivers override this is a good idea. How
> > > > > for example would a GPU driver make sure it's node is in the top tier? By moving
> > > > > every node that the driver does not know about out of N_TOPTIER_MEMORY? That
> > > > > could get messy if say there were two drivers both of which wanted their node to
> > > > > be in the top tier.
> > > > 
> > > > The suggestion is to allow a device driver to opt out its memory
> > > > devices from the top-tier, not the other way around.
> > > 
> > > So how would demotion work in the case of accelerators then? In that
> > > case we would want GPU memory to demote to DRAM, but that won't happen
> > > if both DRAM and GPU memory are in N_TOPTIER_MEMORY and it seems the
> > > only override available with this proposal would move GPU memory into a
> > > lower tier, which is the opposite of what's needed there.
> > 
> > How about we do 3 tiers now. dax kmem devices can be registered to
> > tier 3. By default all numa nodes can be registered at tier 2 and HBM or
> > GPU can be enabled to register at tier 1. ?
> 
> This makes sense.  I will send an updated RFC based on the discussions so far.

Are these tier number fixed?  If so, it appears strange that the
smallest tier number is 0 on some machines, but 1 on some other
machines.

Best Regards,
Huang, Ying


