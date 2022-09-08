Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE915B1B07
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiIHLNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiIHLNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:13:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FBAD99E9;
        Thu,  8 Sep 2022 04:13:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 88232CE1F07;
        Thu,  8 Sep 2022 11:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14B1C433D6;
        Thu,  8 Sep 2022 11:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662635590;
        bh=iJAltEe80iBgnEcTrGpToVAW8pvN4/7NYz8vdUhpFAs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q86NaGdXLc8cdu7XwxAzrwSH9WjGvlaAPr6xEVBgQ3CQSOqxk2Qz3Y6McraLUAxi+
         BK5cTAl72DtjcF9dEmM+dvXs0F8xQrsEv9mr+//QNoMKfX8LEgzNTj/RwyEjWdVYBp
         vEfYZ0JY2orfoKTZxaSp48W2D3D9VDkO5rDxEQ1cyJXiJBCABfZfNmloz2qSRfDZxe
         FPjVLsQ3wfRSYbQHmDJQUVL5dlyiIO2Rw+j9kwyRS9nMKxCVA+mFGTeNLhLoONM+F2
         i6XDpxbJePNuDNxveXOopz2fCr56iNg6KH3k5wWwCQYxITLeKhLHU5sG7vrfAu4TNi
         npKBqh2BnhmUQ==
Date:   Thu, 8 Sep 2022 13:13:03 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-media@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] media: remove reference to CONFIG_EMBEDDED in
 MEDIA_SUPPORT_FILTER
Message-ID: <20220908131303.1fe813cd@coco.lan>
In-Reply-To: <20220908104337.11940-4-lukas.bulwahn@gmail.com>
References: <20220908104337.11940-1-lukas.bulwahn@gmail.com>
        <20220908104337.11940-4-lukas.bulwahn@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu,  8 Sep 2022 12:43:34 +0200
Lukas Bulwahn <lukas.bulwahn@gmail.com> escreveu:

> The config EMBEDDED selects EXPERT, i.e., when EMBEDDED is enabled, EXPERT
> is usually also enabled. Hence, it sufficient to have the option
> MEDIA_SUPPORT_FILTER set to y if !EXPERT.
> 
> This way, MEDIA_SUPPORT_FILTER does not refer to CONFIG_EMBEDDED anymore
> and allows us to remove CONFIG_EMBEDDED in the close future.
> 
> Remove the reference to CONFIG_EMBEDDED in MEDIA_SUPPORT_FILTER.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  drivers/media/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
> index ba6592b3dab2..283b78b5766e 100644
> --- a/drivers/media/Kconfig
> +++ b/drivers/media/Kconfig
> @@ -24,7 +24,7 @@ if MEDIA_SUPPORT
>  
>  config MEDIA_SUPPORT_FILTER
>  	bool "Filter media drivers"
> -	default y if !EMBEDDED && !EXPERT
> +	default y if !EXPERT
>  	help
>  	   Configuring the media subsystem can be complex, as there are
>  	   hundreds of drivers and other config options.

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Thanks,
Mauro
