Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A99502553
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343738AbiDOGNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240302AbiDOGNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:13:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C654A3C6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:10:40 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g20so8872901edw.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yZK1aloE4NcRFJpUcMOYel3NphqGgMdnwyOVwX33QOs=;
        b=U9+WVlHalxi7H57sau6QSkuKMv2MWHS/5P+S956ZjjyTuQ8RKfdBxh2bi1qbwLRlvd
         skzz5aCDZ/89t4gIrBOoEn5oR9nrF0Z2SN34XZIYzLjgEU6WkeFSfBVUBZIKlw7T1+72
         M2HWH5R44yVFealq9KxccsniB3k3MWu6vRCHfIb9outynu+V7mZQ+PimAHAN5uaBgE65
         WEnroJrDIrCrnwMEaZQnrr3zUzMlw8io18/qbc+IhcGvKI7o+/EIJj0wE8yAxqks0xEY
         rM2nAfs7AXMiOwuMIY3Zx/iic+z+pjUHURlwSjK/EewxyVO8g2pbXuq+Laj2gxrljd3e
         0XbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yZK1aloE4NcRFJpUcMOYel3NphqGgMdnwyOVwX33QOs=;
        b=vdK6U26rdnaCAGFUuBSzw0CEvsTZhKpXrUH6dxN8WkJUSHhaJ/i4Axa9uIeUNkav1t
         Ah7w5c1UM9brcZR2v/J0cF++Uz7qf9Vqm6SmOR1hmm3UmUo82hK0MHjqsL8K1euBBGd8
         ADrcAjmVFIuRizyEEdZ5ePxTi/6jrwI4Vx6loE9cXP8ng1Z2rUA9Fiih2pDSiLfSOvw+
         5uhRrK+EdeVHK1bdn/wiHlyxtbXgy1WzbX16pcyHi54Xv+gFBe69ZITWcOLpkiZvEzeh
         opsyBtmrUOCkXf8LPOjtCCLS+2cH/p+7kFGasguWIohVlKbJMWKNuxhNJD+eFLXv9/W2
         0EGA==
X-Gm-Message-State: AOAM5331oiDUQoZ9VG6LebQjylPNNiGaaQrENSOE6yneEk9rjsnKwT+K
        LiTZyrEo+JOEe6Z+7pchCTU=
X-Google-Smtp-Source: ABdhPJw9yVcZt1UgXVG9oF4OCzM62Pz8XY5umRDDqZPTpiME1PPpVjKX1pd8Y41igc0qGYA8HiDMyQ==
X-Received: by 2002:aa7:c612:0:b0:41d:7ad7:4a4d with SMTP id h18-20020aa7c612000000b0041d7ad74a4dmr6668648edq.125.1650003038475;
        Thu, 14 Apr 2022 23:10:38 -0700 (PDT)
Received: from leap.localnet (host-79-43-11-75.retail.telecomitalia.it. [79.43.11.75])
        by smtp.gmail.com with ESMTPSA id cq24-20020a056402221800b00420ad7d2dd0sm2142646edb.29.2022.04.14.23.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 23:10:36 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haowen Bai <baihaowen@meizu.com>
Cc:     Haowen Bai <baihaowen@meizu.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] staging: rtl8192e: Fix signedness bug in rtllib_rx_assoc_resp()
Date:   Fri, 15 Apr 2022 08:10:35 +0200
Message-ID: <4370787.8F6SAcFxjW@leap>
In-Reply-To: <16182197.geO5KgaWL5@leap>
References: <20220415053116.GN3293@kadam> <1650001836-25956-1-git-send-email-baihaowen@meizu.com> <16182197.geO5KgaWL5@leap>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On venerd=EC 15 aprile 2022 08:06:17 CEST Fabio M. De Francesco wrote:
> On venerd=EC 15 aprile 2022 07:50:36 CEST Haowen Bai wrote:
> > The rtllib_rx_assoc_resp() function has a signedness bug because it's
> > a declared as a u16 but it return -ENOMEM.  When you look at it more
> > closely it returns a mix of error codes including 0xcafe, -ENOMEM, and
> > a->status which is WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG.  This is a mess.
> >=20
> > Clean it up to just return standard kernel error codes.  We can print
> > out the a->status before returning a regular error code.  The printks
> > in the caller need to be adjusted as well.
>=20
> This commit message suggested by Dan Carpenter is much better. The=20
previous=20
> one made me think that you were doing several different logical changes.
>=20
> >
> > [snip]
> > =20
> >  static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct=20
> sk_buff *skb)
> >  {
> > -	u16 errcode;
> > +	int errcode;
> >  	u8 *challenge;
> >  	int chlen =3D 0;
> >  	bool bSupportNmode =3D true, bHalfSupportNmode =3D false;
> > @@ -2292,8 +2292,8 @@ static void rtllib_rx_auth_resp(struct=20
> rtllib_device *ieee, struct sk_buff *skb)
> >  	if (errcode) {
> >  		ieee->softmac_stats.rx_auth_rs_err++;
> >  		netdev_info(ieee->dev,
> > -			    "Authentication response status code=20
> 0x%x",
> > -			    errcode);
> > +			    "Authentication response status code %d",
> > +			    le16_to_cpu(errcode));
>=20
> This is something that I'm still missing. Why do we need that call to=20
> le16_to_cpu on "errcode"?
>=20
> "errcode" is returned by auth_parse()? I see that this function already=20
> changes the endianness of the returned value.

Sorry, I missed that you also changed auth_code().

=46abio

>=20
> Thanks,
>=20
> Fabio
>=20
>=20
> >  		rtllib_associate_abort(ieee);
> >  		return;
> >  	}
> > --=20
> > 2.7.4
> >=20
> >=20
> >=20
>=20
>=20
>=20
>=20
>=20




