Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C8C55D6A3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242369AbiF0Xwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 19:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242350AbiF0Xwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 19:52:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59378E0B1;
        Mon, 27 Jun 2022 16:52:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F13F161629;
        Mon, 27 Jun 2022 23:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43895C34115;
        Mon, 27 Jun 2022 23:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656373968;
        bh=9o8m950DV1fTZ5y8Xg05BQF6yJMVzXBC+OPeMCZsUGE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ITNEpab73iKnpFuZO1fsLuu9Bp4nVLQIXMSgxrBjfMrS9jnspsnARvsN/0PoDyVR0
         xy9klbC7mVhKey7HpboQSJpekk8anFbbm392b1XIHuRLPtRTaAPKSYCzl5kyws+OCL
         1S7XOLCZEoYPQGVw3TLxqyug+ehZnOARxSXZmyB8pcmHuU1i+sPhBX1g7fi3MhFSyg
         mQ4MZppTFdi0jllcIlygL9Y7ZlbfJVP0T5TVQ6AG+Qdo2SFryIkaUaZXVasA9GcgMD
         2rh6eMrfZiwwaiJ8dYibmYf43ooR1dHH6ISXlMenlW/GEKwnCarGn61wVBmrtN4Cmd
         KeWgHWPa0o+Yg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220627161642.1.Ie7b480cd99e2c13319220cbc108caf2bcd41286b@changeid>
References: <20220627161642.1.Ie7b480cd99e2c13319220cbc108caf2bcd41286b@changeid>
Subject: Re: [PATCH] soc: qcom: cmd-db: replace strscpy_pad() with strncpy()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Mon, 27 Jun 2022 16:52:46 -0700
User-Agent: alot/0.10
Message-Id: <20220627235248.43895C34115@smtp.kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2022-06-27 16:17:00)
> Commit ac0126a01735 ("soc: qcom: cmd-db: replace strncpy() with
> strscpy_pad()") breaks booting on my sc7280-herobrine-herobrine
> device. From printouts I see that at bootup the function is called
> with an id of "lnbclka2" which is 8 bytes big.
>=20
> Previously all 8 bytes of this string were copied to the
> destination. Now only 7 bytes will be copied since strscpy_pad() saves
> a byte for '\0' termination.
>=20
> We don't need the '\0' termination in the destination. Let's go back
> to strncpy(). According to the warning:
>   If a caller is using non-NUL-terminated strings, strncpy() can still
>   be used, but destinations should be marked with the __nonstring
>   attribute to avoid future compiler warnings.
> ...so we'll do that.
>=20
> Fixes: ac0126a01735 ("soc: qcom: cmd-db: replace strncpy() with strscpy_p=
ad()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>=20
>  drivers/soc/qcom/cmd-db.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index c5137c25d819..0aafe90277bc 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -141,14 +141,14 @@ static int cmd_db_get_header(const char *id, const =
struct entry_header **eh,
>         const struct rsc_hdr *rsc_hdr;
>         const struct entry_header *ent;
>         int ret, i, j;
> -       u8 query[8];
> +       u8 query[8] __nonstring;

Since you're already here, can you change 8 to be sizeof(ent->id)? That
would directly tie the two lengths together so that one can't change and
then the carefully crafted strncpy() fails again.

> =20
>         ret =3D cmd_db_ready();
>         if (ret)
>                 return ret;
> =20
>         /* Pad out query string to same length as in DB */
> -       strscpy_pad(query, id, sizeof(query));
> +       strncpy(query, id, sizeof(query));
