Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA417546E88
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 22:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350472AbiFJUig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 16:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350581AbiFJUi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:38:28 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC86B30E752
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 13:38:23 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-fdfe64231dso656713fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 13:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=OmNB8Tcgddvh+DStPNDRj/l3PH4AXfXE+UIaJzFaKDU=;
        b=PeEQYbTqlBNmQVeOneHYbMQ2SNrnE9oRTTJBeeItlAIoqfZ+jTsaeM3pXbv4byuW2/
         AfTroOiJeqAqHgr6g/W5/8NxXUIGHdQ7BxUq1EEr3ZV/U/uQjrGlxVpcIR3cc5hcxYdl
         QtdINxF1F92WAg6BPLRNtQNPQFQiMlm1VhshM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=OmNB8Tcgddvh+DStPNDRj/l3PH4AXfXE+UIaJzFaKDU=;
        b=TsT4sKPDWzVD8r6eCWgqo+Bt4HSBoli+c1QDqR+XfdAx1MnP7GNau4krYDsPfFqPKd
         3udnOUQFA4h5WUkcWeV6zgWmbLbqocpoycV6b4s4NxT12RulGkbd4Ri997xDOk+NKdGv
         Q+fooft2eXYfOkV+rrd0qPlKGQcX4g8cBHezCuJf0oZ+LYBt0fHpamwPaLEdS0Fy1yfM
         RU5ehIiT0S0tU7ravuJONi7n2u5KN0z7a64KdQfd4xzUikV024fXMz6iCtTYivso0H9S
         GxGDwKyj5aWM911D+5TcaB0kdcQzYOes+KJpiqQJmzn8f27GaT+jTz0wgN2QCUbLYhlC
         axWA==
X-Gm-Message-State: AOAM532wykGIKMwF/L7FqrZuKB1ymWKQihLA2PDwqYuolTTjStXRRLSr
        VJzWWkS+dVmPAkFyQXd0fZ7Eakwv88JZ+zFNSPHOsW0fRBA=
X-Google-Smtp-Source: ABdhPJxrnMCKEY4AraCYzAprPhmiQ1YNHjc36TBp1WRgX1iN4BwAyAiw6GjZRAmfjgdlO1edLxRj4Tmv7M7qh5o0Mgk=
X-Received: by 2002:a05:6870:b381:b0:fe:2004:b3b5 with SMTP id
 w1-20020a056870b38100b000fe2004b3b5mr922317oap.63.1654893502377; Fri, 10 Jun
 2022 13:38:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Jun 2022 13:38:21 -0700
MIME-Version: 1.0
In-Reply-To: <1654775566-21953-1-git-send-email-quic_dikshita@quicinc.com>
References: <1654775566-21953-1-git-send-email-quic_dikshita@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 10 Jun 2022 13:38:21 -0700
Message-ID: <CAE-0n50q5GJ_q9Pojjrh+34W+i6BXhxSDCS6M_6NLP0pyZYuQg@mail.gmail.com>
Subject: Re: [PATCH] venus: Add support for SSR trigger using fault injection
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, stanimir.varbanov@linaro.org,
        quic_vgarodia@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dikshita Agarwal (2022-06-09 04:52:46)
> diff --git a/drivers/media/platform/qcom/venus/dbgfs.c b/drivers/media/platform/qcom/venus/dbgfs.c
> index 52de47f..a0bfb9e 100644
> --- a/drivers/media/platform/qcom/venus/dbgfs.c
> +++ b/drivers/media/platform/qcom/venus/dbgfs.c
> @@ -4,13 +4,31 @@
>   */
>
>  #include <linux/debugfs.h>
> +#include <linux/fault-inject.h>
>
>  #include "core.h"
>
> +#ifdef CONFIG_FAULT_INJECTION
> +static DECLARE_FAULT_ATTR(venus_ssr_attr);
> +#endif
> +
> +bool venus_fault_inject_ssr(void)
> +{
> +#ifdef CONFIG_FAULT_INJECTION
> +       return should_fail(&venus_ssr_attr, 1);
> +#else
> +       return false;
> +#endif
> +}

It would be better to remove the ifdef in this function and define a
static inline version that returns false when CONFIG_FAULT_INJECTION is
disabled so that the compiler doesn't have to insert a function call to
venus_fault_inject_ssr() when the config is disabled. It may also be
good to avoid the jump when enabled by exporting the attribute to the
irq handler file.

> +
>  void venus_dbgfs_init(struct venus_core *core)
>  {
>         core->root = debugfs_create_dir("venus", NULL);
>         debugfs_create_x32("fw_level", 0644, core->root, &venus_fw_debug);
> +
> +#ifdef CONFIG_FAULT_INJECTION
> +       fault_create_debugfs_attr("fail_ssr", core->root, &venus_ssr_attr);
> +#endif
>  }
>
>  void venus_dbgfs_deinit(struct venus_core *core)
