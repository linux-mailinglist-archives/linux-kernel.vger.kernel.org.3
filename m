Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7A64F2153
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiDECu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiDECuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:50:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09982DE868
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:57:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dr20so23529538ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8lHhYFW2wjM+XVs/ce0McLe3nK2usueM9y5Aj9STafs=;
        b=FA3yAVlH7wWlUJcQ3bx0/NKcDywUaZwtbXLP0LgBSGRsj2d2snpgTAmXJYtAOj88Gp
         CYtFbUBDTDcuvuZ6eF8j53jpAsLinkhtZ/Ef7Uhmox18cVGyrIEp9+qFcKK1GR7ahTX/
         46ca7IWLXUxpUvV8Z7tJKIFbNnbydN6hr9cY+q8rAaP9tsLoMgJ8dqWI49WpKCiDRpTE
         PsOSqjptGmbI4aFA5uNyW/woYfgGQRFmmcyMJSCyS7fEbURD8nDhaF9Hpqc7RVgDWTbv
         FTwkLzXuSi1Xd9T4XDBVXpZaK/RmyVsS1OQLe+XLBuvnqnOFHJVS4qvUkD342N6xOgZB
         9o0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8lHhYFW2wjM+XVs/ce0McLe3nK2usueM9y5Aj9STafs=;
        b=zmhSTXfZ0+X5V3rcvlV8GVzONwjTrEHF0i48QZaYNn7uFn4LYRLCYArytbQzOUNQZe
         AQyYhRL86ojhJVqbGV2YEBtWWdJfATlc8NNHitZFRr1GR0awSHIhnocQaJQQC2oqznv6
         eTn9CC4CE33Kp+DZQvpiXnXNI8WuZyql1fvojBsVMgioUjMbEDkwR+xaqfBqY1IP3B11
         XKIQevcMkgQOz1zxEsyae+9Iz559ueQYCe4hPIJB5z7qs/0qKJKhL+uEFjZhmWJDv9cz
         WyebmJcFkFWxdFSIaTgO1A9iR1hCKO7vq7/MIs5ClWYsSKBDwyU7ytkMoNjOp8vSJZyj
         obvA==
X-Gm-Message-State: AOAM531yOFi5NkStuPKDxgf91y24yy1PjLhonOVy+URlaMZMVeKFJTaf
        1QftVkLi2HtYjMsyXMnGDuyRNYTN0VfyJrL7dvgxcA==
X-Google-Smtp-Source: ABdhPJzWg56tGOZzoo6mjBM60wGyjWHjZEk8WIMAmh9wb7iaHGuDP2UkNGGEbl/PJn03N2TZh9MDxqyZayUe0V0A/Ic=
X-Received: by 2002:a17:907:1624:b0:6db:8caa:d71 with SMTP id
 hb36-20020a170907162400b006db8caa0d71mr1097692ejc.723.1649123853100; Mon, 04
 Apr 2022 18:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220404041101.6276-1-akihiko.odaki@gmail.com>
In-Reply-To: <20220404041101.6276-1-akihiko.odaki@gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 4 Apr 2022 18:57:22 -0700
Message-ID: <CABXOdTe9u_DW=NZM1-J120Gu1gibDy8SsgHP3bJwwLsE_iuLAQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Check for EC driver
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
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

On Sun, Apr 3, 2022 at 9:11 PM Akihiko Odaki <akihiko.odaki@gmail.com> wrote:
>
> The EC driver may not be initialized when cros_typec_probe is called,
> particulary when CONFIG_CROS_EC_CHARDEV=m.
>

Does this cause a crash ? If so, do you have a crash log ?

Reason for asking is that I saw the following crash, and it would be
good to know if the problem is the same.

<1>[    6.651137] #PF: error_code(0x0002) - not-present page
<6>[    6.651139] PGD 0 P4D 0
<4>[    6.651143] Oops: 0002 [#1] PREEMPT SMP NOPTI
<4>[    6.651146] CPU: 0 PID: 1656 Comm: udevd Tainted: G     U
    5.4.163-17384-g99ca1c60d20c #1
<4>[    6.651147] Hardware name: HP Lantis/Lantis, BIOS
Google_Lantis.13606.204.0 05/26/2021
<4>[    6.651152] RIP: 0010:mutex_lock+0x2b/0x3c
...
<4>[    6.651174] Call Trace:
<4>[    6.651180]  cros_ec_cmd_xfer+0x22/0xc1
<4>[    6.651183]  cros_ec_cmd_xfer_status+0x19/0x59
<4>[    6.651185]  cros_ec_command+0x82/0xc3
<4>[    6.651189]  cros_typec_probe+0x8a/0x5a2 [cros_ec_typec]

> Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>

Not sure if this is the best solution, but I don't know a better one.

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 4bd2752c0823..7cb2e35c4ded 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -1084,6 +1084,9 @@ static int cros_typec_probe(struct platform_device *pdev)
>         }
>
>         ec_dev = dev_get_drvdata(&typec->ec->ec->dev);
> +       if (!ec_dev)
> +               return -EPROBE_DEFER;
> +
>         typec->typec_cmd_supported = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_CMD);
>         typec->needs_mux_ack = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
>
> --
> 2.35.1
>
