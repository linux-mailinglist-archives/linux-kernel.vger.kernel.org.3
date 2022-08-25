Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3BF5A138F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242012AbiHYO1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241885AbiHYO0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF51B6D08
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661437554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q49EiEhu4KKBgImNE6Kk4TPrRnh4uj8GAAC4ty7YwzQ=;
        b=Sbk5a/roJBLk0uJyMolbB7tcZjoLZCTiFlx2e+KSf3ldl+hzIpv/fxv0eaQe9Z+YJAF8jT
        G3HWvAFn8Fl+lw5I69/MGf6nYZEfP/6GQxH6zvELe5+k9s2FZElEeukxqY7nwTk+8jS22c
        0EqpvuAVG58g7UmEvnfNw99mGO/vXLY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-437-ihJ7s9HTO5edOk6RWYnAug-1; Thu, 25 Aug 2022 10:25:52 -0400
X-MC-Unique: ihJ7s9HTO5edOk6RWYnAug-1
Received: by mail-ej1-f70.google.com with SMTP id hp36-20020a1709073e2400b0073d6bee146aso4367114ejc.20
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=q49EiEhu4KKBgImNE6Kk4TPrRnh4uj8GAAC4ty7YwzQ=;
        b=qvebn5ko4auQ5NL8HnlspJzvrChHJuieOKAS0E7mAqQRe/khi0HSJ7VFIIW9JRfW+y
         /S9wF+SDvJwyYxKLs0G+Y6Ab1+72GYSRumJuTss2oIWn6RYBKNrQs4n0qshB4dZFYCb7
         bb35MBTkHx8xuSXSrCRQmNd/rlhrEY75zSRS89MlXQSSidH2CKrnLTum/IieHstd1irm
         WnoQnqv5NHZgFoAsr9RERQlXxl5ZTJqETt6ymWk4WQTWBpPO+ghLrMiWc77yrNh97O4S
         KGyIvTceEgT0I/q8ewOTQvlF57H3Fe96rUlNRxPxkmUjCD6+4PslBoJZDMEvC4EGT9ic
         aM+g==
X-Gm-Message-State: ACgBeo1D7xn1c+plSbO8oJUbejfihpE1yxhwQL30Skkz2O6mH3b7IYLs
        bWhDnG6dFkKo+DZmywBDcJj6Ao4dH2XiGE2IkWz1U5ls/B+9e9Tllb43jwc6CcWEZjHB3hcwVP1
        iTFuiZerLRxZap3xDNYGioqKE
X-Received: by 2002:a17:906:5d04:b0:722:f46c:b891 with SMTP id g4-20020a1709065d0400b00722f46cb891mr2735322ejt.4.1661437551543;
        Thu, 25 Aug 2022 07:25:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5E5uCelGZZVL2PStU0q6L4cU1QZeOKGrToalPkIi67JvXZz2A4Dkd4yrB6s0Xp+yWSQ3O/jw==
X-Received: by 2002:a17:906:5d04:b0:722:f46c:b891 with SMTP id g4-20020a1709065d0400b00722f46cb891mr2735313ejt.4.1661437551289;
        Thu, 25 Aug 2022 07:25:51 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id d14-20020a50fb0e000000b00447d4109e16sm107170edq.87.2022.08.25.07.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 07:25:50 -0700 (PDT)
Message-ID: <34315356-f23e-34ff-98e6-a152b588f201@redhat.com>
Date:   Thu, 25 Aug 2022 16:25:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v6 0/7] add support for another simatic board
Content-Language: en-US
To:     Henning Schild <henning.schild@siemens.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>, Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        simon.guinot@sequanux.org
References: <20220825104422.14156-1-henning.schild@siemens.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220825104422.14156-1-henning.schild@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/25/22 12:44, Henning Schild wrote:
> changes since v5:
>   - adding patch to convert to pr_fmt
>   - adding patch to prefix macros with "f7188x_"
>   - rebased p1v4 to be p3v5 and added tag
> 
> changes since v4:
>   - remove int case from a printk in p1
>   - include tags into commit messages
> 
> changes since v3:
>   - update Kconfig as well
>   - drop chip names from comment in driver header
>   - add manufacturer check for Fintek again, Nuvoton not possible
>   - drop revision printing for Nuvoton
>   - restructure defines again
>   - add new model 427G
> 
> changes since v2: (p1 only)
>   - rename macros that change behavior
>   - use chip type not device id in the macros
>   - reorder defines a bit
> 
> changes since v1:
>   - remove unused define
>   - fix bug where (base + 2) was used as second data bit
>   - add macros for "inverted" and "single data bit"
> 
> The first two patches apply some style refactorings before actual
> functional changes are made.
> 
> Later, This series enables a SuperIO GPIO driver to support a chip from
> the vendor Nuvoton, the driver is for Fintek devices but those just are
> very similar. And in watchdog and hwmon subsystems these SuperIO drivers
> also share code and are sometimes called a family.
> 
> In another step the individual banks receive a label to tell them apart,
> a step which potentially changes an interface to legacy users that might
> rely on all banks having the same label, or an exact label. But since a
> later patch wants to use GPIO_LOOKUP unique labels are needed and i
> decided to assign them for all supported chips.
> 
> In a following patch the Simatic GPIO LED driver is extended to provide
> LEDs in case that SuperIO GPIO driver can be loaded.
> 
> Last but not least the watchdog module of that same SuperIO gets loaded
> on a best effort basis.
> 
> The very last patch enables a second model of that same board type.
> 
> Henning Schild (7):
>   gpio-f7188x: switch over to using pr_fmt
>   gpio-f7188x: add a prefix to macros to keep gpio namespace clean
>   gpio-f7188x: Add GPIO support for Nuvoton NCT6116
>   gpio-f7188x: use unique labels for banks/chips
>   leds: simatic-ipc-leds-gpio: add new model 227G
>   platform/x86: simatic-ipc: enable watchdog for 227G
>   platform/x86: simatic-ipc: add new model 427G

So it looks like all these patches are ready for merging now,
the only thing which is missing is an Ack from Pavel or
one of the other LED people for patch 5/7.

Pavel can have your ack for merging this through another tree
please?

So what is the plan for merging this?

I see 2 options:

Option a:
1. Merge the GPIO changes (patches 1-4) through the GPIO tree; and
2. Merge the leds + pdx86 changes through the pdx86 tree

Option b:
Merge everything through the pdx86 tree, and I will then provide
an immutable branch + signed tag for other subsystems to pull
(if they want to).

Regards,

Hans

