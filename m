Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B4A5783BC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiGRNco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiGRNcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:32:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50463A2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:32:41 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g1so15265157edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxdmslAnS6b+ZgeZcdk+CdUgW+Roq4pJkkdHVyVREms=;
        b=We7MIscdIRrGZnQLQX8w+SEF3MfAlePBkfPD/sTbPkMRd2CWtVSsYpqCIV0oFQYcAI
         ecYRTpYR4EBcl1gIQfQmiE9/fa127fmNDnsl9T1wy/Ez6dGaTORreRb2J5xG8LAdIs/m
         unMRQm/NWq0E9UqXwFs7GEvq/34P+p8GrysMCaIDh1kYxQYzNH/KNXg19tm9K7tncTA9
         S4d9vMs8V0D9jIpZ0RVuTV8EQmTmk+cGKnce8jR3gNlQMGNPJaflQ1I0ZeArhNGWtDHR
         E82iKkc6KdArXlms2mypCriKfow8qo3ZpCgwfQHuDY/V5lekGlFst5fP32UWOogv5Z50
         627A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxdmslAnS6b+ZgeZcdk+CdUgW+Roq4pJkkdHVyVREms=;
        b=CLZ4L5aLhrh1nMxbXnd8cITZpp+S60DWhUfJnnciTMU+yyZBitcKCe06VPvaZsqV59
         YvHV/uEnKWxDHXN7lkycLWrdHFt25EKAhBT6YICKNYAabMyFS+wCT6cqfkrGK9xuEeKA
         dZdO+aUUuOBgjXbuATDPODSzU8PGyWVWdct9lIrLqdcJDRtH+mJ7IdNKPiQPDxaZVwEf
         6amBCv3VH2ngX/SGFca87lJ3V9CMGPN2uyLMoTA4KFM0NGik9l+S9aqVKjDu4UVuvEWI
         +YjDLKXSmzCGaHnW+Cawgjjk4WZ49AOTvB0sSludEdAoSTETh4DL2wVOaLfcnz5fgdmR
         /kKA==
X-Gm-Message-State: AJIora9C9kukGPZJHVJuzYPYIG7dHNLw2eFfmIqPhEvHtuqjSa68PhrZ
        l3DtjslxBTShXdb7DWm0U0VJIl/GKLgZSNp5adRQqCOoxy4=
X-Google-Smtp-Source: AGRyM1tdaHrL02Liizfy/WoYUlXnVDHpuTmmw6s3M3yjcUJL+oyZoOCmrc1wlxobAns/7gkPGV6zySCd9JEMaVKVg/Y=
X-Received: by 2002:aa7:d389:0:b0:43a:56c0:c863 with SMTP id
 x9-20020aa7d389000000b0043a56c0c863mr37005948edq.373.1658151160318; Mon, 18
 Jul 2022 06:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220718050914.2267370-1-tzungbi@kernel.org> <20220718050914.2267370-7-tzungbi@kernel.org>
In-Reply-To: <20220718050914.2267370-7-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 18 Jul 2022 06:32:29 -0700
Message-ID: <CABXOdTcaJg4NgO1WSxoQHVK84qdDg53RgiWSvvTSX2RSokNFTQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] platform/chrome: cros_ec_proto: separate cros_ec_wait_until_complete()
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 10:10 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
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

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> Changes from v1:
> - Allocate buffer in cros_ec_wait_until_complete() statically.
> - Use `return ret` instead of `break` to make the intent explicit.
>
>  drivers/platform/chrome/cros_ec_proto.c | 74 ++++++++++++-------------
>  1 file changed, 35 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 0cec013be3d3..a6ad7f7956e6 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -134,56 +134,52 @@ static int cros_ec_xfer_command(struct cros_ec_device *ec_dev, struct cros_ec_co
>         return ret;
>  }
>
> -static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
> +static int cros_ec_wait_until_complete(struct cros_ec_device *ec_dev, uint32_t *result)
>  {
> -       int ret = cros_ec_xfer_command(ec_dev, msg);
> +       struct {
> +               struct cros_ec_command msg;
> +               struct ec_response_get_comms_status status;
> +       } __packed buf;
> +       struct cros_ec_command *msg = &buf.msg;
> +       struct ec_response_get_comms_status *status = &buf.status;
> +       int ret = 0, i;
>
> -       if (msg->result == EC_RES_IN_PROGRESS) {
> -               int i;
> -               struct cros_ec_command *status_msg;
> -               struct ec_response_get_comms_status *status;
> +       msg->version = 0;
> +       msg->command = EC_CMD_GET_COMMS_STATUS;
> +       msg->insize = sizeof(*status);
> +       msg->outsize = 0;
>
> -               status_msg = kmalloc(sizeof(*status_msg) + sizeof(*status),
> -                                    GFP_KERNEL);
> -               if (!status_msg)
> -                       return -ENOMEM;
> +       /* Query the EC's status until it's no longer busy or we encounter an error. */
> +       for (i = 0; i < EC_COMMAND_RETRIES; ++i) {
> +               usleep_range(10000, 11000);
>
> -               status_msg->version = 0;
> -               status_msg->command = EC_CMD_GET_COMMS_STATUS;
> -               status_msg->insize = sizeof(*status);
> -               status_msg->outsize = 0;
> +               ret = cros_ec_xfer_command(ec_dev, msg);
> +               if (ret == -EAGAIN)
> +                       continue;
> +               if (ret < 0)
> +                       return ret;
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
> +               *result = msg->result;
> +               if (msg->result != EC_RES_SUCCESS)
> +                       return ret;
>
> -               kfree(status_msg);
> +               if (!(status->flags & EC_COMMS_STATUS_PROCESSING))
> +                       return ret;
>         }
>
>         return ret;
>  }
>
> +static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
> +{
> +       int ret = cros_ec_xfer_command(ec_dev, msg);
> +
> +       if (msg->result == EC_RES_IN_PROGRESS)
> +               ret = cros_ec_wait_until_complete(ec_dev, &msg->result);
> +
> +       return ret;
> +}
> +
>  /**
>   * cros_ec_prepare_tx() - Prepare an outgoing message in the output buffer.
>   * @ec_dev: Device to register.
> --
> 2.37.0.170.g444d1eabd0-goog
>
