Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C94153407E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245178AbiEYPkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiEYPkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:40:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A957A888A
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653493236; x=1685029236;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yr71LVtIF0IzK1uygtSjo875vCTw40HqQF9YxW8zSVQ=;
  b=UvWiL5pEfyMSllPJQEEbAB1rTnSnE4t3HI+Uf+o6c7oeU/HU86cZiKnD
   Z2kbwGR489xeIJuU8MucfAXYri8YrN3nHq5fFlE/mcstSQ7XowRcOvn0C
   8v1oc6e+y381Dp1Z+GwOM1qAth3IKIAd7vKX75XcIbnXj6y8yEhKoTTgi
   7cxyWM3VwsIx9FxyaS9Fib1V6dOMRcv2A2ama6PO1rf95lasejhsbFCxG
   lRqT3hkE8VHFOENAiP8kmpiFTT/1rtHFbXKB1rWhd8NYuYN5Jh1+KWKbb
   uhq0XRQwaGo2nYiiMBLgJ4J4uiubUj2Ldc0iKduVdJLLZlm+eTWJNA22x
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="360236085"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="360236085"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 08:40:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="573316986"
Received: from hcrossle-mobl.amr.corp.intel.com (HELO [10.209.24.64]) ([10.209.24.64])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 08:40:34 -0700
Message-ID: <2e9802ec-dc06-29bd-b6db-b66c5ad49886@linux.intel.com>
Date:   Wed, 25 May 2022 08:40:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v7 2/5] x86/tdx: Add TDX Guest event notify interrupt
 support
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220524040517.703581-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220524040517.703581-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <2db114898222afd86eee77bf8ac46099c75f154e.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <2db114898222afd86eee77bf8ac46099c75f154e.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai,

On 5/23/22 11:40 PM, Kai Huang wrote:
>> +/* Helper function to register tdx_event_notify_handler */
>> +void tdx_setup_ev_notify_handler(void (*handler)(void))
>> +{
>> +	tdx_event_notify_handler = handler;
>> +}
>> +EXPORT_SYMBOL_GPL(tdx_setup_ev_notify_handler);
>> +
>> +/* Helper function to unregister tdx_event_notify_handler */
>> +void tdx_remove_ev_notify_handler(void)
>> +{
>> +	tdx_event_notify_handler = NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(tdx_remove_ev_notify_handler);
> I don't think you need to export the two symbols now.

Agree. I will remove it.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
