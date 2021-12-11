Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDB6471169
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 05:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345870AbhLKE2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 23:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345848AbhLKE2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 23:28:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F105DC061714;
        Fri, 10 Dec 2021 20:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=EocwI5iB8uisBYdGHyN4tRaO4AYTxuJ0X6GFvjQpK9w=; b=mGLlIeH9Cp6Jbn3ov5XRsr6llg
        Hxq8J6V0R5w4w54IJ646rmohi0LTAn8gYytEHMvGezM24p65JbgSndkExREl9dAs3p1H9hpylaPJZ
        4auc2bAUsgU/OJvCVU43krf1zpCmJjaCucg14hCMmOKBjvnnvwDZ/c3oxiawg2CzY0GNKtQeGcNWI
        ijZH0loIqKHJRJM8/1NclXEkh+QebOUHov2IfV/iN9A/zA2P8+K5g5x8P0uhBDnblDBend9X7Rnuu
        nyPQIFs8NPjlN+STVOyqYxlOy9GQKfhe4ffz2hP7KYU30qiXFItNbY3eawm3iDQZv8WQUY5mavUT9
        jgH5ka3w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvtw4-00Awwp-Le; Sat, 11 Dec 2021 04:24:38 +0000
Message-ID: <936d6140-72bb-fe49-9013-638cb087f1a2@infradead.org>
Date:   Fri, 10 Dec 2021 20:24:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 1/4] docs: allow selecting a Sphinx theme
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@protonmail.com>, Alex Shi <alexs@kernel.org>,
        linux-kernel@vger.kernel.org
References: <cover.1638870323.git.mchehab+huawei@kernel.org>
 <bd20adabfd428fd3cd0e69c2cf146aa354932936.1638870323.git.mchehab+huawei@kernel.org>
Content-Language: en-US
In-Reply-To: <bd20adabfd428fd3cd0e69c2cf146aa354932936.1638870323.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/7/21 01:52, Mauro Carvalho Chehab wrote:
> Instead of having RTD as an almost mandatory theme, allow the
> user to select other themes via DOCS_THEME environment var.
> 
> There's a catch, though: as the current theme override logic is
> dependent of the RTD theme, we need to move the code which
> adds the CSS overrides to be inside the RTD theme logic.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> See [PATCH v4 0/4] at: https://lore.kernel.org/all/cover.1638870323.git.mchehab+huawei@kernel.org/
> 
>  Documentation/Makefile             |  3 ++
>  Documentation/conf.py              | 52 +++++++++++++++++-------------
>  Documentation/doc-guide/sphinx.rst |  8 +++++
>  3 files changed, 41 insertions(+), 22 deletions(-)
> 

> diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
> index e445cb146efe..bef276c58ebe 100644
> --- a/Documentation/doc-guide/sphinx.rst
> +++ b/Documentation/doc-guide/sphinx.rst
> @@ -138,6 +138,14 @@ To pass extra options to Sphinx, you can use the ``SPHINXOPTS`` make
>  variable. For example, use ``make SPHINXOPTS=-v htmldocs`` to get more verbose
>  output.
>  
> +By default, the build will try to use the Read the Docs sphinx theme:
> +
> +    https://github.com/readthedocs/sphinx_rtd_theme
> +
> +If the theme is not available, it will fall-back to the classic one.
> +
> +The Sphinx theme can be overriden by using the ``DOCS_THEME`` make variable.

                           overridden

> +
>  To remove the generated documentation, run ``make cleandocs``.
>  
>  Writing Documentation
> 

-- 
~Randy
