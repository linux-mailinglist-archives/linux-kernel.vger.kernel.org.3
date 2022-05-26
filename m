Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88330534C08
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239121AbiEZIzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiEZIzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:55:12 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73497C3D1F
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:55:10 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id bl14so17550qtb.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bIETZN5LHnHAH+U1JfhvsbCUrW1/W0Niq8OmHZJ39Os=;
        b=Q3GGF3sWTGLvm6w8AXmfn1JRu5uam28CQOycDVq8tgBxR4YhCzbv1wJchoJU2ecPzl
         7XkhJqytQLOrylS76GhAKTHVMhkBC9JC3rzueSF6doyip2ymBVQEcwcWDyiCwi+yEokn
         npfy1EJDfxkOGJcKLPEIY3xZuW5BGd+aQbK8BnYMMAzpllyWSsV9btD5K2vYRfIaLVhR
         Jy8jQr5ckZ+bpdELT5NLxFuGOinEL//Ei9nOFwrJMsIYfVDWR1P8qs8cOcDT1w6fYdXK
         fcAP+a0kf8Swgspl1h969zS7G8iD4r5+DM5dolRKMUbz8wkVIYCutw7PlbddYQqPdOTr
         FInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bIETZN5LHnHAH+U1JfhvsbCUrW1/W0Niq8OmHZJ39Os=;
        b=eDhVj8bjP/bvq0kMQDPc0Z2OTA+zpqMyjam46OWEy38Li+fbxlOGClrUtLR1fnOuQW
         +DGxfDp8uZhR7hNF1euKgOQKbL4OUaNC76MYwiBx9MTYGzW9j9dxOa7VFzItM05o5jHn
         WXA0YBQKQbo+bW4fR+KS+zgTgQerlO5KddwOsQMEHtItVfAoOkdEfTqHwxjFR09PN7bu
         apBBKuoHxu7sQ8UL3gVY3zWvl422i6cGGl5yD84iixvCRPXQuKGXSTgByBxsz8LunUK8
         bRsIkdLP8ntQVStZLRW+yoqA/J6S07rQvLy1NamOpTuvEqVhTNFlmsST9iarCE9EKrXD
         VAuw==
X-Gm-Message-State: AOAM532mEu1v+b987jxZ0lFNihf71mIijaVVl3zsAU4aMCtfvM7kFZZU
        I5mnAyNqb/t+Y3Ny75+CliQf2YR6iInNZ0+M81A=
X-Google-Smtp-Source: ABdhPJwelRgMh1nRJ54ZYmK4gx7kA2yWrak2VpuwwdstL51dufOW67pn/MNWjf/4BsKVc+EvNjZk/q8I+rZ/JGd+7LE=
X-Received: by 2002:a05:622a:c7:b0:2fa:ec2f:a386 with SMTP id
 p7-20020a05622a00c700b002faec2fa386mr5654121qtw.5.1653555309508; Thu, 26 May
 2022 01:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220525144013.6481-1-ubizjak@gmail.com> <20220525144013.6481-2-ubizjak@gmail.com>
 <CAHk-=wh1XeaxWXG5QziGA4ds918UnW1hO924kusgVB-wGj+9Og@mail.gmail.com>
In-Reply-To: <CAHk-=wh1XeaxWXG5QziGA4ds918UnW1hO924kusgVB-wGj+9Og@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 26 May 2022 10:54:58 +0200
Message-ID: <CAFULd4bc54+_FmJ=f++zzz99mR8r5c11-Y49pz86Yb8G3dyJpA@mail.gmail.com>
Subject: Re: [PATCH 1/2] locking/lockref: Use try_cmpxchg64 in CMPXCHG_LOOP macro
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Content-Type: multipart/mixed; boundary="000000000000d7603a05dfe658c4"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d7603a05dfe658c4
Content-Type: text/plain; charset="UTF-8"

On Wed, May 25, 2022 at 6:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, May 25, 2022 at 7:40 AM Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > Use try_cmpxchg64 instead of cmpxchg64 in CMPXCHG_LOOP macro.
> > x86 CMPXCHG instruction returns success in ZF flag, so this
> > change saves a compare after cmpxchg (and related move instruction
> > in front of cmpxchg). The main loop of lockref_get improves from:
>
> Ack on this one regardless of the 32-bit x86 question.
>
> HOWEVER.
>
> I'd like other architectures to pipe up too, because I think right now
> x86 is the only one that implements that "arch_try_cmpxchg()" family
> of operations natively, and I think the generic fallback for when it
> is missing might be kind of nasty.
>
> Maybe it ends up generating ok code, but it's also possible that it
> just didn't matter when it was only used in one place in the
> scheduler.
>
> The lockref_get() case can be quite hot under some loads, it would be
> sad if this made other architectures worse.
>
> Anyway, maybe that try_cmpxchg() fallback is fine, and works out well
> on architectures that use load-locked / store-conditional as-is.

Attached to this message, please find attached the testcase that
analyses various CMPXCHG_LOOPs. Here you will find the old, the
fallback and the new cmpxchg loop, together with corresponding
lockref_get_* functions.

The testcase models the x86 cmpxchg8b and can be compiled for 64bit as
well as 32bit targets. As can be seen from the experiment, the
try_cmpxchg fallback creates EXACTLY THE SAME code for 64bit target as
the unpatched code. For the 32bit target one extra dead reg-reg 32bit
move remains in the generated fallback code assembly (this is the
compiler (gcc-10.3) artefact with double-word 64bit moves on x86_32
target).

From the above experiment, we can conclude that the patched lockref.c
creates the same code with the try_cmpxchg fallback as the original
code. I think the same will be observed also for other targets.

When the new code involving try_cmpxchg is compiled, impressive size
gains for x86_32 can be seen. The main loop size reduces from 44 bytes
to 30 bytes.

In the git repository, several transitions from cmpxchg to try_cmpxchg
can be found. The above experiment confirms, that the generated
fallback assembly is at least as good as the original unpatched
version, but can be more optimal when the target provides try_cmpxchg
instruction. Also, it looks to me that several other hot spots
throughout the code can be improved by changing them from using
cmpxchg to try_cmpxchg.

Uros.

--000000000000d7603a05dfe658c4
Content-Type: text/x-csrc; charset="US-ASCII"; name="lockref-test.c"
Content-Disposition: attachment; filename="lockref-test.c"
Content-Transfer-Encoding: base64
Content-ID: <f_l3ms4e290>
X-Attachment-Id: f_l3ms4e290

I2luY2x1ZGUgPHN0ZGludC5oPgoKI2RlZmluZSBfX2FsaWduZWRfdTY0IHU2NCBfX2F0dHJpYnV0
ZV9fKChhbGlnbmVkKDgpKSkKCiNkZWZpbmUgTE9DS19QUkVGSVggImxvY2sgIgoKIyBkZWZpbmUg
bGlrZWx5KHgpCV9fYnVpbHRpbl9leHBlY3QoISEoeCksIDEpCiMgZGVmaW5lIHVubGlrZWx5KHgp
CV9fYnVpbHRpbl9leHBlY3QoISEoeCksIDApCgp0eXBlZGVmIHVpbnQ2NF90IHU2NDsKdHlwZWRl
ZiB1aW50MzJfdCB1MzI7CgpzdGF0aWMgaW5saW5lIHZvaWQgY3B1X3JlbGF4KHZvaWQpCnsKCWFz
bSB2b2xhdGlsZSgicmVwOyBub3AiIDo6OiAibWVtb3J5Iik7Cn0KCnN0YXRpYyBpbmxpbmUgdTY0
IGNtcHhjaGc2NCh2b2xhdGlsZSB1NjQgKnB0ciwgdTY0IG9sZCwgdTY0IG5ldykKewoJdTY0IHBy
ZXY7Cglhc20gdm9sYXRpbGUoTE9DS19QUkVGSVggImNtcHhjaGc4YiAlMSIKCQkgICAgIDogIj1B
IiAocHJldiksCgkJICAgICAgICIrbSIgKCpwdHIpCgkJICAgICA6ICJiIiAoKHUzMiluZXcpLAoJ
CSAgICAgICAiYyIgKCh1MzIpKG5ldyA+PiAzMikpLAoJCSAgICAgICAiMCIgKG9sZCkKCQkgICAg
IDogIm1lbW9yeSIpOwoJcmV0dXJuIHByZXY7Cn0KCiNkZWZpbmUgQ01QWENIR19MT09QX09MRChD
T0RFLCBTVUNDRVNTKSBkbyB7CQkJCVwKCWludCByZXRyeSA9IDEwMDsJCQkJCQlcCglfX2FsaWdu
ZWRfdTY0IG9sZCA9ICpsb2NrcmVmOwkJCQkJXAoJd2hpbGUgKHQpIHsJCQkJCQkJXAoJCV9fYWxp
Z25lZF91NjQgbmV3ID0gb2xkLCBwcmV2ID0gb2xkOwkJCVwKCQlDT0RFCQkJCQkJCVwKCQlvbGQg
PSBjbXB4Y2hnNjQobG9ja3JlZiwgb2xkLCBuZXcpOwkJCVwKCQlpZiAobGlrZWx5KG9sZCA9PSBw
cmV2KSkgewkJCQlcCgkJCVNVQ0NFU1M7CQkJCQlcCgkJfQkJCQkJCQlcCgkJaWYgKCEtLXJldHJ5
KQkJCQkJCVwKCQkJYnJlYWs7CQkJCQkJXAoJCWNwdV9yZWxheCgpOwkJCQkJCVwKCX0JCQkJCQkJ
CVwKfSB3aGlsZSAoMCkKCnZvaWQgbG9ja3JlZl9nZXRfb2xkKHU2NCAqbG9ja3JlZiwgX0Jvb2wg
dCkKewoJQ01QWENIR19MT09QX09MRCgKCQluZXcrKzsKCSwKCQlyZXR1cm47CgkpOwp9CgojZGVm
aW5lIHRyeV9jbXB4Y2hnNjRfZmFsbGJhY2soX3B0ciwgX29sZHAsIF9uZXcpCVwKKHsgXAoJdHlw
ZW9mKCooX3B0cikpICpfX19vcCA9IChfb2xkcCksIF9fX28gPSAqX19fb3AsIF9fX3I7IFwKCV9f
X3IgPSBjbXB4Y2hnNjQoKF9wdHIpLCBfX19vLCAoX25ldykpOyBcCglpZiAodW5saWtlbHkoX19f
ciAhPSBfX19vKSkgXAoJCSpfX19vcCA9IF9fX3I7IFwKCWxpa2VseShfX19yID09IF9fX28pOyBc
Cn0pCgojZGVmaW5lIENNUFhDSEdfTE9PUF9GQUxMQkFDSyhDT0RFLCBTVUNDRVNTKSBkbyB7CQkJ
CVwKCWludCByZXRyeSA9IDEwMDsJCQkJCQkJXAoJX19hbGlnbmVkX3U2NCBvbGQgPSAqbG9ja3Jl
ZjsJCQkJCQlcCgl3aGlsZSAodCkgewkJCQkJCQkJXAoJCV9fYWxpZ25lZF91NjQgbmV3ID0gb2xk
OwkJCQkJXAoJCUNPREUJCQkJCQkJCVwKCQlpZiAobGlrZWx5KHRyeV9jbXB4Y2hnNjRfZmFsbGJh
Y2sobG9ja3JlZiwgJm9sZCwgbmV3KSkpIHsJXAoJCQlTVUNDRVNTOwkJCQkJCVwKCQl9CQkJCQkJ
CQlcCgkJaWYgKCEtLXJldHJ5KQkJCQkJCQlcCgkJCWJyZWFrOwkJCQkJCQlcCgkJY3B1X3JlbGF4
KCk7CQkJCQkJCVwKCX0JCQkJCQkJCQlcCn0gd2hpbGUgKDApCgp2b2lkIGxvY2tyZWZfZ2V0X2Zh
bGxiYWNrKHU2NCAqbG9ja3JlZiwgX0Jvb2wgdCkKewoJQ01QWENIR19MT09QX0ZBTExCQUNLKAoJ
CW5ldysrOwoJLAoJCXJldHVybjsKCSk7Cn0KCnN0YXRpYyBpbmxpbmUgX0Jvb2wgdHJ5X2NtcHhj
aGc2NCh2b2xhdGlsZSB1NjQgKnB0ciwgdTY0ICpwb2xkLCB1NjQgbmV3KQp7CglfQm9vbCBzdWNj
ZXNzOwoJdTY0IG9sZCA9ICpwb2xkOwoJYXNtIHZvbGF0aWxlKExPQ0tfUFJFRklYICJjbXB4Y2hn
OGIgJVtwdHJdIgoJCSAgICAgOiAiPUBjY3oiIChzdWNjZXNzKSwKCQkgICAgICAgW3B0cl0gIitt
IiAoKnB0ciksCgkJICAgICAgICIrQSIgKG9sZCkKCQkgICAgIDogImIiICgodTMyKW5ldyksCgkJ
ICAgICAgICJjIiAoKHUzMikobmV3ID4+IDMyKSkKCQkgICAgIDogIm1lbW9yeSIpOwoKCWlmICh1
bmxpa2VseSghc3VjY2VzcykpCgkJKnBvbGQgPSBvbGQ7CglyZXR1cm4gc3VjY2VzczsKfQoKI2Rl
ZmluZSBDTVBYQ0hHX0xPT1BfTkVXKENPREUsIFNVQ0NFU1MpIGRvIHsJCQkJXAoJaW50IHJldHJ5
ID0gMTAwOwkJCQkJCVwKCV9fYWxpZ25lZF91NjQgb2xkID0gKmxvY2tyZWY7CQkJCQlcCgl3aGls
ZSAodCkgewkJCQkJCQlcCgkJX19hbGlnbmVkX3U2NCBuZXcgPSBvbGQ7CQkJCVwKCQlDT0RFCQkJ
CQkJCVwKCQlpZiAobGlrZWx5KHRyeV9jbXB4Y2hnNjQobG9ja3JlZiwgJm9sZCwgbmV3KSkpIHsJ
XAoJCQlTVUNDRVNTOwkJCQkJXAoJCX0JCQkJCQkJXAoJCWlmICghLS1yZXRyeSkJCQkJCQlcCgkJ
CWJyZWFrOwkJCQkJCVwKCQljcHVfcmVsYXgoKTsJCQkJCQlcCgl9CQkJCQkJCQlcCn0gd2hpbGUg
KDApCgp2b2lkIGxvY2tyZWZfZ2V0X25ldyh1NjQgKmxvY2tyZWYsIF9Cb29sIHQpCnsKCUNNUFhD
SEdfTE9PUF9ORVcoCgkJbmV3Kys7CgksCgkJcmV0dXJuOwoJKTsKfQo=
--000000000000d7603a05dfe658c4--
