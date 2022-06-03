Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9D553C901
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 13:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243895AbiFCLCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 07:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243877AbiFCLCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:02:09 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C62DE90
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 04:02:04 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id r3so5982086ilt.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 04:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGV5SsKbSd2QdHPl8LR4HxzpZDbxIoUIGiTmzmYRICU=;
        b=pTs3iB6pTzJtRvoxfh2eEuGwMr+d8vioWpsetePj816n7Tz/NNC3l3FSOFVCXMdeZk
         hLP1SWblTC+U/6yblN8X9EqpqlTpsWqNQ7byW1YxdPwSszlYgLPsHl3TUYr95POo++/A
         kEyw+rAg0a7K9btirU4Bcpt+Q0+NBAid/pLfIqCU6ytkFT9cUx+8LJ4FAwnn3a1DGDk4
         eQWpRiVM3vQyUh2MQrVRYdVSVskdGf2A4UWNvaOzYAh0AgQAIEHnUWoTt0J8b31q5w6o
         xts8eVhu8x+eR3ZtQxfybwkt3ljALAD+9jtOkE9DKO7+t9IrPieSsQoZwPB+Ls/iINT4
         XCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGV5SsKbSd2QdHPl8LR4HxzpZDbxIoUIGiTmzmYRICU=;
        b=biasovN/99XBYbZFMAdNda9nrSaix8mokUgHegyZ3kN0PrOGLfq++gNMDM9ot9rZ5R
         Q8yOjeRiJBDxkAqphk5tcoFurJ2CseiHN1v+QTeB6i5qbVVtgbXXes3jKKLCiAzpmE7B
         rYlsiCeA7lqc7dx/MtsjFFaPr0G1b39FS47jxV2+cTVGHad8W3Ggz/HvXhL4NIZX+8yV
         s6IPOxx52WukWxPRWTa36DMmvRG/yxAsEpBEhIX2hEn8tbF42p8WtCxyBmlmhsC+fFau
         JYQbRE/dkYXt+D2ZHsU35JuDJsrmBqt2U3Sg7/+8ayhoBfqR7TmVBCPCIpHjPSYg21YD
         XKkw==
X-Gm-Message-State: AOAM532YezTYjHkH7LZG3M/HRST/mD0sRhNQNrNNjrJRlGjBE7IGm12B
        u3o9sXSdrBcIxZNiFxCIjgdKTkYiEUpCuHUOdpE=
X-Google-Smtp-Source: ABdhPJxV7dB9gEgpQyA2p3QXnsAEKKA1bjMJgQFfQx59SR/96koLig1G7LYsfePBxG02Vo2liG0CZrJjqV9KdJVMJHY=
X-Received: by 2002:a05:6e02:1c82:b0:2d3:b7c2:1129 with SMTP id
 w2-20020a056e021c8200b002d3b7c21129mr5634371ill.237.1654254123233; Fri, 03
 Jun 2022 04:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <202205240321.sb0gX2mq-lkp@intel.com> <cdd02535-b446-5547-4fdd-6deaf3fba6a6@intel.com>
In-Reply-To: <cdd02535-b446-5547-4fdd-6deaf3fba6a6@intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 3 Jun 2022 13:01:52 +0200
Message-ID: <CANiq72k69wUZxvCeJFH3=9LsyjT76XFcfbf5aKZbb-u91wMmkQ@mail.gmail.com>
Subject: Re: [rust:rust-next 2/24] ld.lld: error: kernel/built-in.a(kallsyms.o):(function
 get_symbol_offset: .text+0x5f0): relocation R_RISCV_PCREL_HI20 out of range:
 -524435 is not in [-524288, 524287]; references kallsyms_names
To:     kernel test robot <yujie.liu@intel.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, kbuild-all@lists.01.org,
        llvm@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Jun 3, 2022 at 12:32 PM kernel test robot <yujie.liu@intel.com> wrote:
>
>  >> ld.lld: error: kernel/built-in.a(kallsyms.o):(function get_symbol_offset: .text+0x5f0): relocation R_RISCV_PCREL_HI20 out of range: -524435 is not in [-524288, 524287]; references kallsyms_names
>     >>> referenced by kallsyms.c
>     >>> defined in kernel/built-in.a(kallsyms.o)

There are similar reports for the same relocation type in trees
without Rust support merged, so this might not be being triggered by
Rust itself, e.g.:

    https://lore.kernel.org/llvm/202206010956.rOpdU4dr-lkp@intel.com/
    https://lore.kernel.org/llvm/202205280837.PPVZBhXr-lkp@intel.com/

Cheers,
Miguel
