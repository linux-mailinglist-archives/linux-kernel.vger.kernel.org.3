Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7003B4DC5C8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiCQM2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiCQM2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B36501EB80B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647520051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OrgWgBIoJfzLisqsnqNuO2T4Ox23yYSbOeMePAqRbx0=;
        b=U+GQlWssHEn87SJBB10dO8yE2DRojQCwuiLX+YBTkjehhVdVzLtkB0uY5Vwa5lGGVwQyUn
        ZEmdL3fhBw2OczSF3+F8fsZXTWb5OZKDrtSST3qqbEK7P7JCqgqjRSnVIsQzX5lYVCfiFK
        YfDnqRw4vcyt/z8gWD/ryEd+W/jt90k=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-NsMpcS1OM0m7EJhZR_it8A-1; Thu, 17 Mar 2022 08:27:23 -0400
X-MC-Unique: NsMpcS1OM0m7EJhZR_it8A-1
Received: by mail-lj1-f197.google.com with SMTP id 20-20020a2e0914000000b0024635d136ddso1999411ljj.22
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OrgWgBIoJfzLisqsnqNuO2T4Ox23yYSbOeMePAqRbx0=;
        b=hKcd/rk71pu/Y9Allb9iz0fQdmshQ0sHycBUV688UWAp9hM1nTJrNg9S8VX5ChMyI1
         r632+SHNxztIwFViStlAo2JskCbK5Ruw3j03sI4r5FELm4eVa8K15gIwzO+AqXTOoD6v
         6e6zS2g6Gl5c52xiZ6TTPhjbCwB2R2DFqJciSIRpGgmtci6faP4u04ZVkOwvFyQrYxm8
         JqKcPROnSCy1Pvph1Zn9rwut8zNt1iAUZyNp+cQ3n9Pne/sh/safBmPD4wu+XouP2jSU
         l9JEdqvb0zz6c/SUgxM5Uwn5QTf/Q+LB7hMUlMgAbAsQUJm/7VErmZtRN49J8eO/1yx1
         8gDQ==
X-Gm-Message-State: AOAM533TBx2rpsDkn8UX6ta61iIt/mCpaXntdlQtn66MOQ+vOBNJtWbj
        FZMwVZCEhvX8q986O1gTOt0YaTrY2UlxOd8QGLKrsBSbcV1Yqpfi16ZnC/QJ7RcbndQOa4jRh4J
        ovMcXBPL6FjdIl7oYpOfhIomqZ/8FqT8HVUQ/GgYj
X-Received: by 2002:a19:dc50:0:b0:448:816d:2dd8 with SMTP id f16-20020a19dc50000000b00448816d2dd8mr2648361lfj.1.1647520042121;
        Thu, 17 Mar 2022 05:27:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2dlOWq1WsEvaFd/fI5iXCgVuOFH/IMSoSaQ5HcG/HFbLEshYRc4GQrRKi3PVGw5rYMSPnEtv/ni99n4bLH0E=
X-Received: by 2002:a19:dc50:0:b0:448:816d:2dd8 with SMTP id
 f16-20020a19dc50000000b00448816d2dd8mr2648335lfj.1.1647520041938; Thu, 17 Mar
 2022 05:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220316143646.13301-1-wander@redhat.com> <20220316143646.13301-2-wander@redhat.com>
 <bb5f03ec092f462c9656f224895bb224@AcuMS.aculab.com>
In-Reply-To: <bb5f03ec092f462c9656f224895bb224@AcuMS.aculab.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Thu, 17 Mar 2022 09:27:10 -0300
Message-ID: <CAAq0SUnGtOgJ5PWZXZ8QHoOxMJEPi1kuuuNeEhGq2iu73oF9AA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] serial/8250: Use fifo in 8250 console driver
To:     David Laight <David.Laight@aculab.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andre.goddard@gmail.com" <andre.goddard@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "phil@raspberrypi.com" <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 12:27 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Wander Lairson Costa
> > Sent: 16 March 2022 14:37
> >
> > Note: I am using a small test app + driver located at [0] for the
> > problem description. serco is a driver whose write function dispatches
> > to the serial controller. sertest is a user-mode app that writes n bytes
> > to the serial console using the serco driver.
> >
> > While investigating a bug in the RHEL kernel, I noticed that the serial
> > console throughput is way below the configured speed of 115200 bps in
> > a HP Proliant DL380 Gen9. I was expecting something above 10KB/s, but
> > I got 2.5KB/s.
> >
> > $ time ./sertest -n 2500 /tmp/serco
> >
> > real    0m0.997s
> > user    0m0.000s
> > sys     0m0.997s
> >
> > With the help of the function tracer, I then noticed the serial
> > controller was taking around 410us seconds to dispatch one single byte:
>
> Did you verify the baud rate?
>

Yes.



> Or is there some horrid serial redirection going on.
> It is even possible there is a bios smm interrupt
> chugging through on another cpu core.
>

I would be surprised if that were the case because I see the problem
even in low system activity. Someone in a previous patch-revision
theorized this might be due to a bad serial controller emulator
implemented in hardware (or something in this line of thought).

