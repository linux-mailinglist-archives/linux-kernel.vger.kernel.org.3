Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B752532FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 19:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240095AbiEXRyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 13:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiEXRyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:54:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38B55DA2E
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:53:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id rq11so14778939ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wa+upPf1apLqjKuR1HuZi1E27/u3cGlLf+e2phX4Q/M=;
        b=Lc5TUPE+V/J7/uOG4++sFWqA0iw2MijypnqiwwIh2GiIbOp7GYm+2zqLmvbIZSnWF/
         IWG4MtvXETAauWUFTCzIm9h+JNA3a5Du5IJuH4RUscUwP85nPI5iaQ+0wkyOU0R+Wuu+
         BFT/kOgozR1lYOBnwsCCgQ4WzjpzTjWqqDYt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wa+upPf1apLqjKuR1HuZi1E27/u3cGlLf+e2phX4Q/M=;
        b=dAUhG5Y4VtDtpsoPZlx0qogOJwV1bFBalKfoznO8IR57s9+a1MPPINLh4NwSmJ5sZH
         vCyCB1sV5RQA42ry+C5iClo1j2ip2TBnOvMWFYmo+dWBBp/Y3XIBCBRyAUnv72okOoF8
         kCj5PwGRukYQ3mmNlicFV3lrKLUg2ltlQ0ET9LDfN2yjhy7DxlZsx9ARYHYCGzRp0BRW
         gJrhUtdOjnCa1aw71YRmoXYX9sG9Wpnb/sxxSPm3eai5sfI1BCNNIAchvifXox+e++s1
         RRjQQiaGmKJnvDle8EnENOPQRMe6jWlSIQBa6mGWLZcrmPPqdZlAtPkg4yCbs1s7h7pi
         1lzQ==
X-Gm-Message-State: AOAM5324DFcJAUuktH0INimCeE0T9dVUMhGYL9kItE2CBVSxl/yeM3BS
        eIZx3U0B9xXXWrykuvMwt4SNyhPJJtLLALdB
X-Google-Smtp-Source: ABdhPJyQc2bMQ5t4kxnQTDEiUKIeLhhN+HFMVk2g+SZY/D2sOSepNlKypO/1gvcrOG5JPMeaE2lKyg==
X-Received: by 2002:a17:906:2658:b0:6fe:deae:cf0d with SMTP id i24-20020a170906265800b006fedeaecf0dmr10624020ejc.119.1653414838174;
        Tue, 24 May 2022 10:53:58 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id n8-20020a170906088800b006fed5247df9sm2794311eje.196.2022.05.24.10.53.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 10:53:57 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id u3so26809213wrg.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:53:57 -0700 (PDT)
X-Received: by 2002:a5d:59ac:0:b0:20e:6fd6:88c1 with SMTP id
 p12-20020a5d59ac000000b0020e6fd688c1mr21783371wrr.442.1653414837147; Tue, 24
 May 2022 10:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <You3JC/BOIyEnmQj@gmail.com> <Yoxucp7aUrCaV9uE@gmail.com> <Yox088fRrhh4grBX@gmail.com>
In-Reply-To: <Yox088fRrhh4grBX@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 May 2022 10:53:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whRTihOdCij9MxpG433cB_9ZHhBeMVAVpAA5Bf2mdr5yA@mail.gmail.com>
Message-ID: <CAHk-=whRTihOdCij9MxpG433cB_9ZHhBeMVAVpAA5Bf2mdr5yA@mail.gmail.com>
Subject: Re: [GIT PULL] objtool changes for v5.19
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: multipart/mixed; boundary="00000000000009102c05dfc5a498"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000009102c05dfc5a498
Content-Type: text/plain; charset="UTF-8"

On Mon, May 23, 2022 at 11:02 PM Ingo Molnar <mingo@kernel.org> wrote:
>
> Note that with your latest tree you'll get 3 new conflicts:

No problem, but the conflicts did make something clear: the objtool
code should just get rid of the "--uaccess" flag that is now
unconditional when CONFIG_X86_SMAP has been removed.

I didn't actually do that, and instead just did the mindless merge
conflict resolution, but it might be a good idea.

See commit dbae0a934f09 ("x86/cpu: Remove CONFIG_X86_SMAP and
'nosmap'") for when it was removed.

Josh? The patch *might* be something like the attached, but this is
(a) untested and (b) that 'opts.noinstr' part of the patch is a bit
dodgy (ie I made the previous 'if' unconditional, but then changed the
follow 'else if ()'  to just 'if ()' instead of deleting it, which is
what "uaccess is always set" would technically have done.

Again: I did *not* do this as part of the merge, the attached patch is
just a suggestion of something that I think should now be done after
the merge.

Hmm?

                        Linus

--00000000000009102c05dfc5a498
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l3kggtqd0>
X-Attachment-Id: f_l3kggtqd0

IHNjcmlwdHMvTWFrZWZpbGUuYnVpbGQgICAgICAgICAgICAgICAgICB8ICAxIC0KIHNjcmlwdHMv
bGluay12bWxpbnV4LnNoICAgICAgICAgICAgICAgICB8ICAyIC0tCiB0b29scy9vYmp0b29sL2Fy
Y2gveDg2L3NwZWNpYWwuYyAgICAgICAgfCAgOCArKy0tLS0tLQogdG9vbHMvb2JqdG9vbC9idWls
dGluLWNoZWNrLmMgICAgICAgICAgIHwgIDQgKy0tLQogdG9vbHMvb2JqdG9vbC9jaGVjay5jICAg
ICAgICAgICAgICAgICAgIHwgMzAgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tCiB0b29s
cy9vYmp0b29sL2luY2x1ZGUvb2JqdG9vbC9idWlsdGluLmggfCAgMSAtCiA2IGZpbGVzIGNoYW5n
ZWQsIDE2IGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Njcmlw
dHMvTWFrZWZpbGUuYnVpbGQgYi9zY3JpcHRzL01ha2VmaWxlLmJ1aWxkCmluZGV4IGY4OWQzZmNm
ZjM5Zi4uNGQ5NmRlYTlmZjMxIDEwMDY0NAotLS0gYS9zY3JpcHRzL01ha2VmaWxlLmJ1aWxkCisr
KyBiL3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQKQEAgLTIzNiw3ICsyMzYsNiBAQCBvYmp0b29sX2Fy
Z3MgPQkJCQkJCQkJXAogCSQoaWYgJChDT05GSUdfU0xTKSwgLS1zbHMpCQkJCQlcCiAJJChpZiAk
KENPTkZJR19TVEFDS19WQUxJREFUSU9OKSwgLS1zdGFja3ZhbCkJCQlcCiAJJChpZiAkKENPTkZJ
R19IQVZFX1NUQVRJQ19DQUxMX0lOTElORSksIC0tc3RhdGljLWNhbGwpCQlcCi0JLS11YWNjZXNz
CQkJCQkJCVwKIAkkKGlmICQobGlua2VkLW9iamVjdCksIC0tbGluaykJCQkJCVwKIAkkKGlmICQo
cGFydC1vZi1tb2R1bGUpLCAtLW1vZHVsZSkJCQkJXAogCSQoaWYgJChDT05GSUdfR0NPVl9LRVJO
RUwpLCAtLW5vLXVucmVhY2hhYmxlKQpkaWZmIC0tZ2l0IGEvc2NyaXB0cy9saW5rLXZtbGludXgu
c2ggYi9zY3JpcHRzL2xpbmstdm1saW51eC5zaAppbmRleCBkN2YyNmYwMmYxNDIuLmFkZDk4Y2U5
ZTFlNSAxMDA3NTUKLS0tIGEvc2NyaXB0cy9saW5rLXZtbGludXguc2gKKysrIGIvc2NyaXB0cy9s
aW5rLXZtbGludXguc2gKQEAgLTE1Miw4ICsxNTIsNiBAQCBvYmp0b29sX2xpbmsoKQogCQlpZiBp
c19lbmFibGVkIENPTkZJR19IQVZFX1NUQVRJQ19DQUxMX0lOTElORTsgdGhlbgogCQkJb2JqdG9v
bG9wdD0iJHtvYmp0b29sb3B0fSAtLXN0YXRpYy1jYWxsIgogCQlmaQotCi0JCW9ianRvb2xvcHQ9
IiR7b2JqdG9vbG9wdH0gLS11YWNjZXNzIgogCWZpCiAKIAlpZiBpc19lbmFibGVkIENPTkZJR19O
T0lOU1RSX1ZBTElEQVRJT047IHRoZW4KZGlmZiAtLWdpdCBhL3Rvb2xzL29ianRvb2wvYXJjaC94
ODYvc3BlY2lhbC5jIGIvdG9vbHMvb2JqdG9vbC9hcmNoL3g4Ni9zcGVjaWFsLmMKaW5kZXggN2M5
N2I3MzkxMjc5Li5iMDcwZWRiNWZkOGYgMTAwNjQ0Ci0tLSBhL3Rvb2xzL29ianRvb2wvYXJjaC94
ODYvc3BlY2lhbC5jCisrKyBiL3Rvb2xzL29ianRvb2wvYXJjaC94ODYvc3BlY2lhbC5jCkBAIC0x
MiwxOCArMTIsMTQgQEAgdm9pZCBhcmNoX2hhbmRsZV9hbHRlcm5hdGl2ZSh1bnNpZ25lZCBzaG9y
dCBmZWF0dXJlLCBzdHJ1Y3Qgc3BlY2lhbF9hbHQgKmFsdCkKIAlzd2l0Y2ggKGZlYXR1cmUpIHsK
IAljYXNlIFg4Nl9GRUFUVVJFX1NNQVA6CiAJCS8qCi0JCSAqIElmIFVBQ0NFU1MgdmFsaWRhdGlv
biBpcyBlbmFibGVkOyBmb3JjZSB0aGF0IGFsdGVybmF0aXZlOwotCQkgKiBvdGhlcndpc2UgZm9y
Y2UgaXQgdGhlIG90aGVyIHdheS4KKwkJICogRm9yY2UgdGhlIHVhY2Nlc3MgYWx0ZXJuYXRpdmUu
CiAJCSAqCiAJCSAqIFdoYXQgd2Ugd2FudCB0byBhdm9pZCBpcyBoYXZpbmcgYm90aCB0aGUgb3Jp
Z2luYWwgYW5kIHRoZQogCQkgKiBhbHRlcm5hdGl2ZSBjb2RlIGZsb3cgYXQgdGhlIHNhbWUgdGlt
ZSwgaW4gdGhhdCBjYXNlIHdlIGNhbgogCQkgKiBmaW5kIHBhdGhzIHRoYXQgc2VlIHRoZSBTVEFD
IGJ1dCB0YWtlIHRoZSBOT1AgaW5zdGVhZCBvZgogCQkgKiBDTEFDIGFuZCB0aGUgb3RoZXIgd2F5
IGFyb3VuZC4KIAkJICovCi0JCWlmIChvcHRzLnVhY2Nlc3MpCi0JCQlhbHQtPnNraXBfb3JpZyA9
IHRydWU7Ci0JCWVsc2UKLQkJCWFsdC0+c2tpcF9hbHQgPSB0cnVlOworCQlhbHQtPnNraXBfb3Jp
ZyA9IHRydWU7CiAJCWJyZWFrOwogCWNhc2UgWDg2X0ZFQVRVUkVfUE9QQ05UOgogCQkvKgpkaWZm
IC0tZ2l0IGEvdG9vbHMvb2JqdG9vbC9idWlsdGluLWNoZWNrLmMgYi90b29scy9vYmp0b29sL2J1
aWx0aW4tY2hlY2suYwppbmRleCBmNGMzYTUwOTE3MzcuLmFlMjg5MDVkYzE3YSAxMDA2NDQKLS0t
IGEvdG9vbHMvb2JqdG9vbC9idWlsdGluLWNoZWNrLmMKKysrIGIvdG9vbHMvb2JqdG9vbC9idWls
dGluLWNoZWNrLmMKQEAgLTcxLDcgKzcxLDYgQEAgY29uc3Qgc3RydWN0IG9wdGlvbiBjaGVja19v
cHRpb25zW10gPSB7CiAJT1BUX0JPT0xFQU4oJ2wnLCAic2xzIiwgJm9wdHMuc2xzLCAidmFsaWRh
dGUgc3RyYWlnaHQtbGluZS1zcGVjdWxhdGlvbiBtaXRpZ2F0aW9ucyIpLAogCU9QVF9CT09MRUFO
KCdzJywgInN0YWNrdmFsIiwgJm9wdHMuc3RhY2t2YWwsICJ2YWxpZGF0ZSBmcmFtZSBwb2ludGVy
IHJ1bGVzIiksCiAJT1BUX0JPT0xFQU4oJ3QnLCAic3RhdGljLWNhbGwiLCAmb3B0cy5zdGF0aWNf
Y2FsbCwgImFubm90YXRlIHN0YXRpYyBjYWxscyIpLAotCU9QVF9CT09MRUFOKCd1JywgInVhY2Nl
c3MiLCAmb3B0cy51YWNjZXNzLCAidmFsaWRhdGUgdWFjY2VzcyBydWxlcyBmb3IgU01BUCIpLAog
CU9QVF9DQUxMQkFDS19PUFRBUkcoMCwgImR1bXAiLCBOVUxMLCBOVUxMLCAib3JjIiwgImR1bXAg
bWV0YWRhdGEiLCBwYXJzZV9kdW1wKSwKIAogCU9QVF9HUk9VUCgiT3B0aW9uczoiKSwKQEAgLTEy
NSw4ICsxMjQsNyBAQCBzdGF0aWMgYm9vbCBvcHRzX3ZhbGlkKHZvaWQpCiAJICAgIG9wdHMucmV0
cG9saW5lCQl8fAogCSAgICBvcHRzLnNscwkJCXx8CiAJICAgIG9wdHMuc3RhY2t2YWwJCXx8Ci0J
ICAgIG9wdHMuc3RhdGljX2NhbGwJCXx8Ci0JICAgIG9wdHMudWFjY2VzcykgeworCSAgICBvcHRz
LnN0YXRpY19jYWxsKSB7CiAJCWlmIChvcHRzLmR1bXBfb3JjKSB7CiAJCQlFUlJPUigiLS1kdW1w
IGNhbid0IGJlIGNvbWJpbmVkIHdpdGggb3RoZXIgb3B0aW9ucyIpOwogCQkJcmV0dXJuIGZhbHNl
OwpkaWZmIC0tZ2l0IGEvdG9vbHMvb2JqdG9vbC9jaGVjay5jIGIvdG9vbHMvb2JqdG9vbC9jaGVj
ay5jCmluZGV4IDE5MGIyZjZlMzYwYS4uODZmMDFmODZjZDEzIDEwMDY0NAotLS0gYS90b29scy9v
Ymp0b29sL2NoZWNrLmMKKysrIGIvdG9vbHMvb2JqdG9vbC9jaGVjay5jCkBAIC0xMDMwLDkgKzEw
MzAsNiBAQCBzdGF0aWMgdm9pZCBhZGRfdWFjY2Vzc19zYWZlKHN0cnVjdCBvYmp0b29sX2ZpbGUg
KmZpbGUpCiAJc3RydWN0IHN5bWJvbCAqZnVuYzsKIAljb25zdCBjaGFyICoqbmFtZTsKIAotCWlm
ICghb3B0cy51YWNjZXNzKQotCQlyZXR1cm47Ci0KIAlmb3IgKG5hbWUgPSB1YWNjZXNzX3NhZmVf
YnVpbHRpbjsgKm5hbWU7IG5hbWUrKykgewogCQlmdW5jID0gZmluZF9zeW1ib2xfYnlfbmFtZShm
aWxlLT5lbGYsICpuYW1lKTsKIAkJaWYgKCFmdW5jKQpAQCAtMzkxOSwyNSArMzkxNiwyNCBAQCBp
bnQgY2hlY2soc3RydWN0IG9ianRvb2xfZmlsZSAqZmlsZSkKIAkJd2FybmluZ3MgKz0gcmV0Owog
CX0KIAotCWlmIChvcHRzLnN0YWNrdmFsIHx8IG9wdHMub3JjIHx8IG9wdHMudWFjY2Vzcykgewot
CQlyZXQgPSB2YWxpZGF0ZV9mdW5jdGlvbnMoZmlsZSk7Ci0JCWlmIChyZXQgPCAwKQotCQkJZ290
byBvdXQ7Ci0JCXdhcm5pbmdzICs9IHJldDsKKwlyZXQgPSB2YWxpZGF0ZV9mdW5jdGlvbnMoZmls
ZSk7CisJaWYgKHJldCA8IDApCisJCWdvdG8gb3V0OworCXdhcm5pbmdzICs9IHJldDsKIAotCQly
ZXQgPSB2YWxpZGF0ZV91bndpbmRfaGludHMoZmlsZSwgTlVMTCk7CisJcmV0ID0gdmFsaWRhdGVf
dW53aW5kX2hpbnRzKGZpbGUsIE5VTEwpOworCWlmIChyZXQgPCAwKQorCQlnb3RvIG91dDsKKwl3
YXJuaW5ncyArPSByZXQ7CisKKwlpZiAoIXdhcm5pbmdzKSB7CisJCXJldCA9IHZhbGlkYXRlX3Jl
YWNoYWJsZV9pbnN0cnVjdGlvbnMoZmlsZSk7CiAJCWlmIChyZXQgPCAwKQogCQkJZ290byBvdXQ7
CiAJCXdhcm5pbmdzICs9IHJldDsKKwl9CiAKLQkJaWYgKCF3YXJuaW5ncykgewotCQkJcmV0ID0g
dmFsaWRhdGVfcmVhY2hhYmxlX2luc3RydWN0aW9ucyhmaWxlKTsKLQkJCWlmIChyZXQgPCAwKQot
CQkJCWdvdG8gb3V0OwotCQkJd2FybmluZ3MgKz0gcmV0OwotCQl9Ci0KLQl9IGVsc2UgaWYgKG9w
dHMubm9pbnN0cikgeworCWlmIChvcHRzLm5vaW5zdHIpIHsKIAkJcmV0ID0gdmFsaWRhdGVfbm9p
bnN0cl9zZWN0aW9ucyhmaWxlKTsKIAkJaWYgKHJldCA8IDApCiAJCQlnb3RvIG91dDsKZGlmZiAt
LWdpdCBhL3Rvb2xzL29ianRvb2wvaW5jbHVkZS9vYmp0b29sL2J1aWx0aW4uaCBiL3Rvb2xzL29i
anRvb2wvaW5jbHVkZS9vYmp0b29sL2J1aWx0aW4uaAppbmRleCAyODBlYTE4YjdmMmIuLjgwNTRm
M2RjNzcxMiAxMDA2NDQKLS0tIGEvdG9vbHMvb2JqdG9vbC9pbmNsdWRlL29ianRvb2wvYnVpbHRp
bi5oCisrKyBiL3Rvb2xzL29ianRvb2wvaW5jbHVkZS9vYmp0b29sL2J1aWx0aW4uaApAQCAtMjIs
NyArMjIsNiBAQCBzdHJ1Y3Qgb3B0cyB7CiAJYm9vbCBzbHM7CiAJYm9vbCBzdGFja3ZhbDsKIAli
b29sIHN0YXRpY19jYWxsOwotCWJvb2wgdWFjY2VzczsKIAogCS8qIG9wdGlvbnM6ICovCiAJYm9v
bCBiYWNrdHJhY2U7Cg==
--00000000000009102c05dfc5a498--
