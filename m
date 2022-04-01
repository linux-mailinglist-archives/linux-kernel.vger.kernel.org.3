Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371154EFB72
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352511AbiDAUZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352577AbiDAUZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2829F28D2BD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648844441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=moFtzAyOAPoCtp/a6KG0UUQYbtXpxVkTbUnLT2+nfP4=;
        b=jV9XAlXaWr+FUaxhCuGuzifYC27gmSLqYh/6fn4SdbttG9pa2E+gCWemst4csY7cMVwRvX
        9aQJjlF7rEoFIaE3FjNzHBlX/b2+3Vuwvb5R/3HVk95OUnTcEfO+ExZUG/B2DRrOtdpw3r
        ivFAfV6eBg5x8bbDiDjaBxAIaqDieso=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-Uty4nxpgMlSX4676oExjWA-1; Fri, 01 Apr 2022 16:20:40 -0400
X-MC-Unique: Uty4nxpgMlSX4676oExjWA-1
Received: by mail-lf1-f71.google.com with SMTP id cf15-20020a056512280f00b0044a7b923686so1598295lfb.20
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=moFtzAyOAPoCtp/a6KG0UUQYbtXpxVkTbUnLT2+nfP4=;
        b=MmfgNgC+OVYv2lSwup9YbDjZ8hOkRg5YgS4wxYHtpdnz8ZXsAFD3hnULJ7yqkaiWWW
         cP/gaUn23H24OQa/dlH25EdcaXwXq2wqaGHp0NjKQ0Ehj0UmHhp0eMGVF1+f4DDkV+nL
         3YGx9jgx+l4omp2Iz0QOfg0y62HYvMbuGWihv18FzTe/VtZaxrSgS8dhLQbo1N/6E/cu
         ciKJyRJ0+H1yjBIbd+5CJgGDXnMSmWhkl/F7U/8zgMuj/uyBz0UJ9lLP+Eea+/MP28Vm
         5Rn9eqlNEgTzV/QMHqrEu/3h7i6oTe6FaUI7seSsqk5ZLLGOx8r/1WlQpzViM38rdI/i
         UjHw==
X-Gm-Message-State: AOAM533e2TX1njJxd6qLeLrv62z44qEpMpbKS+f/E2F214yA/KHIruIL
        AGFzaETm+SvXewyOaOsykXWrd1ZjZCOXdrJh+hERKwT1+YBZqc6JOrG9WQiknTxTRIDJYft07kU
        kMJ8mT3CblIVrTcndEmu1HrDM09nLkso5r1MZpvSD
X-Received: by 2002:a2e:7d05:0:b0:247:ed41:690d with SMTP id y5-20020a2e7d05000000b00247ed41690dmr14495537ljc.92.1648844438487;
        Fri, 01 Apr 2022 13:20:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6C0nNye6mqstGgicxwQGjK28I/pm5vkMPhiF7HWuofBNDZkh6xMWyCF9ZZ3jNE7SwAsx+BSi2rHs0wjJQeCk=
X-Received: by 2002:a2e:7d05:0:b0:247:ed41:690d with SMTP id
 y5-20020a2e7d05000000b00247ed41690dmr14495528ljc.92.1648844438292; Fri, 01
 Apr 2022 13:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220331190257.101781-1-wander@redhat.com> <20220331190257.101781-2-wander@redhat.com>
 <4767809d-5818-ad40-a0e7-b3af40aa071e@kernel.org> <20220401120705.533896e5@gandalf.local.home>
In-Reply-To: <20220401120705.533896e5@gandalf.local.home>
From:   Wander Costa <wcosta@redhat.com>
Date:   Fri, 1 Apr 2022 17:20:27 -0300
Message-ID: <CAAq0SUnFnbo_ABbbAMJRZsa1+30T=-cojgncvnnpCmfrz77U6g@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] serial/8250: Use fifo in 8250 console driver
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        =?UTF-8?Q?Andr=C3=A9_Goddard_Rosa?= <andre.goddard@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Jon Hunter <jonathanh@nvidia.com>, phil@raspberrypi.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 1:12 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 1 Apr 2022 06:35:58 +0200
> Jiri Slaby <jirislaby@kernel.org> wrote:
>
> > > With the help of the function tracer, I then noticed the serial
> > > controller was taking around 410us seconds to dispatch one single byte:
> > >
> > > $ trace-cmd record -p function_graph -g serial8250_console_write \
> > >     ./sertest -n 1 /tmp/serco
> > >
> > > $ trace-cmd report
> > >
>
> Note, the function graph tracer can add a noticeable amount of overhead to
> these timings. If you want a more accurate time for a function, just trace
> that one function:
>
>         trace-cmd record -p function_graph -l serial8250_console_write ...
>
> As that will only trace the serial8250_console_write() function (think of
> -l as "limit"), and the overhead of function graph for tracing a single
> function becomes negligible, and then you can see the true time of that
> function.
>

Thanks for the tip. I used bpftrace as a low overhead tracer. Then I
used the function-graph tracer to get the details.

> -- Steve
>

