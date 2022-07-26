Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F09581938
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiGZRzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239853AbiGZRyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:54:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672BE30F6C;
        Tue, 26 Jul 2022 10:54:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 378E5CE11E0;
        Tue, 26 Jul 2022 17:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FB8C433C1;
        Tue, 26 Jul 2022 17:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658858042;
        bh=MTd2fTAvNUmuqKVSjZqDvs/4KSGaAZDJjBUdCfoNxoE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AHu3lwB8caO18Cqx0Six5fBB537DDG5SgSwgYiwM0v6qFGFJhI71wp8keugPVtw4j
         hTyDNOQHmw5yTDfki9yvxdV9S2shoC6gYPKRALh21LlChG6UEi4gwpmcqAHWT3plsb
         hCAWJME/nUa9QvwvunQMQEKCrLMWwZWFzFdliUXhlqssALibwVqLw3TcOwI3yIbGDC
         Dym5hs6AoIAFfvFJTCWcOCug7AuEDe+adoW8w0gcKllsofJEypQiujmeiKb3kLch0K
         qKcTKyMvCdHAiOsxjRTY33nnDDlOnSLaPo105MHwqX4apmhHBm+2GxYSMH7hTEfSCR
         GSBikSfYUdNuw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Qiang Yu <quic_qianyu@quicinc.com>, quic_hemantk@quicinc.com,
        loic.poulain@linaro.org, quic_jhugo@quicinc.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ath11k@lists.infradead.org
Subject: Re: [PATCH v3 1/1] bus: mhi: host: Fix up null pointer access in mhi_irq_handler
References: <1658459838-30802-1-git-send-email-quic_qianyu@quicinc.com>
        <20220726080636.GE5522@workstation>
Date:   Tue, 26 Jul 2022 20:53:58 +0300
In-Reply-To: <20220726080636.GE5522@workstation> (Manivannan Sadhasivam's
        message of "Tue, 26 Jul 2022 13:36:36 +0530")
Message-ID: <87czdrrc95.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manivannan Sadhasivam <mani@kernel.org> writes:

> +ath11k, Kalle
>
> On Fri, Jul 22, 2022 at 11:17:18AM +0800, Qiang Yu wrote:
>> The irq handler for a shared IRQ ought to be prepared for running
>> even now it's being freed. So let's check the pointer used by
>> mhi_irq_handler to avoid null pointer access since it is probably
>> released before freeing IRQ.
>> 
>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

This fixes the crash and my regression tests pass now, thanks. But
please see my question below.

Tested-by: Kalle Valo <kvalo@kernel.org>

>> +	/*
>> +	 * If CONFIG_DEBUG_SHIRQ is set, the IRQ handler will get invoked during __free_irq()
>> +	 * and by that time mhi_ctxt() would've freed. So check for the existence of mhi_ctxt
>> +	 * before handling the IRQs.
>> +	 */
>> +	if (!mhi_cntrl->mhi_ctxt) {
>> +		dev_dbg(&mhi_cntrl->mhi_dev->dev,
>> +			"mhi_ctxt has been freed\n");
>> +		return IRQ_HANDLED;
>> +	}

I don't see any protection accessing mhi_cntrl->mhi_ctxt, is this really
free of race conditions?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
