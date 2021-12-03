Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269EF467F88
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383307AbhLCVw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344144AbhLCVwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:52:24 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE3BC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 13:48:59 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id j18so8630971ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 13:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IDeRdhpoAj5TSghltVaQSNuQnQhtbp2XMUe5m+RBa+I=;
        b=AmnHaybw1fg068uclusv+Qkf8yVpSqijeFrG4mXWsQ+WSlp7R4+WViXHmBDTFmVCpM
         aUnDsTw8VWeCO+uN6p553IHfpe1Xvy/YAnpBLWbOAe/mp12nU3bH9E8k6VL1vxD7ECzs
         jIl5sfF2WjIRwm9rNigtt3g2SZnMWQuhbnSTG+d2OYwEvExlf8qejUhFTurjvYh9zL1/
         Ff7jdhpmm6HEk+QgmCq8SZB7yjg5YKh01/MyUqtvfyUrEVWesoK4I4m99rDgMe/+mCT0
         aQhJIr+NwwbZ5bFGXXAifh2g4xPZkFZE+PsQeVgO5hdOfocvAPkNi5rrzB9TIbDD01L/
         VhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IDeRdhpoAj5TSghltVaQSNuQnQhtbp2XMUe5m+RBa+I=;
        b=iBZ2VoSnKOwymnUCaNSLuawL77XoQYSs07k4H0P+Ui1bm9THWKSXnyB9VYQBIfMgxQ
         lJXnPGjTrLdj3R00kEZ9W7e0AhfAQor5U7vMJ5Z9Z8CNqfLfXbFtsx1dRmkIGnBEewbk
         FejBqa0jo03kZFj08jJZw9vKrp0xyW4Twt/ttkMVufwn8D1lt+uPmDgGrZpYxojkIoym
         rPCy3lZeKuCg5jVMCrjTnGH+reNM466qCL33VWiMHPvHLnOjugvto/mVz2o94FRwDY0E
         oqK5BGLSsuEIHsd6DJbkKuNXSKkGG7ccHnZYWDAu9Y4Ox4jtQx/E0gQFcbj6hCZGjkSn
         zWAg==
X-Gm-Message-State: AOAM531MvmVZWeASYowcmEv1PtSRFB/pYLVwOoHr7dQ4Fa/SEaKvcRiF
        3Eq/N7o6IMAzXRSKyNkCSHSeACWGwZ+x5OLEKXCG5w==
X-Google-Smtp-Source: ABdhPJxM7LeVBwx6zhzZJsNSW09G7vvN0O+sWKe2aJIvH1OvYBXnNTsyCYdJVgv1iUularp0CKJShjGpLxkPivWjvAc=
X-Received: by 2002:a2e:b169:: with SMTP id a9mr21273034ljm.369.1638568137816;
 Fri, 03 Dec 2021 13:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20211115174102.2211126-1-pgonda@google.com> <20211126051944.GA17358@gondor.apana.org.au>
In-Reply-To: <20211126051944.GA17358@gondor.apana.org.au>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 3 Dec 2021 14:48:46 -0700
Message-ID: <CAMkAt6o_bjdoQ7zTs7ZY5QrYcd2Wd7GzMzRMq8m5ZUBQRQMtVw@mail.gmail.com>
Subject: Re: [PATCH V4 0/5] Add SEV_INIT_EX support
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Thomas.Lendacky@amd.com, Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 10:20 PM Herbert Xu <herbert@gondor.apana.org.au> w=
rote:
>
> On Mon, Nov 15, 2021 at 09:40:57AM -0800, Peter Gonda wrote:
> > SEV_INIT requires users to unlock their SPI bus for the PSP's non
> > volatile (NV) storage. Users may wish to lock their SPI bus for numerou=
s
> > reasons, to support this the PSP firmware supports SEV_INIT_EX. INIT_EX
> > allows the firmware to use a region of memory for its NV storage leavin=
g
> > the kernel responsible for actually storing the data in a persistent
> > way. This series adds a new module parameter to ccp allowing users to
> > specify a path to a file for use as the PSP's NV storage. The ccp drive=
r
> > then reads the file into memory for the PSP to use and is responsible
> > for writing the file whenever the PSP modifies the memory region.
> >
> > V3
> > * Add another module parameter 'psp_init_on_probe' to allow for skippin=
g
> >   PSP init on module init.
> > * Fixes review comments from Sean.
> > * Fixes missing error checking with file reading.
> > * Removed setting 'error' to a set value in patch 1.
>
> This doesn't compile cleanly for me with C=3D1 W=3D1:
>
>   CC [M]  drivers/crypto/ccp/sev-dev.o
> In file included from ../arch/x86/include/asm/bug.h:84,
>                  from ../include/linux/bug.h:5,
>                  from ../include/linux/cpumask.h:14,
>                  from ../arch/x86/include/asm/cpumask.h:5,
>                  from ../arch/x86/include/asm/msr.h:11,
>                  from ../arch/x86/include/asm/processor.h:22,
>                  from ../arch/x86/include/asm/timex.h:5,
>                  from ../include/linux/timex.h:65,
>                  from ../include/linux/time32.h:13,
>                  from ../include/linux/time.h:60,
>                  from ../include/linux/stat.h:19,
>                  from ../include/linux/module.h:13,
>                  from ../drivers/crypto/ccp/sev-dev.c:10:
> ../drivers/crypto/ccp/sev-dev.c: In function =E2=80=98sev_read_init_ex_fi=
le=E2=80=99:
> ../include/linux/lockdep.h:286:52: error: invalid type argument of =E2=80=
=98->=E2=80=99 (have =E2=80=98struct mutex=E2=80=99)
>  #define lockdep_is_held(lock)  lock_is_held(&(lock)->dep_map)
>                                                     ^~
> Please fix and resubmit.

Thanks. Submitted a V5.1 with fixes.

>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
