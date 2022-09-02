Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4125AB751
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiIBRPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbiIBROy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:14:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D51633E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 10:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662138892; x=1693674892;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ociHViEeSxi0I99NX7uRA7W9reDW4aCMRYbLEzzPzUY=;
  b=la+g/tp3cotrn0B8WH9gZlsdAX+YMwiyyufYamuT4fSs0MUVdP3HV2zV
   8h3a5/fj4l1v22gaIFV+xm1WKRnAoTl/+nenKOtzDIGZxGdCiawGDhJBH
   s49vStqVF5dSJRT8OpsfXb9sJwja7fHomRYphb/myr/KOki65ep0HVXrR
   50spGI3sbACMA4EPk7lwG4A+5HydW6LtAgXBMsgJ+j83+aG7822eXJRQi
   NnP8t+RNJF3FMQG47zqjrpgE4thlbAbS+GX6AiUfSwTTvl929Yawa0q6o
   el9Vv32vy2rUi3WduaJ2z73khAUcGPQobiiQ1SUKQut01dQFiW6Ei8rR8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="357741673"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="357741673"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 10:14:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="642986590"
Received: from tanjeffr-mobl1.amr.corp.intel.com (HELO [10.212.156.60]) ([10.212.156.60])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 10:14:51 -0700
Message-ID: <8722acbe-c668-5b05-c030-565f8c42068c@intel.com>
Date:   Fri, 2 Sep 2022 10:14:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC] x86/apic: skip cpu slot reservation logic on boot in
 case of NR_CPUS == 1
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
References: <20220902164211.1425982-1-yury.norov@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220902164211.1425982-1-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/22 09:42, Yury Norov wrote:
> This is RFC because I'm not sure that this is not a false positive from
> smatch. If NR_CPUS is 1, and the condition is always true, it's simply
> optimized out by a compiler, and nothing wrong happens, except maybe a
> couple of checks on boot.

I think it's a reasonable warning, but it's also not something we need
to hack around.  We can surely only land in here with
boot_cpu_detected==true if NR_CPUS==1, so the rest of the expression is
moot.

I don't think it's worth adding the #ifdef.
