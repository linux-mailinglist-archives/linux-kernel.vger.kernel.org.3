Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E953D4EEF93
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 16:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347080AbiDAO2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 10:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346911AbiDAO2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:28:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F8591E3189
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 07:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648823190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2UVV1ZX1y9UdjpKVLfQDZGpGG6d6q550euWe10BEY9E=;
        b=hUOw6p+Y4E4tlcFUL0wmM3fCsfUJAEh6zeCZY35oJR/A6ENIUFc6naEn6fJLssunnzjov2
        n6vTy/+YBaDkkCUi1nmohbqbZQA7WQklJrmYKtKR1Q/N75UsLBqlJJ2V9lzAKsDLbAJLQL
        cmmNBAfgaG255N0azMlYwIS/JkrW8Ik=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-wPpgVoM1MUCqsjfcuTCy2g-1; Fri, 01 Apr 2022 10:26:28 -0400
X-MC-Unique: wPpgVoM1MUCqsjfcuTCy2g-1
Received: by mail-lf1-f71.google.com with SMTP id bp13-20020a056512158d00b0044a7966d6baso1268574lfb.21
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 07:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UVV1ZX1y9UdjpKVLfQDZGpGG6d6q550euWe10BEY9E=;
        b=6gjDy2Z8fdvzbaxW2ufLCsyzhOGxd/XySUdOaD4dHkm+YuMnQzHNFXCXxeGhA9KBlG
         rvssd/bIS0Uog1V3FkB6vSoARrB7JqI9rATdsGOKCLghcSsTbmaVGZvlOK7QUehQ4jtx
         tF4jKZKUha11omxswrAzALsw9WsBp5jt+IPUjzBs+ZcHdDEVrVUpWleaEhU+KYR8Z2Or
         QBp7LyDcpyngiSHFM/KvZ8x/BXQYzmBRKeKTfNmNk9moQHQ2RAxENFB0gbnvUT+1fWrf
         REmk5rUxWbKap84YAQdwYj0wN5u1PntreaH1X9eoL6AoA3XFcXd+/bpr6u66booGjOnl
         OYzw==
X-Gm-Message-State: AOAM532AT6u1hEZPx1SUB/7+y0oPCnlVBKXuUfl46arC2SkUnIUOwKqF
        +3xAMM9H4cDY5opxTVPPkS2cwumMWrI93tWK6CuZbgO4RV4dm94ZJbUZhF3A1eZedOLUdrMP7zk
        LzSk7Ov2iMpmihCLapZvXcLbGFEEZnM+0A9mx+ZKz
X-Received: by 2002:a05:6512:308a:b0:44a:96cf:7ceb with SMTP id z10-20020a056512308a00b0044a96cf7cebmr13936439lfd.1.1648823187409;
        Fri, 01 Apr 2022 07:26:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEZVCL9DRSUlkJcPMDBd0xC2u70/SZJFXNSHYEoLpznTZMmi9QE8ctwQW8FDrNG5W5P8YwVfpONL2yFm35WK8=
X-Received: by 2002:a05:6512:308a:b0:44a:96cf:7ceb with SMTP id
 z10-20020a056512308a00b0044a96cf7cebmr13936426lfd.1.1648823187229; Fri, 01
 Apr 2022 07:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220331190257.101781-1-wander@redhat.com> <20220331190257.101781-2-wander@redhat.com>
 <4767809d-5818-ad40-a0e7-b3af40aa071e@kernel.org>
In-Reply-To: <4767809d-5818-ad40-a0e7-b3af40aa071e@kernel.org>
From:   Wander Costa <wcosta@redhat.com>
Date:   Fri, 1 Apr 2022 11:26:15 -0300
Message-ID: <CAAq0SUmZ1u0TLTOq9fcn68oTZ6iHmpALbjhhy3zh6T=Kz1afxg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] serial/8250: Use fifo in 8250 console driver
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        =?UTF-8?Q?Andr=C3=A9_Goddard_Rosa?= <andre.goddard@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Jon Hunter <jonathanh@nvidia.com>, phil@raspberrypi.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 1:36 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>

>
> ">" missing here. Doesn't a compiler warn about subtracting different types?
>

My local machine doesn't generate a warning; it causes a build error.
So my question was, how was I able to build and test yesterday in a
remote server? It turns out I built it with make -j40, so I missed the
error message because of the parallel build, and I didn't pay
attention that the output didn't display the modules_install typical
output. Usually, I do my tests in an RHEL9 machine, which ships with
kernel 5.14, but this time I tested in a Fedora machine, which ships
kernel 5.16. And for a moment, I forgot that. So when I booted with
kernel 5.16, I believed I was running my custom kernel. Luckily, v5
mainly was a squash of v4 with this port->state check added. Anyway,
sorry about the typo. v6 is on the way.

