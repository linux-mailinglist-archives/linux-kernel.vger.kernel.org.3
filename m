Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5C654EA11
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377820AbiFPTXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378046AbiFPTWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:22:53 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF108563AB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:22:16 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 68so1707172qkk.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=px+zQB2QIe/Sc5BaXEKHEw8B2vAxzFzKAk+Qqh0TdWQ=;
        b=ZRUSgbgyboiffTJL2svIbN0fV/PAcCmgaLRu9DQZZnmruyBzU914IVgWUtYYqe1YUs
         ydhhVxWO6wjM3oJdMNXgZxW8kev0RGzt+5vqGMKEh04LJyEC+e5mAQ1PS8TTyjuw4N28
         +DC6hvhASFekAQ6T8dNJLCtJ/e2QmjoB6LQthkp1Ut4++/xhPNlmUgIuw+U22i/xAsGB
         j7ZUyn7SLuJop4Fzb8P5OV/mAOU/A1YbtxmbTwVvVRO7PQgbCqwKu24ILSCA90ik2w/8
         bxYafFz6mO8bPuZ9yQeda5EmFI65bAQpAAOUnV6Y0t87ujZqLRQjh8DJYdZ+rO0sBj56
         dd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=px+zQB2QIe/Sc5BaXEKHEw8B2vAxzFzKAk+Qqh0TdWQ=;
        b=5HK3ABQsLo06ZTMIvu+njznIPULllekl6k3Ahjr+JSmSzEG0Zrw1Y6RDZva9E3wb7G
         UC3lsJ694qDyZ/WQam7badFYdPffLFMehHYBWnIaq4IGNoyvWgEUJ1IhdipWy/GiFob5
         eo1n4tD5TWPIIcewZ/QgB1P7O5nRdMKJ8IyNB0D4Vmm7opRp/Tv3txRWO6n5LWG22b4M
         n3Pr4tIFcnNQYJUhkgbsqV1huvCGef/RBKbd4V9d+p8z7QhBQ3aq/cbZmKzLil0HB18h
         epK+IVTGENMoqGvwxA+l600U5mq5cYvtJHQnvmo0PpTojyqWV01K8txB7WDNTNxI0eb/
         Fqag==
X-Gm-Message-State: AJIora+czl9jUbLs3zrguUXW+wFMnsHOadCfm87dHnQnhY1T5WMwy28m
        1TA6mFPHSDwVIVZjehLR8f1GoZk0VuXbkvq9Bok=
X-Google-Smtp-Source: AGRyM1uaQ8kl+lyTCVmMeI0Uq6kC0kZXEpQj5QKlPurp5ZUCgrKagZ+gdcPsyL+SfHXLL/xNHF1cJA==
X-Received: by 2002:a05:620a:4714:b0:6a7:2f11:d04f with SMTP id bs20-20020a05620a471400b006a72f11d04fmr4770202qkb.688.1655407335698;
        Thu, 16 Jun 2022 12:22:15 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id f5-20020a05620a280500b006a6a6f148e6sm2341887qkp.17.2022.06.16.12.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 12:22:14 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-30fdbe7467cso23198237b3.1;
        Thu, 16 Jun 2022 12:22:13 -0700 (PDT)
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr7472185ywk.209.1655407332919; Thu, 16
 Jun 2022 12:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220405093759.1126835-1-alex.bennee@linaro.org> <20220405093759.1126835-3-alex.bennee@linaro.org>
In-Reply-To: <20220405093759.1126835-3-alex.bennee@linaro.org>
From:   Arnd Bergmann <arnd@linaro.org>
Date:   Thu, 16 Jun 2022 21:21:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1xC5jVT9dE7GTtMhE5siFzOkgb5uBEC-ZCt5GPW09u+g@mail.gmail.com>
Message-ID: <CAK8P3a1xC5jVT9dE7GTtMhE5siFzOkgb5uBEC-ZCt5GPW09u+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] char: rpmb: provide a user space interface
To:     =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Joakim Bech <joakim.bech@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Ruchika Gupta <ruchika.gupta@linaro.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Huang, Yang" <yang.huang@intel.com>,
        "Zhu, Bing" <bing.zhu@intel.com>, Matti.Moell@opensynergy.com,
        hmo@opensynergy.com, linux-mmc <linux-mmc@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Avri Altman <avri.altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 5, 2022 at 11:37 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

> +static int rpmb_open(struct inode *inode, struct file *fp)
> +{
> +       struct rpmb_dev *rdev;
> +
> +       rdev =3D container_of(inode->i_cdev, struct rpmb_dev, cdev);
> +       if (!rdev)
> +               return -ENODEV;
> +
> +       /* the rpmb is single open! */
> +       if (test_and_set_bit(RPMB_DEV_OPEN, &rdev->status))
> +               return -EBUSY;
> +
> +       mutex_lock(&rdev->lock);
> +
> +       fp->private_data =3D rdev;
> +
> +       mutex_unlock(&rdev->lock);

The mutex here doesn't really do anything, as the file structure is not
reachable from any other context.

I'm not sure the single-open protection gains you anything either,
as it does not prevent the file structure to be shared between
processes.

> +static long rpmb_ioctl_ver_cmd(struct rpmb_dev *rdev,
> +                              struct rpmb_ioc_ver_cmd __user *ptr)
> +{
> +       struct rpmb_ioc_ver_cmd ver =3D {
> +               .api_version =3D RPMB_API_VERSION,
> +       };
> +
> +       return copy_to_user(ptr, &ver, sizeof(ver)) ? -EFAULT : 0;
> +}

API version ioctls are generally a bad idea, I think this should be skipped=
.
The way to handle incompatible API changes is to introduce new ioctl
commands.

> +static const struct file_operations rpmb_fops =3D {
> +       .open           =3D rpmb_open,
> +       .release        =3D rpmb_release,
> +       .unlocked_ioctl =3D rpmb_ioctl,



> diff --git a/drivers/rpmb/rpmb-cdev.h b/drivers/rpmb/rpmb-cdev.h
> new file mode 100644
> index 000000000000..e59ff0c05e9d
> --- /dev/null
> +++ b/drivers/rpmb/rpmb-cdev.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
> +/*
> + * Copyright (C) 2015-2018 Intel Corp. All rights reserved
> + */
> +#ifdef CONFIG_RPMB_INTF_DEV
> +int __init rpmb_cdev_init(void);
> +void __exit rpmb_cdev_exit(void);
> +void rpmb_cdev_prepare(struct rpmb_dev *rdev);
> +void rpmb_cdev_add(struct rpmb_dev *rdev);
> +void rpmb_cdev_del(struct rpmb_dev *rdev);
> +#else
> +static inline int __init rpmb_cdev_init(void) { return 0; }
> +static inline void __exit rpmb_cdev_exit(void) {}
> +static inline void rpmb_cdev_prepare(struct rpmb_dev *rdev) {}
> +static inline void rpmb_cdev_add(struct rpmb_dev *rdev) {}
> +static inline void rpmb_cdev_del(struct rpmb_dev *rdev) {}
> +#endif /* CONFIG_RPMB_INTF_DEV */

What is the purpose of the fallback? Would you ever build the code without
the interface?

> +/**
> + * struct rpmb_ioc_ver_cmd - rpmb api version
> + *
> + * @api_version: rpmb API version.
> + */
> +struct rpmb_ioc_ver_cmd {
> +       __u32 api_version;
> +} __packed;

Best remove this completely.

> +enum rpmb_auth_method {
> +       RPMB_HMAC_ALGO_SHA_256 =3D 0,
> +};
> +
> +/**
> + * struct rpmb_ioc_cap_cmd - rpmb capabilities
> + *
> + * @target: rpmb target/region within RPMB partition.
> + * @capacity: storage capacity (in units of 128K)
> + * @block_size: storage data block size (in units of 256B)
> + * @wr_cnt_max: maximal number of block that can be written in a single =
request.
> + * @rd_cnt_max: maximal number of block that can be read in a single req=
uest.
> + * @auth_method: authentication method: currently always HMAC_SHA_256
> + * @reserved: reserved to align to 4 bytes.
> + */
> +struct rpmb_ioc_cap_cmd {
> +       __u16 target;
> +       __u16 capacity;
> +       __u16 block_size;
> +       __u16 wr_cnt_max;
> +       __u16 rd_cnt_max;
> +       __u16 auth_method;
> +       __u16 reserved;
> +} __packed;

I would remove the __packed attribute here. If you want to keep it, then
it needs to have a __aligned() attribute as well.

It seems strange to have an odd number of 16-bit fields in this, maybe
make it two reserved fields to have a multiple of 32-bit.

> + * struct rpmb_ioc_reqresp_cmd - general purpose reqresp
> + *
> + * Most RPMB operations consist of a set of request frames and an
> + * optional response frame. If a response is requested the user must
> + * allocate enough space for the response, otherwise the fields should
> + * be set to 0/NULL.
> + *
> + * It is used for programming the key, reading the counter and writing
> + * blocks to the device. If the frames are malformed they may be
> + * rejected by the underlying driver or the device itself.
> + *
> + * Assuming the transaction succeeds it is still up to user space to
> + * validate the response and check MAC values correspond to the
> + * programmed keys.
> + *
> + * @len: length of write counter request
> + * @request: ptr to device specific request frame
> + * @rlen: length of response frame
> + * @resp: ptr to device specific response frame
> + */
> +struct rpmb_ioc_reqresp_cmd {
> +       __u32 len;
> +       __u8 __user *request;
> +       __u32 rlen;
> +       __u8 __user *response;
> +} __packed;

Try to avoid indirect pointers in ioctl structures, they break
compatibility with
32-bit processes. I think you can do this with a variable-length structure =
that
has the two length fields followed by the actual data. If there is a reason=
able
upper bound for the length, it could also just be a fixed-length buffer.

If you end up having to use a pointer, make it a __u64 value and cast betwe=
en
that and the actual pointer value.

Whatever you do though, don't use misaligned pointers or implicit padding i=
n the
structure. You can have explicit padding by adding an extra __u32 before
a __u64 pointer value, and then remove the __packed attribute, or reorder t=
he
members so each pointer is naturally aligned.

       Arnd
