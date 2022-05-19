Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C4B52CD03
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiESH13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiESH1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:27:04 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F49887202
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:26:52 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id a76so4150604qkg.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3UJrO2piIT0I8Jfgc2FkyRe58lX/r1xOx3qX4OA5srQ=;
        b=QL/1YoEAbqRiH1jSSZANBeYhM8cUEXOf1TXjcK9jc0zjqWs8JMU22oQ+XhIsU2T57d
         ozR1mex5hJQefWNEaQwfX+uCB4Q8T2Ge+hAvvFSuoZsLTr9P39xSkwmEzTVWynjX29yj
         bgDet5Ga8cRLljWzBXIQt3FEZceKkP5McLkkKf6SWMmTIp+nCE6ouYwcGMaAJtAz2JXz
         /+wzTICROxKVNIo/EE7YR/8RvJuCVBffiluM8QBw8xSJrK37b3O2eS7Kiil/KHGYj3rh
         azDu+EElIkY16TNc2NR7ZbnzpS7I0BdbYEWABKLSvmgKxrj7g0UoDw67gKB2NzH0tyLY
         DxZg==
X-Gm-Message-State: AOAM531P9e8obUMhmyWGPo5WK4/rJgUmna4azLSL1/EEVJBif1P+i9BH
        ClL/PYm9lF0U1a5Srx4UopIU8uyCR4fyEw==
X-Google-Smtp-Source: ABdhPJzQ6XZQBSLyB32ygG584YL3O97yt+xXrqTCC1KxXmb0t7txz+T9+QVdeQnMFiNDzG5G+Fs2tg==
X-Received: by 2002:a05:620a:10a8:b0:69f:8b8b:36d9 with SMTP id h8-20020a05620a10a800b0069f8b8b36d9mr2178339qkk.93.1652945211281;
        Thu, 19 May 2022 00:26:51 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id v11-20020a05622a014b00b002f39b99f6bfsm984178qtw.89.2022.05.19.00.26.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 00:26:50 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2fefb051547so48009067b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:26:49 -0700 (PDT)
X-Received: by 2002:a81:234b:0:b0:2f8:4082:bbd3 with SMTP id
 j72-20020a81234b000000b002f84082bbd3mr3287277ywj.47.1652945209116; Thu, 19
 May 2022 00:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <YoUBh5BSsURDO71Z@chrisdown.name>
In-Reply-To: <YoUBh5BSsURDO71Z@chrisdown.name>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 May 2022 09:26:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU2tUU6FAM-nK9oxd0GwcO3WwvZp9Um4=w5By+N0P0kXA@mail.gmail.com>
Message-ID: <CAMuHMdU2tUU6FAM-nK9oxd0GwcO3WwvZp9Um4=w5By+N0P0kXA@mail.gmail.com>
Subject: Re: [RFC PATCH] printk: console: Allow each console to have its own loglevel
To:     Chris Down <chris@chrisdown.name>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Wed, May 18, 2022 at 4:27 PM Chris Down <chris@chrisdown.name> wrote:
> [Once the goals of this patch are generally agreed upon, it can be split
> out further with more detailed changelogs if desired.]
>
> Consoles can have vastly different latencies and throughputs. For
> example, writing a message to the serial console can take on the order
> of tens of milliseconds to get the UART to successfully write a message.
> While this might be fine for a single, one-off message, this can cause
> significant application-level stalls in situations where the kernel
> writes large amounts of information to the console.
>
> This means that while you might want to send at least INFO level
> messages to (for example) netconsole, which is relatively fast, you may
> only want to send at least WARN level messages to the serial console.
> Such an implementation would permit debugging using the serial console
> in cases that netconsole doesn't receive messages during particularly
> bad system issues, while still keeping the noise low enough to avoid
> inducing latency in userspace applications. This patch adds such an
> interface, extending the existing console loglevel controls to allow
> each console to have its own loglevel.

Thanks, this looks like an interesting idea!

> --- a/Documentation/admin-guide/serial-console.rst
> +++ b/Documentation/admin-guide/serial-console.rst
> @@ -17,7 +17,7 @@ use for console output.
>
>  The format of this option is::
>
> -       console=device,options
> +       console=device,options/loglevel
>
>         device:         tty0 for the foreground virtual console
>                         ttyX for any other virtual console
> @@ -32,15 +32,23 @@ The format of this option is::
>                         and F is flow control ('r' for RTS). Default is
>                         9600n8. The maximum baudrate is 115200.
>
> +       loglevel:       optional. a number can be provided from 0
> +                       (LOGLEVEL_EMERG) to 8 (LOGLEVEL_DEBUG + 1), and
> +                       messages below that will be emitted onto the console as
> +                       they become available.
> +
>  You can specify multiple console= options on the kernel command line.
>  Output will appear on all of them. The last device will be used when
>  you open ``/dev/console``. So, for example::
>
> -       console=ttyS1,9600 console=tty0
> +       console=ttyS1,9600/5 console=tty0
>
>  defines that opening ``/dev/console`` will get you the current foreground
> -virtual console, and kernel messages will appear on both the VGA
> -console and the 2nd serial port (ttyS1 or COM2) at 9600 baud.
> +virtual console, and kernel messages will appear on both the VGA console and
> +the 2nd serial port (ttyS1 or COM2) at 9600 baud. The optional loglevel "5"
> +indicates that this console will emit messages more serious than
> +LOGLEVEL_NOTICE (that is, LOGLEVEL_WARNING and below, since more serious
> +messages have lower ordering).
>
>  Note that you can only define one console per device type (serial, video).

All of the above options are appropriate for "classic" systems,
where the console device is selected using the "console=" option.

On systems using Device tree, the serial console device is selected
using the "chosen/stout-path" property in DT, and the graphical
console is usually auto-detected and auto-enabled through DRM.
Do you envision a way to specify a specific console loglevel on the
kernel command line on such systems?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
