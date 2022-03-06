Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7944CED51
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 20:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiCFTRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 14:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiCFTRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 14:17:42 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D876A55492;
        Sun,  6 Mar 2022 11:16:49 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id qa43so27639440ejc.12;
        Sun, 06 Mar 2022 11:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XkjyBn8RTBF3TIgoelbZlPWIXh1FI1r8sae/cnzrj6Y=;
        b=U274yF6VKYXNGlm3FuSn90o9BFI7lOjLVxQ4GUZJJ940BmdDrsdE58JKDDqCl8BZ0S
         hzr4dnSxhN8bN4w4rov7rL5ysylC1Pzbk/whuZ8uIDEvH6pacac/O4EgpwoIfem43q1l
         0ppdwPWZ5k08oyvkWer6LPvhmP+KRzrm54IKkE3qoOmY4tyJjf8Uteih5kCBOqxbrHtS
         oizOOTQ05rEguotLPMIU+thd5eiQ1eql9BkBcpBJZvDYWXnbetXlsOGUtRih5hXZHDpj
         H7Ytz1i2RT/Yx1NXCNjCuCnNmUA/oYgZRD3ZRkVPe0ntQsy56IYBmTJUr4eIbFnwaVvu
         /GKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XkjyBn8RTBF3TIgoelbZlPWIXh1FI1r8sae/cnzrj6Y=;
        b=IGAlx506bkx4WwqaBEbPbM/pVDRQulc6f/Hpq5jKxbRPvyW52zYRuJvmtja/xpI5Kl
         BjQAYfh+wafS3Ln9at/DZ+PTA3Jki+zY6UEbx+VkhhW0lGa+28nTFwFKZHdELAu6qTX2
         H18T4gZpyiFQrBvhWLR5KSH+vOcCymxlDrRBEjkEm6mYv0g0/dZ4RxZcy/PS4CCKv/9/
         Q19eLDrqCKWVdKu2JQFRWo9ttPaa/SlADFpepQdHpbDTt+TL59SeoHZwnQOyz72ARzrd
         5W7KGvoM1DCs68g5kUcNzGacRnVxlEqIkBY2N/qwTLxp4PaToDud8QdjTED9k5+Lj7ex
         5C/Q==
X-Gm-Message-State: AOAM530D9bbQkUOl/0r9JGew30Z0Urxw73XmrKUfa/p8FmGrpmWwGlrN
        V8IwlUfzHfjdVWQmKosVyawEyV1mTR+m++d3apvxDQ==
X-Google-Smtp-Source: ABdhPJwccY2Lza+suh6Iu2EXenxXmE63f7x+DoRdV9QXqKRzndP+kk0ZxCA9jU1f6fc8qHpExQK+tQ==
X-Received: by 2002:a17:906:1f11:b0:685:d50e:3bf9 with SMTP id w17-20020a1709061f1100b00685d50e3bf9mr6702455ejj.275.1646594208417;
        Sun, 06 Mar 2022 11:16:48 -0800 (PST)
Received: from smtpclient.apple ([2a02:8109:9d80:3f6c:dceb:fbab:14be:fc99])
        by smtp.gmail.com with ESMTPSA id fx3-20020a170906b74300b006daecedee44sm2377233ejb.220.2022.03.06.11.16.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Mar 2022 11:16:47 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH 25/26] usb: gadget: dummy_hcd: replace usage of rc to
 check if a list element was found
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <YiT2odfvXhp4nsK4@kroah.com>
Date:   Sun, 6 Mar 2022 20:16:46 +0100
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
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
Message-Id: <024FB75A-A6AD-4ED1-8E1D-5126A4692FD8@gmail.com>
References: <20220306175034.3084609-1-jakobkoschel@gmail.com>
 <20220306175034.3084609-26-jakobkoschel@gmail.com>
 <YiT2odfvXhp4nsK4@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
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



> On 6. Mar 2022, at 19:00, Greg KH <gregkh@linuxfoundation.org> wrote:
>=20
> On Sun, Mar 06, 2022 at 06:50:33PM +0100, Jakob Koschel wrote:
>> To move the list iterator variable into the list_for_each_entry_*()
>> macro in the future it should be avoided to use the list iterator
>> variable after the loop body.
>>=20
>> To *never* use the list iterator variable after the loop it was
>> concluded to use a separate iterator variable [1].
>>=20
>> This removes the need to check the rc value to determine if the
>> break/goto was hit and can be made more obvious
>> by checking if the variable was set within the list traversal loop.
>>=20
>> Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
>> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
>> ---
>> drivers/usb/gadget/udc/dummy_hcd.c | 11 ++++++-----
>> 1 file changed, 6 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/usb/gadget/udc/dummy_hcd.c =
b/drivers/usb/gadget/udc/dummy_hcd.c
>> index a2d956af42a2..f21944707707 100644
>> --- a/drivers/usb/gadget/udc/dummy_hcd.c
>> +++ b/drivers/usb/gadget/udc/dummy_hcd.c
>> @@ -751,7 +751,7 @@ static int dummy_dequeue(struct usb_ep *_ep, =
struct usb_request *_req)
>> 	struct dummy		*dum;
>> 	int			retval =3D -EINVAL;
>> 	unsigned long		flags;
>> -	struct dummy_request	*req =3D NULL;
>> +	struct dummy_request	*req =3D NULL, *tmp;
>>=20
>> 	if (!_ep || !_req)
>> 		return retval;
>> @@ -763,17 +763,18 @@ static int dummy_dequeue(struct usb_ep *_ep, =
struct usb_request *_req)
>>=20
>> 	local_irq_save(flags);
>> 	spin_lock(&dum->lock);
>> -	list_for_each_entry(req, &ep->queue, queue) {
>> -		if (&req->req =3D=3D _req) {
>> -			list_del_init(&req->queue);
>> +	list_for_each_entry(tmp, &ep->queue, queue) {
>> +		if (&tmp->req =3D=3D _req) {
>> +			list_del_init(&tmp->queue);
>> 			_req->status =3D -ECONNRESET;
>> +			req =3D tmp;
>> 			retval =3D 0;
>> 			break;
>> 		}
>> 	}
>> 	spin_unlock(&dum->lock);
>>=20
>> -	if (retval =3D=3D 0) {
>> +	if (req) {
>=20
> There's no need for this change as we are testing retval, not req =
here,
> unlike the other udc drivers.
>=20
> So this one I think is correct as-is, or am I mistaken somehow?

The check is correct as-is. I just felt it would be more explicit to
actually check if the pointer that is used within the block is not
NULL than implicitly checking this through retval. There are other
blocks which do like:

list_for_each_entry(pos, head, list) {
	if (...) {
		rc =3D -1;
		goto fail;
	}
}

rc =3D call_unrelated_function(...);
if (rc =3D=3D -1)
	goto fail;

...

return 0;

fail:
	*pos->member;

While this code is obviously broken and then one in this patch works =
fine,
I feel like it's easier to follow the rule of always checking of pos !=3D =
NULL.

It might also make it easier for some static analyzers to find potential
NULL pointer dereferences but it probably doesn't matter.

If you prefer keeping retval I'll just do that instead.

>=20
> thanks,
>=20
> greg k-h

Jakob

