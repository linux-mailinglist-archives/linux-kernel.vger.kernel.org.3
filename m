Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263314935F6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346862AbiASIBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343971AbiASIBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:01:39 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA9AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:01:38 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b13so7544193edn.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+4TAAW0oCGxfeZjzEbwErifa+6E3JL+Snfdxuo9hi4=;
        b=VphISyBLHqMdbjiWr2Zai00b4bFXug+8mUgSJxbfpZQoTAGgs2rCN2UNKbJD2vXt6i
         GbOkmqHLi5vXN621pAU3O1Ao0bKq9j/ukvtcqner6W2s0X1EaCJuZ1aCZNCFt6lFO7Ig
         tH+1kqNjJqFLVH0/8uHItRZFdFBLAZZJMq+2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+4TAAW0oCGxfeZjzEbwErifa+6E3JL+Snfdxuo9hi4=;
        b=qvAyZsQI1/ZGfjryTe2COJfXb/awC0sBPBrFbWdiH+KRsaBKSW9kTinCTh6Raye5Nv
         QQM16oZZc2Xmuu7JI0jP3XL3CHJWIFe34InquJWH+RG73U/uHBaxEitG967WUlIj3Qaz
         3evIdPCVbMhTVhCuRrJHkQVHCuOm8G0Je+cUa5hlyYhTI6tqidvDrpHj6RtK73QIRHeP
         f2/QloJnvSKxbCWHEOb/9L9mutKjBQNwr/6vgKbTwpyBQtpR+wCY9QAkSWzGlOqZ2PVl
         wCVqynKRYJpYCVj9vJ00Gb89U9gWXK5iUxcJsY/+w7GY0rytmi5llWQ51gLvohdVJuyP
         schg==
X-Gm-Message-State: AOAM530GbcWyWkLfIYXf7nyh3mjzbX1zvL7HrBinYBMYZbjzyqQyF4a9
        8UQU9L8Gf7JuMNqvAuSFqKkxSrxciXClbsGqx+A=
X-Google-Smtp-Source: ABdhPJwiwfF6jks448d1MbcLfqOwg2iIEIVn6c/I1kOxbbMKWBreFSElo5wGTAVo3pUR863Yx1KgUA==
X-Received: by 2002:a05:6402:b3c:: with SMTP id bo28mr29809127edb.314.1642579297167;
        Wed, 19 Jan 2022 00:01:37 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id lb11sm6095698ejc.216.2022.01.19.00.01.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 00:01:36 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id m4so7212864edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:01:36 -0800 (PST)
X-Received: by 2002:adf:c74e:: with SMTP id b14mr27546389wrh.97.1642578820207;
 Tue, 18 Jan 2022 23:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20220118160452.384322748@linuxfoundation.org> <CA+G9fYvJaFVKu24oFuR1wGFRe4N2A=yxH6ksx61bunfR9Y3Ejw@mail.gmail.com>
In-Reply-To: <CA+G9fYvJaFVKu24oFuR1wGFRe4N2A=yxH6ksx61bunfR9Y3Ejw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Jan 2022 09:53:24 +0200
X-Gmail-Original-Message-ID: <CAHk-=whJjHXGeVnVPmC8t_+Rie5N1tarrzsttECEh5efbXYUuA@mail.gmail.com>
Message-ID: <CAHk-=whJjHXGeVnVPmC8t_+Rie5N1tarrzsttECEh5efbXYUuA@mail.gmail.com>
Subject: Re: [PATCH 5.16 00/28] 5.16.2-rc1 review
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        NeilBrown <neilb@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        stable <stable@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 9:30 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Inconsistent kallsyms data

This tends to be a "odd build environment" problem, and very very
random. Triggered by very particular compiler versions and just some
odd code modement details.

I'd suggest doing a completely clean build and disabling ccache, and
seeing if that makes it go away.

              Linus
