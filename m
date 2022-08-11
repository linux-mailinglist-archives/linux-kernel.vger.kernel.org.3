Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18F858FCC1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbiHKMsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbiHKMsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:48:38 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF35275CC
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:48:36 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id f28so16405313pfk.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=cheSiUk9PymoQVD7nE+6cqPn4hs1XlRBmEpyUVTqYsY=;
        b=wbj7DxgJDcpoKo/TKv9VO9o/3WuGmBZPD+D9H87SOosYRwBDuGjgAViBUj0k/bn8B6
         7aVCNKMjpBY6SDH90rHiWbWSR3jUk29zekRY73oEmUTMr6DpWgcUhvRyo0VJQJnp9C3Y
         WdLG7uWoU9bOCBckpqHdTm+3pHSirISLJfdqDigpf8TWoxDXpqfsfSHaYgt/VZ463wzw
         uPZdZoKXIFMD2fuGwcfb7kT+zQByhsQtS7AoC26SHefgvYr34749IhqTFIIRa7/469gg
         qCPHB8Eb4m5Uzxg8E0HlixlCHSWA9sR9Hjbs071zwDhlzwULGdV4PJoMmZV8XMJBWi08
         Q3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=cheSiUk9PymoQVD7nE+6cqPn4hs1XlRBmEpyUVTqYsY=;
        b=b+Ha5Al+7evzzcuBCEjwxMl1YeyoMb5Tx+Qau3Jo2kVxYDJSQoKq5K88l3GJAy/CuX
         vR648Tkda76gdUa7F7nZk1/W0iT3gjMHFovugkxsBq6cUclLwOVxjkm3QHegF4F+pW81
         /Xz0JqEV1g+IW+/5gnfe/z+2wcRaROH00EE/2wnBnVfmTg25dVCjVVs+aTdg7hLJZ1Oy
         e+u9Dvrq2rIj0p0tbgFV/jJAKGLYm2EikhZrrjg8cyO5wf6aD/DGhL5RnS7wxd4v76iF
         zh6YzwIWrk8Dh92VvqCYWeUWILOubk7PF8Y3DU/6piAoQJOQOoIWXgSD8VgdVot+IZha
         r8rw==
X-Gm-Message-State: ACgBeo0DzfVP0LlF+cP6CKIwMDgEeTRlDaXaAiOeIZjue+7po97/pBqE
        HqPbtuUYUgcB9sOINwv/pZqKTXJEIV2ADI8t
X-Google-Smtp-Source: AA6agR5YcEKbU2hA2wch00RrXvy+iHMvooiQHMUwICRVaYJ4pVPsnkccaSiS5qdNVcWthZpBhXGFyQ==
X-Received: by 2002:a63:d012:0:b0:41c:5f9f:9ab8 with SMTP id z18-20020a63d012000000b0041c5f9f9ab8mr27014922pgf.213.1660222116098;
        Thu, 11 Aug 2022 05:48:36 -0700 (PDT)
Received: from leoy-huanghe.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id r24-20020aa79638000000b0052ad6d627a6sm3872599pfg.166.2022.08.11.05.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 05:48:35 -0700 (PDT)
Date:   Thu, 11 Aug 2022 20:48:25 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools headers arm64: Fix compilation failure
Message-ID: <20220811124825.GA868014@leoy-huanghe.lan>
References: <20220811044341.426796-1-leo.yan@linaro.org>
 <48524c3d-c858-15ec-ac79-9547f3489b7b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48524c3d-c858-15ec-ac79-9547f3489b7b@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Thu, Aug 11, 2022 at 11:11:41AM +0100, Suzuki Kuruppassery Poulose wrote:
> Hi Leo
> 
> On 11/08/2022 05:43, Leo Yan wrote:
> > When build perf tool on x86_64, it reports failure for finding the
> > header <asm/sysreg.h>:
> > 
> 
> Please could you mention the exact build options used for the perf
> build ? (e.g, enable SPE)

Sure, yeah, I encoutered the building failure after I applied the
patch set; the first patch is to change Arm SPE code in perf.
https://lore.kernel.org/lkml/20220811062451.435810-1-leo.yan@linaro.org/

> >    In file included from util/arm-spe.c:37:
> >    util/../../arch/arm64/include/asm/cputype.h:183:10: fatal error: asm/sysreg.h: No such file or directory
> >      183 | #include <asm/sysreg.h>
> >          |          ^~~~~~~~~~~~~~
> >    compilation terminated.
> >  > There have no sysreg.h in x86's asm folder, alternatively, this patch
> > includes the sysreg.h header in the same folder with cputype.h to fix
> > the compilation failure.
> 
> Wondering how the "cputype.h" was picked up from arch/arm64/include/ and
> why not the sysreg.h ? Ideally, we would like to pickup the kernel
> headers as it is without having to manually fixup, things like this.

Actually cputype.h and sysreg.h both are copied from arch/arm64/include/
and they are placed under tools/arch/arm64/include/asm/.

> > Fixes: 37402d5d061b ("tools headers arm64: Sync arm64's cputype.h with the kernel sources")
> 
> Also from the above commit,
> 
> "That addresses this perf build warning:
> 
>       Warning: Kernel ABI header at 'tools/arch/arm64/include/asm/cputype.h'
> differs from latest version at 'arch/arm64/include/asm/cputype.h'
>       diff -u tools/arch/arm64/include/asm/cputype.h
> arch/arm64/include/asm/cputype.h
> "
> 
> Wouldn't we re-introduce the warning back ?

Good point!  Thanks for pointing out this.  So I think another option
is to tweak the CFLGAS for arm-spe.c.  The change is as below.

I will send patch out a bit later in today, please let me know if this
is fine for you?  Thanks!

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index d8fe514c9ec9..9dfae1bda9cc 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -289,6 +289,7 @@ CFLAGS_hweight.o       += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ET
 CFLAGS_parse-events.o  += -Wno-redundant-decls
 CFLAGS_expr.o          += -Wno-redundant-decls
 CFLAGS_header.o        += -include $(OUTPUT)PERF-VERSION-FILE
+CFLAGS_arm-spe.o       += -I$(srctree)/tools/arch/arm64/include/
 
 $(OUTPUT)util/kallsyms.o: ../lib/symbol/kallsyms.c FORCE
        $(call rule_mkdir)

