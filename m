Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4894C45F0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbiBYNVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241130AbiBYNU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:20:58 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983A51FED89;
        Fri, 25 Feb 2022 05:20:25 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s13so4490360wrb.6;
        Fri, 25 Feb 2022 05:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s1IYJZfN0mhNOaQ7xs2EzjYsvsrp1awM4MJ+j+7u52c=;
        b=D1PT3X4A3/4qAB2dteG2aRhfQPR+e22vU0e4PzgdD4Pecm79lz7X9hXBX8dGtd2KRj
         686i4FTxtgNtswJoVjLRaGYneZFulFIxP/FQlxh89iUHTdZsxdsMfqRoRbX6DDwCbBcP
         RisE1M4OfrDZXooYhJlQnhOezWRfeSi94qzIaRhKhhgzP1h0YAq352ofs/nODkN+AF1/
         QWumRmW9DJScWEfEjXx/uBuiVyjRIco+pdqOeJlWNaU5nfeBxPXauooL0cZWunuclspL
         zmiHpfeo7yUB35ig9E3o9onbLdGqUNWwVVJA3oqyAXLt6HPXhk1oLksIQ4ZDzX8oP8kb
         z3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s1IYJZfN0mhNOaQ7xs2EzjYsvsrp1awM4MJ+j+7u52c=;
        b=LoF66T61wsZhG44trVehja3ABSxdEmlw/bBrhni8kfbrumzXooFX8+y8rWveL8ZvMy
         z9TuPl0K4JVJZGGz+qJjXU34tEonm5mgX0Po++X3Ur6gH4gvRQs+6IjIafCfXQhv6Kp7
         j2PLmWZ//ZnG1fimTcR9clu9avRhtwhNeT5esOHv/3KRJ92Y58K4kfrwhMJxI3xxGPzp
         3DX5Pe8c8+e/T/645lEkkhdf8gNzVT85kHbtAHMypi3tuSATzVEgwBWfH7BCsQrRaAm6
         XborkbBiGKpRypGA26Rq7rUEkqqTLmLy0geJKHW9Hv2ndDPbeRIKFD7oM0HLECfHRMMZ
         RkHw==
X-Gm-Message-State: AOAM53055D0+H9CVoD+YFuprwU6R+TyO8jsXaNpZJt4PRIM18dAuSlm0
        myUFOdPpf6Ta4IBlaoRjwjE=
X-Google-Smtp-Source: ABdhPJxYMDQjuuuIGYLTbkg31qQ1dYrHeN8eVGWGz1u9aIrgkh/o3msDoM0EpvZtTVzhreSGAIZ/zQ==
X-Received: by 2002:a5d:648b:0:b0:1e2:181:96cb with SMTP id o11-20020a5d648b000000b001e2018196cbmr6117994wri.508.1645795224064;
        Fri, 25 Feb 2022 05:20:24 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c1c0700b0037c2c6d2a91sm2348993wms.2.2022.02.25.05.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 05:20:23 -0800 (PST)
Date:   Fri, 25 Feb 2022 14:20:21 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wayne Chang <waynec@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        zhangqilong3@huawei.com, yangyingliang@huawei.com,
        rikard.falkeborn@gmail.com, chunfeng.yun@mediatek.com,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: gadget: tegra-xudc: Fix control endpoint's
 definitions
Message-ID: <YhjXlQJoKzI/9q89@orome>
References: <20220107091349.149798-1-waynec@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nNcLsEMhhKxQEfJG"
Content-Disposition: inline
In-Reply-To: <20220107091349.149798-1-waynec@nvidia.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nNcLsEMhhKxQEfJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 07, 2022 at 05:13:49PM +0800, Wayne Chang wrote:
> According to the Tegra Technical Reference Manual, the seq_num
> field of control endpoint is not [31:24] but [31:27]. Bit 24
> is reserved and bit 26 is splitxstate.
>=20
> The change fixes the wrong control endpoint's definitions.
>=20
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> ---
>  drivers/usb/gadget/udc/tegra-xudc.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Again, what's the impact of this? Is this a critical bug fix that needs
to go into stable? Or is it cleanup? Perhaps add something along those
lines to the commit message to make it clearer to maintainers how they
need to deal with them.

Also, if this is a bugfix, make sure to Cc: stable@vger.kernel.org and
add a corresponding Fixes: line. Same for that earlier patch.

Thierry

--nNcLsEMhhKxQEfJG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIY15UACgkQ3SOs138+
s6ELuA//frfkH8KumnsE3c8cVrLkPeCVSZOWkuK/7ye9Eg1ddJcQw/G1e3XdxijZ
IdluDEI4Vvt0F2Fg/saOVlQ2H5pVozQUL4zWWqNs9ZORCW9HZuFVAuWfzAEqT3pT
WY6i2SYq9+AAcZNFGL3HaLGfA5EjMvCjnpDMFEruzaKcOqaab8yFy77E4xxUa9WE
WiBiU3HykF0S7sAOkXIv5g7WmllFZbFetipPwm9WDsv3lyZjg42i0qXKzqzeD/wv
MRPEU/IRxSVXBtUfwWPrQBU71zct8xmTb9WAuhbgddTigWWNEt2Ovu2Yk5Sl5I9n
dXWfmWUkujyKuWs+a+ULy85T/GuJ8XOgLHf1Ew6dL7k6yrPIHyTU3qFwbcdjqEsM
VHuIT8j1OMWI18sVb+0QY6NjsDjwaAgErxUNE3c/oCTf+3JtrfOVBy40zlwr6BN+
PkDhKLESUTjlu3YYRukVmaU47jcMjCLr1SSr+XMfa/byGtXyfe+EGAQ7tIZTwXSa
+u7dhWmKBuW12cZbrGAw1raMdDrUhEkkgSv6c0KqAOeFjOY3XY+ndSQl8+x3I2vV
m/VAQZ4u7RBSYhKQK3vPu6i18o/0yQq920B6gkdg2eQDfbPlLa/Tk6gGLujrV8mQ
xkzo9jSVey6+WQcZ/CZdNy7qYASKI5RfQCDDjtDJwGIzGdUA5js=
=Jn0V
-----END PGP SIGNATURE-----

--nNcLsEMhhKxQEfJG--
