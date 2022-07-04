Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A2D5658E2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiGDOp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbiGDOp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50D1CEE24
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656945925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JUaeOZcABuRzKgKBZGeq/1CmNMYL/xg0qgavZQZWuHs=;
        b=W+Vfk0GhDLlE4y+HkLe6OmQPl+4K0AjqKwqfrVQ2+Nm/RitIHPXJYLinVhJfFuRaxXL7yt
        4XEOH9vsZ3o5ss546mvrPnyDmWWFEkRSd+e6r1JgAX+uNW0wIVrtwpANYDAqqG+XkDGWe+
        XWNbx3w5rTItD/wcaGRyHD7i4kAS95o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-wViLpvIUOz2sE70HNzvCFw-1; Mon, 04 Jul 2022 10:45:21 -0400
X-MC-Unique: wViLpvIUOz2sE70HNzvCFw-1
Received: by mail-wm1-f71.google.com with SMTP id e24-20020a05600c219800b003a0471b1904so7485550wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JUaeOZcABuRzKgKBZGeq/1CmNMYL/xg0qgavZQZWuHs=;
        b=4wHicnBJKntXTKOTmlIRvp573rPcxlgDFi0+l2t1ldnfv/Opn2cKsBrJ4T7ji5AGP/
         ddmBaQcovgisFyAmwxsfyJmuJd9kQtv3RjMGTp/fzXCDxMxQSeGfnVR1E42bN1xMQlHf
         7dXUF2ty98afdORzaVaGj9YDZIaL6VR2qA7/p9PvTxBZizFSflKRn45OrRyVz2COJ4PY
         g91c0ETNdjzqfyuFhKMuAWOkGS3RtVTEb3snVOD/d682Bt6m3+yHKOJUi+qIRM1zDTuX
         5E6Vai6iSiDqn57T8rDSKDC/FxPkBxKnskmFcZslC4qetyvJwKt8OHjhGwRDLqamjqxe
         5KZA==
X-Gm-Message-State: AJIora9IESP6lDEQquLrxsvNjAdT1wx0pjXy968E02weoGbKkOOy9Kah
        IMu9WcTK1TRTk6k+CB/FH1ultEcrHOxluaS4hLjLKNOmrxAzmMB/phBg2/FdAbHPtd8M0mtpFpg
        jwubUrDA/q2ppfbwxPk2pObQ=
X-Received: by 2002:a05:6000:1869:b0:21d:6e7a:6e4 with SMTP id d9-20020a056000186900b0021d6e7a06e4mr1506222wri.295.1656945920598;
        Mon, 04 Jul 2022 07:45:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s14BgUjo37HVVyUWoOAiHXHmApD2TXmLZkM1+61bzx/ROxOELV0Q4xHqfwO71nG1sCS+7XBw==
X-Received: by 2002:a05:6000:1869:b0:21d:6e7a:6e4 with SMTP id d9-20020a056000186900b0021d6e7a06e4mr1506207wri.295.1656945920417;
        Mon, 04 Jul 2022 07:45:20 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id x1-20020a1c7c01000000b003a02b135747sm19663644wmc.46.2022.07.04.07.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:45:19 -0700 (PDT)
Date:   Mon, 4 Jul 2022 15:45:18 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        mcgrof@kernel.org
Subject: Re: [PATCH -next] module: Use vzalloc() instead of
 vmalloc()/memset(0)
Message-ID: <20220704144518.5gjj45ldgzfl3tak@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220704120337.4119910-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220704120337.4119910-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-07-04 20:03 +0800, Yang Yingliang wrote:
> Use vzalloc() instead of vmalloc() and memset(0) to simpify the code.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  kernel/module/main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index fed58d30725d..02b67abc448f 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2138,7 +2138,7 @@ static int move_module(struct module *mod, struct load_info *info)
>  
>  #ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
>  	/* Do the allocs. */
> -	ptr = vmalloc(mod->data_layout.size);
> +	ptr = vzalloc(mod->data_layout.size);
>  	/*
>  	 * The pointer to this block is stored in the module structure
>  	 * which is inside the block. Just mark it as not being a
> @@ -2151,7 +2151,6 @@ static int move_module(struct module *mod, struct load_info *info)
>  		return -ENOMEM;
>  	}
>  
> -	memset(ptr, 0, mod->data_layout.size);
>  	mod->data_layout.base = ptr;
>  #endif
>  	/* Transfer each section which specifies SHF_ALLOC */
> -- 
> 2.25.1
> 

Hi Yang,

Nice!

Reviewed-by: Aaron Tomlin <atomlin@redhat.com>


Kind regards,

-- 
Aaron Tomlin

