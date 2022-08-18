Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450CC598A6C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344550AbiHRR0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343515AbiHRRZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:25:09 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED50558E9;
        Thu, 18 Aug 2022 10:24:50 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 25B6D380;
        Thu, 18 Aug 2022 17:24:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 25B6D380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1660843490; bh=3fRl1j7mKGqvV85JpGfgS3kDrE8+2lAy6KIi73rzFoc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iKpMyJv3NbbL+LzdhHbx+QU4/u2VBzyekTAjUdJXeQ/8Bq1mmUsx2422T89+X385k
         XteDu3N47gDwd9r01p8gfH7FJ/nnmNQ7StQXjcVMIMIKJ732E+MxDQSmUE9Px49UEr
         TqIGxs//RbN3zGVa4hN/pjZfjYMkrDuLUqldcsiAfNz3fIpSJ/bp5RCGF6ITjf/cd4
         mhTQnE4EZVT1ZHx1H9LJCMws7Uoe4oqL6seOBmvp9B2N+IOvoDKOZiBitRLH56sbQ1
         WR6WNf4CzI+C6VP31CWSeWxIx7GPhLS66aR3ZDlx3iQhME8vpOStFbeV9VZUOJD37Z
         yN7UUb052ts+Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 2/3] docs/conf.py: Respect env variable SPHINX_IMGMATH
In-Reply-To: <736e39fd-b068-80dd-b383-70e061e71bf5@gmail.com>
References: <c41cab17-afd6-bc99-56a1-e4e73b8c1ef6@gmail.com>
 <736e39fd-b068-80dd-b383-70e061e71bf5@gmail.com>
Date:   Thu, 18 Aug 2022 11:24:49 -0600
Message-ID: <87sfltbh26.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> On some distros with coarse-grained packaging policy, dvipng is
> installed along with latex.  In such cases, math rendering will
> use imgmath by default.  It is possible to override the choice by
> specifying the option string of "-D html_math_renderer='mathjax'"
> to sphinx-build (Sphinx >= 1.8).
>
> To provide developers an easier-to-use knob, add code for an env
> variable "SPHINX_IMGMATH" which overrides the automatic choice
> of math renderer for html docs.
>
>     SPHINX_IMGMATH=yes : Load imgmath even if dvipng is not found
>     SPHINX_IMGMATH=no  : Don't load imgmath (fall back to mathjax)
>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> Changes since v1:
>  - No logical changes.
>  - Renames:
>      LOAD_IMGMATH -> SPHINX_IMGMATH (Mauro),
>      opt_load_imgmath -> env_sphinx_imgmath.
>  - Acked-by from Mauro.
>
> --
>  Documentation/conf.py | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 3ec1f845c839..0b8f20e8e22c 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -128,8 +128,20 @@ autosectionlabel_maxdepth = 2
>  # mathjax is the default math renderer since Sphinx 1.8.
>  have_latex =  have_command('latex', '--version', 'pdfTeX')
>  have_dvipng = have_command('dvipng', '--version', 'dvipng')
> -load_imgmath = ((have_latex and have_dvipng)
> -                or (major == 1 and minor < 8)
> +load_imgmath = have_latex and have_dvipng
> +
> +# Respect SPHINX_IMGMATH (for html docs only)
> +if 'SPHINX_IMGMATH' in os.environ:
> +    env_sphinx_imgmath = os.environ['SPHINX_IMGMATH']
> +    if 'yes' in env_sphinx_imgmath:
> +        load_imgmath = True
> +    elif 'no' in env_sphinx_imgmath:
> +        load_imgmath = False
> +    else: # otherwide, auto selection
> +        pass

That "else: pass" sequence does nothing, of course, and could be taken
out.

Otherwise fine,

jon
