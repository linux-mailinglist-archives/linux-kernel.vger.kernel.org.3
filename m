Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44112508B39
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379821AbiDTOz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbiDTOz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:55:27 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161EB1C139
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:52:40 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g20so2631974edw.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=J17I7k1DFIqdIF/nQAjV+GrkyCMr24/svVDXLbOChlw=;
        b=JBbWsEgOEa3GzjofmvOYyn+vCd97m5ObSyLdlSx0foS7fqFoPNa+6SVFauM0aD8VQG
         ZSkZln+EXn10Uy0PFc1DvXI0mJ774skLlTkSQfmX8qUTSBTfT0izN9GWBg/4mN7owrRx
         EOwUrr+vgc/soUSGSI/g6pQLR2mtSTF7WwmKIfCmHrligUM7YCu2NUK+5ggefv5ph31s
         t+mmWJ4zbOMOsBNxJTSA2MNpwYhl3be54FHmu3aeWYbS3sq7rHHx1b6B2nc0EnAXTyH7
         iFKhLvci/5DueD9EJOdVFOftEbybMLhnZ4QC+YlAwy2OGQUN4KQpUyyhRpMOqFh8+/0a
         zTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J17I7k1DFIqdIF/nQAjV+GrkyCMr24/svVDXLbOChlw=;
        b=cilGnFdLfJHnHPP2R6LmrhOicBIVstHqS670TrqKkRzpcgCQPyeLti+X+ZuUW60j6e
         LH9dKQJGpAoYM805gA2NNmsWhd8UmP5HDs4ew1hh6FloIxePVem7WRmdqGvnIz8kq1iR
         Kbe9fLQ9Ww6lBBABXExGvU0suzrFZd64kTF2Mb4Y6Cc3wqkvzXWvcFxvIAJIuOAmlo5N
         F/rUaEJViWx2zbTgLLzv0dCfRkJ0f32KvioDpDUHqinOx3/psWtN1vpHIbQqTqaVkioS
         HsFhPgERH9/dBcrzKj29/WizKon0hEkTDkahlTglIp9tbx+zNWDHsQyIlzfIehkowqya
         PwGw==
X-Gm-Message-State: AOAM532ltpcqkMMqLtQnFnfYvvnp0I/aEbdPMlNewLPU3m125NJchukg
        NRr5ghWaqQBH6VpIiX+IWJfaZQzIWQs=
X-Google-Smtp-Source: ABdhPJx2ZxgmXp985oW9D/tZe4ZqroM4HtirxNo5Df1BZbnJnyqyDBb/QXHmtBPvc/0fWHsstt+qIw==
X-Received: by 2002:a05:6402:1ac4:b0:41d:83d1:9da7 with SMTP id ba4-20020a0564021ac400b0041d83d19da7mr23708711edb.272.1650466358430;
        Wed, 20 Apr 2022 07:52:38 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id b23-20020a05640202d700b00422da9b980esm7945020edx.22.2022.04.20.07.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:52:37 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, Rebecca Mckeever <remckee0@gmail.com>
Subject: Re: [PATCH] staging: rtl8192u: change get_key functions to return 0 instead of -1
Date:   Wed, 20 Apr 2022 16:52:36 +0200
Message-ID: <3183776.G96rZvMJ2N@leap>
In-Reply-To: <Yl/7QPKXer7YtXOs@bertie>
References: <Yl/7QPKXer7YtXOs@bertie>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mercoled=C3=AC 20 aprile 2022 14:23:28 CEST Rebecca Mckeever wrote:
> Currently, these three get_key functions return -1 when the provided len
> value is less a specific key length value, which can result in buffer
> overflow depending on how the returned value is used. These functions are
> used in three places in ieee80211/ieee80211_wx.c:
>=20
>   ieee80211_wx_get_encode() :
>     The behavior of this function will be unchanged.
>=20
>   ieee80211_wx_get_encode_ext() :
>     The result of the get_key function is written to ext->key_len,
>     resulting in a buffer overflow if the result is negative.
>=20
>   ieee80211_wx_set_encode() :
>     The behavior of this function will change. When len is less than the
>     key length value, it will set a default key of all 0.
>=20
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c | 2 +-
>  drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c | 2 +-
>  drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

I was not able to find the message where Dan suggested this solution.=20
However it looks that we actually have problems in those callers when they=
=20
get '-1' as the return code.

I didn't look at the code with much attention but I think that returning=20
'0' to signal errors is not so good.

If I'm not missing something from the context, I'd rather return '-EINVAL'=
=20
and change the callers to check for this specific error that would signal=20
we have "len less than a specific len value". If so, act in accordance to=20
the returned -EINVAL.

=46or example, in a caller you may test:

if (ext->key_len =3D=3D -EINVAL || <some other test, if required>)
        <error path>
<success path>

Just my thoughts, but, as I said, I haven't checked carefully neither the=20
callers nor the called functions. Maybe that returning '0' is the better=20
solution, but it usually means that we have no errors.=20

However, I'm 100% sure that, if Dan suggested this specific solution, there=
=20
must be good reasons behind. If so, your changes are good :)

Thanks,

=46abio M. De Francesco

>=20
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c b/
drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
> index 101c28265e91..f17d07dad56d 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
> @@ -362,7 +362,7 @@ static int ieee80211_ccmp_get_key(void *key, int len,=
=20
u8 *seq, void *priv)
>  	struct ieee80211_ccmp_data *data =3D priv;
> =20
>  	if (len < CCMP_TK_LEN)
> -		return -1;
> +		return 0;
> =20
>  	if (!data->key_set)
>  		return 0;
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c b/
drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
> index 689d8843f538..7b120b8cb982 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
> @@ -637,7 +637,7 @@ static int ieee80211_tkip_get_key(void *key, int len,=
=20
u8 *seq, void *priv)
>  	struct ieee80211_tkip_data *tkey =3D priv;
> =20
>  	if (len < TKIP_KEY_LEN)
> -		return -1;
> +		return 0;
> =20
>  	if (!tkey->key_set)
>  		return 0;
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c b/
drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
> index 8a51ea1dd6e5..a2cdf3bfd1a4 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
> @@ -201,7 +201,7 @@ static int prism2_wep_get_key(void *key, int len, u8=
=20
*seq, void *priv)
>  	struct prism2_wep_data *wep =3D priv;
> =20
>  	if (len < wep->key_len)
> -		return -1;
> +		return 0;
> =20
>  	memcpy(key, wep->key, wep->key_len);
> =20
> --=20
> 2.32.0
>=20
>=20
>=20




