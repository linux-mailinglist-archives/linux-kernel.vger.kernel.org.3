Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F511594EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 04:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbiHPCd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 22:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiHPCdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 22:33:37 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E7D7DF7D
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:50:04 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id qn6so15870299ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=I5jxQVs7W6/LmzImzxb0x52U4QygZ1NAuhue2UMu3tY=;
        b=JFd0OtvLnfxGcRFVTNKpxHzu5uMl/QnIJc8Pym7w/M4kVpGynPr7Wk2rv4BN3QKZrL
         xvxYbrWkaoQXYzKsZEVbfY/RHWtJwy63KQzIhtVJkZnDeW/NIRzzKr7onG4rJ7L08DLv
         RtY3bFlGLHbG7PHAR77HZuh+uVH5IlN9qONPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=I5jxQVs7W6/LmzImzxb0x52U4QygZ1NAuhue2UMu3tY=;
        b=GmncwKogBQSHAz3JXflT9Yi//BWUVO/aNJJrJOC4pKlCYXUY0uHujXKhH6kMZ3uNJS
         BATppq3GM5TKzOs0aoONHjTfkcnzjsH8ss4K1CHeTICVNq8uNc6giJ/uTLWXYJnGUM1j
         WxPWiI16LkMaJscBW14rPtNuADv1W4y30HnUMkAtMxAMv24hzywfnv3GE3yG90Uixszy
         GEOGK1Rq0O6D9dD9DqWBEF/LOCek3PNmnnOHsbFdsIJOK7FGRRxzhK1zphUB39ok/lKc
         ahXhKb2X9/gVMPEHZRXJwm7CRFr06FA5R0ot0QjITYNguOAhl0o0SL0GIN+vgEso/BBZ
         rJcQ==
X-Gm-Message-State: ACgBeo1eimPcpUQD6lJwaZBtJxENeylonGi/zUIDAd9I1ar/SMlpfNEV
        1nDj+nkIxnwI657HwVA7rjHKEBpXTWn+csdbZZI=
X-Google-Smtp-Source: AA6agR5M8mjD5db3mzvOpzhCWB+WfFYDXtBRgC/FiRFTTF1WRSCGWhKI/MVcfQVFYnWUFO2Qy611hg==
X-Received: by 2002:a17:907:75d5:b0:730:b051:d93f with SMTP id jl21-20020a17090775d500b00730b051d93fmr11648883ejc.568.1660603802373;
        Mon, 15 Aug 2022 15:50:02 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id f16-20020a50ee90000000b0043cf2e0ce1csm7353704edr.48.2022.08.15.15.50.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 15:50:01 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id p12-20020a7bcc8c000000b003a5360f218fso8468775wma.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:50:01 -0700 (PDT)
X-Received: by 2002:a7b:c399:0:b0:3a5:f3fb:85e0 with SMTP id
 s25-20020a7bc399000000b003a5f3fb85e0mr4429844wmj.38.1660603801029; Mon, 15
 Aug 2022 15:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh1xHi-WeytuAK1-iSsR0wi=6e4-WgFq6ZPt8Z1mvqoNA@mail.gmail.com>
 <Yvny9L3tw1EolqQ4@worktop.programming.kicks-ass.net> <CAHk-=whnEN3Apb5gRXSZK7BM+MOby9VCZe3sDcW34Zme_wk3uA@mail.gmail.com>
 <Yvqn8BqE7FdB6Ccd@worktop.programming.kicks-ass.net>
In-Reply-To: <Yvqn8BqE7FdB6Ccd@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Aug 2022 15:49:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6QaNkoNPA0jrW8F_=RNNb1jCsFF2QngNEQb_C=wMDPQ@mail.gmail.com>
Message-ID: <CAHk-=wj6QaNkoNPA0jrW8F_=RNNb1jCsFF2QngNEQb_C=wMDPQ@mail.gmail.com>
Subject: Re: Simplify load_unaligned_zeropad() (was Re: [GIT PULL] Ceph
 updates for 5.20-rc1)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: multipart/mixed; boundary="000000000000ac874805e64f7363"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000ac874805e64f7363
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 15, 2022 at 1:09 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> I'm not at all suggesting we do this; but it might be
> insn_get_addr_ref() does what is needed.

.. you didn't suggest it at all, but I started doing it anyway.

It's a bit more complicated, and the fixup certainly isn't that
trivial thing any more, but you were right, it's not *that*
complicated, and it does allow us to use arbitrary 'mov' instructions.

And while it now has more added lines than deletions, and the diffstat now says

 3 files changed, 60 insertions(+), 43 deletions(-)

most of the added lines are still that block comment, and some *very*
anal but trivial sanity checks of the instruction decode.

So I could have made it smaller than it used to be by just not doing
any of those verifications, and maybe I went a bit overboard, but I
think this is such a rare case that it's better to be ridiculously
careful than to try to minimize the number of lines.

So it may be a few more lines, but I can argue that it is still at
least conceptually simpler than the conditional asm goto with outputs
code was.

And yeah, it makes some of the code generation places marginally better.

So since I was tricked into writing this patch, and it's even tested
(the second attachment has a truly stupid patch with my test-case), I
think it's worth doing.

Comments? I left your "Acked-by" from the previous version of this
thing, so holler now if you think this got too ugly in the meantime..

               Linus

--000000000000ac874805e64f7363
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-x86-simplify-load_unaligned_zeropad-implementation.patch"
Content-Disposition: attachment; 
	filename="0001-x86-simplify-load_unaligned_zeropad-implementation.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l6vclm2r0>
X-Attachment-Id: f_l6vclm2r0

RnJvbSAzMTBlZGZjN2I2YjBjOWE3OTIxZjExYzA1MTIzNGM3OTM4NTEzMGVkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFN1biwgMTQgQXVnIDIwMjIgMTQ6MTY6MTMgLTA3MDAKU3ViamVjdDog
W1BBVENIXSB4ODY6IHNpbXBsaWZ5IGxvYWRfdW5hbGlnbmVkX3plcm9wYWQoKSBpbXBsZW1lbnRh
dGlvbgoKVGhlIGV4Y2VwdGlvbiBmb3IgdGhlICJ1bmFsaWduZWQgYWNjZXNzIGF0IHRoZSBlbmQg
b2YgdGhlIHBhZ2UsIG5leHQKcGFnZSBub3QgbWFwcGVkIiBuZXZlciBoYXBwZW5zLCBidXQgdGhl
IGZpeHVwIGNvZGUgZW5kcyB1cCBjYXVzaW5nCnRyb3VibGUgZm9yIGNvbXBpbGVycyB0byBvcHRp
bWl6ZSB3ZWxsLgoKY2xhbmcgaW4gcGFydGljdWxhciBlbmRzIHVwIHNlZWluZyBpdCBiZWluZyBp
biB0aGUgbWlkZGxlIG9mIGEgbG9vcCwgYW5kCnRyaWVzIGRlc3BlcmF0ZWx5IHRvIG9wdGltaXpl
IHRoZSBleGNlcHRpb24gZml4dXAgY29kZSB0aGF0IGlzIG5ldmVyCnJlYWxseSByZWFjaGVkLgoK
VGhlIHNpbXBsZSBzb2x1dGlvbiBpcyB0byBqdXN0IG1vdmUgYWxsIHRoZSBmaXh1cHMgaW50byB0
aGUgZXhjZXB0aW9uCmhhbmRsZXIgaXRzZWxmLCB3aGljaCBtb3ZlcyBpdCBhbGwgb3V0IG9mIHRo
ZSBob3QgY2FzZSBjb2RlLCBhbmQgbWVhbnMKdGhhdCB0aGUgY29tcGlsZXIgbmV2ZXIgc2VlcyBp
dCBvciBuZWVkcyB0byB3b3JyeSBhYm91dCBpdC4KCkFja2VkLWJ5OiBQZXRlciBaaWpsc3RyYSA8
cGV0ZXJ6QGluZnJhZGVhZC5vcmc+ClNpZ25lZC1vZmYtYnk6IExpbnVzIFRvcnZhbGRzIDx0b3J2
YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9leHRh
YmxlX2ZpeHVwX3R5cGVzLmggfCAgMiArCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS93b3JkLWF0LWEt
dGltZS5oICAgICAgfCA0NiArKy0tLS0tLS0tLS0tLS0tLS0KIGFyY2gveDg2L21tL2V4dGFibGUu
YyAgICAgICAgICAgICAgICAgICAgICB8IDU1ICsrKysrKysrKysrKysrKysrKysrKysKIDMgZmls
ZXMgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKSwgNDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vZXh0YWJsZV9maXh1cF90eXBlcy5oIGIvYXJjaC94ODYv
aW5jbHVkZS9hc20vZXh0YWJsZV9maXh1cF90eXBlcy5oCmluZGV4IDUwMzYyMjYyNzQwMC4uYjUz
ZjE5MTk3MTBiIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9leHRhYmxlX2ZpeHVw
X3R5cGVzLmgKKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vZXh0YWJsZV9maXh1cF90eXBlcy5o
CkBAIC02NCw0ICs2NCw2IEBACiAjZGVmaW5lCUVYX1RZUEVfVUNPUFlfTEVONAkJKEVYX1RZUEVf
VUNPUFlfTEVOIHwgRVhfREFUQV9JTU0oNCkpCiAjZGVmaW5lCUVYX1RZUEVfVUNPUFlfTEVOOAkJ
KEVYX1RZUEVfVUNPUFlfTEVOIHwgRVhfREFUQV9JTU0oOCkpCiAKKyNkZWZpbmUgRVhfVFlQRV9a
RVJPUEFECQkJMjAgLyogbG9hZCBheCBmcm9tIGR4IHplcm8tcGFkZGVkICovCisKICNlbmRpZgpk
aWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vd29yZC1hdC1hLXRpbWUuaCBiL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL3dvcmQtYXQtYS10aW1lLmgKaW5kZXggODMzOGIwNDMyYjUwLi40NmI0
ZjFmN2YzNTQgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3dvcmQtYXQtYS10aW1l
LmgKKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vd29yZC1hdC1hLXRpbWUuaApAQCAtNzcsNTgg
Kzc3LDE4IEBAIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBmaW5kX3plcm8odW5zaWduZWQg
bG9uZyBtYXNrKQogICogYW5kIHRoZSBuZXh0IHBhZ2Ugbm90IGJlaW5nIG1hcHBlZCwgdGFrZSB0
aGUgZXhjZXB0aW9uIGFuZAogICogcmV0dXJuIHplcm9lcyBpbiB0aGUgbm9uLWV4aXN0aW5nIHBh
cnQuCiAgKi8KLSNpZmRlZiBDT05GSUdfQ0NfSEFTX0FTTV9HT1RPX09VVFBVVAotCiBzdGF0aWMg
aW5saW5lIHVuc2lnbmVkIGxvbmcgbG9hZF91bmFsaWduZWRfemVyb3BhZChjb25zdCB2b2lkICph
ZGRyKQogewotCXVuc2lnbmVkIGxvbmcgb2Zmc2V0LCBkYXRhOwogCXVuc2lnbmVkIGxvbmcgcmV0
OwogCi0JYXNtX3ZvbGF0aWxlX2dvdG8oCisJYXNtIHZvbGF0aWxlKAogCQkiMToJbW92ICVbbWVt
XSwgJVtyZXRdXG4iCi0KLQkJX0FTTV9FWFRBQkxFKDFiLCAlbFtkb19leGNlcHRpb25dKQotCi0J
CTogW3JldF0gIj1yIiAocmV0KQotCQk6IFttZW1dICJtIiAoKih1bnNpZ25lZCBsb25nICopYWRk
cikKLQkJOiA6IGRvX2V4Y2VwdGlvbik7Ci0KLQlyZXR1cm4gcmV0OwotCi1kb19leGNlcHRpb246
Ci0Jb2Zmc2V0ID0gKHVuc2lnbmVkIGxvbmcpYWRkciAmIChzaXplb2YobG9uZykgLSAxKTsKLQlh
ZGRyID0gKHZvaWQgKikoKHVuc2lnbmVkIGxvbmcpYWRkciAmIH4oc2l6ZW9mKGxvbmcpIC0gMSkp
OwotCWRhdGEgPSAqKHVuc2lnbmVkIGxvbmcgKilhZGRyOwotCXJldCA9IGRhdGEgPj4gb2Zmc2V0
ICogODsKLQotCXJldHVybiByZXQ7Ci19Ci0KLSNlbHNlIC8qICFDT05GSUdfQ0NfSEFTX0FTTV9H
T1RPX09VVFBVVCAqLwotCi1zdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgbG9hZF91bmFsaWdu
ZWRfemVyb3BhZChjb25zdCB2b2lkICphZGRyKQotewotCXVuc2lnbmVkIGxvbmcgb2Zmc2V0LCBk
YXRhOwotCXVuc2lnbmVkIGxvbmcgcmV0LCBlcnIgPSAwOwotCi0JYXNtKAkiMToJbW92ICVbbWVt
XSwgJVtyZXRdXG4iCiAJCSIyOlxuIgotCi0JCV9BU01fRVhUQUJMRV9GQVVMVCgxYiwgMmIpCi0K
LQkJOiBbcmV0XSAiPSZyIiAocmV0KSwgIithIiAoZXJyKQorCQlfQVNNX0VYVEFCTEVfVFlQRSgx
YiwgMmIsIEVYX1RZUEVfWkVST1BBRCkKKwkJOiBbcmV0XSAiPXIiIChyZXQpCiAJCTogW21lbV0g
Im0iICgqKHVuc2lnbmVkIGxvbmcgKilhZGRyKSk7CiAKLQlpZiAodW5saWtlbHkoZXJyKSkgewot
CQlvZmZzZXQgPSAodW5zaWduZWQgbG9uZylhZGRyICYgKHNpemVvZihsb25nKSAtIDEpOwotCQlh
ZGRyID0gKHZvaWQgKikoKHVuc2lnbmVkIGxvbmcpYWRkciAmIH4oc2l6ZW9mKGxvbmcpIC0gMSkp
OwotCQlkYXRhID0gKih1bnNpZ25lZCBsb25nICopYWRkcjsKLQkJcmV0ID0gZGF0YSA+PiBvZmZz
ZXQgKiA4OwotCX0KLQogCXJldHVybiByZXQ7CiB9CiAKLSNlbmRpZiAvKiBDT05GSUdfQ0NfSEFT
X0FTTV9HT1RPX09VVFBVVCAqLwotCiAjZW5kaWYgLyogX0FTTV9XT1JEX0FUX0FfVElNRV9IICov
CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS9leHRhYmxlLmMgYi9hcmNoL3g4Ni9tbS9leHRhYmxl
LmMKaW5kZXggMzMxMzEwYzI5MzQ5Li42MDgxNGUxMTBhNTQgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2
L21tL2V4dGFibGUuYworKysgYi9hcmNoL3g4Ni9tbS9leHRhYmxlLmMKQEAgLTQxLDYgKzQxLDU5
IEBAIHN0YXRpYyBib29sIGV4X2hhbmRsZXJfZGVmYXVsdChjb25zdCBzdHJ1Y3QgZXhjZXB0aW9u
X3RhYmxlX2VudHJ5ICplLAogCXJldHVybiB0cnVlOwogfQogCisvKgorICogVGhpcyBpcyB0aGUg
KnZlcnkqIHJhcmUgY2FzZSB3aGVyZSB3ZSBkbyBhICJsb2FkX3VuYWxpZ25lZF96ZXJvcGFkKCki
CisgKiBhbmQgaXQncyBhIHBhZ2UgY3Jvc3NlciBpbnRvIGEgbm9uLWV4aXN0ZW50IHBhZ2UuCisg
KgorICogVGhpcyBoYXBwZW5zIHdoZW4gd2Ugb3B0aW1pc3RpY2FsbHkgbG9hZCBhIHBhdGhuYW1l
IGEgd29yZC1hdC1hLXRpbWUKKyAqIGFuZCB0aGUgbmFtZSBpcyBsZXNzIHRoYW4gdGhlIGZ1bGwg
d29yZCBhbmQgdGhlICBuZXh0IHBhZ2UgaXMgbm90CisgKiBtYXBwZWQuIFR5cGljYWxseSB0aGF0
IG9ubHkgaGFwcGVucyBmb3IgQ09ORklHX0RFQlVHX1BBR0VBTExPQy4KKyAqCisgKiBOT1RFISBU
aGUgZmF1bHRpbmcgYWRkcmVzcyBpcyBhbHdheXMgYSAnbW92IG1lbSxyZWcnIHR5cGUgaW5zdHJ1
Y3Rpb24KKyAqIG9mIHNpemUgJ2xvbmcnLCBhbmQgdGhlIGV4Y2VwdGlvbiBmaXh1cCBtdXN0IGFs
d2F5cyBwb2ludCB0byByaWdodAorICogYWZ0ZXIgdGhlIGluc3RydWN0aW9uLgorICovCitzdGF0
aWMgYm9vbCBleF9oYW5kbGVyX3plcm9wYWQoY29uc3Qgc3RydWN0IGV4Y2VwdGlvbl90YWJsZV9l
bnRyeSAqZSwKKwkJCSAgICAgICBzdHJ1Y3QgcHRfcmVncyAqcmVncywKKwkJCSAgICAgICB1bnNp
Z25lZCBsb25nIGZhdWx0X2FkZHIpCit7CisJc3RydWN0IGluc24gaW5zbjsKKwljb25zdCB1bnNp
Z25lZCBsb25nIG1hc2sgPSBzaXplb2YobG9uZykgLSAxOworCXVuc2lnbmVkIGxvbmcgb2Zmc2V0
LCBhZGRyLCBuZXh0X2lwLCBsZW47CisJdW5zaWduZWQgbG9uZyAqcmVnOworCisJbmV4dF9pcCA9
IGV4X2ZpeHVwX2FkZHIoZSk7CisJbGVuID0gbmV4dF9pcCAtIHJlZ3MtPmlwOworCWlmIChsZW4g
PiBNQVhfSU5TTl9TSVpFKQorCQlyZXR1cm4gZmFsc2U7CisKKwlpZiAoaW5zbl9kZWNvZGUoJmlu
c24sICh2b2lkICopIHJlZ3MtPmlwLCBsZW4sIElOU05fTU9ERV9LRVJOKSkKKwkJcmV0dXJuIGZh
bHNlOworCWlmIChpbnNuLmxlbmd0aCAhPSBsZW4pCisJCXJldHVybiBmYWxzZTsKKworCWlmIChp
bnNuLm9wY29kZS5ieXRlc1swXSAhPSAweDhiKQorCQlyZXR1cm4gZmFsc2U7CisJaWYgKGluc24u
b3BuZF9ieXRlcyAhPSBzaXplb2YobG9uZykpCisJCXJldHVybiBmYWxzZTsKKworCWFkZHIgPSAo
dW5zaWduZWQgbG9uZykgaW5zbl9nZXRfYWRkcl9yZWYoJmluc24sIHJlZ3MpOworCWlmIChhZGRy
ID09IH4wdWwpCisJCXJldHVybiBmYWxzZTsKKworCW9mZnNldCA9IGFkZHIgJiBtYXNrOworCWFk
ZHIgPSBhZGRyICYgfm1hc2s7CisJaWYgKGZhdWx0X2FkZHIgIT0gYWRkciArIHNpemVvZihsb25n
KSkKKwkJcmV0dXJuIGZhbHNlOworCisJcmVnID0gaW5zbl9nZXRfbW9kcm1fcmVnX3B0cigmaW5z
biwgcmVncyk7CisJaWYgKCFyZWcpCisJCXJldHVybiBmYWxzZTsKKworCSpyZWcgPSAqKHVuc2ln
bmVkIGxvbmcgKilhZGRyID4+IChvZmZzZXQgKiA4KTsKKwlyZXR1cm4gZXhfaGFuZGxlcl9kZWZh
dWx0KGUsIHJlZ3MpOworfQorCiBzdGF0aWMgYm9vbCBleF9oYW5kbGVyX2ZhdWx0KGNvbnN0IHN0
cnVjdCBleGNlcHRpb25fdGFibGVfZW50cnkgKmZpeHVwLAogCQkJICAgICBzdHJ1Y3QgcHRfcmVn
cyAqcmVncywgaW50IHRyYXBucikKIHsKQEAgLTIxNyw2ICsyNzAsOCBAQCBpbnQgZml4dXBfZXhj
ZXB0aW9uKHN0cnVjdCBwdF9yZWdzICpyZWdzLCBpbnQgdHJhcG5yLCB1bnNpZ25lZCBsb25nIGVy
cm9yX2NvZGUsCiAJCXJldHVybiBleF9oYW5kbGVyX3NneChlLCByZWdzLCB0cmFwbnIpOwogCWNh
c2UgRVhfVFlQRV9VQ09QWV9MRU46CiAJCXJldHVybiBleF9oYW5kbGVyX3Vjb3B5X2xlbihlLCBy
ZWdzLCB0cmFwbnIsIHJlZywgaW1tKTsKKwljYXNlIEVYX1RZUEVfWkVST1BBRDoKKwkJcmV0dXJu
IGV4X2hhbmRsZXJfemVyb3BhZChlLCByZWdzLCBmYXVsdF9hZGRyKTsKIAl9CiAJQlVHKCk7CiB9
Ci0tIAoyLjM3LjEuMjg5Lmc0NWFhMWU1YzcyLmRpcnR5Cgo=
--000000000000ac874805e64f7363
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l6vclt1p1>
X-Attachment-Id: f_l6vclt1p1

IGluaXQvbWFpbi5jIHwgMTMgKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbml0L21haW4uYyBiL2luaXQvbWFpbi5jCmluZGV4IDkx
NjQyYTRlNjliZS4uYzFlNjMyNTgyNDE5IDEwMDY0NAotLS0gYS9pbml0L21haW4uYworKysgYi9p
bml0L21haW4uYwpAQCAtMTA4LDYgKzEwOCw4IEBACiAjaW5jbHVkZSA8YXNtL3NlY3Rpb25zLmg+
CiAjaW5jbHVkZSA8YXNtL2NhY2hlZmx1c2guaD4KIAorI2luY2x1ZGUgPGFzbS93b3JkLWF0LWEt
dGltZS5oPgorCiAjZGVmaW5lIENSRUFURV9UUkFDRV9QT0lOVFMKICNpbmNsdWRlIDx0cmFjZS9l
dmVudHMvaW5pdGNhbGwuaD4KIApAQCAtMTQ4OCw2ICsxNDkwLDE1IEBAIHZvaWQgX193ZWFrIGZy
ZWVfaW5pdG1lbSh2b2lkKQogCWZyZWVfaW5pdG1lbV9kZWZhdWx0KFBPSVNPTl9GUkVFX0lOSVRN
RU0pOwogfQogCitzdGF0aWMgaW50IHRlc3RfdW5hbGlnbmVkKHZvaWQgKnVudXNlZCkKK3sKKwl2
b2lkICpidWYgPSB2bWFsbG9jKFBBR0VfU0laRSk7CisJbWVtc2V0KGJ1ZiwgMHhmZSwgUEFHRV9T
SVpFKTsKKwlwcmludGsoImxvYWRfdW5hbGlnbmVkX3plcm9wYWQgPSAlMDE2bHhcbiIsIGxvYWRf
dW5hbGlnbmVkX3plcm9wYWQoYnVmICsgUEFHRV9TSVpFIC0gNSkpOworCWt0aHJlYWRfZXhpdCgw
KTsKK30KKworCiBzdGF0aWMgaW50IF9fcmVmIGtlcm5lbF9pbml0KHZvaWQgKnVudXNlZCkKIHsK
IAlpbnQgcmV0OwpAQCAtMTUxOCw2ICsxNTI5LDggQEAgc3RhdGljIGludCBfX3JlZiBrZXJuZWxf
aW5pdCh2b2lkICp1bnVzZWQpCiAJc3lzdGVtX3N0YXRlID0gU1lTVEVNX1JVTk5JTkc7CiAJbnVt
YV9kZWZhdWx0X3BvbGljeSgpOwogCitrZXJuZWxfdGhyZWFkKHRlc3RfdW5hbGlnbmVkLCBOVUxM
LCBDTE9ORV9GUyB8IENMT05FX0ZJTEVTKTsKKwogCXJjdV9lbmRfaW5rZXJuZWxfYm9vdCgpOwog
CiAJZG9fc3lzY3RsX2FyZ3MoKTsK
--000000000000ac874805e64f7363--
