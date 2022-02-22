Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB6C4C051E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbiBVXP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiBVXPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:15:54 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481C88BF6F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:15:28 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id ck4-20020a17090afe0400b001bc64ee7d3cso1017957pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=5pE50TTDWFLueJKrt7WZSWbPDAQlxEYigig8ufnxSqw=;
        b=MomlBqvzX/EV4d871QSkrxnPcNmppWaV+rJ5eU0e7Zw3bAOk01v1rBmpiWbTUT9VH5
         BOtWmYtrGqVHpApv9N2nYi7AmBk5kNAH5vhT8k7DyGgeSyDvdMfN1p7qIXDw45Nx28ps
         Yg1gWSViHyjbxkE7Y8hmm1rsMV05a3io++T+1HgLp8ZIeZgQ6zS049SyP8s2fQhV25I1
         zHNdfoR2d7nzrwqXP5+Jh88vRj/Iq8wqiLRSYSCCrClUEK20e7HvBCq+2U2zos9KtiUa
         A4u6m6iHcuGFdPCRZuS7/GeAQZIAhL61rvkByDSvMD73FkAsVvC4QF+7wxrQugiShAz7
         koPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=5pE50TTDWFLueJKrt7WZSWbPDAQlxEYigig8ufnxSqw=;
        b=yomD89elAVl/6ET+cMoJ/IYJ0QcWEcvQJKc+jI0aevWwOr2elb2lQxTRzzYEre9Wxj
         kmYyKXCwLKt+SA51OTc7GUI0PpFQCnGpZqtKxUnKLR6lr969R24pCyuuh4dzDxv8B4S+
         moPrvXGs0OHvPTfn/6qQsX2bt1IkGIYi0JSuf09HEexo3iklMv4Qbu+5ejLrJ5kDuxXx
         3hY9LiCDdiUkA9u6ujbN88ZyXgl5QkPFUlQLmzPfNqPrXmmBGF1UF0u2ClNatQQyYIBP
         bkvmIkRY8ZCzhw9CNuWIl2biGpVrLmf8MH4nF8h6iHEM5lxsLsZKyXw9kmGLHVeKntgh
         gvTQ==
X-Gm-Message-State: AOAM532u6K4mmSBknZn9o4JC9Ndqbzf9YvhL6vpHxLQKeYSClN+wXsUP
        8vryCnAwIZznUwgqXFi1ZGkVSw==
X-Google-Smtp-Source: ABdhPJyyATbltkiRInaszXFhi6tfmEasdHLKV+OMPMQ0rqqSD4GjJ3HZPfOe27ft9wDuT8FYyHr8ow==
X-Received: by 2002:a17:90b:4cc6:b0:1bc:210d:b6fa with SMTP id nd6-20020a17090b4cc600b001bc210db6famr6416375pjb.104.1645571727708;
        Tue, 22 Feb 2022 15:15:27 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id h21sm17640393pfo.12.2022.02.22.15.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 15:15:26 -0800 (PST)
Date:   Tue, 22 Feb 2022 15:15:26 -0800 (PST)
X-Google-Original-Date: Tue, 22 Feb 2022 15:14:36 PST (-0800)
Subject:     Re: [PATCH v2 0/7] Module relocation fixes and asm/insn.h header
In-Reply-To: <20220131182720.236065-1-kernel@esmil.dk>
CC:     linux-riscv@lists.infradead.org, kernel@esmil.dk,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, peterz@infradead.org, jpoimboe@redhat.com,
        jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
        alex@ghiti.fr, jszhang@kernel.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     kernel@esmil.dk
Message-ID: <mhng-8e6926b7-c690-4398-a70a-072b11d7e6fa@palmer-ri-x1c9>
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

On Mon, 31 Jan 2022 10:27:13 PST (-0800), kernel@esmil.dk wrote:
> Apologies! I messed up v1. Please consider this patch set only.
>
> The first patch removes a bunch of code from the asm/module.h which is
> included in almost all drivers through linux/module.h. Next are two
> patches to fix unaligned access when doing module relocations and do
> proper range checks for auipc+jalr offsets.
>
> I'm a little less confident about the following patches, so consider
> this more of an RFC for those. The idea is to consolidate the RISC-V
> instruction generation and manipulation similar to arm64's asm/insn.h
> header.
>
> /Emil
>
> Emil Renner Berthing (7):
>   riscv: Remove unneeded definitions from asm/module.h
>   riscv: Avoid unaligned access when relocating modules
>   riscv: Fix auipc+jalr relocation range checks
>   riscv: Add asm/insn.h header
>   riscv: Use asm/insn.h for module relocations
>   riscv: Use asm/insn.h to generate plt entries
>   riscv: Use asm/insn.h for jump labels
>
>  arch/riscv/include/asm/insn.h       | 121 ++++++++++++++
>  arch/riscv/include/asm/module.h     |  87 ----------
>  arch/riscv/kernel/jump_label.c      |  12 +-
>  arch/riscv/kernel/module-sections.c |  71 +++++++++
>  arch/riscv/kernel/module.c          | 237 +++++++++++++---------------
>  5 files changed, 306 insertions(+), 222 deletions(-)
>  create mode 100644 arch/riscv/include/asm/insn.h

These generally look good to me, though there's a lot of bit-field 
twiddling so I'll take another look before merging it.  There's a 
handful of minor issues:

* There's a fix in here, mixed into the cleanups.  It's generally best 
  to split those out.
* There's another copy of the insn patterns in our BPF JIT, it'd be nice 
  to clean that up too.  That can be a follow-on, though.
* It's 2022, but there's some 2020 copyrights.  If this really is old 
  stuff that's OK, I just wanted to check.

I'm usually OK just re-ordering patches myself, but I figured I'd have 
to ask about the copyright dates anyway.  LMK if you want to send a v2 
with the fix pulled to the front, and what you want me to do about the 
copyright dates (if you're going to send a v2 then just fix them, but if 
you're not then just telling me is OK).

Thanks!
