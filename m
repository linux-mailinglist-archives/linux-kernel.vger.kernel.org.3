Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4534D591361
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbiHLP77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiHLP74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:59:56 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD659ACA36;
        Fri, 12 Aug 2022 08:59:54 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-31f445bd486so13991677b3.13;
        Fri, 12 Aug 2022 08:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=yysyImrhLlAY3C/TnSWpE64J+UbkveI1E/t+93CXsL0=;
        b=DgENi7+Ue7tLt1Pl1ATDN/XTcVA8oZ11rYTH6oQuCaPzAbVl6qaCfuTpj9qI26ZZVW
         QBIO4rIM7IbS3Dg3vOfbaEtgIke84amPjcqSDutDFqwnYkQLSceJfOTjxYFN1k1YtWcy
         P+3VpS+Y40Af8ERo+bDBxXdodKQIfyH0pw+xF4vVubzHRoWEN8nOxJez5zVg1n7GBmMg
         nsYBY8Kt9RS7Ygg1N2oSKhkkBufuHzdLOxfFP5vQprX+6MNvIlZNKV4IWqGfNEOKKy+U
         ne5La8Cv8mQ7S7edF6NDWoP9tIpON4feSfKQeNHcSEMgXOyHdyB+YEuzjbadYBB4aHMk
         0hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yysyImrhLlAY3C/TnSWpE64J+UbkveI1E/t+93CXsL0=;
        b=pl8FGOKhnKnOYuGBdDdUlisPITo9LS7F24jzl5Wh8+kxateOv8WPVz8zAZfHVzBrVB
         Myx7RGudJklJXoKlotWBfPIE/K0yaSwL9BvC+haU1tnIZCuBnqkdCkTZsL1xUHWrsktA
         bOimWb7Plz02sT3U1G1fhr6F/VYmLSRH2ll6HKnbv8mEMd2JLbW1/ZrNZaFHecaKF19Z
         hxbnf3VFjkKHOPU0xNxYNdEj0duFbAiZmBUTwelhWbVbINKzvalyrhJYCybhazXoFeZK
         pwXj8YhQybpWBZIWfHzOt9epB+Gdpc0YP3bE1LQ2xIezob2na2bh509kPYldI5NMNC6i
         Szaw==
X-Gm-Message-State: ACgBeo15wt14DLY5pk0ebPy1OR5rEolaKT/+vwRtJT+y7mUg8mGQD7wh
        OIh0Cm+upEWtggNMVoZiSqS+OFWBKS0mS76VU+I=
X-Google-Smtp-Source: AA6agR46a2BAgn9IO/KQvgr9BK5Qz69v5A6HGK5pb3pOb5T/UozNYNDng0Wi88vvrjixsnuaPPOAsjR0SNEcqURn0QE=
X-Received: by 2002:a0d:d849:0:b0:324:8602:7ca9 with SMTP id
 a70-20020a0dd849000000b0032486027ca9mr4253369ywe.481.1660319994018; Fri, 12
 Aug 2022 08:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220804113052.1117009-1-gregkh@linuxfoundation.org>
In-Reply-To: <20220804113052.1117009-1-gregkh@linuxfoundation.org>
From:   Roderick Colenbrander <thunderbird2k@gmail.com>
Date:   Fri, 12 Aug 2022 08:59:43 -0700
Message-ID: <CAEc3jaApj_=eEgOWzhfh06PXKU7DO1zAsR8tG-SD3vva5duTtw@mail.gmail.com>
Subject: Re: [PATCH] HID: playstation: convert to use dev_groups
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        linux-input <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for the patch. It looks good and confirmed it working properly.
(Replying from personal email... corporate email systems *Exchange*
don't work well with GIT)

Acked-by: Roderick Colenbrander <roderick.colenbrander@sony.com>

Thanks,
Roderick Colenbrander

On Thu, Aug 4, 2022 at 4:32 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> There is no need for a driver to individually add/create device groups,
> the driver core will do it automatically for you.  Convert the
> hid-playstation driver to use the dev_groups pointer instead of manually
> calling the driver core to create the group and have it be cleaned up
> later on by the devm core.
>
> Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/hid/hid-playstation.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
> index b1b5721b5d8f..40050eb85c0a 100644
> --- a/drivers/hid/hid-playstation.c
> +++ b/drivers/hid/hid-playstation.c
> @@ -692,15 +692,12 @@ static ssize_t hardware_version_show(struct device *dev,
>
>  static DEVICE_ATTR_RO(hardware_version);
>
> -static struct attribute *ps_device_attributes[] = {
> +static struct attribute *ps_device_attrs[] = {
>         &dev_attr_firmware_version.attr,
>         &dev_attr_hardware_version.attr,
>         NULL
>  };
> -
> -static const struct attribute_group ps_device_attribute_group = {
> -       .attrs = ps_device_attributes,
> -};
> +ATTRIBUTE_GROUPS(ps_device);
>
>  static int dualsense_get_calibration_data(struct dualsense *ds)
>  {
> @@ -1448,12 +1445,6 @@ static int ps_probe(struct hid_device *hdev, const struct hid_device_id *id)
>                 }
>         }
>
> -       ret = devm_device_add_group(&hdev->dev, &ps_device_attribute_group);
> -       if (ret) {
> -               hid_err(hdev, "Failed to register sysfs nodes.\n");
> -               goto err_close;
> -       }
> -
>         return ret;
>
>  err_close:
> @@ -1487,6 +1478,9 @@ static struct hid_driver ps_driver = {
>         .probe          = ps_probe,
>         .remove         = ps_remove,
>         .raw_event      = ps_raw_event,
> +       .driver = {
> +               .dev_groups = ps_device_groups,
> +       },
>  };
>
>  static int __init ps_init(void)
> --
> 2.37.1
>
