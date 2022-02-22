Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC6D4BF1E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 07:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiBVGLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 01:11:00 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiBVGK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 01:10:57 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AC6C331C;
        Mon, 21 Feb 2022 22:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=9q3yjh9uLyNjxrhUerp6IhTsxF93kG7KHpu4Olz4eNE=; b=jOWoVkAQBFZORRr8wm1BxB7JNG
        DN2pz7usUpggsTA5poxAj943t3ZFbTfMBTJcSJJ/XIUVpTSc+5LPf27xPNqMapVDkckno2so6rlih
        izVuubkI7ueepLIc3Qdz0gGN0jZBPAGq02VttXybRBcT54EkDilw5lP1bhJMOYxJd1yUtmumjsjRO
        5abU/wkABYXFgq4bzeg6J1Y4QqyTKE8G+81GOHPTk7T0h/TLpogsKQm9kapAw2XqUKd9gJHvJ2Cps
        2lixE0FoSlOqzNhyLERg0E350+Sg+oEnrKBtU21C68p/SOGdznHoq04MDYdDXDx67v5ItTHdSjfRW
        /BIjYLLw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMONX-00BsFN-91; Tue, 22 Feb 2022 06:10:27 +0000
Message-ID: <7852b505-a65a-6cdd-29a8-3bc966dfc750@infradead.org>
Date:   Mon, 21 Feb 2022 22:10:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 01/11] scripts: kernel-doc: Add the basic POD sections
Content-Language: en-US
To:     =?UTF-8?B?VG9tYXN6IFdhcm5pZcWCxYJv?= <tomasz.warniello@gmail.com>,
        corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
 <20220218181628.1411551-2-tomasz.warniello@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220218181628.1411551-2-tomasz.warniello@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/22 10:16, Tomasz Warniełło wrote:
> The NAME section provides the doc title, while SYNOPSIS contains
> the basic syntax and usage description, which will be printed
> in the help document and in the error output produced on wrong script
> usage.
> 
> The rationale is to give users simple and succinct enlightment,
> at the same time structuring the script internally for the maintainers.
> 
> In the synopsis, Rst-only options are grouped around rst, and the rest is
> arranged as in the OPTIONS subsections (yet to be translated into POD,
> check at the end of the series).
> 
> The third of the basic sections, DESCRIPTION, is added separately.
> 
> Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
> ---
>  scripts/kernel-doc | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 3106b7536b89..c8fbf1d3d5aa 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -16,6 +16,31 @@ use strict;
>  ## This software falls under the GNU General Public License.     ##
>  ## Please read the COPYING file for more information             ##
>  
> +=head1 NAME
> +
> +kernel-doc - Print formatted kernel documentation to stdout
> +
> +=head1 SYNOPSIS
> +
> + kernel-doc [-h] [-v] [-Werror]
> +   [ -man |
> +     -rst [-sphinx-version VERSION] [-enable-lineno] |
> +     -none
> +   ]
> +   [
> +     -export |
> +     -internal |
> +     [-function NAME] ... |
> +     [-nosymbol NAME] ...
> +   ]
> +   [-no-doc-sections]
> +   [-export-file FILE] ...
> +   FILE ...
> +
> +Run `kernel-doc -h` for details.

Nit:
$ ./scripts/kernel-doc -h
says:
    Run `kernel-doc -h` for details.

> +
> +=cut
> +
>  # 18/01/2001 - 	Cleanups
>  # 		Functions prototyped as foo(void) same as foo()
>  # 		Stop eval'ing where we don't need to.

-- 
~Randy
