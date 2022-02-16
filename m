Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D62B4B8094
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 07:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiBPGMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 01:12:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiBPGMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 01:12:43 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872B313549F;
        Tue, 15 Feb 2022 22:12:20 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id f19so1261015qvb.6;
        Tue, 15 Feb 2022 22:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LzmxRI7SnZuuXPRRqtAkUYN/DbqY0lbF3LJbpfBnCMU=;
        b=bosRiRdIkuMYNqfxx8xzE9fy8vRIQbWF9y1rnmz5Pqh1XTGq0tv31moxEWOye0NP7x
         mwsFEtNLguV5eNrNZXlpxqy7/HE3xT9pNJM9vK8OAFPk3yJ2qanS7N9RrCb4sOo2ibzf
         jIsiyB66B0iVU2DXm8TA8o0XxozzWJy4QQ1MM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LzmxRI7SnZuuXPRRqtAkUYN/DbqY0lbF3LJbpfBnCMU=;
        b=oaYEroAFjHy1uJMhgwRs7jqGnYxFJou7yOrBLWrO0Danr8Qc1i22aBLsXmjzmafJal
         JyT/1D+v7q3vDJT/RB4nOmCffH7pmeNSDedtuNFvf1o+L/9SXviX2ISW6NcTZkuVWq3C
         qYMQlLskwh1F1vrozV9bH/ThYtP28WhWrReSBPyzs6uojQNs345v44e4VatkdPFL28Rt
         SS0v9QH8yP21JnI29qilXLG/5Ymz+2IdFjGBsvGRVQ8VUEOuQcmWCxZVp+TdyoHJRd2w
         WHQaHGV0uv2B7MCWrYoFxRGanRGmEU9IqwL/XcuhaS87WUs9EBGL/M0XBQagX8wKfZZw
         uu+A==
X-Gm-Message-State: AOAM5333KS/nKLqsjQfSzEHMBlYoQkixJeBRRq9F+SwkQDQk+uD9FQI8
        l/OfI1Yr9yX+WEXqyLTQhkrXJ2Mjsclc8k3PiVLY4M+S
X-Google-Smtp-Source: ABdhPJyhlOM4Hk8zpR7uQ5NsfA5am+a9ZY9C4B3UxkU+DqgP8JkiKsfg26pm/eXaiUl9LGe0wWVfSx46TwX7mufsqw0=
X-Received: by 2002:ad4:456e:0:b0:42c:b084:147f with SMTP id
 o14-20020ad4456e000000b0042cb084147fmr887416qvu.49.1644991939607; Tue, 15 Feb
 2022 22:12:19 -0800 (PST)
MIME-Version: 1.0
References: <20220215151022.7498-1-eajames@linux.ibm.com> <20220215151022.7498-4-eajames@linux.ibm.com>
In-Reply-To: <20220215151022.7498-4-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 16 Feb 2022 06:12:07 +0000
Message-ID: <CACPK8XeTJU0E6LCmEMhvebXTh23+3PHfbCoHsn_0fH9d0=rDZg@mail.gmail.com>
Subject: Re: [PATCH 3/4] hwmon: (occ) Add sysfs entries for additional
 extended status bits
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022 at 15:11, Eddie James <eajames@linux.ibm.com> wrote:
>
> Add sysfs entries for DVFS due to a VRM Vdd over-temperature condition,
> and add the GPU throttling condition bits (such that if bit 1 is set,
> GPU1 is throttling).
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/hwmon/occ/sysfs.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/hwmon/occ/sysfs.c b/drivers/hwmon/occ/sysfs.c
> index 88f655887c95..b2f788a77746 100644
> --- a/drivers/hwmon/occ/sysfs.c
> +++ b/drivers/hwmon/occ/sysfs.c
> @@ -19,6 +19,8 @@
>  #define OCC_EXT_STAT_DVFS_POWER                BIT(6)
>  #define OCC_EXT_STAT_MEM_THROTTLE      BIT(5)
>  #define OCC_EXT_STAT_QUICK_DROP                BIT(4)
> +#define OCC_EXT_STAT_DVFS_VDD          BIT(3)
> +#define OCC_EXT_STAT_GPU_THROTTLE      GENMASK(2, 0)
>
>  static ssize_t occ_sysfs_show(struct device *dev,
>                               struct device_attribute *attr, char *buf)
> @@ -69,6 +71,12 @@ static ssize_t occ_sysfs_show(struct device *dev,
>         case 9:
>                 val = header->mode;
>                 break;
> +       case 10:
> +               val = !!(header->ext_status & OCC_EXT_STAT_DVFS_VDD);
> +               break;
> +       case 11:
> +               val = header->ext_status & OCC_EXT_STAT_GPU_THROTTLE;
> +               break;
>         default:
>                 return -EINVAL;
>         }
> @@ -96,6 +104,8 @@ static SENSOR_DEVICE_ATTR(occ_state, 0444, occ_sysfs_show, NULL, 6);
>  static SENSOR_DEVICE_ATTR(occs_present, 0444, occ_sysfs_show, NULL, 7);
>  static SENSOR_DEVICE_ATTR(occ_ips_status, 0444, occ_sysfs_show, NULL, 8);
>  static SENSOR_DEVICE_ATTR(occ_mode, 0444, occ_sysfs_show, NULL, 9);
> +static SENSOR_DEVICE_ATTR(occ_dvfs_vdd, 0444, occ_sysfs_show, NULL, 10);
> +static SENSOR_DEVICE_ATTR(occ_gpu_throttle, 0444, occ_sysfs_show, NULL, 11);
>  static DEVICE_ATTR_RO(occ_error);
>
>  static struct attribute *occ_attributes[] = {
> @@ -109,6 +119,8 @@ static struct attribute *occ_attributes[] = {
>         &sensor_dev_attr_occs_present.dev_attr.attr,
>         &sensor_dev_attr_occ_ips_status.dev_attr.attr,
>         &sensor_dev_attr_occ_mode.dev_attr.attr,
> +       &sensor_dev_attr_occ_dvfs_vdd.dev_attr.attr,
> +       &sensor_dev_attr_occ_gpu_throttle.dev_attr.attr,
>         &dev_attr_occ_error.attr,
>         NULL
>  };
> @@ -166,6 +178,18 @@ void occ_sysfs_poll_done(struct occ *occ)
>                 sysfs_notify(&occ->bus_dev->kobj, NULL, name);
>         }
>
> +       if ((header->ext_status & OCC_EXT_STAT_DVFS_VDD) !=
> +           (occ->prev_ext_stat & OCC_EXT_STAT_DVFS_VDD)) {
> +               name = sensor_dev_attr_occ_dvfs_vdd.dev_attr.attr.name;
> +               sysfs_notify(&occ->bus_dev->kobj, NULL, name);
> +       }
> +
> +       if ((header->ext_status & OCC_EXT_STAT_GPU_THROTTLE) !=
> +           (occ->prev_ext_stat & OCC_EXT_STAT_GPU_THROTTLE)) {
> +               name = sensor_dev_attr_occ_gpu_throttle.dev_attr.attr.name;
> +               sysfs_notify(&occ->bus_dev->kobj, NULL, name);
> +       }
> +
>         if ((header->status & OCC_STAT_MASTER) &&
>             header->occs_present != occ->prev_occs_present) {
>                 name = sensor_dev_attr_occs_present.dev_attr.attr.name;
> --
> 2.27.0
>
