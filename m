Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2ED4B80CE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 07:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiBPGqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 01:46:40 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiBPGqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 01:46:39 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE1A22BDF8;
        Tue, 15 Feb 2022 22:46:20 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id x5so1211977qtw.10;
        Tue, 15 Feb 2022 22:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XS4kLUNe+IZUuCNJBO1SJPPEbuousn0y/b6MeXhwcE=;
        b=U6xlUW2G7CBkjX5Crf4XgUS0U7WRFsrbEUBpEjblJWIu0xtg4LzVxQUehE4ZxbTjv4
         gayuTt24Ah902YuIOb7MFBeYlC3ryKbGQC7DxEI+NHbp5hQmoVBlLEUHOvbYQUNQF9fM
         cmMqpKuAEhRFeMu4dOC0dApTv5wEnbshEbQzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XS4kLUNe+IZUuCNJBO1SJPPEbuousn0y/b6MeXhwcE=;
        b=TlyHfma6sOpkDzJchmcjcElMUDuYZWCWPAdWkQNMp4Mpzq1vcnOVXcm7fkPuPC3nLs
         Sy+OsTihfF1ralu1NZ/44T4i1r5X+jfcLnrBT4MMQ99/uPxO+e/nRntPREcBRlH0BdiI
         ulaqV0X9UrmhO2ThuzGLGgq8SegSaODKvkqwLV4OJnTrB42/MRr13W5z0y0J58phywux
         nX1nsWYBFzaaS6pCGGtz3kyRHSfjv2MszNxZQHTYC7kV8OrhCibkQbFVUaOr9AysoBPt
         E1eiasTxrmpxb4DKX/Nb+dEqKIDJXjbHkHyLchWKXxH96Euvn9yfg6dxDppwQRooU/Bl
         vQZA==
X-Gm-Message-State: AOAM532JRXVYM/f5SePKn4HuQ7CBmW6G+pNnjtGR3Pj29GuxqL+P+lb/
        faCF8kJ8wbSzgrDMf8eUBt0xnUnPmsV493/49MX3Zgiv
X-Google-Smtp-Source: ABdhPJxR8AyxoX+WWn1H3SzPot8I7lRW3fMjMORcGOksDawBB0Sdpvgh8N+BFtwatYalcZ8srn0jbnH0BlLiKVlVY8s=
X-Received: by 2002:a37:a147:0:b0:47a:be0e:4a0c with SMTP id
 k68-20020a37a147000000b0047abe0e4a0cmr577727qke.165.1644993248256; Tue, 15
 Feb 2022 22:34:08 -0800 (PST)
MIME-Version: 1.0
References: <20220215151022.7498-1-eajames@linux.ibm.com> <20220215151022.7498-5-eajames@linux.ibm.com>
In-Reply-To: <20220215151022.7498-5-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 16 Feb 2022 06:33:56 +0000
Message-ID: <CACPK8Xe+M97Covu0+Qc9M-8vdCc9pTXfZjJ9y6_Xm-j1E4GUPQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] hwmon: (occ) Add soft minimum power cap attribute
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
> Export the power caps data for the soft minimum power cap through hwmon.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/hwmon/occ/common.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> index 0cb4a0a6cbc1..f00cd59f1d19 100644
> --- a/drivers/hwmon/occ/common.c
> +++ b/drivers/hwmon/occ/common.c
> @@ -674,6 +674,9 @@ static ssize_t occ_show_caps_3(struct device *dev,
>         case 7:
>                 val = caps->user_source;
>                 break;
> +       case 8:
> +               val = get_unaligned_be16(&caps->soft_min) * 1000000ULL;
> +               break;
>         default:
>                 return -EINVAL;
>         }
> @@ -835,12 +838,13 @@ static int occ_setup_sensor_attrs(struct occ *occ)
>         case 1:
>                 num_attrs += (sensors->caps.num_sensors * 7);
>                 break;
> -       case 3:
> -               show_caps = occ_show_caps_3;
> -               fallthrough;
>         case 2:
>                 num_attrs += (sensors->caps.num_sensors * 8);
>                 break;
> +       case 3:
> +               show_caps = occ_show_caps_3;
> +               num_attrs += (sensors->caps.num_sensors * 9);

How do we know this changed from 8 to 9?

We should start adding links to the occ source code, or a similar
reference, when making these changes so they can be reviewed.

> +               break;
>         default:
>                 sensors->caps.num_sensors = 0;
>         }
> @@ -1047,6 +1051,15 @@ static int occ_setup_sensor_attrs(struct occ *occ)
>                         attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
>                                                      show_caps, NULL, 7, 0);
>                         attr++;
> +
> +                       if (sensors->caps.version > 2) {
> +                               snprintf(attr->name, sizeof(attr->name),
> +                                        "power%d_cap_min_soft", s);
> +                               attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
> +                                                            show_caps, NULL,
> +                                                            8, 0);
> +                               attr++;
> +                       }
>                 }
>         }
>
> --
> 2.27.0
>
