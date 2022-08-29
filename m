Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8AC5A526A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiH2Q72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiH2Q7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:59:09 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD7C9C216;
        Mon, 29 Aug 2022 09:59:03 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B35244B7;
        Mon, 29 Aug 2022 16:59:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B35244B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661792342; bh=KVB/dfI17sai5/pehF9fzhRTupEe9KHezPY2ahrCIbw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QwTgRXzdYlLH5j0A2Em9SIf1KJoja/q2AcPXbQqdwS5M6SHBV5RUm6C7UdkGFLDJX
         ohAMJFbG9mdKOmMOtSjw/JbNNlI3R36d54X6coH4bUZklfobNAXEicoDdW5D3t2vo1
         ZQQDcWvDmi3aX4Bw/+AaS8LUdskyqRv3KlC+gATKuH96YLy4PTUcBhlg1jMJoScf0c
         e7uN4dhtLmB+Q3FIpFN54J+jTAKV/SrTwnANoHohsxTBqB+lmQ6ZgJ+Ax/q/c32XiB
         RQlKber4hPQNkck1dD2FG2oGXf9GxgI7enHtTCfHZtxaSlRm6JeLmUaKWyWdiR4KQY
         /Y8R4BLBOiPYw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v3 1/2] docs/conf.py: Treat mathjax as fallback math
 renderer
In-Reply-To: <a6a877fc-dc93-2bda-a6d3-37001d99942a@gmail.com>
References: <9b8ff6d7-e97a-c03f-7d46-4b80ae3cf196@gmail.com>
 <a6a877fc-dc93-2bda-a6d3-37001d99942a@gmail.com>
Date:   Mon, 29 Aug 2022 10:59:02 -0600
Message-ID: <87edwzoujt.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
> To find out whether required commands are available, add a helper
> find_command(), which is a wrapper of shutil.which().
>
> For epub docs, keep the same behavior of always loading imgmath.
>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> Changes since v2:
>  - Mention find_command() in the changelog.
>  - Simplify find_command() by using shutil.which().
>
> Changes sinve v1:
>  - Acked-by from Mauro
> --
>  Documentation/conf.py | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 255384d094bf..c4aaedd96220 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -15,6 +15,18 @@
>  import sys
>  import os
>  import sphinx
> +import shutil
> +
> +# helper
> +# ------
> +
> +def have_command(cmd):
> +    """Search ``cmd`` in the ``PATH`` environment.
> +
> +    If found, return True.
> +    If not found, return False.
> +    """
> +    return shutil.which(cmd) is not None
>  
>  # Get Sphinx version
>  major, minor, patch = sphinx.version_info[:3]
> @@ -107,7 +119,22 @@ else:
>  autosectionlabel_prefix_document = True
>  autosectionlabel_maxdepth = 2
>  
> -extensions.append("sphinx.ext.imgmath")
> +# Load math renderer:
> +# For html builder, load imgmath only when its dependencies are met.
> +# mathjax is the default math renderer since Sphinx 1.8.
> +have_latex =  have_command('latex')
> +have_dvipng = have_command('dvipng')
> +load_imgmath = ((have_latex and have_dvipng)
> +                or (major == 1 and minor < 8)
> +                or 'epub' in sys.argv)
> +
> +if load_imgmath:
> +    extensions.append("sphinx.ext.imgmath")
> +    math_renderer = 'imgmath'
> +else:
> +    math_renderer = 'mathjax'
> +
> +sys.stderr.write("math_renderer: %s\n" % math_renderer)

I've taken this line out as I applied the patch.  The docs build is
verbose enough as it is, and this line isn't really going to add
anything for most people.  If it needs to be there, I think, it should
only show up on a V=1 build.

Thanks,

jon
