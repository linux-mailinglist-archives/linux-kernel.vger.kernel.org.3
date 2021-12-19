Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D3A47A204
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 21:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbhLSUOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 15:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhLSUOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 15:14:49 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28C8C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 12:14:48 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id m21so2994361edc.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 12:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sTdI+sIAjC2OQJaFkp0olcNH/rXd7PcbURWdipoviYg=;
        b=bQ2TnAiWAXuxhuLJ2ziLj6XVQhZW9+llBd8h2H/ZCqL5L001VXBEEPy3IlwM0tQuX4
         pu1c44oF4TzJxflGh1eitFb9KW5OwrFTfQXtMnnCrOBiNNnShVLZwZwqcwRkfhNQV3w6
         tc9r/i8fPrA8IVqc68fVcK1/iEKJJRXS5RXPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTdI+sIAjC2OQJaFkp0olcNH/rXd7PcbURWdipoviYg=;
        b=GwuMh3DismP3eVWph9Ficshr2jJNpwWfgHjr9a4pATgwf0zlp+/vdaZsRlAd8xePBD
         dkeYGfdFmoknkxtRe/pWa07y/QpONTz15LOjloZyhYGiyTwgCWU/JdPyw/6JLc1Z6dhD
         ASPJrzpU0tDj8hbP1VbPqr7DVr9MNGWnaWr/MmMkhS2uptWuo3J/HOJlG5z99wbAOghK
         hYrkZDl4t7oaxsNN69Pvr0b5kUkcyM03WcL145QvOuY8fBKBFUDVR9gkwv6uHBYlc0mQ
         qLRJ5T1jG8aUR5q+7OdqcivfoUoA0XFc8ZgTI0gKamphlYdRHtldpuPUgGljbKyur8aS
         UEsg==
X-Gm-Message-State: AOAM5306Rl9tf5mY47T8Xe1EkXa4pD1S/qhtXaEoDyQ3oDZ65bW4gNgQ
        yvat1TdfCc8IqCTBNSrmFRlH3DvfNfEc6y3DV2s=
X-Google-Smtp-Source: ABdhPJw0b291JeOgyND/ndV+I3uNDs4+5RsQVyQeXTVU0A5oPcSUx2Mx6iIm0T4Fl4wiFA6clRgVnQ==
X-Received: by 2002:a17:907:8692:: with SMTP id qa18mr10154390ejc.7.1639944887225;
        Sun, 19 Dec 2021 12:14:47 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id f26sm4628830ejf.131.2021.12.19.12.14.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 12:14:45 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id j18so15972245wrd.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 12:14:45 -0800 (PST)
X-Received: by 2002:a5d:6211:: with SMTP id y17mr10458128wru.97.1639944885363;
 Sun, 19 Dec 2021 12:14:45 -0800 (PST)
MIME-Version: 1.0
References: <Yb82O5i2DVcK9nAJ@zn.tnic>
In-Reply-To: <Yb82O5i2DVcK9nAJ@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Dec 2021 12:14:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiNMghi=nZc432_Sj4QwG+BtxGUtovnpVQk-LpDj8r3ZA@mail.gmail.com>
Message-ID: <CAHk-=wiNMghi=nZc432_Sj4QwG+BtxGUtovnpVQk-LpDj8r3ZA@mail.gmail.com>
Subject: Re: [GIT PULL] core/urgent for v5.16-rc6
To:     Borislav Petkov <bp@suse.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000058121f05d3856c61"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000058121f05d3856c61
Content-Type: text/plain; charset="UTF-8"

On Sun, Dec 19, 2021 at 5:40 AM Borislav Petkov <bp@suse.de> wrote:
>
> Prevent lock contention on the new sigaltstack lock on the common-case
> path, when no changes have been made to the alternative signal stack.

I pulled this, but I think it's wrong.

It checks whether the new ss_size/ss_sp is the same as the old ones,
and skips the work if so.

But that check is bogus.

Why? Because it's comparing the wrong values.

It's comparing the values as they are *before* they are fixed up for
the SS_DISABLE case.

So if the new mode is SS_DISABLE, it's going to compare the values
against the old values for ss_size and ss_sp: but those old values
will have been reset to 0/NULL.

And the new values have not been reset yet before the comparison.

So the comparison wil easily fail when it shouldn't.

And that's all pointless anyway. If it's SS_DISABLE, there's no point
in doing *any* of this.

Now, I decided to keep the pull, because this bug only means that the
commit isn't actually as effective as it *should* be.

Honestly, that do_sigaltstack code is written just about pessimally,
and taking the sigaltstack_lock just for the limit checking is all
kinds of silly.

The SS_DISABLE case shouldn't take the lock at all.

And the actual modification of the values shouldn't need any locking
at all, since it's all thread-local.

I'm not convinced even the limit checking needs the lock, but
whatever. I think it could maybe just use "read_once()" or something.

I think the attached patch is an improvement, but I did *not* test
this, and I'm just throwing this out as a "maybe something like this".

Comments?

Note: I will throw this patch away after sending it out. If people agree,

                  Linus

--00000000000058121f05d3856c61
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kxdonna10>
X-Attachment-Id: f_kxdonna10

IGtlcm5lbC9zaWduYWwuYyB8IDM2ICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2tlcm5lbC9zaWduYWwuYyBiL2tlcm5lbC9zaWduYWwuYwppbmRleCBkZmNlZTM4
ODhiMDAuLmY1OGYxZDU3NDkzMSAxMDA2NDQKLS0tIGEva2VybmVsL3NpZ25hbC5jCisrKyBiL2tl
cm5lbC9zaWduYWwuYwpAQCAtNDE2MSw3ICs0MTYxLDYgQEAgZG9fc2lnYWx0c3RhY2sgKGNvbnN0
IHN0YWNrX3QgKnNzLCBzdGFja190ICpvc3MsIHVuc2lnbmVkIGxvbmcgc3AsCiAJCXNpemVfdCBt
aW5fc3Nfc2l6ZSkKIHsKIAlzdHJ1Y3QgdGFza19zdHJ1Y3QgKnQgPSBjdXJyZW50OwotCWludCBy
ZXQgPSAwOwogCiAJaWYgKG9zcykgewogCQltZW1zZXQob3NzLCAwLCBzaXplb2Yoc3RhY2tfdCkp
OwpAQCAtNDE4MSw4ICs0MTgwLDE1IEBAIGRvX3NpZ2FsdHN0YWNrIChjb25zdCBzdGFja190ICpz
cywgc3RhY2tfdCAqb3NzLCB1bnNpZ25lZCBsb25nIHNwLAogCQkJcmV0dXJuIC1FUEVSTTsKIAog
CQlzc19tb2RlID0gc3NfZmxhZ3MgJiB+U1NfRkxBR19CSVRTOwotCQlpZiAodW5saWtlbHkoc3Nf
bW9kZSAhPSBTU19ESVNBQkxFICYmIHNzX21vZGUgIT0gU1NfT05TVEFDSyAmJgotCQkJCXNzX21v
ZGUgIT0gMCkpCisKKwkJaWYgKHNzX21vZGUgPT0gU1NfRElTQUJMRSkgeworCQkJdC0+c2FzX3Nz
X3NwID0gMDsKKwkJCXQtPnNhc19zc19zaXplID0gMDsKKwkJCXQtPnNhc19zc19mbGFncyA9IHNz
X2ZsYWdzOworCQkJcmV0dXJuIDA7CisJCX0KKworCQlpZiAodW5saWtlbHkoc3NfbW9kZSAhPSBT
U19PTlNUQUNLICYmIHNzX21vZGUgIT0gMCkpCiAJCQlyZXR1cm4gLUVJTlZBTDsKIAogCQkvKgpA
QCAtNDE5NCwyNCArNDIwMCwyMCBAQCBkb19zaWdhbHRzdGFjayAoY29uc3Qgc3RhY2tfdCAqc3Ms
IHN0YWNrX3QgKm9zcywgdW5zaWduZWQgbG9uZyBzcCwKIAkJICAgIHQtPnNhc19zc19mbGFncyA9
PSBzc19mbGFncykKIAkJCXJldHVybiAwOwogCisJCS8qIElzIHRoaXMgbG9jayByZWFsbHkgd29y
dGggaXQ/ICovCiAJCXNpZ2FsdHN0YWNrX2xvY2soKTsKLQkJaWYgKHNzX21vZGUgPT0gU1NfRElT
QUJMRSkgewotCQkJc3Nfc2l6ZSA9IDA7Ci0JCQlzc19zcCA9IE5VTEw7Ci0JCX0gZWxzZSB7Ci0J
CQlpZiAodW5saWtlbHkoc3Nfc2l6ZSA8IG1pbl9zc19zaXplKSkKLQkJCQlyZXQgPSAtRU5PTUVN
OwotCQkJaWYgKCFzaWdhbHRzdGFja19zaXplX3ZhbGlkKHNzX3NpemUpKQotCQkJCXJldCA9IC1F
Tk9NRU07Ci0JCX0KLQkJaWYgKCFyZXQpIHsKLQkJCXQtPnNhc19zc19zcCA9ICh1bnNpZ25lZCBs
b25nKSBzc19zcDsKLQkJCXQtPnNhc19zc19zaXplID0gc3Nfc2l6ZTsKLQkJCXQtPnNhc19zc19m
bGFncyA9IHNzX2ZsYWdzOworCQlpZiAodW5saWtlbHkoc3Nfc2l6ZSA8IG1pbl9zc19zaXplKSB8
fAorCQkgICAgdW5saWtlbHkoc2lnYWx0c3RhY2tfc2l6ZV92YWxpZChzc19zaXplKSkpIHsKKwkJ
CXNpZ2FsdHN0YWNrX3VubG9jaygpOworCQkJcmV0dXJuIC1FTk9NRU07CiAJCX0KIAkJc2lnYWx0
c3RhY2tfdW5sb2NrKCk7CisKKwkJdC0+c2FzX3NzX3NwID0gKHVuc2lnbmVkIGxvbmcpIHNzX3Nw
OworCQl0LT5zYXNfc3Nfc2l6ZSA9IHNzX3NpemU7CisJCXQtPnNhc19zc19mbGFncyA9IHNzX2Zs
YWdzOwogCX0KLQlyZXR1cm4gcmV0OworCXJldHVybiAwOwogfQogCiBTWVNDQUxMX0RFRklORTIo
c2lnYWx0c3RhY2ssY29uc3Qgc3RhY2tfdCBfX3VzZXIgKix1c3MsIHN0YWNrX3QgX191c2VyICos
dW9zcykK
--00000000000058121f05d3856c61--
