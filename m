Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09DF53EABC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbiFFPYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240469AbiFFPYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:24:35 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92332B4595
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:24:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id s12so22429582ejx.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LkVR1NuQxjBXrvEq17FZVgpSOEkLzSQoABYmEhvkVmQ=;
        b=CaTMDhM8HArxhiM8wuEqYHguZd+Ow22R1fzwTFrTbpk5PuHjMdCTcfeVrzdHIBRYSW
         yQNBz17J5+HBN+JQkvdk3ejN61UBjSKi8HGWzdDLxf7gpdfUKwE+ucqdU6his7L0ZH2k
         A21jL8g4RkA9McGN05TmIXlJWekmGVckhdO8Dw04vJtoZhmIuWa+pd+axtIYooJ68K2a
         G9VYdMM/w9Uzgul5i1HfXU/AAHIbg4fhtv3hz55FfvkYzgRcJQ4FXjFmVwTDFOZjgSQS
         Q3teYiu6BRLeqyvOE2ZQd6AsRq3y5OaXApsexu0doVKJNt3+VAU9BR5H05k0eEJuW6pQ
         BXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LkVR1NuQxjBXrvEq17FZVgpSOEkLzSQoABYmEhvkVmQ=;
        b=OQEmeXGMgCw04nN0F2QNSzkD0ixwSKFcL3rN0lLl/iGogaX9c8+BF/MFOo2Kd3PqdY
         VObxXlgAiSQynD39Ee4BNwduoYc9fvR6pK5Ycv61D93aAqWWIdTWjAnSRTqvWD/+7c+p
         Ju0uBQg6JVaWimZgYdQ9UyRVHWXQcNfNT2TQ30AKxl6fHxLbUcwSS0cmXGLk1Bna0l2k
         nWbikw4ViL4dR0vnlnmbnrAThKkMhzWBPUaGQVDxsVBgWWOvqvTnicorjvyeo7ChhxsE
         kLO3ksD88AL4bP8+4E3vyP6yDOHUCZ1H09DX8qsJ8xNCub2k17T2CZbxkWzkfT7UWazV
         TBFw==
X-Gm-Message-State: AOAM532+VXS8weoJD604qjZKkG8PSXnvdoKy9Bg821aIuFUsgSxSTkW3
        vbVDAV2fqGBb8HFInYsHnN5w8ZlHtCVUhp38C5moDa3ncLeVLg==
X-Google-Smtp-Source: ABdhPJzahMapjCZ5wlUS2CyFN/NKvEDW1VCntlLo+6OrHYcPoPQkb3UsOtXoGGy5JESgoznkiN29l7/0VlFZ9Wk5PgY=
X-Received: by 2002:a17:906:4d50:b0:70d:afd4:1e63 with SMTP id
 b16-20020a1709064d5000b0070dafd41e63mr17459197ejv.618.1654529071847; Mon, 06
 Jun 2022 08:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220606141051.285823-1-tzungbi@kernel.org> <20220606141051.285823-5-tzungbi@kernel.org>
In-Reply-To: <20220606141051.285823-5-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 6 Jun 2022 08:24:20 -0700
Message-ID: <CABXOdTfoX+U=RWmnCha_9LuVcyhcz53MifuQwox8wQs6kangwg@mail.gmail.com>
Subject: Re: [PATCH 04/13] platform/chrome: cros_ec_proto: assign buffer size
 from protocol info
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

On Mon, Jun 6, 2022 at 7:12 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> `din_size` is calculated from `ec_dev->max_response`.
> `ec_dev->max_response` is further calculated from the protocol info.
>
> To make it clear, assign `din_size` and `dout_size` from protocol info
> directly.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 65191af5139c..629dce3e6ab3 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -449,12 +449,8 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>                         "using proto v%u\n",
>                         ec_dev->proto_version);
>
> -               ec_dev->din_size = ec_dev->max_response +
> -                       sizeof(struct ec_host_response) +
> -                       EC_MAX_RESPONSE_OVERHEAD;
> -               ec_dev->dout_size = ec_dev->max_request +
> -                       sizeof(struct ec_host_request) +
> -                       EC_MAX_REQUEST_OVERHEAD;
> +               ec_dev->din_size = proto_info->max_response_packet_size + EC_MAX_RESPONSE_OVERHEAD;
> +               ec_dev->dout_size = proto_info->max_request_packet_size + EC_MAX_REQUEST_OVERHEAD;
>
>                 /*
>                  * Check for PD
> --
> 2.36.1.255.ge46751e96f-goog
>
