Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0891C58F072
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiHJQa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiHJQaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:30:22 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960FA1DA7B;
        Wed, 10 Aug 2022 09:30:21 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso2710008pjo.1;
        Wed, 10 Aug 2022 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=vufaLke+Y9C89yfo1scfSCBU7Vp0KeQxf8BAAfrZOJE=;
        b=OylVwTohrej7zPKGOwHnYwuXSw9/G5QWILPZzXbeuMut1OO+Hjrto4A6wGNsY5FMgV
         a0V449p9II9Fh4YjOh2s7FWvhiscr/GF70/T2Xs9rVQou/HMzD+mp9jYnNMXbUOwlj2j
         +rYwwbSHxMQchGn/XSLAN+v8WWNBHgvSd+3h0ynpSLm5hESx8Rg3LlBsUPrFfuaSY7v2
         hmWLUthAI3QdJGj82tMB4yEU798bEslMyHowCSWk2UwTmGdes8r2JFQwqYo22kkSyVFl
         GUlfr6wvAcYK1ntbo+zEHtc9exNAD9ZL/ZgeVGTTaA4A6Wagit/savUGUtuMi0oskROD
         A9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=vufaLke+Y9C89yfo1scfSCBU7Vp0KeQxf8BAAfrZOJE=;
        b=DV3B9vwyv4El2aXpYnSwSIJwfVMcvHRlMpofzi7mKZyqDY3HVaRZTmjkS6TfZKH5Uy
         jslFHaSDv1Tva4xpZzjdaxuyiyuWakn3XEC00FNKwFHeHkjCgpHWr3VZwZrW1YDv5mv5
         Vb1Ug1jkrsMPec3F9QAzacGsConfSpW1JjYynMDktjFDdnBT1dMP4DIL6W3SGZB4xnRJ
         jcOl/FO5oDTrdznyGjiC9y3/qu/JESfZ9X5oys55kgBzn/UArod+HCGEfEuJ3VP7Xdif
         MzB7Fl+HJfgddrn24Jm+renI+9IG/FChmCeR4glbIO7qp0ua8ojwcx8TJOWIrhWD5TmX
         QJrg==
X-Gm-Message-State: ACgBeo3WRzp0+nugWqzeAixvTh6OPKh+8o80ljaXjHWuez2e4ZLV5LNo
        5951p95Y0oilXUK8iwC05uG3qFWjqH0=
X-Google-Smtp-Source: AA6agR5+mp0MTJWz54wqhnOlm+q8JR+cdwomVm/VefBywcbOpwIrEeKHB9YaC21NCg+b8Kjt4E2fKA==
X-Received: by 2002:a17:902:d2c8:b0:16e:ea4e:36e0 with SMTP id n8-20020a170902d2c800b0016eea4e36e0mr29257389plc.37.1660149021086;
        Wed, 10 Aug 2022 09:30:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090b078b00b001f4d4a1b494sm1873037pjz.7.2022.08.10.09.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 09:30:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ce384ba2-2801-b820-3e96-cfd5636c3c71@roeck-us.net>
Date:   Wed, 10 Aug 2022 09:30:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/5] ACPI: Rename acpi_bus_get/put_acpi_device()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
References: <12036348.O9o76ZdvQC@kreacher> <4763162.31r3eYUQgx@kreacher>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <4763162.31r3eYUQgx@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 09:14, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because acpi_bus_get_acpi_device() is completely analogous to
> acpi_fetch_acpi_dev(), rename it to acpi_get_acpi_dev() and
> add a kerneldoc comment to it.
> 
> Accordingly, rename acpi_bus_put_acpi_device() to acpi_put_acpi_dev()
> and update all of the users of these two functions.
> 
> While at it, move the acpi_fetch_acpi_dev() header next to the
> acpi_get_acpi_dev() header in the header file holding them.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/bus.c               |    6 +++---
>   drivers/acpi/device_pm.c         |    4 ++--
>   drivers/acpi/irq.c               |    4 ++--
>   drivers/acpi/scan.c              |   21 ++++++++++++++++-----
>   drivers/hwmon/acpi_power_meter.c |    2 +-

For hwmon:

Acked-by: Guenter Roeck <linux@roeck-us.net>
