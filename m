Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C0A4E6C37
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357479AbiCYBrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357656AbiCYBr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:47:29 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D159D4E0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 18:44:32 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2e6650cde1bso68845367b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 18:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6C1MiK2JBH1dTA/prMrmf+ttqe2Acvbmx0mhdpvszJ8=;
        b=qDnVP63bmla7Or6NurBxPJNTEhoxKm9iNRNnN+VkXopisHaUnwNODLhCLXI78xhN17
         Se4VSoarjGMh5dIjpAYb/qeQdvR/h0YD/T0ad9o+DeuzscOiHFnBHwrPhSziFcLVA7pF
         qYfaenDvXDZzO47+2ebGuLOHMymLN4rm3ECK6wQoXz48V9kQusQczwKa0jZ4LNRBZ1oV
         fluHVr3rz5LG4UmUU9zxnyBLjA0aBziq1xAQXYZpJpDm/K0YVax48CETR1j7n6jWfZpu
         jil0lKeiD4KRrAbyO+kofxpZE5XlxHBzTkuoZIm3g0NuDQHUaEssG3UEtq3Ma/J7ThJY
         xBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6C1MiK2JBH1dTA/prMrmf+ttqe2Acvbmx0mhdpvszJ8=;
        b=Dl/d6X1H7DfTT7oqDJICjLdaaZNNq4D5ytMMJW/eQztyk4LrwKyUkC9EJUC/sVjIcA
         Ul7fnHgoD8md+ZlH8ya/5fm629dGdFcPjBkAsZHekp2O8Qgtad5Tg5ighUZyAxi4hSZI
         3PY283lF6nRQu/7EAXxqEt2r3ZfsJ5G3aeXP5ZyRmGUqJz6BQfZij9DKCQVh93uG1jnu
         WQvtdJ5c6VUnGREVgzfFjRv69It7AlzaKqZ4mOdEE6KRUAdksZ9Frodp1G1+DcA0wE8k
         Qs3TK9YH0WddIQTVqRxULz3rz2ssjQPIPYOsK+a85vS78HB5vkilolE82k0X8FqVRAEs
         y9jA==
X-Gm-Message-State: AOAM530xrRQU4F6XPQrBHmhhiGbwcUBV3LLDkKP4LntYAh7VXIJt622B
        d9OgVCSmipq3N9/yVNIjmUdb/TzDE+HjOBpcHR6KCSEIs/qpYA==
X-Google-Smtp-Source: ABdhPJxJqyASCYtHv3Pm1jkdaLKDI2gwBxP2Hx07HZA7/4CPpleAOda8/wG9UI6ImIvOAu/zNbavc6lv0WME2kZXQ28=
X-Received: by 2002:a81:1c4f:0:b0:2e5:9db3:7a8e with SMTP id
 c76-20020a811c4f000000b002e59db37a8emr7691833ywc.319.1648172671241; Thu, 24
 Mar 2022 18:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAMZfGtUr6V5pTrPhZukD2_KbB7BLPoKvF6H63HP4pykY36Ou9A@mail.gmail.com>
 <0000000000009901d505dafc07b3@google.com> <CAHk-=whxaFX4nqnE-SLHTGKyqejvbrhYx5sagcxWd+UWCMf8dg@mail.gmail.com>
 <CAHk-=wg++3S5Cvks-4xFCrD7qgZDibc5aMS4Bt=Pemm7FnOBZA@mail.gmail.com>
In-Reply-To: <CAHk-=wg++3S5Cvks-4xFCrD7qgZDibc5aMS4Bt=Pemm7FnOBZA@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 25 Mar 2022 09:43:51 +0800
Message-ID: <CAMZfGtVHSWAzLN+FzOL0MyedcXc5UAaGuc4OufUwkLzWe2KWvQ@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in list_lru_add
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: multipart/mixed; boundary="00000000000099e40505db011a51"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000099e40505db011a51
Content-Type: text/plain; charset="UTF-8"

On Fri, Mar 25, 2022 at 3:47 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Mar 24, 2022 at 12:45 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, Mar 24, 2022 at 12:41 PM syzbot
> > <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com> wrote:
> > >
> > > syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> >
> > Heh, well that's unfortunate.
> >
> > I think the issue is that it triggered a new BUG() that didn't match
> > the previous NULL pointer dereference, so it thinks things are
> > "fixed".
>
> Oh, no, it's because it used the truncated patch that didn't do anything:
>
> > patch:          https://syzkaller.appspot.com/x/patch.diff?x=1208043d700000
>
> and maybe (due to the racy nature) nothing actually happened.
>

It is not easy to reproduce. I'm also trying to reproduce locally.

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
5abc1e37afa0335c52608d640fd30910b2eeda21

--00000000000099e40505db011a51
Content-Type: application/octet-stream; name="test.patch"
Content-Disposition: attachment; filename="test.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l15r51s80>
X-Attachment-Id: f_l15r51s80

ZGlmZiAtLWdpdCBhL21tL2xpc3RfbHJ1LmMgYi9tbS9saXN0X2xydS5jCmluZGV4IGZjOTM4ZDhm
ZjQ4Zi4uODg1YWU1ZDc3MDAyIDEwMDY0NAotLS0gYS9tbS9saXN0X2xydS5jCisrKyBiL21tL2xp
c3RfbHJ1LmMKQEAgLTc2LDYgKzc2LDcgQEAgbGlzdF9scnVfZnJvbV9rbWVtKHN0cnVjdCBsaXN0
X2xydSAqbHJ1LCBpbnQgbmlkLCB2b2lkICpwdHIsCiAJc3RydWN0IGxpc3RfbHJ1X25vZGUgKm5s
cnUgPSAmbHJ1LT5ub2RlW25pZF07CiAJc3RydWN0IGxpc3RfbHJ1X29uZSAqbCA9ICZubHJ1LT5s
cnU7CiAJc3RydWN0IG1lbV9jZ3JvdXAgKm1lbWNnID0gTlVMTDsKKwlpbnQga21lbWNnX2lkOwog
CiAJaWYgKCFscnUtPm1scnVzKQogCQlnb3RvIG91dDsKQEAgLTg0LDcgKzg1LDEyIEBAIGxpc3Rf
bHJ1X2Zyb21fa21lbShzdHJ1Y3QgbGlzdF9scnUgKmxydSwgaW50IG5pZCwgdm9pZCAqcHRyLAog
CWlmICghbWVtY2cpCiAJCWdvdG8gb3V0OwogCi0JbCA9IGxpc3RfbHJ1X2Zyb21fbWVtY2dfaWR4
KGxydSwgbmlkLCBtZW1jZ19jYWNoZV9pZChtZW1jZykpOworCWttZW1jZ19pZCA9IG1lbWNnX2tt
ZW1faWQobWVtY2cpOworCWwgPSBsaXN0X2xydV9mcm9tX21lbWNnX2lkeChscnUsIG5pZCwga21l
bWNnX2lkKTsKKwlpZiAoIWwpIHsKKwkJcHJfaW5mbygiQlVHOiB0aGUgbWVtY2coJXB4KS0+b2Jq
Y2coJXB4KSwga21lbWNnX2lkOiAlZFxuIiwKKwkJCW1lbWNnLCBtZW1jZy0+b2JqY2csIGttZW1j
Z19pZCk7CisJfQogb3V0OgogCWlmIChtZW1jZ19wdHIpCiAJCSptZW1jZ19wdHIgPSBtZW1jZzsK
--00000000000099e40505db011a51--
