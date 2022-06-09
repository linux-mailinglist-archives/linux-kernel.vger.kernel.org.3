Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC70544874
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238486AbiFIKOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbiFIKO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:14:29 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E6C1D4222;
        Thu,  9 Jun 2022 03:14:27 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0C93E3200928;
        Thu,  9 Jun 2022 06:14:23 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Thu, 09 Jun 2022 06:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1654769663; x=
        1654856063; bh=3JVSv/3Y7cnWYb5H6IILBv0JoYAgHd/+In59ua4cJ3s=; b=f
        i34A/lL5DHAJJYwp9WyhPqRjMKGy8n3IZmtblbDb+HRWkJqq9ufQjGYBBlACJlkl
        kt6yq3iwVwyq3huipPCGq6zLtpHlf6kYV7JpSEm78VNkjZGyNZcHtdV595aL7Xax
        2MeBYIghSX3tihY4xSh+H15c2I/6mNYrsg498W3aeXfjCrkBOtVfPG37c3dehQis
        tttMzELkN1B4YiJeeFECgOi8EN6+6pWycsY1sQtOnuy2hFkQUbzYat5QACqHHToW
        YpN0cQvwyF4s98EK4Gs8WSr8u0d5c3mBFUYNK701ZuNIaziZ1XKXewZONRVAcFwk
        YyGTLmHxBC90E5otn2wVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1654769663; x=
        1654856063; bh=3JVSv/3Y7cnWYb5H6IILBv0JoYAgHd/+In59ua4cJ3s=; b=g
        U9HeZSPaG/kJSXMkjeZz5mTYDxcpFpKx3MTpO7IFhisD2WCiiNNEW/wujpNwku1h
        icNHzTivY/EZyJhzT1xm3OgV4x+pTccD9xBZAAWY7HDfIAnHtL2S+oLsPGWAkp+S
        LV1x6fkemfbuLjWbwOsL43accRIb8ibrl/911rQgx3gxJhKuEqGu8nWyAiRwDL+1
        iZCNjBQgDRfYtDmjnIbBO32iWwK87O39lW2pYjP2eq4zIkbeTilcMvJKqWw7a5Da
        wwmvY5Kc4J03Djm/Z2kl6KKX9KIflIdj6BTEgjlNZMZ7L+vjukB7RfGSJOvjVHQS
        0GichANqdlDRshx0Qh+XA==
X-ME-Sender: <xms:_sehYpUBAr972p3QKgi5Juqfn1MMR8N2QBWpH__Ipxry44vpTJl8aw>
    <xme:_sehYpmmmBQbr4m26qyJqJntBfoNAnqj2WjrM_r9uXXunjDKmdFYtXTS_wFKiPr4E
    QcHgjS2FhnqL74Zuzc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddtledgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:_sehYla9GCXZp6WHUfXLJuFjBcTTZkk-NqaufXbA3fHmsnlQ1xdWaA>
    <xmx:_sehYsVNz2kY9_0NAnBDoFmpxajSed0up5aJ4eyMoXlSqm7roujwLA>
    <xmx:_sehYjnfAhEJRVoF8l4CBU1U-F-NHqxn8T4k6CxF4_2Y7KlKeXraPQ>
    <xmx:_8ehYtnzhFXDONtB-X5wvgVV0QYWv-oqk9326LYzk5dwB1wwdnJseg>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6B89A36A006D; Thu,  9 Jun 2022 06:14:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-692-gb287c361f5-fm-20220603.003-gb287c361
Mime-Version: 1.0
Message-Id: <692f7fc0-4953-408a-93fd-b1fe9b87663c@www.fastmail.com>
In-Reply-To: <87pmjjzo3k.wl-maz@kernel.org>
References: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
 <20220525121030.16054-7-Dragan.Mladjenovic@syrmia.com>
 <87wndu3tff.wl-maz@kernel.org>
 <0a5dd632-0607-dab6-4de7-1ea248490863@flygoat.com>
 <87pmjjzo3k.wl-maz@kernel.org>
Date:   Thu, 09 Jun 2022 11:14:01 +0100
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Marc Zyngier" <maz@kernel.org>
Cc:     "Dragan Mladjenovic" <Dragan.Mladjenovic@syrmia.com>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Chao-ying Fu" <cfu@wavecomp.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Greg Ungerer" <gerg@kernel.org>,
        "Hauke Mehrtens" <hauke@hauke-m.de>,
        "Ilya Lipnitskiy" <ilya.lipnitskiy@gmail.com>,
        linux-kernel@vger.kernel.org,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Serge Semin" <fancer.lancer@gmail.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Tiezhu Yang" <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v2 06/12] irqchip: mips-gic: Multi-cluster support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82022=E5=B9=B46=E6=9C=888=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=887:05=EF=BC=8CMarc Zyngier=E5=86=99=E9=81=93=EF=BC=9A
> On Tue, 07 Jun 2022 19:23:02 +0100,
> Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>>=20
>>=20
>>=20
>> =E5=9C=A8 2022/6/6 12:47, Marc Zyngier =E5=86=99=E9=81=93:
>> > On Wed, 25 May 2022 13:10:24 +0100,
>> > Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com> wrote:
>> >> From: Paul Burton <paulburton@kernel.org>
>> >>=20
>> >> The MIPS I6500 CPU & CM (Coherence Manager) 3.5 introduce the conc=
ept of
>> >> multiple clusters to the system. In these systems each cluster con=
tains
>> >> its own GIC, so the GIC isn't truly global any longer. We do have =
the
>> >> ability to access registers in the GICs of remote clusters using a
>> >> redirect register block much like the redirect register blocks pro=
vided
>> >> by the CM & CPC, and configured through the same GCR_REDIRECT regi=
ster
>> >> that we our mips_cm_lock_other() abstraction builds upon.
>> >>=20
>> >> It is expected that external interrupts are connected identically =
to all
>> >> clusters. That is, if we have a device providing an interrupt conn=
ected
>> >> to GIC interrupt pin 0 then it should be connected to pin 0 of eve=
ry GIC
>> >> in the system. This simplifies things somewhat by allowing us for =
the
>> >> most part to treat the GIC as though it is still truly global, so =
long
>> >> as we take care to configure interrupts in the cluster that we wan=
t them
>> >> affine to.
>> > I can see how this can work for level interrupts, but how does this
>> > work for edge interrupts? Is there any guarantee that the interrupt
>> > will be discarded if routed to a cluster where it isn't configured?
>> It is supposed to mask the interrupt out on the GIC which belongs to =
the
>> cluster that the interrupt is not routed to.
>>=20
>> When it's masked out GIC simply won't sense any level change.
>>=20
>> I guess it's sort of guarantee?
>
> Pretty much the opposite. There is a *strong* requirement that a
> masked interrupt can still detect interrupts, so that on unmask the
> interrupt fires (you'd otherwise lose edge interrupts pretty often).
Oops, sorry there is a terminology issue. On MIPS Coherent Manager
manual it uses terminology of =E2=80=9CMasked=E2=80=9D when vector regis=
ter of
a interrupt is cleared.

It means implementation will guarantee interrupt will be dropped
when it=E2=80=99s routed to nowhere.

>
> What does the MIPS GIC arch spec says about this?
Unfortunately GIC is not a arch spec. It=E2=80=99s just a implementation=
 spec
of MIPS Coherent Manager.

Thanks.
- Jiaxun

>
> Thanks,
>
> 	M.
>
> --=20
> Without deviation from the norm, progress is not possible.

--=20
- Jiaxun
