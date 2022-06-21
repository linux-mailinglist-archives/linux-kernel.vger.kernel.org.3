Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D5E5533D0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351253AbiFUNjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351716AbiFUNil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:38:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA8B28987
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655818711; x=1687354711;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4g1OBCKHsQO3IKCZZ/oEJywrdg/bmeF4o4W6XXd/1Fc=;
  b=gAVUgnhEYvGV+8Ep9J4w0+hr6bJloYhdV0zlU7NmgXTM+hHiKXg7i106
   Qxy29iUoH8ZxszelCF5H1hv7vjqTqjpNZ6AtXI+zqEof5jQlQj3UxAbTg
   gg7YKMLZVpLD7c7J0vKoNSZOvUX0+CFBmG6DXfT/njaSaUsIlbOK3Y+IR
   EpSqjfJwgG/7xO0Hhme9K0amEzxVrpsFcWN/besbJmPaM7q+C6XdgtwDy
   43UdKrW319XhBRlOTium0RwHMgA8bfPyj+GCGJps/aTc2ArNBZI8xhBal
   Ds+08ZxFipo3qImGmGaKzH1+K0ysxCEyz8WUsVeic5zJBqlG7BMrmWNkf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="341802758"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="341802758"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 06:38:31 -0700
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="591653651"
Received: from dpasupul-mobl.amr.corp.intel.com (HELO [10.209.178.35]) ([10.209.178.35])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 06:38:30 -0700
Message-ID: <f80c7bf2-1d9e-40d7-d3bd-c8bbe548934b@linux.intel.com>
Date:   Tue, 21 Jun 2022 08:11:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [Sound-open-firmware] ASoC: SOF: Race condition in ipc.c
Content-Language: en-US
To:     noman pouigt <variksla@gmail.com>, Mark Brown <broonie@kernel.org>,
        liam.r.girdwood@linux.intel.com
Cc:     alsa-devel@alsa-project.org, peter.ujfalusi@linux.intel.com,
        ranjani.sridharan@linux.intel.com, linux-kernel@vger.kernel.org,
        yangyingliang@huawei.com, rander.wang@intel.com,
        yung-chuan.liao@linux.intel.com,
        sound-open-firmware@alsa-project.org
References: <CAES_P+_aC4cHMB3Tn0pz13_gKCpXs=efeae2JBvEPOK5zidYnA@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CAES_P+_aC4cHMB3Tn0pz13_gKCpXs=efeae2JBvEPOK5zidYnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/20/22 21:46, noman pouigt wrote:
> Folks,
> 
> I have borrowed part of SOF architecture for my own DSP
> framework development as the memory on the DSP is
> extremely small and wouldn't be able to support SOF.

You're providing very little context here. Of course it's open-source
and you can do whatever you want with the code, but it's not clear if
the 'borrowed' code can deal with your specific case.

> Currently I am running into a race condition as below:
> 
> CPU                                            DSP
> PCM_TRIGGER_START
> sof_ipc_send_msg ---->
> 
>                                       <------Immediate ACK
> ipc3_wait_tx_done
> (wait_event_timeout)
>                                       <------ POSITION update
> 
> snd_pcm_period_elapsed
> 
> 
> As you can see TRIGGER_START didn't even finish
> and waiting for it to complete in ipc3_wait_tx_done
> function. However, before it could complete the position
> interrupt was issued which results in calling period_elapsed
> function.
> 
> In order to fix this I assume below is called in SOF framework:
> schedule_work(&spcm->stream[substream->stream].period_elapsed_work);
> 
> How is this design working? If the interrupt is coming too fast
> from the DSP than the associated function with this schedule_work
> will not get called as the scheduler will not get time to schedule the
> workqueue and elapsed function will not be called thereby not increasing
> the hw_ptr. How is the flow control for data transfer achieved?

The schedule_work was added by this commit, and the explanations are
rather straightforward:

commit e2803e610aecb36ea4fec5a04861547664580d0c

Author: Keyon Jie <yang.jie@linux.intel.com>

Date:   Tue Apr 30 18:09:25 2019 -0500




ASoC: SOF: PCM: add period_elapsed work to fix race condition in
interrupt context

"
The IPC implementation in SOF requires sending IPCs serially: we should
not send a new IPC command to the firmware before we get an ACK (or time
out) from firmware, and the IRQ processing is complete.

snd_pcm_period_elapsed() can be called in interrupt context before
IRQ_HANDLED is returned. When the PCM is done draining, a STOP
IPC will then be sent, which breaks the expectation that IPCs are
handled serially and leads to IPC timeouts.

This patch adds a workqueue to defer the call to snd_pcm_elapsed() after
the IRQ is handled.
"

I am not sure what the problem you have really is.

It's not really surprising that the first period is consumed
immediately, the flow will become more steady-state afterwards.

The DMAs should be primed to deal with more than one period, and the
schedule_work() will only signal that the application can refill the
ring buffer. There's all kinds of delays that will happen depending on
load and scheduling, and if the POSITION_UPDATE was received immediately
then there's should be still plenty of time to provide a new buffer.

> 
> I am facing the above problem in my design.
> 
> I am wondering if I can simply add one more IPC command(don't call
> wait_event_interruptible for this) after TRIGGER_START to start the
> streaming.This way schedule_work for updating period_elapsed function
> can be avoided and it can be called in an interrupt context.

See commit above, this won't work because you'll be sending an IPC while
dealing with an IPC.
