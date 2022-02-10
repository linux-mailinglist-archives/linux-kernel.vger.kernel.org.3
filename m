Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FEA4B1495
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245362AbiBJRue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:50:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245319AbiBJRud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:50:33 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F2310EA;
        Thu, 10 Feb 2022 09:50:33 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2357B2C1;
        Thu, 10 Feb 2022 17:50:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2357B2C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1644515433; bh=BRR4tLeRUD3KW6QMKm1Nd86zR7/+/nU//fsI8Io5rWM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fFrsVgL36L94ewK9+Xe4qVHKsRPjUdkmnqEJtUfX5NnaEaN65pn3J/Hk9cuRiWuE0
         75er350j1+DmBnuckTXDbDdV0cUoOEDOGAdHi0LyU3JvR8/y9+GFJqTf1h4h6xiRM1
         bMxqSgQp/bWA1YF1ihPNmXy6ex2GS545+27zYun3MgPV/+PFKcasLDXJUP5wzMhfqa
         gLdzpOGN12PAbFwaehbsANT3apcwpAs39/UTfDY9TbTcVtYp/STRKzU6WwISCn6yU8
         puOfdxRX/j1mizYmAj9H3dLnakQoXo9cDk3vzbIezLnu+XrgvzP6ozxVq5M5hW7m2g
         wlLNFtBKyU4Ow==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] docs: Makefile: Add -no-shell-escape option to LATEXOPTS
In-Reply-To: <519bd2d9-1bee-03e1-eeb4-d9883c18be0c@gmail.com>
References: <519bd2d9-1bee-03e1-eeb4-d9883c18be0c@gmail.com>
Date:   Thu, 10 Feb 2022 10:51:17 -0700
Message-ID: <87zgmybofe.fsf@meer.lwn.net>
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

Akira Yokosawa <akiyks@gmail.com> writes:

> By adding this option, message of "restricted \write18 enabled" from
> LaTeX can be silenced.
>
> As there is no use of \write18 in LaTeX sources from sphinx-build, it
> is safe to add this option.
>
> Reported-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> ---
>  Documentation/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 9f4bd42cef18..64d44c1ecad3 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -26,7 +26,7 @@ SPHINX_CONF   = conf.py
>  PAPER         =
>  BUILDDIR      = $(obj)/output
>  PDFLATEX      = xelatex
> -LATEXOPTS     = -interaction=batchmode
> +LATEXOPTS     = -interaction=batchmode -no-shell-escape

Interesting.  In my digging now and back in 2016 [1] everything I found
said that \write18 had to be explicitly enabled - and for good reason.
And I could never figure out *how* we were enabling it...  It turns out
that the net misinformed me; how come nobody ever told me that could
happen? :)

Anyway, I've applied this, but I'm going to tweak the changelog a bit.
My reason for wanting this isn't to make the warning go away - it's a
*tiny* piece of the noise of a pdfdocs build.  That warning is there for
a reason; \write18 is dangerous.  We really don't want any way for
arbitrary shell commands to be executed via the docs build.  So the new
text is:

  It turns out that LaTeX enables \write18, which allows arbitrary shell
  commands to be executed from the document source, by default.  This the
  often-seen warning during a pdfdocs build:

    restricted \write18 enabled

  That is a potential security problem and is entirely unnecessary; nothing
  in the kernel PDF docs build needs that capability.  So disable \write18
  explicitly.

I think I'll add a Cc: stable while I'm at it.  I know of no actual
threat, but this is best closed.

Thanks for fixing this,

jon

[1] https://lore.kernel.org/lkml/20161113125250.779df4dd@lwn.net/
