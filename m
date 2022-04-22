Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0182D50B6AA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447248AbiDVMAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447214AbiDVMAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:00:21 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF7154FB5;
        Fri, 22 Apr 2022 04:57:28 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id x9so6947421ybe.11;
        Fri, 22 Apr 2022 04:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mo2gwYWJ7v3j2YMx6bxMzq/oePOXwNlGXJmLNbBcYNw=;
        b=SPO+V7r6R/A+hJFfGn+eHiAq018UQgd9LrDiLxOPcg7r75J3PkVoN1f6NZUmKgZ1/0
         Z1hii1ChUnKDQ7ujmbWSmQWVauk7knxbX6SUeY+RxbeaX/c9I5RVEcLK1kJfnkoLvSJn
         Q9slWt+QAh1iV1aW0ZNXI5V9BWJJAL2W46bGoTDtCaIl+1MmubLIRhA/nRgtAVd1Yijy
         +uNy5sfZWzr7IlfCk6RiYBYI1vYr8hAD5RFTmyCeaWBzSVkGvfIm8WInc3Q4ypnxXReP
         F/Lvi+n3j1yx6FOOUERBYriB7ESSH8Vm3OFYL1y+8x478q6j7tNIMoHWLnqDuYt6nFzx
         XubA==
X-Gm-Message-State: AOAM533FUBZvtTuNUYD6tSb/zdMTNp4l/IXzWITVzcCG6zpuZZnE0YuU
        0AV/bkHjGT0BuYdg4lW76IKAfG/nlUmMSQ6KyLE=
X-Google-Smtp-Source: ABdhPJww0e7Q1osgVBWbiQpEUtZNSNKNM2OqFsD//h3jvx8Gu911m2tDMHkzJSveus4EHFgb0GUefU88XPyf4wwFDzQ=
X-Received: by 2002:a25:3cc3:0:b0:63e:6ee9:4840 with SMTP id
 j186-20020a253cc3000000b0063e6ee94840mr4222715yba.153.1650628648089; Fri, 22
 Apr 2022 04:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <1650395470-31333-1-git-send-email-quic_c_sanm@quicinc.com> <1650395470-31333-3-git-send-email-quic_c_sanm@quicinc.com>
In-Reply-To: <1650395470-31333-3-git-send-email-quic_c_sanm@quicinc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Apr 2022 13:57:17 +0200
Message-ID: <CAJZ5v0h2ZKPN6SERPnASPywZfeOWXWncJgNZ1WZa80+=M4DCiQ@mail.gmail.com>
Subject: Re: [PATCH v14 2/7] PM / wakeup: Add device_children_wakeup_capable()
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_kriskura@quicinc.com, quic_vpulyala@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 9:11 PM Sandeep Maheswaram
<quic_c_sanm@quicinc.com> wrote:
>
> From: Matthias Kaehlcke <mka@chromium.org>
>
> Add device_children_wakeup_capable() which checks whether the device itself
> or one if its descendants is wakeup capable.

device_wakeup_path() exists for a very similar purpose.

Is it not usable for whatever you need the new function introduced here?

> Suggested-by: Felipe Balbi <balbi@kernel.org>
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/base/power/wakeup.c | 18 ++++++++++++++++++
>  include/linux/pm_wakeup.h   |  7 +++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index a57d469..1900637 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -541,6 +541,24 @@ int device_set_wakeup_enable(struct device *dev, bool enable)
>  }
>  EXPORT_SYMBOL_GPL(device_set_wakeup_enable);
>
> +static int __device_children_wakeup_capable(struct device *dev, void *dummy)
> +{
> +       return device_may_wakeup(dev) ||
> +               device_for_each_child(dev, NULL, __device_children_wakeup_capable);
> +}
> +
> +/**
> + * device_children_wakeup_capable - Check whether a device or one of its descendants is
> + *                                  wakeup capable.
> + * @dev: Device to handle.
> + */
> +bool device_children_wakeup_capable(struct device *dev)
> +{
> +       return __device_children_wakeup_capable(dev, NULL);
> +}
> +EXPORT_SYMBOL_GPL(device_children_wakeup_capable);
> +
> +
>  /**
>   * wakeup_source_not_registered - validate the given wakeup source.
>   * @ws: Wakeup source to be validated.
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index 196a157..9a3005b 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -109,6 +109,7 @@ extern struct wakeup_source *wakeup_sources_walk_next(struct wakeup_source *ws);
>  extern int device_wakeup_enable(struct device *dev);
>  extern int device_wakeup_disable(struct device *dev);
>  extern void device_set_wakeup_capable(struct device *dev, bool capable);
> +extern bool device_children_wakeup_capable(struct device *dev);
>  extern int device_init_wakeup(struct device *dev, bool val);
>  extern int device_set_wakeup_enable(struct device *dev, bool enable);
>  extern void __pm_stay_awake(struct wakeup_source *ws);
> @@ -186,6 +187,12 @@ static inline bool device_wakeup_path(struct device *dev)
>
>  static inline void device_set_wakeup_path(struct device *dev) {}
>
> +static inline bool device_children_wakeup_capable(struct device *dev)
> +{
> +       return false;
> +}
> +
> +
>  static inline void __pm_stay_awake(struct wakeup_source *ws) {}
>
>  static inline void pm_stay_awake(struct device *dev) {}
> --
> 2.7.4
>
