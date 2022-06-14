Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCCF54BA0F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244156AbiFNTGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbiFNTG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:06:29 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EE762D4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:06:27 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 25so12942274edw.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RtQY3s2vYYq68H+r/lgX/x0yv7hdr9UXLRzRq5pNtQ=;
        b=IEOJkNe1bGyhhPHG1DEoQ0Ucjm42dZ1O7iMPXmgYjEYU66yMJUuQsKaOmWMADxC5gz
         06N8t4Rugf6GWyqk1uKlXIXS1WO36VAykdBQK9w2aI1uoNIFb3DN0ZZMpBYcZuF/11iE
         I5MsnbrRo0uIWSGXelUcnUz0/6CZIKWNOoStE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RtQY3s2vYYq68H+r/lgX/x0yv7hdr9UXLRzRq5pNtQ=;
        b=JnNW5SMYf+675X3GagBIJRAr4oOfHu34zanc8bbACGQhzp38GCysaTXrLZQQH3+MnN
         MzVdZs9V94nH4jdp2E3cs5vlfTUiPGACRh5gjV4Wr3j+si5Dh+RIMdfrGpBWpUA2p5H8
         FuP9umvEZc+Ess21mOY3/bcErPLBmsGlaHyUSCAxwGRfKlsRmf4InDGRmaQLBDqRM5CJ
         f5UlZJB9R4C19tIQfLFeouPhdas7wlA1HXkf4XGqaAkoUuwXSwD1fqWH8WeUZU+OA/ZG
         mf6oC4MBISH/sL5Wi81rExioizVvmVvnXJrkHsVzfa0IVzAuBV36aMa6xDCkHljKaZnH
         Hocg==
X-Gm-Message-State: AOAM5305HJ7N0F0BEVnKXyRzWO7Uco4WBITTEMXAwJyscUKkjoXdQlpx
        HtIWJ9jEs9Gt5uKz4yME7UK5O50LffmDx+rOfcs=
X-Google-Smtp-Source: AGRyM1ue2o/Bn7Axkg0wB5WLOL4cBOIZGGzL6C06I2iXxnqcePSdsV0v/yANwwCr16cF2+uLdP+aTg==
X-Received: by 2002:a05:6402:1857:b0:42d:bcd6:3a88 with SMTP id v23-20020a056402185700b0042dbcd63a88mr8059213edy.6.1655233585955;
        Tue, 14 Jun 2022 12:06:25 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id da26-20020a056402177a00b004315050d7dfsm7579314edb.81.2022.06.14.12.06.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 12:06:25 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id x6-20020a1c7c06000000b003972dfca96cso5303518wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:06:25 -0700 (PDT)
X-Received: by 2002:a05:600c:354c:b0:39c:7e86:6ff5 with SMTP id
 i12-20020a05600c354c00b0039c7e866ff5mr5742710wmq.145.1655233239137; Tue, 14
 Jun 2022 12:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <bd80cd0d-a364-4ebd-2a89-933f79eaf4c7@tmb.nu> <CAHk-=wix7+mGzS-hANyk7DZsZ1NgGMHjPzSQKggEomYrRCrP_Q@mail.gmail.com>
In-Reply-To: <CAHk-=wix7+mGzS-hANyk7DZsZ1NgGMHjPzSQKggEomYrRCrP_Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jun 2022 12:00:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgfFhwMP0=QQY_iZvf0kveR5=VGK919Ayn+ZSUADs9mag@mail.gmail.com>
Message-ID: <CAHk-=wgfFhwMP0=QQY_iZvf0kveR5=VGK919Ayn+ZSUADs9mag@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/251] 5.15.47-rc2 review
To:     Thomas Backlund <tmb@tmb.nu>, Jan Kara <jack@suse.cz>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Slade Watkins <slade@sladewatkins.com>
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

On Tue, Jun 14, 2022 at 11:51 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Or just make sure that noop_backing_dev_info is fully initialized
> before it's used.

I don't see any real reason why that

    err = bdi_init(&noop_backing_dev_info);

couldn't just be done very early. Maybe as the first call in
driver_init(), before the whole devtmpfs_init() etc.

But I might be missing some dependency there.

              Linus
