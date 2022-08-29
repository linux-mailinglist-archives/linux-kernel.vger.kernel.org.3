Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80575A55CE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiH2UxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiH2UxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:53:10 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C965A7C1FE;
        Mon, 29 Aug 2022 13:53:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3C39A6E2;
        Mon, 29 Aug 2022 20:53:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3C39A6E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661806388; bh=FT/boG8NCbfvG3WRa48iItFzgVTCXb0NFZB0UWFeiGg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NHC6PkdKcWYSjp44yMzBVq2SxcEc0rM/XOlGel418c+Ab1943ifZ73MffX00kOuKh
         Xa7NC8qA0v5Rev9CJXWbqtFfKqs6Gn6KdYvh0pnRBF49bb1ScarG5DUi3lP9OgwwTb
         2umld9zq/1HK9X7Mq5TjVVuDoGLH5CxQ37529ugQJVYLekoxwStQAgw/kT0MIu80yL
         senCNTHzHIdMRtdGeLWdMqJ77q4+GuhhO7fwwr/ijN+r92oDQAeY9aQUOJ9AXzzwXF
         xSqyhjWIjCR9na+KhfLwNSSngyshiQXIzEdCutqqhYEsPW9IkyWfKEAm1mJkh3d8Bb
         sWOJepDQdPRkQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>, Robert Elliott <elliott@hpe.com>
Cc:     mpe@ellerman.id.au, nanya@linux.vnet.ibm.com, asahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/core-api: expand Fedora instructions for GCC plugins
In-Reply-To: <202208291225.A0D3FAFC@keescook>
References: <20220827193836.2582079-1-elliott@hpe.com>
 <202208291225.A0D3FAFC@keescook>
Date:   Mon, 29 Aug 2022 14:53:07 -0600
Message-ID: <87fsheojpo.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Sat, Aug 27, 2022 at 02:38:36PM -0500, Robert Elliott wrote:
>> In Fedora 36, cross-compiling an allmodconfig configuration
>> for other architectures on x86 fails with this problem:
>> 
>> In file included from ../scripts/gcc-plugins/gcc-common.h:95,
>>                  from ../scripts/gcc-plugins/latent_entropy_plugin.c:78:
>> /usr/lib/gcc/aarch64-linux-gnu/12/plugin/include/builtins.h:23:10: fatal
>> error: mpc.h: No such file or directory
>>    23 | #include <mpc.h>
>>       |          ^~~~~~~
>> compilation terminated.
>> 
>> In that distro, that header file is available in the separate
>> libmpc-devel package.
>> 
>> Although future versions of Fedora might correctly mark
>> that dependency, mention this additional package.
>> 
>> To help detect such problems ahead of time, describe the
>>     gcc -print-file-name=plugin
>> command that is used by scripts/gcc-plugins/Kconfig to detect
>> plugins [1].
>> 
>> [1] https://lore.kernel.org/lkml/CAHk-=wjjiYjCp61gdAMpDOsUBU-A2hFFKJoVx5VAC7yV4K6WYg@xxxxxxxxxxxxxx/
>> 
>> Fixes: 43e96ef8b70c50f ("docs/core-api: Add Fedora instructions for GCC plugins");
>> Signed-off-by: Robert Elliott <elliott@hpe.com>
>
> Thanks!
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Jon, do you want to take this since it's entirely in the .rst file?

Yes, I'll do that.

Thanks,

jon
