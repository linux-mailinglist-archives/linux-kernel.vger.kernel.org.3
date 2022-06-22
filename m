Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C04554EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359234AbiFVPTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358543AbiFVPTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:19:51 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F204037A18
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:19:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id g25so34931583ejh.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fL0cpK7LWs+wtjTpXEysTDKhA1+C2iKr938rtJlnymk=;
        b=GvfsdTBmWyUjk9gg9yIDNOY9pWXwZpSazxMnvIHYUTAT4sO4mm4iC+WrG83ULgLwBi
         QtBCMGf25OQ+7Ho+NdkvZzvhBdy0akfEaA68slA7C5N5ZDC46Rfqh50C/YZ9XO/vmVqA
         3eV5iTj/g8q0Qp6DxxUqZdHPySmTSs8jND17Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fL0cpK7LWs+wtjTpXEysTDKhA1+C2iKr938rtJlnymk=;
        b=URf6pwXbq43B2B7kc25N4oabjAEv6Ja03gJHqt6czAO98DTmAhBg90hXYyHU4/Oak7
         JF/5ry7Rl2H9oQJNewTi5iLgWoMQi4lWA1FxPWS9wo/b5yDuji+k1jQBu86zb9k8iQXO
         KxQSIlkBD6nBj43EdH4UaLS0Qeekd5Lh5iLMHQiDDl7LoruTn0tJ+Y4s0k1xiRgACCcu
         IHrU2sdv7WUg01FpErsLFIzp6ngAVBcOYJYeFwVMHFrjCAKv5U+wPEA1MZ5jAUEoa4h6
         Kk/UWORzKV34gTfaoP2Q3gkLxz3TzcG6iqe6QdX+dr4yc/NDGiVueh/xzeJ3DvoNm1qu
         Hffw==
X-Gm-Message-State: AJIora8AMumWmeofvS37PoHZUe3KH7waezBFju55X7Weit8oL9DWx/Xo
        tDggLiMCgv4x62pP2E2uXnvYGx3xTNH/V96O
X-Google-Smtp-Source: AGRyM1sdEDek1xkPLf2oSmzkwx8IWUa1up5g1iWsOhl6vTgUAO7G1wfcwjyg6OplG3LVLY/fnKqOCQ==
X-Received: by 2002:a17:906:ce:b0:715:705e:52fb with SMTP id 14-20020a17090600ce00b00715705e52fbmr3562711eji.303.1655911189246;
        Wed, 22 Jun 2022 08:19:49 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id h7-20020a0564020e8700b004355dc75066sm12916446eda.86.2022.06.22.08.19.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 08:19:48 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id v14so23906429wra.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:19:48 -0700 (PDT)
X-Received: by 2002:a5d:48c1:0:b0:21a:3574:e70c with SMTP id
 p1-20020a5d48c1000000b0021a3574e70cmr3769039wrs.97.1655911187876; Wed, 22 Jun
 2022 08:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <YrLtpixBqWDmZT/V@debian> <CAHk-=wiN1ujyVTgyt1GuZiyWAPfpLwwg-FY1V-J56saMyiA1Lg@mail.gmail.com>
 <YrMwXAs9apFRdkVo@debian>
In-Reply-To: <YrMwXAs9apFRdkVo@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Jun 2022 10:19:31 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjmREcirYi4k_CBT+2U8X5VOAjQn0tVD28OdcKJKpA0zg@mail.gmail.com>
Message-ID: <CAHk-=wjmREcirYi4k_CBT+2U8X5VOAjQn0tVD28OdcKJKpA0zg@mail.gmail.com>
Subject: Re: mainline build failure due to 281d0c962752 ("fortify: Add Clang support")
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000224f9505e20ade6b"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_RED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000224f9505e20ade6b
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 22, 2022 at 10:08 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> Yeah, true. I had to check to find out its from the memcpy() in check_image_valid().

Funky but true - I can reproduce it, and just commenting out that
memcpy fixes the warning.

And I see nothing wrong with that code - it's copying a 'struct
fw_section_info_st' between two other structs that seem to have arrays
that are appropriately sized.

Replacing the memcpy() with just a structure assignment seems to get
rid of the warning, and seems to be a simple fix (patch attached), but
I don't understand why that memcpy() would warn.

This looks like a clang bug to me, but maybe I'm missing something.

                  Linus

--000000000000224f9505e20ade6b
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l4pqr5ry0>
X-Attachment-Id: f_l4pqr5ry0

IGRyaXZlcnMvbmV0L2V0aGVybmV0L2h1YXdlaS9oaW5pYy9oaW5pY19kZXZsaW5rLmMgfCA0ICst
LS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9odWF3ZWkvaGluaWMvaGluaWNfZGV2bGluay5j
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaHVhd2VpL2hpbmljL2hpbmljX2RldmxpbmsuYwppbmRl
eCA2MGFlOGJmYzVmNjkuLjE3NDlkMjZmNGJlZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaHVhd2VpL2hpbmljL2hpbmljX2RldmxpbmsuYworKysgYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9odWF3ZWkvaGluaWMvaGluaWNfZGV2bGluay5jCkBAIC00Myw5ICs0Myw3IEBAIHN0YXRp
YyBib29sIGNoZWNrX2ltYWdlX3ZhbGlkKHN0cnVjdCBoaW5pY19kZXZsaW5rX3ByaXYgKnByaXYs
IGNvbnN0IHU4ICpidWYsCiAKIAlmb3IgKGkgPSAwOyBpIDwgZndfaW1hZ2UtPmZ3X2luZm8uZndf
c2VjdGlvbl9jbnQ7IGkrKykgewogCQlsZW4gKz0gZndfaW1hZ2UtPmZ3X3NlY3Rpb25faW5mb1tp
XS5md19zZWN0aW9uX2xlbjsKLQkJbWVtY3B5KCZob3N0X2ltYWdlLT5pbWFnZV9zZWN0aW9uX2lu
Zm9baV0sCi0JCSAgICAgICAmZndfaW1hZ2UtPmZ3X3NlY3Rpb25faW5mb1tpXSwKLQkJICAgICAg
IHNpemVvZihzdHJ1Y3QgZndfc2VjdGlvbl9pbmZvX3N0KSk7CisJCWhvc3RfaW1hZ2UtPmltYWdl
X3NlY3Rpb25faW5mb1tpXSA9IGZ3X2ltYWdlLT5md19zZWN0aW9uX2luZm9baV07CiAJfQogCiAJ
aWYgKGxlbiAhPSBmd19pbWFnZS0+ZndfbGVuIHx8Cg==
--000000000000224f9505e20ade6b--
