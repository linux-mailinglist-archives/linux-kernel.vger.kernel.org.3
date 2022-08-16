Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76A9596484
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbiHPVSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiHPVSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:18:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42016BCDC
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660684719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pB2MXlODWhdpcT5LoWH4Us0FJuxoK4gcT72TphVt0ag=;
        b=eyz3FCZ7/9IhnEHwhggIJy5egEH3a7wKUXww8QKMFhYL4vZEEHgcso+a5T3KjcJP5Z4zR/
        m9LclKMnsbe4qA3hmW+gpHbvc0rwa8h8iuW2h3bxc7dIrJaHoZTVmfHbn4BtmMEvIMLTYG
        A0noCF+wz/+qQFZnIELFfr5EaljiwkQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-668-8lky7uBJO1Gh3nLIssmDjw-1; Tue, 16 Aug 2022 17:18:37 -0400
X-MC-Unique: 8lky7uBJO1Gh3nLIssmDjw-1
Received: by mail-qv1-f71.google.com with SMTP id nj9-20020a05621437c900b004961f45e5b7so937254qvb.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=pB2MXlODWhdpcT5LoWH4Us0FJuxoK4gcT72TphVt0ag=;
        b=oIhmSgHG24alQGK+p/lDrLVOlgKp3A0tKuHYQ2qFVsEnWJiYnTrp4ns5Gg3YceyJ+v
         gmTb0yo3N7i06Mz7Djlj0CwJ8e6dANbf7cYPfBiTYFWWemvijbBRtTc98bxx1go3WgJ5
         415NLUWQ35U11HN48+0EK0h3DQqp84vQs5PjcpJD50m08Pf56dqy9ETFHPSLWbK1sH8q
         13HxE87y349NR6hUlnmZCwxlhvZsMq33FcINsEyi66X7pyl1/IWEdbs3vlXuUie81wcg
         aewgDmLIBoE98sWFEichrm56S7ZFukj5CvsR4tVRASYWjMxVt9xlHaDvO3Juz2SYpq+I
         /8Og==
X-Gm-Message-State: ACgBeo0F4urTsX6H7Ge813q5p8rVHRIDLD4SkOFp7RummHUwiL12qNYP
        P2Rs+KzPkVgkJNyB+zLswmy/jKz1B7glJ+esG+iOTZuM5Btw1ym3W/lczgsQWssj76xwVSb5WQF
        NKT15oKa3wBtCR3UJkNGFX8dM
X-Received: by 2002:ac8:5716:0:b0:344:540b:d118 with SMTP id 22-20020ac85716000000b00344540bd118mr13913280qtw.68.1660684716550;
        Tue, 16 Aug 2022 14:18:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7IEkmqc/qG0o268oGvr06pk78pb8Xs9cosCViTIQdJJKsk2JEc+qZbuIUUgdPWBgAZ+oPi5A==
X-Received: by 2002:ac8:5716:0:b0:344:540b:d118 with SMTP id 22-20020ac85716000000b00344540bd118mr13913263qtw.68.1660684716342;
        Tue, 16 Aug 2022 14:18:36 -0700 (PDT)
Received: from halaneylaptop ([2600:1700:1ff0:d0e0::1e])
        by smtp.gmail.com with ESMTPSA id h17-20020ac85e11000000b003430589dd34sm11766161qtx.57.2022.08.16.14.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:18:35 -0700 (PDT)
Date:   Tue, 16 Aug 2022 16:18:32 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] misc: fastrpc: Use USER_PD define in
 fastrpc_get_info_from_dsp
Message-ID: <20220816211832.6elmi3sg5gaeh3jl@halaneylaptop>
References: <20220816105528.3222763-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816105528.3222763-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 01:55:28PM +0300, Abel Vesa wrote:
> There are defines for each type of protection domain now.
> Use the USER_PD instead of magic value in fastrpc_get_info_from_dsp.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Amol Maheshwari <amahesh@qti.qualcomm.com>

This looks like it got the only remaining magic value assignment.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/misc/fastrpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 93ebd174d848..8895ca593911 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1515,7 +1515,7 @@ static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr
>  	args[1].ptr = (u64)(uintptr_t)&dsp_attr_buf[1];
>  	args[1].length = dsp_attr_buf_len;
>  	args[1].fd = -1;
> -	fl->pd = 1;
> +	fl->pd = USER_PD;
>  
>  	return fastrpc_internal_invoke(fl, true, FASTRPC_DSP_UTILITIES_HANDLE,
>  				       FASTRPC_SCALARS(0, 1, 1), args);
> -- 
> 2.34.1
> 

