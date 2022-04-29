Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8441D5151CD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357732AbiD2R2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345884AbiD2R2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:28:44 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D2078911
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:25:25 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x52so5908748pfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8VcGiTnxBdnn4a/IH4FBlOWmNwovAahBFVXVNAZgYfQ=;
        b=Jy5Ild4MPRqvDdH5+nSFFHeeaFYOzUK/2qw2dkEdiI+pfpK4feYmsiCQpd8R8swm7L
         Kit7qZlqbKWL1obYmfX9HtEY8wUNe5GnVjxtVCHultpKguWxdA1TAcwvBiY85ahhsmiW
         1GlYDQnvJH5WIOPq+YiTaRCAKC21JkOjvgbUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8VcGiTnxBdnn4a/IH4FBlOWmNwovAahBFVXVNAZgYfQ=;
        b=7xWFzmy0SbLKRzuUkocNth2ITdYLPfXQCOYct2T3VP5FmcHVHip6ihbvoVm1MQNn6V
         63a/kAlIYD2EVTqg6wU/4xLvZ05AxW9qg6+1CE0OVwTaxnj/7HQsRCqQSBM1DDFF7maY
         ymeAnzLe+UeoZCY80i8PrwKNlx1n6A7Pt1nNlMPKUnYXxxQTbIB9iWvUIXnHsPjYjCvZ
         9LGc6YVngfF7Z/w8n36YFO8dUODW4kTO80o5wbo8RN6vqbjcf0bb3MYZ+PbSDl1cjR/W
         6qLOooiz7vRrSatoOaTtEpJi1f+NcEtJTrIcuLDwcFQgwy9acmrYbwq+aLE+sMmzLNqd
         cK8w==
X-Gm-Message-State: AOAM532HTXdPxH06G6sShouCRHhL4NjweG2n3FiSWiKEXvlzEsyI9LwV
        74Tl69+yZkeLyCLPFpSYbmrDZoOt0syB/Q==
X-Google-Smtp-Source: ABdhPJw7vBPVQORraV1l1u6vViCsoUgapJkXOwfPZgKZAaLzp2zohmaN8nv8PJol7chOeYrz/pAKaw==
X-Received: by 2002:aa7:9802:0:b0:50d:4f5d:fef6 with SMTP id e2-20020aa79802000000b0050d4f5dfef6mr170737pfl.9.1651253124752;
        Fri, 29 Apr 2022 10:25:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k18-20020a628e12000000b0050d8500048fsm3761692pfe.39.2022.04.29.10.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 10:25:24 -0700 (PDT)
Date:   Fri, 29 Apr 2022 10:25:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] ELF, uapi: fixup ELF_ST_TYPE definition
Message-ID: <202204291019.B628991360@keescook>
References: <Ymv7G1BeX4kt3obz@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymv7G1BeX4kt3obz@localhost.localdomain>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 05:50:03PM +0300, Alexey Dobriyan wrote:
> This is very theoretical compile failure:
> 
> 	ELF_ST_TYPE(st_info = A)
> 
> Cast will bind first and st_info will stop being lvalue:
> 
> 	error: lvalue required as left operand of assignment
> 
> Given that the only use of this macro is
> 
> 	ELF_ST_TYPE(sym->st_info)
> 
> where st_info is "unsigned char" I've decided to remove cast especially
> given that companion macro ELF_ST_BIND doesn't use cast.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  include/uapi/linux/elf.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

It looks like akpm already pulled this, so:

Acked-by: Kees Cook <keescook@chromium.org>

Please keep Eric & I CCed on ELF changes; there's a MAINTAINERS entry
now...

-Kees

-- 
Kees Cook
