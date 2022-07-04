Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B271856563D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiGDM4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiGDM4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:56:52 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ABCD57
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:56:51 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 264AHs5e008697;
        Mon, 4 Jul 2022 14:56:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=selector1;
 bh=/xn9WTxm3J+BhSPtpIQTJNXDo4Fe/OymRKXzxlOXDTA=;
 b=rh+plKvW9YVXlfBodCYoSFhJE7wCWujRZ8eqmBePb13lcaaz5pMgg+AaF2w73XgSRtf+
 t/gC9J95mqtsj71L/mT4j1WMpIBIOYLlyV93iS5NyXTxB7OUmpKy5jyPhuAdRzaHSyiF
 mw36Yys+IxnYRcXsRrsRMHPOmOJNT4a84MLIqFe1BoVi1KKmQ5b+WSDA7emJTigvmU9v
 zcHsUok2y6FxGB72HcSvtd3cf2xA+Xk3RFATy83SWzImuf48KrPjMlm/kTCap3oyQVXc
 HCrodpAQQFMqTyV4U4qQSH0q9P/g7pvftr+yWMH4FTt9esQ+iAiw8X/dDerMfwFAhQqN 9Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h2ben1n6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 14:56:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9913910002A;
        Mon,  4 Jul 2022 14:56:33 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9401C21E691;
        Mon,  4 Jul 2022 14:56:33 +0200 (CEST)
Received: from [192.168.8.15] (10.75.127.48) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 4 Jul
 2022 14:56:32 +0200
Message-ID: <d42a1360b522585dfa214c3152da4aa018bd6013.camel@foss.st.com>
Subject: Re: [PATCH v2 0/6] irqchip/stm32-exti: Fixes and simplifications
From:   Antonio Borneo <antonio.borneo@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC:     Ludovic Barre <ludovic.barre@foss.st.com>,
        Loic Pallardy <loic.pallardy@foss.st.com>,
        Pascal Paillet <p.paillet@foss.st.com>
Date:   Mon, 4 Jul 2022 14:56:29 +0200
In-Reply-To: <20220606162757.415354-1-antonio.borneo@foss.st.com>
References: <20220510164123.557921-1-antonio.borneo@foss.st.com>
         <20220606162757.415354-1-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 
MIME-Version: 1.0
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_11,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-06 at 18:27 +0200, Antonio Borneo wrote:
> This series address some code fix for irq-stm32-exti driver and
> simplifies the table that remaps the interrupts from exti to gic.
>=20

Gentle ping for this series.
If there is anything I can do to let this series proceed, please let me
know.

Thanks,
Antonio

> v1->v2
> =C2=A0- Properly format the commit title and expand the commit msg;
> =C2=A0- drop the patch v1 4/7:
> =C2=A0=C2=A0 "irqchip/stm32-exti: forward irq_request_resources to parent=
"
> =C2=A0=C2=A0 in favor of the generic:
> =C2=A0=C2=A0
> https://lore.kernel.org/lkml/20220512160544.13561-1-antonio.borneo@foss.s=
t.com/
> =C2=A0=C2=A0 "genirq: Don't return error on missing optional
> =C2=A0=C2=A0 irq_request_resources()";
> =C2=A0- use consistently UNDEF_REG for non existing EMR registers;
> =C2=A0- rebase on v5.19-rc1.
>=20
>=20
> Alexandre Torgue (1):
> =C2=A0 irqchip/stm32-exti: Tag emr register as undefined for stm32mp15
>=20
> Antonio Borneo (3):
> =C2=A0 irqchip/stm32-exti: Prevent illegal read due to unbounded DT value
> =C2=A0 irqchip/stm32-exti: Read event trigger type from event_trg registe=
r
> =C2=A0 irqchip/stm32-exti: Simplify irq description table
>=20
> Loic Pallardy (1):
> =C2=A0 irqchip/stm32-exti: Fix irq_mask/irq_unmask for direct events
>=20
> Ludovic Barre (1):
> =C2=A0 irqchip/stm32-exti: Fix irq_set_affinity return value
>=20
> =C2=A0drivers/irqchip/irq-stm32-exti.c | 250 +++++++++++++++-------------=
-
> --
> =C2=A01 file changed, 124 insertions(+), 126 deletions(-)
>=20
>=20
> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56

