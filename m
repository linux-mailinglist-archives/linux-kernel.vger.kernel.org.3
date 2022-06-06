Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9756753EB7D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241326AbiFFPzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241068AbiFFPz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:55:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3502235B19
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:55:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gl15so15946621ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OyTbKzsjMWwUwZL5SRg35VIyuSrvd4hrhHdZpr2aEOY=;
        b=HsN12eaSchfRAga+qrLk/zwMDjiloHPOIo6tuhJQY/CZwhGJzq00ySOnbBVrq4SeQg
         lZIjFoT51lIlA0y/Fc+X/b7883LNAAm87aDcZFKQHK2qFVo6cm9iqc6yrjIA/suhhB85
         KgMbqKUo+cHvvhldTv8YohG9sCt/OilC6hL0xnr2yA1y8aP+z0q6qW35v2O6ApvKgXRb
         8Ee4EsJmhEd9kT+Mbba3IOds0L5VUbhsdbSbyfQ/nbe26uGpGB2eEv385NkEMguy/kUf
         o9Ru9uuSRyZxRsxxWznhiIZvSE69Z8jpIXmvw3fAvtqgV1ZaSI1Fs+KWLrdcpaJwZojL
         9QLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OyTbKzsjMWwUwZL5SRg35VIyuSrvd4hrhHdZpr2aEOY=;
        b=XudP2kYaKe+WQdu4CdptzS95+qPQsLM3IYuS0o363elRNB0Dhz5gMXq7OaArQ0R5xX
         KJzhkTnL6yu+iAoVvhOnzCi8sim1Fso6+pvtA/+HfzwbV+GMp1XZ7C/zqf5stkzGv73m
         t93rLFawTXXlI5Nn1utPDqbkZmLVrvPPDbOtm5sm6RanBj4KXSPJ0tkgLVH9Qhv29Fy0
         kg36NKVY1vOFpat4EXdOv071ZgVvV20xQCLZA4AGE5MuwoTZyM6SLqCaypcsWErhksRk
         sXf87/Uil89bB1GJeAo+3QZyzLtr4YLVGaDHb8Z6h82Lla/lIjO6lBgW27WFFBzjwBaL
         nwhg==
X-Gm-Message-State: AOAM533pov/76Byv+bK1/tJIBtTPYvHb3YDjZm9/ndUE6UzsqtY70hiS
        kUNv+KTxnkl8TcOKpCoIR6DrrI9bpO6h5IIKlYABsg==
X-Google-Smtp-Source: ABdhPJz3Mq3IMfcDu/Cuub9xOBDyP5zz4COVAFXlmMtrZ+GAOmJ3s3a7/vHwxn8jk+cf8QeW7HW+CGV4YBCJOc7LkK8=
X-Received: by 2002:a17:907:1ca8:b0:70c:68ce:dade with SMTP id
 nb40-20020a1709071ca800b0070c68cedademr19254581ejc.723.1654530925293; Mon, 06
 Jun 2022 08:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220606141051.285823-1-tzungbi@kernel.org> <20220606141051.285823-7-tzungbi@kernel.org>
In-Reply-To: <20220606141051.285823-7-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 6 Jun 2022 08:55:14 -0700
Message-ID: <CABXOdTdhGYhS=qO7M5OQ9GDv7LEUQTzrpEkYwas+VfomxDaUcw@mail.gmail.com>
Subject: Re: [PATCH 06/13] platform/chrome: cros_ec_proto: use cros_ec_map_error()
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
> Use cros_ec_map_error() in cros_ec_get_host_event_wake_mask().
>
> The behavior of cros_ec_get_host_event_wake_mask() slightly changed.  It
> is acceptable because the caller only needs it returns negative integers
> for indicating errors.  Especially, the EC_RES_INVALID_COMMAND still
> maps to -EOPNOTSUPP.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 1b851dcd20c9..71ba6a56ad7c 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -247,7 +247,7 @@ static int cros_ec_get_host_event_wake_mask(struct cros_ec_device *ec_dev,
>                                             uint32_t *mask)
>  {
>         struct ec_response_host_event_mask *r;
> -       int ret;
> +       int ret, mapped;
>
>         msg->command = EC_CMD_HOST_EVENT_GET_WAKE_MASK;
>         msg->version = 0;
> @@ -256,10 +256,9 @@ static int cros_ec_get_host_event_wake_mask(struct cros_ec_device *ec_dev,
>
>         ret = send_command(ec_dev, msg);
>         if (ret >= 0) {
> -               if (msg->result == EC_RES_INVALID_COMMAND)
> -                       return -EOPNOTSUPP;
> -               if (msg->result != EC_RES_SUCCESS)
> -                       return -EPROTO;
> +               mapped = cros_ec_map_error(msg->result);
> +               if (mapped)
> +                       return mapped;
>         }
>         if (ret > 0) {
>                 r = (struct ec_response_host_event_mask *)msg->data;
> --
> 2.36.1.255.ge46751e96f-goog
>
