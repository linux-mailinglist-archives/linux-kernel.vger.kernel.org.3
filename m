Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED6E536DFE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 19:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbiE1RlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 13:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbiE1RlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 13:41:20 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB16E2
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 10:41:19 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t5so8864982edc.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 10:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pP5sQR3QwXNtypqdUBNCTZlpu49d035rXCG+jxDoA2s=;
        b=Z70GBvzBscFi3wczPp/1gBU54OJpVhVtHdRLTSfj2K/6zYlVoev9uCuNVqs5HUSD6f
         AxHO+J2LAuG3MqxfhY3/pQ1sdLe7lXw7Q1xxXU6eXyGm/7Xyqf/1CmirEGCn6tq8hsj1
         FuIAAeHZ2rF1M229MhVKggd35Tg9CBjRlQDRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pP5sQR3QwXNtypqdUBNCTZlpu49d035rXCG+jxDoA2s=;
        b=D6E9odeooxvxE3srZAOCb64CEBtlY/c4u2X1ZLwxTvXA3GcilImSTfbOVnd2gsJIt1
         v6h9RZzullZ2UXrpGnwFHjEsgKaZkaiuMVMqhv4qbUdP15xxSPE5KvjjfgMPaUdYzPo1
         e8pXWGDAQQEspwB3alIBBO82mLwfWiFjSgVm+N3u9YC8H+XjmUmsgTBiQfynhy5B22vT
         mI1eAW4lOFSNO+nU/XlgxIB3VquVTJw5NzhztjIEZ7cHfSmChOhu4bLuGOfdUDYB4TBn
         AQfZf2zwlO84je8OC2N0imEOzU9AcLZzTIF9ejRZgavtTHuCFOuaaRrO/ZnoJQn60XVn
         r7KQ==
X-Gm-Message-State: AOAM533SJmYimIwUKQ9l3cDSYBVYRxPsYJBieDqmR6DRTPGbbzfYgt9k
        5IiWGYwNUMlFIyng09agHXXlUMSEv5/+dYZY
X-Google-Smtp-Source: ABdhPJwJzGMD+Me5AgUkGzc3LSd1Rt0x0OGscCQfIqdo/57cS2Ls0ZxS1zocQOMmbuJzoE0Q/GeRVQ==
X-Received: by 2002:aa7:dc09:0:b0:42a:aadd:8e71 with SMTP id b9-20020aa7dc09000000b0042aaadd8e71mr50558464edu.41.1653759677531;
        Sat, 28 May 2022 10:41:17 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id c23-20020a50f617000000b0042b765c2448sm3718820edn.80.2022.05.28.10.41.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 10:41:16 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id t6so9653167wra.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 10:41:16 -0700 (PDT)
X-Received: by 2002:adf:dcc5:0:b0:210:1f95:c5d0 with SMTP id
 x5-20020adfdcc5000000b002101f95c5d0mr5490672wrm.97.1653759675983; Sat, 28 May
 2022 10:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <YpCUzStDnSgQLNFN@debian> <CAHk-=wg0uGAX5DYZq+tY2KeUAR8DtR91YE1y9CkPMKkKOyE4jg@mail.gmail.com>
 <CADVatmNGPbSdRNQuwJEWAaPtqb3vBYRjvsuBpoRUnhEHj=X5GQ@mail.gmail.com>
 <CAHk-=wisQd8yiPX=SsK3eFiakKo713hq4SyqPWsJ-oyAmLFefQ@mail.gmail.com> <YpIR67FMtTGCwARZ@debian>
In-Reply-To: <YpIR67FMtTGCwARZ@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 28 May 2022 10:40:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuyHE=1wLgHncub8FfgeyYqfWYsy4-YrhAvq9991h_Aw@mail.gmail.com>
Message-ID: <CAHk-=wjuyHE=1wLgHncub8FfgeyYqfWYsy4-YrhAvq9991h_Aw@mail.gmail.com>
Subject: Re: mainline build failure due to f1e4c916f97f ("drm/edid: add EDID
 block count and size helpers")
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 5:13 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> just tried this with
> make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- drivers/gpu/drm/drm_edid.s
>
> size_of_edid:
>         mov     r0, #144        @,
>         ldmfd   sp, {fp, sp, pc}        @

So digging a bit deeper - since I have am arm compiler after all - I
note that 'sizeof(detailed_timings)' is 88.

Which is completely wrong. It should be 72 bytes (an array of 4
structures, each 18 bytes in size).

I have not dug deeper, but that is clearly the issue.

Now, why that only happens on that spear3xx_defconfig, I have no idea.

             Linus
