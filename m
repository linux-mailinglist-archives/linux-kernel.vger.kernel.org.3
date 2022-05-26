Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9495355D2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 23:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348713AbiEZVrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 17:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244143AbiEZVrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 17:47:31 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8357E60C9
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 14:47:30 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g184so2393733pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 14:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qV2UpEJWp4WtdFS1TH/Dq7u8EaIkSboyPOa+IcckSU4=;
        b=P//S1dZ1qGjkScTl7aNaZgJny3ov/OEo2ZHPRm5Khedg3CRREVHVCF6GA9g4PVubcT
         yk+HmAUbkoOAJm9vEOFOBw9Q0nA9LaOTstUPo64N2+33eMTvDc5Mz+m9JwDf+rQZXOWN
         6qA9T2GEbc8P93ipm0oUO6aJwcmpYaU8SrVpHfGaCTjeRjME6GiFw3m8cLd2fVOP1imr
         7VSk10xk7kok7FxUeEu/ouioosLwifDjK/zLp//SfsAb/VNRSGsT00AL64UxRi8ggRDT
         GW/azz9ccdOnSqwUJWGt+NG6GM8/dyULdkbslsa0ZB/GGk1YamScq1Zg3FspTBo61KAl
         qckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qV2UpEJWp4WtdFS1TH/Dq7u8EaIkSboyPOa+IcckSU4=;
        b=tkjCyddKsegRlxqVMn/Ff8Xxv2iVuuypptlrGOyPHebuXRIKPkE4/k9imIZ0EqEdsN
         5/utOvH1W61u/O+ReTdi6D/YA5t+DmLqbPV2+tb5QWTTlH7BykjH8C3XsfGgp3J1GV8q
         eplj0Hq6DG5baRxDt/RQqGhIlzGujCygWjV1zaKMlYlU6lhjevPdq0z7FtWBn/F+4/dq
         knGSzb5MMA2JRAbzhZKr2m69j1BY3X+EV3XdIDn1Pypwr3lkBh0mABb0pJ49jSirD0mW
         /SQgH5kAscBWSv5tYaKcKPyZ7bw2LC3JhdSY5IjTG7s6xrYKR1ePbY6a4BcZGqkTWFoX
         BjOQ==
X-Gm-Message-State: AOAM530tWJgVhcvf00h4w3BS6X4O6n7ph2vdNAzU/pGjh/hYIe01/YzQ
        2atd7vFDXHXaMpAg34POorY=
X-Google-Smtp-Source: ABdhPJy3xXni4JBLDbbYG18eLknPo0GbnZCOlNnoxTTNvOXJ+owmYKObV/emoe4rOZ+SSwm9c+hwUw==
X-Received: by 2002:a65:6284:0:b0:3f6:298d:dd81 with SMTP id f4-20020a656284000000b003f6298ddd81mr34564393pgv.319.1653601649826;
        Thu, 26 May 2022 14:47:29 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:3206:ea0b:ce53:ea86])
        by smtp.gmail.com with ESMTPSA id z187-20020a6233c4000000b0050dc76281aesm1970498pfz.136.2022.05.26.14.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:47:28 -0700 (PDT)
Date:   Thu, 26 May 2022 14:47:26 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     pso@chromium.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] pstore/ram: Fix pmsg address when per-cpu ftrace buffers
 are enabled
Message-ID: <Yo/1btY2tKiDDCle@google.com>
References: <20220525151809.1.I43128ef59eb08247ec093f8b19d05aa91f721afb@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525151809.1.I43128ef59eb08247ec093f8b19d05aa91f721afb@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 03:18:55PM -0700, pso@chromium.org wrote:
> From: Paramjit Oberoi <pso@chromium.org>
> 
> When allocating ftrace pstore zones, there may be space left over at the
> end of the region. The paddr pointer needs to be advanced to account for
> this so that the next region (pmsg) ends up at the correct location.
> 
> Signed-off-by: Paramjit Oberoi <pso@chromium.org>

This looks correct to me.

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
> 
>  fs/pstore/ram.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index fefe3d391d3af..3bca6cd34c02a 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -554,10 +554,12 @@ static int ramoops_init_przs(const char *name,
>  			goto fail;
>  		}
>  		*paddr += zone_sz;
> +		mem_sz -= zone_sz;
>  		prz_ar[i]->type = pstore_name_to_type(name);
>  	}
>  
>  	*przs = prz_ar;
> +	*paddr += mem_sz;
>  	return 0;
>  
>  fail:
> -- 
> 2.36.1.124.g0e6072fb45-goog
> 

Thanks.

-- 
Dmitry
