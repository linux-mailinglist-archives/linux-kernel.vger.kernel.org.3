Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F0B511743
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiD0MUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbiD0MT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:19:59 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE0B66CB0;
        Wed, 27 Apr 2022 05:16:48 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id i20so1199051ion.0;
        Wed, 27 Apr 2022 05:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vR9/a6S/9L9qoG5vKxM2YzI02WzXzNNLg/n2mKuTMEA=;
        b=Rwo92AOR89AowvwIZRFDJCISlJTT8dV2nKf1oTeQ8FJ1Gh4x8Xi1az8uAxYxxjmiRe
         EQJcGldpvQbOuC0f4Iu3HpefxfdRNbnV7fWOhVvdOdqbQyOwkkli21vRCfs8BwqHHeNb
         VVIYUcf0RhIuvTDL2N49xyewWCmzmFIMJZ8bH1mi8jVzfli9YqHPqmbG7UtlzRHUHa0g
         fcJpNbINaxjCaYMoM73NTt5ZM89fiG2wA3pT7yBKg4wseFXCizFWK7z60EUVp9bZadFZ
         1h0qSpzRfbXw9rfEV54VaVmhQlgqYhPkNQ0m6H6qsWX3yNs9RrYzlkg9b7Od6CnBaeml
         WRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vR9/a6S/9L9qoG5vKxM2YzI02WzXzNNLg/n2mKuTMEA=;
        b=7xCkMkuJWdZth2h0/0vxSCv2VOeCjfrJkbkz1kOuXCnd0Xo7Eze/p6y26cwxrrlAHg
         e4UAYLZAKbY1AGPzt03srJcCL/rYEiyAzq0gO06HY7idBHgUJBUz5YAt2Bwc59+xdzfm
         w4uLsz+FzqqCp56ExAVZq2gbv90l5Iqy42DSzsZpOuv1qmUEwFU14eFULYGo1PHpa+e/
         CpwUGgWJXHWjhTI90q0Vi3XR66pFMBdte6um0lQFxYhjgtH6bsSqKSCxgyQ4e9s3ioNL
         jRA3LtrvIdwua9p8wvc4OnF9GoHmUjwXsY1Ap3xZhYcF6rFZ15SA07Wt8COKAmLjqe3F
         R4rA==
X-Gm-Message-State: AOAM5323GqBjlRjzXCKFu9Yii6V/npoQLgGOg5Kf6+0Qkv0ctJrbA6Mo
        Nw5y+gLLicpx39hvRVwI3aCcn8L73wgE9vfLE//AlAxCBQzNVubY
X-Google-Smtp-Source: ABdhPJxP3tB/CnUTqnVFqvh6WaO0e5G8sr5EQaqsF3/VuRhQCnK57XGvNoHzUdPgI8BaGHO8ZUaNfFqtKR7ePQHcAWU=
X-Received: by 2002:a05:6638:16cc:b0:32a:7375:8472 with SMTP id
 g12-20020a05663816cc00b0032a73758472mr11946126jat.256.1651061807775; Wed, 27
 Apr 2022 05:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220426092340.495704-1-eugene.shalygin@gmail.com>
 <20220426092340.495704-2-eugene.shalygin@gmail.com> <20220426151656.GA3119637@roeck-us.net>
 <CAB95QASxuS=RDN6MRJ89O0pSpqQSaWFQVeyedGyda01FGtR7GQ@mail.gmail.com> <6d69fb63-a84f-31e5-0a88-4a154e290573@roeck-us.net>
In-Reply-To: <6d69fb63-a84f-31e5-0a88-4a154e290573@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Wed, 27 Apr 2022 14:16:36 +0200
Message-ID: <CAB95QARDq1Tr64dvPVemXHRNyu=T5P7LJ_DUn7sdHauUB6daaw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] hwmon: (asus-ec-sensors) introduce ec_board_info
 struct for board data
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry, I don't follow that part. One can add "__init" or "__initdata",
> as in
>
> static struct platform_driver asus_ec_sensors_platform_driver __initdata = {
>
> to mark a function or data structure as __init. I don't think adding
> "_probe" to the struct platform_driver variable name does that.
>

__initdata leads to modpost warning:
WARNING: modpost: drivers/hwmon/asus-ec-sensors.o(.exit.text+0x3):
Section mismatch in reference from the function cleanup_module() to
the variable .init.data:asus_ec_sensors_platform_driver
The function __exit cleanup_module() references
a variable __initdata asus_ec_sensors_platform_driver.
This is often seen when error handling in the exit function
uses functionality in the init path.
The fix is often to remove the __initdata annotation of
asus_ec_sensors_platform_driver so it may be used outside an init section.

Compiling without attributes resulted in another message:
WARNING: modpost: drivers/hwmon/asus-ec-sensors.o(.data+0x0): Section
mismatch in reference from the variable
asus_ec_sensors_platform_driver to the function
.init.text:asus_ec_probe()
The variable asus_ec_sensors_platform_driver references
the function __init asus_ec_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Here is why I added the "_probe" suffix.

Eugene
