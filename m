Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637935803B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 19:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiGYR5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 13:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiGYR5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 13:57:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229601C90F;
        Mon, 25 Jul 2022 10:57:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86E84B810A4;
        Mon, 25 Jul 2022 17:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F17DC341C6;
        Mon, 25 Jul 2022 17:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658771827;
        bh=cv8NQiE83GOv/DB+wSK/QtVSNmHqEKCAHuhQNzhIfxM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RN3bNnf1qcACvLhVz3+mrnnm2wSCxhgepF5qQDBMARV1dju+rFw81BgPS0Yl/VIBX
         fshMJU1Vh88fcTMJBbzmh1Ud1+tJhMPK/CKq9Ainvt5DdoSyC0HoNkpOuUf6BM8A+V
         0MuHcJuWokEUpi2ho2CDm5QuE+xVLx9qHpplB8vqSdCZ04E3EpbhXQf1klsZm5bjkl
         ZbQOvXHIbLxNo03s34bUTcVR/zNrpI7FPFsd7W07Wk1JF7b61PpD1UU8pEmuDupaR1
         R5jmscp6n3a2gu+s6n+jHcVbFCkDhGMY5oL2rqFPqLjHIW8RiaEaQZB+p91qjtsxvN
         4Uop5zyiUAi3Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Qiang Yu <quic_qianyu@quicinc.com>, quic_hemantk@quicinc.com,
        loic.poulain@linaro.org, quic_jhugo@quicinc.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ath11k@lists.infradead.org
Subject: Re: [PATCH v4 1/1] bus: mhi: host: Move IRQ allocation to controller registration phase
References: <1655952183-66792-1-git-send-email-quic_qianyu@quicinc.com>
        <20220624072740.GA12171@thinkpad> <87k08an038.fsf@kernel.org>
        <20220720093909.GA5747@thinkpad>
Date:   Mon, 25 Jul 2022 20:57:00 +0300
In-Reply-To: <20220720093909.GA5747@thinkpad> (Manivannan Sadhasivam's message
        of "Wed, 20 Jul 2022 15:09:09 +0530")
Message-ID: <871qu9rs7n.fsf@kernel.org>
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

> On Mon, Jul 18, 2022 at 02:15:23PM +0300, Kalle Valo wrote:
>
>> + ath11k list
>> 
>> Manivannan Sadhasivam <mani@kernel.org> writes:
>> 
>> > On Thu, Jun 23, 2022 at 10:43:03AM +0800, Qiang Yu wrote:
>> >> During runtime, the MHI endpoint may be powered up/down several times.
>> >> So instead of allocating and destroying the IRQs all the time, let's just
>> >> enable/disable IRQs during power up/down.
>> >> 
>> >> The IRQs will be allocated during mhi_register_controller() and freed
>> >> during mhi_unregister_controller(). This works well for things like PCI
>> >> hotplug also as once the PCI device gets removed, the controller will
>> >> get unregistered. And once it comes back, it will get registered back
>> >> and even if the IRQ configuration changes (MSI), that will get accounted.
>> >> 
>> >> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> >
>> > Applied to mhi-next!
>> 
>> I did a bisect and this patch breaks ath11k during rmmod. I'm on
>> vacation right now so I can't investigate in detail but more info below.
>> 
>
> I just tested linux-next/master next-20220718 on my NUC with QCA6390, but I'm
> not able to reproduce the issue during rmmod! Instead I couldn't connect to AP.
>
> log: https://paste.debian.net/1247788/

I get "Entry not found" for that link. But yeah, there were several
regressions in ath11k while I was away. I except that the could not
connect to AP bug should be fixed now in wireless-next and linux-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
