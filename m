Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F037C598A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344501AbiHRRW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345163AbiHRRW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:22:26 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECA4260F;
        Thu, 18 Aug 2022 10:22:25 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AA3C7380;
        Thu, 18 Aug 2022 17:22:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AA3C7380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1660843344; bh=eYsIsnvHJN/VRUKL8GXFeyjNGIwW+qATM1xhlORPWNM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Kx7Qr1ZfNF19fwW4BtAdtyEINV6IniYegmu6NXd/VB5PU9oshTm4FkYnyim9jYfh6
         hVjRPYiLSbxVvF7lad4IlfSg9xVpT8y38mbCClWnTUU8pgM3cf27yqCVhms9kMFnWP
         3xZW8cSn3JaDFfsPcQtbQn4ujbOohgCe4XZ/ubljHCaRJCq8pNRrHmXtNDMySrrJx1
         zhz30z2lF4cD+tyWFr38/956J4DsYFg+TMHa9bIk/8dxpR67l1g0zA74A2tWGut/US
         1c1aylQ3bWAFdMW697uR3Dhn3U4AajruswgfGFUfXVoDi37ux/LUM3rFTJ1757cwvE
         jDgIsBKa4j4RQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 1/3] docs/conf.py: Treat mathjax as fallback math
 renderer
In-Reply-To: <a45f1aec-a2cb-0ef2-7100-378a5130c492@gmail.com>
References: <c41cab17-afd6-bc99-56a1-e4e73b8c1ef6@gmail.com>
 <a45f1aec-a2cb-0ef2-7100-378a5130c492@gmail.com>
Date:   Thu, 18 Aug 2022 11:22:24 -0600
Message-ID: <87wnb5bh67.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> Currently, math expressions using the "math::" directive or
> the ":math:" role of Sphinx need the imgmath extension for proper
> rendering in html and epub builds.
> imgmath requires dvipng (and latex).
> Otherwise, "make htmldocs" will complain of missing commands.
>
> As a matter of fact, the mathjax extension is loaded by default since
> Sphinx v1.8 and it is good enough for html docs without any dependency
> on texlive packages.
>
> Stop loading the imgmath extension for html docs unless requirements
> for imgmath are met.
>
> For epub docs, keep the same behavior of always loading imgmath.
>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> Changes sinve v1:
>  - Acked-by from Mauro
>
> --
>  Documentation/conf.py | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 934727e23e0e..3ec1f845c839 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -15,6 +15,23 @@
>  import sys
>  import os
>  import sphinx
> +from subprocess import check_output
> +
> +# helper
> +# ------
> +
> +def have_command(cmd, ver_opt, str_in_ver):
> +    """Run ```cmd`` with ``ver_opt`` and see if ``str_in_ver`` is found
> +    or not.
> +    """
> +
> +    try:
> +        ver_str = check_output([cmd, ver_opt]).decode('utf-8', 'ignore')
> +        have_cmd = str_in_ver in ver_str
> +    except:
> +        have_cmd = False
> +
> +    return have_cmd

So this is adding infrastructure that isn't really mentioned in the
changelog.

A more fundamental comment, though, is that I have learned (the hard
way, repeatedly) that good things do not come from bare "except"
statements.  They always hide bugs.  If there is an exception you're
worried about here, please list it explicitly.

Otherwise seems good.

Thanks,

jon
