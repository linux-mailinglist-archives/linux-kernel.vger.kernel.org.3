Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788DC59267E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiHNVOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiHNVO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:14:28 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CA362CC
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:14:27 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w3so7494668edc.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=Q3rxfxfhyGA2AUg4ZGZuVw0wPS1+PYg+Nvu3rOct/ZI=;
        b=ApWQ4x42OQeA+KH06JfSUCYmPkUBMH87sd6c/gBlW/w5OJ84FReYQXibCA3KO4dWHN
         QReeRlrLBcI8uzwW/cArNEPq7OYpPDalsGzvqlOEb8XQdt8+u7pLG1b+/2rFlL9cBgiR
         4CmeoFXzhECb6bn1K00PNqRN9M15hjeKshquk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=Q3rxfxfhyGA2AUg4ZGZuVw0wPS1+PYg+Nvu3rOct/ZI=;
        b=dDaZeVjuv/HGvuofxCOnH/dZAt8gB71KafCHvL3S4hV8sFgbKI34RcyNyWWaJTTzRu
         nbiNyps+4WjJbfwBRiSkFmKA2TiVWoSFB/TCP6byIKJ63WiKkRHuWKQnPbSr/jy4u5/v
         2aHlGl/cVj8qZJryopu0Y+5ahaE9Olj9Li12m3MV7LzMdpTE4i9vFUj2t1UV0PegI/3t
         clPOi41HplpSSm3MvMxXnYcdCeYYvPOmRbgRRLvDDiQOLKf4IoLIHYJHxNyLWGnTeGza
         dVZRspA+CMjeQP3WstN4bO1ufnqEfNPu9wcPd95QpIYhrLsiSjTUchRiWrSrJwhWQACd
         kTNg==
X-Gm-Message-State: ACgBeo3XDM67nJlIItcgJMiCDgBHobt5qwAiov8k26243yKnKOpm56S2
        dClPCE/6IOgSKzm1+5Q/hbHmIXTFJWlN1EH7
X-Google-Smtp-Source: AA6agR6uDtVgQEFEgIF6ZdAJTYGMYHk25tzIu1NZNBPQB5TqgUlL2t5sP3yQfyvOpvlpV1yjgGzmiw==
X-Received: by 2002:a05:6402:20b:b0:440:cb9f:c469 with SMTP id t11-20020a056402020b00b00440cb9fc469mr12232310edv.420.1660511666124;
        Sun, 14 Aug 2022 14:14:26 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id n24-20020a17090625d800b0072ee7b51d9asm3338715ejb.39.2022.08.14.14.14.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 14:14:25 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id v3so7108885wrp.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:14:25 -0700 (PDT)
X-Received: by 2002:a05:6000:178d:b0:222:c7ad:2d9a with SMTP id
 e13-20020a056000178d00b00222c7ad2d9amr7067605wrg.274.1660511665009; Sun, 14
 Aug 2022 14:14:25 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Aug 2022 14:14:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1xHi-WeytuAK1-iSsR0wi=6e4-WgFq6ZPt8Z1mvqoNA@mail.gmail.com>
Message-ID: <CAHk-=wh1xHi-WeytuAK1-iSsR0wi=6e4-WgFq6ZPt8Z1mvqoNA@mail.gmail.com>
Subject: Simplify load_unaligned_zeropad() (was Re: [GIT PULL] Ceph updates
 for 5.20-rc1)
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: multipart/mixed; boundary="000000000000f109c905e639ff71"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f109c905e639ff71
Content-Type: text/plain; charset="UTF-8"

On Sun, Aug 14, 2022 at 1:29 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I dug into it some more, and it is really "load_unaligned_zeropad()"
> that makes clang really uncomfortable.
>
> The problem ends up being that clang sees that it's inside that inner
> loop, and tries very hard to optimize the shift-and-mask that happens
> if the exception happens.
>
> The fact that the exception *never* happens unless DEBUG_PAGEALLOC is
> enabled - and very very seldom even then - is not something we can
> really explain to clang.

Hmm.

The solution to that is actually to move the 'zeropad' part into the
exception handler.

That makes both gcc and clang generate quite nice code for this all.
But perhaps equally importantly, it actually simplifies the code
noticeably:

 arch/x86/include/asm/extable_fixup_types.h |  2 ++
 arch/x86/include/asm/word-at-a-time.h      | 50 +++---------------------------
 arch/x86/mm/extable.c                      | 30 ++++++++++++++++++
 3 files changed, 37 insertions(+), 45 deletions(-)

and that's with 11 of those 37 new lines being a new block comment.

It's mainly because now there's no need to worry about
CONFIG_CC_HAS_ASM_GOTO_OUTPUT in load_unaligned_zeropad(), because the
asm becomes a simple "address in, data out" thing.

And to make the fixup code simple and straightforward, I just made
"load_unaligned_zeropad()" use fixed registers for address and output,
which doesn't bother the compilers at all, they'll happily adjust
their register allocation. The code generation ends up much better
than with the goto and the subtle address games that never trigger
anyway.

PeterZ - you've touched both the load_unaligned_zeropad() and the
exception code last, so let's run this past you, but this really does
seem to not only fix the code generation issue in fs/dcache.s, it just
looks simpler too. Comments?

             Linus

--000000000000f109c905e639ff71
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l6ttpmer0>
X-Attachment-Id: f_l6ttpmer0

IGFyY2gveDg2L2luY2x1ZGUvYXNtL2V4dGFibGVfZml4dXBfdHlwZXMuaCB8ICAyICsrCiBhcmNo
L3g4Ni9pbmNsdWRlL2FzbS93b3JkLWF0LWEtdGltZS5oICAgICAgfCA1MCArKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KIGFyY2gveDg2L21tL2V4dGFibGUuYyAgICAgICAgICAgICAgICAg
ICAgICB8IDMwICsrKysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAzNyBpbnNlcnRp
b25zKCspLCA0NSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9leHRhYmxlX2ZpeHVwX3R5cGVzLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9leHRhYmxlX2Zp
eHVwX3R5cGVzLmgKaW5kZXggNTAzNjIyNjI3NDAwLi5iNTNmMTkxOTcxMGIgMTAwNjQ0Ci0tLSBh
L2FyY2gveDg2L2luY2x1ZGUvYXNtL2V4dGFibGVfZml4dXBfdHlwZXMuaAorKysgYi9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS9leHRhYmxlX2ZpeHVwX3R5cGVzLmgKQEAgLTY0LDQgKzY0LDYgQEAKICNk
ZWZpbmUJRVhfVFlQRV9VQ09QWV9MRU40CQkoRVhfVFlQRV9VQ09QWV9MRU4gfCBFWF9EQVRBX0lN
TSg0KSkKICNkZWZpbmUJRVhfVFlQRV9VQ09QWV9MRU44CQkoRVhfVFlQRV9VQ09QWV9MRU4gfCBF
WF9EQVRBX0lNTSg4KSkKIAorI2RlZmluZSBFWF9UWVBFX1pFUk9QQUQJCQkyMCAvKiBsb2FkIGF4
IGZyb20gZHggemVyby1wYWRkZWQgKi8KKwogI2VuZGlmCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS93b3JkLWF0LWEtdGltZS5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vd29yZC1h
dC1hLXRpbWUuaAppbmRleCA4MzM4YjA0MzJiNTAuLjQ4OTNmMWIzMGRkNiAxMDA2NDQKLS0tIGEv
YXJjaC94ODYvaW5jbHVkZS9hc20vd29yZC1hdC1hLXRpbWUuaAorKysgYi9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS93b3JkLWF0LWEtdGltZS5oCkBAIC03Nyw1OCArNzcsMTggQEAgc3RhdGljIGlubGlu
ZSB1bnNpZ25lZCBsb25nIGZpbmRfemVybyh1bnNpZ25lZCBsb25nIG1hc2spCiAgKiBhbmQgdGhl
IG5leHQgcGFnZSBub3QgYmVpbmcgbWFwcGVkLCB0YWtlIHRoZSBleGNlcHRpb24gYW5kCiAgKiBy
ZXR1cm4gemVyb2VzIGluIHRoZSBub24tZXhpc3RpbmcgcGFydC4KICAqLwotI2lmZGVmIENPTkZJ
R19DQ19IQVNfQVNNX0dPVE9fT1VUUFVUCi0KIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBs
b2FkX3VuYWxpZ25lZF96ZXJvcGFkKGNvbnN0IHZvaWQgKmFkZHIpCiB7Ci0JdW5zaWduZWQgbG9u
ZyBvZmZzZXQsIGRhdGE7CiAJdW5zaWduZWQgbG9uZyByZXQ7CiAKLQlhc21fdm9sYXRpbGVfZ290
bygKLQkJIjE6CW1vdiAlW21lbV0sICVbcmV0XVxuIgotCi0JCV9BU01fRVhUQUJMRSgxYiwgJWxb
ZG9fZXhjZXB0aW9uXSkKLQotCQk6IFtyZXRdICI9ciIgKHJldCkKLQkJOiBbbWVtXSAibSIgKCoo
dW5zaWduZWQgbG9uZyAqKWFkZHIpCi0JCTogOiBkb19leGNlcHRpb24pOwotCi0JcmV0dXJuIHJl
dDsKLQotZG9fZXhjZXB0aW9uOgotCW9mZnNldCA9ICh1bnNpZ25lZCBsb25nKWFkZHIgJiAoc2l6
ZW9mKGxvbmcpIC0gMSk7Ci0JYWRkciA9ICh2b2lkICopKCh1bnNpZ25lZCBsb25nKWFkZHIgJiB+
KHNpemVvZihsb25nKSAtIDEpKTsKLQlkYXRhID0gKih1bnNpZ25lZCBsb25nICopYWRkcjsKLQly
ZXQgPSBkYXRhID4+IG9mZnNldCAqIDg7Ci0KLQlyZXR1cm4gcmV0OwotfQotCi0jZWxzZSAvKiAh
Q09ORklHX0NDX0hBU19BU01fR09UT19PVVRQVVQgKi8KLQotc3RhdGljIGlubGluZSB1bnNpZ25l
ZCBsb25nIGxvYWRfdW5hbGlnbmVkX3plcm9wYWQoY29uc3Qgdm9pZCAqYWRkcikKLXsKLQl1bnNp
Z25lZCBsb25nIG9mZnNldCwgZGF0YTsKLQl1bnNpZ25lZCBsb25nIHJldCwgZXJyID0gMDsKLQot
CWFzbSgJIjE6CW1vdiAlW21lbV0sICVbcmV0XVxuIgorCWFzbSB2b2xhdGlsZSgKKwkJIjE6CW1v
diAoJVthZGRyXSksICVbcmV0XVxuIgogCQkiMjpcbiIKLQotCQlfQVNNX0VYVEFCTEVfRkFVTFQo
MWIsIDJiKQotCi0JCTogW3JldF0gIj0mciIgKHJldCksICIrYSIgKGVycikKLQkJOiBbbWVtXSAi
bSIgKCoodW5zaWduZWQgbG9uZyAqKWFkZHIpKTsKLQotCWlmICh1bmxpa2VseShlcnIpKSB7Ci0J
CW9mZnNldCA9ICh1bnNpZ25lZCBsb25nKWFkZHIgJiAoc2l6ZW9mKGxvbmcpIC0gMSk7Ci0JCWFk
ZHIgPSAodm9pZCAqKSgodW5zaWduZWQgbG9uZylhZGRyICYgfihzaXplb2YobG9uZykgLSAxKSk7
Ci0JCWRhdGEgPSAqKHVuc2lnbmVkIGxvbmcgKilhZGRyOwotCQlyZXQgPSBkYXRhID4+IG9mZnNl
dCAqIDg7Ci0JfQorCQlfQVNNX0VYVEFCTEVfVFlQRSgxYiwgMmIsIEVYX1RZUEVfWkVST1BBRCkK
KwkJOiBbcmV0XSAiPWEiIChyZXQpCisJCTogW2FkZHJdICJkIiAoYWRkcikpOwogCiAJcmV0dXJu
IHJldDsKIH0KIAotI2VuZGlmIC8qIENPTkZJR19DQ19IQVNfQVNNX0dPVE9fT1VUUFVUICovCi0K
ICNlbmRpZiAvKiBfQVNNX1dPUkRfQVRfQV9USU1FX0ggKi8KZGlmZiAtLWdpdCBhL2FyY2gveDg2
L21tL2V4dGFibGUuYyBiL2FyY2gveDg2L21tL2V4dGFibGUuYwppbmRleCAzMzEzMTBjMjkzNDku
LjU4Yzc5MDc3YTQ5NiAxMDA2NDQKLS0tIGEvYXJjaC94ODYvbW0vZXh0YWJsZS5jCisrKyBiL2Fy
Y2gveDg2L21tL2V4dGFibGUuYwpAQCAtNDEsNiArNDEsMzQgQEAgc3RhdGljIGJvb2wgZXhfaGFu
ZGxlcl9kZWZhdWx0KGNvbnN0IHN0cnVjdCBleGNlcHRpb25fdGFibGVfZW50cnkgKmUsCiAJcmV0
dXJuIHRydWU7CiB9CiAKKy8qCisgKiBUaGlzIGlzIHRoZSAqdmVyeSogcmFyZSBjYXNlIHdoZXJl
IHdlIGRvIGEgImxvYWRfdW5hbGlnbmVkX3plcm9wYWQoKSIKKyAqIGFuZCBpdCdzIGEgcGFnZSBj
cm9zc2VyIGludG8gYSBub24tZXhpc3RlbnQgcGFnZS4KKyAqCisgKiBUaGlzIGhhcHBlbnMgd2hl
biB3ZSBvcHRpbWlzdGljYWxseSBsb2FkIGEgcGF0aG5hbWUgYSB3b3JkLWF0LWEtdGltZQorICog
YW5kIHRoZSBuYW1lIGlzIGxlc3MgdGhhbiB0aGUgZnVsbCB3b3JkIGFuZCB0aGUgIG5leHQgcGFn
ZSBpcyBub3QKKyAqIG1hcHBlZC4gVHlwaWNhbGx5IHRoYXQgb25seSBoYXBwZW5zIGZvciBDT05G
SUdfREVCVUdfUEFHRUFMTE9DLgorICoKKyAqIE5PVEUhIFRoZSBsb2FkIGlzIGFsd2F5cyBvZiB0
aGUgZm9ybSAibW92ICglZWR4KSwlZWF4IiB0byBtYWtlIHRoZQorICogZml4dXAgc2ltcGxlLgor
ICovCitzdGF0aWMgYm9vbCBleF9oYW5kbGVyX3plcm9wYWQoY29uc3Qgc3RydWN0IGV4Y2VwdGlv
bl90YWJsZV9lbnRyeSAqZSwKKwkJCSAgICAgICBzdHJ1Y3QgcHRfcmVncyAqcmVncywKKwkJCSAg
ICAgICB1bnNpZ25lZCBsb25nIGZhdWx0X2FkZHIpCit7CisJY29uc3QgdW5zaWduZWQgbG9uZyBt
YXNrID0gc2l6ZW9mKGxvbmcpIC0gMTsKKwl1bnNpZ25lZCBsb25nIG9mZnNldCwgYWRkcjsKKwor
CW9mZnNldCA9IHJlZ3MtPmR4ICYgbWFzazsKKwlhZGRyID0gcmVncy0+ZHggJiB+bWFzazsKKwlp
ZiAoZmF1bHRfYWRkciAhPSBhZGRyICsgc2l6ZW9mKGxvbmcpKQorCQlyZXR1cm4gZmFsc2U7CisK
KwlyZWdzLT5heCA9ICoodW5zaWduZWQgbG9uZyAqKWFkZHIgPj4gKG9mZnNldCAqIDgpOworCXJl
Z3MtPmlwID0gZXhfZml4dXBfYWRkcihlKTsKKwlyZXR1cm4gdHJ1ZTsKK30KKwogc3RhdGljIGJv
b2wgZXhfaGFuZGxlcl9mYXVsdChjb25zdCBzdHJ1Y3QgZXhjZXB0aW9uX3RhYmxlX2VudHJ5ICpm
aXh1cCwKIAkJCSAgICAgc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIGludCB0cmFwbnIpCiB7CkBAIC0y
MTcsNiArMjQ1LDggQEAgaW50IGZpeHVwX2V4Y2VwdGlvbihzdHJ1Y3QgcHRfcmVncyAqcmVncywg
aW50IHRyYXBuciwgdW5zaWduZWQgbG9uZyBlcnJvcl9jb2RlLAogCQlyZXR1cm4gZXhfaGFuZGxl
cl9zZ3goZSwgcmVncywgdHJhcG5yKTsKIAljYXNlIEVYX1RZUEVfVUNPUFlfTEVOOgogCQlyZXR1
cm4gZXhfaGFuZGxlcl91Y29weV9sZW4oZSwgcmVncywgdHJhcG5yLCByZWcsIGltbSk7CisJY2Fz
ZSBFWF9UWVBFX1pFUk9QQUQ6CisJCXJldHVybiBleF9oYW5kbGVyX3plcm9wYWQoZSwgcmVncywg
ZmF1bHRfYWRkcik7CiAJfQogCUJVRygpOwogfQo=
--000000000000f109c905e639ff71--
