Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A27251CC7D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386579AbiEEXJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239301AbiEEXJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:09:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8702849C87
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651791944; x=1683327944;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8zFl1ySBzU3C1JX8/kaCsJKh0UI6cak+gf4FwEGPeyE=;
  b=W0PIa6O2L33HA8N+9M1IldjtCHSOTCp67NW1YvwZ1aXZWY7vN7jimf3C
   KIUY/lJYUhfsCFVvPiGWe/VamwvmSPFLrocQU3US/0IOgF8eqK7aWhequ
   3kRpYS1J4EweWmem8rHdD8vY3WcjjFmLc1TKhT+A3PRWN4RgzY4h5j7b5
   T+LdTwr1tKhcX1jm4TlU2TnGixfsQVvhA5Fze4aKGXe/ambL/WRdDwpjk
   5fIvtITBU8xbBj3sRthVL1uQSDHoWN9lPCpxSPJ3fuLPhrT2lsyaQvMH9
   EoH8HC/ngy70QQXG9rw9UelgSDLd7WGzXxxxwj5Ax6WfBcLBXROwC9qMv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="265872143"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="265872143"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:05:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="665193489"
Received: from jesicili-mobl1.amr.corp.intel.com (HELO [10.213.189.201]) ([10.213.189.201])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:05:43 -0700
Message-ID: <d63d2774-c44d-27da-74b6-550935a196fd@intel.com>
Date:   Thu, 5 May 2022 16:06:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <243e918c523320ba3d216cbe22d24fe5ce33f370.camel@intel.com>
 <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
 <58d07b2d-cef5-17ed-9c57-e12fe5665e04@intel.com>
 <40ccd0f0-35a1-5aa7-9e51-25ab196d79e5@linux.intel.com>
 <2ed5c9cc316950a5a47ee714715b7980f358a140.camel@intel.com>
 <ab17102c-0cb7-87d3-3494-969866d64573@linux.intel.com>
 <d53696f85ada39a91a3685c61d177c582810772e.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <d53696f85ada39a91a3685c61d177c582810772e.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/22 15:15, Kai Huang wrote:
> set_memory_xx()  is supposedly only for direct-mapping.  Please use my
> suggestion above.

Kai, please take a look at some of the other users, especially
set_memory_x().  See how long the "supposed" requirement holds up.

That said, I've forgotten by now if this _could_ have used vmalloc() or
vmap() or vmap_pfn().  None of the logic about why or how the allocator
and mapping design decisions were made.  Could that be be rectified for
the next post?
