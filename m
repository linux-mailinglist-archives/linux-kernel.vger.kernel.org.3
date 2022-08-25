Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3175A0A4E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbiHYHao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237671AbiHYHaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:30:21 -0400
X-Greylist: delayed 501 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 Aug 2022 00:30:19 PDT
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119E39A9A9;
        Thu, 25 Aug 2022 00:30:19 -0700 (PDT)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Thu, 25 Aug 2022 09:21:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1661412116; bh=/+UC0gRCiFWQcMuy4Xj0qMCo2bQnVRVF/PnuYavamBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hI+XGEjVal0XVZcBbCZY4poHtGOSgWwflU0pGH50eFNfESJzpF/JBeerdSxtQC8dt
         pfSdEMmRpzRgSFMDlJ/Vhl9LnWi0WTR4hL5AlWVPVltlPvGE7JDO3aM+rGgUux8CLE
         ytGgIjK7q/QUei6W5p6w2NNb+yf+N/clLDpBm2cE=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id 7C5E4801AA;
        Thu, 25 Aug 2022 09:21:56 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 70EF318149F; Thu, 25 Aug 2022 09:21:56 +0200 (CEST)
Date:   Thu, 25 Aug 2022 09:21:56 +0200
From:   Nicolas Schier <n.schier@avm.de>
To:     Thitat Auareesuksakul <thitat@flux.ci>
Cc:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/extract-ikconfig: add zstd compression support
Message-ID: <YwcjFCXF7lKpU3r5@buildd.core.avm.de>
References: <20220824200340.45673-1-thitat@flux.ci>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220824200340.45673-1-thitat@flux.ci>
X-purgate-ID: 149429::1661412116-8F3FE9DB-1C6824EF/0/0
X-purgate-type: clean
X-purgate-size: 868
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 03:03:40AM +0700, Thitat Auareesuksakul wrote:
> Add extract-ikconfig support for kernel images compressed with zstd.
> 
> Signed-off-by: Thitat Auareesuksakul <thitat@flux.ci>
> ---

Tested-by: Nicolas Schier <n.schier@avm.de>

>  scripts/extract-ikconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/extract-ikconfig b/scripts/extract-ikconfig
> index 3b42f255e2ba..8df33e7d6daa 100755
> --- a/scripts/extract-ikconfig
> +++ b/scripts/extract-ikconfig
> @@ -62,6 +62,7 @@ try_decompress 'BZh'          xy    bunzip2
>  try_decompress '\135\0\0\0'   xxx   unlzma
>  try_decompress '\211\114\132' xy    'lzop -d'
>  try_decompress '\002\041\114\030' xyy 'lz4 -d -l'
> +try_decompress '\050\265\057\375' xxx unzstd
>  
>  # Bail out:
>  echo "$me: Cannot find kernel config." >&2
> -- 
> 2.37.2
> 
