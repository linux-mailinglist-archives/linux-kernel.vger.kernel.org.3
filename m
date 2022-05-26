Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7310853516D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347920AbiEZPac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347910AbiEZPaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:30:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3500DD8088;
        Thu, 26 May 2022 08:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653579023; x=1685115023;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3B2Wr7V4mxS5yN7FqlZWSMeWz6geZFEoAVpPVPFG0QY=;
  b=bkyku7NUBX/SMJbHdk4IDnNnnQO8N+DNJAYNcY5yScQjVe7Md+65umaq
   QBuQZ/dFZ1vgi0+PfK5KWkPpB3UuLf0nJivPKxgq1kBNJnQPy7zxCs1/x
   kwIjPS/vhKfQ2fHipreFrZfJCaQjdyfuVEW+IsZxqGODcAovPJDLzuZSD
   7durXoaBfhHAahjwYbxFHpl8Rep2riDcNt+3yo5o8B43svyVhWNhf7/lU
   KL5cmxBtORhCoVzQmGYln+z1vR8ZPAQUILlvUvjV4j4LSg583QaqzHOzT
   ImIjNpcR8kx1w7OA3CiedkGAf2n5MRV4QF4qCMpyfRPlVKOG/ypED65B7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274295901"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="274295901"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 08:30:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="642933553"
Received: from tjeziers-mobl1.amr.corp.intel.com (HELO [10.251.23.34]) ([10.251.23.34])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 08:30:22 -0700
Message-ID: <902b4745-4ca0-9b29-6563-ed49f924a5e1@intel.com>
Date:   Thu, 26 May 2022 08:30:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] x86/platform/uv: Dont use smp_processor_id while
 preemptable
Content-Language: en-US
To:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20220520203755.266337-1-mike.travis@hpe.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220520203755.266337-1-mike.travis@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 13:37, Mike Travis wrote:
> To avoid a "BUG: using smp_processor_id() in preemptible" debug
> warning message, disable preemption around use of the processor id.

I'm sure this gets rid of the warning.  But, could you please take a
quick look at the callers and ensure that they can handle if this read
comes from another CPU?

In other words, what would actually go wrong if uv_read_rtc() got
preempted in this region?  What would this actually fix?
