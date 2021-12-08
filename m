Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F07246CFBC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhLHJNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhLHJNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:13:48 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA700C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 01:10:16 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id g28so1381916qkk.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 01:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version:date
         :message-id;
        bh=vutFqY0ZTHo8JOAnQkYE1aP8GhO1tTcTsT9w9L82rCw=;
        b=Wh0AnnpyKTCTAl4L4Hg+tQqumpf+i6VX9GSapJ7plb7VhsYuO5N1YDpY0r1+jaXsPB
         EzCcRsg/L6OP29IAAZ2xTbeb/BknGcRa+D6ZXjNtROc6CaftcHdk8r+tpQdmasDUzU1/
         RbKXkFHobLW/IU0SUgkUpy6hiP0HjJgKp38Oc5+5cf1xpO9Zi7SobSDObSXumMl5wIdH
         OiFE/XAQ3hWeaXUbHnm2TYR5v5c/LmzF9/2dQ8pIN0W2NFZH9d07lN2t3QBYHHzhgxaH
         VU6DOTubg2S+9ulSqJwqWbKT1nL8WvDOSQORZtk/+mQhXcJNv+1fdqllZecFB0G9PJAe
         Mz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=vutFqY0ZTHo8JOAnQkYE1aP8GhO1tTcTsT9w9L82rCw=;
        b=TPsq6pxq5pm03PT9ztY0h8mfcJf6Lr9oBuaCRAp/jHWzlIBHC/qe3qszN3ewIdJ5Ib
         odLy6BSGhOaqgfVEfmueJL81x6KBM5D7H7ggblIFV2KW1ZdrcCjXMrybNiyRgpvNGwJi
         fq88BJq4wSNUz0OxEkYi961VTXTIM2Ec1yXxk9GNjTtxFAmZyVJ7kJjZZWib6DA215D4
         W4KH1E9FM6ana38OTG7SKw7IhUaKkafNl8V2wr9WcEyXfCnxFVt/7x6F+jXetxbQYlbf
         IhIqMte5mE21mO5tCt0bXDi0UkXLn6fJn2ZYC0G/rK0o54Br2emT/Cmaj8++WuR73zj/
         tH/A==
X-Gm-Message-State: AOAM532QPvbomotJumKjZTJ6CRT5rFPX/t7825mIhc4p0bQEIlzXuAu2
        X9SBVIXPkRlvjUjCqfUTsYFe1ZyDtRP4MA==
X-Google-Smtp-Source: ABdhPJzCPC4yk2O4IeNn0B5Mv+VGpKUAIT/OzYQHqV5gB1lSJoFmc15etvn/Wz0457y42ONq7J3aZw==
X-Received: by 2002:a05:620a:3dd:: with SMTP id r29mr5208179qkm.208.1638954615971;
        Wed, 08 Dec 2021 01:10:15 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id y11sm1423475qta.6.2021.12.08.01.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 01:10:15 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.10.0-pre 07/05/2021 with nmh-1.7+dev
To:     Muni Sekhar <munisekharrms@gmail.com>
cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: Re: Time: new clocksource
In-reply-to: <CAHhAz+iZe4A9bi9tvwqpHaV1ari76r2bXcO1E6Bm88Cc7XFq+A@mail.gmail.com>
References: <CAHhAz+jpmksehY4BSH9jJPYuY+jykSHtx9TNiG-gAkq10zaXSQ@mail.gmail.com> <fe9dbf81-e060-36ab-b769-215af3d65ba7@linaro.org>
 <CAHhAz+iZe4A9bi9tvwqpHaV1ari76r2bXcO1E6Bm88Cc7XFq+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 08 Dec 2021 04:10:14 -0500
Message-ID: <158505.1638954614@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2021 13:03:07 +0530, Muni Sekhar said:

> Which module is responsible for resulting in the absolute time? Is
> absolute time synchronized across multiple systems connected on the
> network?

man -k ntp

Keeping the system clock in sync with external timesources and reality is too
complicated and messy to be done inside the kernel, so it's usually done with a
userspace daemon which on Linux boxes is usually ntpd.

Depending on the clock stability of the hardware, whether you have an RTC chip
that keeps track of time even when powered down, and the timing tolerances you
want on your network (synced to the same minute, or same second, or same 0.001
seconds), it may be sufficient to run ntpdate at an appropriate time during
system boot, or from inside a cron job, or you may want to have a continually
running ntpd process.

Most sane distros have ntpd enabled by default with a reasonable set of
defaults - systems that have non-broken clocks will fairly quickly figure out
the clock drift rate, and your network load to keep the clocks within a few
milliseconds of a national time standard drops to a few packets every 20
minutes or so. In case of a network outage, it will continue to correct the
system clock according to the last known drift rate.

And if you need better than millisecond sync, you're going to be springing
for a GPS receiver with a PPS output and/or a cesium or rubidium clock.

