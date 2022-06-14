Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB9054BBAB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357867AbiFNU3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352859AbiFNU3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:29:16 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB2129828
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:29:15 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id d19so11014901lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JelMl5DE/hcbFl5tXcWcJ+M0I+5jYzJldxTFoClo8B8=;
        b=Xo+FI0P1jCUF7cy7Lv1fCtt7r5lBUn6zSriIjnvp0F1pfVRH+Vuuxu8H9IcHCzIxY4
         mc4GecxJHZ/9YFJkOHxQseHs7FM94FItM+1n7gX95nIBxc3IShK5NzppIwxn9rBOQV0Y
         R5CRzw+Ed2uWpwpBK4/iyuvp+BjWFGfA0FLvKR2FVY32qxgJU6l458tSkSvTQWDBSq5H
         XQdDoEZF2flZtIENnDFp4aPDR5WMXQqiO12CFaS3NAHEI8tRw5bMd2Ot4IDRjOHsY/bS
         fl1XlW/x8iUSN4uKcWBketxI+QmhJOYT8YgWCvDmEmTQoFPr1ObugpnpaYTQTzptS+qD
         z5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JelMl5DE/hcbFl5tXcWcJ+M0I+5jYzJldxTFoClo8B8=;
        b=bajH5WAWR12gyISdODHR+q5P0cHfPnEZvGkkmMlB4eurvVWuna0keLdujMGlA5SHTc
         CQcD3/VLjs8v/DS+NoVXHMnVJLJB5fGLoHnIa64DJ8UYC9PMW4s6JxQw0CrFewcaoBOJ
         BhRYM3MhAsRBQDhjaJDbqtguWYOFWT6AbPLg6D0Ba/xa31omwTGDg4k0Z2EtaMDTkZoK
         ZFG4YRtHujAvvfaBwAvlxSQ43KKZ4pTmfNBWbHNBF4rm4PZyraYqYXboYGAqnnu9pbec
         uarxaI0C+/Utxr/HYN+Cx3IDVdrRXr8wWxsx9h9Dt51z2A0G24p6vZ6hiUSWCjhV2rnH
         auiQ==
X-Gm-Message-State: AJIora9eBCC/d020EvDP6OPQiwmkL+bYEAUoInZQVd29cqxOpfvzlS+z
        e6EgKohZxPHzwBozdeqYk+E5VfLNHXckdIT5wTDuPQ==
X-Google-Smtp-Source: AGRyM1uqTOBp6a2xrVdhdGv7VkBK65jaqX8HjIXLaJChc8NThMPOjHL62L7SARvKS0b0k54p0tLUcBB00SsNkoe4hbs=
X-Received: by 2002:a2e:6e06:0:b0:255:753d:f119 with SMTP id
 j6-20020a2e6e06000000b00255753df119mr3576613ljc.93.1655238552862; Tue, 14 Jun
 2022 13:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAMZm_C=o-rc4a+u_8-pFJtmL_2drwczASMRTqszamrks5Zm_OA@mail.gmail.com>
In-Reply-To: <CAMZm_C=o-rc4a+u_8-pFJtmL_2drwczASMRTqszamrks5Zm_OA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 14 Jun 2022 22:28:36 +0200
Message-ID: <CAG48ez2PVMs-CeLoZtvPq2EeQqOg05mm3AuvEE_pr9Sog0O5og@mail.gmail.com>
Subject: Re: pgprot_encrypted macro is broken
To:     Federico Di Pierro <nierro92@gmail.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
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

On Tue, Jun 14, 2022 at 3:15 PM Federico Di Pierro <nierro92@gmail.com> wrote:
> In our kmod we use the `pgprot_encrypted` macro.
> It seems like the macro cannot be used on 5.18+ kernels because commit
> b577f542f93cbba57f8d6185ef1fb13a41ddf162 broke it.
>
> Basically, the macro definition was:
> `__pgprot(__sme_set(pgprot_val(prot)))`
>
> but after the commit, it was changed to:
> `__pgprot(cc_mkenc(pgprot_val(prot)))`.
>
> But `cc_mkenc` symbol is not exported!
>
> This leads to build issues:
> > ERROR: modpost: "cc_mkenc" undefined!
>
> Is this a bug?
> Is there any workaround?

Why does your driver need to use that macro? pgprot_encrypted() is
mostly only directly used by core kernel code, not by drivers... and
if memory encryption is enabled, almost all memory mappings created by
the kernel should be marked as encrypted automatically.
