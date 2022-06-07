Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350665401A4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245747AbiFGOmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245741AbiFGOmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:42:06 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31F1DE301
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:42:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y19so35650230ejq.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 07:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tUW9diLTesI3roFry1o64Px5gNXnYkvb4K3Brj/FaUM=;
        b=bA8OX150j85ClhlKoLu/Q6RRRIfNsRqHm+iwi9htMQONv9TwxbRHzCvQxXKghpfdG7
         sVygQMXAJOQvnDTit6sHGOIsiCxOWZSvY4QW05XrpsUypxslSAGwPgUzNdiARBbQDSUK
         6bdi/WtcOPqcUV3Yt3VMxolq4lWl35bhWxxTd5uS7qZXRUz7dl5MhmMJFesKyJBL5jW6
         SzH6TqqKqzoS0pplV5LjhN2AaH9vLSRhQnvUwFhgM3a7xecy9K6fPX7bq2UngCsmt8Zu
         Mh5VMm//VFU2Bf2gqIN3z0qg+y086l7hfx1jeewU6MrME+0LpHjE9wR6h6aSv4Kq8oKI
         yoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tUW9diLTesI3roFry1o64Px5gNXnYkvb4K3Brj/FaUM=;
        b=tq+mmUQd2imOFAJqdpOZoLToSioAsElKjZluEYJUX3vveLLiH/WdkOWn9uhdVapJff
         Aemb68th567/vcbyW0OfFYvSPb6PgTM2FhiWHBXU4SwFyl8SGdf5RAa0haNaDUARrnWY
         ir7zhCvCNj3WZFJcBs8PN9u2YFqfgwBHzJgfa/Vtb4Y4oQVhbvr+39T84WPxXJnzjOCD
         gjD/Q2iYGGkqrzBU4RFeic2lBHbwt56cihN/eu2fFgP5RhYJStW6VfvGB0GvxgjV/jpY
         GhDAcT/Luia6IUcSH7sybY7yBkkzANmJC+RTa7x3JL6eiWGf/RSdZNVQARfjWXH1Te3o
         zcEQ==
X-Gm-Message-State: AOAM530W/GK+jKgJuC6OWJizHGdmXgnY1XSnhvpkoqC31ERUTub0pTJ0
        yS6dWkpkPtKJsFSCcpwYMsE3zgfDjq13nPGAMOggVg==
X-Google-Smtp-Source: ABdhPJx43dr01Y8Sr37Uf1HprEWxa+wFWjlbIRhi3oGCU79pp1EpiHwIhDXUEFTRNbQieHln3EPD7tSQ3i0LN75Q3NM=
X-Received: by 2002:a17:907:1ca8:b0:70c:68ce:dade with SMTP id
 nb40-20020a1709071ca800b0070c68cedademr24194819ejc.723.1654612923085; Tue, 07
 Jun 2022 07:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220606201825.763788-1-pmalani@chromium.org> <20220606201825.763788-4-pmalani@chromium.org>
In-Reply-To: <20220606201825.763788-4-pmalani@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 7 Jun 2022 07:41:51 -0700
Message-ID: <CABXOdTeQKPXs5GqGUDusp5S_w0W_Ewzfgge2+_H0nYmUQw3XVw@mail.gmail.com>
Subject: Re: [PATCH 3/3] platform/chrome: cros_ec_proto: Update size arg types
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>
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

On Mon, Jun 6, 2022 at 1:20 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> cros_ec_cmd() takes 2 size arguments. Update them to be of the more
> appropriate type size_t.
>
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto.c     | 4 ++--
>  include/linux/platform_data/cros_ec_proto.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index b6bea183ee28..cefabfe45551 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -958,9 +958,9 @@ int cros_ec_cmd(struct cros_ec_device *ec_dev,
>                 unsigned int version,
>                 int command,
>                 void *outdata,
> -               int outsize,
> +               size_t outsize,
>                 void *indata,
> -               int insize)
> +               size_t insize)
>  {
>         struct cros_ec_command *msg;
>         int ret;
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index 816da4eef3e5..85e29300f63d 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -232,7 +232,7 @@ bool cros_ec_check_features(struct cros_ec_dev *ec, int feature);
>  int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
>
>  int cros_ec_cmd(struct cros_ec_device *ec_dev, unsigned int version, int command, void *outdata,
> -                   int outsize, void *indata, int insize);
> +                   size_t outsize, void *indata, size_t insize);
>
>  /**
>   * cros_ec_get_time_ns() - Return time in ns.
> --
> 2.36.1.255.ge46751e96f-goog
>
