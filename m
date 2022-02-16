Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E314B8098
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 07:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiBPGK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 01:10:57 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiBPGKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 01:10:55 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321E618405F;
        Tue, 15 Feb 2022 22:10:44 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id m25so886559qka.9;
        Tue, 15 Feb 2022 22:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9GHn97tmKkFKT0TLBTqaZhFGKQxKmA3Zsz3j3x81qAg=;
        b=hphw9V4prrwZoOCWfZ7wVEQvkuBOCmDwCUIapwfqb43ibC8owgqK5pc9TCEswQGpdX
         kZW6UCz9PjP+Va0G6Ec9HSqkuNayL9noyeuWKTuAHYyipaQHHxo3UR9IpGRX4NYuOQau
         FtmdJc69bZanaXiz9L1pu0g9thNr3VAbkGDMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9GHn97tmKkFKT0TLBTqaZhFGKQxKmA3Zsz3j3x81qAg=;
        b=rQZ9m9CtgIvH8Uj4t2jWC9xyRjsWee7A7KHDaL3pQ4zNem4CfqZPd8PeVMBVlJoDjx
         7icq1i/MUQBaVjzw30rPBI5jqCe4Kx3TToCWoIgE4nZgqtA5IgmpIlXvdnfmcJdoJmKZ
         w6oe73GcoYKMQ6OhvI7MlKyyuGjLVtawhB0TvqYIUkPgcScBqPZZjMyZ0VV9DpiKl0i0
         +iRHiD2ZpkKKyLJI+Zky1P6NJNVuwi1b1TyM3xGXbWXtXy9LVq5V8r9hsak3eHGax6MS
         5uo8tmty2l40IGPCuOU9vj92QlL1WZvNN9ybPUQPMiG2AcxEDJGlsHQPRlZIH61Qhk2i
         Ouig==
X-Gm-Message-State: AOAM533BIySkPQvtC0tk18OiR8IW5pUbhWA5KEJB6oITV1RpMo9RgQyE
        3OHUIcXVyKa4jTRVp7GORCyZSEK8TksxErecZe8R377M
X-Google-Smtp-Source: ABdhPJyac4sOvY/FhUgGOQxoDzMAcC6vVEcQ9z4mWvdX01D3T4kamGjlGDUdmPFpFA+7c+Nvmq7aAUWOmWA+tB6sk5s=
X-Received: by 2002:a37:a147:0:b0:47a:be0e:4a0c with SMTP id
 k68-20020a37a147000000b0047abe0e4a0cmr557442qke.165.1644991843234; Tue, 15
 Feb 2022 22:10:43 -0800 (PST)
MIME-Version: 1.0
References: <20220215151022.7498-1-eajames@linux.ibm.com> <20220215151022.7498-2-eajames@linux.ibm.com>
In-Reply-To: <20220215151022.7498-2-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 16 Feb 2022 06:10:31 +0000
Message-ID: <CACPK8Xfs8=MnsmJU6WkBXdwMJ0eQvJHEVrN5AGS0YB6LUO3TZQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] hwmon: (occ) Add sysfs entry for IPS (Idle Power
 Saver) status
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
> BMC control applications need to check the Idle Power Saver status
> byte returned by the OCC poll response, so export it in sysfs with
> the other OCC-specific data.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/hwmon/occ/common.h |  1 +
>  drivers/hwmon/occ/sysfs.c  | 11 +++++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
> index 5020117be740..a88c66d36e38 100644
> --- a/drivers/hwmon/occ/common.h
> +++ b/drivers/hwmon/occ/common.h
> @@ -119,6 +119,7 @@ struct occ {
>         u8 prev_stat;
>         u8 prev_ext_stat;
>         u8 prev_occs_present;
> +       u8 prev_ips_status;
>  };
>
>  int occ_setup(struct occ *occ, const char *name);
> diff --git a/drivers/hwmon/occ/sysfs.c b/drivers/hwmon/occ/sysfs.c
> index 03b16abef67f..6dc69c9aa4c2 100644
> --- a/drivers/hwmon/occ/sysfs.c
> +++ b/drivers/hwmon/occ/sysfs.c
> @@ -63,6 +63,9 @@ static ssize_t occ_sysfs_show(struct device *dev,
>                 else
>                         val = 1;
>                 break;
> +       case 8:
> +               val = header->ips_status;
> +               break;
>         default:
>                 return -EINVAL;
>         }
> @@ -88,6 +91,7 @@ static SENSOR_DEVICE_ATTR(occ_mem_throttle, 0444, occ_sysfs_show, NULL, 4);
>  static SENSOR_DEVICE_ATTR(occ_quick_pwr_drop, 0444, occ_sysfs_show, NULL, 5);
>  static SENSOR_DEVICE_ATTR(occ_state, 0444, occ_sysfs_show, NULL, 6);
>  static SENSOR_DEVICE_ATTR(occs_present, 0444, occ_sysfs_show, NULL, 7);
> +static SENSOR_DEVICE_ATTR(occ_ips_status, 0444, occ_sysfs_show, NULL, 8);
>  static DEVICE_ATTR_RO(occ_error);
>
>  static struct attribute *occ_attributes[] = {
> @@ -99,6 +103,7 @@ static struct attribute *occ_attributes[] = {
>         &sensor_dev_attr_occ_quick_pwr_drop.dev_attr.attr,
>         &sensor_dev_attr_occ_state.dev_attr.attr,
>         &sensor_dev_attr_occs_present.dev_attr.attr,
> +       &sensor_dev_attr_occ_ips_status.dev_attr.attr,
>         &dev_attr_occ_error.attr,
>         NULL
>  };
> @@ -162,6 +167,11 @@ void occ_sysfs_poll_done(struct occ *occ)
>                 sysfs_notify(&occ->bus_dev->kobj, NULL, name);
>         }
>
> +       if (header->ips_status != occ->prev_ips_status) {
> +               name = sensor_dev_attr_occ_ips_status.dev_attr.attr.name;
> +               sysfs_notify(&occ->bus_dev->kobj, NULL, name);
> +       }
> +
>         if (occ->error && occ->error != occ->prev_error) {
>                 name = dev_attr_occ_error.attr.name;
>                 sysfs_notify(&occ->bus_dev->kobj, NULL, name);
> @@ -174,6 +184,7 @@ void occ_sysfs_poll_done(struct occ *occ)
>         occ->prev_stat = header->status;
>         occ->prev_ext_stat = header->ext_status;
>         occ->prev_occs_present = header->occs_present;
> +       occ->prev_ips_status = header->ips_status;
>  }
>
>  int occ_setup_sysfs(struct occ *occ)
> --
> 2.27.0
>
