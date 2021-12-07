Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423E746B7D5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbhLGJtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbhLGJqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:46:55 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5921C061574;
        Tue,  7 Dec 2021 01:43:25 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y8so9055136plg.1;
        Tue, 07 Dec 2021 01:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M26x5UvlFo70PWzW7kaxBf+q+G00WQfZ+Q0ntnHnbLY=;
        b=pGJmJ0NP1NOGZ2NPAQfIIES/ZDzgnLdpK4WXWUmiiuAQIXkrZn07+L/wjHmJoR2jkQ
         tB2pyBNdeXpH4lj08vqJQx606notQkjiIbwYXgkOLJGX2wNnbR93MyyTqt3QrjFYDl+E
         7do9zYIm/5vb9PrQicEylejphIisuVjIMrxvzfuek0CI6p4qZ/ZiMWQDCTsadfl6JCE4
         GVE39JSnzOZsKSF0S95d9vwcMGWlY4Dn2NBy89Iwb/g9vXlH3G2Yghjkf4Nsb/TJQ4U0
         ESrD9rU/ixXx/wLatDHIwsfVk0y9BS+s9JRwUvSij+09CRyvyoc3LF2w4Qlz2NlOHswo
         MIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M26x5UvlFo70PWzW7kaxBf+q+G00WQfZ+Q0ntnHnbLY=;
        b=qgwDC5DCS2hf4HAF7s/wsBADavMrbM+R/YlS4TGL/kERFdo9EsCsEx/q9dC4a2HMIk
         N6Fg0WDCP6PRuBLSw5q7Izfku49oOHDCZcfIJt5HyYLZs2YcM5wqwF8iNyqqNlDIVr40
         uyljG+hX2TKDCnPgS6sa24O1/ohfJj8UiqIqyICXl8SIqv/Iz7y0UH9pxhVlEt0d3X/W
         fqSUwxi26eiaAR8uTAn69QSNpPJu2aar7uP9iJ6a0KTtOM/1XsxVSKQhVjwYeUjjdawk
         xyRsxdsIu7cMppQJHlzv20P00P3yvaHe2ptjdZ311425N9wv+Nh20cbgvEsyx1A4Yr1W
         I23A==
X-Gm-Message-State: AOAM531zEv5Zo2TebE8eCJeXRP0mgLqzY6GNnu4M4jvPwDXwTpsnmUkX
        dOotNUdWz/fRRpF7s4XeM1M=
X-Google-Smtp-Source: ABdhPJwanBlcrErgErWcvGEOvkGFOtcjtqkyktDf0f+ooTR3yIBhwa/jruKeOP4U0Yw//j7yD5OhZA==
X-Received: by 2002:a17:902:d2cf:b0:141:b347:df9d with SMTP id n15-20020a170902d2cf00b00141b347df9dmr49432164plc.37.1638870205352;
        Tue, 07 Dec 2021 01:43:25 -0800 (PST)
Received: from nishad ([2406:7400:61:6687:fd10:b36d:bcea:520])
        by smtp.gmail.com with ESMTPSA id fs21sm2095731pjb.1.2021.12.07.01.43.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Dec 2021 01:43:24 -0800 (PST)
Date:   Tue, 7 Dec 2021 15:13:08 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Huijin Park <huijin.park@samsung.com>,
        Yue Hu <huyue2@yulong.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Christian =?utf-8?B?TMO2aGxl?= <CLoehle@hyperstone.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nishadkamdar@gmail.com
Subject: Re: [PATCH] mmc: core: Add support for the eMMC RTC feature in
 mmc_ops
Message-ID: <20211207094304.GA11969@nishad>
References: <20211205191009.32454-1-nishadkamdar@gmail.com>
 <DM6PR04MB657527FCF325EA9760032DA5FC6E9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <20211207093009.GA11794@nishad>
 <DM6PR04MB6575BF4FC2DE49885D0EEDF0FC6E9@DM6PR04MB6575.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB6575BF4FC2DE49885D0EEDF0FC6E9@DM6PR04MB6575.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 09:33:46AM +0000, Avri Altman wrote:
> > On Tue, Dec 07, 2021 at 08:28:42AM +0000, Avri Altman wrote:
> > >
> > > > This patch adds support to set the RTC information in the eMMC
> > > > device. This is based on the JEDEC specification.
> > > >
> > > > There is no way however, to read the RTC time from the device. Hence
> > > > we rely on the response of the CMD49 to confirm the completion of
> > > > the operation.
> > > >
> > > > This patch has been tested successfully with the ioctl interface.
> > > > This patch has also been tested suceessfully with all the three
> > > > RTC_INFO_TYPEs.
> > > If this is triggered from user-space via ioctl anyway, Why do we need
> > > this command to be implemented in the kernel?
> > > Why not just add this to mmc-utils?
> > >
> > > Thanks,
> > > Avri
> > As per the spec, B51: Section 6.6.35:
> > Providing RTC info may be useful for internal maintainance operations.
> > And the host should send it on the following events:
> > - power-up
> > - wake-up
> > - Periodically
> > Hence IMO, the Kernel would be the right place of peforming this operation.
> But your patch doesn't do that, is it?
>
Yes, That's because this operation may be device specific. In order to know when
to call this function may require eMMC firmware info.
This patch only adds support so that if the info is made available
in the future, a separate patch can be added to introduce the calling mechanism.

Thanks and Regards,
Nishad

> Thanks,
> Avri
