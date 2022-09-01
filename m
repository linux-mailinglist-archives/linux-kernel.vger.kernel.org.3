Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE485A9157
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiIAH45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiIAH4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:56:53 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BC1EA89E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:56:52 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z187so16741281pfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 00:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=X9W6VxAu06jIOMqR9gPP6gg20oaBg0aqDnBh+JFn9xY=;
        b=BQWFXM4zGwgAulGPxzT8ZCAIBRXcGsSzYrDGvKL+aMN+24FkKktZUJMTKQ0++cHlK7
         8/dRumDjCXncqX+QrZH0byjevoU2C37we5qVY7kXY9UEYC5Qc+dYOpfMr7ft+FFjpagO
         km+HFhiBcgmRbT+kl9qldjiSD4SNSfNwWKw3mwPVG1LOUXGS1pL/hK61Bpydnpp287gS
         Dg5znHRHWpKV1AiA9h9CwaQB4ED6EUXtA4DZLpCxvXPgK9fhv6m0DD6yEv/lOHePlTZ9
         iDmN5w2PebX/xX+TTU8tAs3dJ+gcZQgNKsZt14IhjPvWX2pNfIZqFYJuGnU4o0rh3w3e
         KIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=X9W6VxAu06jIOMqR9gPP6gg20oaBg0aqDnBh+JFn9xY=;
        b=nVDODRp/Rv/9W6hPrwcWpn8UYq1Odd8ixzNbZsS8XRhdtnqBrS1EWAyHdw4Zourctb
         TK0SuFf1nJYdbArsaOAFDyXOx2kdH5S7I/9lHQoBqLWi7D11OSoz9oCfg3z2V62m6Eue
         y1iHok0ydIuPLjQG64g7NapNCE/ZVONrjTzdP42EdG1h2OcbtmLpMMUEBhtNuqPCKdzj
         HILHsoGoGQ9eVfSjuavXa1wCWAdN+B0+bb+sAsmrnhGtOsld+SmFEOhwPa3POI0gBfOQ
         gcrGN5Ie9B4uxiGsaHnt1bKlV+YW5lc/EpHAVzxeKuVHqnUoK8FfhWdPPdeAIAZIG2pb
         dJzA==
X-Gm-Message-State: ACgBeo1nJlHhRZOhEXQ3r1BJUweko0A3uzHnjjlBnU62I4VO4zumtFRB
        YKsmZP3Akuft0qP0pS2NROVH8NudpohlXfUV3731Tg==
X-Google-Smtp-Source: AA6agR5pENCCNyoa7Jw69iqcgBoMzQEr0+CAqB4xWbisdjSDjQBdLXdGHfwQBXfTeWosj+IA0lZDLSIk3dI5HXCIJAQ=
X-Received: by 2002:a63:ef0e:0:b0:42c:298e:eb7 with SMTP id
 u14-20020a63ef0e000000b0042c298e0eb7mr14476947pgh.568.1662019012050; Thu, 01
 Sep 2022 00:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220830100700.344594-1-sudeep.holla@arm.com> <20220830100700.344594-5-sudeep.holla@arm.com>
In-Reply-To: <20220830100700.344594-5-sudeep.holla@arm.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 1 Sep 2022 09:56:41 +0200
Message-ID: <CAHUa44HL5g-b+oGpYg=jne1MPNJSGLYbeW8_nx7a40=26ehQ1A@mail.gmail.com>
Subject: Re: [PATCH 4/9] firmware: arm_ffa: Add support for querying FF-A features
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 12:07 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Add support for FFA_FEATURES to discover properties supported at the
> FF-A interface. This interface can be used to query:
>  - If an FF-A interface is implemented by the component at the higher EL,
>  - If an implemented FF-A interface also implements any optional features
>    described in its interface definition, and
>  - Any implementation details exported by an implemented FF-A interface
>    as described in its interface definition.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_ffa/driver.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 04e7cbb1b9aa..de94073f4109 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -571,6 +571,29 @@ static int ffa_memory_reclaim(u64 g_handle, u32 flags)
>         return 0;
>  }
>
> +static int ffa_features(u32 func_feat_id, u32 input_props, u32 *if_props)
> +{
> +       ffa_value_t id;
> +
> +       if (!ARM_SMCCC_IS_FAST_CALL(func_feat_id) && input_props) {
> +               pr_err("%s: Invalid Parameters: %x, %x", __func__,
> +                      func_feat_id, input_props);
> +               return ffa_to_linux_errno(FFA_RET_INVALID_PARAMETERS);
> +       }
> +
> +       invoke_ffa_fn((ffa_value_t){
> +               .a0 = FFA_FEATURES, .a1 = func_feat_id, .a2 = input_props,
> +               }, &id);
> +
> +       if (id.a0 == FFA_ERROR)
> +               return ffa_to_linux_errno((int)id.a2);
> +
> +       if (if_props)
> +               *if_props = id.a2;

w3 (id.a3) also contains a value when querying for
FFA_MEM_RETRIEVE_REQ. I see that in "[PATCH 5/9] firmware: arm_ffa:
Use FFA_FEATURES to detect if native versions are supported" you're
using this function with if_props = NULL. So I guess that at the
moment we have more than needed, but in case you need to add another
parameter to this function you'll need to update all the call sites
too.

Cheers,
Jens

> +
> +       return 0;
> +}
> +
>  static u32 ffa_api_version_get(void)
>  {
>         return drv_info->version;
> --
> 2.37.2
>
