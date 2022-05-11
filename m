Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14D052364D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245235AbiEKOz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245231AbiEKOzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:55:25 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965A2200F4F
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:55:23 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BAW1Ju018362;
        Wed, 11 May 2022 16:55:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=selector1;
 bh=+YPIl1+HECBCIFGnFWdVUt+GpcgGMMtibG+mpoeQNc0=;
 b=bSLmsDXRbL88WEdwp57DO3MAA2xNUkKwZ+ReLtxsGg+2rbFq1qzUNkr8szuo0K4kViJW
 H/oJhgbuzjj+Xb/KP+xIVj2b6+/cLkbCT+r963uBsYYRCSrBkTE0XRm9MXCSamf9DNml
 Mt4Xh4okVW683qpN28yWgXXfyYA1AeHzCVuDBMRcHPHZ5bGE/2qm+hj6DTfA5Az+vQeg
 cwqPvh3y/6LemoJL7tYpiZ3nx6ZbtXF0n7px/qwRD0yMv5NftcLlJF5Vx+o8E0imhhq9
 6/HZSH3jktQ1++ft31T4FcrDO4WRbBP6STXf/draglsWSkR0q2efXNUtineHg3frTNM3 yA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fwdw9bawu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 16:55:08 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7D80F10002A;
        Wed, 11 May 2022 16:55:07 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 763F7229A9A;
        Wed, 11 May 2022 16:55:07 +0200 (CEST)
Received: from [192.168.8.15] (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 11 May
 2022 16:55:04 +0200
Message-ID: <87d059e62a54e2216acdf4ca3a6a81b8d771af42.camel@foss.st.com>
Subject: Re: [PATCH 4/7] irqchip/stm32-exti: forward irq_request_resources
 to parent
From:   Antonio Borneo <antonio.borneo@foss.st.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Pascal Paillet <p.paillet@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        "Loic Pallardy" <loic.pallardy@foss.st.com>
Date:   Wed, 11 May 2022 16:55:03 +0200
In-Reply-To: <875ymd6xdu.wl-maz@kernel.org>
References: <20220510164123.557921-1-antonio.borneo@foss.st.com>
         <20220510164123.557921-4-antonio.borneo@foss.st.com>
         <875ymd6xdu.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-10 at 19:44 +0100, Marc Zyngier wrote:
> On Tue, 10 May 2022 17:41:20 +0100,
> Antonio Borneo <antonio.borneo@foss.st.com> wrote:
> >=20
> > From: Pascal Paillet <p.paillet@foss.st.com>
> >=20
> > Enhance stm32-exti driver to forward request_resources and
> > release_resources_parent operations to parent.
> > Do not use irq_request_resources_parent because it returns
> > an error when the parent does not implement irq_request_resources.
> >=20
> > Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
> > Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> > ---
> > =C2=A0drivers/irqchip/irq-stm32-exti.c | 14 ++++++++++++++
> > =C2=A01 file changed, 14 insertions(+)
> >=20
> > diff --git a/drivers/irqchip/irq-stm32-exti.c
> > b/drivers/irqchip/irq-stm32-exti.c
> > index c8003f4f0457..3f6d524a87fe 100644
> > --- a/drivers/irqchip/irq-stm32-exti.c
> > +++ b/drivers/irqchip/irq-stm32-exti.c
> > @@ -550,6 +550,16 @@ static void stm32_exti_h_unmask(struct
> > irq_data *d)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0irq_chip_unmask_parent(d);
> > =C2=A0}
> > =C2=A0
> > +static int stm32_exti_h_request_resources(struct irq_data *data)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data =3D data->parent_data;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (data->chip->irq_request_=
resources)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return data->chip->irq_request_resources(data);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > +}
>=20
> Why do you need to reinvent the whole thing? Why isn't it just:
>=20
> static int stm32_exti_h_request_resources(struct irq_data *data)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq_chip_request_resource=
s_parent(data);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> }
>=20
> And this really deserves a comment. I also wonder whether we should
> change this behaviour to always return 0.

Marc,
the stm32-exti sits in the middle of an irq hierarchy, exactly as the
"Interrupt remapping controller" in the section "Hierarchy IRQ domain"
in Documentation/core-api/irq/irq-domain.rst

When the "IOAPIC controller" runs a request_*_irq(), it causes calling
irq_request_resources() of its parent, if the parent implements it.
There is no automatic propagation in the hierarchy, so it's up to each
irq_chip in the hierarchy to propagate this call to its parent.
Using irq_chip_request_resources_parent() fits this use case.

At the end of the chain, the "Local APIC controller" is not obliged to
implement the 'optional' irq_request_resources(). And here starts the
pain:
irq_chip_request_resources_parent() returns -ENOSYS if the parent does
not implement the optional irq_request_resources().
So we need to filter-out the error for unimplemented function, e.g.:

static int stm32_exti_h_request_resources(struct irq_data *data)
{
	int ret;
	ret =3D irq_chip_request_resources_parent(data);
	/* not an error if parent does not implement it */
	return (ret =3D=3D -ENOSYS) ? 0 : ret;
}

but then we cannot discriminate if -ENOSYS comes from missing optional
irq_request_resources() in parent, or from an error inside parent's
irq_request_resources(). That's why this patch reimplements the wheel.

Shuldn't irq_chip_request_resources_parent() return 0 when the parent
doesn't implements the optional method, as it's already the case inside
kernel/irq/manage.c:1390 static int irq_request_resources(struct
irq_desc *desc)
?

Regards,
Antonio
