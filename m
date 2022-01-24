Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D505F49998F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 22:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1455736AbiAXVf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 16:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382881AbiAXUtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:49:04 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E67C08C5C5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:58:05 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id v74so13827273pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=HVGqPcoZ6tA4nJhZfd9qY6ac55uc9ZaTu5VnzL123sM=;
        b=UoZnDRjvtwLGL+ZkFcMTRUht5RIXtnBkTp4T6OG0AtGfMmQrPFl9oEQK+LSaOTD9Ff
         4IgMBC8I2mCMgPlfBJQkK3VHrxcha3AZYVFNAwOwcZzAmgea+bvbp1UehK004oOm9ZDt
         2GdGVRW/O0rVSL0okB2EzJHABeN+B+OCzbNa37efKF4UpKfDdcUMbdtqli79nb1lYgdB
         AhkzshqI36hc2fxfBmdAMwT8yif1sH38wALztzkS/dESmgamvc5nJuOU9Q76HPIk9AwX
         7kdNVBsNmfqu7WibSmnqSXB8wzieNrEyCiyFmZxO0kIq6vvmJSYZRLX9BvSnuIltj+iS
         aGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HVGqPcoZ6tA4nJhZfd9qY6ac55uc9ZaTu5VnzL123sM=;
        b=0DEc5th54hqaY81mH2N2OQfc7tdkEIlcnU913iOGhVhu8HvPKPi42CxL2LFstGY5iv
         XeIlE/OD03UFUrs0BhSqBhKiqYSutSczt6wjWBkZCrjQLTzCMWmaJLvtnpjVp8UwMdjb
         Af2d09geHOlio30Llj2jqG+jjyfC2W5hEbwLfFNVVBu0CzzZtolkCU5rHZZ4Qaonier7
         cL3myX7tQdrlT4DdOppEE2vXMA4Mq53PoFiau5G3XqOtz1IsLwVvvQSXQO4CmNclOBoP
         q4SOhu7alzQM/Tb4WwsbsaAj1yXMQn5yMJsStqBIiDbwIIF/3xLjGdOoUVIV39RNKQ2q
         593g==
X-Gm-Message-State: AOAM530CeBJrT8yk+5AI8Zqd3EaLDDaZS/W+sfDTZ3gGf/N2pA6nRWds
        D05uVWxPb/dmbwXuKE528Bx9SA==
X-Google-Smtp-Source: ABdhPJx7U6j+SQSA5xpuk5vCxWu3Ky4xUij2eceN7DEhp+Ycho/C63+AuVhP3jpxuBCnbaR6tX0zww==
X-Received: by 2002:a62:e210:0:b0:4c9:1cff:15cc with SMTP id a16-20020a62e210000000b004c91cff15ccmr2941028pfi.55.1643054285206;
        Mon, 24 Jan 2022 11:58:05 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id x18sm12866584pgj.41.2022.01.24.11.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:58:04 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V6 0/5] Use CCF to describe the UART baud rate clock
In-Reply-To: <cc3b971f-c630-4ce2-e6dd-c13bcba89d22@amlogic.com>
References: <20220118030911.12815-1-yu.tu@amlogic.com>
 <7hfspjqrn7.fsf@baylibre.com>
 <cc3b971f-c630-4ce2-e6dd-c13bcba89d22@amlogic.com>
Date:   Mon, 24 Jan 2022 11:58:04 -0800
Message-ID: <7hbl00ykhf.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Tu <yu.tu@amlogic.com> writes:

> Hi Kevin,
> 	Thank you very much for your reply.
>
> On 2022/1/20 6:37, Kevin Hilman wrote:
>> [ EXTERNAL EMAIL ]
>> 
>> Hello,
>> 
>> Yu Tu <yu.tu@amlogic.com> writes:
>> 
>>> Using the common Clock code to describe the UART baud rate
>>> clock makes it easier for the UART driver to be compatible
>>> with the baud rate requirements of the UART IP on different
>>> meson chips. Add Meson S4 SoC compatible.
>> 
>> Could you describe how this was tested and on which SoCs?  There seem to
>> be some changes in this series that might affect previous SoCs.
>> 
> For me, the board starts normally and prints. My intention was to add 
> the S4 SOC UART compatible, but for the S4 our baud rate clock is 
> calculated at 12MHz by default.So a series of changes were made at your 
> suggestion.
>
> Since most SoCs are too old, I was able to find all the platforms myself 
> such as Meson6, Meson8, Meson8b, GXL and so on. I only tested it with 
> G12A and S4.But when I talked to Martin earlier he tried meson8b's log.
> The test patch is in the attachment.
>
> I have found that on some boards with this change, the initcall_debug 
> Uart driver takes longer to initialize. Running the stty command to 
> change the baud rate at the same time may cause a jam.

This kind of detail is important to document in the cover letter,
including a bit more detail on how to reproduce so that other can help
test or may have ideas for how to solve.

> I'd love to know what else you suggest.

I don't expect you to be able to test on all SoCs, but just to list what
SoCs and which boards you tested on.  This way, those who have other
boards can help test and we can have a better idea of how this was
tested before merging.

Thanks,

Kevin
