Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AAD4D3719
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbiCIRhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiCIRhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:37:19 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B2311AA31;
        Wed,  9 Mar 2022 09:36:19 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y12so3811766edt.9;
        Wed, 09 Mar 2022 09:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=52VpJb2poMyndYoO2/jzkA3a3xPKo3Oi9H/A1xeVuO0=;
        b=TzRDrHx0bCpzyY4SIOL0NQt4/QkBXUrwIuDlDLygNTTiaTtxGgogp7qpVspxQjjnLR
         rcSC7oThzVvrWiq5pvKJ7KXCjI6lQH5Dr/mLR2FMamgCy2Nnz7hbQOVElSBPeyAes8qf
         GCja8fW2gXSOkKSH7cvCML7g390y7T3O8/0GEDCtFUrWJTRgB0ibf7GYtmxjxsIdLlrk
         jFos50KvjIc5wDhMRfyRc6+aJd8qNQpaLzxg6u7Tva8YOW96okmPRBIuJjQu0jFz/2h7
         v2kGk8n/WOh+icNUwS1WZERQ1XHDJwRZh08bmENdSjpJTraygHqp9CuYvFjv2n5+5eNR
         zhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=52VpJb2poMyndYoO2/jzkA3a3xPKo3Oi9H/A1xeVuO0=;
        b=W61mbJ8JF+wQhbsjyz5YPtVJvSG615N9bCMG23iCogT5Y5laZJlqD3Gqd694ECpp/r
         gPl6vQJ1vGAzoIFzVFS6sloQLtiOtOXp4Xf4ffzavmD5rnBBhLwDiEWjR0wNYt2NUK0U
         u2Bj4+ZVORp+GkRBlbEgY+sx4Xf5hyFIZ7NQNzJPd0y8o/cGiaKDxpVJ3iR6aSRFF4u2
         FDo9rgcpBb/DVnMgdYItw+MdMVCfMN1pt4NQnb7ljfLIQLUFiILcywWIj3zWi1hZ8X7J
         ZysHmDxdebOWSC7FHibpfBOCX/s7FPXjkoTpD2NWnFnT6vSZlHDWmO+u5kluo3hKKcEQ
         RdZg==
X-Gm-Message-State: AOAM531PAE/S7UKvW/PevtkSomlSdvl84LUJL3UxDp1LK0hvZxT2rKl7
        zrpAaZN5/c/fvMNQR8GR9ro=
X-Google-Smtp-Source: ABdhPJx7u58ANK586D6t59htWDEqonBQIHEAdErDfpUiQbQq419Nzvzj35X9VbDFlstEw732L/0+QQ==
X-Received: by 2002:aa7:d381:0:b0:416:293f:7de7 with SMTP id x1-20020aa7d381000000b00416293f7de7mr583161edq.170.1646847377796;
        Wed, 09 Mar 2022 09:36:17 -0800 (PST)
Received: from smtpclient.apple (ip5f5bf490.dynamic.kabel-deutschland.de. [95.91.244.144])
        by smtp.gmail.com with ESMTPSA id si13-20020a170906cecd00b006cded0c5ee2sm1032235ejb.61.2022.03.09.09.36.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Mar 2022 09:36:17 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH v2 14/26] usb: gadget: s3c-hsudc: remove usage of list
 iterator past the loop body
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <a3fb72da-a9e3-04af-fa19-62765bf81c2b@canonical.com>
Date:   Wed, 9 Mar 2022 18:36:14 +0100
Cc:     Greg Kroah-Hartman <greg@kroah.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Al Cooper <alcooperx@gmail.com>, Li Yang <leoyang.li@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:USB GADGET/PERIPHERAL SUBSYSTEM" 
        <linux-usb@vger.kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B269AAED-135D-4EAB-AA7C-26219581FB40@gmail.com>
References: <20220308171818.384491-1-jakobkoschel@gmail.com>
 <20220308171818.384491-15-jakobkoschel@gmail.com>
 <a3fb72da-a9e3-04af-fa19-62765bf81c2b@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 9. Mar 2022, at 18:25, Krzysztof Kozlowski =
<krzysztof.kozlowski@canonical.com> wrote:
>=20
> On 08/03/2022 18:18, Jakob Koschel wrote:
>> If the list representing the request queue does not contain the =
expected
>> request, the value of the list_for_each_entry() iterator will not =
point
>> to a valid structure. To avoid type confusion in such case, the list
>> iterator scope will be limited to the list_for_each_entry() loop.
>>=20
>> In preparation to limiting scope of the list iterator to the list =
traversal
>> loop, use a dedicated pointer to point to the found request object =
[1].
>>=20
>> Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
>> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
>> ---
>> drivers/usb/gadget/udc/s3c-hsudc.c | 12 +++++++-----
>> 1 file changed, 7 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/usb/gadget/udc/s3c-hsudc.c =
b/drivers/usb/gadget/udc/s3c-hsudc.c
>> index 89f1f8c9f02e..bf803e013458 100644
>> --- a/drivers/usb/gadget/udc/s3c-hsudc.c
>> +++ b/drivers/usb/gadget/udc/s3c-hsudc.c
>> @@ -877,7 +877,7 @@ static int s3c_hsudc_dequeue(struct usb_ep *_ep, =
struct usb_request *_req)
>> {
>> 	struct s3c_hsudc_ep *hsep =3D our_ep(_ep);
>> 	struct s3c_hsudc *hsudc =3D hsep->dev;
>> -	struct s3c_hsudc_req *hsreq;
>> +	struct s3c_hsudc_req *hsreq =3D NULL, *iter;
>> 	unsigned long flags;
>>=20
>> 	hsep =3D our_ep(_ep);
>> @@ -886,11 +886,13 @@ static int s3c_hsudc_dequeue(struct usb_ep =
*_ep, struct usb_request *_req)
>>=20
>> 	spin_lock_irqsave(&hsudc->lock, flags);
>>=20
>> -	list_for_each_entry(hsreq, &hsep->queue, queue) {
>> -		if (&hsreq->req =3D=3D _req)
>> -			break;
>> +	list_for_each_entry(iter, &hsep->queue, queue) {
>> +		if (&iter->req !=3D _req)
>> +			continue;
>> +		hsreq =3D iter;
>> +		break;
>=20
> You have in the loop both continue and break, looks a bit complicated.
> Why not simpler:
>=20
> if (&iter->req =3D=3D _req) {
> 	hsreq =3D iter;
> 	break;
> }

Ultimately I changed this based on the feedback from Linus
(Link: =
https://lore.kernel.org/linux-kernel/CAHk-=3Dwheru6rEfzC2wuO9k03PRF6s3nhxr=
yCAnwR5bzKwPV2ww@mail.gmail.com/).

>=20
> ?
> Less code, typical (expected) code flow when looking for something in
> the list. Is your approach related to some speculative execution?

no relation to speculative execution.

I have no preference for one over the other, so I'll just change it to
however it is desired.

It would just be great to have a (somewhat) consistent way so I can =
prepare
the rest of the patch sets accordingly.

>=20
>> 	}
>> -	if (&hsreq->req !=3D _req) {
>> +	if (!hsreq) {
>> 		spin_unlock_irqrestore(&hsudc->lock, flags);
>> 		return -EINVAL;
>> 	}
>=20
>=20
> Best regards,
> Krzysztof

Jakob=
