Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809EA54389A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245233AbiFHQOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245217AbiFHQN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:13:59 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5D62C671
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:13:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id v1so31750729ejg.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 09:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OpAXdwZORFKOvufIunvkEJrAFgZQ4NyOlXoZC5h0a6c=;
        b=GJCPf0tMR5KB3tq7Gq+jOWVHZ2cU2+4uYOTuLelzQMdvxjByTt5ghKXjWHrT5QS13V
         86ZK1gL1SSML3H/VJI8zoFMPVRmNZ3mCVZ1S1eZ78ofZrBMXOYI5noo/sJDSxqSM+PZE
         wigVLL5OjMxYX5cKwqdS7EDmQrjYLHC7H4ahxV0vekgUeBk7BFSdcANbzkOUFVkQRpnm
         BscwDT5cHAGWXydy0U/F2QyVg66/SspdTcoRLognJcaKwezYd8Q7u+9g9J290mI9cBmL
         fqDSfjMHZuY/02kkjvb7Lr+TnTLFjk6jmU+O/sWd56hO08eVW+u3Pr7cmIT9OUHb144z
         dvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OpAXdwZORFKOvufIunvkEJrAFgZQ4NyOlXoZC5h0a6c=;
        b=7KmkPW7jmZlx/4e3a+NkTB99oA2ldk2PRF0peozwELMwK8hsDwW/Q75eVukNrRjwNN
         CccUcOOJT6fODyGst7qQvcyqqkmKjyYktBDv+mi9S7IQ/H1aLKa5Odsk4ab97kZtyugv
         MUWItM+2qemZ+0gOReEkCI3Hb7vfrGVfnyOoLsC5qGR+C6R0ZgIQpVQbBlc3JLoh3b1H
         Utarg0I7JCegyKbEpDrP+s8mguhwBMejbJFJAF/rNMntHHPhHC5TKN7XhTdNiqNkmdyv
         R9J/PPtE3NbBD7Y19WKMqQCwNvrF3cYJ+VONnnV3FfaFJtGqOxGwaUVWu6WnngxoG2jP
         johg==
X-Gm-Message-State: AOAM532ZuBIMAb1R9IvR3b+DmZDG5Eype5bNzaC1LnkVoYfho8/xQwvI
        e3lZihIhCUu4HRbYOVQUHG1FoqsrwDxP+KaXqvPLmw==
X-Google-Smtp-Source: ABdhPJzJ0AJJ9icMZPuUHYLgOB+vOx7hnBA7Vnp7/yXbm/rZI09fSn3FtoK1o3wfuzxV/p+RU41uXof455lUK5N+9EQ=
X-Received: by 2002:a17:906:85cb:b0:70b:ffb4:b0e with SMTP id
 i11-20020a17090685cb00b0070bffb40b0emr28556697ejy.533.1654704835154; Wed, 08
 Jun 2022 09:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220608110734.2928245-1-tzungbi@kernel.org> <20220608110734.2928245-10-tzungbi@kernel.org>
In-Reply-To: <20220608110734.2928245-10-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 8 Jun 2022 09:13:44 -0700
Message-ID: <CABXOdTe0+Zp2O-_S3fb3+T3J40BAxUDpSKkbQvoGw2xpw1cW6g@mail.gmail.com>
Subject: Re: [PATCH v3 09/23] platform/chrome: cros_ec_proto: handle empty
 payload in getting proto info
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
> cros_ec_get_proto_info() expects to receive
> sizeof(struct ec_response_get_protocol_info) from send_command().  The
> payload is valid only if the return value is positive.
>
> Return -EPROTO if send_command() returns 0 in cros_ec_get_proto_info().
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> Changes from v2:
> - Separate Kunit test to another patch.
>
>  drivers/platform/chrome/cros_ec_proto.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 893b76703da6..6f5be9e5ede4 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -314,6 +314,11 @@ static int cros_ec_get_proto_info(struct cros_ec_device *ec_dev, int devidx)
>                 goto exit;
>         }
>
> +       if (ret == 0) {
> +               ret = -EPROTO;
> +               goto exit;
> +       }
> +
>         info = (struct ec_response_get_protocol_info *)msg->data;
>
>         switch (devidx) {
> --
> 2.36.1.255.ge46751e96f-goog
>
