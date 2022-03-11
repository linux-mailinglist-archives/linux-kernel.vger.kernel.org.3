Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433F14D6746
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350597AbiCKRLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349499AbiCKRLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:11:12 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE4FD444E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647018608; x=1678554608;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=p9BhkaxiWbSuCDwfv6fPTGlhyGO3m3RMfcZIxaye4DA=;
  b=W78cKCIfoRAyViAKCS75PvWOzRCbA00Ftd57ITzgMHAfpaB6SlLU/3xe
   TBLPk/08PxaskTf9vWUtoodL1jZ8InSnNLXL9dkyw9gj3s/wCrKpL94jm
   ariPDaC5Y7e0DSh6BwosGnselrRgP5UAcTMgFaRMmYHTAYCYo0jiDUI04
   C/JKCyutjhiJgEjSdd9ZX1OwYNg1BPuq4+cuuSvpmeBnkcEsAHD3O3ZK2
   NkxSoAifmyXp9pYubJjsLVvqwmNs08aUzBYWPG7V8NMr4hYVHDNFUuwho
   DPvP/+4bjuEg9zSGh1xb6qrRswlrKPkcnSqVNVdo5Dh1QLezNtr+v2XQm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="316333577"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="316333577"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 09:10:08 -0800
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="644988416"
Received: from cpeirce-mobl1.amr.corp.intel.com (HELO [10.212.128.243]) ([10.212.128.243])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 09:10:07 -0800
Message-ID: <c3b12235-b0ee-c5c5-b876-e96519786503@intel.com>
Date:   Fri, 11 Mar 2022 09:10:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220310120749.23077-1-osalvador@suse.de>
 <20220310183951.cb713c6ae926ea6ea8489a71@linux-foundation.org>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2] mm: Only re-generate demotion targets when a numa node
 changes its N_CPU state
In-Reply-To: <20220310183951.cb713c6ae926ea6ea8489a71@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/22 18:39, Andrew Morton wrote:
> On Thu, 10 Mar 2022 13:07:49 +0100 Oscar Salvador <osalvador@suse.de> wrote:
>> We do already have two CPU callbacks (vmstat_cpu_online() and vmstat_cpu_dead())
>> that check exactly that, so get rid of the CPU callbacks in
>> migrate_on_reclaim_init() and only call set_migration_target_nodes() from
>> vmstat_cpu_{dead,online}() whenever a numa node change its N_CPU state.
> What I'm not getting here (as so often happens) is a sense of how badly
> this affects our users.  Does anyone actually hotplug frequently enough
> to care?

I asked Abhishek about this a bit here:

> https://lore.kernel.org/all/4e8067e1-0574-c9d2-9d6c-d676d32071bd@linux.vnet.ibm.com/

It sounded to me like there are ppc users who convert their systems from
SMT=1 to SMT=8.  I'd guess that they want to do this as a side-channel
mitigation because ppc has been dealing with the same basic issues as
those of us over in x86 land.  The increase in time (20s->36s) would be
noticeable and probably slightly annoying to a human waiting on it.

I'd love to hear more details on this from Abhishek, like whether end
users do this as opposed to IBM's kernel developers.  But, it does sound
deserving of a stable@ tag to me.
