Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353EC4A79CB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347315AbiBBUyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241698AbiBBUyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:54:36 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5D0C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 12:54:36 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id h23so482742pgk.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 12:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l2Oma9zXCLWmq5QWeFwdvr5FNqJvallv/jOB/x/DuMo=;
        b=PUMB0XI/DBpwDBjvrTU4GRblhYvTYge8mzWnov2rHbPeccUHMEWLLWO4Ox835bCcpg
         vipWFV2JKk6RSWJrGEcbDILjvbqlik4DgefMvzZNmQMwm9nzoS6kPhU0b+Ppplw7dQ3g
         XXJDRQ6lRNyf8LM1HeN3vKBIcEfGkghW6UZv0048O8odgN/WKuzLu3ufUG1OvrMJyEtC
         t7x0A5nEjNAEbw+SLG49jpkkpzvUd3ol2coeKzQRYXY0CmrIIMJozuFFpQk4zoYCXgDy
         A+NNfFCti8EGbKzo26fpTpaMDXBxNqwPEG8e2LMBodnru6PtY6QcQlsWbJPUSbWbLXBc
         xDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l2Oma9zXCLWmq5QWeFwdvr5FNqJvallv/jOB/x/DuMo=;
        b=XhNZE37ACOSscMXyjvaVDFYPUtISzP6sYZdlavzhgLTIgpMtogcbGo9gYx8cyfmN7h
         s83FQlp6SHNjAijwid3aDO4F5NrG5rdXiJw9uWFePKfHOyaWfg6EvtM1rrexK04OL7Ar
         MOFz2gYQs4DLcAQF7FKXpnVuHsHYuigJqHGv+RhGsBUE7npQQz+7wdncFy3mtSm19JDv
         gRPnO400V3MwGCpKoSyduQsVi7rtU+2ScL9UopbAUw1n3sCYeHY2enWFN/Ml7347kk8m
         LMxD3gdsc7InwfpGqGLwl5CtdvVDex10mLSbM3WmProYTiMsK1o04oqdSOBoK9pza9gs
         nx1A==
X-Gm-Message-State: AOAM532Qmcqw9Co7YwxyKtktIFenwIJcdcf8idH9dFz1vyTj+6yWjekh
        22kcp4dh7B3LHV4DWTIE0/GEjQ==
X-Google-Smtp-Source: ABdhPJxxsEXOdAKWRKznRFLLkUlAgp8BBmDHDhft6rZzZrSGwJ8lyMOEhAyse98KdIdkzQKoL5th+g==
X-Received: by 2002:a63:5545:: with SMTP id f5mr25618685pgm.157.1643835275909;
        Wed, 02 Feb 2022 12:54:35 -0800 (PST)
Received: from x1 ([2601:1c2:1001:7090:9646:73e6:2457:2f0f])
        by smtp.gmail.com with ESMTPSA id f8sm25371811pfe.204.2022.02.02.12.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 12:54:35 -0800 (PST)
Date:   Wed, 2 Feb 2022 12:54:59 -0800
From:   Drew Fustini <dfustini@baylibre.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>, Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 2/2] clocksource/drivers/timer-ti-dm: Handle dra7 timer
 wrap errata i940
Message-ID: <Yfrvo+kVd9ZHJjBX@x1>
References: <20210323074326.28302-1-tony@atomide.com>
 <20210323074326.28302-3-tony@atomide.com>
 <YfWsG0p6to3IJuvE@x1>
 <Yfe25rpSY8OFPxzr@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfe25rpSY8OFPxzr@atomide.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 12:16:06PM +0200, Tony Lindgren wrote:
> Hi,
> 
> * Drew Fustini <dfustini@baylibre.com> [220129 21:05]:
> > On Tue, Mar 23, 2021 at 09:43:26AM +0200, Tony Lindgren wrote:
> > > There is a timer wrap issue on dra7 for the ARM architected timer.
> > > In a typical clock configuration the timer fails to wrap after 388 days.
> > > 
> > > To work around the issue, we need to use timer-ti-dm percpu timers instead.
> > > 
> > > Let's configure dmtimer3 and 4 as percpu timers by default, and warn about
> > > the issue if the dtb is not configured properly.
> > 
> > Hi Tony,
> > 
> > This causes a conflict for IPU2 which is using timer 3 and 4.
> > 
> > From arch/arm/boot/dts/dra7-ipu-dsp-common.dtsi:
> > 
> >   &ipu2 {
> >           mboxes = <&mailbox6 &mbox_ipu2_ipc3x>;
> >           ti,timers = <&timer3>;
> >           ti,watchdog-timers = <&timer4>, <&timer9>;
> >   };
> 
> OK, sorry I missed that part.
> 
> > I noticed an error ("could not get timer platform device") when booting
> > mainline on a BeagleBoard X15 (AM578):
> > 
> >   omap-rproc 55020000.ipu: assigned reserved memory node ipu2-memory@95800000
> >   remoteproc remoteproc1: 55020000.ipu is available
> >   remoteproc remoteproc1: powering up 55020000.ipu
> >   remoteproc remoteproc1: Booting fw image dra7-ipu2-fw.xem4, size 3747220
> >   omap-rproc 55020000.ipu: could not get timer platform device
> >   omap-rproc 55020000.ipu: omap_rproc_enable_timers failed: -19
> >   remoteproc remoteproc1: can't start rproc 55020000.ipu: -19
> > 
> > I switched this errata fix to use timer 15 and 16 instead which resolves
> > the error.  Do you think that is an acceptable solution?
> 
> I think the only difference is that timers 15 and 16 are in l4_per3 instead
> of l4_per1. I doubt that matters as they are pretty much always clocked in
> this case. If you want to check you can run cyclictest :)

I ran this with existing errata fix with dmtimer 3 and 4:

root@am57xx-evm:~# cyclictest --mlockall --smp --priority=80 --interval=200 --distance=0
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 0.02 0.03 0.05 

T: 0 ( 1449) P:80 I:200 C: 800368 Min:      0 Act:   32 Avg:   22 Max:     128
T: 1 ( 1450) P:80 I:200 C: 800301 Min:      0 Act:   12 Avg:   23 Max:      70

And the results after my switch to dmtimer 15 and 16:

root@am57xx-evm:~# cyclictest --mlockall --smp --priority=80 --interval=200 --distance=0
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 0.36 0.19 0.07

T: 0 ( 1711) P:80 I:200 C: 759599 Min:      0 Act:    6 Avg:   22 Max:     108
T: 1 ( 1712) P:80 I:200 C: 759539 Min:      0 Act:   19 Avg:   23 Max:      79

This doesn't appear to show any latency regression.

Any other options for cyclictest that that you'd recommend trying?

Thank you,
Drew
