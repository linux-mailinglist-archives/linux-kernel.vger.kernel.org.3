Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B3C5A5B14
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 07:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiH3F0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 01:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiH3F0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 01:26:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCDE4A805;
        Mon, 29 Aug 2022 22:25:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CA5F6CE1758;
        Tue, 30 Aug 2022 05:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05121C433C1;
        Tue, 30 Aug 2022 05:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661837155;
        bh=3yqxcS7dQZQOpbb7/uOnTFNQ1/YCaRMFuuWwnpC4s6Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=EfL3T9hUGjzQsjWuSMwj4srw26KD/aeh57IhRzyo4hoK1+DfflrNKKzJy3luZd2VV
         ldakR/75yO16W0+H7wG4jmeI8AZXNJQpJFPMjRrVZF5AJyqgFM2MO+z8iY29wosN44
         dmW3213K3flJu2/YsIIF58MlCGFQaWIeR9jOhWLEGlGD368vllOykdZUOXDMYQeNS4
         FJ0+qWvO6xlngNCeQ8UCq7L0UDlb5ONVjaZl3zyrRpgbHzuZZsyP0a85JwkenKrXTu
         9aT4jR2qp7IBzuJ29cn1vCEYmD4p82anZtF97dE3pSKxVq/q4fFtZ05UJwvpRtsD2j
         Xwobdb5rQfxkQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Qiang Yu <quic_qianyu@quicinc.com>, quic_hemantk@quicinc.com,
        loic.poulain@linaro.org, quic_jhugo@quicinc.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ath11k@lists.infradead.org
Subject: Re: [PATCH v3 1/1] bus: mhi: host: Fix up null pointer access in mhi_irq_handler
References: <1658459838-30802-1-git-send-email-quic_qianyu@quicinc.com>
        <20220726080636.GE5522@workstation> <87czdrrc95.fsf@kernel.org>
        <20220729142221.GA9937@thinkpad> <87h71vc98l.fsf@kernel.org>
        <20220829172654.GA84762@thinkpad>
Date:   Tue, 30 Aug 2022 08:25:48 +0300
In-Reply-To: <20220829172654.GA84762@thinkpad> (Manivannan Sadhasivam's
        message of "Mon, 29 Aug 2022 22:56:54 +0530")
Message-ID: <87fshefgkj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manivannan Sadhasivam <mani@kernel.org> writes:

> On Mon, Aug 29, 2022 at 07:20:10PM +0300, Kalle Valo wrote:
>> Manivannan Sadhasivam <mani@kernel.org> writes:
>> 
>> > On Tue, Jul 26, 2022 at 08:53:58PM +0300, Kalle Valo wrote:
>> >> Manivannan Sadhasivam <mani@kernel.org> writes:
>> >> 
>> >> > +ath11k, Kalle
>> >> >
>> >> > On Fri, Jul 22, 2022 at 11:17:18AM +0800, Qiang Yu wrote:
>> >> >> The irq handler for a shared IRQ ought to be prepared for running
>> >> >> even now it's being freed. So let's check the pointer used by
>> >> >> mhi_irq_handler to avoid null pointer access since it is probably
>> >> >> released before freeing IRQ.
>> >> >> 
>> >> >> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> >> >
>> >> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>> >> 
>> >> This fixes the crash and my regression tests pass now, thanks. But
>> >> please see my question below.
>> >> 
>> >> Tested-by: Kalle Valo <kvalo@kernel.org>
>> >> 
>> >
>> > Thanks Kalle!
>> 
>> I just tested v6.0-rc3 and it's still crashing. What's the plan to get
>> this fix to Linus?
>
> Sorry for the delay. Just sent the PR to Greg for including it as a fix for
> v6.0.

Excellent, thank you.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
