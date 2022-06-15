Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE15F54D2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbiFOUup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346441AbiFOUum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:50:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E0E54FBA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 13:50:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x62so17871000ede.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 13:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ZXBUIxqBm6uyxBilji48aCf+mfxOLYDgSX9YlArqBA=;
        b=AFFih5W0o5aUzvDXTiceCSYg5SE+KN4Yx/De279r5ciZaqpBDyOcqdcdiC/LzqV8X7
         PnPCsy33DMFoDcZ7lX5DenjOwjeThgwf0pGPiQEXOQItddk3Tlgedzx2cbX0jUNvLB3w
         sQ1VEU9OpHcvPRde5hjUjGOVAQf2t6G+9qNUpMIfhW+FWNkET5vk2prshkwnufPPgtnE
         XjynoDPD6y9WLVXlrYy1kvocieuQnhn8FhZUbWJo6uHGqHanWuzqhopJrvo8sUzSSex5
         W16BuQjhUbt4tVZ3SaoojwtiDamYTkHE5UnPO7ToVWD+YS+3Vur7hYHI99lH3fYB7luI
         KBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ZXBUIxqBm6uyxBilji48aCf+mfxOLYDgSX9YlArqBA=;
        b=FoOrBrNeSPMuPvLrdmjVs9c3JBL3T8m5mULZKjBedOxYohHIz19tTsnShpLEyDOVgB
         c+AIfF/ThVThVOFc4MvoOAopBbIsOgHSaPXZy2YbOpjKORfMpy9C5i00+iO22rnBMef9
         rBKBBS56Fo3Dxz6yn34/XU5yoV5G4TH3u21qaHqw1x57BgWsRd3P4B1xoK6D4O5cfG/h
         h8/UIDP4q8B8JQ+qqg5ethhopScb4vW0lXC4C5saVTVyPvoj1eD0g4Yp6Q0QWyATzLu3
         BGrfEi0jFcpznoz4Nsguro+J1zGZcieBo1ChVdDWgEPiQGkS2Zf59BAePxzRVPIMdfiV
         gqjQ==
X-Gm-Message-State: AJIora8Lz7UXKx/Y+3InYqQQhWVrOl9Jj49KJebbzUs5SdhsMVYLunH2
        RxwcdoTV242vRGq7MkorhRoSQleJ0ADin5P5jHsGIg==
X-Google-Smtp-Source: AGRyM1ssS+sc685rYaHH2KgSnyCXAfvHgnC+e/hU1VF6fIg3/zRUdW2cKIeWjcO13qpLymSmg3T/6J3aZ8/+k+qRu8Q=
X-Received: by 2002:a05:6402:3688:b0:42d:d3ba:4725 with SMTP id
 ej8-20020a056402368800b0042dd3ba4725mr2144623edb.212.1655326237916; Wed, 15
 Jun 2022 13:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220615051248.1628156-1-tzungbi@kernel.org> <20220615051248.1628156-6-tzungbi@kernel.org>
In-Reply-To: <20220615051248.1628156-6-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 15 Jun 2022 13:50:26 -0700
Message-ID: <CABXOdTeYf=KsaMeEMOcevRjitvkLDKPeTELfDSmCxyG0OWWjgQ@mail.gmail.com>
Subject: Re: [PATCH 05/11] platform/chrome: cros_ec_proto: separate cros_ec_wait_until_complete()
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

On Tue, Jun 14, 2022 at 10:13 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> EC returns EC_RES_IN_PROGRESS if the host command needs more time to
> complete.  Whenever receives the return code, cros_ec_send_command()
> sends EC_CMD_GET_COMMS_STATUS to query the command status.
>
> Separate cros_ec_wait_until_complete() from cros_ec_send_command().
> It sends EC_CMD_GET_COMMS_STATUS and waits until the previous command
> was completed, or encountered error, or timed out.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  drivers/platform/chrome/cros_ec_proto.c | 75 ++++++++++++-------------
>  1 file changed, 36 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 0cec013be3d3..466ecb063bd6 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -134,53 +134,50 @@ static int cros_ec_xfer_command(struct cros_ec_device *ec_dev, struct cros_ec_co
>         return ret;
>  }
>
> -static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
> +static int cros_ec_wait_until_complete(struct cros_ec_device *ec_dev, uint32_t *result)
>  {
> -       int ret = cros_ec_xfer_command(ec_dev, msg);
> +       struct cros_ec_command *msg;
> +       struct ec_response_get_comms_status *status;
> +       int ret = 0, i;
> +
> +       msg = kzalloc(sizeof(*msg) + sizeof(*status), GFP_KERNEL);
> +       if (!msg)
> +               return -ENOMEM;
>
> -       if (msg->result == EC_RES_IN_PROGRESS) {
> -               int i;
> -               struct cros_ec_command *status_msg;
> -               struct ec_response_get_comms_status *status;
> +       msg->command = EC_CMD_GET_COMMS_STATUS;
> +       msg->insize = sizeof(*status);
>
> -               status_msg = kmalloc(sizeof(*status_msg) + sizeof(*status),
> -                                    GFP_KERNEL);
> -               if (!status_msg)
> -                       return -ENOMEM;
> +       status = (struct ec_response_get_comms_status *)msg->data;
>
> -               status_msg->version = 0;
> -               status_msg->command = EC_CMD_GET_COMMS_STATUS;
> -               status_msg->insize = sizeof(*status);
> -               status_msg->outsize = 0;
> +       /* Query the EC's status until it's no longer busy or we encounter an error. */
> +       for (i = 0; i < EC_COMMAND_RETRIES; ++i) {
> +               usleep_range(10000, 11000);
>
> -               /*
> -                * Query the EC's status until it's no longer busy or
> -                * we encounter an error.
> -                */
> -               for (i = 0; i < EC_COMMAND_RETRIES; i++) {
> -                       usleep_range(10000, 11000);
> -
> -                       trace_cros_ec_request_start(status_msg);
> -                       ret = (*xfer_fxn)(ec_dev, status_msg);
> -                       trace_cros_ec_request_done(status_msg, ret);

I'll have to spend more time on this; I don't immediately see (from
the diff) the replacement for the traces, and I don't see what
happened with xfer_fxn.

Guenter

> -                       if (ret == -EAGAIN)
> -                               continue;
> -                       if (ret < 0)
> -                               break;
> -
> -                       msg->result = status_msg->result;
> -                       if (status_msg->result != EC_RES_SUCCESS)
> -                               break;
> -
> -                       status = (struct ec_response_get_comms_status *)
> -                                status_msg->data;
> -                       if (!(status->flags & EC_COMMS_STATUS_PROCESSING))
> -                               break;
> -               }
> +               ret = cros_ec_xfer_command(ec_dev, msg);
> +               if (ret == -EAGAIN)
> +                       continue;
> +               if (ret < 0)
> +                       break;
> +
> +               *result = msg->result;
> +               if (msg->result != EC_RES_SUCCESS)
> +                       break;
>
> -               kfree(status_msg);
> +               if (!(status->flags & EC_COMMS_STATUS_PROCESSING))
> +                       break;
>         }
>
> +       kfree(msg);
> +       return ret;
> +}
> +
> +static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
> +{
> +       int ret = cros_ec_xfer_command(ec_dev, msg);
> +
> +       if (msg->result == EC_RES_IN_PROGRESS)
> +               ret = cros_ec_wait_until_complete(ec_dev, &msg->result);
> +
>         return ret;
>  }
>
> --
> 2.36.1.476.g0c4daa206d-goog
>
