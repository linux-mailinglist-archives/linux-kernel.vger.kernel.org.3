Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55A451C8A3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384815AbiEETHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384416AbiEETHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:07:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601A84B1D4
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 12:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651777430; x=1683313430;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4tROlkNo1kbPCFN62W49cfr118LlJIiTBohgCgaZqMg=;
  b=jko0gGkwQSye1xN0AXP/yV9MS93gXUwQGWGiBBoqBa7kt7u2H55z5G6h
   A1dwJHO+AYqWbculX1w+SRdtqTyJgmZSPeT/+WO8JFBJEUQ28wt/5K8Pk
   se/OZUMHxcOIwytot1MSumeUvRIBpN43L9/yIvvlhrCRmShlJK/qzkChD
   6SuvZomh034QXnR/qh/yDLzCaCZxuDk+Z22I52qhErp2BuurT3Ki6QbO2
   xPnGz1lXMpuZV47kj2GiiXohvrQv5Mx3KpnnS1zxbxg+YfGFZJ/oTzyEG
   lBnF1OVT+9Kv+vqU0cU9lxxJ0Q3xxFty40puyBgGrUscoTiB9r7L0+isC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248757016"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="248757016"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 12:03:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="585505604"
Received: from jdrobitc-mobl1.amr.corp.intel.com (HELO [10.209.123.186]) ([10.209.123.186])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 12:03:46 -0700
Message-ID: <5d34ac93-09dc-ea93-bffe-f3995647cd5b@linux.intel.com>
Date:   Thu, 5 May 2022 12:03:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
 <1534b975275b78d61d851eb86faa226fd9be5c7a.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <1534b975275b78d61d851eb86faa226fd9be5c7a.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai,

On 5/5/22 3:50 AM, Kai Huang wrote:
> 
>> +       /* Submit GetQuote Request */
>> +       ret = tdx_get_quote_hypercall(buf);
>> +       if (ret) {
>> +               pr_err("GetQuote hypercall failed, status:%lx\n", ret);
>> +               ret = -EIO;
>> +               goto free_entry;
>> +       }
>> +
>> +       /* Add current quote entry to quote_list */
>> +       add_quote_entry(entry);
>> +
>> +       /* Wait for attestation completion */
>> +       ret = wait_for_completion_interruptible(&entry->compl);
>> +       if (ret < 0) {
>> +               ret = -EIO;
>> +               goto del_entry;
>> +       }
> 
> This is misuse of wait_for_completion_interruptible().
> 
> xxx_interruptible() essentially means this operation can be interrupted by
> signal.  Using xxx_interruptible() in driver IOCTL essentially means when it
> returns due to signal, the IOCTL should return -EINTR to let userspace know that
> your application received some signal needs handling, and this IOCTL isn't
> finished and you should retry.  So here we should return -EINTR (and cleanup all
> staff has been done) when wait_for_completion_interruptible() returns -
> ERESTARTSYS (in fact, it returns only -ERESTARTSYS or 0).


But in this case, I was expecting the user agent to check the Quote
buffer status code to understand the IN_FLIGHT, SUCCESS or FAILURE
status and handle it appropriately. So IMO, it should not matter what
we return for the failure case. For the IN_FLIGHT case, they can retry
if they want after checking the status code.

But I agree that EINTR is the appropriate return value for an
interrupted case. So, I will change it.

> 
> Since normally userspace application just ignore signals, and in this particular
> case, asking userspace to retry just makes things more complicated to handle, I

I am not sure how the user agent is going to be implemented. So I don't
want to make any assumptions. In this case, we are not asking user space
to implement the retry support using signals. But we are just giving 
them option to do it. It is up to them if they want to use it.

> think you can just use wait_for_completion_killable(), which only returns when
> the application receives signal that it is going to be killed.

If you agree with the above point, we can leave just it as 
*_interruptible(). But if you still see other issues, please let me
know.

> 
>> +
>> +       /* Copy output data back to user buffer */
>> +       if (copy_to_user((void __user *)quote_req.buf, buf->vmaddr,
>> quote_req.len))
>> +               ret = -EFAULT;
>> +
>> +del_entry:
>> +       del_quote_entry(entry);
>> +free_entry:
>> +       free_quote_entry(entry);
> 
> As I (and Isaku) mentioned before, when wait_for_completion_killable() returns
> with error, you cannot just convert the buffer to private and free it.  The VMM
> is still owning it (IN_FLIGHT).

Do you know what happens when VMM writes to a page which already marked
private? Will MapGPA fail during shared-private conversion?

> 
> One way to handle is you can put those buffers that are still owned by VMM to a
> new list, and have some kernel thread to periodically check buffer's status and
> free those are already released by VMM.  I haven't thought thoroughly, so maybe
> there's better way to handle, though.

Instead of adding new thread to just handle the cleanup, maybe I
can move the entire callback interrupt logic (contents of
attestation_callback_handler()) to a work queue and wake up this
work queue whenever we get the callback interrupt.

We can let the same work queue handle the cleanup for interrupted
requests. As for as how to identify the interrupted request, we
can add a bit in queue_entry for it and set it when we exit
wait_for_completion*() due to signals.

I will do a sample logic and get back to you.



> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
