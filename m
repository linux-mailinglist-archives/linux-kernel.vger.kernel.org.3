Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468174F84FD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345480AbiDGQa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiDGQaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:30:55 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34FB2654B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:28:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bh17so11959051ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 09:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Vv5wRMLm7eAUwbieA9P9R0i+n/Nx3ujFLOcNigvPcM=;
        b=Nh9bB1KB4S3CAncBLCOeNhoQBW4BpFg7ZxBEKFPIdrPjYLLIXTykS08+eEDZhFWyZ8
         Thpi+P0aSF7sVwTnCRHfToCT9gHhhfKUTdrju+t5E7uyVVjlUwgssiadvrQKU9v4qNGE
         UGaJC8AOLzUArHajp1eLxKaJ3Si9FAGFRr300FrLTKdRBLX62d7XQVrFh69vwxlKtd2C
         WxnNkYIZtoWVODJra1ZHi7tF1gH3RYCAfr02mNt988D5DFXmHfcUd4rFetFQle6MGTMj
         Ci6AYLRrWkvEwU37AQ9XJIDCkWAEFa0AQGz/XDUlpe355EzgRwDt0SJo0W1IsGoPS7Kn
         a4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Vv5wRMLm7eAUwbieA9P9R0i+n/Nx3ujFLOcNigvPcM=;
        b=5oQ4MKzFFrHtfOEkTTZXOT0fy4IHn8WVyMjWEesJlvnLcp3ZsLMRXj+8gQ/dvimtif
         ZqHQfDS8PX7MUhKVObE5NFDvbMzghauAP1yw9VWooso/z8uTGtIgzlbukVFvOlPF0ZfA
         EJtAC/exZDRbTpz8xE97xeM/xJBv2bOi5LB8MdmI+iCCNkSQGU2dkBTdFYGfpIUh8wQf
         stmxvlIcDmcZi56hAyW95kwPZQGP7t/xKi18zRbsq+tc6TXtGNhXd6CmcJibeslcszPv
         LA/pQvboHigGRY1+vl8D9XlHD36rwo/0ns+J7T0xj8uetdxkzVp+1a5maFjWsx1r6B69
         WAXg==
X-Gm-Message-State: AOAM530XMtLXw9gDxXxI6F3UyXtdVi5N/vFJLb1DF8PerPZd5paymZFW
        UpaJKkh/cw1CVg83VhAbilQ6B5QrnfeiqZOzidEafQ==
X-Google-Smtp-Source: ABdhPJySuUD0Vc5Fggv3BJDcImC7/nHme84hjtmjDS8hx74rIZfA/aVAQ1ZlYO8FDlK29GQs74zzLvfuZR+3cWp4Nvs=
X-Received: by 2002:a17:906:300f:b0:6e0:b38d:777d with SMTP id
 15-20020a170906300f00b006e0b38d777dmr14328595ejz.189.1649348933215; Thu, 07
 Apr 2022 09:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220404041101.6276-1-akihiko.odaki@gmail.com>
 <Yk4DGZfpYbK8dofL@chromium.org> <CABXOdTcY3w56hc7kWsDLxKU-c6fCLYt_jigK13tKjjm9OHi2+w@mail.gmail.com>
 <033c1ec4-4bee-a689-140c-9694dfee435b@gmail.com>
In-Reply-To: <033c1ec4-4bee-a689-140c-9694dfee435b@gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 7 Apr 2022 09:28:41 -0700
Message-ID: <CABXOdTet5ynSXf94qMimobJF4LLzHc89cVbwJ5NuAz8G6jmVdQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Check for EC driver
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
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

On Wed, Apr 6, 2022 at 6:16 PM Akihiko Odaki <akihiko.odaki@gmail.com> wrote:
[ ... ]
> >>>        ec_dev = dev_get_drvdata(&typec->ec->ec->dev);

I completely missed the part that this is not on the parent.

> >>> +     if (!ec_dev)
> >>> +             return -EPROBE_DEFER;
[ ... ]
>
> 1. The parent exists and dev_get_drvdata(pdev->dev.parent) returns
> non-NULL value. However, dev_get_drvdata(&typec->ec->ec->dev) returns
> NULL. (Yes, that is confusing.) I'm wondering

I am actually surprised that typec->ec->ec is not NULL. Underlying
problem (or, one underlying problem) is that it is set in
cros_ec_register():

        /* Register a platform device for the main EC instance */
        ec_dev->ec = platform_device_register_data(ec_dev->dev, "cros-ec-dev",
                                        PLATFORM_DEVID_AUTO, &ec_p,
                                        sizeof(struct cros_ec_platform));

"cros-ec-dev" is the mfd device which instantiates the character
device. On devicetree (arm64) systems, the typec device is registered
as child of google,cros-ec-spi and thus should be instantiated only
after the spi device has been instantiated. The same should happen on
ACPI systems, but I don't know if that is really correct.

I don't know what exactly is happening, but apparently typec
registration happens in parallel with cros-ec-dev registration, which
is delayed because the character device is not loaded. As mentioned, I
don't understand why typec->ec->ec is not NULL. Can you check what it
points to ?

Thanks,
Guenter

> dev_get_drvdata(pdev->dev.parent) returned NULL in the following crash
> log but it would be a problem distinct from what is handled with my patch:
> https://lore.kernel.org/lkml/CABXOdTe9u_DW=NZM1-J120Gu1gibDy8SsgHP3bJwwLsE_iuLAQ@mail.gmail.com/
>
> 2. My patch returns -EPROBE_DEFER instead of -ENODEV and I confirmed it
> will eventually be instantiated.
>
> Regards,
> Akihiko Odaki
>
> >
> > Guenter
> >
> >> Thanks,
> >>
> >> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/platform/chrome?id=ffebd90532728086007038986900426544e3df4e
>
