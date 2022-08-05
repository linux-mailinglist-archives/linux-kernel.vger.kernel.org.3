Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C532558A4B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 04:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbiHECaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 22:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiHECaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 22:30:09 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC2B6D9C9
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 19:30:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e13so1727759edj.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 19:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qTWkeFlRZnqwpCI34+5joMnqgdb8MiarGI8X4TrBXY4=;
        b=hbFZSme/BYq0JK0mDEuehPSBM0egDecgUHj3R5Uf4Z6RC33hTa4k1teKJF6K4jvz8l
         sQFHsgqMgz2E7So+KhXZLjyJQcPuEoiONyYM72BQ/HMRlk6YSdAOfEqZ8ZeedunZioPC
         LFnZMCaqn4piDHrgj0BqrfPOSm4Ay1y8ytT0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qTWkeFlRZnqwpCI34+5joMnqgdb8MiarGI8X4TrBXY4=;
        b=RamW6IDuHZZKZKEC5A0uvQWCd5O2cnIVIKkscsYzCe0Nd1U2zGTj82xaqbKsRkdCXM
         9jFQhNGUMhlbKsnY0noIDRRA1Zz/VZGtNVXEgV3jn9yFuD+HJ0Ex8t6V761qynoBUrW3
         ZVTP5DtSj5znhGlPRDQy20ACqnrk+QxHznZU56pBUlWCJUCN4hFnnvkwwIwrQVJMDPyx
         YblGQKLEZji9crIz+NBdhw8EyM7fw9A3INNQBlmSqBQ8TvJJezdRXLgghOy2+0t/GI5d
         PecADkRLtlePEL/jzWbN8ikcj+MbX/m42vUybM1Qmlft/NdNe06pV7PtQqPYF8W6CHf6
         kKgg==
X-Gm-Message-State: ACgBeo1YnbhM5nGhhd729zfM8KyOU8ozU9e4zlmslyE3SSQJWvfWqGnJ
        T75SnTJfUmDDGSwUYIAJz/Ic0G62/NmVxYpm
X-Google-Smtp-Source: AA6agR48zz2UEYi02fgHF89268AW9pxX3zN6DzVJmuCGb/R+YnVMoDIFctiR5ePKjE+uMf+J/XSalg==
X-Received: by 2002:a50:fb10:0:b0:43d:561a:c990 with SMTP id d16-20020a50fb10000000b0043d561ac990mr4551534edq.115.1659666606924;
        Thu, 04 Aug 2022 19:30:06 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id ep11-20020a1709069b4b00b0073087f7dfe2sm989251ejc.125.2022.08.04.19.30.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 19:30:06 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id z12so1707055wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 19:30:06 -0700 (PDT)
X-Received: by 2002:a5d:64c1:0:b0:220:8590:3809 with SMTP id
 f1-20020a5d64c1000000b0022085903809mr2919665wri.97.1659666605721; Thu, 04 Aug
 2022 19:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <YuuJNJ7/3AXzKMF7@matsya>
In-Reply-To: <YuuJNJ7/3AXzKMF7@matsya>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Aug 2022 19:29:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=0TfDnDhaxsbS83yrrhXFmROu94pNLUgPAYuc9OSBjA@mail.gmail.com>
Message-ID: <CAHk-=wi=0TfDnDhaxsbS83yrrhXFmROu94pNLUgPAYuc9OSBjA@mail.gmail.com>
Subject: Re: [GIT PULL]: dmaengine updates for v6.0-rc1
To:     Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Hector Martin <marcan@marcan.st>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 1:54 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> Please pull to receive dmaengine updates for v6.0-rc1. One thing which
> might interest you is the Apple ADMAC driver which should be for your
> shiny new laptop :)

I can confirm that my M2 laptop boots with this version of the driver too.

Which I guess should surprise nobody, since it seems to be a slightly
newer version of the one in the Asahi branch, and the differences seem
to be mainly a few updates and cleanups.

Thanks,
            Linus
