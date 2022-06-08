Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A372254389F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245244AbiFHQPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245245AbiFHQPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:15:10 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103B71339CC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:15:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id n28so27776615edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 09:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tbbr8cqlM6JP1/EQV/OxwLpk923WPZfF3f3/reyY39c=;
        b=pVryUjmwn4whBpZYVa57ovLNVPxnEQjKuBNPxsdoHbh7hmx0ZFuQFGABiVHN6oMoI3
         i4BRyjnH8n35ss+AkcXl4HIqx7Qk8R9+EdAJpoIIFIpxohXUfPTOCQrkOj9tNSaLaPWu
         tE6TZRJEzqsmnLTJNjrMtlQNAEV63ot8l/Z5FnHab3UxlxnbsETap47NCzjPFf4TDMrN
         +COlv0NWE7zzwjENxT/7Hx2pynkKhnUs+hWkeZP4CCHcJzKfKOdiZ/F00W7DH0pHjc5d
         yV9lMLhTd2pwMuEoiznqCtK+agVcEIR/9TF4LwXnuuJAMs8s6Anaoge6sLstwdF8xZm9
         qYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tbbr8cqlM6JP1/EQV/OxwLpk923WPZfF3f3/reyY39c=;
        b=KRZV/ZFTtDTfP5zONv67//XqEipdjUDuwRwbaLAPUMb+HzXL/lEncWgYUHQpebkhpq
         Vuo4WRXOn5om314jKRmNuAIz4GmgV1L9u3iEge+nSkw1Yof9ad2TeYQzpA3xDdhoF144
         5P+7PzuvRgDWv7j5F7YlkxBeAKT8eJVc7jVHCz2JJl8sFeLrz7Jx0cf4tCAfx+5grc0I
         AZxM4zPi4EiD6YgDWeoFzhM2kTuHJh3w4dBEHmKB/Y4edrY7RI+93lhlJeA+75vcqlk2
         gGoNMboIBtF2BUTJJfG8rlNmE9s64/AekdIjdSDwJ6W5221V56Vhhuyx7ltjhhudJXs+
         NCRw==
X-Gm-Message-State: AOAM532wWgPwPg0iPjnQeXnDJ6exD/JJ8hQtqAgz3mdosnqP7nNExGwx
        0fZmsF9R+DqN4EKUTT0XitdZov2bFRdPsKfebq5MhA==
X-Google-Smtp-Source: ABdhPJzChkltkDWfRpxI27D6Nsqy515FN2xdSfY/pUuD3QpNiIPD4LAFMwKEyLcTtg9MSMfDidj2HIYO1A0YcdTM1x4=
X-Received: by 2002:a05:6402:350e:b0:42f:b2c1:9393 with SMTP id
 b14-20020a056402350e00b0042fb2c19393mr29766337edd.11.1654704907120; Wed, 08
 Jun 2022 09:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220608110734.2928245-1-tzungbi@kernel.org> <20220608110734.2928245-13-tzungbi@kernel.org>
In-Reply-To: <20220608110734.2928245-13-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 8 Jun 2022 09:14:56 -0700
Message-ID: <CABXOdTemMhLvQ_N0fgQ=VH9JgxGxnYy1DHrZx=SFFu4dxsT4iA@mail.gmail.com>
Subject: Re: [PATCH v3 12/23] platform/chrome: cros_ec_proto: handle empty
 payload in getting info legacy
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
> cros_ec_get_proto_info_legacy() expects to receive
> sizeof(struct ec_response_hello) from send_command().  The payload is
> valid only if the return value is positive.
>
> Return -EPROTO if send_command() returns 0 in
> cros_ec_get_proto_info_legacy().
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>


> ---
> Changes from v2:
> - Separate Kunit test to another patch.
>
>  drivers/platform/chrome/cros_ec_proto.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 04b9704ed302..473654f50bca 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -356,7 +356,7 @@ static int cros_ec_get_proto_info_legacy(struct cros_ec_device *ec_dev)
>         struct cros_ec_command *msg;
>         struct ec_params_hello *params;
>         struct ec_response_hello *response;
> -       int ret;
> +       int ret, mapped;
>
>         ec_dev->proto_version = 2;
>
> @@ -377,12 +377,18 @@ static int cros_ec_get_proto_info_legacy(struct cros_ec_device *ec_dev)
>                 goto exit;
>         }
>
> -       ret = cros_ec_map_error(msg->result);
> -       if (ret) {
> +       mapped = cros_ec_map_error(msg->result);
> +       if (mapped) {
> +               ret = mapped;
>                 dev_err(ec_dev->dev, "EC responded to v2 hello with error: %d\n", msg->result);
>                 goto exit;
>         }
>
> +       if (ret == 0) {
> +               ret = -EPROTO;
> +               goto exit;
> +       }
> +
>         response = (struct ec_response_hello *)msg->data;
>         if (response->out_data != 0xa1b2c3d4) {
>                 dev_err(ec_dev->dev,
> --
> 2.36.1.255.ge46751e96f-goog
>
