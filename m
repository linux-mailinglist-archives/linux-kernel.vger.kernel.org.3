Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA094E2319
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345757AbiCUJQI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Mar 2022 05:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244214AbiCUJQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:16:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEDC233EB2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:14:38 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-278-qw6f7-ngP1apDy64emi6IQ-1; Mon, 21 Mar 2022 09:14:35 +0000
X-MC-Unique: qw6f7-ngP1apDy64emi6IQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Mon, 21 Mar 2022 09:14:36 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Mon, 21 Mar 2022 09:14:36 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dan Carpenter' <dan.carpenter@oracle.com>
CC:     'Martin Kaiser' <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging: r8188eu: remove local BIT macro
Thread-Topic: [PATCH] staging: r8188eu: remove local BIT macro
Thread-Index: AQHYO7vDt7lRrzeqGEaCQ6n5CUyH5azHRaWwgAJI4ACAAADG0A==
Date:   Mon, 21 Mar 2022 09:14:36 +0000
Message-ID: <8173b8e8846646de844de50952c5117e@AcuMS.aculab.com>
References: <20220319180342.3143734-1-martin@kaiser.cx>
 <ac3343ea279b4d048d77b3cf2724bcbe@AcuMS.aculab.com>
 <20220321090648.GH3293@kadam>
In-Reply-To: <20220321090648.GH3293@kadam>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter
> Sent: 21 March 2022 09:07
> 
> On Sat, Mar 19, 2022 at 10:35:58PM +0000, David Laight wrote:
> > OTOH this code is a big pile of poo.
> > Abstraction functions gone mad.
> 
> Yeah.
> 
> I wrote an email similar to yours and I even wrote some sample code.
> But then I deleted it because I don't pay Martin anything so I'm just
> grateful for what he sends and can't reasonably ask for more.
> 
> This code constantly amazes me with how many abstractions there are.
> Martin keeps deleting them, and I think he's going to run out but so
> far that hasn't happened.
> 
> Anyway here is the diff just for laughs since you brought it up.  Not
> something that's necessarry and definitely not a priority.
> 
> I don't really like enable/disable functions that do opposite things
> depending on if true/false is passed as a parameter.  They're normally
> more readable split apart.
> 
> Ideally there would be adapter_to_pdbm() and adapter_to_podm() helper
> functions.
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c
> b/drivers/staging/r8188eu/core/rtw_wlan_util.c
> index 665b077190bc..d973cf341031 100644
> --- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
> +++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
> @@ -276,12 +276,23 @@ void Restore_DM_Func_Flag(struct adapter *padapter)
>  	SetHwReg8188EU(padapter, HW_VAR_DM_FUNC_OP, (u8 *)(&saveflag));
>  }
> 
> +void enable_dm_func(struct adapter *padapter, u32 mode)
> + {
> +	struct dm_pri *pdmpriv = adapter_to_pdbm(padapter);
> +	struct odm_dm_struct *podmpriv = adapter_to_pod(padapter);
> +
> +	if (mode == DYNAMIC_ALL_FUNC_ENABLE) {
> +		podmpriv->SupportAbility = pdmpriv->InitODMFlag;
> +	} else {
> +		podmpriv->SupportAbility |= mode;
> +	}
> +}
> +
> +void disable_dm_func(struct adapter *padapter, u32 mode)
> +{
> +	struct odm_dm_struct *podmpriv = adapter_to_pod(padapter);
> +
> +	podmpriv->SupportAbility &= mode;
> + }

I'd go even further.
One function for each of 'set', 'enable' and 'disable'.
Doing '=', '|=' and '&= ~'.

But then you realise it just isn't worth the effort.
Just type:
		adapter_to_pod(padapter)-> SupportAbility = ...
directly in the code.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

