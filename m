Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5261358D024
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 00:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244415AbiHHWdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 18:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244390AbiHHWdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 18:33:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E66A1BE9E
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 15:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659997980; x=1691533980;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bnjlZgpuutkZrJxBWQh2r6PZVMI3J0fNen2yYsfuf4A=;
  b=lOT/A/9CrcSsAwDZR/xvW/yf9eGdPkxLbdNz9q2MtaSfkyWxH4kXbOFC
   EJvDxUp5WMmkrMdiY4Se8xcIdGu0LsA3y2r+gNXmOyR/Q95/mm3lYx2kY
   9Jd9pIZ0k47AbKSRLm82NlYKVuYYg857TbVKuvIhe7dAZA263jwQA/3gQ
   wuNzIO30UTqCuWRb5Cthqt365U0ym9NFGWKGgDgOT5yeGmS3L74nAJXds
   CmTWqIaGJ0qD2K4rwvtfr9X8bpuTUCRGLSYBcdjeZDZrFlmrD7g6qlK6T
   EtcAc8d/BynB5vUhclDKRloqAPttB7p2TqOzJtMBua/X5v+kmdrSAmm2P
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="376997539"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="376997539"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 15:32:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="555101920"
Received: from sankarka-mobl1.amr.corp.intel.com (HELO [10.212.251.15]) ([10.212.251.15])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 15:32:59 -0700
Message-ID: <77087e5b-ae81-8809-bf37-448d18c7b618@intel.com>
Date:   Mon, 8 Aug 2022 15:33:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] x86/sev: Put PSC struct on the stack in prep for
 unaccepted memory support
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1659978985.git.thomas.lendacky@amd.com>
 <21d5d55640ee1c5d66501b9398858b6a6bd6546f.1659978985.git.thomas.lendacky@amd.com>
 <50599c3c-eacb-7774-746c-021adf3f56e3@intel.com>
 <6b615140-4075-4fab-de23-e0c7cd3c64d8@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <6b615140-4075-4fab-de23-e0c7cd3c64d8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/22 15:18, Tom Lendacky wrote:
>>>   +/* Flag to indicate when the first per-CPU GHCB is registered */
>>> +static bool ghcb_percpu_ready __section(".data");
>>
>> So, there's a code path that can't be entered until this is set?  Seems
>> like the least we can do it annotate that path with a
>> WARN_ON_ONCE(!ghcb_percpu_ready).
> 
> Sure, that can be added. Right now the only function that calls
> vmgexit_psc() is covered (set_pages_state()/__set_pages_state()) and is
> doing the right thing. But I guess if anything is added in the future,
> that will provide details on what happened.
> 
>>
>> Also, how does having _one_ global variable work for indicating the
>> state of multiple per-cpu structures?  The code doesn't seem to delay
>> setting this variable until after _all_ of the per-cpu state is ready.
> 
> All of the per-CPU GHCBs are allocated during the BSP boot, before any
> AP is started. The APs only ever run the kernel_exc_vmm_communication()
> #VC handler and only ever use the per-CPU version of the GHCB, never the
> early boot version. This is based on the initial_vc_handler being
> switched to the runtime #VC handler, kernel_exc_vmm_communication.
> 
> The trigger for the switch over for the BSP from the early boot GHCB to
> the per-CPU GHCB is during setup_ghcb() after the initial_vc_handler has
> been switched to kernel_exc_vmm_communication, which is just after the
> per-CPU allocations. By putting the setting of the ghcb_percpu_ready in
> setup_ghcb(), it indicates that the BSP per-CPU GHCB has been registered
> and can be used.

That description makes the proposed comment even more confusing:

	/* Flag to indicate when the first per-CPU GHCB is registered */

The important thing is that this variable is only _useful_ for the boot
CPU.  After the boot CPU has allocated space for _itself_, it can then
go and stop using the MSR-based method.

The reason it's set after "the first" is because "the first" is also the
boot CPU, but referring to it as the "the first" is a bit oblique.
Maybe something like this:

	/*
	 * Set after the boot CPU's GHCB is registered.  At that point,
	 * it can be used for calls instead of MSRs.
	 */
