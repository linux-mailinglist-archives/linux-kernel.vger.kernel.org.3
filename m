Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42F3586DC2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiHAP34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiHAP3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:29:53 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF1F22BDB
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:29:52 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10ea7d8fbf7so8870235fac.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 08:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PtgS4dgz8xv7/FHw1JDRxioWwZ+//JkgR/Ho/06ZT1U=;
        b=BzICjI5CjsXpXwfXXBS4lwImefSjPK5kVnk0jR4294uqqPiW8i5QyLCGj/cBSEAcL5
         X81BWaBC0636Q6ZE25zuam/hn4nbLa72QQLo9CxlxH/yh3P+iRNtdinCqRDpDZC/F4L2
         gGSVoEtBMUojJcjcjTeJ5mkTJmOVUwMJqOoU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PtgS4dgz8xv7/FHw1JDRxioWwZ+//JkgR/Ho/06ZT1U=;
        b=u5y4j+6cgF2KKo/Hf1t5ykiLrnxuqNoUjN60E/CRCpWdg3kem3zg+wyHd9uUR0XyRU
         z5Mi3SfSR/4jtGnGkxnvqL5QAdTPr8OkqT5qIRdYav1s1C6btXuFEnHuB2IwN2hPWeJg
         QTiNn+ow665ZxPcslj+QOgAlYM//uLREVcStZzC7S62uO55ryCW4OyNc2VbJ7UyXECtf
         MUxbpGqJIZROMGYOcyJT1cEB0vB1RruTRWShBmdKONmsIR9C8V0f7XBW/V6Uf2vR0cEu
         0bBpdcY/9xFymPdzX58VmUzuxWRbMpuFhc0ZKBOzbGJYDMi1wRyP6qb392vxawywGw+I
         2b0Q==
X-Gm-Message-State: AJIora/X1Cg6ddVjXI8a9dVxBPqjYLyQmS7KUwU9G4a6IESY6w/msI3U
        XkGlG0UkCjpPyErLc9VNVclGc92QP/Ipc68gMiE=
X-Google-Smtp-Source: AGRyM1uScJUHbJQVVoKx6STKXSlkXmFmbWDKJH+DS6GF0zvJ8M8qwrJIWK8UFq1jnOvKVl5GZnXaIw==
X-Received: by 2002:a05:6870:23a3:b0:101:a0da:f478 with SMTP id e35-20020a05687023a300b00101a0daf478mr7920599oap.181.1659367791521;
        Mon, 01 Aug 2022 08:29:51 -0700 (PDT)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com. [209.85.167.174])
        by smtp.gmail.com with ESMTPSA id 65-20020aca0644000000b0032f63c4638esm2489029oig.2.2022.08.01.08.29.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 08:29:51 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id u9so13397960oiv.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 08:29:51 -0700 (PDT)
X-Received: by 2002:a05:6808:1c06:b0:33a:9b3b:b3ce with SMTP id
 ch6-20020a0568081c0600b0033a9b3bb3cemr6596099oib.53.1659367790915; Mon, 01
 Aug 2022 08:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3GTzeJUdcjVv-1fL7h7e6XRFPA65-5xseQ4=tyZE8UDg@mail.gmail.com>
 <CAK8P3a01piA9bvuUpEPQ6dE4EL4AM8ui4CJGCdnOHPSOBG2Wrw@mail.gmail.com>
In-Reply-To: <CAK8P3a01piA9bvuUpEPQ6dE4EL4AM8ui4CJGCdnOHPSOBG2Wrw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Aug 2022 08:29:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wikSK533pTAw_RDud8sdiNcL7EB62_ueJwYL1X3G=oj=w@mail.gmail.com>
Message-ID: <CAHk-=wikSK533pTAw_RDud8sdiNcL7EB62_ueJwYL1X3G=oj=w@mail.gmail.com>
Subject: Re: [GIT PULL 1/6] ARM: SoC updates for 5.20
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 3:30 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git arm-soc-5.20

That doesn't exist.

I can see the branch ("arm/soc"), but not the tag. I did check your
other requests, and those all had their tags pushed out, so it's just
this one that is missing.

Given the mess-up with 2/6, I'll just skip this series for now - I
hope you can fix it up and resend it tomorrow when you're back h ome.

                   Linus
