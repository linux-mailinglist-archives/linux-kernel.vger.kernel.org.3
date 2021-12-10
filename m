Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88074708E5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbhLJShl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236371AbhLJShi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:37:38 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A44FC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 10:34:03 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l25so33069824eda.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 10:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ilVDqdbUBCf221go2ceZATx/u5PLd2j7p3PLuOom2Xs=;
        b=hh/5WijI/KIj86N+SBkOQn2I+YRA2z83MqWjlXHXaKRldKFjYSbWt217XT844hOmUj
         tzFKyg/wWV0gyUSx1JyaPC9apCz2CI9yiejmp1fpRc05cN5/D124hIdhsMiVhtKDyXuS
         9dbHI73UbObbGFS4qnmLvsvZiVUSUDNGOxs3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilVDqdbUBCf221go2ceZATx/u5PLd2j7p3PLuOom2Xs=;
        b=2RPFUN8YQJRYFJAeoKNwc2bVtGMny6A7E0gJs72TPJPRvWGGkSv3sqRHx60nRyP9aj
         jqU15m8WZccEzjpfYEHZbz3EuzkLhbJT6qsO1gSdmp5ilEpPnGGBKOO4dUItPI1sj0Ep
         Dkj5/VVNZqA7Aj/kTh6H8wxtd4jzkJJewbNPHYxvGUFaWu55suOnmnLJBrwC3bUPbeVn
         JXeuIm4U3Bvmz1Y8aeEwKGqfmesxYwCpyU0iTD2pkaX7FPdi1aHzUEwd/YlZ8b+IvfS2
         QKjnNazVlQCA4v6LoRqdq82b+3/MSfYpYsAcTrgk3S2SJsWQ8HPv+m9q3mCcmMOiS8yV
         Q33w==
X-Gm-Message-State: AOAM531Ssn0HxdQ+ameVEAVREDwD4iNG1P3J8vmb07lIlYCdLoXa9/8Q
        5AgjFFx7JFOyksvahKm4398lymFmq+GFljX8QEc=
X-Google-Smtp-Source: ABdhPJy9MtIv14lBEt4MsAkIjLK9/cArHR6KBJ8owbuFuPHaijxceZEJauhg33kWBKu3FDWtw6cSvg==
X-Received: by 2002:a05:6402:274c:: with SMTP id z12mr42329668edd.294.1639161241492;
        Fri, 10 Dec 2021 10:34:01 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id w5sm1969135edc.58.2021.12.10.10.33.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 10:34:00 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso7702187wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 10:33:59 -0800 (PST)
X-Received: by 2002:a05:600c:1d97:: with SMTP id p23mr18581622wms.144.1639161239390;
 Fri, 10 Dec 2021 10:33:59 -0800 (PST)
MIME-Version: 1.0
References: <20211210053743.GA36420@xsang-OptiPlex-9020>
In-Reply-To: <20211210053743.GA36420@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Dec 2021 10:33:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgxd2DqzM3PAsFmzJDHFggxg7ODTQxfJoGCRDbjgMm8nA@mail.gmail.com>
Message-ID: <CAHk-=wgxd2DqzM3PAsFmzJDHFggxg7ODTQxfJoGCRDbjgMm8nA@mail.gmail.com>
Subject: Re: [fget] 054aa8d439: will-it-scale.per_thread_ops -5.7% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Jann Horn <jannh@google.com>, Miklos Szeredi <mszeredi@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        fengwei.yin@intel.com
Content-Type: multipart/mixed; boundary="00000000000067829105d2cef759"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000067829105d2cef759
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 9, 2021 at 9:38 PM kernel test robot <oliver.sang@intel.com> wr=
ote:
>
> FYI, we noticed a -5.7% regression of will-it-scale.per_thread_ops due to=
 commit:
> 054aa8d439b9  ("fget: check that the fd still exists after getting a ref =
to it")

Well, some downside of the new checks was expected, that's just much
more than I really like or would have thought.

But it's exactly where you'd expect:

>      27.16 =C2=B1 10%      +4.3       31.51 =C2=B1  2%  perf-profile.call=
trace.cycles-pp.__fget_light.do_sys_poll.__x64_sys_poll.do_syscall_64.entry=
_SYSCALL_64_after_hwframe
>      22.91 =C2=B1 10%      +4.4       27.34 =C2=B1  2%  perf-profile.call=
trace.cycles-pp.__fget_files.__fget_light.do_sys_poll.__x64_sys_poll.do_sys=
call_64
>      26.33 =C2=B1 10%      +4.4       30.70 =C2=B1  2%  perf-profile.chil=
dren.cycles-pp.__fget_light
>      22.92 =C2=B1 10%      +4.4       27.35 =C2=B1  2%  perf-profile.chil=
dren.cycles-pp.__fget_files
>      22.70 =C2=B1 10%      +4.4       27.11 =C2=B1  2%  perf-profile.self=
.cycles-pp.__fget_files

although there's odd spikes in dTLB-loads etc.

I checked whether it's some unexpected code generation issue, but the
new "re-check file table after refcount update" really looks very
cheap when I look at what gcc generates, there's nothing really
unexpected there.

What did change was:

 (a) some branches go other ways, which might well affect branch
prediction and just be unlucky. It might be that just marking the
mismatch case "unlikely()" will help.

 (b) the obvious few new instructions (re-load and check file table
pointer, re-load and check file pointer)

 (c) that __fget_files() function is now no longer a leaf function in
a simple config case, since it calls "fput_many" in the error case.

And that (c) is worth mentioning simply because it means that the
function goes from not having any stack frame at all, to having to
save/restore four registers. So now it has the usual push/pop
sequences.

It may also be that the test-case actually does a lot of threaded
open/close/poll, and either actually triggers the re-lookup looping
case (unlikely) or just sees a lot of cacheline bouncing that now got
worse due to the re-check of the file pointer.

So this regression looks real, and the issue seems to be that
__fget_files() really is _that_ important for this do_sys_poll()
benchmark, and even just the handful of extra instructions end up
being meaningful.

Oliver - I'm attaching the obvious "unlikely9)" oneliner in case it's
just "gcc thought the retry loop was the common case" issue and bad
branch prediction.

And it would perhaps be interesting to get an actual instruction-level
profile of that __fget_files() thing for that benchmark, if that
pinpoints exactly what is going on and in case that would be easy to
get on that machine.

Because it might just be truly horrendously bad luck, with the 32-byte
stack frame meaning that the kernel stack goes one more page down
(just jhandwaving from the dTLB number spike), and this all being just
random bad luck on that particular benchmark.

Of course, the thing about poll() is that for that case, we *don't*
really need the "re-check the file descriptor" code at all, since the
resulting fd isn't going to be installed as a new fd, and it doesn't
matter for the socket garbage collector logic.

So maybe it was a mistake to put that re-check in the generic fdget()
code - yes, it should be cheap, but it's also some of the most hot
code in the kernel on some loads.

But if we move it elsewhere, we'd need to come up with some list of
"these cases need it". Some are obvious: dup, dup2, unix domain file
passing. It's the non-obvious ones I'd worry about.

Anybody?

              Linus

--00000000000067829105d2cef759
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kx0q7ovl0>
X-Attachment-Id: f_kx0q7ovl0

IGZzL2ZpbGUuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL2ZpbGUuYyBiL2ZzL2ZpbGUuYwppbmRleCBhZDRhOGJm
M2NmMTAuLmY4MDIzNjBlMjQwZCAxMDA2NDQKLS0tIGEvZnMvZmlsZS5jCisrKyBiL2ZzL2ZpbGUu
YwpAQCAtODU4LDcgKzg1OCw3IEBAIHN0YXRpYyBzdHJ1Y3QgZmlsZSAqX19mZ2V0X2ZpbGVzKHN0
cnVjdCBmaWxlc19zdHJ1Y3QgKmZpbGVzLCB1bnNpZ25lZCBpbnQgZmQsCiAJCQlmaWxlID0gTlVM
TDsKIAkJZWxzZSBpZiAoIWdldF9maWxlX3JjdV9tYW55KGZpbGUsIHJlZnMpKQogCQkJZ290byBs
b29wOwotCQllbHNlIGlmIChmaWxlc19sb29rdXBfZmRfcmF3KGZpbGVzLCBmZCkgIT0gZmlsZSkg
eworCQllbHNlIGlmICh1bmxpa2VseShmaWxlc19sb29rdXBfZmRfcmF3KGZpbGVzLCBmZCkgIT0g
ZmlsZSkpIHsKIAkJCWZwdXRfbWFueShmaWxlLCByZWZzKTsKIAkJCWdvdG8gbG9vcDsKIAkJfQo=
--00000000000067829105d2cef759--
