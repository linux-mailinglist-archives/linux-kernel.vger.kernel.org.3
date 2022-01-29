Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C83D4A31FF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 22:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353214AbiA2VFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 16:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346309AbiA2VFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 16:05:08 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8825EC061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 13:05:08 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id j16so9214239plx.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 13:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hUntcolkKoG81YeeiCT2Ivi3zNzCUdhrxI8/sMLFU2E=;
        b=G3AzFjJJ92ol7qLFDRRFSLfp/CLaSfxoqvRBEUwKQpdQHZLFvCJkOnS08WK68jfAIe
         GNSwYfv/zfiRiwJdVfwDklXj0ALbg9RZixiie8z+SReymEqrbbIqckj/W7GtDnRANA4/
         ZcaXGVYH/u6VCjmvU7qEAJAcCzOj60u1qzEfDJ/e6RWmtBhVvocYJy81jzNC4BDLDOIL
         1a3nHaA/bBkmYr3zZ9uXE2C8uCF5IoOmAn+J5OxWWgPELVDD5yEOjFQv+W3qN9tpHVPJ
         kV4sIQzINoZPDkTpK+ecwyf/9HOtO9bfQDmueFsGRWagkW3AgqDlSzJLjfFFxpmyzkcK
         AU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hUntcolkKoG81YeeiCT2Ivi3zNzCUdhrxI8/sMLFU2E=;
        b=8PCQ+qEWQ1nJrEXCygBOCrOthfb36rJjrYisDSi8CzgcvQPPyB4VddVha08tQhRucy
         aHRrbrRSDs2gtYo6BJd5Z24FHiDTaVXtM5ZqMKv32/NRV0lmaQ7i51qlVh+VVXpZtHvp
         GrD5q7yLbcj4/ncz0+hDPcxw8/AG3kVM2GcT0Mtkdg19M8PEQkfFXzcGexksVTJLn66j
         I4D6CrFBw4pir47lTre3iAetI5+eTdOdEmGba7FChHiVI0ncGvS3kWurLrjeNny4/vPz
         zCU9tK0QiD/ntERa4b780in+WJ6UtvstdFvsXuGJekQmJOsqwcHB5wevTNEonkOgkEQs
         mr3Q==
X-Gm-Message-State: AOAM532EbRFMK87UmptBApfApDf8cp+bbXV+XyPvLSU+29D223P8ZJDN
        wiFWvTQLPHrtbCxLiZUqlgHuJw==
X-Google-Smtp-Source: ABdhPJwjpG3OiPfI97msJffsJIBxd35YRlUPDoyKmkHH7MxwyWq/knvXfXMs/N182qeFHWduDIH2qw==
X-Received: by 2002:a17:90b:23d4:: with SMTP id md20mr21278863pjb.199.1643490308052;
        Sat, 29 Jan 2022 13:05:08 -0800 (PST)
Received: from x1 ([2601:1c2:1001:7090:638f:aa01:c56a:78da])
        by smtp.gmail.com with ESMTPSA id j14sm13857007pfj.218.2022.01.29.13.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 13:05:07 -0800 (PST)
Date:   Sat, 29 Jan 2022 13:05:31 -0800
From:   Drew Fustini <dfustini@baylibre.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>, Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 2/2] clocksource/drivers/timer-ti-dm: Handle dra7 timer
 wrap errata i940
Message-ID: <YfWsG0p6to3IJuvE@x1>
References: <20210323074326.28302-1-tony@atomide.com>
 <20210323074326.28302-3-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323074326.28302-3-tony@atomide.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 09:43:26AM +0200, Tony Lindgren wrote:
> There is a timer wrap issue on dra7 for the ARM architected timer.
> In a typical clock configuration the timer fails to wrap after 388 days.
> 
> To work around the issue, we need to use timer-ti-dm percpu timers instead.
> 
> Let's configure dmtimer3 and 4 as percpu timers by default, and warn about
> the issue if the dtb is not configured properly.

Hi Tony,

This causes a conflict for IPU2 which is using timer 3 and 4.

From arch/arm/boot/dts/dra7-ipu-dsp-common.dtsi:

  &ipu2 {
          mboxes = <&mailbox6 &mbox_ipu2_ipc3x>;
          ti,timers = <&timer3>;
          ti,watchdog-timers = <&timer4>, <&timer9>;
  };

I noticed an error ("could not get timer platform device") when booting
mainline on a BeagleBoard X15 (AM578):

  omap-rproc 55020000.ipu: assigned reserved memory node ipu2-memory@95800000
  remoteproc remoteproc1: 55020000.ipu is available
  remoteproc remoteproc1: powering up 55020000.ipu
  remoteproc remoteproc1: Booting fw image dra7-ipu2-fw.xem4, size 3747220
  omap-rproc 55020000.ipu: could not get timer platform device
  omap-rproc 55020000.ipu: omap_rproc_enable_timers failed: -19
  remoteproc remoteproc1: can't start rproc 55020000.ipu: -19

I switched this errata fix to use timer 15 and 16 instead which resolves
the error.  Do you think that is an acceptable solution?

If so, I will post the patch to the list.

Thanks,
Drew
