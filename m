Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD4B598A56
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344863AbiHRRZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345417AbiHRRZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:25:04 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF304D839
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:24:34 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-333a4a5d495so59139197b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WmBqeJ78050aXLKgOwLTPwBE6TsmJMEDRuI6qelXVno=;
        b=CBVHuUfuyWcCZNBWBq/+y/JHPvetpvzju+JjhM+v3zR68gaL+f+jaybMfNWIJo0ukv
         MteuvRIcYU28PD6BBoRIRYfAQscIw8740RBblr8y+jf7nKJA5OQ8kd6qCkXrLw0QbMk9
         q0hrBTX4MDTnVEVeCDrwR7JxRflSQdwzZzb9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WmBqeJ78050aXLKgOwLTPwBE6TsmJMEDRuI6qelXVno=;
        b=bXnV59XQk3eNNaqc69l4oTs6ptOBRJhwtXfPc4dj1118Ka68tCyj8QZQx+2shmByIV
         KspMGjNGsLz05oZm+01NFeGIY7tR2Wz8TMApsDsDPg8o5ilNDknxheTlo2oej+7lNQxS
         lF1K7tvuVElNIU/Pmm9mTtz3m8CeSSnVEtjhNhWeWDA6UsJIRADiauBpnPN7M3dxVabh
         vYza4W2ImA8uAGbda46mVfPU+Tyo0KHAvhuvin27whZdp6ubZ1vpVnK327eoSBUX5sct
         V2ckrJkL2oTtk+URVm0WAdFtvfmzCGLIJtQnunOKF89pGctG6Erz9mACo4v/hGiE/xk1
         ze4w==
X-Gm-Message-State: ACgBeo31xiHmD3TVajCLz3dVKPwhmN2Cwe/p9qqMkeOhuXr3o2JBb/JS
        Q9GvWYmjIQ8xddZcSO46iW4kJfaOBW+aufGaeiCOv72wmhU=
X-Google-Smtp-Source: AA6agR5zeO11pwMCpjpTangMySpcd64Fk35oD7bSXulfN4WOV9pLCmRT0KLruTqnSsflSM25W8GDYbKDstNQ5osbyq0=
X-Received: by 2002:a25:4ce:0:b0:67c:3362:c396 with SMTP id
 197-20020a2504ce000000b0067c3362c396mr3963221ybe.336.1660843473754; Thu, 18
 Aug 2022 10:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220818082827.v2.1.Idd188ff3f9caddebc17ac357a13005f93333c21f@changeid>
In-Reply-To: <20220818082827.v2.1.Idd188ff3f9caddebc17ac357a13005f93333c21f@changeid>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 18 Aug 2022 10:24:23 -0700
Message-ID: <CACeCKafyHSTiyyjA=yjSXsTub4kKECfe9gp=y10LCYYx0nGKqg@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Expose suspend_timeout_ms in debugfs
To:     Evan Green <evgreen@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Rajat Jain <rajatja@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 8:29 AM Evan Green <evgreen@chromium.org> wrote:
>
> In modern Chromebooks, the embedded controller has a mechanism where
> it will watch a hardware-controlled line that toggles in suspend, and
> wake the system up if an expected sleep transition didn't occur. This
> can be very useful for detecting power management issues where the
> system appears to suspend, but doesn't actually reach its lowest
> expected power states.
>
> Sometimes it's useful in debug and test scenarios to be able to control
> the duration of that timeout, or even disable the EC timeout mechanism
> altogether. Add a debugfs control to set the timeout to values other
> than the EC-defined default, for more convenient debug and
> development iteration.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
(One minor nit aside) FWIW:
Reviewed-by: Prashant Malani <pmalani@chromium.org>

> ---
>
> Changes in v2:
>  - Update release version to 6.1 (Tzung-Bi)
>  - Reference EC_HOST_SLEEP_TIMEOUT_INFINITE (Tzung-Bi)
>  - Name the debugfs file suspend_timeout_ms (Prashant)
>
>  Documentation/ABI/testing/debugfs-cros-ec   | 22 +++++++++++++++++++++
>  drivers/platform/chrome/cros_ec.c           |  3 ++-
>  drivers/platform/chrome/cros_ec_debugfs.c   |  3 +++
>  include/linux/platform_data/cros_ec_proto.h |  1 +
>  4 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/debugfs-cros-ec b/Documentation/ABI/testing/debugfs-cros-ec
> index 1fe0add99a2a99..9f79c641b2d09f 100644
> --- a/Documentation/ABI/testing/debugfs-cros-ec
> +++ b/Documentation/ABI/testing/debugfs-cros-ec
> @@ -54,3 +54,25 @@ Description:
>                 this feature.
>
>                 Output will be in the format: "0x%08x\n".
> +
> +What:          /sys/kernel/debug/<cros-ec-device>/suspend_timeout_ms
> +Date:          August 2022
> +KernelVersion: 6.1
> +Description:
> +               Some ECs have a feature where they will track transitions to the
> +               a hardware-controlled sleep line, such as Intel's SLP_S0 line,
> +               in order to detect cases where a system failed to go into deep
> +               sleep states. The suspend_timeout file controls the amount of
s/suspend_timeout/suspend_timeout_ms
