Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2E558B0E0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 22:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbiHEUfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 16:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240175AbiHEUfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 16:35:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A36491E3;
        Fri,  5 Aug 2022 13:35:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E733C61AB9;
        Fri,  5 Aug 2022 20:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269A5C433B5;
        Fri,  5 Aug 2022 20:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659731706;
        bh=zP7E6kgu1qc+50yVif6a7UHQC7yTSPxs4G5vpQLKDFA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bjh87kmme4lPaWHfOnB8kXIzdZk+rGZPojv46PmRslSv9T60QlgkIBjvthZnQeEoA
         zGyUxKoeQFd6KQv9g+MCF5uKBrGvUDpwDjCMg1HBPIiqUHFEA2dtZzlKqCdXhj5zZ1
         g63R1hcdAP+m7z7soTl/97luvdVhCK6FOHAxIYkDYxDXjjSXB7QLVcHwgWkEyJ7ra2
         TJO5g4LKRsl8VGB93lINFJx1kE1c6QjGcTxiKJ1BxKdPwQVb+HrRA9Ys13uPzN6rY/
         qMl9XnopP/sZg0+ZY0BCBDYcSGoZKJlIwuvwr3l74SieNh55EpHbV6y1Gr9SeDf9Ti
         UPe9gezwDIsYw==
Date:   Fri, 5 Aug 2022 22:35:01 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] docs/conf.py: Respect env variable LOAD_IMGMATH
Message-ID: <20220805223501.27429692@coco.lan>
In-Reply-To: <aeb5e6fc-4af9-8e3e-a9db-bbcb22d9d913@gmail.com>
References: <12d078f5-6995-b039-7076-bdb1f372a799@gmail.com>
        <aeb5e6fc-4af9-8e3e-a9db-bbcb22d9d913@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 5 Aug 2022 23:24:46 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On some distros with coarse-grained packaging policy, dvipng is
> installed along with latex.  In such cases, math rendering will
> use imgmath by default.  It is possible to override the choice by
> specifying the option string of "-D html_math_renderer='mathjax'"
> to sphinx-build (Sphinx >= 1.8).
> 
> To provide developers an easier-to-use knob, add code for an env
> variable "LOAD_IMGMATH" which overrides the automatic choice
> of math renderer for html docs.
> 
>     LOAD_IMGMATH=yes : Load imgmath even if dvipng is not found
>     LOAD_IMGMATH=no  : Don't load imgmath (fall back to mathjax)

I would use a var name starting with SPHINX, like SPHINX_IMGMATH.

Anyway, for this entire series:

Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>

> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>  Documentation/conf.py | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 3ec1f845c839..03613eb59578 100644
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
> +# Respect LOAD_IMGMATH (for html docs only)
> +if 'LOAD_IMGMATH' in os.environ:
> +    opt_load_imgmath = os.environ['LOAD_IMGMATH']
> +    if 'yes' in opt_load_imgmath:
> +        load_imgmath = True
> +    elif 'no' in opt_load_imgmath:
> +        load_imgmath = False
> +    else: # otherwide, auto selection
> +        pass
> +
> +# Always load imgmath for Sphinx <1.8 or for epub docs
> +load_imgmath = (load_imgmath or (major == 1 and minor < 8)
>                  or 'epub' in sys.argv)
>  
>  if load_imgmath:



Thanks,
Mauro
