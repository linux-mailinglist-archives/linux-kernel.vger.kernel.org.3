Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C7B58BA71
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 11:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiHGJjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 05:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiHGJjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 05:39:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4437D5FE3;
        Sun,  7 Aug 2022 02:39:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gb36so11777861ejc.10;
        Sun, 07 Aug 2022 02:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+ZZ4LtDa0Oze2baYowb91yA7OENsUYsoGJT2EuU8wW4=;
        b=MPTb2SvWdI+IocN/btOQmvU1EmNejfQitWsSXkNeCF3dz7yawIQqT/DaoIzKH9fjV7
         XOuoMZpDr28wbZA/zohHyZwOM6ztNbHz0f8KHVrAfGF5OsLS29gMniO5GOvtHwplQF7A
         B2tsHHcXPro8B+iP8lOB/rYFv4faWYqIAgN6kgcse4Qx2OnUaLD04IBM1OD7WA2Meywa
         3AKC0fYY1HM1+iyf5gQ5lxcBVSWlvkhS3Q4mrxELXyJuBiRIfBnfoHxDf2HDE1DaIp3w
         wmBu9n5jILbeekBZ0z44ZFQE0zc2j11r9H0PonvFwmDriqQdu9e4NyrsLpxXx5EhYNrJ
         cUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+ZZ4LtDa0Oze2baYowb91yA7OENsUYsoGJT2EuU8wW4=;
        b=cRR51ZxmDMeU719wiP/1GUp+c4nNNkmsNZW71b2tTtMsURQfTDOi7IY8wvb7U/NMLv
         EcapfGiVHloivjSDoCDJuGWbsyFlXekKdwLuLBEK5Eh3JfsktqQjHqn5YUq2BgHm9/zR
         jvEu+GgQMZB+9ZgQ3aneaYkX98k4X/o74bhQq/3sjbQy6HcEITPKRpVTM3b6Ms/qHSXK
         6r4u3ATxbr80EpRL71fNP6/cd8a0eAxSpa5gXAfSRhkaoGVQeiq3xhLJ4HqLe6KFZP3X
         9Lm/ePr0tka/xojwrXJTxP2vXJUZTCmam362s2IXl4/yqzDWKXmzDwpJTQcldh/iNq90
         5S2A==
X-Gm-Message-State: ACgBeo04QC0COOf87plpgJFEZPc98fUuC2fY4AYkYXClzclDz6ux/HYK
        dd0R/aSWn6LUnIysdENqpBNl5X0IA8s=
X-Google-Smtp-Source: AA6agR60f+DtVE9ZpquxMPl+wOrHGRqLTl1D/v831PhC05cjwrAVL76Vo5EtH9r3iFD9LTQ4Lt316Q==
X-Received: by 2002:a17:906:845c:b0:730:bbf1:196a with SMTP id e28-20020a170906845c00b00730bbf1196amr10495293ejy.13.1659865188755;
        Sun, 07 Aug 2022 02:39:48 -0700 (PDT)
Received: from gmail.com (195-38-112-141.pool.digikabel.hu. [195.38.112.141])
        by smtp.gmail.com with ESMTPSA id x17-20020a170906711100b007304f4107f9sm3606161ejj.52.2022.08.07.02.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 02:39:47 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 7 Aug 2022 11:39:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: remove the target in signal traps when
 interrupted
Message-ID: <Yu+IYuGUAajZVnUF@gmail.com>
References: <20220807004809.69076-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220807004809.69076-1-masahiroy@kernel.org>
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



* Masahiro Yamada <masahiroy@kernel.org> wrote:

> Reported-by: Ingo Molnar <mingo@kernel.org>
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> If you are happy to help test this patch, that will be appreciated.
> 
> Without applying this patch,
> 
>     $ make -j<nr-proc> 2>&1 | tee log
> 
> Then, you will see an error reported in [1].
> You may need to repeat it dozen of times to reproduce it.
> The more CPU cores you have, the easier you will get the error.
> 
> Apply this patch, and repeat the same.
> You will no longer see that error (hopefully).
> 
> 
>  scripts/Kbuild.include | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)

I've tested your patch on a system with 64 CPUs on the latest upstream 
kernel, and without your patch I was able to quickly reproduce the 
corrupted .cmd files within 4-5 interrupted kernel builds:

  fs/xfs/libxfs/.xfs_alloc.o.cmd:5: *** unterminated call to function 'wildcard': missing ')'.  Stop.

or:

  kernel/time/.tick-broadcast.o.cmd:5: *** unterminated call to function 'wildcard': missing ')'.  Stop.

or:

  lib/.is_single_threaded.o.cmd:5: *** unterminated call to function 'wildcard': missing ')'.  Stop.

These corrupted .cmd files blocked subsequent additive builds perpetually, 
until I manually removed the corrupted .o.cmd file or did an explicit 'make clean'.

With your patch I've yet to see a single failure, after dozens of attempts.

  Tested-by: Ingo Molnar <mingo@kernel.org>

Thanks a lot for taking care of this problem!

	Ingo
