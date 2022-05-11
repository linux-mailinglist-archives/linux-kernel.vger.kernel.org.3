Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7845522C8D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242304AbiEKGqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiEKGqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:46:19 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE5E2EA39
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:46:16 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B4hxSG021004;
        Wed, 11 May 2022 08:45:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : subject
 : from : to : cc : in-reply-to : references : content-type :
 content-transfer-encoding : date : mime-version; s=selector1;
 bh=9YYnwNfMMp9aQpgH4lmO552ifYtlfvbBnjgFiJluffU=;
 b=cxDlvgTRxykxPoFoXt2jquDUKz3zJrNbAYkJFegkgL+zwXF6sA51FRSnYjQt5AWGA0/n
 pDopkqerMw3z2hAComH3g8i8Ql56TSj7ukGM7lNvGwAvZXEgt/2WB9Fy1f0hGWV2jf07
 yyWV4MSssrmhKrjjb21j4RiVf0sDpsn69upFZM4hueqoxQhZ1hnXWjhhi+x8WI3llclo
 s9IorcdMgaQZxSUYtUt9ttw8RuOfS9qjWM1mzMHFltnM36ZaepZriFtuZD+Z5+nJ+AAm
 KvkguFN0TUL+D1jwMPWqcl03189Z4HXcgamzKodZ61wy3J4B6NhyCGEkMWStDcjOzCfi Tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fwe6kw5ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 08:45:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 30F2410002A;
        Wed, 11 May 2022 08:45:56 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 277A020FA2D;
        Wed, 11 May 2022 08:45:56 +0200 (CEST)
Received: from [192.168.8.15] (10.75.127.45) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 11 May
 2022 08:45:54 +0200
Message-ID: <05d9a88de4a7c415545043fab1e577e7f6151b8c.camel@foss.st.com>
Subject: Re: [PATCH 1/7] irqchip/stm32-exti: set_affinity return
 IRQ_SET_MASK_OK_DONE if no parent
From:   Antonio Borneo <antonio.borneo@foss.st.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Loic Pallardy <loic.pallardy@foss.st.com>,
        Pascal Paillet <p.paillet@foss.st.com>
In-Reply-To: <878rr96xuo.wl-maz@kernel.org>
References: <20220510164123.557921-1-antonio.borneo@foss.st.com>
         <878rr96xuo.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 11 May 2022 08:39:43 +0200
MIME-Version: 1.0
User-Agent: Evolution 3.44.1 
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_02,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Tue, 2022-05-10 at 19:34 +0100, Marc Zyngier wrote:
> Antonio,
>=20
> On Tue, 10 May 2022 17:41:17 +0100,
> Antonio Borneo <antonio.borneo@foss.st.com> wrote:
> >=20
> > From: Ludovic Barre <ludovic.barre@foss.st.com>
> >=20
> > If no parent, there is no specific action to do in
> > stm32 irqchip, and so return IRQ_SET_MASK_OK_DONE.
> >=20
> > Signed-off-by: Ludovic Barre <ludovic.barre@foss.st.com>
> > Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> > ---
> > =C2=A0drivers/irqchip/irq-stm32-exti.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/irqchip/irq-stm32-exti.c
> > b/drivers/irqchip/irq-stm32-exti.c
> > index 9d18f47040eb..10c9c742c216 100644
> > --- a/drivers/irqchip/irq-stm32-exti.c
> > +++ b/drivers/irqchip/irq-stm32-exti.c
> > @@ -614,7 +614,7 @@ static int stm32_exti_h_set_affinity(struct
> > irq_data *d,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (d->parent_data->chi=
p)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return irq_chip_set_affinity_parent(d, dest,
> > force);
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return IRQ_SET_MASK_OK_DONE;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int __maybe_unused stm32_exti_h_suspend(void)
>=20
> <rant>
> Can you *please* use a cover-letter when sending more that a single
> patch? I expect there is an overarching motive to this series. Where
> is it described?
>=20
> Also, please look at the way the subject lines are written for most
> irqchip patches:
>=20
> irqchip/foo: Frobify the bar callback return value
>=20
> Note the capital letter after the ':', and the fact that it starts
> with a verb. Here, I would have liked to see:
>=20
> irqchip/stm32-exti: Fix set_affinity() return value
>=20
> and leave the meat of the description to the commit log (instead of
> saying the exact same thing twice).
> </rant>

thanks for your review and the hints on this series.
I will shortly send a V2.

Regards,
Antonio


