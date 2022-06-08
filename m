Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7725438CC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245381AbiFHQXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245328AbiFHQXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:23:37 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17303EB92
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:23:36 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 25so27530112edw.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 09:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pH4epaydulKCzm3U0hT80dPoBBzbWjC5FDf9U06Ouz8=;
        b=tMTpHgPJK0KyZNMjbhcDWL+vqGFG2psfpD5M2hMow/ED0ef+1jqkEF2DPMcXDtg9AS
         0v+y4629bTKsvDEYpEJemWcGM8AwbP5sF8wEy+4mGUpTTeSeKHEXZf48b8dkyrmIXCUM
         DshaUPivp1CGYDKctrAgC0CP3WNoCJ+p/35s/nIudJalTXkOmw0IO/3COjzVMn1zLV0F
         ES8xpuQS481oxGbdY1RKg94oK8c/IMdydGSeOhy5aCD6A9zoxdcEMO04i3qz5BB/FxQ8
         kGPHfZFs10j1st2K9015vZgWp3q4xRP9cHxPZ50jGd+J2ug81VEalkABs9wZL5uskKTh
         3vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pH4epaydulKCzm3U0hT80dPoBBzbWjC5FDf9U06Ouz8=;
        b=Ig9T6nGQiaSy0M3EWZjKpe8t0hbUzPDCGb/QVWkl5d55mq0eSrGh3v3pLYn7cn7yVN
         O68EJH7g4NodS+Ch9M2Q8g3BQRGGFCEWep40d1XX4og7WvMJNhJcLCcSu8bKvUbRg2Gh
         IRaH3vgt1wDU6ZYbjkblbiYdJgXtcjLcy/E3163APHWttpe02rj4AbLdgY5vOrncR/1L
         CUV0904m7pIch4qNWGghnPV81Qz5YdW9vBmNfQANtugbR/IAnQYy0xIkVfcKQNgrFM/X
         mtyrSnxJsbKFVxN2FvtTVqzEQ4EOFew/YAR+10SfmWbTZJ5orGwtyeH/cD8WxA+DnIGq
         OaOw==
X-Gm-Message-State: AOAM531IyrJ3drTUsNh3fuKepj+XubSXy1D/Qv2HXiKEPjwJtpy1l2aT
        CKMdECPGw5P68FeaE+IOJVd2n14mL7gfjKYfMMclT1+58ouO5g==
X-Google-Smtp-Source: ABdhPJxurra4SbiWW25ogvhvTo8GI/+sQDJfMtYjH3WfGqpMoXwQFHkMqBfu4kaXiqns0Jj5Xl/Rak/TNkL80+JPotg=
X-Received: by 2002:a05:6402:2405:b0:431:6ef1:e2a with SMTP id
 t5-20020a056402240500b004316ef10e2amr16357932eda.26.1654705414971; Wed, 08
 Jun 2022 09:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220608110734.2928245-1-tzungbi@kernel.org> <20220608110734.2928245-19-tzungbi@kernel.org>
In-Reply-To: <20220608110734.2928245-19-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 8 Jun 2022 09:23:23 -0700
Message-ID: <CABXOdTdPwO6xv+DPcErZJcqZsLMMECcuk5MEYEpf4L3PYhSh7g@mail.gmail.com>
Subject: Re: [PATCH v3 18/23] platform/chrome: cros_ec_proto: check
 `msg->result` in getting cmd mask
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
> cros_ec_get_host_command_version_mask() should check if EC wasn't happy
> by checking `msg->result`.
>
> Use cros_ec_map_error() and return the error code if any.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> No v2.  New and separated from the original series.
>
>  drivers/platform/chrome/cros_ec_proto.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 06bc7db1213e..6a5771361383 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -428,13 +428,12 @@ static int cros_ec_get_proto_info_legacy(struct cros_ec_device *ec_dev)
>   * the caller has ec_dev->lock mutex or the caller knows there is
>   * no other command in progress.
>   */
> -static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
> -       u16 cmd, u32 *mask)
> +static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev, u16 cmd, u32 *mask)
>  {
>         struct ec_params_get_cmd_versions *pver;
>         struct ec_response_get_cmd_versions *rver;
>         struct cros_ec_command *msg;
> -       int ret;
> +       int ret, mapped;
>
>         msg = kmalloc(sizeof(*msg) + max(sizeof(*rver), sizeof(*pver)),
>                       GFP_KERNEL);
> @@ -450,14 +449,20 @@ static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
>         pver->cmd = cmd;
>
>         ret = send_command(ec_dev, msg);
> -       if (ret > 0) {
> -               rver = (struct ec_response_get_cmd_versions *)msg->data;
> -               *mask = rver->version_mask;
> -               ret = 0;
> +       if (ret < 0)
> +               goto exit;
> +
> +       mapped = cros_ec_map_error(msg->result);
> +       if (mapped) {
> +               ret = mapped;
> +               goto exit;
>         }
>
What if ret == 0 ? Is that valid ?

Thanks,
Guenter

> +       rver = (struct ec_response_get_cmd_versions *)msg->data;
> +       *mask = rver->version_mask;
> +       ret = 0;
> +exit:
>         kfree(msg);
> -
>         return ret;
>  }
>
> --
> 2.36.1.255.ge46751e96f-goog
>
