Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A926585E7C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 12:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiGaKqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 06:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiGaKqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 06:46:43 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2033E9FC8;
        Sun, 31 Jul 2022 03:46:42 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id q16so7347857pgq.6;
        Sun, 31 Jul 2022 03:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=8LXfCuQf1ok+bLVaf+9Iv92NnrW84zioylbo1NJx9kw=;
        b=HOyZbPdInNSPQ6t57F4DnBMImvSkTrx2UpVj19plrD00sFbXgSgQw3sWUEmOkpsG1J
         WSRzOuptiKaGVUmV2Fw0dnciZ6wkDgv8hT4mSz0mdBzHU+/wwowQCh3RHnqJt3AV2FR8
         RuFC+beUV/EaV3vCZYXFGTDhGpF5vxkvbxQoJGlD8nvydEanYJJXlEtJQtF8zpw1waD5
         Rc5S7Vew7c43+NNupUlmUXpDw5YGim+mpubmKuHMn8L5esGX4LFXNm/uap/WRAVq9rLy
         2q16UU0WPz8lu/yZooQrgc3Q6I2RuQjnJsI6EK2/bBIdI5SaBHuPlWs4FfLIb2C52YQ+
         LlQw==
X-Gm-Message-State: AJIora9Ha6HVEZa1pavKThuG/YtFHOduswYW665RO32MtTbYc6nUXiAK
        8sP/ZlQqCVwU6zml1Sck/mw=
X-Google-Smtp-Source: AGRyM1sjuCSUeJt7xz12xOf9mO/jYiRZOm43VyPfkySA27/z2NC5UrGHWxWrs32xo0P5d2ELc8FHrQ==
X-Received: by 2002:a65:604a:0:b0:401:9c5f:876b with SMTP id a10-20020a65604a000000b004019c5f876bmr9390362pgp.459.1659264401524;
        Sun, 31 Jul 2022 03:46:41 -0700 (PDT)
Received: from [192.168.220.108] (bba556890.alshamil.net.ae. [86.98.159.122])
        by smtp.gmail.com with ESMTPSA id p12-20020aa79e8c000000b0052bae7b2af8sm168332pfq.201.2022.07.31.03.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 03:46:41 -0700 (PDT)
Message-ID: <b79b4f63-aa71-192c-54a9-6a8455bb9867@linux.com>
Date:   Sun, 31 Jul 2022 14:46:30 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: INFO: task hung in __floppy_read_block_0
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>,
        Dipanjan Das <mail.dipanjan.das@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        fleischermarius@googlemail.com, its.priyanka.bose@gmail.com
References: <CANX2M5ZSuHONz-TPVdGcW3q_n6Z2DKLM6M8RfG+mORA9CCQRsQ@mail.gmail.com>
 <CAKXUXMxVCCRB2uaAN68LZv6Fwe7zAkUmwCmsqB6pE=z_=cztMg@mail.gmail.com>
 <CANX2M5b9PBp9i5v_akXshQqBFRT4dTHg+PR2pWpHPa5RBOEUTg@mail.gmail.com>
 <20220731095307.GA12211@1wt.eu>
From:   Denis Efremov <efremov@linux.com>
In-Reply-To: <20220731095307.GA12211@1wt.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/31/22 13:53, Willy Tarreau wrote:
> Hi,
> 
> On Thu, Jul 28, 2022 at 01:20:33PM -0700, Dipanjan Das wrote:
>> On Thu, Jul 28, 2022 at 7:23 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>>>
>>> Dipanjan, are you really sure that you want to report a "INFO: task
>>> hung" bug identified with your syzkaller instance? Especially for a
>>> floppy driver, probably in your case even just an emulated one
>>> (right?). Reading data from floppies was always very slow as far as I
>>> remember those times...
>>
>> >From the bugs reported by syzkaller in the past, we observed that
>> several of these "INFO: task hung in... " reports were considered and
>> acted on, for example, this:
>> https://groups.google.com/g/syzkaller-bugs/c/L0SBaHZ5bYc. For the
>> reported issue, we noticed the read task stays blocked for 143
>> seconds, which seemed to be one the higher, especially given that it
>> is an emulated floppy drive (yes, you are right). If it deems normal,
>> then we do apologize for our misassesment.
> 
> FWIW I've been running the repro here on machine running 5.19-rc8 and
> equipped with a real floppy drive. The code is still running as I type,
> it sounds like it's destroying the floppy disk in it but after 12 minutes
> of torture, nothing happens.
> 
> Thus I'm a bit confused about what to look for. It's very likely that
> there are still bugs left in this driver, but trying to identify them
> and to validate a fix will be difficult if they cannot be reproduced.
> Maybe they only happen under emulation due to timing issues.
> 
> As such, any hint about the exact setup and how long to wait to get
> the error would be much appreciated.

It's relatively easy to get "INFO: task hung ..." with the floppy driver.
The simplest way is to do "while (true) { close(open("/dev/fd0", ...)); }"
in multiple threads. Maybe with O_NBLOCK flag, I don't remember the exact
details. The timeout value to report task hung matters here (i.e.
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT). If you stop executing the cycle the
requests will be processed eventually. Floppy driver contains a number
of timeouts for hardware requests because hardware is slow. I would not
treat it as a thing to fix because: 1) a user faces it only if he tries
to fuzz the driver 2) it's easy to break something in the driver
(testing is hard and it doesn't cover all hardware/use-cases, real users
will notice if something broken only ~6 six months after distros will release
kernels with LTS patches) 3) floppy is not a security problem in modern
distros (/dev/fd0 access requires disk group or floppy group at least).

Null-ptr-deref reported recently is a different bug and I will look at it.
Last week I was out of my hardware with only limited access to the email
and I wasn't able to do it. Sorry for delays.

Thanks,
Denis
