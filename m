Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A02E4C493E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242229AbiBYPjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242221AbiBYPi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:38:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BB81CF0A6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:38:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF86BB82D04
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 15:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95084C340F6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 15:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645803502;
        bh=Qp6aGn+gfpXQjgM8XZgj/bDqpiOmsivhTJEvuTz+fDA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vKYh1x0GLneHhE/0yXjH1+P2NcfgvGJ3rCBu/pBYythxhJYskOaY0cmc7hWO4hiPz
         68HtLHzakEQIt9ab4Oh9cw7bOTzhwh+6FB/vhIbFOQU+sQerX5/FIxGW+iEGN9b2NJ
         QbnFnvcW6iL0ElUVoOpWEik/X3w82RwNCbmdYvQWoxvBQTqI1yS7C5hgMgwx1/6750
         MR2ctkpc7CDcrWOGB07E7GwZY4AOzEqk1VQyG+269hgNHnaTA2X2g97sWnSVV8HZV/
         vY5Aw9WvYq/cnbeUBCD33rTerbIScpj1+E3HCzJftDyqekClorrI5KpA0qMfwcuJfb
         Z+RUrCbwGQZqg==
Received: by mail-yb1-f169.google.com with SMTP id e140so6599586ybh.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:38:22 -0800 (PST)
X-Gm-Message-State: AOAM531O7aGf1SgoplQFeo0q6EGLultl1qh0siN7jA9LZ9xtmbmmxH/R
        GhpST9Oki1ccjgKb8rXf0G+Eq7nxxZpvWGQ9tF8=
X-Google-Smtp-Source: ABdhPJx3rvESMXLxmCbN7BFFRnF9VG0LfFW9lEx0SZZrJ9ggiEnkwCvqiu8bEDq0wko4R3DdaAXk1mMrwpgvYOmaWJ4=
X-Received: by 2002:a25:6c43:0:b0:61d:e94b:3c55 with SMTP id
 h64-20020a256c43000000b0061de94b3c55mr7907145ybc.224.1645803501561; Fri, 25
 Feb 2022 07:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20220222165212.2005066-7-kaleshsingh@google.com>
 <202202231727.L621fVgD-lkp@intel.com> <875yp63ptg.wl-maz@kernel.org>
 <YhYpvfZaSjrAtkZp@rli9-dbox> <cb750267af0636c49d2f8aa354f086a5@kernel.org>
 <CAMj1kXHsNsQXbeeS1zcy+xYA7kSE5apbLpChohfvkABS7Z6jKg@mail.gmail.com>
 <89c48bd2a9b32b4607d1515714fa3c1b@kernel.org> <16f47fa9-90b4-0b5c-33cb-cb004fc39266@intel.com>
In-Reply-To: <16f47fa9-90b4-0b5c-33cb-cb004fc39266@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 25 Feb 2022 16:38:10 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEfsxj44t13rpgNddvTeM3qgfv5zU_xpnxn7HV3xUN2YA@mail.gmail.com>
Message-ID: <CAMj1kXEfsxj44t13rpgNddvTeM3qgfv5zU_xpnxn7HV3xUN2YA@mail.gmail.com>
Subject: Re: [kbuild-all] Re: [PATCH v2 6/9] KVM: arm64: Detect and handle
 hypervisor stack overflows
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Scull <ascull@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 at 03:12, Chen, Rong A <rong.a.chen@intel.com> wrote:
>
>
>

> Hi Marc, Ard,
>
> We have ignored the warning related to asmlinkage according to the below
> advice:
>
> https://lore.kernel.org/lkml/CAMj1kXHrRYagSVniSetHdG15rkQS+fm4zVOtN=Zda3W0QaEoJA@mail.gmail.com/
>

Excellent! Thanks for implementing this - I wasn't aware that you
adopted this suggestion.

> do you want the bot ignore such warning if asmlinkage not specified?
>

Even though I think this warning has little value, I think asmlinkage
is sufficient for us to avoid it for symbols that are exported for use
by assembler code.

So I don't think this additional change is needed.

-- 
Ard.
