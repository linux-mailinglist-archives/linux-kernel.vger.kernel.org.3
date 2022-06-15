Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CFF54D4C4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349797AbiFOWtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349219AbiFOWtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:49:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121A3563AE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655333391; x=1686869391;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KTjICITjrVt2DQkelrrQm6WihpE66G8gij1AAo7jBWs=;
  b=Ziuvf6uf1HQ8VPmLmrAhxJEVLn6c9xWpP5hZWz5G5zG0WcAVjRYfW4G5
   f+HE1zIUeA42ld10dIHdAFiHjrd3vMYsHPvuC9f/XLaJXJFqRJngX3fu3
   8TgYXskV3oyUCw2dnLpTQwv6K7m1NgtKbGfY2mQdsXiU/HBSC1IsjPGmU
   kd+Suu/v3L9GcMUcCficr4kg3x9g5eJ5GtLx9ecUrxxHwVuT4Ph3phdH8
   XI7u5/JfyII8JMN/IEuOixFSSD2ZW/q98+SZUd7lLRmg389Wj2IPai+cL
   m1I71z/gWsuNqbMu2ggWK5aMSKQOgPSTPs2ZaI4LIlRpsvLLrjAMKeG4A
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="258971800"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="258971800"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 15:49:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="559409416"
Received: from mjortiz-mobl.amr.corp.intel.com (HELO [10.212.185.241]) ([10.212.185.241])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 15:49:48 -0700
Message-ID: <e7852739-0b68-65ef-2800-71337420a30a@intel.com>
Date:   Wed, 15 Jun 2022 15:49:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv4 3/3] x86/tdx: Handle load_unaligned_zeropad() page-cross
 to a shared page
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org
References: <20220614120135.14812-1-kirill.shutemov@linux.intel.com>
 <20220614120135.14812-4-kirill.shutemov@linux.intel.com>
 <051fd468-11e6-308b-66c8-4de16ff80deb@intel.com>
 <20220615171042.oeumb3vs3ttu4rvd@black.fi.intel.com>
 <1d190555-2bb1-e483-2405-e28ddabead07@intel.com>
 <20220615224303.el4qtowheu2rgpdn@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220615224303.el4qtowheu2rgpdn@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 15:43, Kirill A. Shutemov wrote:
> I will reword it like this:
> 
> 	The issue was discovered by analysis after triggering other issue with
> 	load_unaligned_zeropad().

Yeah, that sounds sane.  I'm also happy to shove this into the commit
message before I push it out.
