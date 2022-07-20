Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC7E57BDFB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiGTSoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiGTSoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:44:02 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8419C6FA23
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:44:00 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z22so11923395edd.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AbSYYz+xofSKkd5p4f8z6hp6elD6pZXuPLrhueoMzGU=;
        b=eSbZVkC2Qst7FUwMpK57N8vIZ1zsHyvs2ve3BykOCe6whnXPKiuQPOUVpomR59Vxpq
         R6/EDujxB5tszpUHKyMyxK+wavy19Vm+g3/TqA3NvJFyOxRTaXBF4Ted3Yfu85MFtFcN
         2sn/yAFKrF6kGdpg226Un6v/2a/Qc5xGkpd7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AbSYYz+xofSKkd5p4f8z6hp6elD6pZXuPLrhueoMzGU=;
        b=xtZjxMTHwrDBX4V0iH9sh6X4/ROKUpDdi7rp6Qk8fXT0VcdTjVfED8Nsng6YWiyclU
         bXuvgzb772ophRyXPxj1oSK+nzAHysmR2FtZZSeOPPrA36luMfKnWdhgsYpp/tq2iXH8
         3+2VbBnLztGSRSmcFNjOJGPyYD96pTavhoRjG+Wyal2v0dPWc4BjcXq9D+bQ1yImJuPX
         tMGJI383KksfbHknZgg47KrkD2aGPniwCujIDG99cKMd2Ak8lBZTzkTtUMxE6K/Ecuqq
         Hd04DopvcHKIGuvbsLr1kwRt+GarNKxVhSRdkjN6+9BGvXTI2BhgXLMiJwMzsasOa3xu
         o8sw==
X-Gm-Message-State: AJIora8hcFAe1fxakNJKVrSIutJIUEjT0Mv8vjHTcVKv5xGujub5myBJ
        9T4HxlCneTdi9GDoKg//ygrDVHgstWl5zKfCR/w=
X-Google-Smtp-Source: AGRyM1vNIZFF2nSO+z/y9PCjI+K04BnlmaL/s4k4Z6WdwZcuavxDUzMPWJYLfukUm7QYW+JUyjrlBg==
X-Received: by 2002:a05:6402:3301:b0:43a:9ad4:633 with SMTP id e1-20020a056402330100b0043a9ad40633mr54704350eda.261.1658342638852;
        Wed, 20 Jul 2022 11:43:58 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id gv21-20020a1709072bd500b00706242d297fsm8170882ejc.212.2022.07.20.11.43.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 11:43:55 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id i132-20020a1c3b8a000000b003a2fa488efdso1912954wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:43:54 -0700 (PDT)
X-Received: by 2002:a05:600c:2211:b0:3a3:2149:88e1 with SMTP id
 z17-20020a05600c221100b003a3214988e1mr5119603wml.8.1658342633852; Wed, 20 Jul
 2022 11:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220716230344.239749011@linutronix.de> <20220720125736.48164a14@gandalf.local.home>
 <CAHk-=wh=Yjy=DmGzzGj-ivyx_w45AHh35eDkpGtajaiO+TX38A@mail.gmail.com>
 <Ytg6UD+0F6zv981o@worktop.programming.kicks-ass.net> <20220720135016.3178ffc6@gandalf.local.home>
 <CAHk-=wjdQbdQGKkQxxEcWoUp4SRmBWm=3bS20SbaVe8cLgKLgg@mail.gmail.com> <20220720143147.4d8a2f8d@gandalf.local.home>
In-Reply-To: <20220720143147.4d8a2f8d@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jul 2022 11:43:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjinvfNvp9kQBgiaON1HJtmnfmytruRGR5WmkM4m+ZRVg@mail.gmail.com>
Message-ID: <CAHk-=wjinvfNvp9kQBgiaON1HJtmnfmytruRGR5WmkM4m+ZRVg@mail.gmail.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: multipart/mixed; boundary="0000000000009ba6a405e440fbd1"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000009ba6a405e440fbd1
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 20, 2022 at 11:31 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Thus, is there a way to keep this file from being entered into the
> return_sites section?

I think the whole concept is broken.

Testing known-broken code on the expectation that "this won't work
anyway, so we can jump off to code that is broken" is not acceptable.

*If* the test were to fail, it would start executing random code that
hasn't been relocated or fixed up properly.

So I think the whole concept is broken. It relies on the compiler
generating code that can work in a read-only data section, and it's
not clear that that is even physically possible (ie the data section
might be far enough away from a code section that any relocation just
fundamentally cannot happen).

I think it worked purely by mistake, because the code was simple
enough that it didn't need any relocation at all before. But even
without RETHUNK, that was never guaranteed, because any random tracing
or debug code or whatever could have made even that empty function
have code in it that just fundamentally wouldn't work in a non-text
section.

So honestly, I think that test should be removed as a "we used this,
it happened to work almost by mistake, but it doesn't work any more
and it is unfixably broken".

Maybe somebody can come up with an entirely different way to do that
test that isn't so broken, but if so, I think it's going to be using
some other machinery (eg bpf and explicitly marking it read-only and
non-executable), and removing this broken model is the right thing
regardless.

So unless somebody has some one-liner workaround, I really suspect the
fix is to remove all this. The amount of hackery to make it work in
the first place is kind of disgusting anyway.

Since this was a WARN_ONCE(), can you make sure that with this case
removed, nothing else triggers?

                Linus

--0000000000009ba6a405e440fbd1
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l5tyd4vd0>
X-Attachment-Id: f_l5tyd4vd0

IGRyaXZlcnMvbWlzYy9sa2R0bS9NYWtlZmlsZSB8IDExIC0tLS0tLS0tLS0tCiBkcml2ZXJzL21p
c2MvbGtkdG0vbGtkdG0uaCAgfCAgMyAtLS0KIGRyaXZlcnMvbWlzYy9sa2R0bS9wZXJtcy5jICB8
ICA3IC0tLS0tLS0KIGRyaXZlcnMvbWlzYy9sa2R0bS9yb2RhdGEuYyB8IDExIC0tLS0tLS0tLS0t
CiA0IGZpbGVzIGNoYW5nZWQsIDMyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bWlzYy9sa2R0bS9NYWtlZmlsZSBiL2RyaXZlcnMvbWlzYy9sa2R0bS9NYWtlZmlsZQppbmRleCAy
ZTBhYTc0YWMxODUuLjRmMTA1OWYwY2FlOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9taXNjL2xrZHRt
L01ha2VmaWxlCisrKyBiL2RyaXZlcnMvbWlzYy9sa2R0bS9NYWtlZmlsZQpAQCAtNiwyMSArNiwx
MCBAQCBsa2R0bS0kKENPTkZJR19MS0RUTSkJCSs9IGJ1Z3MubwogbGtkdG0tJChDT05GSUdfTEtE
VE0pCQkrPSBoZWFwLm8KIGxrZHRtLSQoQ09ORklHX0xLRFRNKQkJKz0gcGVybXMubwogbGtkdG0t
JChDT05GSUdfTEtEVE0pCQkrPSByZWZjb3VudC5vCi1sa2R0bS0kKENPTkZJR19MS0RUTSkJCSs9
IHJvZGF0YV9vYmpjb3B5Lm8KIGxrZHRtLSQoQ09ORklHX0xLRFRNKQkJKz0gdXNlcmNvcHkubwog
bGtkdG0tJChDT05GSUdfTEtEVE0pCQkrPSBzdGFja2xlYWsubwogbGtkdG0tJChDT05GSUdfTEtE
VE0pCQkrPSBjZmkubwogbGtkdG0tJChDT05GSUdfTEtEVE0pCQkrPSBmb3J0aWZ5Lm8KIGxrZHRt
LSQoQ09ORklHX1BQQ182NFNfSEFTSF9NTVUpCSs9IHBvd2VycGMubwogCi1LQVNBTl9TQU5JVEla
RV9yb2RhdGEubwkJOj0gbgogS0FTQU5fU0FOSVRJWkVfc3RhY2tsZWFrLm8JOj0gbgotS0NPVl9J
TlNUUlVNRU5UX3JvZGF0YS5vCTo9IG4KLUNGTEFHU19SRU1PVkVfcm9kYXRhLm8JCSs9ICQoQ0Nf
RkxBR1NfTFRPKQotCi1PQkpDT1BZRkxBR1MgOj0KLU9CSkNPUFlGTEFHU19yb2RhdGFfb2JqY29w
eS5vCTo9IFwKLQkJCS0tcmVuYW1lLXNlY3Rpb24gLm5vaW5zdHIudGV4dD0ucm9kYXRhLGFsbG9j
LHJlYWRvbmx5LGxvYWQsY29udGVudHMKLXRhcmdldHMgKz0gcm9kYXRhLm8gcm9kYXRhX29iamNv
cHkubwotJChvYmopL3JvZGF0YV9vYmpjb3B5Lm86ICQob2JqKS9yb2RhdGEubyBGT1JDRQotCSQo
Y2FsbCBpZl9jaGFuZ2VkLG9iamNvcHkpCmRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvbGtkdG0v
bGtkdG0uaCBiL2RyaXZlcnMvbWlzYy9sa2R0bS9sa2R0bS5oCmluZGV4IDAxNWUwNDg0MDI2Yi4u
ZTU4ZjY5MDc3ZmNkIDEwMDY0NAotLS0gYS9kcml2ZXJzL21pc2MvbGtkdG0vbGtkdG0uaAorKysg
Yi9kcml2ZXJzL21pc2MvbGtkdG0vbGtkdG0uaApAQCAtOTQsNyArOTQsNCBAQCB2b2lkIF9faW5p
dCBsa2R0bV9wZXJtc19pbml0KHZvaWQpOwogdm9pZCBfX2luaXQgbGtkdG1fdXNlcmNvcHlfaW5p
dCh2b2lkKTsKIHZvaWQgX19leGl0IGxrZHRtX3VzZXJjb3B5X2V4aXQodm9pZCk7CiAKLS8qIFNw
ZWNpYWwgZGVjbGFyYXRpb24gZm9yIGZ1bmN0aW9uLWluLXJvZGF0YS4gKi8KLXZvaWQgbGtkdG1f
cm9kYXRhX2RvX25vdGhpbmcodm9pZCk7Ci0KICNlbmRpZgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
aXNjL2xrZHRtL3Blcm1zLmMgYi9kcml2ZXJzL21pc2MvbGtkdG0vcGVybXMuYwppbmRleCBiOTM0
MDRkNjU2NTAuLmQxYTY5ZWY4NjVjMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9taXNjL2xrZHRtL3Bl
cm1zLmMKKysrIGIvZHJpdmVycy9taXNjL2xrZHRtL3Blcm1zLmMKQEAgLTE5MSwxMiArMTkxLDYg
QEAgc3RhdGljIHZvaWQgbGtkdG1fRVhFQ19WTUFMTE9DKHZvaWQpCiAJdmZyZWUodm1hbGxvY19h
cmVhKTsKIH0KIAotc3RhdGljIHZvaWQgbGtkdG1fRVhFQ19ST0RBVEEodm9pZCkKLXsKLQlleGVj
dXRlX2xvY2F0aW9uKGRlcmVmZXJlbmNlX2Z1bmN0aW9uX2Rlc2NyaXB0b3IobGtkdG1fcm9kYXRh
X2RvX25vdGhpbmcpLAotCQkJIENPREVfQVNfSVMpOwotfQotCiBzdGF0aWMgdm9pZCBsa2R0bV9F
WEVDX1VTRVJTUEFDRSh2b2lkKQogewogCXVuc2lnbmVkIGxvbmcgdXNlcl9hZGRyOwpAQCAtMjgw
LDcgKzI3NCw2IEBAIHN0YXRpYyBzdHJ1Y3QgY3Jhc2h0eXBlIGNyYXNodHlwZXNbXSA9IHsKIAlD
UkFTSFRZUEUoRVhFQ19TVEFDSyksCiAJQ1JBU0hUWVBFKEVYRUNfS01BTExPQyksCiAJQ1JBU0hU
WVBFKEVYRUNfVk1BTExPQyksCi0JQ1JBU0hUWVBFKEVYRUNfUk9EQVRBKSwKIAlDUkFTSFRZUEUo
RVhFQ19VU0VSU1BBQ0UpLAogCUNSQVNIVFlQRShFWEVDX05VTEwpLAogCUNSQVNIVFlQRShBQ0NF
U1NfVVNFUlNQQUNFKSwKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9sa2R0bS9yb2RhdGEuYyBi
L2RyaXZlcnMvbWlzYy9sa2R0bS9yb2RhdGEuYwpkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQKaW5k
ZXggYmFhY2I4NzZkMWQ5Li4wMDAwMDAwMDAwMDAKLS0tIGEvZHJpdmVycy9taXNjL2xrZHRtL3Jv
ZGF0YS5jCisrKyAvZGV2L251bGwKQEAgLTEsMTEgKzAsMCBAQAotLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAKLS8qCi0gKiBUaGlzIGluY2x1ZGVzIGZ1bmN0aW9ucyB0aGF0IGFy
ZSBtZWFudCB0byBsaXZlIGVudGlyZWx5IGluIC5yb2RhdGEKLSAqICh2aWEgb2JqY29weSB0cmlj
a3MpLCB0byB2YWxpZGF0ZSB0aGUgbm9uLWV4ZWN1dGFiaWxpdHkgb2YgLnJvZGF0YS4KLSAqLwot
I2luY2x1ZGUgImxrZHRtLmgiCi0KLXZvaWQgbm9pbnN0ciBsa2R0bV9yb2RhdGFfZG9fbm90aGlu
Zyh2b2lkKQotewotCS8qIERvZXMgbm90aGluZy4gV2UganVzdCB3YW50IGFuIGFyY2hpdGVjdHVy
ZSBhZ25vc3RpYyAicmV0dXJuIi4gKi8KLX0K
--0000000000009ba6a405e440fbd1--
