Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35CC5771BC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 00:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiGPWJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 18:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiGPWJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 18:09:02 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAB55F90
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 15:09:00 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id va17so15005450ejb.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 15:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AcjWh/Vyv/p487/TiHDxM9foCDPT53sV1cJadscCohE=;
        b=PgN9wmVjO3lR3KoSzFAY1iWb2IFmaxa116V4LWyxcRywTrML/HZOcILWc+leY52aWj
         D1DdypmH28pNlpnSvS8eWcv5N65gLyHTT9NsoIE3FS1bYMyYqlKVpJ8x7p+ob0ZtLJV8
         szWud/nfhwbnu0JcZmnJ7/ClpeGR8eTdIZxbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcjWh/Vyv/p487/TiHDxM9foCDPT53sV1cJadscCohE=;
        b=Hi2afLmwRwBUqpPM31NTtH/R4lDKU8nxnBWVtUzC82m2peKLGcy8gFvW5J8/F4yVup
         xqP3K2aV0re6cd3blrgcX66ksDi+xffvpVYkJvhQilBSN2fVC7ouLeOvLFype9b4GE8j
         6jeRa2LLXvyn6R2VKeTHqZ4CmQq2jTLmym+76qPBExTK+bFI+qb28yR9WqqMfJkCvDlI
         5azcRsEqu510wmSUS5Vvw8z0FKIn8sCcSzuojt/St2hJy/FM4pOakU+vPv2Mf7SlHRxj
         V1/qTQd+Adt7qjfbNLbiRwNo3lNq7rPJa7h6qhCNTXOsGGD2dGSF/d1njukzTV4S++r8
         7bnw==
X-Gm-Message-State: AJIora/WFCMpXQKAJdKMrE6+SHcuI6A0thkzTOaIUhNdafM+X3PAUg6D
        BBmt5YRSdhbki8GEEe0edG8/2U1RNih+Wzt0
X-Google-Smtp-Source: AGRyM1tGjTBKqmT/1QEwnbSqXVFNdDtSZPNParv8URE69JRkU+vv/GZ1H4s1OSA75afhxqtVPsP55A==
X-Received: by 2002:a17:907:2bde:b0:72b:4da0:6f3c with SMTP id gv30-20020a1709072bde00b0072b4da06f3cmr19593994ejc.623.1658009339300;
        Sat, 16 Jul 2022 15:08:59 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id e14-20020a170906314e00b00711d546f8a8sm3577160eje.139.2022.07.16.15.08.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jul 2022 15:08:57 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id h17so11772747wrx.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 15:08:56 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8c:b0:21d:7e98:51ba with SMTP id
 bw12-20020a0560001f8c00b0021d7e9851bamr16864641wrb.442.1658009335873; Sat, 16
 Jul 2022 15:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twM75GDM9t+9-CSCPDZG3QdcEpQ-X+FzQ4CLUCM7cKLkw@mail.gmail.com>
 <YtHXe4PcWXfihF9Q@dev-arch.thelio-3990X> <CAHk-=wh5DB+OL2QvWPqRhpLLCqW7u_bLucFJpm4v6rZT3T5+zQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh5DB+OL2QvWPqRhpLLCqW7u_bLucFJpm4v6rZT3T5+zQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 16 Jul 2022 15:08:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcECb3cwnB=7Zgf8CBfEYaTWcSzAjfQpTM75_Q5aO7dA@mail.gmail.com>
Message-ID: <CAHk-=wgcECb3cwnB=7Zgf8CBfEYaTWcSzAjfQpTM75_Q5aO7dA@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.19-rc7
To:     Nathan Chancellor <nathan@kernel.org>,
        Matthew Auld <matthew.auld@intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000080390c05e3f36106"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000080390c05e3f36106
Content-Type: text/plain; charset="UTF-8"

On Sat, Jul 16, 2022 at 2:35 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That said, even those type simplifications do not fix the fundamental
> issue. That "DIV_ROUND_UP()" still ends up being a 64-bit divide,
> although now it's at least a "64-by-32" bit divide.

Hmm. The "DIV_ROUND_UP()" issue could be solved by just making the
rule be that the max_segment size is always a power of two.

Then you don't need the (expensive!) DIV_ROUND_UP(), and can just use
the regular "round_up()" that works on powers-of-two.

And the simplest way to do that is to just make "max_segments" be 2GB.

The whole "round_down(UINT_MAX, page_alignment)" seems entirely
pointless. Do you really want segments that are some odd number just
under the 4GB mark, and force expensive divides?

For consistency, I used the same value in
i915_rsgt_from_buddy_resource(). I have no idea if that makes sense.

Anyway, the attached patch is COMPLETELY UNTESTED. But it at least
seems to compile. Maybe.

                  Linus

--00000000000080390c05e3f36106
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l5ofxmky0>
X-Attachment-Id: f_l5ofxmky0

IGRyaXZlcnMvZ3B1L2RybS9pOTE1L2k5MTVfc2NhdHRlcmxpc3QuYyB8IDggKysrKystLS0KIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvaTkxNV9zY2F0dGVybGlzdC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2k5MTUvaTkxNV9zY2F0dGVybGlzdC5jCmluZGV4IGY2M2I1MGI3MWUxMC4uODMwZGNkODMz
ZDRlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9pOTE1X3NjYXR0ZXJsaXN0LmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvaTkxNV9zY2F0dGVybGlzdC5jCkBAIC04MSw3ICs4
MSw5IEBAIHN0cnVjdCBpOTE1X3JlZmN0X3NndCAqaTkxNV9yc2d0X2Zyb21fbW1fbm9kZShjb25z
dCBzdHJ1Y3QgZHJtX21tX25vZGUgKm5vZGUsCiAJCQkJCSAgICAgIHU2NCByZWdpb25fc3RhcnQs
CiAJCQkJCSAgICAgIHU2NCBwYWdlX2FsaWdubWVudCkKIHsKLQljb25zdCB1NjQgbWF4X3NlZ21l
bnQgPSByb3VuZF9kb3duKFVJTlRfTUFYLCBwYWdlX2FsaWdubWVudCk7CisJLy8gTWFrZSBzdXJl
IG1heF9zZWdtZW50IChhbmQgdGh1cyBzZWdtZW50X3BhZ2VzKSBpcworCS8vIGEgcG93ZXIgb2Yg
dHdvIHRoYXQgZml0cyBpbiAzMiBiaXRzLgorCWNvbnN0IHU2NCBtYXhfc2VnbWVudCA9IDF1bCA8
PCAzMTsKIAl1NjQgc2VnbWVudF9wYWdlcyA9IG1heF9zZWdtZW50ID4+IFBBR0VfU0hJRlQ7CiAJ
dTY0IGJsb2NrX3NpemUsIG9mZnNldCwgcHJldl9lbmQ7CiAJc3RydWN0IGk5MTVfcmVmY3Rfc2d0
ICpyc2d0OwpAQCAtOTYsNyArOTgsNyBAQCBzdHJ1Y3QgaTkxNV9yZWZjdF9zZ3QgKmk5MTVfcnNn
dF9mcm9tX21tX25vZGUoY29uc3Qgc3RydWN0IGRybV9tbV9ub2RlICpub2RlLAogCiAJaTkxNV9y
ZWZjdF9zZ3RfaW5pdChyc2d0LCBub2RlLT5zaXplIDw8IFBBR0VfU0hJRlQpOwogCXN0ID0gJnJz
Z3QtPnRhYmxlOwotCWlmIChzZ19hbGxvY190YWJsZShzdCwgRElWX1JPVU5EX1VQKG5vZGUtPnNp
emUsIHNlZ21lbnRfcGFnZXMpLAorCWlmIChzZ19hbGxvY190YWJsZShzdCwgcm91bmRfdXAobm9k
ZS0+c2l6ZSwgc2VnbWVudF9wYWdlcyksCiAJCQkgICBHRlBfS0VSTkVMKSkgewogCQlpOTE1X3Jl
ZmN0X3NndF9wdXQocnNndCk7CiAJCXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOwpAQCAtMTU5LDcg
KzE2MSw3IEBAIHN0cnVjdCBpOTE1X3JlZmN0X3NndCAqaTkxNV9yc2d0X2Zyb21fYnVkZHlfcmVz
b3VyY2Uoc3RydWN0IHR0bV9yZXNvdXJjZSAqcmVzLAogewogCXN0cnVjdCBpOTE1X3R0bV9idWRk
eV9yZXNvdXJjZSAqYm1hbl9yZXMgPSB0b190dG1fYnVkZHlfcmVzb3VyY2UocmVzKTsKIAljb25z
dCB1NjQgc2l6ZSA9IHJlcy0+bnVtX3BhZ2VzIDw8IFBBR0VfU0hJRlQ7Ci0JY29uc3QgdTY0IG1h
eF9zZWdtZW50ID0gcm91bmRfZG93bihVSU5UX01BWCwgcGFnZV9hbGlnbm1lbnQpOworCWNvbnN0
IHU2NCBtYXhfc2VnbWVudCA9IDF1IDw8IDMxOwogCXN0cnVjdCBkcm1fYnVkZHkgKm1tID0gYm1h
bl9yZXMtPm1tOwogCXN0cnVjdCBsaXN0X2hlYWQgKmJsb2NrcyA9ICZibWFuX3Jlcy0+YmxvY2tz
OwogCXN0cnVjdCBkcm1fYnVkZHlfYmxvY2sgKmJsb2NrOwo=
--00000000000080390c05e3f36106--
