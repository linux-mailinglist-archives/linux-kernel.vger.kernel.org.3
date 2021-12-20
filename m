Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A7847B434
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 21:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbhLTUFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 15:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbhLTUFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 15:05:32 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E91C061574;
        Mon, 20 Dec 2021 12:05:32 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id g26so8415542lfv.11;
        Mon, 20 Dec 2021 12:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qqja4ulZwPhOxbg/bnQaKERAlBmKCgAEDMqxEQbrLy8=;
        b=AaIjDoRhyIYd6O6yPJSRn4srhbM/mDG9EGY8OASxLUlgKW0A04PYiJ1oHMbcZxQzmY
         b3+z1aTkyugzM3OreReISFzlMC2feQdKH3uttazzJ6RQmY3jHoQA1Sm+TJ2sMpOVRIdx
         sS0kdT47FywfaDFo6k/MGtZ/IKOe1nDbgrlcBcgDLaMKth3M9JMDaD74y10oHPx2yjcH
         mBS4Dw/2fRJLUoR+kcJg1o2jBGZ7i5ceFiJMCrCBDc5cEINoim7zslJBP/flghq92Lz1
         jHa7oxvWwzJ4ftlqxkkQFn+aS36ZB8ZN57jc50LcOZER/Snc8jWYtzIq4OdWcEItIK4E
         8ZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qqja4ulZwPhOxbg/bnQaKERAlBmKCgAEDMqxEQbrLy8=;
        b=zacFY6cA85kHw91D96vrGeuchyIBJyBU0eMOkHCbvE4iemRcp6o8xu7GI4LP1k+khn
         870NK3jxA/wQv19FAAZ6uoT19L+r3LffT8hbRUDGKxPNl4idU/ZYPV+b4C1zQIWF4EJJ
         Q37JQbXXrhN+KKFOEp9CpYEPSR65o5EU5+IpgOSto+5Ku5vTEtbvJjmxGXcCtKrULcrN
         gv/QRfO3KqZn9V7ZLzpxufSxX9UgM1XkKRnTpG9jagSnO26pS+WjfkK88B6ySRbkNR1V
         pwCImSnSnWg0HTCBQbfoHKA1cV4WJH0qMKEu6gW/LGdj4D7R+yzc8nv9BXwWJTwijBaE
         8OYQ==
X-Gm-Message-State: AOAM530XgP19dArkXKRIe5Z3i/ie8X4DNcRiU0JtHIF2+9ANcAmWxvJV
        Ny+jGwjZQf+E4S0iisGmKyU=
X-Google-Smtp-Source: ABdhPJzKVjZhqzGZVthQwTEdRoAmCxsCW7o+afjEC+J8DQzahHZu07y5nUFQDR1CLwlQf4FXjGySeQ==
X-Received: by 2002:a05:6512:3f98:: with SMTP id x24mr17444572lfa.87.1640030730299;
        Mon, 20 Dec 2021 12:05:30 -0800 (PST)
Received: from [192.168.2.145] (46-138-43-24.dynamic.spd-mgts.ru. [46.138.43.24])
        by smtp.googlemail.com with ESMTPSA id g4sm2462594lfv.288.2021.12.20.12.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 12:05:29 -0800 (PST)
Subject: Re: [PATCH v17 1/7] usb: misc: Add onboard_usb_hub driver
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>
References: <20211116200739.924401-1-mka@chromium.org>
 <20211116120642.v17.1.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <07781322-3632-7d63-0da8-a651a438a3ff@gmail.com>
Date:   Mon, 20 Dec 2021 23:05:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211116120642.v17.1.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.11.2021 23:07, Matthias Kaehlcke пишет:
> +static const struct usb_device_id onboard_hub_id_table[] = {
> +	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS0411 USB 3.0 */
> +	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.0 */
> +	{},
> +};

RTS5411 two times in the comments? Internet suggests that RTS5411 is USB 3.0

Are these hubs expected to be powered-on only when upstream port is
enabled? Shouldn't runtime PM be used for that somehow?
