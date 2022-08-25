Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656F45A18DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243373AbiHYSiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbiHYSiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:38:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0C28C02D;
        Thu, 25 Aug 2022 11:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661452682; x=1692988682;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UDIT9w7lLnqkI9XrrOn8rPx4zbFBiEYDz5hJTNkU2iU=;
  b=f8h8O2Kxp+OjhE7U7LdW7SXEqSv3Hzi1IdXGWOSbyPR72rB0dvGq/jeT
   YwTg4B7axbST8PJklFJeyObqiTnPnNHIXb6ft4/L90LIyY1u03s3dSZgy
   cgcH6wSTB4vW7FwzWVCchcawKaWB1o9YQIhdX9hpgp/x7nJ7g3PcEttCt
   FtVCqR75AJFDvE1Axvc28ESG2ygGv0CEuo34ssjNN2t+7uI6kww64iPgt
   VAd9upeVOx65jH+6N2QTPDdRx+WxXFIVS6I1VI6Gs6jFUr1vvTHbISrko
   g1uLbkomBYXQu+IysMHBMdar95kr0nvGeKtzVds8FTdJGB3K5XzVJV7D9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="277345921"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="277345921"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 11:38:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="752596178"
Received: from manjeets-mobl.amr.corp.intel.com (HELO [10.212.220.1]) ([10.212.220.1])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 11:38:00 -0700
Message-ID: <9dda4484-4c81-ab86-0227-ea926178986e@intel.com>
Date:   Thu, 25 Aug 2022 11:38:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] x86/sgx: Do not consider unsanitized pages an error
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-sgx@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20220825080802.259528-1-jarkko@kernel.org>
 <c63e554e-e433-b088-280c-aa1a185ade61@intel.com>
 <Ywe+Zw4NgLrwvEo7@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Ywe+Zw4NgLrwvEo7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/22 11:27, Jarkko Sakkinen wrote:
> On Thu, Aug 25, 2022 at 07:07:44AM -0700, Dave Hansen wrote:
>> On 8/25/22 01:08, Jarkko Sakkinen wrote:
>>> However, if the SGX subsystem initialization is retracted, the sanitization
>>> process could end up in the middle, and sgx_dirty_page_list be left
>>> non-empty for legit reasons.
>> What does "retraction" mean in this context?
> Rest of the initialization failing or features not detected (-ENODEV).

Can you please work on communicating better descriptions of the
problems?  This really isn't good enough.

I think you're talking about sgx_init().  It launches ksgxd from
sgx_page_reclaimer_init() which sets about sanitizing the
'dirty_page_list'.  After launching ksgxd, if later actions in
sgx_init() (misc_register(), sgx_drv_init(), sgx_vepc_init()) fail,
ksgxd will be stopped prematurely.

This will leave pages in 'sgx_dirty_page_list' after
__sgx_sanitize_pages() has completed, which results in a WARN_ON().

The WARN_ON() is really only valid when __sgx_sanitize_pages() runs to
completion *and* fails to empty 'sgx_dirty_page_list'.

Is that it?

If so, could you please give the changelog another go?
