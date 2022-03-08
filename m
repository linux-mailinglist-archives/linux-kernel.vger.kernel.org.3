Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE674D1BBD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243489AbiCHPbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiCHPbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:31:53 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967124E395
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:30:57 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id b5so11602526ilj.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 07:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QL+ZtmXXGFLuTx2y9WXZomB2eATV+ikv3E06Gw8vFq0=;
        b=I68j85a6/qjvW0V3IavZmXBtBc8pD6pwX7yGYgP70N3qfY/KekXPn14gqHuXHQi3iz
         45y3wjsfeAJoSBGDTb3kxwyUuzILLoXo2eFo4z3nCSjYHUU1aBHr+B04M3kP/DctZcqU
         FaE5+rdNtdNZSVsKxPIjL2TKvhOwT8EAqwk6x0LlVDTkAwSZt0rUy3ePzZmsgeFzrtgj
         IcJ9yy+JXS0yPZEfdAsbdDcR8t9w2+5GyzVroPUq4B5oDrMBfwsfDFPB6QqHpu/tXFOv
         cMBPSu+cM5zifvwDyOWdetr6U++L+xykJjh1Zou3iBXvPcrzyzw1BY2lrHkSovZ8zh++
         GxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QL+ZtmXXGFLuTx2y9WXZomB2eATV+ikv3E06Gw8vFq0=;
        b=GB85ffSYopOdsVyjfYoYgfz8yEhqJ1Mupj4vjsMH15nE+TeiY4G/EEZHQ3OIDYhOyg
         zDiycAp8lfCBuGFDqyQZJDEEa11VkntdhUvPqNIacgKmVIBFmJnIkrbA0U2bk5a2i+Fh
         utAZK8hGlGV10k2TJUQ10+UzKyDLA+lGEpcPzkugLVs691OnXAnq0p4ra4/z5vSolOSG
         ZPCdHtvhIx6XhJLWw/dnafLZUsNqcR6CBfSMHImCBKF7y8fAFNgjRlWV7oj3Gdllu+dG
         YcFvyVqd8NEMrQzPxlod5OC8n/BSQmq8JxmamhWwDLg/tbODHpM0CIQ1tpu8Hirs0d9E
         jEnA==
X-Gm-Message-State: AOAM532yTnwoCC9bNMLzXfSEzmdj4zTQD0s0VrGCsHNS8QZomim39wMO
        Sn6+ykrlZbEenHiy8ULY6w9m9nfd7PX0Z2QXgkc=
X-Google-Smtp-Source: ABdhPJyPwmIL/pO50iF8syyeci1IJTewvmDOYzdRSzAtoKHRP6OQjBCrXGlvhWl93W16Be715WB6xOEjeRlrzUnkWU8=
X-Received: by 2002:a05:6e02:20c3:b0:2c2:9e23:8263 with SMTP id
 3-20020a056e0220c300b002c29e238263mr16510481ilq.248.1646753456934; Tue, 08
 Mar 2022 07:30:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643047180.git.andreyknvl@google.com> <fbfd9939a4dc375923c9a5c6b9e7ab05c26b8c6b.1643047180.git.andreyknvl@google.com>
 <your-ad-here.call-01646752633-ext-6250@work.hours>
In-Reply-To: <your-ad-here.call-01646752633-ext-6250@work.hours>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 8 Mar 2022 16:30:46 +0100
Message-ID: <CA+fCnZdCZ92BxnympNoRP8+3_gGDMZQgTeaUpga3ctuRq8zPYg@mail.gmail.com>
Subject: Re: [PATCH v6 31/39] kasan, vmalloc: only tag normal vmalloc allocations
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: multipart/mixed; boundary="000000000000d579e505d9b6aa3d"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d579e505d9b6aa3d
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 8, 2022 at 4:17 PM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> On Mon, Jan 24, 2022 at 07:05:05PM +0100, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > The kernel can use to allocate executable memory. The only supported way
> > to do that is via __vmalloc_node_range() with the executable bit set in
> > the prot argument. (vmap() resets the bit via pgprot_nx()).
> >
> > Once tag-based KASAN modes start tagging vmalloc allocations, executing
> > code from such allocations will lead to the PC register getting a tag,
> > which is not tolerated by the kernel.
> >
> > Only tag the allocations for normal kernel pages.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> This breaks s390 and produce huge amount of false positives.
> I haven't been testing linux-next with KASAN for while, now tried it with
> next-20220308 and bisected false positives to this commit.
>
> Any idea what is going wrong here?

Hi Vasily,

Could you try the attached fix?

Thanks!

--000000000000d579e505d9b6aa3d
Content-Type: application/octet-stream; name="s390-kasan-vmalloc.fix"
Content-Disposition: attachment; filename="s390-kasan-vmalloc.fix"
Content-Transfer-Encoding: base64
Content-ID: <f_l0iafuk20>
X-Attachment-Id: f_l0iafuk20

ZGlmZiAtLWdpdCBhL21tL2thc2FuL3NoYWRvdy5jIGIvbW0va2FzYW4vc2hhZG93LmMKaW5kZXgg
NzI3MmUyNDhkYjg3Li42OTM5NTRmNzcxZWMgMTAwNjQ0Ci0tLSBhL21tL2thc2FuL3NoYWRvdy5j
CisrKyBiL21tL2thc2FuL3NoYWRvdy5jCkBAIC00OTIsNyArNDkyLDggQEAgdm9pZCAqX19rYXNh
bl91bnBvaXNvbl92bWFsbG9jKGNvbnN0IHZvaWQgKnN0YXJ0LCB1bnNpZ25lZCBsb25nIHNpemUs
CiAJICogRG9uJ3QgdGFnIGV4ZWN1dGFibGUgbWVtb3J5LgogCSAqIFRoZSBrZXJuZWwgZG9lc24n
dCB0b2xlcmF0ZSBoYXZpbmcgdGhlIFBDIHJlZ2lzdGVyIHRhZ2dlZC4KIAkgKi8KLQlpZiAoIShm
bGFncyAmIEtBU0FOX1ZNQUxMT0NfUFJPVF9OT1JNQUwpKQorCWlmIChJU19FTkFCTEVEKENPTkZJ
R19LQVNBTl9TV19UQUdTKSAmJgorCSAgICAhKGZsYWdzICYgS0FTQU5fVk1BTExPQ19QUk9UX05P
Uk1BTCkpCiAJCXJldHVybiAodm9pZCAqKXN0YXJ0OwogCiAJc3RhcnQgPSBzZXRfdGFnKHN0YXJ0
LCBrYXNhbl9yYW5kb21fdGFnKCkpOwo=
--000000000000d579e505d9b6aa3d--
