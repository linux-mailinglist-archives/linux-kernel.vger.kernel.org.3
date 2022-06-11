Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DFD5477CC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 00:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiFKWBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 18:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiFKWBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 18:01:33 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E6C3E5F2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 15:01:32 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h19so2982568edj.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNvZMKbt+7/Kf7YBjNNI5bE9XcnXeFt+vWqBn00F0RE=;
        b=BavePnvBNEsyNXtcZaLBDnP8bcFQNxj3xyZaoBRF7UUU0pp6X7CX8we+nL7XD2td5K
         CVcJH6mNbpjv817NTr+DzsKFeUVYkswE3RWmwtP2aLdPXaa0kIa62ieX9TwYAj9nxEGc
         uDarGbZy4+zjPxmy6+EPIywGZBvrrNKBKX6h6ymU3/Rao1qLsw8hb6B/8oPLMkw5JLu6
         CIZGJ+vmcjnZahIoA1VlQekqhJr4wSoc8cbkhUp1lNqmh+gXb5kNBR5+sr8ZgySadMFd
         DJhjUrsoGFSkQjpCAUwUR0uHLTxidMSMP9HGVjewTue32YtMcIwl5SHFrVWaI39o73+O
         Nm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNvZMKbt+7/Kf7YBjNNI5bE9XcnXeFt+vWqBn00F0RE=;
        b=DFX5lzPLsL40hb2XLkdXdwp05q06pZtT3FNDa7EvkiEyq5PGNH0szNWQcVWW4MPIX9
         XE2HSB5Eb/2bP9F4sFcAyFWtYOPmcnzs/zLUR8Bh5reja5FQwwVtwA+CR5CX31awTrhh
         pgsAFibAbNrMlP4YRwhJYw3TyoiQeNIf1c5xpXAIzvQc0EquHpmQM/oMKgUdWUo8qDJu
         aH8v33rAE6ZUD2cpAR4eXIK4PHnN6uBrgbKH2m9i0D0Vi6qv8FGlwhP1ZFIxlmzjtSPf
         eBTVwjqjDl43clb0f3tlHfRvzoTnL01YY1kTWUbo1FiXPb0UR+2t0JrogmcaMmfhXvOF
         KHiQ==
X-Gm-Message-State: AOAM532g0prFkQhRh3SqQhOOUDp8/QlDK7Z+ittrA6BSsAs/zqyx/EQf
        YjlfYviGYEmDd/E6jbQz7EpyFLl4NDTaVqIm1+TLS0Ob1vUuiw==
X-Google-Smtp-Source: ABdhPJwn+ijlsUn+/3pWRnVD3NDV7vYFGdrXQC+5hntomqS18em7SoRsgYGeer5IoRv1xjaubpTHmvI1b8x/+Y70rRA=
X-Received: by 2002:a05:6402:2405:b0:431:6ef1:e2a with SMTP id
 t5-20020a056402240500b004316ef10e2amr34447712eda.26.1654984891012; Sat, 11
 Jun 2022 15:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220611061825.4119270-1-swboyd@chromium.org>
In-Reply-To: <20220611061825.4119270-1-swboyd@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Sat, 11 Jun 2022 15:01:20 -0700
Message-ID: <CABXOdTf8oFN-_SKuY0hxXSSkpdGU4MzV1t290TB3TqAOLVqrig@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Always expose last resume result
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        patches@lists.linux.dev, Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        Evan Green <evgreen@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
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

On Fri, Jun 10, 2022 at 11:18 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> The last resume result exposing logic in cros_ec_sleep_event()
> incorrectly requires S0ix support, which doesn't work on ARM based
> systems where S0ix doesn't exist. That's because cros_ec_sleep_event()
> only reports the last resume result when the EC indicates the last sleep
> event was an S0ix resume. On ARM systems, the last sleep event is always
> S3 resume, but the EC can still detect sleep hang events in case some
> other part of the AP is blocking sleep.
>
> Always expose the last resume result if the EC supports it so that this
> works on all devices regardless of S0ix support. This fixes sleep hang
> detection on ARM based chromebooks like Trogdor.
>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Rajat Jain <rajatja@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Fixes: 7235560ac77a ("platform/chrome: Add support for v1 of host sleep event")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes from v1 (https://lore.kernel.org/r/20220610223703.3387691-1-swboyd@chromium.org):
>  * Fixed typo
>
>  drivers/platform/chrome/cros_ec.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index b3e94cdf7d1a..3abef9747482 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -135,10 +135,10 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
>         buf.msg.command = EC_CMD_HOST_SLEEP_EVENT;
>
>         ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
> -
> -       /* For now, report failure to transition to S0ix with a warning. */
> +       /* Report failure to transition to system wide suspend with a warning. */
>         if (ret >= 0 && ec_dev->host_sleep_v1 &&
> -           (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME)) {
> +           (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME ||
> +            sleep_event == HOST_SLEEP_EVENT_S3_RESUME)) {
>                 ec_dev->last_resume_result =
>                         buf.u.resp1.resume_response.sleep_transitions;
>
>
> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
> --
> https://chromeos.dev
>
