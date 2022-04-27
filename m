Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8995B511565
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiD0K66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 06:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiD0K6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:58:49 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DC943AE3A;
        Wed, 27 Apr 2022 03:50:16 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z26so2494958iot.8;
        Wed, 27 Apr 2022 03:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OAoMj+A6jdvZS9msGVjyudUngTJlnCQJeB43kkAkA4Y=;
        b=gcv3E13hmuNS18jvZe/CZuaKOJBfS3T0jEG8xir9wWhCSls+WolK0LyI5NNsxZuBk9
         8DEzE2djwKedo/5fUwHv6Ai4n+uNVUl+AZ5b5I0DaBJISIlNW19Uux9KnB9p4YVchJyC
         uo879ZqAj9BnnFYeaBL81bxu72vFdzD4lXvWQF+LBM3s+8AISyjNpBBZkOnMLK7xTQVS
         OMqbMhFCAe6nDA5StMFepfUt23qmu9mhFUdT8MCINA1TudY+enD42jOkJjc0bVqkY7Zf
         dch1gBG76tqAstwGebweYk/BXcxK5H6eDF4truS3eWkpwCwlzCKPxoqtTb9CZ0jAfLpW
         aqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OAoMj+A6jdvZS9msGVjyudUngTJlnCQJeB43kkAkA4Y=;
        b=dvqH9or6XwuxySCs18hEzPY1jQjy/bHb20S9Ypn1nRH99aelJCM7t53e+Ad2XROTWv
         B/HU0UTI3HId9qX+iS8Pbt6NfJ50DikF9FCi4PogqO1hmCwhMEkYXF/g6SiR2wg7Isra
         +HkDZeyYBHiceFwUWpxLRXxL0yncwfec9nynbA13UeH0HD0w8yWnyb/jZUbbtEU5aWeB
         NU1RS9RR70EkWqd9C+T7pYxQDFhS6IkUejE4FtghKhEMjg/Cg4T1vL4f67v1AIyY5TSx
         fatCtbOquC6egMxkRtukczTqkDQf8l7dfbYdCWAOIPGpcqEKTJ/shCJJjqqvYvMJz3jM
         PpBA==
X-Gm-Message-State: AOAM533w5BHnCpuvnP+cpfg9htiOHhRmh/Yd5qtSdLmA5/QR+Yx2dtvm
        qjFpCBjuK9die3yOtNJWPSlCyHZB63f3mBiTmRTWOq8BHLY/FuAw
X-Google-Smtp-Source: ABdhPJz49MYR+D1KWm6MxvH1PVC7qWnal3lRMK+gwaDyn+Bh2y5jiqs1HtqWCCCOfh5un6c61CqdAPXDTwFftsuEzh0=
X-Received: by 2002:a05:6638:470f:b0:32a:d8cf:f7bc with SMTP id
 cs15-20020a056638470f00b0032ad8cff7bcmr8434768jab.108.1651051944817; Wed, 27
 Apr 2022 02:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220426092340.495704-1-eugene.shalygin@gmail.com>
 <20220426092340.495704-2-eugene.shalygin@gmail.com> <20220426151656.GA3119637@roeck-us.net>
In-Reply-To: <20220426151656.GA3119637@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Wed, 27 Apr 2022 11:32:13 +0200
Message-ID: <CAB95QASxuS=RDN6MRJ89O0pSpqQSaWFQVeyedGyda01FGtR7GQ@mail.gmail.com>
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

> Since this is now tied to MODULE_DEVICE_TABLE(acpi, ...), I think the
> probe function should be referenced in asus_ec_sensors_platform_driver,
> and it should be module_platform_driver() instead of
> module_platform_driver_probe().

As follows?

static struct platform_driver asus_ec_sensors_platform_driver_probe = {
    .probe = asus_ec_probe,
        .driver = {
        .name = "asus-ec-sensors",
    .acpi_match_table = acpi_ec_ids,
    },
};

MODULE_DEVICE_TABLE(acpi, acpi_ec_ids);
module_platform_driver(asus_ec_sensors_platform_driver_probe);

The "_probe" suffix added to keep the asus_ec_probe() code and its
deps as __init.

Eugene
