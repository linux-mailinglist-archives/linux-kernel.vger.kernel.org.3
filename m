Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F13C4769AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 06:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbhLPFiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 00:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhLPFiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 00:38:00 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D511AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 21:37:59 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id x6so33414213iol.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 21:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=6ScHdtKJBGLpSH1WCw4x7edbvBY4BLhz9TD1CTHUesQ=;
        b=Rh1PMORQrWW3aNlpNq0Dm8K/gqfuz9eVKKNKV9XJrSPwONwKc6wvmSCpga9KxTHtIF
         0zDQRp6e8rMAEsJPfx741s7DnmOiBbsRW6YAwEvrSELddQ0gyRxldzbAKmnTO0Kb9YT8
         6Kx2cyY3ga33KeHXyXdWjd1LfbSrm1VNQT9KpJU4rU01YrhOXfvEiNreKw/IH71FwRpx
         dQ14wH+ka46Xrt2Is05w0nkCxr6kj4oh7q4DKZn5rtUWC+sheS73CS/qYMhogfpxDXgP
         Mvrf78K602or907qFpG4PZCIM5sauwUzH09VJGPDH9GDmE3E1QtdNV1bghGbJYoBB2Vl
         58AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=6ScHdtKJBGLpSH1WCw4x7edbvBY4BLhz9TD1CTHUesQ=;
        b=jyRPh8ofHw2v+lmh0m9sDwAILLl6zQI20WuSWLcj8IIn5DAg351zXn3YK4IT1qOAUL
         o41RHUvsrXIDT0GlPZ8KDdp5KCEXJT0T02klpY7s96KR9DMVsXNoc8TTG5eSBfZgOqHz
         llILM9ja+T0GakKP9VPAhCuiQlJ9aIVBAA9VubyFwXLaovhURVIUsn8eLjFAvVVl1Kni
         9WmW9b0etdV8JlzJIjmoVQ9aLQHVaMTOnjaO8uaxGyKLjrrMRd1FsI9HeeIhsvKO7AlG
         gXI3g4SxRrRuH4xfzXxru8+98ocqbc2MzYAm1XIw+pRljIjs8Eq12/LLX0BKogKbvIEn
         9/AQ==
X-Gm-Message-State: AOAM533KgZJdCK7/nljJAxt9GSii/8dEC3w7tOuwL8LMTCCiVbbMGi6K
        ZKulzCIykjQqGH4IwpQFW6ty
X-Google-Smtp-Source: ABdhPJwbhQHP0Lg2aI7V08adPfvImhPuENbAA3IxvfP5uS1vgnq3nu6gVTlG7wLNi6vDhA77D5jRzg==
X-Received: by 2002:a05:6638:38a6:: with SMTP id b38mr8269875jav.233.1639633079157;
        Wed, 15 Dec 2021 21:37:59 -0800 (PST)
Received: from ?IPv6:2601:281:8300:4e0:2ba9:697d:eeec:13b? ([2601:281:8300:4e0:2ba9:697d:eeec:13b])
        by smtp.gmail.com with ESMTPSA id l12sm2263692iow.23.2021.12.15.21.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 21:37:58 -0800 (PST)
Message-ID: <31d5e7447e4574d0fcfc46019d7ca96a3db4ecb6.camel@egauge.net>
Subject: Re: [PATCH] wilc1000: Allow setting power_save before driver is
 initialized
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Ajay.Kathat@microchip.com
Cc:     Claudiu.Beznea@microchip.com, kvalo@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 15 Dec 2021 22:37:47 -0700
In-Reply-To: <5378e756-8173-4c63-1f0d-e5836b235a48@microchip.com>
References: <20211212011835.3719001-1-davidm@egauge.net>
         <6fc9f00aa0b0867029fb6406a55c1e72d4c13af6.camel@egauge.net>
         <5378e756-8173-4c63-1f0d-e5836b235a48@microchip.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-12-15 at 13:01 +0000, Ajay.Kathat@microchip.com wrote:
> On 13/12/21 02:50, David Mosberger-Tang wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Unfortunately, this patch doesn't seem to be sufficient.  From what I
> > can tell, if power-save mode is turned on before a station is
> > associated with an access-point, there is no actual power savings.  If
> > I issue the command after the station is associated, it works perfectly
> > fine.
> > 
> > Ajay, does this make sense to you?
>   <snip>
> Power-save mode is allowed to be enabled irrespective of station 
> association state. Before association, the power consumption should be 
> less with PSM enabled compared to PSM disabled. The WLAN automatic power 
> save delivery gets enabled after the association with AP.
> 
> To check the power measurement before association,  test without 
> wpa_supplicant.
> 
> 
> Steps:
> - load the module
> - ifconfig wlan0 up
> - iw dev wlan0 set power_save off (check the pwr measurement after PS 
> mode disabled)
> - iw dev wlan0 set power_save on (check the pwr measurement after PS 
> mode enable)

It appears wpa_supplicant consistently renders PSM ineffective:

                                (current draw, 1 min avg):
------------------------------  --------------------------
- base case (no module loaded): 16.8 mA
- module loaded & PSM on      : 16.8 mA
- wpa_supplicant started      : 19.6 mA
- PSM on                      : 19.6 mA (no change)
- PSM off                     : 19.6 mA (no change)
- PSM on                      : 15.4 mA

What's strange is when I try this sequence a couple of times in a row,
the device gets into a state where after starting wpa_supplicant, no
amount of PSM on/off commands will get it to enter power-savings mode
any more.  When in that state, only removing wilc1000-spi.ko and adding
it back gets it out of that state.  A power-cycle does not.  Very
confusing.

  --david


