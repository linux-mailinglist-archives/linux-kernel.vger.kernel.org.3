Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86374B8095
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 07:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiBPGLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 01:11:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiBPGLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 01:11:39 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3197678;
        Tue, 15 Feb 2022 22:11:27 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id b22so877097qkk.12;
        Tue, 15 Feb 2022 22:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qrF2AGkbesTiCfkO3ANeMQbLK0for1A6sHEYe/Kim6M=;
        b=YQO/vVYVfgFF9bhl7F3Qj/xl36UeARvvtaR0v/JHXa6kkCNxuEnVixYVI5vdB4HyOO
         vZEdPAWstqWv07ho/IOKE8yM+04oz8QoPYPX52zG1rKjpOamO/RXVxWs2qsiitPsP0ki
         dYHP2zfKCbBj++kHUw4w3OZz928fuIs4+XEBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrF2AGkbesTiCfkO3ANeMQbLK0for1A6sHEYe/Kim6M=;
        b=12FZ+fcpElkeiU+D5kCQdjIorBOZVqpYzSfqLdFrK6PIMENgtnzfGQIqtA6s+C/+Jy
         oEUY1k11tSYJuXZyElk1fFbT3w65AFjWdIMEkWR9P89Q4OBM3QEDvpDOh7inLaFTk9Sz
         VnDgbWVwa64h4HJsGTib75g/m6Bf0LpjSAQH38E7OgBt1yOpRristDjUAFL6+ZSe4Gmv
         nTH6mXveTVBVEx2MYSlBb7Z3zhFtXDVbLheGPtErJegaZLbnKnfJ640J+csuTI4asWs8
         G5lfb/I/lmJ2EO7Yt6ZkAsj1/5iecNK2YodXKvSEMnggE481Xh839TreToqRq+hDxCaE
         Vcww==
X-Gm-Message-State: AOAM532piwN+T1MwK8TOcNzf9HwyWwTw6H9GziFaYNOO7YD1wiMr5Ta4
        +TmkfILN6a2o+AYeARJBCNwi7PNaScPJiVBkZ1s=
X-Google-Smtp-Source: ABdhPJyHGS8voRqkcfgL0uskNDpsry0nAbiZHG2QitWww/PPlUxFURSwTAkccYj6Y//ECje6Q0b76s6DzIi4DmofzHg=
X-Received: by 2002:a05:620a:1414:b0:47d:87ec:72b6 with SMTP id
 d20-20020a05620a141400b0047d87ec72b6mr580051qkj.666.1644991886241; Tue, 15
 Feb 2022 22:11:26 -0800 (PST)
MIME-Version: 1.0
References: <20220215151022.7498-1-eajames@linux.ibm.com> <20220215151022.7498-3-eajames@linux.ibm.com>
In-Reply-To: <20220215151022.7498-3-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 16 Feb 2022 06:11:14 +0000
Message-ID: <CACPK8Xf6XYF-8ge_wzRH2V4_ErW8duYoFVVjjojBNy68rk7gNw@mail.gmail.com>
Subject: Re: [PATCH 2/4] hwmon: (occ) Add sysfs entry for OCC mode
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
> BMC control applications need to check the OCC mode returned by the
> OCC poll response, so export it in sysfs with the other OCC-specific
> data.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/hwmon/occ/common.h |  1 +
>  drivers/hwmon/occ/sysfs.c  | 11 +++++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
> index a88c66d36e38..2dd4a4d240c0 100644
> --- a/drivers/hwmon/occ/common.h
> +++ b/drivers/hwmon/occ/common.h
> @@ -120,6 +120,7 @@ struct occ {
>         u8 prev_ext_stat;
>         u8 prev_occs_present;
>         u8 prev_ips_status;
> +       u8 prev_mode;
>  };
>
>  int occ_setup(struct occ *occ, const char *name);
> diff --git a/drivers/hwmon/occ/sysfs.c b/drivers/hwmon/occ/sysfs.c
> index 6dc69c9aa4c2..88f655887c95 100644
> --- a/drivers/hwmon/occ/sysfs.c
> +++ b/drivers/hwmon/occ/sysfs.c
> @@ -66,6 +66,9 @@ static ssize_t occ_sysfs_show(struct device *dev,
>         case 8:
>                 val = header->ips_status;
>                 break;
> +       case 9:
> +               val = header->mode;
> +               break;
>         default:
>                 return -EINVAL;
>         }
> @@ -92,6 +95,7 @@ static SENSOR_DEVICE_ATTR(occ_quick_pwr_drop, 0444, occ_sysfs_show, NULL, 5);
>  static SENSOR_DEVICE_ATTR(occ_state, 0444, occ_sysfs_show, NULL, 6);
>  static SENSOR_DEVICE_ATTR(occs_present, 0444, occ_sysfs_show, NULL, 7);
>  static SENSOR_DEVICE_ATTR(occ_ips_status, 0444, occ_sysfs_show, NULL, 8);
> +static SENSOR_DEVICE_ATTR(occ_mode, 0444, occ_sysfs_show, NULL, 9);
>  static DEVICE_ATTR_RO(occ_error);
>
>  static struct attribute *occ_attributes[] = {
> @@ -104,6 +108,7 @@ static struct attribute *occ_attributes[] = {
>         &sensor_dev_attr_occ_state.dev_attr.attr,
>         &sensor_dev_attr_occs_present.dev_attr.attr,
>         &sensor_dev_attr_occ_ips_status.dev_attr.attr,
> +       &sensor_dev_attr_occ_mode.dev_attr.attr,
>         &dev_attr_occ_error.attr,
>         NULL
>  };
> @@ -172,6 +177,11 @@ void occ_sysfs_poll_done(struct occ *occ)
>                 sysfs_notify(&occ->bus_dev->kobj, NULL, name);
>         }
>
> +       if (header->mode != occ->prev_mode) {
> +               name = sensor_dev_attr_occ_mode.dev_attr.attr.name;
> +               sysfs_notify(&occ->bus_dev->kobj, NULL, name);
> +       }
> +
>         if (occ->error && occ->error != occ->prev_error) {
>                 name = dev_attr_occ_error.attr.name;
>                 sysfs_notify(&occ->bus_dev->kobj, NULL, name);
> @@ -185,6 +195,7 @@ void occ_sysfs_poll_done(struct occ *occ)
>         occ->prev_ext_stat = header->ext_status;
>         occ->prev_occs_present = header->occs_present;
>         occ->prev_ips_status = header->ips_status;
> +       occ->prev_mode = header->mode;
>  }
>
>  int occ_setup_sysfs(struct occ *occ)
> --
> 2.27.0
>
