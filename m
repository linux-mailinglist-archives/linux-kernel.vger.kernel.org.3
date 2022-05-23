Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C042530D45
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiEWKTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiEWKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:19:09 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1204927B
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:19:08 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id m12so12678925plb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0CyjIkmjSrjOaXJYGsS+V/Qn1NDSOVv5w9zr7GUbHlc=;
        b=gzKVMoorpR6IdJinck/RoryW2gKB2OEhRG2p4kXDZKkOFdBZUEhu/otJ7HzgUycNnV
         IZpv2IJQXHyJ8+LrkOYtMM8CoTjqRiEajtf6HwvuvKaaixkZfH4ngo18AYC63ZRBroRU
         RRRFHw/13sVoooSzLACteDnXQxbEcSDNBDcgHVvESEA/2gMQROVna+RVjPr41gGXYZYG
         X9Ci3Uo9hm9ZPtyQKanNHVX4AwuD2QXK8YHasD9hWnw9dPo+BGyvB91KA2oMHO4u74BT
         uE/MV956EPnpmTkT6lcqRnjckzsHkO4e954E0q1RJbMqeEfp5hHnNw3JYEi91bivHJVg
         ZrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0CyjIkmjSrjOaXJYGsS+V/Qn1NDSOVv5w9zr7GUbHlc=;
        b=vMiEJbiZUKEusqtEFl+k3AG3QVd2SBU4CC5tblrfLwtAZYxWATRDR3mKarGvIMp+gU
         5dT3DZyjycjBs+2zOPhSgxeK5/BfRkpwzaLhBZgwWqwrLOyy/l/aoqkeXCaV0jIAGI7e
         kPRMuFWrDopNuDUcduvVrQEg8NgFlUk6c6HqTNbgXqfAS7msk/ANegrud/xHBVd0muUE
         jnRJNZF5Qn0VZUystNORXx0sc+9Gl9QD02yKuO7a3WlnvRDWIw4h7U52MRekMW1NQYB0
         jNqYCCIZLyaMyJseSetHIAC623C6rFGAalbRbcWAmBRTxDn871iM4xGuQao3AE/eKY4z
         wSmg==
X-Gm-Message-State: AOAM532+r17l59ehqFA9YKf+VuOvCbhrx5oQth+zc0oVwHPVWFrt3irR
        rjmWKfpmKajsKvPOI081O1uqfp0OPPjBInStttMsVQ==
X-Google-Smtp-Source: ABdhPJycDO/uIQRYRr+lI/PxhhCnGXzW7+fIgAwfVEU7zWquWWx3S9cUEzxOwctgoHY0fbop9EYOiJW112ALZAvCohY=
X-Received: by 2002:a17:903:1c6:b0:161:9fbc:5a6 with SMTP id
 e6-20020a17090301c600b001619fbc05a6mr22184014plh.65.1653301148137; Mon, 23
 May 2022 03:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220511012612.3297577-1-jstultz@google.com> <20220511012612.3297577-2-jstultz@google.com>
In-Reply-To: <20220511012612.3297577-2-jstultz@google.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 23 May 2022 12:18:57 +0200
Message-ID: <CAG3jFyvHkZ6n5yYR6mW_oMLDeEGG9FpfCxyn+Pjo-APSKR6-PQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: lt9611: Use both bits for HDMI sensing
To:     John Stultz <jstultz@google.com>
Cc:     linux-kernel@vger.kernel.org, Yongqin Liu <yongqin.liu@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Peter Collingbourne <pcc@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        kernel-team@android.com
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

On Wed, 11 May 2022 at 03:26, John Stultz <jstultz@google.com> wrote:
>
> In commit 19cf41b64e3b ("lontium-lt9611: check a different
> register bit for HDMI sensing"), the bit flag used to detect
> HDMI cable connect was switched from BIT(2) to BIT(0) to improve
> compatibility with some monitors that didn't seem to set BIT(2).
>
> However, with that change, I've seen occasional issues where the
> detection failed, because BIT(2) was set, but not BIT(0).

I was waiting for a review or testing from a previous lt9611
committer, but seeing as how functionality is being re-introduced in
this patch I think a code review is all that's needed.

>
> Unfortunately, as I understand it, the bits and their function
> was never clearly documented. So lets instead check both
> (BIT(2) | BIT(0)) when checking the register.
>
> Cc: Yongqin Liu <yongqin.liu@linaro.org>
> Cc: Amit Pundir <amit.pundir@linaro.org>
> Cc: Peter Collingbourne <pcc@google.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Robert Foss <robert.foss@linaro.org>
> Cc: kernel-team@android.com
> Fixes: 19cf41b64e3b ("lontium-lt9611: check a different register bit for HDMI sensing")
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
> index bf66af668f61..a11604a56e08 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
> @@ -584,7 +584,7 @@ static enum drm_connector_status __lt9611_detect(struct lt9611 *lt9611)
>         int connected = 0;
>
>         regmap_read(lt9611->regmap, 0x825e, &reg_val);
> -       connected  = (reg_val & BIT(0));
> +       connected  = (reg_val & (BIT(2) | BIT(0)));
>
>         lt9611->status = connected ?  connector_status_connected :
>                                 connector_status_disconnected;
> --
> 2.36.0.512.ge40c2bad7a-goog
>

I reviewed this series and it looks good.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

Applied to drm-misc-next.
