Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3112D50254B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242371AbiDOGIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240302AbiDOGIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:08:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C256AAB6A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:06:21 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bv19so13814632ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=56qZhVh84dtsVlqsQOB0RGlHkJgFs7X0oSzIvgUl4cM=;
        b=Zhv8lF6w3NRo7aX4KNxJl2lyeuQvHNlfet3mLfGaNQdqy4VDf8kxpuTvWkiR1u2Y2k
         KrLLEug2pYc/pt1/k7DXiRILH4FxPdQsl5Acap6HwHzt8EJ6wefrSzuNq3//QG5b1jhj
         CHNwtrqDjj1iHc4/b8ncu1b4p9WKZ5TUrAm0VufXK7fxILqWPF12zpp7WHbbvQD04J2x
         iEt/2vzER66jkc3ymiEpafejKMSfcf+DAOdDZOStAjxXYF+ml+3mkDZJ18/iqGlNTeTz
         kVXpUnFypIc9+46NYj2f9NLmjrrB/LG8MOQ2jpIqAETpI8iGFm3ilU6Qie8rccUQQVWO
         EmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=56qZhVh84dtsVlqsQOB0RGlHkJgFs7X0oSzIvgUl4cM=;
        b=rN8YDrmDbcNH8PaNZ0wh3V9/XUqU7XqZyXT4Qkz/nyB1WoQy/ebRar/Snc9OLRbRXw
         sYmeUA8exTn/UZ4owWqVnikT+iKhxoy2Pf/6w+Kt1bg3YuaPKq5Mo0XkEv9GE7kYMZc0
         3wukYBuGnKhdbWfT8GzHER9xd+2TXQt+DimckhwT2yRwIcPFI+ndlhAbSP6ZgzRYIM9Z
         ms04gPV3adiuKe67YQwUMaUdKIeOO07ZDVdA73zt6o60X8q/ORSDI4N4w8+EVGawmZ0p
         13/UOnhorD9ESzgi8kEYSWnJ0+32/PjbQ+OrauumWEAe4zXE7Cn4Pts9F+uUeZOFoedc
         RTlg==
X-Gm-Message-State: AOAM532CK8UdUzCw2rC89SpUBvgkNnlIolnUeEOsOq+/hllddSLekZ1/
        V2/TtYwSifzUMFf7oSh4Ft8=
X-Google-Smtp-Source: ABdhPJwlz3Gd+zNTO2vXQRWSHSxBiQ2PjDL8JpdgdhlfwpW72pirIiT6AFHt18hwxU85ko3twR2x7w==
X-Received: by 2002:a17:906:af96:b0:6e8:7765:a6d4 with SMTP id mj22-20020a170906af9600b006e87765a6d4mr5076600ejb.756.1650002780226;
        Thu, 14 Apr 2022 23:06:20 -0700 (PDT)
Received: from leap.localnet (host-79-43-11-75.retail.telecomitalia.it. [79.43.11.75])
        by smtp.gmail.com with ESMTPSA id ay17-20020a170906d29100b006e88f246fdbsm1319695ejb.152.2022.04.14.23.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 23:06:19 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haowen Bai <baihaowen@meizu.com>
Cc:     Haowen Bai <baihaowen@meizu.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] staging: rtl8192e: Fix signedness bug in rtllib_rx_assoc_resp()
Date:   Fri, 15 Apr 2022 08:06:17 +0200
Message-ID: <16182197.geO5KgaWL5@leap>
In-Reply-To: <1650001836-25956-1-git-send-email-baihaowen@meizu.com>
References: <20220415053116.GN3293@kadam> <1650001836-25956-1-git-send-email-baihaowen@meizu.com>
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

On venerd=EC 15 aprile 2022 07:50:36 CEST Haowen Bai wrote:
> The rtllib_rx_assoc_resp() function has a signedness bug because it's
> a declared as a u16 but it return -ENOMEM.  When you look at it more
> closely it returns a mix of error codes including 0xcafe, -ENOMEM, and
> a->status which is WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG.  This is a mess.
>=20
> Clean it up to just return standard kernel error codes.  We can print
> out the a->status before returning a regular error code.  The printks
> in the caller need to be adjusted as well.

This commit message suggested by Dan Carpenter is much better. The previous=
=20
one made me think that you were doing several different logical changes.

>
> [snip]
> =20
>  static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct=20
sk_buff *skb)
>  {
> -	u16 errcode;
> +	int errcode;
>  	u8 *challenge;
>  	int chlen =3D 0;
>  	bool bSupportNmode =3D true, bHalfSupportNmode =3D false;
> @@ -2292,8 +2292,8 @@ static void rtllib_rx_auth_resp(struct=20
rtllib_device *ieee, struct sk_buff *skb)
>  	if (errcode) {
>  		ieee->softmac_stats.rx_auth_rs_err++;
>  		netdev_info(ieee->dev,
> -			    "Authentication response status code=20
0x%x",
> -			    errcode);
> +			    "Authentication response status code %d",
> +			    le16_to_cpu(errcode));

This is something that I'm still missing. Why do we need that call to=20
le16_to_cpu on "errcode"?

"errcode" is returned by auth_parse()? I see that this function already=20
changes the endianness of the returned value.

Thanks,

=46abio


>  		rtllib_associate_abort(ieee);
>  		return;
>  	}
> --=20
> 2.7.4
>=20
>=20
>=20




