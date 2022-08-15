Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8171592808
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiHODTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiHODTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:19:05 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF9312A99
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:19:03 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r4so8081687edi.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=LhaahkH5GFRbxIpnuv9xFvPIRlQILzNnIFZLeZOgjmM=;
        b=TCYZxAAYo/vLLcSD2mRJvt/g+H+dlLudRinfizXWloZ1cPjGnz0JyBIT4/0bLPtRRf
         anF+qCuIRDFCkx6I6g2E4S2AC2w8Oz9pavFOPgc6/CS+F57XO/FkZxYLf3fIRH0Yycbo
         EinIQd5MExmUoQhau+ZWU9cQxOjIzKp9+zrVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LhaahkH5GFRbxIpnuv9xFvPIRlQILzNnIFZLeZOgjmM=;
        b=JzJ2pfpuBCxSxtj5iYcC14KIYnJVyZL36P0SxIRdfxvg/AUwDcyRo26LBiFXm/v2oA
         N9P+7uQEvc42E5uZq+FMnFtZhS9ErEPPiHsDOBaahCbI2hhxityscXaebcDTLNPi42xq
         C7xMBXeTEYWrDfYaxp5+dbC+REMMBIpJOO0x4/BOsOXkEXsnnx4JC2ZJHHdHaaINI0WH
         zCw8rzCIIjydpppU9JsXM0KXshtMpige6q24EZKfTR8SP7ENvFcMLta9O2GJ+jhlrCE9
         5ETQMa/Fzj5y1mA62KnkCcjRCvtKMA0ZK1LmOC8977zi4vFAZwxQgT00MoPkJjM84W7x
         hCSg==
X-Gm-Message-State: ACgBeo2Zp1WAgoa5lAfC3ZCeIlLuFguNk1P794BMDFMd6r4sP8RGOFIZ
        mtn4RpnSiKkzuNTjHeaWN8MCp0tN0dMswnMb
X-Google-Smtp-Source: AA6agR7Zh1TLYRWr/AaEId+PUtcHV/pVs+2yGPS0Sem2ru/M6kLXozo6z2loTGKUpTbdUQsEZPQZyQ==
X-Received: by 2002:a05:6402:378f:b0:43a:d3f5:79f2 with SMTP id et15-20020a056402378f00b0043ad3f579f2mr13017395edb.338.1660533542352;
        Sun, 14 Aug 2022 20:19:02 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id kx18-20020a170907775200b007341663d7ddsm3533797ejc.96.2022.08.14.20.19.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 20:19:01 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id bs25so7671525wrb.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:19:01 -0700 (PDT)
X-Received: by 2002:a5d:6248:0:b0:222:cd3b:94c8 with SMTP id
 m8-20020a5d6248000000b00222cd3b94c8mr7621171wrv.97.1660533540842; Sun, 14 Aug
 2022 20:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220814212610.GA3690074@roeck-us.net> <CAHk-=wgf2EfLHui6A5NbWoaVBB2f8t-XBUiOMkyjN2NU41t6eA@mail.gmail.com>
 <20220814223743.26ebsbnrvrjien4f@awork3.anarazel.de> <CAHk-=wi6raoJE-1cyRU0YxJ+9ReO1eXmOAq0FwKAyZS7nhvk9w@mail.gmail.com>
 <1c057afa-92df-ee3c-5978-3731d3db9345@kernel.dk> <20220815013651.mrm7qgklk6sgpkbb@awork3.anarazel.de>
In-Reply-To: <20220815013651.mrm7qgklk6sgpkbb@awork3.anarazel.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Aug 2022 20:18:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wikzU4402P-FpJRK_QwfVOS+t-3p1Wx5awGHTvr-s_0Ew@mail.gmail.com>
Message-ID: <CAHk-=wikzU4402P-FpJRK_QwfVOS+t-3p1Wx5awGHTvr-s_0Ew@mail.gmail.com>
Subject: Re: upstream kernel crashes
To:     Andres Freund <andres@anarazel.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 6:36 PM Andres Freund <andres@anarazel.de> wrote:
>
> Some of the symptoms could be related to the issue in this thread, hence
> listing them here

Smells like slab corruption to me, and the problems may end up being
then largely random just depending on who ends up using the allocation
that gets trampled on.

I wouldn't be surprised if it's all the same thing - including your
network issue.

Both you and Guenter seem to be seeing this on that google cloud VM
setup, which may or may not be related. I haven't seen any reports
from anybody else, but that might still be just coincidence.

But it makes me go back to your original report, where you suspected
the virtio pull.

Looking at that original report, and doing

    gitk 7ebfc85e2cd7..69dac8e431af

nothing else looks all that relevant, although obviously any random
error path could end up doing a double free and messing up the slab
cache that way. But a lot of the non-virtio stuff there is things like
RISC-V and devicetree that definitely shouldn't have any effect.

Adding Michael Tsirkin to this thread too, just so he knows.

            Linus
