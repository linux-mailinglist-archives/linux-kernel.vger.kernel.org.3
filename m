Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED705A0188
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbiHXSox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 14:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiHXSou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 14:44:50 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84E362D9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:44:48 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id l8so7676234lfc.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JTYkOn2/lJTDmbf1Y5o6kNVGh/wX3WwhysufbkHfkwE=;
        b=ITiSSNp34hiy/4MmcU+rJfM6ZUYMX8XQuWeU/gRfqufx92hmheTjQV9dQ4RZT/X6AW
         mGKIVuBDQskZHbvErnRVFXnY30xzHX4/muyCFkPLdW67IjnLDOA2GvMPoM+ZIlEIu6cY
         CPob6W8ogYEDqiUNIvxloyOBGeV3mwQqDk8gCmCjOudypaMdUaxZKLMKNtb4yjMPqXap
         fQgm/iH26WfW5w/6T0GJAMGjh9I7IYX7mhfVs5ZaKENu59/AcP6QIjoMxXrIjrOE/U3B
         hTQrXaAmlCkSF/eKm5pMbYbG6Ux7ZSyiMkrWrdSD5rJUEk3KZe0UrIXbGIM/XaBIMa3N
         tXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JTYkOn2/lJTDmbf1Y5o6kNVGh/wX3WwhysufbkHfkwE=;
        b=JTFKWQ8+77zLsPSVXnqTSrQ8R/uZGR8zAvWc3HgUyyPQir8bBULMqs9L3aApVoZYhF
         LHtWY78CxqavVL0kXDwKT93WTuCM+lhP9bBmOlB1jqd80FXktXGjBJshOqO3tT1oomhc
         nYoJQzim8BEEbr4t6A0G/mpr/LJLKt1WP6o2F7uHb6wOorZKNjk7o/Rx5DexmHd3DJ5t
         FaYZmqZnL87B9dquPXIISDNhPX/YDutoHVZd+4P/yLqjDhFKWvIlNl/YrPjYSdZCLvai
         YCb19v0Dwx7UTG03y4D04vfqGonLJHOTnI0AscJRHCOSsvlNEkbWLdglg2OcJUwe93XR
         XkZw==
X-Gm-Message-State: ACgBeo3YB00PF0uOUEb3G6RIhRv9WldgwI8ZgFg9etiOw+Crn93Ecp/f
        DbIqpm4JaC4ZJeIhygEyCpjazHSkYwF3Ry7PQvErgUEhpFc=
X-Google-Smtp-Source: AA6agR7E6A7xBhZ8TnKs/WZv8qFVsc3CQb2aM5QheWrBMPV8dC7OHW37Q6b9CHQSET33+I8e7EyDdD0eop33I/LPo/8=
X-Received: by 2002:ac2:4f03:0:b0:48a:6061:bd8e with SMTP id
 k3-20020ac24f03000000b0048a6061bd8emr83360lfr.647.1661366686878; Wed, 24 Aug
 2022 11:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220824152420.20547-1-bp@alien8.de> <20220824172929.GA25951@gate.crashing.org>
In-Reply-To: <20220824172929.GA25951@gate.crashing.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Aug 2022 11:44:35 -0700
Message-ID: <CAKwvOdm+yFhZ2pYLJ5vpj1YyNJmG=UVF4cTz_m+0UfDGNGsRbQ@mail.gmail.com>
Subject: Re: [PATCH] x86/sev: Mark snp_abort() noreturn
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Michael Matz <matz@suse.de>, linux-toolchains@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 10:33 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> Hi!
>
> On Wed, Aug 24, 2022 at 05:24:20PM +0200, Borislav Petkov wrote:
> > Mark both the function prototype and definition as noreturn in order to
> > prevent the compiler from doing transformations which confuse objtool
> > like so:
> >
> >   vmlinux.o: warning: objtool: sme_enable+0x71: unreachable instruction
>
> Would -Wmissing-noreturn have caught this?

Oh, that's shiny. Is that relatively new?
-- 
Thanks,
~Nick Desaulniers
