Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2B455436C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349938AbiFVHCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiFVHCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:02:19 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA06369FC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:02:16 -0700 (PDT)
Date:   Wed, 22 Jun 2022 07:02:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1655881334; x=1656140534;
        bh=hW6aQpyvrQi+nVh0DL4cohSiWMLpTMwE3tnnUD5pEHc=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=zPgSvVxQLJVZ8kUbeSjT6fZZhN8tgkMspF9xTC+0xN8i36hhESoEA4bqRfwNOX28+
         BGxiOXxyum7Bdjlwev8aNvA4rE/AGCQzzddCaEEhJedkeWqKTlfgcjyD+xjALkcFKE
         MxDXPq2hnLQwUXwtbZCO6kwciR+3jKj/zoTVH9Z26oR4id73wnnfwoZvMfAVqgjgqp
         qsQFRr7W5uBSjNtrHu9ci/BxZejVKXgQKrLUESfGoTE6fs0kZ1WhP8130XcYr6jtg9
         v6nUPedlQ9mlsFk37PbD42VtAp4/rtRrhCq1EksZ3+J6bJ5zU1l2IHguHXP4PcBXFE
         h/3P+Wl7zBi/A==
To:     Carlos Llamas <cmllamas@google.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/fourcc: fix integer type usage in uapi header
Message-ID: <uvR86emMYmXwy4OxDiY5OlpRs9UIoEce59p_VukwHwNa368FpqXYVtN7tqccW6WzG5Vz08ycVdxXonbMczsohHw8O8Dx7WdJv8pnrYb9V34=@emersion.fr>
In-Reply-To: <20220621203921.3594920-1-cmllamas@google.com>
References: <20220621203921.3594920-1-cmllamas@google.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 21st, 2022 at 22:39, Carlos Llamas <cmllamas@google.com> w=
rote:

> Kernel uapi headers are supposed to use __[us]{8,16,32,64} types defined
> by <linux/types.h> as opposed to 'uint32_t' and similar. See [1] for the
> relevant discussion about this topic. In this particular case, the usage
> of 'uint64_t' escaped headers_check as these macros are not being called
> here. However, the following program triggers a compilation error:
>
>   #include <drm/drm_fourcc.h>
>
>   int main()
>   {
>   =09unsigned long x =3D AMD_FMT_MOD_CLEAR(RB);
>   =09return 0;
>   }
>
> gcc error:
>   drm.c:5:27: error: =E2=80=98uint64_t=E2=80=99 undeclared (first use in =
this function)
>       5 |         unsigned long x =3D AMD_FMT_MOD_CLEAR(RB);
>         |                           ^~~~~~~~~~~~~~~~~
>
> This patch changes AMD_FMT_MOD_{SET,CLEAR} macros to use the correct
> integer types, which fixes the above issue.
>
>   [1] https://lkml.org/lkml/2019/6/5/18
>
> Fixes: 8ba16d599374 ("drm/fourcc: Add AMD DRM modifiers.")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Simon Ser <contact@emersion.fr>

Cc'ing Bas as well

> ---
>  include/uapi/drm/drm_fourcc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.=
h
> index f1972154a594..0980678d502d 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -1444,11 +1444,11 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 m=
odifier)
>  #define AMD_FMT_MOD_PIPE_MASK 0x7
>
>  #define AMD_FMT_MOD_SET(field, value) \
> -=09((uint64_t)(value) << AMD_FMT_MOD_##field##_SHIFT)
> +=09((__u64)(value) << AMD_FMT_MOD_##field##_SHIFT)
>  #define AMD_FMT_MOD_GET(field, value) \
>  =09(((value) >> AMD_FMT_MOD_##field##_SHIFT) & AMD_FMT_MOD_##field##_MAS=
K)
>  #define AMD_FMT_MOD_CLEAR(field) \
> -=09(~((uint64_t)AMD_FMT_MOD_##field##_MASK << AMD_FMT_MOD_##field##_SHIF=
T))
> +=09(~((__u64)AMD_FMT_MOD_##field##_MASK << AMD_FMT_MOD_##field##_SHIFT))
>
>  #if defined(__cplusplus)
>  }
> --
> 2.37.0.rc0.104.g0611611a94-goog
