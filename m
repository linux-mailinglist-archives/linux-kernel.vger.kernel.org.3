Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7696B544009
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 01:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiFHXmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 19:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbiFHXmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 19:42:39 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DCFAFAD5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 16:44:25 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id s39so11525540ybi.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 16:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7YvbnxXMryXWMsjSaz1Ekl/JpgVzZCjALJ/1ZepPv50=;
        b=mZDxGrd4G/FXAlzUGMy+s+aMzzkBbXRGQX1OHO/y9mtGdDWKN3FDCN49F8E5CjRHEe
         nXIaKYS8iAszBSSddmfyFAr35b96F0Fj4JpoiqlWkSvK9rnxrF2UJYwS7U5b29ABsqvO
         WrpZRK1cyQlnMVutnjeNjFPN0tD6vt9oyV3mN4rn0udSaYEZEKLPQTYSM4Lm1lTHBYA6
         An/8ykts9cW76kb+mmVHFwJ9vNYiLuVquNc+hnlLIGuceVY11yjleVLHRwPYSHx0/o1H
         pvAm7XyC4oW8zfsk0xxLOktBIZQz7msgNo+iRgkFBYMjGH+6Twtty7ZRAWUukOWh2yR7
         K86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7YvbnxXMryXWMsjSaz1Ekl/JpgVzZCjALJ/1ZepPv50=;
        b=CHsKFpZOLt9nrMz6HQYzoFDogGIpDZiOgetFBpktmqXqfxkKdQW2ASClA3+7zCGiZG
         sUefBIBejie1a1SOri6xYx6eBfyXfLLeoZkOcDA8+PcK2wVL2ytBG1Pugmhl8Ca7jFqO
         6FI2r9TwzFCBaV4KUxVwy292MpZO0S1x17VQjtoZHIqPHON4nuQgjw0IZexOZcknZqJE
         9ZPaI4br+GHXk/np3cWvXpGO5by/wRYksdOTViNxbWjpcILmZwxEvZ1JDrTv4ditj0fO
         yxKurBpZZkVBaveRweznDtwnXUulyrMp4WkZueGnNovpj0oZT6uvg3D7wILPPkbNtmEQ
         O9qw==
X-Gm-Message-State: AOAM532upC2sx7xYQ8M98GC/mTEUdBOmh51POYBuAy5onU75Md0/rqTM
        INejnZCBZK1QVxUf8iMsYDwdBYs7ZeI5hDYtPPc=
X-Google-Smtp-Source: ABdhPJwc9TJDrPzjl4vqLj9UMS5h1WkqxuMJZP7pVSyFdUGCnCSClulRkmpIszlQy5si4ukb56KYJSYcxr16AXvmi2g=
X-Received: by 2002:a05:6902:12ca:b0:65c:a34c:39cf with SMTP id
 j10-20020a05690212ca00b0065ca34c39cfmr36298170ybu.476.1654731864951; Wed, 08
 Jun 2022 16:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com> <c423c281f6739b7d847e2375c65ec2a4cf839d01.camel@mediatek.com>
In-Reply-To: <c423c281f6739b7d847e2375c65ec2a4cf839d01.camel@mediatek.com>
From:   patrick wang <patrick.wang.shcn@gmail.com>
Date:   Thu, 9 Jun 2022 07:44:11 +0800
Message-ID: <CAGcnep-57CcH+7-zaPu16v7AeVgRD=MTvPG8DJR+ucfg6RYREQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] mm: kmemleak: store objects allocated with
 physical address separately and check when scan
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?WWVlIExlZSAo5p2O5bu66Kq8KQ==?= <Yee.Lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 10:46 AM Kuan-Ying Lee
<Kuan-Ying.Lee@mediatek.com> wrote:
>
> On Fri, 2022-06-03 at 11:54 +0800, Patrick Wang wrote:
> > The kmemleak_*_phys() interface uses "min_low_pfn" and
> > "max_low_pfn" to check address. But on some architectures,
> > kmemleak_*_phys() is called before those two variables
> > initialized. The following steps will be taken:
> >
> > 1) Add OBJECT_PHYS flag and rbtree for the objects allocated
> >    with physical address
> > 2) Store physical address in objects if allocated with OBJECT_PHYS
> > 3) Check the boundary when scan instead of in kmemleak_*_phys()
> >
> > This patch set will solve:
> > https://lore.kernel.org/r/20220527032504.30341-1-yee.lee@mediatek.com
> >
> https://lore.kernel.org/r/9dd08bb5-f39e-53d8-f88d-bec598a08c93@gmail.com
>
> Hi Patrick,
>
> If this patchset fix the above issue, I think we need to add
> the below fixes tag.
>
> Fixes: 23c2d497de21 ("mm: kmemleak: take a full lowmem check in
> kmemleak_*_phys()")

Hi Kuan-Ying,

Thanks for taking a look.

This series should solve the false positive on ppc32 and arm64.
And the false positive on arm64 is triggered by commit
23c2d497de21. So I will add the fixes tag.

Thanks,
Patrick
