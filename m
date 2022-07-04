Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07724565638
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiGDMzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbiGDMy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:54:57 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4014C13CD2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:54:17 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 264A11Rm009102;
        Mon, 4 Jul 2022 14:53:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=selector1;
 bh=PVb4Y/nz/MVu/ZlYFkjQIxizU3xTIA4qA1VeZ0HrcYM=;
 b=YE5lE7+xzftTo9GGRfkuyS93PX6Tot+2Qjn6vWpttdXVTssyO8ryaEBn0dnMKQAHj3NO
 kg1Ote7e5goQO8zkVDL3/Vqp2NagQtAzA3XSNdXsiISBQ+cUGsXcud/ukAovCeemdAF3
 xRqkFIrHS2p37Iw5OtHewIbevtRhOtRW/MxHfNukTnXhWI7Qt+spSGAX6AGgg8NN+8+O
 phIDYuFl02fS92q+6sLWU2wquBFv2829EDQEvHuSuHoHn+bWK0MGTCwhT7H4WVI8lI25
 HBMGqvo+SnGtDKdLYTso6H6tjbtAQckE+v1L/7taOg3krNqhyOye66VZP+yg8yyksoSi YA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h2ben1mr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 14:53:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 55BC410002A;
        Mon,  4 Jul 2022 14:53:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C984921E68F;
        Mon,  4 Jul 2022 14:53:40 +0200 (CEST)
Received: from [192.168.8.15] (10.75.127.44) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 4 Jul
 2022 14:53:40 +0200
Message-ID: <4a57677268ac356a006ee35f73ceacdf49ae4221.camel@foss.st.com>
Subject: Re: [PATCH] genirq: Don't return error on missing optional
 irq_request_resources()
From:   Antonio Borneo <antonio.borneo@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>
Date:   Mon, 4 Jul 2022 14:53:36 +0200
In-Reply-To: <20220512160544.13561-1-antonio.borneo@foss.st.com>
References: <20220512160544.13561-1-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 
MIME-Version: 1.0
X-Originating-IP: [10.75.127.44]
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

On Thu, 2022-05-12 at 18:05 +0200, Antonio Borneo wrote:
> Function irq_chip::irq_request_resources() is reported as optional
> in the declaration of struct irq_chip.
> If the parent irq_chip does not implement it, we should ignore it
> and return.
>=20
> Don't return error if the functions is missing.
>=20
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> ---
>=20
> As follow-up of discussion in
> https://lore.kernel.org/lkml/875ymd6xdu.wl-maz@kernel.org/
> here is a proposal for changing the returned value.
>=20
> A similar issue is present for the optional function
> irq_set_vcpu_affinity(), to be covered separately, if needed.

Gentle ping for this patch.
Does it match the expected behaviour for an optional function?

Thanks,
Antonio


>=20
> ---
> =C2=A0kernel/irq/chip.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 54af0deb239b..eb921485930f 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -1513,7 +1513,8 @@ int irq_chip_request_resources_parent(struct
> irq_data *data)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (data->chip->irq_reque=
st_resources)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return data->chip->irq_request_resources(data);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOSYS;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* no error on missing optiona=
l
> irq_chip::irq_request_resources */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(irq_chip_request_resources_parent);
> =C2=A0
>=20
> base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a

