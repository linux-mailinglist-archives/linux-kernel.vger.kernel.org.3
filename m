Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A7D5964D9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbiHPVo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiHPVo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:44:57 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FBF6525B
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:44:56 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-32fd97c199fso161081337b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=HVy2dhpgUq+TCa1+gNzXEDC+2DKw2nqR1kkYuPYSqUw=;
        b=ftyIhd9V+q2A29zdiypNsQVoUh2exbA2eIUGJcoay9088xFM15YHBmgU16PeKDsFuY
         Gw7FHeTI5lVY0Wj3An1IYErXR9AVLYmOw3opdXc0bpv5Ys90pXC4lxrI+QUWottezu2P
         eMWW6OTfY/xw5NMk9D/l+o1N2PaZ+HtfTZR+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HVy2dhpgUq+TCa1+gNzXEDC+2DKw2nqR1kkYuPYSqUw=;
        b=tYA9reIr2AZvwWWWdCEwlyMrH+s4YtHWOgCPRYrjGtHR03NcaY8jsFAUFgmzqIuTb5
         BOog+1G+WvZistytylTDe1aI5YL1qetkJtczEZ5XptaP9y6LsMunGq/gbdVmKgzAZ2Nw
         axQcsqXDsvbKKOt20+mGe6Wt0aMKJJ422g5k8Eub73GbBQJLQMWti0vlnRjYrvOWmGbS
         /hhE8PKXsWjvavRCE/rm6e2TMcv0wsn74RlawrhOgzpFpSHc0Z3Zvx2DJaPGdU0J7CQQ
         koMjzgTHxz3aQr8leDzzMHVJ5sYz85/rDquCCWOChOYHPs1Ls3Qj8zpx1X2pQjvjNVaj
         8Sow==
X-Gm-Message-State: ACgBeo07kYrMHBe+JTiMVGUVPU9l69/0yuZ6AoK94bGOh1Lcwu3gRy5q
        xEbC86nAQZ/PXKhrwdTDayCtjug7Pj+4rmUuozHjbr06tVo=
X-Google-Smtp-Source: AA6agR50R5+yZwR0E9gjbHI0sJwF86HfBORhJh0SzaLt1EEjVs6AYC4BYIG9uitnV3tHcz0Rs8DT4IcNwkM1uJT2dx8=
X-Received: by 2002:a25:4ce:0:b0:67c:3362:c396 with SMTP id
 197-20020a2504ce000000b0067c3362c396mr17283128ybe.336.1660686295674; Tue, 16
 Aug 2022 14:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220815063555.1384505-1-pmalani@chromium.org>
 <20220815063555.1384505-3-pmalani@chromium.org> <Yvsm7qEiCpoYPeTS@google.com>
In-Reply-To: <Yvsm7qEiCpoYPeTS@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 16 Aug 2022 14:44:45 -0700
Message-ID: <CACeCKadOK22FzOwyOEkmaqw+V4-Jna=QqetDmsqNhs27skzU7A@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] platform/chrome: cros_typec_switch: Add switch driver
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Xiang wangx <wangxiang@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tzung-Bi,

Thanks for reviewing the patch series.

On Mon, Aug 15, 2022 at 10:11 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> On Mon, Aug 15, 2022 at 06:34:19AM +0000, Prashant Malani wrote:
> > Introduce a driver to configure USB Type-C mode switches and retimers
> > which are controlled by the Chrome OS EC (Embedded Controller).
> > This allows Type-C port drivers, as well as alternate mode drivers to
> > configure their relevant mode switches and retimers according to the
> > Type-C state they want to achieve.
>
> s/Chrome OS/ChromeOS/.

Fixed in v6.

>
> > diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> [...]
> > +config CROS_TYPEC_SWITCH
> > +     tristate "ChromeOS EC Type-C Switch Control"
> > +     depends on MFD_CROS_EC_DEV && TYPEC && ACPI
> > +     default MFD_CROS_EC_DEV
> > +     help
> > +       If you say Y here, you get support for configuring the Chrome OS EC Type C
> > +       muxes and retimers.
>
> s/Chrome OS/ChromeOS/.
>
> Up to you, s/Type C/Type-C/g.

Fixed in v6.

>
> > diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
> > new file mode 100644
> > index 000000000000..0d319e315d57
> > --- /dev/null
> > +++ b/drivers/platform/chrome/cros_typec_switch.c
> > @@ -0,0 +1,170 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright 2022 Google LLC
> > + *
> > + * This driver provides the ability to configure Type C muxes and retimers which are controlled by
> > + * the Chrome OS EC.
> > + */
>
> s/Chrome OS/ChromeOS/.
Fixed in v6.

>
> > +static int cros_typec_register_switches(struct cros_typec_switch_data *sdata)
> > +{
> > +     struct cros_typec_port *port = NULL;
> > +     struct device *dev = sdata->dev;
> > +     struct fwnode_handle *fwnode;
> > +     struct acpi_device *adev;
> > +     unsigned long long index;
> > +     int ret = 0;
>
> `port` and `ret` don't need to be initialized.
Fixed in v6.

>
> > +MODULE_DESCRIPTION("Chrome OS EC Type C Switch control");
>
> s/Chrome OS/ChromeOS/.

Fixed in v6.
