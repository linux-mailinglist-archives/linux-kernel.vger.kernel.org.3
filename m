Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E636F53019D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 09:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243444AbiEVHdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 03:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344951AbiEVHdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 03:33:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352713CA70;
        Sun, 22 May 2022 00:33:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gh17so9789515ejc.6;
        Sun, 22 May 2022 00:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q56IvgxavWJhsEkcadDqcZc6FJeimEL1lZJWPor8auE=;
        b=oIiyK58kipbrNJ6GQaCjqXXreZvXCvVHjcytBE/FyzVM+VNOTvCLY9FgQAbTRnNQaw
         3ucvfITxTcnGiCU+HpEs9caByTp2IZrMetTUCkQ32agmMhas4iT8pkIgIqXpgXauf+Su
         QY0G/53zn+mjJUpwQt1y5LJ5fS4hfXc4jsC+2Pf/PzUWRKKyinlGb2b25puWwo/X7bDE
         FT++CTBo+jSorDuKzLAkowO8jVDCa50w6IAfA8MWGwIz6v8uq8caLkIscISKHMAqHv9+
         CYpaAlYlc4RBOqL204PQb/8Tmf9+Pn9SF3B6ozmHMdzXhoCMUwwcisKgI1SntF4zjFO9
         YV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q56IvgxavWJhsEkcadDqcZc6FJeimEL1lZJWPor8auE=;
        b=H43+eCS4Q3ClnNc1RzYZ6jJhDKESxRdkVZYpdfqAjlcC1ka/YX94hOS8JAaC15uDih
         W9QoxG5Kaoplc239nubyBS8KVPqJnutYkPJa81fyNE76/7x0ZowI8NXxrDdEEjfF6iZr
         VxAyyVG0/rIsx6ETV/dhLx2OoRH9/ren2lck0i7LAi+r9rx44E8vrWl2LPv+TISQ0TpC
         z1g51ccvMUEG7nY9Kg3TEQFvrjQ5lDGynhnWLynehxUkkeevFXVfYy1leDxrTqcBTapm
         V9WTgDOB1jbMT9fAh/8gyuyfcpSERQznsLm25AxTKvKxuJwHQX/WxeM2IaQQ3e3+ivZx
         LIJQ==
X-Gm-Message-State: AOAM533wYKT7ocjHOD3HfhR8epnNdRT6sn3woz4iYuEtQkOTIM5AJjp6
        +cShUfVhQeFV+sXATeT9/NI=
X-Google-Smtp-Source: ABdhPJxlBx3vwsBGbu+xb+kNECnqZsU7ogBTgwifDfJ1SRjFeixrkga7Y7gf13mVgboWIf8yJHFEKQ==
X-Received: by 2002:a17:906:d193:b0:6fe:9a92:6c4d with SMTP id c19-20020a170906d19300b006fe9a926c4dmr13355170ejz.49.1653204785589;
        Sun, 22 May 2022 00:33:05 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id ej23-20020a056402369700b0042a2d9af0f8sm6696800edb.79.2022.05.22.00.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 00:33:05 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: sun8i: fix typo in comment
Date:   Sun, 22 May 2022 09:33:03 +0200
Message-ID: <2629117.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20220521111145.81697-36-Julia.Lawall@inria.fr>
References: <20220521111145.81697-36-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 21. maj 2022 ob 13:10:46 CEST je Julia Lawall napisal(a):
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> 
> ---
>  drivers/thermal/sun8i_thermal.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/sun8i_thermal.c
> b/drivers/thermal/sun8i_thermal.c index d9cd23cbb671..212c87e63a66 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -237,7 +237,7 @@ static int sun50i_h6_ths_calibrate(struct ths_device
> *tmdev, * The calibration data on the H6 is the ambient temperature and *
> sensor values that are filled during the factory test stage.
>  	 *
> -	 * The unit of stored FT temperature is 0.1 degreee celusis.
> +	 * The unit of stored FT temperature is 0.1 degree celsius.
>  	 *
>  	 * We need to calculate a delta between measured and caluclated
>  	 * register values and this will become a calibration offset.




