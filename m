Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA4E4714DF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 18:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhLKRNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 12:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhLKRM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 12:12:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D96C061714;
        Sat, 11 Dec 2021 09:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=KuSuJOPNTZYDvz1E1afHDAYrDn96f2gyPAIgOUQWldI=; b=PLcKCXgIk4FGuje0Gt8cH9pRIX
        ojS6zzIqg1dSG7+3vAvLmt6NtRdBxiQBgAHs/aPQj1N3OBrE8tBIVJMJ+4Lxi5MSXHL+cT0F1RSEu
        Q8Ja7XTwVtvWC7e+oQmZoI8ynNVtVYteMyAs4IwR/HJPrSS7X6ArxWlv1vVq2QyuJk1SiZs3ib9J1
        MyxWtE8gEya0IHB9/xa77x44aOuuh9HiWIXhJCfr3SR4l6sTd3c3PzWmvUnr/3xLkAMKC8SBqKWgE
        t6w0yPbScILrMMKvH39oX+AP9Yx5V3hapKEU3VgbgVdvpIfCxy1LsRyQrAYu6DGEkDi7UKQa/j1CH
        d8FMfpjw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mw5vX-000mA9-RK; Sat, 11 Dec 2021 17:12:53 +0000
Message-ID: <98078a61-dcc5-9e52-f6fc-9bd3b8be6d25@infradead.org>
Date:   Sat, 11 Dec 2021 09:12:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/2] docs: Makefile: use the right path for DOCS_CSS
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org
References: <cover.1639212812.git.mchehab+huawei@kernel.org>
 <cea4ff1237ae9a99bc6509ab1bf9c70acd97e265.1639212812.git.mchehab+huawei@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <cea4ff1237ae9a99bc6509ab1bf9c70acd97e265.1639212812.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/21 00:56, Mauro Carvalho Chehab wrote:
> When make is used with O=<dir>, the location of the css file
> won't be get right:
> 
> 	$ make DOCS_THEME=nature DOCS_CSS=my_css.css    O=DOCS SPHINXDIRS=x86 -j9 htmldocs
> 	make[1]: Entering directory '/work/lnx/next/next-2021-1210/DOCS'
> 	...
> 	cp: cannot stat 'my_css.css': No such file or directory
> 
> Fix it in a way that both relative and absolute paths will be
> handled.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
> See [PATCH 0/2] at: https://lore.kernel.org/all/cover.1639212812.git.mchehab+huawei@kernel.org/
> 
>  Documentation/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 9f0f53db2f10..c9543b63dc6a 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -88,7 +88,7 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
>  	$(abspath $(srctree)/$(src)/$5) \
>  	$(abspath $(BUILDDIR)/$3/$4) && \
>  	if [ "x$(DOCS_CSS)" != "x" ]; then \
> -		cp $(DOCS_CSS) $(BUILDDIR)/$3/_static/; \
> +		cp $(if $(patsubst /%,,$(DOCS_CSS)),$(abspath $(srctree)/$(DOCS_CSS)),$(DOCS_CSS)) $(BUILDDIR)/$3/_static/; \
>  	fi
>  
>  htmldocs:
> 

-- 
~Randy
