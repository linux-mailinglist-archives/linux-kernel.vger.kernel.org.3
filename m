Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4124454219E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391234AbiFHBAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444566AbiFGXCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:02:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4684E326E7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 13:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654633004; x=1686169004;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oa7be7baBm0n3iWafiYaE07e1MExtPBJOGW0P5KwdXY=;
  b=NZRY0VkMkU4hjAluTfXZueOenewEyMYuH3Otia7qX/tgOLA+GVp1jKFT
   W+ffZ3gOjYiuJbJw5g9PdCTod2/bArtIUSCgSPIIvPpayurkuI/tXmr/d
   ttXC4U1cqlUWhcN4RtQ+TznPtpeBUKzI2B43jDDK8/2NOz0J7CsSWQH0t
   DXEtGgk5oNGa/Y4PFhMAePFxhf5SKsFDrchST1y0bvHcYHKHBnwtf3lMI
   Gd8Znhh5yd5frTvdqArEi9ioHOxEYlru/hqx7bsk3SSvqKcm+yeJGFV8n
   ktWhEMZHefUYqUeXkhpAkeezdpaJ7L9Lfr01691ZI2GYzHVd+wyHuzoyQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="338333000"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="338333000"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 12:25:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="648191587"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.8.166])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 12:25:43 -0700
Message-ID: <d99836a86fea8a975ba207d1c874ee062836004d.camel@linux.intel.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v3)
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Ying Huang <ying.huang@intel.com>
Cc:     Wei Xu <weixugc@google.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Feng Tang <feng.tang@intel.com>, Linux MM <linux-mm@kvack.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Date:   Tue, 07 Jun 2022 12:25:42 -0700
In-Reply-To: <20220530135043.00001e88@Huawei.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
         <c453491b-6dc1-a008-d6f4-3c806eebd2ef@linux.ibm.com>
         <CAAPL-u_NwJuxWe7Wfn3A1sut+QwEmoZh2QUBQKNPq4bU=NjybA@mail.gmail.com>
         <1281d918c07b05ac82aee290018ad08d212e0aaa.camel@intel.com>
         <20220530135043.00001e88@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-30 at 13:50 +0100, Jonathan Cameron wrote:
> 
> > When discussed offline, Tim Chen pointed out that with the proposed
> > interface, it's unconvenient to know the position of a given memory tier
> > in all memory tiers.  We must sort "rank" of all memory tiers to know
> > that.  "possible" file can be used for that.  Although "possible" file
> > can be generated with a shell script, it's more convenient to show it
> > directly.
> > 
> > Another way to address the issue is to add memtierN/pos for each memory
> > tier as suggested by Tim.  It's readonly and will show position of
> > "memtierN" in all memory tiers.  It's even better to show the relative
> > postion to the default memory tier (DRAM with CPU). That is, the
> > position of DRAM memory tier is 0.
> > 
> > Unlike memory tier device ID or rank, the position is relative and
> > dynamic.
> 
> Hi,
> 
> I'm unconvinced.  This is better done with a shell script than
> by adding ABI we'll have to live with for ever..
> 
> I'm no good at shell scripting but this does the job 
> grep "" tier*/rank | sort -n -k 2 -t : 
> 
> tier2/rank:50
> tier0/rank:100
> tier1/rank:200
> tier3/rank:240
> 
> I'm sure someone more knowledgeable will do it in a simpler fashion still.
> 
> 

You can argue that 

$ cat /sys/devices/system/cpu/cpu1/topology/core_siblings
f
$ cat /sys/devices/system/cpu/cpu1/topology/core_siblings_list
0-3

provide exactly the same information and we should get rid of
core_siblings_list.  I think core_siblings_list exists to make
it easier for a human, so he/she doesn't have to parse the mask,
or write a script to find out the ids of CPUs who are siblings.

I think in the same spirit, having an interface to allow a
human to quickly see the hierachical relationship of tiers 
relative to each other is helpful. 

Tim

