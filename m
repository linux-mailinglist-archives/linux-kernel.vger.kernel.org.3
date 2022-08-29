Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15815A517E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiH2QUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiH2QUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1500E140BD;
        Mon, 29 Aug 2022 09:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11A4061225;
        Mon, 29 Aug 2022 16:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D25C433D6;
        Mon, 29 Aug 2022 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661790018;
        bh=rKldEn8GDoqan884Kl27KYDre5RSBwf1soWE1GqIuUI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Jo27ES0wd1AvWThEa0nNWsF4/0g4E7h6fUZmtGF6fpqKxWQaGM2/7aSaVKcq9vxdz
         75czUSVooDbVphf884bV11kfN5fPZPvAABfAlW+VFs8USi8AKPQe/brfzmnE7VN68u
         qhuXnZbyhTKBgKL6ycWq4C7TKJy/ow/hplrFpoxrCBfTHkLX+1JBVzA71cwM3AHn9P
         l449PrywaV5w/dgku2ObN6ZObfjcAywk7e+8HtteRg64LoBVhLyyXyMO7g5fORlPf1
         m3JErPnp7uWjth4CxV5kg4QvVma2BsLqYIq5WrNDf2VjFKsPYpgkE7d0f/pr+fx/MI
         4t1WqSnGXFa2Q==
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
        <20220729142221.GA9937@thinkpad>
Date:   Mon, 29 Aug 2022 19:20:10 +0300
In-Reply-To: <20220729142221.GA9937@thinkpad> (Manivannan Sadhasivam's message
        of "Fri, 29 Jul 2022 19:52:21 +0530")
Message-ID: <87h71vc98l.fsf@kernel.org>
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

> On Tue, Jul 26, 2022 at 08:53:58PM +0300, Kalle Valo wrote:
>> Manivannan Sadhasivam <mani@kernel.org> writes:
>> 
>> > +ath11k, Kalle
>> >
>> > On Fri, Jul 22, 2022 at 11:17:18AM +0800, Qiang Yu wrote:
>> >> The irq handler for a shared IRQ ought to be prepared for running
>> >> even now it's being freed. So let's check the pointer used by
>> >> mhi_irq_handler to avoid null pointer access since it is probably
>> >> released before freeing IRQ.
>> >> 
>> >> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> >
>> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>> 
>> This fixes the crash and my regression tests pass now, thanks. But
>> please see my question below.
>> 
>> Tested-by: Kalle Valo <kvalo@kernel.org>
>> 
>
> Thanks Kalle!

I just tested v6.0-rc3 and it's still crashing. What's the plan to get
this fix to Linus?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
