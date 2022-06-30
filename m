Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F95560F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 04:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiF3CnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 22:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiF3CnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 22:43:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B249D1EAF3;
        Wed, 29 Jun 2022 19:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656556983; x=1688092983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1lniFQHbdKUYo5fK6cZ0TOr+5OfkEYvxDzpS35OnvAA=;
  b=CjEe1uZSCrqjrEK/uKr2Nk5UAISY9PCaSHviIhxhwmufXkeOe8OB9efO
   jUGcxed8OnQh73JddRnvpoNV+pg69VT0icZzZzQc8GHeDnjlSbrGfAUwz
   2/FbiebSQ3YKhvE5gfcwE/o47YokuO9gK3YMUFHSTOs/uOdiA/nJifKe4
   3d2hliadQ7R5bwU57snmpaCZ1t5Zs5DIGci87wBWCeL6FZYsgEsariOIo
   egCYFRHFtvIct9bpCUNDWc5kK/FNzNPd7uTWnT1jQK5wmXX+IofQue23I
   gOsi7frqweuVVrYDWWhUnNgLi09qEu9kBStAyLOqqGi3az4cOOICBgnT1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="262020362"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="262020362"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 19:43:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="647681038"
Received: from gao-cwp.sh.intel.com (HELO gao-cwp) ([10.239.159.23])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 19:42:59 -0700
Date:   Thu, 30 Jun 2022 10:42:43 +0800
From:   Chao Gao <chao.gao@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        ilpo.jarvinen@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v1 3/3] swiotlb: Split up single swiotlb lock
Message-ID: <20220630024238.GA884@gao-cwp>
References: <20220628070136.419163-1-chao.gao@intel.com>
 <20220628070136.419163-4-chao.gao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628070136.419163-4-chao.gao@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 03:01:34PM +0800, Chao Gao wrote:
>From: Andi Kleen <ak@linux.intel.com>
>
>Traditionally swiotlb was not performance critical because it was only
>used for slow devices. But in some setups, like TDX confidential
>guests, all IO has to go through swiotlb. Currently swiotlb only has a
>single lock. Under high IO load with multiple CPUs this can lead to
>signifiant lock contention on the swiotlb lock. We've seen 20+% CPU
>time in locks in some extreme cases.
>
>This patch splits the swiotlb into individual areas which have their
>own lock. Each CPU tries to allocate in its own area first. Only if
>that fails does it search other areas. On freeing the allocation is
>freed into the area where the memory was originally allocated from.
>
>To avoid doing a full modulo in the main path the number of swiotlb
>areas is always rounded to the next power of two. I believe that's
>not really needed anymore on modern CPUs (which have fast enough
>dividers), but still a good idea on older parts.
>
>The number of areas can be set using the swiotlb option. But to avoid
>every user having to set this option set the default to the number of
>available CPUs. Unfortunately on x86 swiotlb is initialized before
>num_possible_cpus() is available, that is why it uses a custom hook
>called from the early ACPI code.
>
>Signed-off-by: Andi Kleen <ak@linux.intel.com>
>[ rebase and fix warnings of checkpatch.pl ]
>Signed-off-by: Chao Gao <chao.gao@intel.com>

Just noticed that Tianyu already posted a variant of this patch.
Will drop this one from my series.
