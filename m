Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBA95646EF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiGCLEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiGCLEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:04:05 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15A77643;
        Sun,  3 Jul 2022 04:04:04 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-10bd4812c29so3768716fac.11;
        Sun, 03 Jul 2022 04:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=u0zVGZoYgtTOd+SAbcJTxS84AcNCwMX7zpI5UFvbynA=;
        b=ZTEABohS1KvJe/RffzDVuksZzfm6Fua7DL+I22oQv2Y+j7erYS3GxzEL8wjtvTJEgK
         F+t/Ig+50bue8nOud7pc7ORnCa0aoDqD8tsZJkvScagFTJKecmDcmhm+fqyfO6ZWRS1g
         6ZorbtLMBO79MMTntY1OMvhR2FRm/IMlhWwOx7rvNUz3G2pQVF1bk9FCHWnV3feZ9GmP
         /hu1LEjh+ojI5FHpH+eq2OiNNO+0CBa45lHwk0N6S9FcJku1bN4c+g71GdROY3uLmQ7m
         mvsZRoYTZPPYJe4unYxnbkjo4ZL8vGk4iEOi8MV1Cvk5EzTRyO93kcm4fx6FY1GtD8XL
         ldAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=u0zVGZoYgtTOd+SAbcJTxS84AcNCwMX7zpI5UFvbynA=;
        b=mmvrShoSPCzC1mVN65FsHTHsL5gBdGMsUqgyopS92DoMe9+rJhi+wHDXLdABn4aWYy
         JdpVYI6BA5c/GGBJ9RtTS6kCoylTGpykr1TcQXocPYetI1bSejTjt2tX3EI9+ANxJ0S1
         jCEApjFxg3yQsrTgPepfyRIuhEHCRSZJOQtOwxKc2mJT9wWCdjzJ+nqW0X0hj7MzUpd8
         HV2fco9Clh069ebcBvq7uCshoCiJiXPRoATrfmgQcLqb7IocqWyvft9Prgnb5mmVyPiU
         RPIJbzwoAOrXV5Ceq1DLUGJLj4jZN3XQCQ0P3UGgPvaWGR3T88QlMzjUd7Z2BdcJq42i
         lkLQ==
X-Gm-Message-State: AJIora/t9Hr5emXZqQ5jXtKOklYMTXq5H9uf2iNdw9IQ0/MiRp0UF77U
        qsgZ9T939tDuIaAuBLQA1R+2JEUn8EaiHHx6bkQ=
X-Google-Smtp-Source: AGRyM1unUuK7vahMw1V9CqaHQ1nVCFvvfgPe3AwVZDgPkWkjejLOdkWJmuq3OsitS/2s/5WuVgT/FBm9EPoU7okldQw=
X-Received: by 2002:a05:6870:709f:b0:fe:2006:a858 with SMTP id
 v31-20020a056870709f00b000fe2006a858mr14737932oae.128.1656846244293; Sun, 03
 Jul 2022 04:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVVXq0Mh8=QuopF0tMZyZ0Tn8AiKEZoA3jfP47Q8B=x2A@mail.gmail.com>
In-Reply-To: <CA+icZUVVXq0Mh8=QuopF0tMZyZ0Tn8AiKEZoA3jfP47Q8B=x2A@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 3 Jul 2022 13:03:28 +0200
Message-ID: <CA+icZUW3VrDC8J4MnNb1H3nGYQggBwY4zOoaJkzSsNj7xKDvyQ@mail.gmail.com>
Subject: Re: [perf-tools] Build-error in tools/perf/util/annotate.c with LLVM-14
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sun, Jul 3, 2022 at 12:57 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
[ ... ]
> util/annotate.c:1766:33: error: too few arguments to function call,
> expected 4, have 3
>                              (fprintf_ftype) fprintf);
>                                                     ^
> /usr/include/dis-asm.h:472:13: note: 'init_disassemble_info' declared here
> extern void init_disassemble_info (struct disassemble_info *dinfo, void *stream,
>            ^
> 1 error generated.
> make[4]: *** [/home/dileks/src/linux/git/tools/build/Makefile.build:97:
> util/annotate.o] Error 1

This is with Debian's binutils(-dev) version 2.38.50.20220629-4.

$ dpkg -S /usr/include/dis-asm.h
binutils-dev: /usr/include/dis-asm.h

-Sedat-
