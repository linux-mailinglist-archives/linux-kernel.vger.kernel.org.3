Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68075438A2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245275AbiFHQQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245255AbiFHQQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:16:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5305A4B1D0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:16:09 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b8so11098725edj.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 09:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xj7h12UkZIB4SsfQQ+SZ6RUvCHFdGip3OqzBInEc28s=;
        b=su+DB+FEUDTr+F2VLRr+X1PXTruzq0D1wec0lhVPqBRoWsnVJ9fAC9K7QDoZ1RsTl8
         dUSLW1/g7MHRHilP/lspdCnDtksPo0tN1Fat08Wc316vzYXA86SZoccWJQdTQ3f6NMiA
         Y2LeATMewXgJug1Ocn77JxKWxbfpF7/YZ9H493mLQ4QfmsiwoIY0MdH+uZMGMvzP0mP2
         LoUfaJXAtvpvAJxc6/JAeGKRFoTBKCdXDomwtSVTeQZFlgy86+kCPORnI3SDSWVzR5o2
         rWGbgR5roMExQuHmTQqdwePDcM9aU8bS5nvi4G/mBPGP7DRcK4qQzWxTwQz9L8WJ0lxG
         I3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xj7h12UkZIB4SsfQQ+SZ6RUvCHFdGip3OqzBInEc28s=;
        b=4AGxawcXV93NDI6EION7OMx8rDRIYz1LzSjRn874+6n4XQ76iL3N24U40iGrPvmPHE
         AmgI6jaG4pro/LZgNqTpHzwIH+SvHbj1VhVJGR2yl9u+Mrt18RHKQQ7kkhf9zcVdvoBC
         fvmSthydmO9IkKGwGN5ddQ4jui59GH9fnnxcnuz4uEtrxsXhjZZ9+kazzSeeVFEzojub
         SdmkgtBVjFAgmn6vaGGSyhLcwzd3iyGmiEEdMgqG6lX4C2sbPeAFVcRNLPfuveYxmaN7
         4+lFrWBOVjeqsHG2m5DX0YSpnjpV2QMSIEbOKEZeYnA7EbfXFDdRTwjIOAiOUrfzsRa2
         uytw==
X-Gm-Message-State: AOAM533mGgeWVizVqIAniXURWOMVFLiZx/6c4iVKnIl2U78+fRWOMFqA
        lgNHCfCfEaNkC/E2pKMV/buNNEoz4Xj+0bLXXqHzNQ==
X-Google-Smtp-Source: ABdhPJxwfJ42pptzM92imvlryrZlItqv3Cbj/UxDQ72rgxDEHUTsEb1kqZ7cX9QGe1sEO/XMA/D3bkxzsaHFTTRk+ME=
X-Received: by 2002:aa7:c84d:0:b0:431:4226:70c9 with SMTP id
 g13-20020aa7c84d000000b00431422670c9mr23414709edt.51.1654704967667; Wed, 08
 Jun 2022 09:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220608110734.2928245-1-tzungbi@kernel.org> <20220608110734.2928245-14-tzungbi@kernel.org>
In-Reply-To: <20220608110734.2928245-14-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 8 Jun 2022 09:15:56 -0700
Message-ID: <CABXOdTegzx8Xpp3QPn8XyjLt1Rdr7ztkLcY53+vHmEEVKYSr4Q@mail.gmail.com>
Subject: Re: [PATCH v3 13/23] platform/chrome: cros_ec: don't allocate `din`
 and `dout` in cros_ec_register()
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 4:08 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> Don't allocate `din` and `dout` in cros_ec_register() as they will be
> allocated soon in cros_ec_query_all().
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> No change from v2.
>
>  drivers/platform/chrome/cros_ec.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index e51a3f2176c7..29d3b544dafb 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -188,14 +188,8 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>         ec_dev->max_passthru = 0;
>         ec_dev->ec = NULL;
>         ec_dev->pd = NULL;
> -
> -       ec_dev->din = devm_kzalloc(dev, ec_dev->din_size, GFP_KERNEL);
> -       if (!ec_dev->din)
> -               return -ENOMEM;
> -
> -       ec_dev->dout = devm_kzalloc(dev, ec_dev->dout_size, GFP_KERNEL);
> -       if (!ec_dev->dout)
> -               return -ENOMEM;
> +       ec_dev->din = NULL;
> +       ec_dev->dout = NULL;
>
>         mutex_init(&ec_dev->lock);
>
> --
> 2.36.1.255.ge46751e96f-goog
>
