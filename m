Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A679512BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244220AbiD1GmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiD1GmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:42:06 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FB897BBB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:38:53 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id t6-20020a056830224600b00605491a5cd7so2548525otd.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=kEjciLMEbJP2JT2eR/lm56SayQx0Q+7PiMH5tkUJMEQ=;
        b=2iBc2tY57H7tKLVZhVYx3hMLx/1DgkICbmlfkfCimneqIuUIm5RHcQgb5d3LCzo2xI
         o9GALWf37EZ8eNOVCaZ7wTKCl+HIG9hS8m8cDoLe2CUnhfbhCdlSCvIxe4AOdrSjDE5b
         2qVx8e3u49PsF76ejlU8NZrT6RjVzboAwyTvF9DNRsSliWRYZhN4t+7+lKLHfEdhPRSM
         4YK4cwx0QxYRWsDkdWhrO3c76wJQVjVeTwSuOzGEzARFwJddL3hXVk6COfPwvm8eEBPb
         cwJpkDocQCjhsvWZAcaaF0WQtAy8ybINelY6VZPes2xkhNUi4+4zZCVZKHXOc91XKT4S
         u3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kEjciLMEbJP2JT2eR/lm56SayQx0Q+7PiMH5tkUJMEQ=;
        b=wmwkYLZezssmPJIkL1Uee85MPirZDeV661h0lRnUqTHhJj+dDn8hunMOGizd9Y8Dg6
         HfwYNt5R+tzEQ/yBfsFN4kKiQAgguurasFTbGeT9dYkpaVvXv5Q8zprQUd4JTS5xpmCI
         PRfQbap/vz8NT6Kdpe2Tdfx4jhRP1GjnDr0MDXyAptEov4khk+EkhcHBfNfVIq/LehBN
         dAg10Kkb9NjFtA2+b6QGFT4KzDn2h5cjkoM6R37zW6IbvpLFrUxnFns8F1g0tPHhATZs
         rolDdG2CkaCkQvFfT9xFXhFe7iv+aZGgDkHcT22P2kumsQrm65iopM81Xt+5QjCDdE6R
         b/4w==
X-Gm-Message-State: AOAM532HLSviJlmoCUnsS1mDUxjvVIG8CfRTA4GJF0nArKuLRuXzQxFb
        25GSMiJh0lEl2UR3Sc6C5F1QnMixHsLZxg==
X-Google-Smtp-Source: ABdhPJyUyIdHchALMblYqr+jfvXuZ1tSGXYv5gCJT9c4rzTMn9yF3DgW4AdSOmtgIcjSUrCnWo4zGA==
X-Received: by 2002:a9d:c63:0:b0:605:e230:3162 with SMTP id 90-20020a9d0c63000000b00605e2303162mr1602463otr.348.1651127932887;
        Wed, 27 Apr 2022 23:38:52 -0700 (PDT)
Received: from [192.168.86.188] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id c17-20020a9d6851000000b0060551d14386sm6607559oto.13.2022.04.27.23.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 23:38:52 -0700 (PDT)
Message-ID: <06e71cfe-4928-539b-7b67-b06e3405f2cc@landley.net>
Date:   Thu, 28 Apr 2022 01:43:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: odd endianness toolchains for crosstool
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, arnd@arndb.de,
        linux-kernel@vger.kernel.org
References: <YmX7z+BirkA3VAfW@zx2c4.com>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <YmX7z+BirkA3VAfW@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/22 20:39, Jason A. Donenfeld wrote:
> Hey Arnd,
> 
> I'm again experimenting with switching to your crosstool toolchains for
> WireGuard's CI. I've hit a few snags in the process:
> 
> - For powerpc, gcc needs to be built with `--enable-secureplt
>   --with-long-double-64` in order for musl to run.
> - Need powerpc64le compiler (-mabi=elfv2).
> - Need mipsel compiler.
> - Need aarch64_be compiler.
> - Need armeb compiler.
> - Need mips64el compiler.

https://landley.net/toybox/faq.html#cross2
https://landley.net/toybox/downloads/binaries/toolchains/latest/

They're all musl based. I use them to build little bootable systems under qemu
with a 300 line bash script:

https://landley.net/toybox/faq.html#mkroot
https://landley.net/toybox/downloads/binaries/mkroot/latest/

Ala:

https://github.com/landley/toybox/blob/master/scripts/mkroot.sh

Rob
