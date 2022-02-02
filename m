Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42324A7431
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345313AbiBBPEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiBBPEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:04:22 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19A5C061714;
        Wed,  2 Feb 2022 07:04:22 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id l5so42495702edv.3;
        Wed, 02 Feb 2022 07:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWu5pDMV1z9EmfaCLWyaLnspdjFYx8WMWSWMsW9MZfM=;
        b=ASPPkxAbndGOdZ2beML4k/g6klMhIr3bRHdGzh1IPqYXOJesPkBCe0mGArORQasiE8
         aZtWiF3U5D7lpXcTkcr7qqTXOgEbep2LbcJc/+pMkKSZ8/UlR2UsMgxVc0iQk2pFrDS3
         CiNM8qQ5zXfFhlnhnrzRgeYI6dwYJ6MXMB24itST/Jqz5szETzrgKgYR7DmWcPjWIwv7
         atPzSqO+53QBit1zHItb7xgJmVr8Y/okudp3ZyyS1/kzwoGL78JKzl0yJge68iWAhLT+
         Sg0s16dUvJjrB4JuXIx3gAT3EhsolXZLqyNqQs15RM1gA8mruL/fku+Fwdq3gpykqyl1
         jfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWu5pDMV1z9EmfaCLWyaLnspdjFYx8WMWSWMsW9MZfM=;
        b=IT1Hef8SJUcmI4wdLhK9QIV36axIi/XKMxD4MoON/Aemt/T0wkBiywqGi/QjYIOimW
         5gsp83qJFWfnqa5EUFICPSKMiSskxpWc903v3c9Remp0xLqgAKp372f2TkyQNYKQdSZK
         X/U8qysbZ6J2DJubDOwr0g9IMT6Y4ogRNRmDfXKYHv350+4XlQ6DHlJMqz3gZfLDBpZ3
         ZA1/kqPOV6DbNlX4Oz7llteMSElj6zpxQ6SUvTgfRKbYDlkK3CDXdzpN940eZbGMnnga
         NG+FVH+WCqgnckwuGfVH/7lafo1ILP4ZB25cIAtUXHK/eD5lJYfTZ2snnz1ThP7kYk53
         9bUw==
X-Gm-Message-State: AOAM533zdEHCZAqrT6CUQC/MrVDkPw9T6tVQMKhXCVo2mfC2uJzA7pTM
        EgZekscx+pFw2kDpQBgwYFxWknaOTPwe6xmdSyo406uyg3I=
X-Google-Smtp-Source: ABdhPJye62W0y+8r30tWYoHFNgkRmHXKCFhpGyEiCKZcn+iMaqsVBM87HTA+JAuKnjgrk94cl5yRV4hww4Bfo0rRyTw=
X-Received: by 2002:a05:6402:1705:: with SMTP id y5mr30480593edu.200.1643814261117;
 Wed, 02 Feb 2022 07:04:21 -0800 (PST)
MIME-Version: 1.0
References: <20211208135644.3523024-1-n.latmos@deepsea.ai> <CAC-bbXbkt0oYPn+EWLdEYKyj8G_muWGDZWTApyFv3cb591dc0A@mail.gmail.com>
 <20220130151737.43ef5b08@jic23-huawei> <FR3P281MB0537EEAEC0F836E5CC895C2BCE259@FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR3P281MB0537EEAEC0F836E5CC895C2BCE259@FR3P281MB0537.DEUP281.PROD.OUTLOOK.COM>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 2 Feb 2022 17:02:46 +0200
Message-ID: <CAHp75VfLFKinChE2H-Lsb1A50JOOMettsshSZWoDkVNSW6ckLQ@mail.gmail.com>
Subject: Re: [PROBLEM]: Error during probing process in inv_icm42600_i2c driver
To:     Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Nikos Latmos <n.latmos@deepsea.ai>,
        "jmaneyrol@invensense.com" <jmaneyrol@invensense.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 10:17 PM Jean-Baptiste Maneyrol
<Jean-Baptiste.Maneyrol@tdk.com> wrote:
>
> Hello,
>
> this is a known issue. When setting I2C parameters, it enables some specific filter for improving transfer quality. These filters are by default disabled to enable I3C usage.
>
> This operation creates a spike in the lines that make the transaction fails even if it is in fact doing OK.
>
> Do not change the register value. The fix is to ignore the return value of the regmap_update_bits done on INV_ICM42600_REG_INTF_CONFIG6.
>
> If you want to create a patch, it would be very welcomed I could review it.

That patch should have a good comment to summarize the above.

-- 
With Best Regards,
Andy Shevchenko
