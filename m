Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3523536E06
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 20:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbiE1SJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 14:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbiE1SJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 14:09:09 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F743DF1B
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 11:09:08 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id m20so13983173ejj.10
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 11:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iGqp3sqIQ6D1oqU2b3UQ+JQ14av/DX22LG0p5NM1mUo=;
        b=Px8PhLWYRiqNg8y87VlDUDsLJH2RoVnLN8Jl2LVu1LymXQyB5v2VGxblVmbq7n6ao8
         VU3hqglYO5WBsoT19tAqis2S52THyYxULaMlPuhCVc+o+wPTrAjTjNWJDkwjJ3dtGVFj
         8QZXFAV7pfp7xwqlA1vAGNq2rUWHaa1b3lzak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iGqp3sqIQ6D1oqU2b3UQ+JQ14av/DX22LG0p5NM1mUo=;
        b=dgmGnvXp8UKEUqFgvXP9OLpaFTiv9KySwhe+IQydHT7qClowgumW8tSGgZxZeIDw58
         eQSRk7XFn6+1ltWXHxgjWy8pPD28WHanObi+85yxsTaw3WfsFAc0Zow5Rw2BF+HTNboZ
         I0lB4UeazDkiSOoieTxbYT98wXWMxaYqRWPpRGn3sV2anNoNZjImGdLFsYU9rvvD6l7f
         v8gq7G2pLeiLjQNCZpI0fPspNZKMcNlSyb0onT82+vljoazsLPSptLtaeM3qG2XS0ZdB
         2RgF0E/bz4N0RXQEjZHe3eMfZN5G+SQy+IqzSSrLXPLQWDsBzQ+0yzN6dJsp/FDmcOJG
         v+0A==
X-Gm-Message-State: AOAM5338XyabSYcJPYYEwlj/otcWAjgmeC1pfZ0b188nsAL6Whqih3jr
        7FP6FfU/0Q3BFVDmgyqlMt0u3qoRCLhZPVbg
X-Google-Smtp-Source: ABdhPJzeIkUdjftI/xLAEArhN6iWXE8iqufD24H+DW7vCtRBC6Im/7Ijuv83TeX8apYnYYuHTOouPg==
X-Received: by 2002:a17:907:a426:b0:6ff:6c9f:7a3a with SMTP id sg38-20020a170907a42600b006ff6c9f7a3amr69120ejc.316.1653761346692;
        Sat, 28 May 2022 11:09:06 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id q9-20020a50cc89000000b0042ac2705444sm3809080edi.58.2022.05.28.11.09.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 11:09:05 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id u3so9714289wrg.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 11:09:05 -0700 (PDT)
X-Received: by 2002:a05:6000:16c4:b0:20f:cd5d:4797 with SMTP id
 h4-20020a05600016c400b0020fcd5d4797mr28588153wrf.193.1653761344659; Sat, 28
 May 2022 11:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <YpCUzStDnSgQLNFN@debian> <CAHk-=wg0uGAX5DYZq+tY2KeUAR8DtR91YE1y9CkPMKkKOyE4jg@mail.gmail.com>
 <CADVatmNGPbSdRNQuwJEWAaPtqb3vBYRjvsuBpoRUnhEHj=X5GQ@mail.gmail.com>
 <CAHk-=wisQd8yiPX=SsK3eFiakKo713hq4SyqPWsJ-oyAmLFefQ@mail.gmail.com>
 <YpIR67FMtTGCwARZ@debian> <CAHk-=wjuyHE=1wLgHncub8FfgeyYqfWYsy4-YrhAvq9991h_Aw@mail.gmail.com>
In-Reply-To: <CAHk-=wjuyHE=1wLgHncub8FfgeyYqfWYsy4-YrhAvq9991h_Aw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 28 May 2022 11:08:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_hJV0V=Ecg2dzbe2P_H1XKTu6VP_AtCH6u=tis31ayg@mail.gmail.com>
Message-ID: <CAHk-=wi_hJV0V=Ecg2dzbe2P_H1XKTu6VP_AtCH6u=tis31ayg@mail.gmail.com>
Subject: Re: mainline build failure due to f1e4c916f97f ("drm/edid: add EDID
 block count and size helpers")
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>
Content-Type: multipart/mixed; boundary="0000000000007e28af05e01651d2"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007e28af05e01651d2
Content-Type: text/plain; charset="UTF-8"

On Sat, May 28, 2022 at 10:40 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So digging a bit deeper - since I have am arm compiler after all - I
> note that 'sizeof(detailed_timings)' is 88.

Hmm.

sizeof() both

    detailed_timings[0].data.other_data.data.range.formula.gtf2

and

    detailed_timings[0].data.other_data.data.range.formula.cvt

is 7.

But the *union* of those things is

    detailed_timings[0].data.other_data.data.range.formula

and its size is 8 (despite having an alignment of just 1).

The attached patch would seem to fix it for me.

Not very much tested, and I have no idea what it is that triggers this
only on spear3xx_defconfig.

Some ARM ABI issue that is triggered by some very particular ARM
compiler flag enabled by that config?

Adding some ARM (and SPEAR, and SoC) people in case they have any idea.

This smells like a compiler bug triggered by "there's a 16-bit member
field in that gtf2 structure, and despite it being packed and aligned
to 1, we somehow still align the size to 2".

I dunno. But marking those unions packed too doesn't seem wrong, and
does seem to fix it.

                  Linus

--0000000000007e28af05e01651d2
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l3q6oh0p0>
X-Attachment-Id: f_l3q6oh0p0

IGluY2x1ZGUvZHJtL2RybV9lZGlkLmggfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9kcm1f
ZWRpZC5oIGIvaW5jbHVkZS9kcm0vZHJtX2VkaWQuaAppbmRleCBjMzIwNGE1OGZiMDkuLmIyNzU2
NzUzMzcwYiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9kcm0vZHJtX2VkaWQuaAorKysgYi9pbmNsdWRl
L2RybS9kcm1fZWRpZC5oCkBAIC0xMjEsNyArMTIxLDcgQEAgc3RydWN0IGRldGFpbGVkX2RhdGFf
bW9uaXRvcl9yYW5nZSB7CiAJCQl1OCBzdXBwb3J0ZWRfc2NhbGluZ3M7CiAJCQl1OCBwcmVmZXJy
ZWRfcmVmcmVzaDsKIAkJfSBfX2F0dHJpYnV0ZV9fKChwYWNrZWQpKSBjdnQ7Ci0JfSBmb3JtdWxh
OworCX0gX19hdHRyaWJ1dGVfXygocGFja2VkKSkgZm9ybXVsYTsKIH0gX19hdHRyaWJ1dGVfXygo
cGFja2VkKSk7CiAKIHN0cnVjdCBkZXRhaWxlZF9kYXRhX3dwaW5kZXggewpAQCAtMTU0LDcgKzE1
NCw3IEBAIHN0cnVjdCBkZXRhaWxlZF9ub25fcGl4ZWwgewogCQlzdHJ1Y3QgZGV0YWlsZWRfZGF0
YV93cGluZGV4IGNvbG9yOwogCQlzdHJ1Y3Qgc3RkX3RpbWluZyB0aW1pbmdzWzZdOwogCQlzdHJ1
Y3QgY3Z0X3RpbWluZyBjdnRbNF07Ci0JfSBkYXRhOworCX0gX19hdHRyaWJ1dGVfXygocGFja2Vk
KSkgZGF0YTsKIH0gX19hdHRyaWJ1dGVfXygocGFja2VkKSk7CiAKICNkZWZpbmUgRURJRF9ERVRB
SUxfRVNUX1RJTUlOR1MgMHhmNwpAQCAtMTcyLDcgKzE3Miw3IEBAIHN0cnVjdCBkZXRhaWxlZF90
aW1pbmcgewogCXVuaW9uIHsKIAkJc3RydWN0IGRldGFpbGVkX3BpeGVsX3RpbWluZyBwaXhlbF9k
YXRhOwogCQlzdHJ1Y3QgZGV0YWlsZWRfbm9uX3BpeGVsIG90aGVyX2RhdGE7Ci0JfSBkYXRhOwor
CX0gX19hdHRyaWJ1dGVfXygocGFja2VkKSkgZGF0YTsKIH0gX19hdHRyaWJ1dGVfXygocGFja2Vk
KSk7CiAKICNkZWZpbmUgRFJNX0VESURfSU5QVVRfU0VSUkFUSU9OX1ZTWU5DICgxIDw8IDApCg==
--0000000000007e28af05e01651d2--
