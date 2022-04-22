Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EE250C0FF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 23:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiDVVRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiDVVRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:17:33 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0C9387369
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:13:07 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id bi49so4342217vkb.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oe1v+8HKmPN5xE9lG49dcb7rjaDAxWTXKsNw822YQmM=;
        b=n5x2XicX6wPW74Dksn/JJcGTef6fmb3LZJfmWfIbNW6DANox9qPcP5MqfpuwQlpCDf
         KoTnuASNxeNpGEBOVFUMkGBeuh4jeVYPYDzN84oEq4VvPT6xIZHiulL2k4kfJ5KT/UUw
         RtDonsGeZSdT3trKWIsDJsVrHud1ugjNH+esPOLHkaO+4fQ748BaNghTc9SBPi+QZ+O+
         8Cdf5JsCnp5fC2/h2avY6ZdmwpgzaTRq5W8xXWXQhomPayl33tegCZuIw1zaupfoFIGM
         iQds3OVOa4vEkMuPzPDLe+Y58XOuY+lA6JQ7y5NiDNXMaPu7wD/sFme4jtws1QPJXkxa
         VyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oe1v+8HKmPN5xE9lG49dcb7rjaDAxWTXKsNw822YQmM=;
        b=gaDED0M3frzv9utpaqUPz5fng4VkurxAa0WbIZgJyufBuLH4nnxP/IDthTnsTpvNSt
         esjdPdheNHaUtIhKXfU0eWcpN56EEf7iiiEARLupERNg3kA/8c1A4gCXtYXuFYGB2iyy
         hLtBHjKWl09qfxHEkEx1AHj2pUNLLdrdnP6o4IW/HWSNZhPv7gtsPfabIJ5GzqSAnMvd
         0ApEFGfzVAmwTK5PL/JZXUOn29tn8Tb+V0w/vN5Zi3yuSPSFJthn0xoidb5Qf2JEDVfr
         XJKaCVvp0c2Sp85LeFapOpkocmweH8qXbAln+tzTU+fzsB1Ll/FLKbIBPJI2SGIL0vCH
         0hFg==
X-Gm-Message-State: AOAM531PmnZwJ1OKu3wkxnk/BUfeRANA7n2ZjbQ6qOfnwGQYfxzLPg7+
        l/yfmfa8h03Eg3v6cZiKaq0srC5RIVVcBmfxr/EeZQ==
X-Google-Smtp-Source: ABdhPJwnyBvl4lVolT8r8TO68OfMOMxgYxm+vCBlAU7uPN5abEv9TLKrIlxLB6z0kTpYjkPB8fzzxj6x+DqKb9Y2+IU=
X-Received: by 2002:ac5:c899:0:b0:349:33e8:d676 with SMTP id
 n25-20020ac5c899000000b0034933e8d676mr2382122vkl.0.1650658111910; Fri, 22 Apr
 2022 13:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220421211549.3884453-1-pcc@google.com> <YmLt0s/KdSJlSSPk@arm.com>
In-Reply-To: <YmLt0s/KdSJlSSPk@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Fri, 22 Apr 2022 13:08:20 -0700
Message-ID: <CAMn1gO77+Smgezkx0o5t+MnLJK9KUNpEb+xiJ3Pkoj4pFD1JfQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: make minimum slab alignment a runtime property
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pekka Enberg <penberg@kernel.org>, roman.gushchin@linux.dev,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 11:03 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Thu, Apr 21, 2022 at 02:15:48PM -0700, Peter Collingbourne wrote:
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 373b3ef99f4e..80e517593372 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -201,21 +201,33 @@ void kmem_dump_obj(void *object);
> >  #endif
> >
> >  /*
> > - * Setting ARCH_SLAB_MINALIGN in arch headers allows a different alignment.
> > + * Setting ARCH_SLAB_MIN_MINALIGN in arch headers allows a different alignment.
> >   * Intended for arches that get misalignment faults even for 64 bit integer
> >   * aligned buffers.
> >   */
> > -#ifndef ARCH_SLAB_MINALIGN
> > -#define ARCH_SLAB_MINALIGN __alignof__(unsigned long long)
> > +#ifndef ARCH_SLAB_MIN_MINALIGN
> > +#define ARCH_SLAB_MIN_MINALIGN __alignof__(unsigned long long)
> > +#endif
>
> Sorry, only a drive-by comment, I'll look at the arm64 parts next week.
> I've seen it mentioned in the first version, what's the point of MIN_MIN
> and not just MIN?

I tried to explain it here:
https://lore.kernel.org/all/CAMn1gO5xHZvFSSsW5sTVaUBN_gS-cYYNMG3PnpgCmh7kk_Zx7Q@mail.gmail.com/

In the end I decided to go back to MIN so this is moot.

Peter
