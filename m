Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FB2470CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344564AbhLJWDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239516AbhLJWDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:03:03 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC8CC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:59:27 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z5so34788901edd.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7+mF54L+8zyE0wNsoNaTjngPRPEIVWZP5nxhfmXy0J4=;
        b=f8EHtham7PBDtyKhtwDT5Q7pOSUHBh8VvB53jA4NjiWjndONo4+lIGRQSSQsD8vui0
         RTDvquDnzfvfbU2nYES9REkh1X5GCSTaA6iZ95uik1y7BYSLfdAol8wVjo7m6eAkIRKT
         fafnkGTXCSEbLVX4dCjXP3okvl9019BKZscp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7+mF54L+8zyE0wNsoNaTjngPRPEIVWZP5nxhfmXy0J4=;
        b=LZkwehhD9xY1qz0OKU5TZWuX9Vz11QSKhJ+2jPWK03fVk9tpjK/RKt+CN0A7FgdHTi
         xh3GK+TViPtwAyD3SjY7Z9vQygqfYnFNRglnRQLj01VCjUKt345NKyYoU/TeVqcPa7he
         bDJymtJ2fBKmDYitxgLOkQi01yqi2Yqt+XqwioA9fnlMlh9p4unncZmBZ8r3vzUOM6nQ
         KBU2TdXiBAiskKPrS2TTItCSocKn2IhkG+Q/R+uv1VmjQha1QhnmM+v7KKelqYUkRP6M
         JnzPVpAKNMmJ89qR9VLQK35CN54XWn+yzl2XfbpIzZxiy0iIx0ue33nA5afPGb2eoZkN
         AIGg==
X-Gm-Message-State: AOAM533UpfgRak0TKDJhtr81rm1UCe00MTEKLXe8sVVBNdt5MRWP5FI9
        UEJWKatr1bwMiJogGqE43aifdbGWfd02K5sYil0=
X-Google-Smtp-Source: ABdhPJzQALUBxtvbfOhB+GrzOxgII8ZQlhrCnb54mn1EaGpALb5mSMc4XZadSa1ckdMvY5mDS0JbIw==
X-Received: by 2002:a17:907:1b11:: with SMTP id mp17mr26380813ejc.374.1639173566055;
        Fri, 10 Dec 2021 13:59:26 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id v3sm2104579edc.69.2021.12.10.13.59.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 13:59:25 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id d24so17339269wra.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:59:25 -0800 (PST)
X-Received: by 2002:a5d:4575:: with SMTP id a21mr17497854wrc.193.1639173564787;
 Fri, 10 Dec 2021 13:59:24 -0800 (PST)
MIME-Version: 1.0
References: <20211210053743.GA36420@xsang-OptiPlex-9020> <CAHk-=wgxd2DqzM3PAsFmzJDHFggxg7ODTQxfJoGCRDbjgMm8nA@mail.gmail.com>
 <CAG48ez1pnatAB095dnbrn9LbuQe4+ENwh-WEW36pM40ozhpruw@mail.gmail.com> <CAHk-=wg1uxUTmdEYgTcxWGQ-s6vb_V_Jux+Z+qwoAcVGkCTDYA@mail.gmail.com>
In-Reply-To: <CAHk-=wg1uxUTmdEYgTcxWGQ-s6vb_V_Jux+Z+qwoAcVGkCTDYA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Dec 2021 13:59:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5iFv1MOx6r8zyGYkYGfgfxqcPSrUDwfuOCdis+VR+BQ@mail.gmail.com>
Message-ID: <CAHk-=wh5iFv1MOx6r8zyGYkYGfgfxqcPSrUDwfuOCdis+VR+BQ@mail.gmail.com>
Subject: Re: [fget] 054aa8d439: will-it-scale.per_thread_ops -5.7% regression
To:     Jann Horn <jannh@google.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        fengwei.yin@intel.com
Content-Type: multipart/mixed; boundary="0000000000000e2ced05d2d1d6b5"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000e2ced05d2d1d6b5
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 10, 2021 at 1:25 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> We could make a special light-weight version of files_lookup_fd_raw(),
> I guess. We don't need the *whole* "look it up again".  We don't need
> to re-check the array bounds, and we don't need to do the nospec
> lookup - we would have triggered a NULL file pointer if that happened
> the first time around.
>
> So all we'd need to do is "check that fdt is the same, and check that
> fdt->fd[fd] is the same".

This is an ENTIRELY UNTESTED patch to do that.

It basically rewrites __fget_files() from scratch: it really wants to
do the fd array lookup by hand, in order to cache the intermediate fdt
pointer, and in order to cache the intermediate speculation-safe fd
array index etc.

It's not a very complicated function, and rewriting it actually cleans
up the loop to not need the ugly goto.

I made it use a helper wrapper function for the rcu locking, so that
the "meat" of the function can just use plain "return NULL" for the
error cases.

However, not only is it entirely untested, this rewrite also means
that gcc has now decided that the result is so simple and clear that
it will inline it into all the callers.

I guess that's a good sign - writing the code in a way that makes the
compiler say "now it's so trivial that it should be inlined" is
certainly not a bad thing. But it makes it hard to really compare the
asm.

I did try a version with "noinline" just to make it more comparable,
and hey, it all looked sane to me there too.

I added more comments about what is going on.

Again - this is UNTESTED. I've looked at the code, I've looked at the
diff, and I've looked at the code it generates. It all looks fine to
me. But I've looked at it so much that I suspect that I'd be entirely
blind to any completely obvious bug by now.

Comments?

Oliver, does this make any difference in the performance department?

                 Linus

--0000000000000e2ced05d2d1d6b5
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kx0xlrnr0>
X-Attachment-Id: f_kx0xlrnr0

IGZzL2ZpbGUuYyB8IDY5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKyks
IDE2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2ZpbGUuYyBiL2ZzL2ZpbGUuYwppbmRl
eCBhZDRhOGJmM2NmMTAuLjcwNjYyZmIxYWIzMiAxMDA2NDQKLS0tIGEvZnMvZmlsZS5jCisrKyBi
L2ZzL2ZpbGUuYwpAQCAtODQxLDI4ICs4NDEsNjUgQEAgdm9pZCBkb19jbG9zZV9vbl9leGVjKHN0
cnVjdCBmaWxlc19zdHJ1Y3QgKmZpbGVzKQogCXNwaW5fdW5sb2NrKCZmaWxlcy0+ZmlsZV9sb2Nr
KTsKIH0KIAorc3RhdGljIGlubGluZSBzdHJ1Y3QgZmlsZSAqX19mZ2V0X2ZpbGVzX3JjdShzdHJ1
Y3QgZmlsZXNfc3RydWN0ICpmaWxlcywKKwl1bnNpZ25lZCBpbnQgZmQsIGZtb2RlX3QgbWFzaywg
dW5zaWduZWQgaW50IHJlZnMpCit7CisJZm9yICg7OykgeworCQlzdHJ1Y3QgZmlsZSAqZmlsZTsK
KwkJc3RydWN0IGZkdGFibGUgKmZkdCA9IHJjdV9kZXJlZmVyZW5jZV9yYXcoZmlsZXMtPmZkdCk7
CisJCXN0cnVjdCBmaWxlIF9fcmN1ICoqZmRlbnRyeTsKKworCQlpZiAodW5saWtlbHkoZmQgPj0g
ZmR0LT5tYXhfZmRzKSkKKwkJCXJldHVybiBOVUxMOworCisJCWZkZW50cnkgPSBmZHQtPmZkICsg
YXJyYXlfaW5kZXhfbm9zcGVjKGZkLCBmZHQtPm1heF9mZHMpOworCQlmaWxlID0gcmN1X2RlcmVm
ZXJlbmNlX3JhdygqZmRlbnRyeSk7CisJCWlmICh1bmxpa2VseSghZmlsZSkpCisJCQlyZXR1cm4g
TlVMTDsKKworCQlpZiAodW5saWtlbHkoZmlsZS0+Zl9tb2RlICYgbWFzaykpCisJCQlyZXR1cm4g
TlVMTDsKKworCQkvKgorCQkgKiBPaywgd2UgaGF2ZSBhIGZpbGUgcG9pbnRlci4gSG93ZXZlciwg
YmVjYXVzZSB3ZSBkbworCQkgKiB0aGlzIGFsbCBsb2NrbGVzc2x5IHVuZGVyIFJDVSwgd2UgbWF5
IGJlIHJhY2luZyB3aXRoCisJCSAqIHRoYXQgZmlsZSBiZWluZyBjbG9zZWQuCisJCSAqCisJCSAq
IFN1Y2ggYSByYWNlIGNhbiB0YWtlIHR3byBmb3JtczoKKwkJICoKKwkJICogIChhKSB0aGUgZmls
ZSByZWYgYWxyZWFkeSB3ZW50IGRvd24gdG8gemVybywKKwkJICogICAgICBhbmQgZ2V0X2ZpbGVf
cmN1X21hbnkoKSBmYWlscy4gSnVzdCB0cnkKKwkJICogICAgICBhZ2FpbjoKKwkJICovCisJCWlm
ICh1bmxpa2VseSghZ2V0X2ZpbGVfcmN1X21hbnkoZmlsZSwgcmVmcykpKQorCQkJY29udGludWU7
CisKKwkJLyoKKwkJICogIChiKSB0aGUgZmlsZSB0YWJsZSBlbnRyeSBoYXMgY2hhbmdlZCB1bmRl
ciB1cy4KKwkJICoKKwkJICogSWYgc28sIHdlIG5lZWQgdG8gcHV0IG91ciByZWZzIGFuZCB0cnkg
YWdhaW4uCisJCSAqLworCQlpZiAodW5saWtlbHkocmN1X2RlcmVmZXJlbmNlX3JhdyhmaWxlcy0+
ZmR0KSAhPSBmZHQpIHx8CisJCSAgICB1bmxpa2VseShyY3VfZGVyZWZlcmVuY2VfcmF3KCpmZGVu
dHJ5KSAhPSBmaWxlKSkgeworCQkJZnB1dF9tYW55KGZpbGUsIHJlZnMpOworCQkJY29udGludWU7
CisJCX0KKworCQkvKgorCQkgKiBPaywgd2UgaGF2ZSBhIHJlZiB0byB0aGUgZmlsZSwgYW5kIGNo
ZWNrZWQgdGhhdCBpdAorCQkgKiBzdGlsbCBleGlzdHMuCisJCSAqLworCQlyZXR1cm4gZmlsZTsK
Kwl9Cit9CisKIHN0YXRpYyBzdHJ1Y3QgZmlsZSAqX19mZ2V0X2ZpbGVzKHN0cnVjdCBmaWxlc19z
dHJ1Y3QgKmZpbGVzLCB1bnNpZ25lZCBpbnQgZmQsCiAJCQkJIGZtb2RlX3QgbWFzaywgdW5zaWdu
ZWQgaW50IHJlZnMpCiB7CiAJc3RydWN0IGZpbGUgKmZpbGU7CiAKIAlyY3VfcmVhZF9sb2NrKCk7
Ci1sb29wOgotCWZpbGUgPSBmaWxlc19sb29rdXBfZmRfcmN1KGZpbGVzLCBmZCk7Ci0JaWYgKGZp
bGUpIHsKLQkJLyogRmlsZSBvYmplY3QgcmVmIGNvdWxkbid0IGJlIHRha2VuLgotCQkgKiBkdXAy
KCkgYXRvbWljaXR5IGd1YXJhbnRlZSBpcyB0aGUgcmVhc29uCi0JCSAqIHdlIGxvb3AgdG8gY2F0
Y2ggdGhlIG5ldyBmaWxlIChvciBOVUxMIHBvaW50ZXIpCi0JCSAqLwotCQlpZiAoZmlsZS0+Zl9t
b2RlICYgbWFzaykKLQkJCWZpbGUgPSBOVUxMOwotCQllbHNlIGlmICghZ2V0X2ZpbGVfcmN1X21h
bnkoZmlsZSwgcmVmcykpCi0JCQlnb3RvIGxvb3A7Ci0JCWVsc2UgaWYgKGZpbGVzX2xvb2t1cF9m
ZF9yYXcoZmlsZXMsIGZkKSAhPSBmaWxlKSB7Ci0JCQlmcHV0X21hbnkoZmlsZSwgcmVmcyk7Ci0J
CQlnb3RvIGxvb3A7Ci0JCX0KLQl9CisJZmlsZSA9IF9fZmdldF9maWxlc19yY3UoZmlsZXMsIGZk
LCBtYXNrLCByZWZzKTsKIAlyY3VfcmVhZF91bmxvY2soKTsKIAogCXJldHVybiBmaWxlOwo=
--0000000000000e2ced05d2d1d6b5--
