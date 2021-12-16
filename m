Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762A6477A39
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbhLPROz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhLPROx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:14:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F743C061574;
        Thu, 16 Dec 2021 09:14:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42C3561EAF;
        Thu, 16 Dec 2021 17:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FFEC36AE7;
        Thu, 16 Dec 2021 17:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639674891;
        bh=we7yz9zt7KnHuiNIIROegupjlifBVTWfkUUGxXRDoMA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QzjxhS04DOak1Q9EQORzoXemhUUkI7tYoOhDoPUjMeGSRwaaeGVLu7G8miBhwR7kp
         iyqbqtv5kFkhrEcfJJlaTFH89X5w7CGqQIy4FQBCgz4pphnQfWBnLHIIXBjZC8N/mh
         mZEl/XlMHCzHkJONHO8nnYYREJsMV/8hodtcekBi42MxeQEI+I2qNLxGSX2WLzo55y
         1JcGwkEj1y8ezdEGGTmyXA2DKJ6GP+tWKMZL1d+6X3X2//vOUlFjt+WvHRuyulUFud
         1nvnikD+97o0hNNt/xXkuSDvS0Zbqs3vdo8ZmKBgFgFkGlCBypW+yhxQfK7Yjnwwpw
         udnFwm/qKUf6w==
Received: by mail-wr1-f42.google.com with SMTP id v11so45395105wrw.10;
        Thu, 16 Dec 2021 09:14:51 -0800 (PST)
X-Gm-Message-State: AOAM530z5+f1PniFDBtiZP2v2mCovvKoQCcS2eKQxQoVU0fdAgiroWkJ
        dYywek1sM1+kRRwz6bKRazV0mvGVqqtvjVWOTaM=
X-Google-Smtp-Source: ABdhPJy78M1um7N5cIvFUityihbq/ys0BTr8bYLECyzu+z++PpYpJYkwRJWorPoWDAVVB4433T+DwlpYx0qOqbqUDsI=
X-Received: by 2002:adf:dc44:: with SMTP id m4mr9929207wrj.550.1639674890091;
 Thu, 16 Dec 2021 09:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20211210143009.4770-1-andriy.shevchenko@linux.intel.com> <YbtVNKdrIKFsbIAc@smile.fi.intel.com>
In-Reply-To: <YbtVNKdrIKFsbIAc@smile.fi.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Dec 2021 18:14:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF-badBtZj0Uf=g4RnxHYgv-zrPsG1Z3xAqWokZ0zhLtA@mail.gmail.com>
Message-ID: <CAMj1kXF-badBtZj0Uf=g4RnxHYgv-zrPsG1Z3xAqWokZ0zhLtA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] crypto: Replace kernel.h with the necessary inclusions
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 at 16:05, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Dec 10, 2021 at 04:30:09PM +0200, Andy Shevchenko wrote:
> > When kernel.h is used in the headers it adds a lot into dependency hell,
> > especially when there are circular dependencies are involved.
> >
> > Replace kernel.h inclusion with the list of what is really being used.
>
> Any comments on this?
>

I am not crazy about the need for forward declarations of struct
scatterlist and struct device. Other than that, I think this is an
improvement
