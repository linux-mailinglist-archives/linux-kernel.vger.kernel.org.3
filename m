Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795CC5803BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbiGYSAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiGYSAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:00:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E839BDE;
        Mon, 25 Jul 2022 11:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66C3F61376;
        Mon, 25 Jul 2022 18:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10D9C341C6;
        Mon, 25 Jul 2022 18:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658772014;
        bh=umOm1cFvLaFJjBTJsRPIlLTUylpQHF2uRLMesgi8PmU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=QVeeA1GKVVlstdAGGCckwZr3lMEVA1s+rUQZ3H4h0WaG+1dw9znU7VG0+B0nKWqLv
         w2nBxCZZ2Ehtyr/3u9wb+G28xcY/wdwgxCWDl0ZenZwU2+llQ6AfkYhNAutiH1+e5a
         dhABj+Zco8xFqSN40GASQ6LNiiPqAet1bW3exNUDzBtLISlzxli9AfgopZhQSIGKEV
         UrXBG8fOUyOZwTg02cpqmpPDG/KaDAkgSSDZciMEwQIXBYWkIKNUGxRnHDeJ2pvi/V
         oCwDaet87QemhqhvJaB2v66p8n5S0YBhSj5WrCIbc0JU3OX0ahwePnlzJ7iasxVO+t
         xLw3DxJZyLCcQ==
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
        <063fe6bf-11b1-1724-058f-0fed7247906e@quicinc.com>
        <20220721101914.GC36189@thinkpad>
Date:   Mon, 25 Jul 2022 21:00:08 +0300
In-Reply-To: <20220721101914.GC36189@thinkpad> (Manivannan Sadhasivam's
        message of "Thu, 21 Jul 2022 15:49:14 +0530")
Message-ID: <87wnc1qdhz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manivannan Sadhasivam <mani@kernel.org> writes:

> On Wed, Jul 20, 2022 at 05:47:37PM +0800, Qiang Yu wrote:
>
>>=20
>> On 7/20/2022 5:39 PM, Manivannan Sadhasivam wrote:
>> > On Mon, Jul 18, 2022 at 02:15:23PM +0300, Kalle Valo wrote:
>> > > + ath11k list
>> > >=20
>> > > Manivannan Sadhasivam <mani@kernel.org> writes:
>> > >=20
>> > > > On Thu, Jun 23, 2022 at 10:43:03AM +0800, Qiang Yu wrote:
>> > > > > During runtime, the MHI endpoint may be powered up/down several =
times.
>> > > > > So instead of allocating and destroying the IRQs all the time, l=
et's just
>> > > > > enable/disable IRQs during power up/down.
>> > > > >=20
>> > > > > The IRQs will be allocated during mhi_register_controller() and =
freed
>> > > > > during mhi_unregister_controller(). This works well for things l=
ike PCI
>> > > > > hotplug also as once the PCI device gets removed, the controller=
 will
>> > > > > get unregistered. And once it comes back, it will get registered=
 back
>> > > > > and even if the IRQ configuration changes (MSI), that will get a=
ccounted.
>> > > > >=20
>> > > > > Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> > > > Applied to mhi-next!
>> > > I did a bisect and this patch breaks ath11k during rmmod. I'm on
>> > > vacation right now so I can't investigate in detail but more info be=
low.
>> > >=20
>> > I just tested linux-next/master next-20220718 on my NUC with QCA6390, =
but I'm
>> > not able to reproduce the issue during rmmod! Instead I couldn't conne=
ct to AP.
>>=20
>> I suspect that in __free_irq(), if CONFIG_DEBUG_SHIRQ is enabled, irq
>> handler for a shared IRQ will be invoked and null pointer access happen.
>>=20
>> #ifdef CONFIG_DEBUG_SHIRQ
>> =C2=A0=C2=A0 =C2=A0/*
>> =C2=A0=C2=A0 =C2=A0 * It's a shared IRQ -- the driver ought to be prepar=
ed for an IRQ
>> =C2=A0=C2=A0 =C2=A0 * event to happen even now it's being freed, so let'=
s make sure that
>> =C2=A0=C2=A0 =C2=A0 * is so by doing an extra call to the handler ....
>> =C2=A0=C2=A0 =C2=A0 *
>> =C2=A0=C2=A0 =C2=A0 * ( We do this after actually deregistering it, to m=
ake sure that a
>> =C2=A0=C2=A0 =C2=A0 *=C2=A0=C2=A0 'real' IRQ doesn't run in parallel wit=
h our fake. )
>> =C2=A0=C2=A0 =C2=A0 */
>> =C2=A0=C2=A0 =C2=A0if (action->flags & IRQF_SHARED) {
>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 local_irq_save(flags);
>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 action->handler(irq, dev_id);
>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 local_irq_restore(flags);
>> =C2=A0=C2=A0 =C2=A0}
>> #endif
>>=20
>
> Ah yes, after enabling CONFIG_DEBUG_SHIRQ I could reproduce the issue.

So how to fix this regression? (If there's already a fix I might have
missed it as I came back only today)

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
