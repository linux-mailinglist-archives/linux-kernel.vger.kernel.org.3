Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBF05582E0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 19:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiFWRVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 13:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiFWRUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:20:54 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109A9CD911;
        Thu, 23 Jun 2022 10:00:41 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g4so22024002lfv.9;
        Thu, 23 Jun 2022 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AyqzSDiNvk0JXiJA88Ctd6VpkzCitgPMbrP8MwPw0tg=;
        b=a3k/G2QCfq01Gzwf77qJyKjiQY6S7idKqT3CD5AUEHQqFB8M8QnX18lwJxA/PrMry7
         XrO58mKy2atVb4hHlz7dBv3CVgm7OCtZZJ5V8S8I7Y0q+j7SSvCGtJrizFu6SSeyrjHv
         aSgjueWr3LBVr5Ak/4iCTDz3Ix0AI3yffx/CKORswfxnKWkRDo1PLjoUaqRWUs4c4P+W
         WgYyH3EVHesxKXKK8m8lQ/Kcg3k+HuwzVnrknOVGvdpaQsuh5An+U8gctX6FtXuJ/cha
         TrFa6E43SOa8O5OkvyjboTKOiD5TDFvk95clmB6qwNL6KAy9UtEtwSseGa8STpLRyWeK
         akhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AyqzSDiNvk0JXiJA88Ctd6VpkzCitgPMbrP8MwPw0tg=;
        b=KdOaJHjfaVXC7WhW6Qq37DJjOQvIJ4/CrTILYncO+zHsCBt1wEoEDLJiNIGDpXhFUA
         WVH3pkq4EW/nGNkzFpbfkBr2RpG27a63b2IXeLpMFfG+XisClaPocQu1bcT+1Y9RKob0
         UZa1M3oHSSjRy293ieVOqMBO8GZxT4SWgXuPEN/NJSHV68o8I3hqQRkz6LPYvfVmTyHU
         Vw44stoU84R1/dhiuzB1mfhOSLjbEAtA3RPGHJk2R6adZhzOYPj/cGBqF0X4gaIyJl7K
         1jIksaJi5+3MUnrRlwkWq0guJ2PAOX7eVTeheRwBYy5rLL7/Cf7PDKIIzaykrhogVC+W
         x3nQ==
X-Gm-Message-State: AJIora+PnsMdEH+evMbfOmASwuCEzVLeCoFVTXs/clX5mRkXZK287uNU
        X/zI6iupui6jSfXHAEKmWh6UIOdYkRwjimTz
X-Google-Smtp-Source: AGRyM1u7UxyLwNPcGv50NxrYtAI+jU11DHAzSBGlQvSi9sZqL3GDSejVn+3spp5cVuyJUsF2yw8Buw==
X-Received: by 2002:ac2:5201:0:b0:479:3923:9559 with SMTP id a1-20020ac25201000000b0047939239559mr6199240lfl.553.1656003638785;
        Thu, 23 Jun 2022 10:00:38 -0700 (PDT)
Received: from sakura.myxoz.lan (2-248-181-228-no2390.tbcn.telia.com. [2.248.181.228])
        by smtp.gmail.com with ESMTPSA id f6-20020a05651c02c600b00255526478f1sm1472387ljo.88.2022.06.23.10.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 10:00:38 -0700 (PDT)
From:   Miko Larsson <mikoxyzzz@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Down <chris@chrisdown.name>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>
Subject: Re: [PATCH 0/2] Kconfig: -O3 enablement
Date:   Thu, 23 Jun 2022 19:00:47 +0200
Message-ID: <2650588.mvXUDI8C0e@sakura.myxoz.lan>
In-Reply-To: <CAK7LNAQqJc74MGFyU6fvhM9VkDKYUXyCt0NF1qAr1RmfUqC0=w@mail.gmail.com>
References: <20220621133526.29662-1-mikoxyzzz@gmail.com> <2817735.mvXUDI8C0e@sakura.myxoz.lan> <CAK7LNAQqJc74MGFyU6fvhM9VkDKYUXyCt0NF1qAr1RmfUqC0=w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 23 June 2022 17:44:57 CEST Masahiro Yamada wrote:
> On Fri, Jun 24, 2022 at 12:42 AM Miko Larsson <mikoxyzzz@gmail.com> wrote:
> > On Wednesday, 22 June 2022 03:57:34 CEST Masahiro Yamada wrote:
> > > If you want to say "use this option carefully",
> > > EXPERT might be another option.
> > > 
> > >     depends on ARC || EXPERT
> > 
> > Yeah, this would be a fair compromise, though I think it would be
> > better to use "visible if" instead of "depends on". I can get a v2 of
> > the series together if this is desired.
> 
> Why is "visible if" better than "depends on"?
> 

Technically it most likely doesn't matter, but logically it makes more
sense, since we'd make CC_OPTIMIZE_FOR_PERFORMANCE_O3 be visible if
we're on ARC or if we have EXPERT enabled, instead of depending on
them. But yeah, it probably doesn't matter.

--
~miko



