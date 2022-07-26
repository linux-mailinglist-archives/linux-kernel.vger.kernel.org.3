Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FA05818D3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239531AbiGZRsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbiGZRsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:48:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C584212A9F;
        Tue, 26 Jul 2022 10:48:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6091661160;
        Tue, 26 Jul 2022 17:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B45C433D6;
        Tue, 26 Jul 2022 17:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658857691;
        bh=jBQWWYLAlwhQocmCejiAludOWzxiwJJG/jaLDBo9abU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JaLKe/taM87sXwV5wgYLDJmRHMRotMw71eAuOWV5JPQFtC9dbG8P98j0vQaf7tELA
         UhiiM6Qsjg7oz2zdNzGn4Wvr91JKJ9f4F99MdtQlwXdArtoBlxHf2/94oNO5nUSp7I
         9413FCmNn8X5AKozZJWEGdfel/SDI/yZqdsNF3/sgLteCKjlEcXe1CSoetGZATQc+Q
         ph06HgBlXIGdUVYUtP5BgQNbIfwSadrIAr0CDC4mkd2C2Mb8pKqqfVIB8TQkA1+xnz
         S4QIkjDTMmgXPo2J7uThrqx3Y4fJgYm7QbPEH9D0dLeNdhTQ220KSPebSpSpt1mSuE
         KbgK2TGJNgxUA==
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
        <20220721101914.GC36189@thinkpad> <87wnc1qdhz.fsf@kernel.org>
        <20220726080913.GF5522@workstation>
Date:   Tue, 26 Jul 2022 20:48:05 +0300
In-Reply-To: <20220726080913.GF5522@workstation> (Manivannan Sadhasivam's
        message of "Tue, 26 Jul 2022 13:39:13 +0530")
Message-ID: <87h733rciy.fsf@kernel.org>
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

> On Mon, Jul 25, 2022 at 09:00:08PM +0300, Kalle Valo wrote:
>
>> Manivannan Sadhasivam <mani@kernel.org> writes:
>>=20
>> > On Wed, Jul 20, 2022 at 05:47:37PM +0800, Qiang Yu wrote:
>> >
>> >>=20
>> >> On 7/20/2022 5:39 PM, Manivannan Sadhasivam wrote:
>> >> > On Mon, Jul 18, 2022 at 02:15:23PM +0300, Kalle Valo wrote:
>> >> > > + ath11k list
>> >> > >=20
>> >> > > Manivannan Sadhasivam <mani@kernel.org> writes:
>> >> > >=20
>> >> > > > On Thu, Jun 23, 2022 at 10:43:03AM +0800, Qiang Yu wrote:
>> >> > > > > During runtime, the MHI endpoint may be powered up/down sever=
al times.
>> >> > > > > So instead of allocating and destroying the IRQs all the time=
, let's just
>> >> > > > > enable/disable IRQs during power up/down.
>> >> > > > >=20
>> >> > > > > The IRQs will be allocated during mhi_register_controller() a=
nd freed
>> >> > > > > during mhi_unregister_controller(). This works well for thing=
s like PCI
>> >> > > > > hotplug also as once the PCI device gets removed, the control=
ler will
>> >> > > > > get unregistered. And once it comes back, it will get registe=
red back
>> >> > > > > and even if the IRQ configuration changes (MSI), that will ge=
t accounted.
>> >> > > > >=20
>> >> > > > > Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> >> > > > Applied to mhi-next!
>> >> > > I did a bisect and this patch breaks ath11k during rmmod. I'm on
>> >> > > vacation right now so I can't investigate in detail but more info=
 below.
>> >> > >=20
>> >> > I just tested linux-next/master next-20220718 on my NUC with QCA639=
0, but I'm
>> >> > not able to reproduce the issue during rmmod! Instead I couldn't co=
nnect to AP.
>> >>=20
>> >> I suspect that in __free_irq(), if CONFIG_DEBUG_SHIRQ is enabled, irq
>> >> handler for a shared IRQ will be invoked and null pointer access happ=
en.
>> >>=20
>> >> #ifdef CONFIG_DEBUG_SHIRQ
>> >> =C2=A0=C2=A0 =C2=A0/*
>> >> =C2=A0=C2=A0 =C2=A0 * It's a shared IRQ -- the driver ought to be pre=
pared for an IRQ
>> >> =C2=A0=C2=A0 =C2=A0 * event to happen even now it's being freed, so l=
et's make sure that
>> >> =C2=A0=C2=A0 =C2=A0 * is so by doing an extra call to the handler ....
>> >> =C2=A0=C2=A0 =C2=A0 *
>> >> =C2=A0=C2=A0 =C2=A0 * ( We do this after actually deregistering it, t=
o make sure that a
>> >> =C2=A0=C2=A0 =C2=A0 *=C2=A0=C2=A0 'real' IRQ doesn't run in parallel =
with our fake. )
>> >> =C2=A0=C2=A0 =C2=A0 */
>> >> =C2=A0=C2=A0 =C2=A0if (action->flags & IRQF_SHARED) {
>> >> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 local_irq_save(flags);
>> >> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 action->handler(irq, dev_id);
>> >> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 local_irq_restore(flags);
>> >> =C2=A0=C2=A0 =C2=A0}
>> >> #endif
>> >>=20
>> >
>> > Ah yes, after enabling CONFIG_DEBUG_SHIRQ I could reproduce the issue.
>>=20
>> So how to fix this regression? (If there's already a fix I might have
>> missed it as I came back only today)
>>=20
>
> Copied you on the fix patch. Please test and let us know!

Thanks, testing it right now. Will let you know the result as a reply to
the patch.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
