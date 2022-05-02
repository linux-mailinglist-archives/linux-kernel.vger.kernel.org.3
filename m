Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D647B5173BB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240717AbiEBQKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386432AbiEBQJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:09:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D6B55AF
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651507549; x=1683043549;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yCmW60f+YT/OL0t3fVfWIfpIPwMrSLpzQKwudRTsldY=;
  b=T90rQMFyBXzAhyIRz+eQTm/zOd+jLjCX8PIdnM1qUAJltUGZDCaUEPzm
   ZDLyt45RwbtEcB/2pmiicThEkWF16OfDnrvJ/P9meJ6QoPI7m09WKNgOl
   EbdrwBrg54HrVATAe9u56Rj+gK++s7oOHxBaD/bKXYpkls9vm7t2RIfYm
   y+UOWWq/hRffP5y/bN9pT1NJLWf/7wEaw9z24g+kYiuWyAS7FmK/4paho
   oKJRW4MisT8iaqTYB3XD4xJ+URriK/mEUiuyt63AXsOq3J8heLXB3XgO8
   fc7Ksjc42JjfFg15oJ0iJLLHxvdhUlcxhbTimAVUM3pKed4NGOKkP2foi
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="330239773"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="330239773"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 09:05:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="583768506"
Received: from wahmed-mobl.amr.corp.intel.com (HELO [10.209.71.202]) ([10.209.71.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 09:05:46 -0700
Message-ID: <e7cd179e-cb8c-46bd-9232-7cf8de50f76d@linux.intel.com>
Date:   Mon, 2 May 2022 09:05:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Ym/ZwMUHbgz4av3U@fedora>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Ym/ZwMUHbgz4av3U@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/22 6:16 AM, Wander Lairson Costa wrote:
> IIUC, ret has a positive value at this point, due to the call to
> wait_for_completion_interruptible, so we need add "ret = 0;"
> here, don't we?

It looks wait_for_completion_interruptible() return 0 on successful
completion. So I think I need to change ret <=0 to ret < 0.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
