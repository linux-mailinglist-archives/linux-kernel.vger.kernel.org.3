Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20103493CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355602AbiASPNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347595AbiASPNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:13:37 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D802EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:13:36 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 25-20020a05600c231900b003497473a9c4so14710798wmo.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nojvlSBxMxzR4GSErwgQdagPUIgNBTK8vSAAewWJfGo=;
        b=UdOh/AhxxSV2+uxZH/MLQG8GMpYKK7LtGvtEgzc0oMjASCb0xgLv1JVkWwbP0Mcj+V
         FTB44ALi2Dkmxa5TtFeeIbigQ+N1KF2QOFjs7nfHIYs/h2YuRCfAJjZQE2rSWo5KHyMt
         4CPSxa99XOEfmjqqpp6mRZSATV4pq1lBLqP7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=nojvlSBxMxzR4GSErwgQdagPUIgNBTK8vSAAewWJfGo=;
        b=eOulwYQog+SPXFL9rLK9BgDPcEkmJDY2m/Zc36uN4JzMg5WECIVwGbHBr+S/ahCX6B
         sLVDrRUzopduY3A80hHcLWKo+Cp0w9MSagMxOrD0FU0JT6ND5Lbv0isQ8SvMTnwjqjfX
         0NC/UaegF9Mesj/Qs5hm9ZvU9KGKY87fcboO3PhUkG4JLSy2o+yVX77a9v2eH0PaUi3r
         jf28aHh1u12MuQF9ohsck7Zm/AygpCSVFwRawQ49L0XXbJAx4zk5aDw0cH6rzWLjGlj+
         XjF8Q5iYwnythcg8akjtAUXyNwNomaAYY8wmyQ5J+sWkqXjzmRSaHIt9h8EQvh43C75b
         oVmQ==
X-Gm-Message-State: AOAM530Lad0XvkRDSuEqP7fSUBu9apXnE0ExRZ/0WS2csMyVSwZbShG2
        kmhkaJzrPmvjWpi55SEoin8D4/3iy57+pQ==
X-Google-Smtp-Source: ABdhPJzgCMa/tbYtoVRSIfTNfXLaMUVi4OH5qPmaP5VowNhx7sB3F/GwbvttLoWt7A3z38o+qBf4Sw==
X-Received: by 2002:a05:6000:3c5:: with SMTP id b5mr26652200wrg.312.1642605215514;
        Wed, 19 Jan 2022 07:13:35 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z1sm5057694wma.20.2022.01.19.07.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 07:13:34 -0800 (PST)
Date:   Wed, 19 Jan 2022 16:13:33 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, lee.jones@linaro.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/selftests/test-drm_dp_mst_helper: Fix memory leak
 in sideband_msg_req_encode_decode
Message-ID: <YegqnfDXHmxUBWxI@phenom.ffwll.local>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        airlied@linux.ie, lee.jones@linaro.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220108165812.46797-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220108165812.46797-1-jose.exposito89@gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 05:58:12PM +0100, José Expósito wrote:
> Avoid leaking the "out" variable if it is not possible to allocate
> the "txmsg" variable.
> 
> Fixes: 09234b88ef55 ("drm/selftests/test-drm_dp_mst_helper: Move 'sideband_msg_req_encode_decode' onto the heap")
> Addresses-Coverity-ID: 1475685 ("Resource leak")
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> 
> ---
> 
> v2: Improve commit message

Applied to drm-misc-next, thanks.
-Daniel

> ---
>  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> index 6b4759ed6bfd..c491429f1a02 100644
> --- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> +++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> @@ -131,8 +131,10 @@ sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
>  		return false;
>  
>  	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
> -	if (!txmsg)
> +	if (!txmsg) {
> +		kfree(out);
>  		return false;
> +	}
>  
>  	drm_dp_encode_sideband_req(in, txmsg);
>  	ret = drm_dp_decode_sideband_req(txmsg, out);
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
