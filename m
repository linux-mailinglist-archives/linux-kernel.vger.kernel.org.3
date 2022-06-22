Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CAA554239
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 07:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbiFVFYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 01:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356084AbiFVFYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 01:24:09 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7882836165
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 22:24:06 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w9so8934815lji.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 22:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SwIledSLJN1+QLOSPItKlxyEAsKWtgQUbp5m5Fbo6uQ=;
        b=yi0OysNlyMSg6TwiZPAbEDxUKmeua7drte42/DUfPgwAoszXJowcaVaHuZgGZcUUIh
         IMTpOJi1r+8ofYsCqnGziazSOoySDDXGQHXWC3MXXMLD4Qxoc9MIsEf97SXpBqY5coXz
         WSBVTzpthRCJu6g/eUTFa8zcxFQyDb/7oyTdelKmL64E4cBypu/KW3RIlvmetc9qiANI
         fQVwVme1pwz5J+JlZzXyc8cljwBMqgPY0oHG3Sk1bU21okCSqWS0OYrxgTT3qvfKDOb6
         pXpaUhMrRmRtd6Z332mM6IRRvKDn+ZrRGuNKfYByuJnZyTehGGGKOmi60/haFUKAp7ii
         8Juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SwIledSLJN1+QLOSPItKlxyEAsKWtgQUbp5m5Fbo6uQ=;
        b=Quyrfk1TSqHzxjrXKpJhwlmmOudglEmUwqoZsO3dO6VESCIq6rcRch1iTA9k6RHE0l
         71Y6kpu1bJCsV14q/Vl7cCUzchrl6y0Wfaq/f2zJxWYsbpFt+srXCcZURGz2nK8Yb3p4
         /HwwYcpPsuZ/M0tbTjLZ4XnrbhuRExp8uRpS6qm9KcCvOhbBC/6WhYTgPXcWdbH3T7Xa
         JqwzjiKxIXikftEpWyXACDgJVKPR01gOvKJL/xflfI2skR1Ru30WvqhsUf1sCQnCFurr
         oJiozt8KYf/GVtybYugj7BDrQEg1Hubb4uA69FUW9l3TEEniF0Hmmd4YidBfB11v77FU
         rQKw==
X-Gm-Message-State: AJIora/qKf6GknCnuy1umYBov+/HnE28hz9mShket9Ypn8BloCiKRu3t
        cHGPs3goWy60JCrR/4xQ2vTXK/+raVK3CveuNhv+3A==
X-Google-Smtp-Source: AGRyM1uZ+3lCpiAbKhVLDcGNPyhqSK6wLdiFg4xJOrqa0vUy4IGMre35HEc0/mj2H1l2hL9a1hHOcyRO3vwE80eIvFs=
X-Received: by 2002:a2e:8881:0:b0:255:7790:25e6 with SMTP id
 k1-20020a2e8881000000b00255779025e6mr835126lji.525.1655875444760; Tue, 21 Jun
 2022 22:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220622040924.113279-1-mie@igel.co.jp> <4bc63a00-a220-e9b8-49ff-8c2d783b55f5@ti.com>
In-Reply-To: <4bc63a00-a220-e9b8-49ff-8c2d783b55f5@ti.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Wed, 22 Jun 2022 14:23:51 +0900
Message-ID: <CANXvt5oNDFmU=YtdAFtd3uB9Un0dxCqbD+0VtMRd3Aj1qOc3Wg@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: Don't stop EP controller by EP function
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Li Chen <lchen@ambarella.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

Thank you for your ack.

2022=E5=B9=B46=E6=9C=8822=E6=97=A5(=E6=B0=B4) 14:10 Kishon Vijay Abraham I =
<kishon@ti.com>:
>
>
>
> On 22/06/22 09:39, Shunsuke Mie wrote:
> > For multi-function endpoint device, an ep function shouldn't stop EP
> > controller. Nomally the controller is stopped via configfs.
>
> %s/Nomally/Normally/
Oops, sorry. Should I resend this patch with fixing the typo?

> > Fixes: 349e7a85b25f ("PCI: endpoint: functions: Add an EP function to t=
est PCI")
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>
> Thank you for the fix!
>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pc=
i/endpoint/functions/pci-epf-test.c
> > index 5b833f00e980..a5ed779b0a51 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -627,7 +627,6 @@ static void pci_epf_test_unbind(struct pci_epf *epf=
)
> >
> >       cancel_delayed_work(&epf_test->cmd_handler);
> >       pci_epf_test_clean_dma_chan(epf_test);
> > -     pci_epc_stop(epc);
> >       for (bar =3D 0; bar < PCI_STD_NUM_BARS; bar++) {
> >               epf_bar =3D &epf->bar[bar];
> >

Thanks.
Shunsuke Mie
