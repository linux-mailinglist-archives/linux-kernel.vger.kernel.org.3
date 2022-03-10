Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9964D41E5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 08:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbiCJHfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 02:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240101AbiCJHf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 02:35:28 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529247892C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 23:34:28 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v4so4499226pjh.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 23:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=pB6gK1JUXPe0uL+qrSzcwuxnE8NCS9QIX0sZYbeurTo=;
        b=lAb20Kihrehyn5GddRYNlLZde6SVbtLD6FzerIMv7eZvtL3sbdj+73S+tLhpNmw5UJ
         tshNHs/Mi7cANEP1Zj80aQ/N5B0sz2O5kjImG8/+T3cwq+8FG2XPkFmaHqa6/9chZ7g8
         /nOihdYxiR7PaKacSgWlLKnP207Jz1eV2gEFGOiGLn/I6vzc+PrfyUx+6/GNK9XFM73f
         r97IA57ckoafcvjVae9/dGfBjF2FeWg5v/Io4Cgwhgsompar72JizyqqaqRszXs+wYz/
         Hp9Cb3jtY2nMfID2JLvQRcs/WJdmvo2czFLzJQXcB1SgseLV+79NKd+T/7EjuUJzpXRp
         fgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=pB6gK1JUXPe0uL+qrSzcwuxnE8NCS9QIX0sZYbeurTo=;
        b=aTkp9Vn0n6kROyZbRCya/pKPRS/6oUFZd1Y3ttXA4EcQ+XGtuBGUtwWf2W3PU6ik6P
         b+VKhz9YyyYQNDRBNayxPaFw8cR143v9tMD3BY9SabsZPt2lMDCDb5aIqx1EnMXsdoBj
         /atIZIgpxV3QKeAria8SSgp7lCScb9kjfOjNCry2z2HUuA476RXMNfPrPPZfd86JgCLI
         e+UAnpHAwSYyQcK3iy6fxqOgUXTVcHF2Wa6bZxdayJTVBp7nHJSdM273b7S3Buj98x7Y
         qdHd5Ncqp2DmuxnfRTWeOBCToQXmutszm4YEN+Ge0CfTc7VnbvH+QH2rJaWftpGt8E8e
         ctcQ==
X-Gm-Message-State: AOAM530YLG7qrJQAYjGLevZCQuVMnDULeD9w844MSGTWUcyU0VuDSvIL
        +K/rPoyynsRFBChid5+kPpCnoA==
X-Google-Smtp-Source: ABdhPJz3jbz0Ao1c1aN34ZBdfv3vtjWtKrnKEumeNN4OD89F9XtIYbdZBYzODo25zFpeltVWYBT47A==
X-Received: by 2002:a17:902:cf08:b0:151:9d28:f46f with SMTP id i8-20020a170902cf0800b001519d28f46fmr3544457plg.53.1646897667710;
        Wed, 09 Mar 2022 23:34:27 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090ab38400b001bf9519fe8bsm7946653pjr.38.2022.03.09.23.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 23:34:27 -0800 (PST)
Date:   Wed, 09 Mar 2022 23:34:27 -0800 (PST)
X-Google-Original-Date: Wed, 09 Mar 2022 23:33:55 PST (-0800)
Subject:     Re: [PATCH] riscv: Work to remove kernel dependence on the M-extension
In-Reply-To: <CAK8P3a2Mr_z6h7eg1O8ZN5_qE-o+8KFFBum3CxyuDYeF50s1dw@mail.gmail.com>
CC:     michael@michaelkloos.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-1ed81282-b17a-43ef-9030-fc538d96892b@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Mar 2022 02:02:27 PST (-0800), Arnd Bergmann wrote:
> On Wed, Mar 9, 2022 at 6:28 AM Michael T. Kloos
> <michael@michaelkloos.com> wrote:
>>
>> Added a new config symbol RISCV_ISA_M to enable the usage of the
>> multiplication, division, and remainder (modulus) instructions
>> from the M-extension.  This configures the march build flag to
>> either include or omit it.
>>
>> I didn't find any assembly using any of the instructions from
>> the M-extension.  However, the BPF JIT is a complicating factor.
>> Currently, it emits M-extension instructions to implement various
>> BPF operations.  For now, I have made HAVE_EBPF_JIT depend on
>> CONFIG_RISCV_ISA_M.
>>
>> I have added the supplementary integer arithmetic functions in
>> the file "arch/riscv/lib/ext_m_supplement.c".  All the code
>> contained in this file is wrapped in an ifndef contingent on the
>> presence of CONFIG_RISCV_ISA_M.
>>
>> Signed-off-by: Michael T. Kloos <michael@michaelkloos.com>
>
> The patch looks fine to me, but I increasingly get the feeling that the
> entire platform feature selection in Kconfig should be guarded with
> a global flag that switches between "fully generic" and "fully custom"
> builds, where the generic kernel assumes that all the standard
> features (64-bit, C, M, FPU, MMU, UEFI, ...) are present, the
> incompatible options (XIP, PHYS_RAM_BASE_FIXED,
> CMDLINE_FORCE, BUILTIN_DTB, ...) are force-disabled,
> and all optional features (V/B/P/H extensions, custom instructions,
> platform specific device drivers, ...) are runtime detected.

That'd be wonderful, but unfortunately we're trending the other way -- 
we're at the point where "words in the specification have meaning" is 
controversial, so trying to talk about which flavors of the 
specification are standard is just meaningless.  I obviously hope that 
gets sorted out, as we've clearly been pointed straight off a cliff for 
a while now, but LMKL isn't the place to have that discussion.  We've 
all seen this before, nobody needs to be convinced this leads to a mess.

Until we get to the point where "I wrote 'RISC-V' on that potato I found 
in my couch" can be conclusively determined not compliant with the spec, 
it's just silly to try and talk about what is.

> At the moment, those three types are listed at the same level,
> which gives the impression that they can be freely mixed.
>
>          Arnd
