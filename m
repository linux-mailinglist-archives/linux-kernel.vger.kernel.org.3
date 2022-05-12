Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63315250F5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355753AbiELPME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355759AbiELPKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:10:54 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5990627CF4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:10:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c12so6609711edv.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CLayYmfjkhcAMg8+8D2BY7rGeeiUMg34h820M4oj538=;
        b=VPP3gLLeF4MsNjONZX20D0qECvCgMzDr/5BarO8M+QHDbT9F5GNFmOArZlZmpzFdG0
         TXPBEolFTiiouK+wbBblSCABFom5RMZOmlPPEGXwSjZAm0sJgeWREmnkns6WFJfjekOV
         NAyCPZ+GlathNET+WBdpkMN9yxVOjZBLiUnhlSSGOGTQHDt+TrdoXgBRAt51wZyHTyRq
         IjC9t554stlsG9/g4B3HLzW+Lv8LCsMztExZcmo2vtQEqQrJqLKEZXhLIEydnif/7RWK
         c2OiX6gZAUp+Ru4D5mNaHjlikY6TWKkdhNmmk6JFU9ZbUAkjSCcOfik52vmudTUjPNGq
         HFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLayYmfjkhcAMg8+8D2BY7rGeeiUMg34h820M4oj538=;
        b=XcJ4qMFlmvrztY7Hx2SZgEOOZmBHn4AiX733uRpAKazn8NgrY+STmaVwCjwlNPYLuB
         AM1cd2MUafKOZV7Exccfp6UlHDUQXf/UOj5LAVVbZJfokfqsr3qG3L7PTWc30SiA8F1f
         x75PdS30PpBjXo6FW6qAlW5zLQaTyOFudvpUuBVixuKNTWq8yStIQXYUE8Fr1tt6B/5B
         4zf0iJsES3GG7v83Qv1Pr2W7ZRLpXVSYvDiRxcMIB38+h5ep4ndDQxRVQn89qQysxFuI
         N0dUZlqWqmBexWC8ppV5RUdw8ZSJujwosg76yDjWtzAlsf/RX7YCsJFHb/TdCGzFVxy1
         Ppvw==
X-Gm-Message-State: AOAM532UjJyK/4HABeYg5YDPMULSRsxSGAB5QQ/z66KTeaKCa+tmGJwJ
        j1UMT9NdG7r3T//OC52cr9WYXFU0Ku0xMtK4Z767dA==
X-Google-Smtp-Source: ABdhPJyTJELgoNqWKtKc/a0Pq3BIgBopqi4EtQVTw75F8NJKDSHOkrQaZCuY63irAg0w41nA9fSJXqT4rvMVcGPVPL4=
X-Received: by 2002:a05:6402:43c4:b0:41d:9403:8dca with SMTP id
 p4-20020a05640243c400b0041d94038dcamr35277391edc.184.1652368249576; Thu, 12
 May 2022 08:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220512083627.885338-1-tzungbi@kernel.org> <20220512083627.885338-4-tzungbi@kernel.org>
In-Reply-To: <20220512083627.885338-4-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 12 May 2022 08:10:38 -0700
Message-ID: <CABXOdTf1Hk3mZMrVGLxQfkBuoJ=bL-yprNtphZLRQu8zvt2U_g@mail.gmail.com>
Subject: Re: [PATCH 3/6] platform/chrome: cros_ec_proto: drop BUG_ON() in cros_ec_prepare_tx()
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
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

On Thu, May 12, 2022 at 1:36 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> It is overkill to crash the kernel if the given message is oversize.
>
> Drop the BUG_ON() and return -EINVAL instead.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 2d6d3fbfa905..9ce3374846ff 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -60,7 +60,8 @@ static int prepare_packet(struct cros_ec_device *ec_dev,
>         int i;
>         u8 csum = 0;
>
> -       BUG_ON(msg->outsize + sizeof(*request) > ec_dev->dout_size);
> +       if (msg->outsize + sizeof(*request) > ec_dev->dout_size)
> +               return -EINVAL;
>
>         out = ec_dev->dout;
>         request = (struct ec_host_request *)out;
> @@ -176,7 +177,9 @@ int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
>         if (ec_dev->proto_version > 2)
>                 return prepare_packet(ec_dev, msg);
>
> -       BUG_ON(msg->outsize > EC_PROTO2_MAX_PARAM_SIZE);
> +       if (msg->outsize > EC_PROTO2_MAX_PARAM_SIZE)
> +               return -EINVAL;
> +
>         out = ec_dev->dout;
>         out[0] = EC_CMD_VERSION0 + msg->version;
>         out[1] = msg->command;
> --
> 2.36.0.512.ge40c2bad7a-goog
>
