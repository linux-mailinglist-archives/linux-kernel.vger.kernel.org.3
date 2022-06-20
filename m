Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43053551207
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239567AbiFTIBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239707AbiFTIBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:01:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399EB11466;
        Mon, 20 Jun 2022 01:01:09 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eo8so13993219edb.0;
        Mon, 20 Jun 2022 01:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OcVNrdlKP0GzMJkVBTzuRwNNS1pphGPVCvGxdcsqxXM=;
        b=ZucKaM0hl9UaeOsS2jAiYrP7lYP/mB4+nF/VfhP40XaBJyQu0CaKHFqZpZN+ZTwjY4
         8W7/FAju6FiP8pSfaWpFFgPmVFANIh6OTyvDr2KKgmEAXA0U5NUb01d38Gk8bZ9FGSxE
         ASBpeHYELSSAKBCHbEs6aE2J/bkHh9Dmrgntylfs+5k+F1rJb0ylTTbx34mxyZpq2atr
         Os+KZL3lriMqh+4Jp3EyAHbcIqn6aEYJtHriXF2h7mGM3b3hePnw5wR1ZlUSmkllLO/Y
         a3zINgixA1yks1eRLy2xSp3C2hZ1yb5BLJ3qeAKJOUqKiMjdZiTLH7EDEVnWtprL0R4n
         kCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OcVNrdlKP0GzMJkVBTzuRwNNS1pphGPVCvGxdcsqxXM=;
        b=CfB0A453cI9kLSrBlCFInt+KCwCutJJoJtdOaIiHuMx+kjWkDvjhACiYEY1FTsxBhH
         nSeCRwsongwhtPj6D5VBFBTGQaOM4SYTPVY1OM4VS589sTXenZ+WvfSWLiC6ahrbPkr6
         pUD8nHTlEz9nH1BTw5O4RKaWh4Q7I8mMgM3GglGbHCk43CLketXInKmtp+Q3HfRgyLtZ
         RdBvNXpW/Wy9mOiYfKs+FveRZV6hNTZgJGGfe20UKuwGkX1l38u0GGCGH0VTCAgwZ9Y1
         79TJbdHT2GK/5GvXyRBBKvrx8KHomrIURnHLFmhI/0NfdcHZjzmvo6bN6ZtIw90TqFlS
         ZVXA==
X-Gm-Message-State: AJIora/TnuwZjKg7tR/ktiMRcRk3vlX2gatAF2jSUQiPtt7WRCcJE2OT
        Wlc0odT0UW+z9mV+SayqT8LxPX40npiUdpYuRPY=
X-Google-Smtp-Source: AGRyM1tA6kLSMzKCwH9JDPtey2pJ1C/MO5M13HPYA86Vm/MJKxqvE2quxGRMO2o0vPxLw/3eZP316rKgVBj7IxInrn0=
X-Received: by 2002:a05:6402:249e:b0:42d:bb88:865b with SMTP id
 q30-20020a056402249e00b0042dbb88865bmr27299794eda.141.1655712067695; Mon, 20
 Jun 2022 01:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220619074030.1154429-1-mw@semihalf.com>
In-Reply-To: <20220619074030.1154429-1-mw@semihalf.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Jun 2022 10:00:31 +0200
Message-ID: <CAHp75VdmtFJe5k_6biofS0HtgqC7HQuNzrM=9cMhM1uz1p5Eng@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: dw: enable using pdata with ACPI
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>, upstream@semihalf.com
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

On Sun, Jun 19, 2022 at 9:43 AM Marcin Wojtas <mw@semihalf.com> wrote:
>
> Commit 3242fe805b52 ("serial: 8250: dw: Move the USR register to pdata")
> caused NULL-pointer dereference when booting with ACPI by unconditional
> usage of the recently added pdata.
>
> In order to fix that and prevent similar issues in future, hook the
> default version of this structure in dw8250_acpi_match table.

Thanks for the report and fix! One proposal below.

...

>  static const struct acpi_device_id dw8250_acpi_match[] = {
> -       { "INT33C4", 0 },
> -       { "INT33C5", 0 },
> -       { "INT3434", 0 },
> -       { "INT3435", 0 },
> -       { "80860F0A", 0 },
> -       { "8086228A", 0 },
> -       { "APMC0D08", 0},
> -       { "AMD0020", 0 },
> -       { "AMDI0020", 0 },
> -       { "AMDI0022", 0 },
> -       { "BRCM2032", 0 },
> -       { "HISI0031", 0 },
> +       { "INT33C4", (kernel_ulong_t)&dw8250_dw_apb },
> +       { "INT33C5", (kernel_ulong_t)&dw8250_dw_apb },
> +       { "INT3434", (kernel_ulong_t)&dw8250_dw_apb },
> +       { "INT3435", (kernel_ulong_t)&dw8250_dw_apb },
> +       { "80860F0A", (kernel_ulong_t)&dw8250_dw_apb },
> +       { "8086228A", (kernel_ulong_t)&dw8250_dw_apb },
> +       { "APMC0D08", (kernel_ulong_t)&dw8250_dw_apb},
> +       { "AMD0020", (kernel_ulong_t)&dw8250_dw_apb },
> +       { "AMDI0020", (kernel_ulong_t)&dw8250_dw_apb },
> +       { "AMDI0022", (kernel_ulong_t)&dw8250_dw_apb },
> +       { "BRCM2032", (kernel_ulong_t)&dw8250_dw_apb },
> +       { "HISI0031", (kernel_ulong_t)&dw8250_dw_apb },

Since you are touching all of them, please keep the order
alphanumerically sorted by the HID.

>         { },
>  };


-- 
With Best Regards,
Andy Shevchenko
