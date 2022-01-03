Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F81482E8C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 07:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiACGvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 01:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiACGvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 01:51:19 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC88FC061792
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 22:51:18 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id h15so41037640ljh.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 22:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dAzVrnb858O63Q3XBgubcfTdy81Z6So6rI7A56IA41A=;
        b=q2I0bIKDCcbo4LKRzdhRHiirZxQE1khPOkPIIddoVFcxaPpHdMffNmMaMjEoKm6mhG
         ZLJgu7nza4KYBdvvawyough4ceq0queDDYCn0JDonA5FPskpthhzX+k5gOL1VcYjyFKC
         XmG/J0raUOX7B9iRiEcgm3c46u6d8P7FfhMqeTlrVdJSsuYVt2W7FpnsqgVT3esAcUOq
         v1KKx27k0ym0LPaCplbpSAxcqiiCgsudWu4N2pSI9mvpz0gODZ2/0CjNgPVHCZJeLa6U
         8BIROPU8O4mut+7qx60zrR9luMwvb1XEvzGEy3t1WPLgnbFWO69rmZOr+q6BYs8r3OQ0
         XdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAzVrnb858O63Q3XBgubcfTdy81Z6So6rI7A56IA41A=;
        b=FX+78TH6vwsbqPi5cHzuT3ZlswAIAaNiQ+0Tj1bvB+SC85dRfmswC1AqBIJA9K22bZ
         2QOnz5i5lQYcOFdaLKsT4YQYM3fGxIz+fpRokgnzYOd3vWjauXvI2GiN2vQ09axgGYJ2
         kVdOLI/5GMLPJOD68aUy/OQgE+4Oy3ZGP6Eoznq918icBEwInCkBGpcaFAovy8DqLlYH
         Z0go35hhKLNsC+5vr2sAlMXDyvAjf+eCOwx19CFKiHUzpWJajCpJoWyVwuEU31Aa3Q0K
         6Xd7Yk7KPnEZfHXasCROiMUxCE6ZMnfRfiYJBgkPwF0BIdbrJyKJf+Dcpny19ETYJKKs
         EP2Q==
X-Gm-Message-State: AOAM531ApSKB0deRMRjzj4b7dK1b/RvdEPiCxIrF6/Cwex7yeQae2xeR
        Mw6GnPqqmjGIvMdMheRW9Gyec3O4qM3GK1k3CCPo2A==
X-Google-Smtp-Source: ABdhPJzaIj8bPdR2AP/fkIHOVO8Js8TuL0VI7GXTi5ZobA/AyT/1w440fgE5XJK3YxeqlFmsdWW3hO4UsffME+a47ao=
X-Received: by 2002:a2e:bf01:: with SMTP id c1mr4483485ljr.511.1641192675956;
 Sun, 02 Jan 2022 22:51:15 -0800 (PST)
MIME-Version: 1.0
References: <20211229215330.4134835-1-yaelt@google.com> <CAFA6WYPuPHgcnzt6j+Q-EA2Dos6vBDukrjpheo5srLVXFrifEg@mail.gmail.com>
 <5a38824152eeee0fc9ba0a4fd2308bb6e0970059.camel@linux.ibm.com>
In-Reply-To: <5a38824152eeee0fc9ba0a4fd2308bb6e0970059.camel@linux.ibm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 3 Jan 2022 12:21:04 +0530
Message-ID: <CAFA6WYOJt3=YMTt_QQSq6Z-MK42hwWspgSpasw2fuPtVFcP3uA@mail.gmail.com>
Subject: Re: [PATCH v4] KEYS: encrypted: Instantiate key with user-provided
 decrypted data
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Yael Tiomkin <yaelt@google.com>, linux-integrity@vger.kernel.org,
        jejb@linux.ibm.com, jarkko@kernel.org, corbet@lwn.net,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

Apologies for the delayed reply as I was on leave for a long new year weekend.

On Thu, 30 Dec 2021 at 18:59, Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Hi Sumit,
>
> On Thu, 2021-12-30 at 15:37 +0530, Sumit Garg wrote:
> > + Jan, Ahmad
> >
> > On Thu, 30 Dec 2021 at 03:24, Yael Tiomkin <yaelt@google.com> wrote:
> > >
> > > The encrypted.c class supports instantiation of encrypted keys with
> > > either an already-encrypted key material, or by generating new key
> > > material based on random numbers. This patch defines a new datablob
> > > format: [<format>] <master-key name> <decrypted data length>
> > > <decrypted data> that allows to instantiate encrypted keys using
> > > user-provided decrypted data, and therefore allows to perform key
> > > encryption from userspace. The decrypted key material will be
> > > inaccessible from userspace.
> >
> > This type of user-space key import feature has already been discussed
> > at large in the context of trusted keys here [1]. So what makes it
> > special in case of encrypted keys such that it isn't a "UNSAFE_IMPORT"
> > or "DEBUGGING_IMPORT" or "DEVELOPMENT_IMPORT", ...?
> >
> > [1] https://lore.kernel.org/linux-integrity/74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de/
> >
> > -Sumit
> >
> > >
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > Signed-off-by: Yael Tiomkin <yaelt@google.com>
>
> There is a difference between trusted and encrypted keys.

Yeah I understand the implementation differences.

>  So in
> addition to pointing to the rather long discussion thread, please
> summarize the conclusion and, assuming you agree, include why in once
> case it was acceptable and in the other it wasn't to provide userspace
> key data.

My major concern with importing user-space key data in *plain* format
is that if import is *not* done in a safe (manufacturing or
production) environment then the plain key data is susceptible to
user-space compromises when the device is in the field.

And it sounds like we are diverting from basic definition [1] of encrypted keys:

"Trusted and Encrypted Keys are two new key types added to the
existing kernel key ring service. Both of these new types are variable
length symmetric keys, and in both cases all keys are created in the
kernel, and **user space sees, stores, and loads** only encrypted
blobs."

Also, as Jarrko mentioned earlier the use-case is still not clear to
me as well. Isn't user logon keys an alternative option for
non-readable user-space keys?

[1] https://www.kernel.org/doc/html/v4.13/security/keys/trusted-encrypted.html

-Sumit

>
> thanks,
>
> Mimi
>
