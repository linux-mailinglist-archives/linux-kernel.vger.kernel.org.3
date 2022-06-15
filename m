Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E4554CB5F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242339AbiFOObR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbiFOObO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:31:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C8B48E7D;
        Wed, 15 Jun 2022 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655303473; x=1686839473;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=ebzG/Ie0Atn1wc1fbw7UUsZ2l0WjLkTgfQladVZYz+g=;
  b=dYhZCOr0gHNz/LAr1qA3EhZG2fkhR0EwOM/5t8M6BwEkaFAd2t1j4z3n
   QOHsCtOG4ZqZ/BWdOqW7nXCGhq+N6zg89Nq8xw0O5EPdo/zPbI1itn0OQ
   FTrxs/uVLezPn26gXPzn99zgYwwDX+fJwaWxkYC55O8j9GwpJyTrZMsLp
   sOaqZhNRRAFobYJwhb2tQHz38T75ZsqBkFy8e0tQPnvg/8jFlnvwEFybu
   ZdSQdYVOcr23yeJePSy6C7BN2+PGtsxxrQ66X50Exq9wJOI70uKuoXDwU
   khlq8jWlNx+u7jJ5ILRRf4a3adIbnk/pO7ywPp3ifzzw7Kk+NgKlNAJyJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="267668217"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="267668217"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 07:31:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="727421534"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2022 07:31:10 -0700
Message-ID: <9075b67b-9290-8d31-abe5-3755d4c93d97@linux.intel.com>
Date:   Wed, 15 Jun 2022 17:32:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Content-Language: en-US
To:     Hongyu Xie <xy521521@gmail.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        125707942@qq.com, wangqi@kylinos.cn, xiongxin@kylinos.cn,
        Hongyu Xie <xiehongyu1@kylinos.cn>
References: <20220615090703.1812560-1-xiehongyu1@kylinos.cn>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v2 -next] usb: xhci: disable irq during initialization
In-Reply-To: <20220615090703.1812560-1-xiehongyu1@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.6.2022 12.07, Hongyu Xie wrote:
> irq is disabled in xhci_quiesce(called by xhci_halt, with bit:2 cleared
> in USBCMD register), but xhci_run(called by usb_add_hcd) re-enable it.
> It's possible that you will receive thousands of interrupt requests
> after initialization for 2.0 roothub. And you will get a lot of
> warning like, "xHCI dying, ignoring interrupt. Shouldn't IRQs be
> disabled?". This amount of interrupt requests will cause the entire
> system to freeze.
> This problem was first found on a device with ASM2142 host controller
> on it
I see, makes sense to enable interrupts as close as possible to where we
start the host.

For some unknown reason xHCI specification recommends enabling interrupts
(INTE and IE bits) before setting the Run/Stop bit, see xhci 4.2
Host Controller Initialization, "Note" part

So the order here needs to be swapped to comply with spec.
This unfortunately also creates a small window where xHC can interrupt
before xHC is running, but it's better than current situation.

This small window could be solved by protecting this part with a
spin_lock_irqsave().

Thanks
-Mathias
