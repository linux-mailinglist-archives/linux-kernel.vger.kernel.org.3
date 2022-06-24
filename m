Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49D8559A49
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiFXNUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiFXNT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:19:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EF654FBD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656076797; x=1687612797;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OP4OPqMU/aTprlJAWfXbs7y8fAZNP38GbVym8fpLFeo=;
  b=a9E1GH6R7YqOho9OZU6jh711qVLMZ6301JmVZa1nfC0YipdVUWRwQqbN
   R5Q2eTb4mEgZu89Tpg3zVQN+6BmY7DHUmt6NZt+ERV1Ird+X1zkphhHte
   1Wtp1BFl309vS3/zFcYL7e9yc8BjkX11CweZaR3b9ngGz8Q1Whu07yLAR
   FU4jrGqIBEDvDOhep2jxrK1S28ha192agNb+kTYFYLfgh1U+HG63kmtma
   T8rd/GU0fhycnWOmssW/WqLi0A5dyKuZ1aLxgNWFUJ2r+1X5kzJHfrkVd
   vKQo8pe5XAdtUIb1hU0o9zYQ5mcHxguL1nsre6t0/B5Uu5OI3IqWnx/EI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="260813864"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="260813864"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 06:19:56 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="586571033"
Received: from mdedeogl-mobl.amr.corp.intel.com (HELO [10.209.126.186]) ([10.209.126.186])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 06:19:56 -0700
Message-ID: <b4190b5d-89e8-b02f-5ef6-c05047af8166@intel.com>
Date:   Fri, 24 Jun 2022 06:19:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 4/5] x86/mm: Add noalias variants of
 set_memory_*crypted() functions
Content-Language: en-US
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-5-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220609025220.2615197-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 19:52, Kuppuswamy Sathyanarayanan wrote:
> set_memory_*crypted() functions are used to modify the "shared" page
> attribute of the given memory. Using these APIs will modify the page
> attributes of the aliased mappings (which also includes the direct
> mapping).
> 
> But such aliased mappings modification is not desirable in use cases
> like TDX guest, where the requirement is to create the shared mapping
> without touching the direct map. It is used when allocating VMM shared
> buffers using alloc_pages()/vmap()/set_memory_*crypted() API
> combinations.
> 
> So to support such use cases, add support for noalias variants of
> set_memory_*crypted() functions.

This changelog has a lot of words, but doesn't tell us much.

It basically says, we don't want to touch the direct map in use cases
where we don't want to touch the direct map.  Not helpful.

The alias processing is there for a reason.  What is it?  Why don't you
need alias processing for TDX?  Sure, you decided you don't want to
touch the direct map, but *WHY*?  Why is it normally OK to touch the
direct map, but not OK in this case?  Even better, why is it *DESIRABLE*
to leave the direct map alone?  Lastly, why is this safe?  If alias
processing was to protect us from something, why is losing that
protection OK here?

