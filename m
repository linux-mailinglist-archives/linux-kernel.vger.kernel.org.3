Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46A45B22CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiIHPup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiIHPul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:50:41 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8F9EB84D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:50:40 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id iw17so11664881plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=yhkKsuJjCkH5vvaGM2iHjCoLwIu5zJgsDHBQXx6FXt0=;
        b=Pyk6o4ghYxcqlBGmRohX+ieQOgTmJcNA8CcaDxXlkVxb97sWZelsSKCR3YlgrRmQLQ
         KXX2MOTT+0R4V4P0lPbj/NdxAlonQqoLOae9CCqUkgE9lPKaEW4Bew5xo4djzKJt0e3u
         zGRli44wSACwjVIiFnyxFWknF2cfJfObrjU4QlY4/umwFFxg+EBgr8M9js75hr1qBbwj
         lj1T3AbVdAXQJ3O4rgCqsOJdFd6Rf+z+UhxcSEhUEjq36m2IBNpDZ0MTIHxnmPVvjydv
         5k3hfxHYYvuLcwxms3/D4jxJGNIoQWJhoUTyYmB8Xu5E+ZvKFFEvXK8cEwxkiXEWYqXN
         ZW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=yhkKsuJjCkH5vvaGM2iHjCoLwIu5zJgsDHBQXx6FXt0=;
        b=A2VrILt+hCsMuwGn7P1tLwRDDqt7o+xg4y3W6c49eahngTBUGeAT1IaxuAhwJMGbFW
         LocpKnmIBFs2SiAuq/sNF0miFtOrf8IsLROp1XhTEFxvUW19iNH1f0IcmumMcrKNOzP6
         46gpmjCj3PBMPlvGSwwu17hCLkSc7ZfH+zE3zHRnzdiiLXHe4NM9emFFY0pAdI8Cedks
         mLbDAdNUibRnILicCRj2xOuClKbgPz3xShq6Qb2eg/ojcL9Na0LhjRmkW1n/aSQTrzHA
         IpC/S4kC1TKNk1oAPp2MxQzs5FOT6p33IkVP/8f3M2hLjTwcSdq9O0m6mrFgfz8iJNLv
         gsIA==
X-Gm-Message-State: ACgBeo1WPG8KzsIx9av6rkm2XUFZSQpuVVMySpi1KPD1M1BkNtnOWGcN
        2+Ipv2kw9ED2oJ3w239poBTGP+BRJrJKNA==
X-Google-Smtp-Source: AA6agR4Ecbhy1CSe7fhCFYobvIDT8BJv3rXrEEP0R+F5e+Gc49DQ8JnrdCsBqI1eJGG+/g2sLfmzig==
X-Received: by 2002:a17:90a:fc98:b0:202:52cf:c117 with SMTP id ci24-20020a17090afc9800b0020252cfc117mr4731880pjb.26.1662652239831;
        Thu, 08 Sep 2022 08:50:39 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id c8-20020a621c08000000b0053e4296e1d3sm6235817pfc.198.2022.09.08.08.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 08:50:39 -0700 (PDT)
Date:   Thu, 8 Sep 2022 15:50:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Liam Ni <zhiguangni01@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com
Subject: Re: [PATCH v2] KVM:x86: Clean up ModR/M "reg" initialization in reg
 op decoding
Message-ID: <YxoPS5OCup1h8QD4@google.com>
References: <20220908141210.1375828-1-zhiguangni01@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908141210.1375828-1-zhiguangni01@zhaoxin.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022, Liam Ni wrote:
> From: Liam Ni <zhiguangni01@gmail.com>
> 
> Refactor decode_register_operand() to get the ModR/M register if and
> only if the instruction uses a ModR/M encoding to make it more obvious
> how the register operand is retrieved.
> 
> Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
> ---

Pushed to branch `for_paolo/6.1` at:

    https://github.com/sean-jc/linux.git

with the below nit sqaushed.  Unless you hear otherwise, it will make its way to
kvm/queue "soon".

Note, the commit IDs are not guaranteed to be stable.

>  arch/x86/kvm/emulate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index f092c54d1a2f..879b52af763a 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -1137,9 +1137,11 @@ static int em_fnstsw(struct x86_emulate_ctxt *ctxt)
>  static void decode_register_operand(struct x86_emulate_ctxt *ctxt,
>  				    struct operand *op)
>  {
> -	unsigned reg = ctxt->modrm_reg;
> +	unsigned int reg;
>  
> -	if (!(ctxt->d & ModRM))
> +	if ((ctxt->d & ModRM))

Only need one set of parentheses.  

> +		reg = ctxt->modrm_reg;
> +	else
>  		reg = (ctxt->b & 7) | ((ctxt->rex_prefix & 1) << 3);
>  
>  	if (ctxt->d & Sse) {
> -- 
> 2.34.1
> 
