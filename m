Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D965E5A3AAA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 02:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiH1Air (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 20:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1Aip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 20:38:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF9739B9D;
        Sat, 27 Aug 2022 17:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=XnVS4fVQ1HsVCUFwtY44NyVamF5JC1EdGhLbgf6rBVM=; b=AkgWHjneeG47zlw9xzSQQxD+yI
        wS8l9k4M0fPfmDS1nvh0KjNtQ8Sr85RTXTtlt/X26uC43oJFXVnY6yVwJm7MMA499KwJOXVg/70T4
        aZK3R5f5UOgEzywkc0jC2RvkXzm/j/Cgt3tuM16DAh7FlLbs3ouKmTHcxWS/4lrwBBWlxVUTJbkC5
        J3ur541GtcfWMTAqxOrZNP8ZFjA87dIPCdVdHTIvIskF1FQDUnZ143xFufB7/J1E70HwxUbe7a/DS
        7An5BpauoLN6x7TUNh6V7+fcqQY1DyWIbr0ayHfB3kkSGkX1wgEKmSfXhtFhDjFdJ5PooG+FWIOuM
        BVWtQSIA==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oS6K2-006hNW-7r; Sun, 28 Aug 2022 00:38:42 +0000
Message-ID: <2032102a-e2d3-6105-f4e6-bba7decdbb66@infradead.org>
Date:   Sat, 27 Aug 2022 17:38:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 2/2] docs/conf.py: Respect env variable SPHINX_IMGMATH
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
References: <9b8ff6d7-e97a-c03f-7d46-4b80ae3cf196@gmail.com>
 <5a582b2b-d51c-a062-36b2-19479cf68fab@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <5a582b2b-d51c-a062-36b2-19479cf68fab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akira,

On 8/26/22 21:38, Akira Yokosawa wrote:
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

Please add SPHINX_IMGMATH to Documentation/doc-guide/sphinx.rst
(I guess), where other Sphinx environment variables are listed.

> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> Changes since v2:
>  - Emit warning on unknown setting of SPHINX_IMGMATH.
> 
> Changes since v1:
>  - No logical changes.
>  - Renames:
>      LOAD_IMGMATH -> SPHINX_IMGMATH (Mauro),
>      opt_load_imgmath -> env_sphinx_imgmath.
>  - Acked-by from Mauro.
> --
>  Documentation/conf.py | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index c4aaedd96220..9678a8215457 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -124,8 +124,20 @@ autosectionlabel_maxdepth = 2
>  # mathjax is the default math renderer since Sphinx 1.8.
>  have_latex =  have_command('latex')
>  have_dvipng = have_command('dvipng')
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
> +    else:
> +        sys.stderr.write("Unknown env SPHINX_IMGMATH=%s ignored.\n" % env_sphinx_imgmath)
> +
> +# Always load imgmath for Sphinx <1.8 or for epub docs
> +load_imgmath = (load_imgmath or (major == 1 and minor < 8)
>                  or 'epub' in sys.argv)
>  
>  if load_imgmath:

thanks.
-- 
~Randy
