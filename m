Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BE94B509C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353530AbiBNMup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:50:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242811AbiBNMun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:50:43 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3FE4B873;
        Mon, 14 Feb 2022 04:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644843035; x=1676379035;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Eb6rJWw2D0/3or5NxM/OEIohDMtNNIjXLf3CGb8tFSs=;
  b=oGAFyXjl4N6S2DGcpLM4IwF308xkIGzaX4vjfWZ5Vm72eJcScjNBBpAa
   Ebu77i/dAf2jxSMDnZ2k2SPJALmTASrMVPWDBj9amZNn/3iKOrP/GeTBT
   8DHibcqW6LjQbMMYMKgxVMBqZZwwX/eHjpIkNfjeurCHr/zfS7Ih4GFuA
   ObZCKD+q1gAO/2HWd9ZVvwWPv9YZNOy7TRt56VcaDlJEurolWZiPFJHmn
   T+SnyFhLANyQBEks+8HdtdLY59A48XXxbn5PBpgkHe9pbPnGvdWRU4DVL
   DV3zPUVJ6GWA/8mIcyFtULCAl1bBVybQC+l0mqVL2eKNIe+sVkQP2UcRk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="274652689"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="274652689"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 04:50:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="570163664"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 14 Feb 2022 04:50:17 -0800
To:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ugoswami@quicinc.com, Jung Daehwan <dh10.jung@samsung.com>
References: <1644836663-29220-1-git-send-email-quic_pkondeti@quicinc.com>
 <1644841216-1468-1-git-send-email-quic_pkondeti@quicinc.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v2] xhci: reduce xhci_handshake timeout in xhci_reset
Message-ID: <d82746d2-4096-1477-42dd-fd393e0ff827@linux.intel.com>
Date:   Mon, 14 Feb 2022 14:51:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1644841216-1468-1-git-send-email-quic_pkondeti@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.2.2022 14.20, Pavankumar Kondeti wrote:
> From: Daehwan Jung <dh10.jung@samsung.com>
> 
> xhci_reset() is called with interrupts disabled. Waiting 10 seconds for
> controller reset and controller ready operations can be fatal to the
> system when controller is timed out. Reduce the timeout to 1 second
> and print a error message when the time out happens.
> 
> Fixes: 22ceac191211 ("xhci: Increase reset timeout for Renesas 720201 host.")


The commit 22ceac191211 ("xhci: Increase reset timeout for Renesas 720201 host.")
intentionally increased the timeout to 10 seconds as that host might take 9
seconds to complete reset. This was done almost 10 years ago so I don't know
if it really is an issue anymore.

Anyways, your patch might break Renesas 72021 instead of fixing it.

I agree that busylooping up to 10 seconds with interrupts disabled doesn't make sense.

Lets see if there is another solution for your case.

- Does a "guard interval" after writing the reset help?
  For example Intel xHCI needs 1ms before touching xHC after writing the reset bit

- Is it the CNR bit or the RESET bit that fails? could be just stuck CNR bit? 
 
- we only disable local interrupts when xhci_reset() is called from xhci_stop(),
  and sometimes from xhci_shutdown() and xhci_resume() if some conditions are met.
  Have you identified which one is the problematic case?

  I think we halt the host in the above case first, meaning there should be no
  xHC interrupts when xhci_reset() is called. So if we could guarantee xhci interrupt
  isn't handled on this cpu, maybe we could somehow enable local interrupt after 
  halting the host?

  haven't really thought this true yet, but something like this could e investigated:

  spin_lock_irqsave()
  xhci_halt()
  < enable interrupts, magically turn spin_lock_irqsave() to just keeping spin lock>
  xhci_reset()
  spin_unlock()

-Mathias
