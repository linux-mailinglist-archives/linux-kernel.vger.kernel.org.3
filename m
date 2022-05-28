Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E0853698E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 03:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351761AbiE1BEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 21:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241664AbiE1BEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 21:04:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D62764BCB
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 18:04:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id m20so11447708ejj.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 18:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/a8ecIYHg7QlH35fGGSVeTBLl6RR/RV9nck1HQAe+N8=;
        b=SsVTwOnhWJT6nMnX54zeDkwThE54QCBhjL5oOAtESV+ElK1rhuZi4yfjiIkJid5QVn
         oPRMlhPY9Ha+TivafeKHuoBSIFj52kqDM9s2LYRerxU1+rtPdhzC1Z11bpZ1PJ4rVfpk
         f8tVQQp7rCAJPhDmpX2a9i4lP3pbTSoBarH80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/a8ecIYHg7QlH35fGGSVeTBLl6RR/RV9nck1HQAe+N8=;
        b=AV3RG8zNCUPBOT8vVnO32q6SsRLuGzJ5RykqK6QVxwKKiOvpBQ0gYWbQk8KIUdMehx
         U5/c1+W+ueQDR53ifcpPEiOnxedpbLk2mFGfi/yKznFzIXr+jKGCbzK/YJoNMTiUCTe7
         kaaSFC2hUJqjBQ4RwZWYy0DgALfWkeqkQFbYrkX/1uNyyguq1iwaRiF71KnebiM+fLLe
         TNGqcI4PdZPzAs4wqDYESN3YMzomXT1uxOTNjLXqlqL3CW4J+P20tSeqZLev38lnvMUE
         zeAzlmD991OBjjYKWW5tJ4SSsrg6nHNSX3iHAJIDLXTSf41lp2f10DopTC2g1cfACw6Q
         4H/g==
X-Gm-Message-State: AOAM532j18ZhtVrhxjN4/DJn1RPI0hWlWdskNMZ75nOaO0ArKon53A4T
        QbkAG5t7hHknd7eLojneV74z0Wxk/bdGw++C
X-Google-Smtp-Source: ABdhPJzBuhjq6j2tWA8FK4FE16qnmlKtI+rE1rpS1qD0MUavrSL6cyjaLu769fhtYamicaE6uUAZDA==
X-Received: by 2002:a17:906:5d04:b0:6db:7262:570e with SMTP id g4-20020a1709065d0400b006db7262570emr39971194ejt.8.1653699872848;
        Fri, 27 May 2022 18:04:32 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id j12-20020a1709062a0c00b006fee28d459csm1910905eje.224.2022.05.27.18.04.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 18:04:31 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id o29-20020a05600c511d00b00397697f172dso4263462wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 18:04:31 -0700 (PDT)
X-Received: by 2002:a7b:c4ca:0:b0:397:3bac:9b2a with SMTP id
 g10-20020a7bc4ca000000b003973bac9b2amr9089329wmk.154.1653699870656; Fri, 27
 May 2022 18:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <YpCUzStDnSgQLNFN@debian> <CAHk-=wg0uGAX5DYZq+tY2KeUAR8DtR91YE1y9CkPMKkKOyE4jg@mail.gmail.com>
 <CADVatmNGPbSdRNQuwJEWAaPtqb3vBYRjvsuBpoRUnhEHj=X5GQ@mail.gmail.com>
In-Reply-To: <CADVatmNGPbSdRNQuwJEWAaPtqb3vBYRjvsuBpoRUnhEHj=X5GQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 May 2022 18:04:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wisQd8yiPX=SsK3eFiakKo713hq4SyqPWsJ-oyAmLFefQ@mail.gmail.com>
Message-ID: <CAHk-=wisQd8yiPX=SsK3eFiakKo713hq4SyqPWsJ-oyAmLFefQ@mail.gmail.com>
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

On Fri, May 27, 2022 at 4:41 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> I just tested with various values, sizeof(*edid) is 144 bytes at that place.

Hmm. What compiler do you have? Because it seems very broken.

You don't actually have to try with various sizes, you could have just
done something like

 int size_of_edid(const struct edid *edid)
 {
        return sizeof(*edid);
 }

and then "make drivers/gpu/drm/drm_edid.s" to generate assembly and
see what it looks like (obviously removing the BUG_ON() in order to
build).

That obviously generates code like

        movl    $128, %eax
        ret

for me, and looking at the definition of that type I really can't see
how it would ever generate anything else. But it's apparently not even
close for you.

I suspect some of the structs inside of that 'struct edid' end up
getting aligned, despite the '__attribute__((packed))'. For example,
'struct est_timings' is supposed to be just 3 bytes, and it's at an
odd offset too (byte offset 35 in the 'struct edid' if I did the math
correctly).

But it obviously doesn't happen for me or for most other people, so
it's something in your setup. Unusual compiler?

                  Linus
