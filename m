Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C994B1A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346454AbiBKAkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:40:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346447AbiBKAkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:40:22 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5477A5F8B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:40:19 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id e79so9513580iof.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=lFCvE5g2JTD7Wl81REd7Gq5kC+E/CgUSaN7wy6qbWOE=;
        b=VtYPNobKD09wldiKKvTu91rXQCR0IYONn5V1OzDhc2Cdc3IOtrLo6mBgEZ3sqH3Pfa
         IN32zk1uZODJ1Jz7OyVbpEuHVXgb5hv+WW3p7NOcK6LMcaHhnw5NAWexF1O+I5tuYFVj
         wTtYO5MC8v2Ogp0J+wzT5vCnkG16XHFKJq57XSh2W1WiT5X0FhwmNAUz7xLMdkCJI/vj
         I8Dcr88qlqQkPLTrgDMQJMX4N3mwKi5bKAxTAOf1Z8rBOflBExxdGoTXIhAMLz6Jebzv
         YxCvRShMHjL0tmfzkpChHFXTGv6ykKmpjblS3sTwUu4QMmEgWBGVQv0LUr8Fexfh3w/e
         BnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=lFCvE5g2JTD7Wl81REd7Gq5kC+E/CgUSaN7wy6qbWOE=;
        b=TuPZJaMZNXuQNsgA9YLqRLfU8KB8SO2jvyXlXxx2N00k3XPYhZHtEx6K9T4NkOI4KE
         vbdur1dR5iSKd4iWd7E3IQMg7TkiFJt9Idu3OY1s43aNTJQqZcFac4KcujO8vfjFyvSv
         y+IB0YDu/NpukiDcR8slX6cNO4HzEFGpW3YuiRpuJ0LSLzX5ISqXwJR57MSGGe0cLjWD
         C4YdzRm4vaU+Kniu/V0pvV6SLso+dcg6Atq+9Cis4JUliqPLwKqvmh2vd56njvuwxKUI
         uyt3Z3YZMgIGqV858/GLGtCdG6TXgZa0lL3nPjxFs2bpM600NPWYIgDZgUH0Da41M4CO
         XCPQ==
X-Gm-Message-State: AOAM533uxbvQbcQNkNPx6pG55tjYW3/XbyKmwbzopm0v9PHR48wNdNnt
        w3Rto3bPEpwMspgZQ8AbT7rg5M4V7Sn9zZbEU20=
X-Received: by 2002:a5d:9d9e:: with SMTP id ay30mt5247367iob.192.1644540018688;
 Thu, 10 Feb 2022 16:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20220211003641.73111-1-eugene.shalygin@gmail.com>
In-Reply-To: <20220211003641.73111-1-eugene.shalygin@gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Fri, 11 Feb 2022 01:40:07 +0100
Message-ID: <CAB95QAS4ow16O6Fb8Q_q5yoZaUzVaBWF59PgmdBCfOsxM0ugpA@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) deduce sensor signess from its type
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,FREEMAIL_FROM,
        MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022 at 01:36, Eugene Shalygin <eugene.shalygin@gmail.com> wrote:
>
> Reading DSDT code for ASUS X470-based boards (the ones served by the
> asus_wmi_Sensors driver), where ASUS put hardware monitoring functions
> into the WMI code, reveals that fan and current sensors data is
> unsigned. For the current sensor that was confirmed by a user who showed
> high enough current value for overflow.

Denis, you might be interested in fixing temperature sensors in the
asus_wmi_sensors driver too.

>  static inline s32 get_sensor_value(const struct ec_sensor_info *si, u8 *data)
>  {
> -       switch (si->addr.components.size) {
> -       case 1:
> -               return (s8)*data;
> -       case 2:
> -               return (s16)get_unaligned_be16(data);
> -       case 4:
> -               return (s32)get_unaligned_be32(data);
> -       default:
> -               return 0;
> +       if (is_sensor_data_signed(si)) {
> +               switch (si->addr.components.size) {
> +               case 1:
> +                       return (s8)*data;
> +               case 2:
> +                       return (s16)get_unaligned_be16(data);
> +               case 4:
> +                       return (s32)get_unaligned_be32(data);
> +               default:
> +                       return 0;
> +               }
> +       } else {
> +               switch (si->addr.components.size) {
> +               case 1:
> +                       return *data;
> +               case 2:
> +                       return get_unaligned_be16(data);
> +               case 4:
> +                       return get_unaligned_be32(data);
> +               default:
> +                       return 0;
> +               }
>         }
>  }

I would appreciate it if anyone could help me to collapse this
ugliness somehow, without multi-level macros, please.

Thank you,
Eugene
