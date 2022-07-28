Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9EA584605
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbiG1Str (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiG1Stp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:49:45 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEF174E1C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:49:44 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e15so3283475edj.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=o4JsS03Vx0jtL7YYXAFCaM1jM5Qa3FkoCPUmMAdZ7vQ=;
        b=ZkwpQzU6cwO3kq6f7VwhOh/R0c7Y3AhMC5D1/J3igjtAioM7sdGi3t2KhlYOQU3rXb
         aauC+z1tUw8ULAlNlQ+VREvuT2gpnrwJBGC5la0a/zW15sErEXYTDK2o8jvkvMtF9jA6
         wnaHLyNlXc2nN+tgxgQvYYyaylDg6Mi/mY7YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=o4JsS03Vx0jtL7YYXAFCaM1jM5Qa3FkoCPUmMAdZ7vQ=;
        b=bv6yliKU+LnRW0387JtvQp2mlSCSaB2/KxPAiqwrTS2aGQxjvPViM7JwCfG/kbZIMF
         f6og7FlaI5SlPaJMTUzglh3FQEmN4rxgJ7P9tdqdm5RT+wxQA7J0fZ/it47eHtpPZ1ws
         pGKQG7QdHnc/iBQ3ywnOWfpFEa2ouDlESNlQjo6E9UP1HHmbrcOBaYQmTV+AaswS8sgh
         xBsUVpDqorbXIRLSN6YL1WNR0flkSGr6T0qF66EGYBEc7PFbmBiRUcJ0ePQ1447WI43a
         wvQC87S34OTaf9aauel9oxXz9+Jqw2ZRy4b+F1WNfH3yqhoXJHoa6/TDLaoveAda4k4u
         tWjg==
X-Gm-Message-State: AJIora9olrGL4CgERv+g0Z4alCHibXWoP2fp2IOY2LzjmisT7QjBMWbB
        vFwYNLuV979EJombBUE3EPh7S/fcEqxKkfqc
X-Google-Smtp-Source: AGRyM1s5ELcuDvKr5y9PBOiImgv5dBHVbq/WAhvNW2Apm7vrqvpXUYi4SpRbCrZHijGu5LsC7oqyrA==
X-Received: by 2002:a05:6402:11d3:b0:43c:436b:829 with SMTP id j19-20020a05640211d300b0043c436b0829mr296214edw.324.1659034182540;
        Thu, 28 Jul 2022 11:49:42 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id kw7-20020a170907770700b00722e31fcf42sm683573ejc.184.2022.07.28.11.49.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 11:49:41 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id i8so3405780wro.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:49:41 -0700 (PDT)
X-Received: by 2002:adf:edcb:0:b0:21e:d043:d271 with SMTP id
 v11-20020adfedcb000000b0021ed043d271mr195839wro.274.1659034180672; Thu, 28
 Jul 2022 11:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220728161208.865420-1-yury.norov@gmail.com>
In-Reply-To: <20220728161208.865420-1-yury.norov@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Jul 2022 11:49:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFJboHXZEXtMhDcHbEYXujTiDxkGbpONC=DJA7dJG6nw@mail.gmail.com>
Message-ID: <CAHk-=wiFJboHXZEXtMhDcHbEYXujTiDxkGbpONC=DJA7dJG6nw@mail.gmail.com>
Subject: Re: [PATCH 0/5] lib/find: optimize find_bit() functions
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000028e7d05e4e1ff41"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000028e7d05e4e1ff41
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 28, 2022 at 9:12 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> In the recent discussion [1], it was noticed that find_next_bit()
> functions may be improved by adding wrappers around common
> __find_next_bit().

So looking at the end result, this generates fairly good code.

I say "fairly good" because _find_next_and_bit() ends up being disgusting.

The reason? That

        if (addr2)
                tmp &= addr2[start / BITS_PER_LONG];

generates horrific code when 'addr2' isn't seen to be always NULL.

So this doesn't affect the regular _find_next_bit case, because the
inliner sees that addr2 is always NULL and doesn't generate extra code
for it.

But the code that actually *does* have two incoming bitmasks will now
pointlessly test that second bitmask pointer all the time.

Now, that particular function probably doesn't matter, but this code
seems to be unnecessarily written to try to be overly generic, and
that

 (a) makes it hard to read the source code because the source code
doesn't do the obvious thing

 (b) clearly generates suboptimal code too

so I'm really not a huge fan of this "try to share code". Not when the
resulting shared code is harder to read, and impossible for the
compiler to do a great job at.

And the code sharing really doesn't help all that much.

If you really want to generate good code, use macros, and share the
logic that way. Not hugely readable either, but I think it's actually
not bad.

I think something like this would work:

    #define BIT_FIND_SETUP(addr, size, start)                   \
        unsigned long val, idx;                                 \
        if (unlikely(start >= size))                            \
                return size;                                    \
        idx = start / BITS_PER_LONG;

    #define BIT_FIND_FIRST_WORD(addr, size, start, EXPRESSION)  \
        if (!IS_ALIGNED(start, BITS_PER_LONG)) {                \
                unsigned long mask;                             \
                mask = BITMAP_FIRST_WORD_MASK(start);           \
                if ((val = mask & (EXPRESSION)) != 0)           \
                        goto found;                             \
                idx++;                                          \
        }

    #define BIT_WORD_LOOP(ptr, size, idx, val, EXPRESSION)              \
        do {                                                    \
                if ((val = (EXPRESSION)) != 0)                  \
                         goto found;                            \
                idx++;                                          \
        } while ((idx)*BITS_PER_LONG < (size));

    #define BIT_FIND_BODY(addr, size, start, EXPRESSION)                \
        BIT_FIND_SETUP(addr, size, start)                       \
        BIT_FIND_FIRST_WORD(addr, size, start, EXPRESSION)      \
        BIT_WORD_LOOP(addr, size, idx, val, EXPRESSION) \
        return size;                                            \
    found:      BIT_WORD_SWAB(val);                                     \
        return min((idx)*BITS_PER_LONG + __ffs(val), size)

    #define BIT_WORD_SWAB(x) /* Nothing */

and then for the BE versions you just use the same macros, but you
make BIT_WORD_SWAB() do the swab.

I'm attaching an UNTESTED version of lib/find_bit.c that works the
above way (note: it is based on your header file changes!)

It builds for me and seems to generate reasonable code, although I
notice that clang messes up the "__ffs()" inline asm and forces the
source into memory.

(Gcc doesn't do that, but gcc follows the code exactly and generates
"shl $6" instructions, while clang seems to figure out that it can
just add 64 instead)

                        Linus

--000000000000028e7d05e4e1ff41
Content-Type: text/x-csrc; charset="US-ASCII"; name="find_bit.c"
Content-Disposition: attachment; filename="find_bit.c"
Content-Transfer-Encoding: base64
Content-ID: <f_l65e3m350>
X-Attachment-Id: f_l65e3m350

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKLyogYml0IHNlYXJj
aCBpbXBsZW1lbnRhdGlvbgogKgogKiBDb3B5cmlnaHQgKEMpIDIwMDQgUmVkIEhhdCwgSW5jLiBB
bGwgUmlnaHRzIFJlc2VydmVkLgogKiBXcml0dGVuIGJ5IERhdmlkIEhvd2VsbHMgKGRob3dlbGxz
QHJlZGhhdC5jb20pCiAqCiAqIENvcHlyaWdodCAoQykgMjAwOCBJQk0gQ29ycG9yYXRpb24KICog
J2ZpbmRfbGFzdF9iaXQnIGlzIHdyaXR0ZW4gYnkgUnVzdHkgUnVzc2VsbCA8cnVzdHlAcnVzdGNv
cnAuY29tLmF1PgogKiAoSW5zcGlyZWQgYnkgRGF2aWQgSG93ZWxsJ3MgZmluZF9uZXh0X2JpdCBp
bXBsZW1lbnRhdGlvbikKICoKICogUmV3cml0dGVuIGJ5IFl1cnkgTm9yb3YgPHl1cnkubm9yb3ZA
Z21haWwuY29tPiB0byBkZWNyZWFzZQogKiBzaXplIGFuZCBpbXByb3ZlIHBlcmZvcm1hbmNlLCAy
MDE1LgogKi8KCiNpbmNsdWRlIDxsaW51eC9iaXRvcHMuaD4KI2luY2x1ZGUgPGxpbnV4L2JpdG1h
cC5oPgojaW5jbHVkZSA8bGludXgvZXhwb3J0Lmg+CiNpbmNsdWRlIDxsaW51eC9tYXRoLmg+CiNp
bmNsdWRlIDxsaW51eC9taW5tYXguaD4KI2luY2x1ZGUgPGxpbnV4L3N3YWIuaD4KCiNkZWZpbmUg
QklUX0ZJTkRfU0VUVVAoYWRkciwgc2l6ZSwgc3RhcnQpCQkJXAoJdW5zaWduZWQgbG9uZyB2YWws
IGlkeDsJCQkJCVwKCWlmICh1bmxpa2VseShzdGFydCA+PSBzaXplKSkJCQkJXAoJCXJldHVybiBz
aXplOwkJCQkJXAoJaWR4ID0gc3RhcnQgLyBCSVRTX1BFUl9MT05HOwoKI2RlZmluZSBCSVRfRklO
RF9GSVJTVF9XT1JEKGFkZHIsIHNpemUsIHN0YXJ0LCBFWFBSRVNTSU9OKQlcCglpZiAoIUlTX0FM
SUdORUQoc3RhcnQsIEJJVFNfUEVSX0xPTkcpKSB7CQlcCgkJdW5zaWduZWQgbG9uZyBtYXNrOwkJ
CQlcCgkJbWFzayA9IEJJVE1BUF9GSVJTVF9XT1JEX01BU0soc3RhcnQpOwkJXAoJCWlmICgodmFs
ID0gbWFzayAmIChFWFBSRVNTSU9OKSkgIT0gMCkJCVwKCQkJZ290byBmb3VuZDsJCQkJXAoJCWlk
eCsrOwkJCQkJCVwKCX0KCiNkZWZpbmUgQklUX1dPUkRfTE9PUChwdHIsIHNpemUsIGlkeCwgdmFs
LCBFWFBSRVNTSU9OKQkJXAoJZG8gewkJCQkJCQlcCgkJaWYgKCh2YWwgPSAoRVhQUkVTU0lPTikp
ICE9IDApCQkJXAoJCQkgZ290byBmb3VuZDsJCQkJXAoJCWlkeCsrOwkJCQkJCVwKCX0gd2hpbGUg
KChpZHgpKkJJVFNfUEVSX0xPTkcgPCAoc2l6ZSkpOwoKI2RlZmluZSBCSVRfRklORF9CT0RZKGFk
ZHIsIHNpemUsIHN0YXJ0LCBFWFBSRVNTSU9OKQkJXAoJQklUX0ZJTkRfU0VUVVAoYWRkciwgc2l6
ZSwgc3RhcnQpCQkJXAoJQklUX0ZJTkRfRklSU1RfV09SRChhZGRyLCBzaXplLCBzdGFydCwgRVhQ
UkVTU0lPTikJXAoJQklUX1dPUkRfTE9PUChhZGRyLCBzaXplLCBpZHgsIHZhbCwgRVhQUkVTU0lP
TikJXAoJcmV0dXJuIHNpemU7CQkJCQkJXApmb3VuZDoJQklUX1dPUkRfU1dBQih2YWwpOwkJCQkJ
XAoJcmV0dXJuIG1pbigoaWR4KSpCSVRTX1BFUl9MT05HICsgX19mZnModmFsKSwgc2l6ZSkKCiNk
ZWZpbmUgQklUX1dPUkRfU1dBQih4KSAvKiBOb3RoaW5nICovCgp1bnNpZ25lZCBsb25nIF9maW5k
X2ZpcnN0X2JpdChjb25zdCB1bnNpZ25lZCBsb25nICphZGRyLCB1bnNpZ25lZCBsb25nIHNpemUp
CnsgQklUX0ZJTkRfQk9EWShhZGRyLCBzaXplLCAwLCBhZGRyW2lkeF0pOyB9Cgp1bnNpZ25lZCBs
b25nIF9maW5kX2ZpcnN0X3plcm9fYml0KGNvbnN0IHVuc2lnbmVkIGxvbmcgKmFkZHIsIHVuc2ln
bmVkIGxvbmcgc2l6ZSkKeyBCSVRfRklORF9CT0RZKGFkZHIsIHNpemUsIDAsIH5hZGRyW2lkeF0p
OyB9Cgp1bnNpZ25lZCBsb25nIF9maW5kX25leHRfYml0KGNvbnN0IHVuc2lnbmVkIGxvbmcgKmFk
ZHIsIHVuc2lnbmVkIGxvbmcgc2l6ZSwgdW5zaWduZWQgbG9uZyBzdGFydCkKeyBCSVRfRklORF9C
T0RZKGFkZHIsIHNpemUsIHN0YXJ0LCBhZGRyW2lkeF0pOyB9Cgp1bnNpZ25lZCBsb25nIF9maW5k
X25leHRfemVyb19iaXQoY29uc3QgdW5zaWduZWQgbG9uZyAqYWRkciwgdW5zaWduZWQgbG9uZyBz
aXplLCB1bnNpZ25lZCBsb25nIHN0YXJ0KQp7IEJJVF9GSU5EX0JPRFkoYWRkciwgc2l6ZSwgc3Rh
cnQsIH5hZGRyW2lkeF0pOyB9Cgp1bnNpZ25lZCBsb25nIF9maW5kX2ZpcnN0X2FuZF9iaXQoY29u
c3QgdW5zaWduZWQgbG9uZyAqYWRkcjEsIGNvbnN0IHVuc2lnbmVkIGxvbmcgKmFkZHIyLCB1bnNp
Z25lZCBsb25nIHNpemUpCnsgQklUX0ZJTkRfQk9EWShhZGRyLCBzaXplLCAwLCBhZGRyMVtpZHhd
ICYgYWRkcjJbaWR4XSk7IH0KCnVuc2lnbmVkIGxvbmcgX2ZpbmRfbmV4dF9hbmRfYml0KGNvbnN0
IHVuc2lnbmVkIGxvbmcgKmFkZHIxLCBjb25zdCB1bnNpZ25lZCBsb25nICphZGRyMiwgdW5zaWdu
ZWQgbG9uZyBzaXplLCB1bnNpZ25lZCBsb25nIHN0YXJ0KQp7IEJJVF9GSU5EX0JPRFkoYWRkciwg
c2l6ZSwgc3RhcnQsIGFkZHIxW2lkeF0gJiBhZGRyMltpZHhdKTsgfQoKI2lmZGVmIF9fQklHX0VO
RElBTgoKI3VuZGVmIEJJVF9XT1JEX1NXQUIKI2RlZmluZSBCSVRfV09SRF9TV0FCKHZhbCkgdmFs
ID0gc3dhYih2YWwpCgouLiBGSVhNRTogc2FtZSBhcyBhYm92ZSwgbm93IHdpdGggX2ZpbmRfZmly
c3RfYml0X2xlKCkgZXRjIC4uCgojZW5kaWYKCiNpZm5kZWYgZmluZF9sYXN0X2JpdAp1bnNpZ25l
ZCBsb25nIF9maW5kX2xhc3RfYml0KGNvbnN0IHVuc2lnbmVkIGxvbmcgKmFkZHIsIHVuc2lnbmVk
IGxvbmcgc2l6ZSkKewoJaWYgKHNpemUpIHsKCQl1bnNpZ25lZCBsb25nIHZhbCA9IEJJVE1BUF9M
QVNUX1dPUkRfTUFTSyhzaXplKTsKCQl1bnNpZ25lZCBsb25nIGlkeCA9IChzaXplLTEpIC8gQklU
U19QRVJfTE9ORzsKCgkJZG8gewoJCQl2YWwgJj0gYWRkcltpZHhdOwoJCQlpZiAodmFsKQoJCQkJ
cmV0dXJuIGlkeCAqIEJJVFNfUEVSX0xPTkcgKyBfX2Zscyh2YWwpOwoKCQkJdmFsID0gfjB1bDsK
CQl9IHdoaWxlIChpZHgtLSk7Cgl9CglyZXR1cm4gc2l6ZTsKfQpFWFBPUlRfU1lNQk9MKF9maW5k
X2xhc3RfYml0KTsKI2VuZGlmCgp1bnNpZ25lZCBsb25nIGZpbmRfbmV4dF9jbHVtcDgodW5zaWdu
ZWQgbG9uZyAqY2x1bXAsIGNvbnN0IHVuc2lnbmVkIGxvbmcgKmFkZHIsCgkJCSAgICAgICB1bnNp
Z25lZCBsb25nIHNpemUsIHVuc2lnbmVkIGxvbmcgb2Zmc2V0KQp7CglvZmZzZXQgPSBmaW5kX25l
eHRfYml0KGFkZHIsIHNpemUsIG9mZnNldCk7CglpZiAob2Zmc2V0ID09IHNpemUpCgkJcmV0dXJu
IHNpemU7CgoJb2Zmc2V0ID0gcm91bmRfZG93bihvZmZzZXQsIDgpOwoJKmNsdW1wID0gYml0bWFw
X2dldF92YWx1ZTgoYWRkciwgb2Zmc2V0KTsKCglyZXR1cm4gb2Zmc2V0Owp9CkVYUE9SVF9TWU1C
T0woZmluZF9uZXh0X2NsdW1wOCk7Cg==
--000000000000028e7d05e4e1ff41--
