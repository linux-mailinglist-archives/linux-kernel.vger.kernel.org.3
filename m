Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B64C598A90
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344816AbiHRRen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344666AbiHRRej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:34:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4907BB7ECE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660844079; x=1692380079;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j9dyTTvzViV+de7VJ/NUqqrzYps/6g0N6F+mX6NZ13I=;
  b=Aphw9cQBymMXeWqgA/XzNEydQe0nUbbqG4x7GG05lHRZF409YHh7h/Xh
   S4n4fTWKRCqu8WoSk/1Bugjwz7PsfI/g+yr1FhXKcSExfSiXqiApZ0SOk
   fJHx+IXvdbj7yyzJaRYOjEt4rJd7dBXphfrCeutc0c7pMQtCRTMpClkau
   6NuOyFFwf2DxXCOMRF/u2povqnPtvhUz76iDpxjzflIu8nxfbEyoDwDOm
   tpQ5cbjgwFYAelCMWpyzZzMRyvbK7ksEIMD0YlNvihgw9HwOk5ahJ1BmJ
   06eJwAm/muuAfzmP2nhL4r2VM5BNkI9LKrlsUd4Y6LCTYjAfP0KFc5Q8Q
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="318846747"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="318846747"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 10:34:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="853491041"
Received: from amalikya-mobl.amr.corp.intel.com (HELO [10.212.238.171]) ([10.212.238.171])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 10:34:37 -0700
Message-ID: <8b2b0155-31a8-4470-c0ed-9747b21d66c9@intel.com>
Date:   Thu, 18 Aug 2022 10:34:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/5] x86/microcode/intel: Allow a late-load only if a min
 rev is specified
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20220813223825.3164861-1-ashok.raj@intel.com>
 <20220813223825.3164861-4-ashok.raj@intel.com>
 <Yvn5vBRNz9z8Y4A9@worktop.programming.kicks-ass.net>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Yvn5vBRNz9z8Y4A9@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/22 00:46, Peter Zijlstra wrote:
> What if any validation do you have to ensure min_rev does as promised?
> That is, ucode can very easily lie about the number and still remove an
> MSR or CPUID enumerated feature.

We can absolutely add sanity checks to this.  It would not be hard at
all to, for instance, dump out all the CPUID leaves we can get our hands
on and diff them before and after a ucode update.

That said, min_rev is *architectural*.  It includes an architectural
promise from Intel that the ucode won't lie.  If Intel is breaking
architectural promises, it has bigger problems on its hands.

Bugs happen, of course -- even bugs in architectural features.  If there
are enough bugs that we can't trust min_rev, late-loading will just get
disabled again, probably permanently.  Our Intel colleagues should have
all the incentive in the world to be very, very careful with min_rev.
