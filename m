Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E1352F152
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350311AbiETRLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352061AbiETRLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:11:31 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917CE5AA55
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:11:29 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id fu47so7371596qtb.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ydAaGCacfT+dF14LRG6MBz1p0hoeWZYV+7ZyUquy+B0=;
        b=BZn01Fi9EpZx4qtDENZYy0KO4bjtysmIThrKmoVvfv0fi553gsX6RfBlT4iL1imCne
         IZCJxG33SgOdfm4VVaNrKe220DpwwasRZj2VCmFCTp+CRUQJ0TyPntR//tA2h8EoDrj3
         fsNQ8exLQ4H6QJVtainszao4UrRRiMpThjhXyj2Eg17oiLteUshXkBglhLQn8gQdULrk
         iVFFkEeJabigDfFQ8uY3QPrKIAAXyK4S7Fjnm2F888VA2GCghSVjrRSFJxYqt9TyvYbD
         RrRKg3mU/dphVlg64P4+Xrdpqx6i8oXtC3moznBJBHh2DHZvu4qEqmtcH1ASlCatVcTF
         N7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ydAaGCacfT+dF14LRG6MBz1p0hoeWZYV+7ZyUquy+B0=;
        b=fbrBaSDzd5ZQjpaMRi467bJYDATl4qwi9n8dH54T0SDBKhvEPxecBPhv5mujLFZtaW
         hEr4zLiEj7yO5lOsp35cojzF9AdUaT+Yqa/2Osj3ElUEMwKQdbVjrY4uXAWLZgCTaVpS
         nWFaHyPJ04N9Ki6mEDL4z86sWYwyxVxgmFhwxyMeR9kx16/bgXTCJTQ7FoQv/qnnMCcD
         lGrXm+Bc6jXmne2eq05ZdoonnvCXasmzD1WcgyOmmMaVxaPmHG3Nf/PrVvF41wawLket
         3ANHSYL2AJ7nhU4GVBNRfvIQ6ALMnPfOqN/dsBAjVJfySZ0/qeKml1nL3S3AuxFME+Bq
         xXSg==
X-Gm-Message-State: AOAM533dffHW5STDnAUTLuNuWbI+iD21HMv8sKipyJ2N/aoDFv4pnxT9
        Ltlee6FubIGrU6NzjfkRU1Ic7noKm/osXA==
X-Google-Smtp-Source: ABdhPJyBeT3VdO5/xLBt0HgHIZisNCjlh8uVoQCLuu6xRLYXi0RSdMQuX0UutteZrXXyKLPss+Rjqw==
X-Received: by 2002:ac8:5a83:0:b0:2f3:bafa:3bcc with SMTP id c3-20020ac85a83000000b002f3bafa3bccmr8359123qtc.366.1653066688650;
        Fri, 20 May 2022 10:11:28 -0700 (PDT)
Received: from cs.cmu.edu (tunnel29655-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:582::2])
        by smtp.gmail.com with ESMTPSA id g1-20020a379d01000000b0069fc13ce1fesm13326qke.47.2022.05.20.10.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 10:11:28 -0700 (PDT)
Date:   Fri, 20 May 2022 13:11:25 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fs/coda: Do not use partially allocated struct
Message-ID: <20220520171125.7u7q4ih5udkykv6b@cs.cmu.edu>
References: <20220520165922.2140450-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520165922.2140450-1-keescook@chromium.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me.

The old code was trying to be too smart for its own good and the type
gets lost by the uc_data = (void *) cast anyway.

Jan


On Fri, May 20, 2022 at 09:59:22AM -0700, Kees Cook wrote:
> GCC 12 does not like seeing a partially allocated structure being used,
> especially when a pointer is being passed out of function scope. Since
> only the struct coda_in_hdr member of union inputArgs is being allocated
> and used, just replace union inputArgs with struct coda_in_hdr.
> 
> ../fs/coda/upcall.c: In function 'coda_upcall':
> ../fs/coda/upcall.c:801:22: warning: array subscript 'union inputArgs[0]' is partly outside array bounds of 'unsigned char[20]' [-Warray-bounds]
>   801 |         sig_inputArgs->ih.opcode = CODA_SIGNAL;
>       |                      ^~
> In file included from ../include/linux/fs.h:45,
>                  from ../include/linux/huge_mm.h:8,
>                  from ../include/linux/mm.h:700,
>                  from ../fs/coda/upcall.c:22:
> In function 'kvmalloc',
>     inlined from 'kvzalloc' at ../include/linux/slab.h:758:9,
>     inlined from 'coda_upcall' at ../fs/coda/upcall.c:794:18:
> ../include/linux/slab.h:750:16: note: object of size 20 allocated by 'kvmalloc_node'
>   750 |         return kvmalloc_node(size, flags, NUMA_NO_NODE);
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../fs/coda/upcall.c: In function 'coda_upcall':
> ../fs/coda/upcall.c:802:22: warning: array subscript 'union inputArgs[0]' is partly outside array bounds of 'unsigned char[20]' [-Warray-bounds]
>   802 |         sig_inputArgs->ih.unique = req->uc_unique;
>       |                      ^~
> In function 'kvmalloc',
>     inlined from 'kvzalloc' at ../include/linux/slab.h:758:9,
>     inlined from 'coda_upcall' at ../fs/coda/upcall.c:794:18:
> ../include/linux/slab.h:750:16: note: object of size 20 allocated by 'kvmalloc_node'
>   750 |         return kvmalloc_node(size, flags, NUMA_NO_NODE);
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Cc: Jan Harkes <jaharkes@cs.cmu.edu>
> Cc: coda@cs.cmu.edu
> Cc: codalist@coda.cs.cmu.edu
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/coda/upcall.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
> index 59f6cfd06f96..21e4f5f446b2 100644
> --- a/fs/coda/upcall.c
> +++ b/fs/coda/upcall.c
> @@ -711,7 +711,7 @@ static int coda_upcall(struct venus_comm *vcp,
>  		       union inputArgs *buffer)
>  {
>  	union outputArgs *out;
> -	union inputArgs *sig_inputArgs;
> +	struct coda_in_hdr *ih;
>  	struct upc_req *req = NULL, *sig_req;
>  	int error;
>  
> @@ -791,22 +791,22 @@ static int coda_upcall(struct venus_comm *vcp,
>  	sig_req = kmalloc(sizeof(struct upc_req), GFP_KERNEL);
>  	if (!sig_req) goto exit;
>  
> -	sig_inputArgs = kvzalloc(sizeof(struct coda_in_hdr), GFP_KERNEL);
> -	if (!sig_inputArgs) {
> +	ih = kvzalloc(sizeof(*ih), GFP_KERNEL);
> +	if (!ih) {
>  		kfree(sig_req);
>  		goto exit;
>  	}
>  
>  	error = -EINTR;
> -	sig_inputArgs->ih.opcode = CODA_SIGNAL;
> -	sig_inputArgs->ih.unique = req->uc_unique;
> +	ih->opcode = CODA_SIGNAL;
> +	ih->unique = req->uc_unique;
>  
>  	sig_req->uc_flags = CODA_REQ_ASYNC;
> -	sig_req->uc_opcode = sig_inputArgs->ih.opcode;
> -	sig_req->uc_unique = sig_inputArgs->ih.unique;
> -	sig_req->uc_data = (void *)sig_inputArgs;
> -	sig_req->uc_inSize = sizeof(struct coda_in_hdr);
> -	sig_req->uc_outSize = sizeof(struct coda_in_hdr);
> +	sig_req->uc_opcode = ih->opcode;
> +	sig_req->uc_unique = ih->unique;
> +	sig_req->uc_data = (void *)ih;
> +	sig_req->uc_inSize = sizeof(*ih);
> +	sig_req->uc_outSize = sizeof(*ih);
>  
>  	/* insert at head of queue! */
>  	list_add(&(sig_req->uc_chain), &vcp->vc_pending);
> -- 
> 2.32.0
> 
> 
