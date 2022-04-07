Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF214F850D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345751AbiDGQgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiDGQgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:36:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4136C149665
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:34:41 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p10so10536660lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 09:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WqSYvYqT9X7yl7ZC/HUz0PiEzpG5QLqTli54FTx6ff8=;
        b=VISbUvHKgYIYMdktxCNmaUwT2non27kUF+WrY38JwcTXfSXeQdPLofQgjH3Rwr5tRc
         +Yk1iX+AFfQxrdL4e5Hua6VSbyUpS7PJk4uUX+whiWwWgM3QLMhloC/Xg/+6jMlTorGT
         lZ67eIcRNucHnGqLoLhZTupsB9f+z7wUYuI/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WqSYvYqT9X7yl7ZC/HUz0PiEzpG5QLqTli54FTx6ff8=;
        b=ZRGSMaXhOkvMJVEqz5bWq+a8V3FGMpLslDSD4AU5BGsGHQug3xmIKAhIirTS5RqN2v
         T7YUDA06PGkKVMDRYOi5laGKDyuee5ozxDXmXjDUs25nGo3WDnc3ikhxTOF3N/fuxo+4
         SwiHFV2pA84N3m+Zw6035u/HBqSqaKPX+dsy9C4JgNjV7Z4gFIFkZkPOeDaOU+8/6PTQ
         XQlYnf8awKSh8/oR8D/mmUBb0v6ssLJBFAIamJIYqSqwY4fS8kBlgYXHJjVUfcTrlJun
         AMzIea+W8Pxg2Enbfp1fV+V1QcFMGPmY83ngBxUbmiURLbfDGxHELrkwPKhu8j677jVW
         MWug==
X-Gm-Message-State: AOAM531bkDcrsMX7j1/A9eu7M1GaxChxWnDRe506bmYibdZ7VS+d3jcc
        IxtrrZ3x8ajcsgdB+F2CecViOtO6KV9+3N70
X-Google-Smtp-Source: ABdhPJzxZSvS61Z2u3Ab4U5xhrUmmr/BqQBbAyGAk/2q5KydGR88JAYRPPWBOus8O6w7w+YVHvlMQw==
X-Received: by 2002:a05:6512:322f:b0:44a:57a0:6950 with SMTP id f15-20020a056512322f00b0044a57a06950mr9776528lfe.74.1649349279218;
        Thu, 07 Apr 2022 09:34:39 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id p14-20020a056512234e00b0044a54de0d1bsm2203847lfu.258.2022.04.07.09.34.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 09:34:38 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id p15so10595506lfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 09:34:38 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr9998758lfb.435.1649349277689; Thu, 07
 Apr 2022 09:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220407132839.496822-1-Jason@zx2c4.com>
In-Reply-To: <20220407132839.496822-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Apr 2022 06:34:21 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjrx=xHFfyNt6bU3=xTkdxr3QwuPA-_A0-HKZmoZwWeiw@mail.gmail.com>
Message-ID: <CAHk-=wjrx=xHFfyNt6bU3=xTkdxr3QwuPA-_A0-HKZmoZwWeiw@mail.gmail.com>
Subject: Re: [GIT PULL] random number generator fixes for 5.18-rc2
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000cf024a05dc130d25"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000cf024a05dc130d25
Content-Type: text/plain; charset="UTF-8"

On Thu, Apr 7, 2022 at 3:29 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> - In order to be more like other devices (e.g. /dev/zero) and to mitigate the
>   impact of fixing the above bug, which has been around forever (users have
>   never really needed to check the return value of read() for medium-sized
>   reads and so perhaps many didn't), we now move signal checking to the bottom
>   part of the loop, and do so every PAGE_SIZE-bytes.

Ugh. After fixing a bug where the signal pending state isn't checked
enough, you then go to extra effort to not do it too much.

The whole historical "give at least 256 bytes without even checking
for signal_pending" is also cryptographically entirely bogus, since we
only actually have CHACHA_BLOCK_SIZE worth of random state

So if some program doesn't check for short reads, the difference
between one chacha block and 256 bytes (or PAGE_SIZE like you changed
it to) really *really* doesn't matter, the rest is going to be purely
filler anyway. Nice good filler, but still..

Also, if you hit a EFAULT, you should still return the partial result
you got before to be consistent with what we normally do in these
kinds of situations.

So I think we could just drop all these games, and make the code
simple and streamlined?

Attached patch not committed, only for "why not just stop the silly
games" comments..

                Linus

--000000000000cf024a05dc130d25
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l1p7ykhw0>
X-Attachment-Id: f_l1p7ykhw0

IGRyaXZlcnMvY2hhci9yYW5kb20uYyB8IDIzICsrKysrKysrKystLS0tLS0tLS0tLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9jaGFyL3JhbmRvbS5jIGIvZHJpdmVycy9jaGFyL3JhbmRvbS5jCmluZGV4IGUx
NTA2M2Q2MTQ2MC4uMzJjM2QxZGRlMTZmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvcmFuZG9t
LmMKKysrIGIvZHJpdmVycy9jaGFyL3JhbmRvbS5jCkBAIC01NDcsMzMgKzU0NywzMCBAQCBzdGF0
aWMgc3NpemVfdCBnZXRfcmFuZG9tX2J5dGVzX3VzZXIodm9pZCBfX3VzZXIgKmJ1Ziwgc2l6ZV90
IG5ieXRlcykKIAkJZ290byBvdXRfemVyb19jaGFjaGE7CiAJfQogCi0JZG8geworCWZvciAoOzsp
IHsKIAkJY2hhY2hhMjBfYmxvY2soY2hhY2hhX3N0YXRlLCBvdXRwdXQpOwogCQlpZiAodW5saWtl
bHkoY2hhY2hhX3N0YXRlWzEyXSA9PSAwKSkKIAkJCSsrY2hhY2hhX3N0YXRlWzEzXTsKIAogCQls
ZW4gPSBtaW5fdChzaXplX3QsIG5ieXRlcywgQ0hBQ0hBX0JMT0NLX1NJWkUpOwotCQlpZiAoY29w
eV90b191c2VyKGJ1Ziwgb3V0cHV0LCBsZW4pKSB7Ci0JCQlyZXQgPSAtRUZBVUxUOworCQlpZiAo
Y29weV90b191c2VyKGJ1Ziwgb3V0cHV0LCBsZW4pKQogCQkJYnJlYWs7Ci0JCX0KIAotCQluYnl0
ZXMgLT0gbGVuOwogCQlidWYgKz0gbGVuOwogCQlyZXQgKz0gbGVuOworCQluYnl0ZXMgLT0gbGVu
OworCQlpZiAoIW5ieXRlcykKKwkJCWJyZWFrOwogCi0JCUJVSUxEX0JVR19PTihQQUdFX1NJWkUg
JSBDSEFDSEFfQkxPQ0tfU0laRSAhPSAwKTsKLQkJaWYgKCEocmV0ICUgUEFHRV9TSVpFKSAmJiBu
Ynl0ZXMpIHsKLQkJCWlmIChzaWduYWxfcGVuZGluZyhjdXJyZW50KSkKLQkJCQlicmVhazsKLQkJ
CWNvbmRfcmVzY2hlZCgpOwotCQl9Ci0JfSB3aGlsZSAobmJ5dGVzKTsKKwkJaWYgKHNpZ25hbF9w
ZW5kaW5nKGN1cnJlbnQpKQorCQkJYnJlYWs7CisJCWNvbmRfcmVzY2hlZCgpOworCX0KIAogCW1l
bXplcm9fZXhwbGljaXQob3V0cHV0LCBzaXplb2Yob3V0cHV0KSk7CiBvdXRfemVyb19jaGFjaGE6
CiAJbWVtemVyb19leHBsaWNpdChjaGFjaGFfc3RhdGUsIHNpemVvZihjaGFjaGFfc3RhdGUpKTsK
LQlyZXR1cm4gcmV0OworCXJldHVybiByZXQgPyByZXQgOiAtRUZBVUxUOwogfQogCiAvKgo=
--000000000000cf024a05dc130d25--
