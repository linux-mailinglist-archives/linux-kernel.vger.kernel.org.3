Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD96536857
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 23:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354693AbiE0VCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 17:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240465AbiE0VCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 17:02:40 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263F41EAEB
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 14:02:39 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-e656032735so7223311fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 14:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=nxF6He7HpWZ4GwGGzPoFQzOw/acvMLoNb90aVoiUal0=;
        b=X85jRBi4B1PcfrEmg5Y7ld9nwXNcZnmKbF37XCeKGUpRvf/UQ6Gaz1zscDH+ytBW9r
         le9wkLTLhcOe9wROcOiiDXIX20kOWPFSOHEhAJJbBLXl8SDC1PoYldNdewWJ+ttbmUqc
         0k/3n06/Kuo4jPUyjyE5vv7EaHsDbrPNsnowc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=nxF6He7HpWZ4GwGGzPoFQzOw/acvMLoNb90aVoiUal0=;
        b=RvUHhFQxLZ0hw5keN9T1RP9lFOUDtRS2NDnDhq1OCkxFJE6T27xwnt9n4nOY+4RKr5
         2PTLXGhUlXEmaUculJSLOUtiXWNwlQfotFDBE5L+KKZhpc0iAXmZlNyoQugY6oW/QrOq
         0npW+s1le/iMqr1nuEy5qziBkzZjylY6NrSg/5VvkV23EmWWnuGZ8oRAhTWliMwF8OzX
         IzazzhhrNK8094nfbU5PhaJZUNg87ucbsrBC263aLiKTgvNNZRpE0D9wKW9O5GwQh/xK
         9M6Ve3TDDWYAkTrLeAzEGzE8FA2NCuoXzfXLy1fFB4j8IX9lNuo2TPVw9UHA4XsXJjW2
         7zeg==
X-Gm-Message-State: AOAM533sPRtx5xpxrLOZgF/tHbHb65HDLcdyPc9sgr7KGZcJxlaDUUMF
        CkOy9OE/lhEM+n3KPa96Fv2hER0C0Wrq75Qpr7/fCA==
X-Google-Smtp-Source: ABdhPJzlCImLhNtTcoiaIh7Pm2IzQ1VjLAL6O8LiIDHqy2sdZqfC1a4S7cVjHJafBiqfUudwpAWHMvGsG5VhwRkAh00=
X-Received: by 2002:a05:6870:240d:b0:f1:b878:e97c with SMTP id
 n13-20020a056870240d00b000f1b878e97cmr4843766oap.193.1653685358485; Fri, 27
 May 2022 14:02:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 27 May 2022 17:02:37 -0400
MIME-Version: 1.0
In-Reply-To: <e70aceba-02d5-15b5-46d0-d5ed5706e81a@quicinc.com>
References: <1653043777-24003-1-git-send-email-quic_c_skakit@quicinc.com>
 <1653043777-24003-8-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n53WLYR1pjnr6wASVmXXQ7xTq5n2Q7GdeKOCkWf4H4n=0A@mail.gmail.com> <e70aceba-02d5-15b5-46d0-d5ed5706e81a@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 27 May 2022 17:02:37 -0400
Message-ID: <CAE-0n539gePyXhw7r+XcaHtooN98KfYsx_qwgDaFkJtMSg+80g@mail.gmail.com>
Subject: Re: [PATCH V13 7/9] regulator: Add a regulator driver for the PM8008 PMIC
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya Kakitapalli <quic_c_skakit@quicinc.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HTML mail? Please send plaintext next time.

Quoting Satya Priya Kakitapalli (Temp) (2022-05-27 01:24:19)
>
> On 5/21/2022 8:26 AM, Stephen Boyd wrote:
>
>     Quoting Satya Priya (2022-05-20 03:49:35)
>
>         diff --git a/drivers/regulator/qcom-pm8008-regulator.c b/drivers/regulator/qcom-pm8008-regulator.c
>         new file mode 100644
>         index 0000000..6e815c6
>         --- /dev/null
>         +++ b/drivers/regulator/qcom-pm8008-regulator.c
>         @@ -0,0 +1,225 @@
>         +// SPDX-License-Identifier: GPL-2.0-only
>         +/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
>         +
>         +#include <linux/device.h>
>         +#include <linux/kernel.h>
>         +#include <linux/mfd/qcom_pm8008.h>
>         +#include <linux/module.h>
>         +#include <linux/of.h>
>         +#include <linux/of_device.h>
>
>     What in of_device.h is used?
>
>
> struct of_device_id

That struct is defined in mod_devicetable.h, not of_device.h

>
>
>
>         +#include <linux/platform_device.h>
>         +#include <linux/regmap.h>
>         +#include <linux/regulator/driver.h>
>         +
[...]
>
>
>         +};
>         +
>         +static int pm8008_regulator_get_voltage(struct regulator_dev *rdev)
>         +{
>         +       struct pm8008_regulator *pm8008_reg = rdev_get_drvdata(rdev);
>         +
>         +       return pm8008_reg->voltage_selector;
>
>     Can this read the hardware instead of caching the value from
>     pm8008_regulator_set_voltage()?
>
>
> I can use the regmap_bulk_read like below (which was present in the earlier
> versions)

Please do

>         +       }
>         +
>         +       pm8008_reg->dev = dev;
>         +
>         +       rc = of_property_read_string(dev->of_node, "regulator-name", &name);
>         +       if (rc)
>         +               return rc;
>         +
>         +       /* get the required regulator data */
>         +       for (i = 0; i < ARRAY_SIZE(reg_data); i++)
>         +               if (strstr(name, reg_data[i].name))
>
>     Why not find this via reg/address instead? It would save storing the
>     regulator name in the reg_data table.
>
>
> You mean match this using base address? then we should add base address in the
> reg_data table. We will need the name to be stored in reg_data table anyway for
> the pm8008_reg->rdesc.of_match

Why? Now that this driver binds to each node individually the usage of
of_match doesn't make any sense to me. Can you set 'struct
regulator_config::dev' instead and not set of_match?
