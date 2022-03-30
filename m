Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28104ECB46
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349683AbiC3SG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349658AbiC3SGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:06:54 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AD23AA48
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:05:07 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 17so28809750lji.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1gCGwBlFlPL7xlbgg8fVcArt1vxjlSJemINBQ6Dyvg=;
        b=pMOXFcNHgVw7MlgZ7yYEI8OIqBpCv7hHzDMln+BSnSNY+w1UBH0/mnhDTZYa2wz++N
         IVZAMs/0+Z7g4aFR7yNZrUVVucG6aeelreqX9D7ZHzcKwl0F7oYarSvbe0tnlzrgvk+6
         W0K/ANA7r6PjVTNIuVEDV7Cys+j8mpQwF7lLgTlgIL0FYGJD7tQGEPqGPYk9j0eVvPiW
         eWgbjzjR2B/gVYNdkAUT5ViAdlRMOBHxjDroMB7/wYDFp+qjh11p4MipYiygqNY/hK1W
         fQ4RILJY0OH1PCnJ/3CWJ4F5ZjF8Q3G96ruwjh2RHp5Ni34Y+kG+Znu09MLeRmtxEh8R
         rgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1gCGwBlFlPL7xlbgg8fVcArt1vxjlSJemINBQ6Dyvg=;
        b=J2R/uTtVNC6KX2NLyYf+OGAS2fata16zk592T0IokBBZXo4mkp8aXC/1ljcwX7TCu/
         ltMjWdIQBPR7E5+DuSApTbXNGejsYYD8l561DNeLZVNT5DXbwwtQtZ1JXoKDjXwrwFZh
         qEs+S740478FVUbQxLp5ngZKDzTXPFM9N8Y8GnKj22rlCBbdHBWNNqAxiPMtFlxhK6V9
         /hkc07peCZj/8YdXLhUeLrxDaCJHkeC+k2Mf760OX5k6TlWbmvRn9W8elXcIZxhKSY4u
         h163yNWvMTLPUszRY0w6lBN5zVO1Vr8yDtcUH9qxtauFZXYhpMHsiZ3wAzcDJE6niKG1
         GygQ==
X-Gm-Message-State: AOAM533r2oKLDdWiXm5w5eHmdxp4EYvZ0otmWMWV2IFaSnR/20/L84pR
        YGWcf9YnGEPgGuQLnQJ6pc26PXQszrmuVuw7LjFeQWaqvuI5D+9w
X-Google-Smtp-Source: ABdhPJzOPCdLzAuEzhP8+XwDRinp5ZhGqb9riWqDAp9YgXyUtPNaoWWz9lFTRmIqu6uYrLte8Tx/X6kn1S35WUT6kUU=
X-Received: by 2002:a2e:7808:0:b0:24a:eacb:ab9f with SMTP id
 t8-20020a2e7808000000b0024aeacbab9fmr3138533ljc.468.1648663501997; Wed, 30
 Mar 2022 11:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <164847778869.3060675.8115416881394543419.stgit@devnote2>
In-Reply-To: <164847778869.3060675.8115416881394543419.stgit@devnote2>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 30 Mar 2022 11:04:50 -0700
Message-ID: <CAKwvOdmAYQZtzGudBjmiRZNjT+VixTdNbJmYmxc7-gQNCsHfrA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] bootconfig: Support embedding a bootconfig in
 kernel for non initrd boot
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 7:29 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> KNOWN ISSUE:
>
> According to the report from Padmanabha[3] and my analysis [4], the embedded
> bootconfig data may not be updated if you do incremental build the kernel
> with CONFIG_LTO_CLANG_THIN.
>
> [3] https://lore.kernel.org/all/20220321183500.GA4065@pswork/T/#u
> [4] https://lore.kernel.org/all/20220327115526.cc4b0ff55fc53c97683c3e4d@kernel.org/
>
> This seems like clang's LTO Thin mode issue. It may not detect the inline
> asm depends on external files.
>
> I think the possible workaround is to split the inline asm which includes
> '.incbin' directive into an asm file. But this should be done in another
> seires because there are other features which uses '.incbin'. (e.g.
> /proc/config.gz)

Hi Masami,
I saw Padmanabha's report (thanks for the report); sorry for not
responding sooner, I've been traveling recently for a funeral.

Any chance we can use

CFLAGS_REMOVE_<file>.o := $(CC_FLAGS_LTO)

a la
commit d2dcd3e37475 ("x86, cpu: disable LTO for cpu.c")

with a comment linking to
https://github.com/ClangBuiltLinux/linux/issues/1618

for the Translation Units using .incbin, until we have had more time
to triage+fix?

-- 
Thanks,
~Nick Desaulniers
