Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E393507C85
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358175AbiDSWbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357935AbiDSWbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:31:21 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C9E24953
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:28:38 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x1so141825pfj.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+kb4y1ct+D39bV4tAeLvKJMLtfqsTHYQZH4lenFOa/s=;
        b=CwsvcqUQiVh25FI4ZNK8H+0YPMBP3eJ+P3BPK5+aJX86n2oBAuo37ctouTLoufKp3t
         AR0duUflr347GoKa1+yY2PIvjEI7hepl8ldvHjU82VoBYV1IveuNNeT2qS+Bxa7Oe1Qk
         8P1ZsVi1PH1Fo9rBcHc5aVoRhxrRRSjFXZEPV+B3g9mY4z3qe6c8QOAm+cakFYC8IFLs
         OG96Ex2auEffqpTVwkIpTzSM/T7wuEzcktzOJRoL1s2lksufdzd2y9Li1HQkwA1c2jt2
         Ouj1krBuEpKLayRIU49KBi8slX2S3bxXI8AUmsjnbfr87yy/DX4QmrOeVmV/wJMbUjnb
         O94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+kb4y1ct+D39bV4tAeLvKJMLtfqsTHYQZH4lenFOa/s=;
        b=HYx9aAay0cfjQhByppQdU6WCYtV2yxkyNewkenJTdy+M1D8UkiwCZVZ9zjRl1Pvt3u
         9sKhzTqOvv3/jNP/EB4BfufX9tXSUfoZziJC756hnjONLKgfw6JRUCSc8op8g1cSymHT
         25+02yd4MbQqunaB6w4TpiZ7QhxWu0MJoUqmVjoVO3yIY2OT6yO88GLhKjbQm7QD3XsK
         5gy1GvBUW1+Kpjn2bOsAAS33buxiyv2Hw3wII5Dtdt+zX8P07T9DTb/YSdE5QqW3SJkW
         1uzXXj/tkJBUJPd951dZx8aCHHG3SMw/KIE4om7g/V0EdyBBArg/vjbvNmm1B/2f8Ep6
         GWpQ==
X-Gm-Message-State: AOAM532wSv/aGkwGER7lIr1KmL6UzXWD3NGBJxkK4w56DZLQqFFbErqc
        X3oG0FwamXaVh7V/z4c5OdER6RzEjibfZ0pnk9ko9w==
X-Google-Smtp-Source: ABdhPJy4KNZkUqNaqV9vPC98/sJFh5SHFjYoQr6PyXvPfsPEpn0S6UwD0reKh4DY9t5+K8leyfzLFiBcIRHF+HKJrHs=
X-Received: by 2002:a63:1117:0:b0:399:2df0:7fb9 with SMTP id
 g23-20020a631117000000b003992df07fb9mr17107704pgl.40.1650407317523; Tue, 19
 Apr 2022 15:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220407191347.9681-1-jithu.joseph@intel.com> <20220419163859.2228874-1-tony.luck@intel.com>
 <20220419163859.2228874-4-tony.luck@intel.com> <Yl7npfrVTPFEIivC@kroah.com> <CAPcyv4jzscs3Dg4QN0+XHRYdekBeqy1=dRX-mWCj1OXo8jS2vQ@mail.gmail.com>
In-Reply-To: <CAPcyv4jzscs3Dg4QN0+XHRYdekBeqy1=dRX-mWCj1OXo8jS2vQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Apr 2022 15:28:26 -0700
Message-ID: <CAPcyv4hBGgN=LqY55nf2K4E1OD0n=_axri4CNSKVneStYEp6rw@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] platform/x86/intel/ifs: Create device for Intel
 IFS (In Field Scan)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 11:09 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Apr 19, 2022 at 9:48 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Apr 19, 2022 at 09:38:51AM -0700, Tony Luck wrote:
> > > The initial implementation of IFS is model specific. Enumeration is
> > > via a combination of family-model-stepping and a check for a bit in the
> > > CORE_CAPABILITIES MSR.
> > >
> > > Linux has handled this lack of enumeration before with a code stub to
> > > create a device.  See arch/x86/kernel/pmem.c. Use the same approach
> > > here.
> >
> > Ick, why?  Why not just create a simple virtual device and use that?  Do
> > you really want to bind a driver to this?  Or do you already "know" the
> > only driver that you have will bind to this?
>
> With the realization that there may be multiple instances of an
> IFS-like capability going forward, and that ideally those capabilities
> would move away from a CPU capability bit to an ACPI description, then
> it seemed to me that a simulated platform_device for this is a
> reasonable fit. I.e. when / if an ACPI _HID is assigned for this
> capability the same platform_driver can be reused for those instances.

Turns out the ACPI enumeration for this may not materialize, so this
can indeed move to a simple / driver-less device.
