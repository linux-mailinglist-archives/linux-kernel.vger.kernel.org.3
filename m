Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9999548BC1E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347480AbiALBC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347471AbiALBCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:02:25 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12E7C061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:02:24 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b13so3560978edn.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8B3i53DIdCTHTAdYfwnz50NvQALzLxzsVidL1FhgLmU=;
        b=EK2SOb9OHyWt1jhh6mIsGgGLfUAui3x/k9CyoYVtZx2QneH12+Panh3HzF/TVB86f8
         wUpjBoOMjRf5CEDgDLKWWcLUP6atsZgXaF5T+d2YAvKFTRidIO9aIKvR0tLBo2PKweBS
         p03XKqx39KzXBaF1qGeEZhIjqCP93ZQef7Rws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8B3i53DIdCTHTAdYfwnz50NvQALzLxzsVidL1FhgLmU=;
        b=4akado12seEzmuIY/L6pLUJVWHSMvWthjDbWEH+O23eFzh8/FKfOPKjZwviXaXyPfd
         YG8sPkSosN6wlYAD+cnk7l33VzF7od0bsYlrkuYOQwEp/6CP8/aCTg4zSOG7JvdHAr4Q
         iVDZHSUqkOX+Mbpq1BWb3118QQNYOqmOdaO0E2A19nZ8jL1TnmgAv9MEetHOjpXkDB+N
         Qcqwn+tdO5uB1faQPETac9xmYujK81wBU1ichSxAax36aE5MIjgTJpzOKvLnXPLGmlbe
         93j2ktDVdFQKWKVVZaK36uGYCRSa8MLiTr41EFlTjS/IW+jYmIggYScUaQ2pysNRxmXU
         zM8w==
X-Gm-Message-State: AOAM531QiupVoGqmV0EXds5194Fnc7wUtPBb7bagAUNtLq0CBB5/diwE
        BNyTD5bdxclvb1xQQ6YoECU7eSeMzwSxSOjGeV4=
X-Google-Smtp-Source: ABdhPJw7ojzMji5Z7iSoHjTZNAAQa4gUMNPi6z9L0YtRd6gckraOhYreLi30w3vRNvsGGQbXzppDYg==
X-Received: by 2002:a05:6402:84e:: with SMTP id b14mr6570974edz.200.1641949343091;
        Tue, 11 Jan 2022 17:02:23 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id b15sm273596edd.91.2022.01.11.17.02.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 17:02:22 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id o3so1306439wrh.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:02:22 -0800 (PST)
X-Received: by 2002:a5d:6951:: with SMTP id r17mr5665842wrw.274.1641949341987;
 Tue, 11 Jan 2022 17:02:21 -0800 (PST)
MIME-Version: 1.0
References: <20220111191456.GA11976@embeddedor>
In-Reply-To: <20220111191456.GA11976@embeddedor>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jan 2022 17:02:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjh5NjGvRm357n-v6wWU6J920hB4iG+nCtOHz2Qbs=p5A@mail.gmail.com>
Message-ID: <CAHk-=wjh5NjGvRm357n-v6wWU6J920hB4iG+nCtOHz2Qbs=p5A@mail.gmail.com>
Subject: Re: [GIT PULL] fallthrough fixes for Clang for 5.17-rc1
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000044e56705d5581f70"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000044e56705d5581f70
Content-Type: text/plain; charset="UTF-8"

On Tue, Jan 11, 2022 at 11:08 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Please, pull the following patches that fix some fall-through warnings
> when building with Clang and -Wimplicit-fallthrough.

Ugh. I started pulling that, and then I actually looked at this one:

> Gustavo A. R. Silva (1):
>       MIPS: mm: tlbex: Fix fall-through warning for Clang

and that's just too ugly to live.

It was ugly before, but now it's just insane.

It literally has an if-statement with a block statement that contains
other cases.

Fine, that's not illegal, and Duff's device made the model famous.

But in this case, there's no actual _reason_ for it. It literally
looks like a mistake to me.

There's no reason to have that block statement in the first place, and
there's *doubly* no reason to add a "fallthrough" to other case
statements that then just do a "break" anyway.

I notice that we actually had that exact same pattern earlier, see
line 2166 in that same line. And it's equally bogus there. Actually,
it's even more bogus there, because the indentation is wrong too!

So I _think_ that patch should do something like the attached, but I
didn't actually test this in any way (I didn't check my mips
cross-build setup), and this is all so ugly that I have to avert my
eyes to even attach that patch to this email.

I also don't understand why it's doing that 'switch ()' on the
current_cpu_type(), only to avoid the 'cpu_has_mips_r2_exec_hazard'
test, Which is just _another_ switch on current_cpu_type().

All this code is completely incomprehensibly oddly written. It looks
like some kind of cut-and-paste thing with no actual understanding of
the code. And I refuse to make it worse than it already is by adding
even *more* mindless blather to it.

               Linus

--00000000000044e56705d5581f70
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kyau8cz60>
X-Attachment-Id: f_kyau8cz60

IGFyY2gvbWlwcy9tbS90bGJleC5jIHwgMTMgKysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL21pcHMv
bW0vdGxiZXguYyBiL2FyY2gvbWlwcy9tbS90bGJleC5jCmluZGV4IGIxMzFlNmE3NzM4My4uNzRm
NTU3ZWQ1MGIwIDEwMDY0NAotLS0gYS9hcmNoL21pcHMvbW0vdGxiZXguYworKysgYi9hcmNoL21p
cHMvbW0vdGxiZXguYwpAQCAtMjE2MSwxNSArMjE2MSwxNCBAQCBzdGF0aWMgdm9pZCBidWlsZF9y
NDAwMF90bGJfbG9hZF9oYW5kbGVyKHZvaWQpCiAKIAkJc3dpdGNoIChjdXJyZW50X2NwdV90eXBl
KCkpIHsKIAkJZGVmYXVsdDoKLQkJCWlmIChjcHVfaGFzX21pcHNfcjJfZXhlY19oYXphcmQpIHsK
KwkJCWlmIChjcHVfaGFzX21pcHNfcjJfZXhlY19oYXphcmQpCiAJCQkJdWFzbV9pX2VoYigmcCk7
Ci0JCQlmYWxsdGhyb3VnaDsKKwkJCWJyZWFrOwogCiAJCWNhc2UgQ1BVX0NBVklVTV9PQ1RFT046
CiAJCWNhc2UgQ1BVX0NBVklVTV9PQ1RFT05fUExVUzoKIAkJY2FzZSBDUFVfQ0FWSVVNX09DVEVP
TjI6Ci0JCQkJYnJlYWs7Ci0JCQl9CisJCQlicmVhazsKIAkJfQogCiAJCS8qIEV4YW1pbmUgIGVu
dHJ5bG8gMCBvciAxIGJhc2VkIG9uIHB0ci4gKi8KQEAgLTIyMzcsMTQgKzIyMzYsMTQgQEAgc3Rh
dGljIHZvaWQgYnVpbGRfcjQwMDBfdGxiX2xvYWRfaGFuZGxlcih2b2lkKQogCiAJCXN3aXRjaCAo
Y3VycmVudF9jcHVfdHlwZSgpKSB7CiAJCWRlZmF1bHQ6Ci0JCQlpZiAoY3B1X2hhc19taXBzX3Iy
X2V4ZWNfaGF6YXJkKSB7CisJCQlpZiAoY3B1X2hhc19taXBzX3IyX2V4ZWNfaGF6YXJkKQogCQkJ
CXVhc21faV9laGIoJnApOworCQkJYnJlYWs7CiAKIAkJY2FzZSBDUFVfQ0FWSVVNX09DVEVPTjoK
IAkJY2FzZSBDUFVfQ0FWSVVNX09DVEVPTl9QTFVTOgogCQljYXNlIENQVV9DQVZJVU1fT0NURU9O
MjoKLQkJCQlicmVhazsKLQkJCX0KKwkJCWJyZWFrOwogCQl9CiAKIAkJLyogRXhhbWluZSAgZW50
cnlsbyAwIG9yIDEgYmFzZWQgb24gcHRyLiAqLwo=
--00000000000044e56705d5581f70--
