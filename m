Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB460589754
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbiHDFZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236833AbiHDFZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:25:51 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185C83B97E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 22:25:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id j8so9681235ejx.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 22:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WGTQSI2IDsep0Ep5FWuQwgSDPWRRC7GjkzJ83Cekmfs=;
        b=Zy8HoBrD482o0HXyIVzu9RXswuhGZryy6gWwsEAkcgFis3yd4cHkmfpbyU6PZBiUin
         /yy5C6sLzs6RYHAMFDwtQTKTHRCvq2+t1A1R5F3LqVtDMCk3UMscBfA7c0BtMfN5+TOm
         aY7XPZ9v9yVanu0GGoWCIliPpWPKmBY5V/v6wLjthGnym6Xd6q92J9xL4TrTHt+7cPKJ
         satCuJlS8IAevD9NS4HuDG5FzF9v6OSVLZdQ001uSC1D9ZgfLycnI6nZibeaAyt60gxW
         bRF7po+bTs7g3pCAmSMtMesNuaPpnRCPOjsGB30prKYGa5dIYjsWBrH2Kpz6EXkmvNtQ
         0Jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WGTQSI2IDsep0Ep5FWuQwgSDPWRRC7GjkzJ83Cekmfs=;
        b=V8gLSUEo2r+4IvciT5DPjMcgncaE0tOCvhiOdGM5Dd4hfBtn2TI8G9AN0uf6zajRP3
         XAWc1I7Ofs5ykMr/lTzZ9jP+XasEyuXWIPqN9KJOdBfWz8yGPoGp82Qb7oSj8bILikB7
         81NU9TUW/cMHqPUYTsBv+91RsyQKJM4cmGUlJVTaejVtjYxdhD3fHLqsh299vPj7lEE/
         mOW7f/8X+Ke/PxGSv28BdN1S8qJxSxLjqhMjPIVwkH7QfkXkEOG71uKPwWWzBBicPbzX
         G3jnhqql1qejbE2bt7Fa1qgbKMJDYOk1QNSRkvAwwKYAPRA/9AXXpDYOSgP/XHpO6L0v
         dgEg==
X-Gm-Message-State: ACgBeo1xcfiptWAfQUEg7w9uc6ur40l0x6plTyLEwcZpd3jLaPr51GNG
        66qJ11dpRJ/6Y8+2MNix+jEsHgiTCP/yarfyWZs=
X-Google-Smtp-Source: AA6agR6cQoFYWdNihZ9jcq0oWE0SS71XYkuqIcIySvpAa4kd8U41krPCRaiIHhK4ubW+zc9nbArvEkHl3hzwDzqRUCA=
X-Received: by 2002:a17:907:6eac:b0:730:a07f:38bb with SMTP id
 sh44-20020a1709076eac00b00730a07f38bbmr149703ejc.750.1659590746620; Wed, 03
 Aug 2022 22:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twFEv8AcRQG-WXg5owy_Xhxy3DqnvVCFHgtd4TYCcKWEQ@mail.gmail.com>
 <CAHk-=whXSt2N0GcoPC6XxXXLMpXm-34ua+X4AhPsLoqBcF6Xqg@mail.gmail.com>
 <CAHk-=wj8UHvjsVPohpRA1RJo1upyKoSnjcsys+=vbRVbpPvBMg@mail.gmail.com>
 <CAPM=9txsYE1zFDW+ehHQv138DoeT1Fw6hfzfPa4czvXGSjefjw@mail.gmail.com>
 <CAHk-=wj+yzauNXiEwHfCrkbdLSQkizdR1Q3YJLAqPo6AVq2_4Q@mail.gmail.com>
 <CAPM=9txkjJg5uArn1ann7Hf+JFCukQFGwqv+YHAx97Cdxezs_Q@mail.gmail.com>
 <CAHk-=whWcektQzPJgSPa2DC3wMPxgLh8fJVQWeo8i99XMXPjfg@mail.gmail.com>
 <CAPM=9twUvRoVcWHhBH7yuDDVj8K8aM0APQ8Yx3cx19keLJP8Gg@mail.gmail.com>
 <CAHk-=wjbfAuN1eV+F0wWFsWEaMmJsT2p3DXnUvxo7bQ-xJwKCQ@mail.gmail.com> <CAHk-=wih3NEubvTye4URZOmLYu6G+ZT9cngepo0z++ogCWUymQ@mail.gmail.com>
In-Reply-To: <CAHk-=wih3NEubvTye4URZOmLYu6G+ZT9cngepo0z++ogCWUymQ@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 4 Aug 2022 15:25:35 +1000
Message-ID: <CAPM=9twRb4c62e0mU9CwOTAYMkR6YCRR5=KLTrSKoLbJ7RB9xw@mail.gmail.com>
Subject: Re: [git pull] drm for 5.20/6.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2022 at 14:46, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Aug 3, 2022 at 9:27 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I'll do a few more. It's close enough already that it should be just
> > four more reboots to pinpoint exactly which commit breaks.
>
> commit 5d945cbcd4b16a29d6470a80dfb19738f9a4319f is the first bad commit.
>
> I think it's supposed to make no semantic changes, but it clearly does.
>
> What a pain to figure out what's wrong in there, and I assume it
> doesn't revert cleanly either.
>
> Bringing in the guilty parties. See
>
>   https://lore.kernel.org/all/CAHk-=wj+yzauNXiEwHfCrkbdLSQkizdR1Q3YJLAqPo6AVq2_4Q@mail.gmail.com/
>
> for the beginning of this thread.

I think I've tracked it down, looks like it would only affect GFX8
cards, which might explain why you and I have seen it, and I haven't
seen any other reports.

pretty sure you have an rx580, and I just happen to have a fiji card
in this machine right now.

I'll retest on master and send you a fixup patch.

Dave.
