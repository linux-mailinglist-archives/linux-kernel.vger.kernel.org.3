Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52E858B10B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbiHEVRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiHEVRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D6486582A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 14:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659734270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZNlrEXt8H3ovW/I1Y4O4JfffQjM6ZL4QQdyq55TVvI=;
        b=fhco1kN8lHuR89L2nFrzZ/KLkfR58GycLiF9uD1SOh4o45onTAgHuRG/WeR2AB5KUBnTNJ
        84Xg0q2QZBfozv0Y/rHwbJYc9tnVhI4nXDaNsA/Zo3ZdbabSaXrJFW2LFj4WrqwXxhtWhF
        K1RLJZ3Dwpa5oDpcMfObr3XZaqjvHek=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-_OTjYX5IMKC75WeQQ95Hdw-1; Fri, 05 Aug 2022 17:17:49 -0400
X-MC-Unique: _OTjYX5IMKC75WeQQ95Hdw-1
Received: by mail-qk1-f199.google.com with SMTP id l15-20020a05620a28cf00b006b46997c070so2883998qkp.20
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 14:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc;
        bh=RZNlrEXt8H3ovW/I1Y4O4JfffQjM6ZL4QQdyq55TVvI=;
        b=K6Kkp4uRFDxitU9a47EVqXh8wACJtgwTY5fXeigSzRn0z3B24Y661yoUb58mnqzjqG
         RTdoS0o3fxv3w8p2Qycgdb7tUO5VLNOcsyBZar4z9ex3fPF7apVFMSTYH3asoUEKvm/L
         J4+PBMKrvA52VYUCRafjQXNiaO95YiGIb9aGzGMSkS52YlXRRBOdGJaibQFh2GFRgorz
         +meTjzrLcjb06hN3L93FdL30CoJbKAO4hZg/wayKUCA+C7vdUtVUBfHFKIWvAG6btu/c
         9U7bzlv/0BKsE6+60q8kqLngKarwP630n1P6k6fEzkkS5jjid//o7qnQ3E2uqjTShGHr
         iUaw==
X-Gm-Message-State: ACgBeo02CYlBaWW7Ydgg2J3k6iUgoCutC3M+FRkyWnubte2CKsZUKMgU
        J5oKBQisKczQQpTPyiTRIRjfHcCkdADX6nDBdZ/8bL+vmmMMUY1zFAxI5sES5k25TPpb66doSMH
        QPUYFIXQODQvYUhEuQHTCU+xN
X-Received: by 2002:a37:b483:0:b0:6b5:8688:5299 with SMTP id d125-20020a37b483000000b006b586885299mr6636096qkf.147.1659734269042;
        Fri, 05 Aug 2022 14:17:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7pmL6DY3sVN5gCS02n3AEyH096euzmB9SRpV1Pn7JxBN+0iCPYIk1jwjNp9v201FEnnIEpPw==
X-Received: by 2002:a37:b483:0:b0:6b5:8688:5299 with SMTP id d125-20020a37b483000000b006b586885299mr6636063qkf.147.1659734268786;
        Fri, 05 Aug 2022 14:17:48 -0700 (PDT)
Received: from [192.168.8.138] (pool-100-0-245-4.bstnma.fios.verizon.net. [100.0.245.4])
        by smtp.gmail.com with ESMTPSA id d3-20020a05620a158300b006b5e3ca6400sm3439923qkk.103.2022.08.05.14.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:17:48 -0700 (PDT)
Message-ID: <8db8a726d1aac25b3590497db9cbdcc3fe161227.camel@redhat.com>
Subject: Re: [PATCH v2 1/3] drm/dp_mst: add passthrough_aux to struct
 drm_dp_mst_port
From:   Lyude Paul <lyude@redhat.com>
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>, linux-kernel@vger.kernel.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        hersenxs.wu@amd.com, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Claudio Suarez <cssk@net-c.es>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Roman Li <Roman.Li@amd.com>, Ian Chen <ian.chen@amd.com>,
        Colin Ian King <colin.king@intel.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@intel.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Imre Deak <imre.deak@intel.com>,
        David Zhang <dingchen.zhang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Date:   Fri, 05 Aug 2022 17:17:46 -0400
In-Reply-To: <20220805211317.176672-1-hamza.mahfooz@amd.com>
References: <20220805211317.176672-1-hamza.mahfooz@amd.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lgtm!

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Fri, 2022-08-05 at 17:13 -0400, Hamza Mahfooz wrote:
> Currently, there is no way to identify if DSC pass-through can be
> enabled and what aux DSC pass-through requests ought to be sent to. So,
> add a variable to struct drm_dp_mst_port that keeps track of the
> aforementioned information.
> 
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
> v2: define DP_DSC_PASSTHROUGH_IS_SUPPORTED
> ---
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 +++-
>  include/drm/display/drm_dp.h                  | 1 +
>  include/drm/display/drm_dp_mst_helper.h       | 3 +++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 67b3b9697da7..71915afd9892 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -5921,8 +5921,10 @@ struct drm_dp_aux *drm_dp_mst_dsc_aux_for_port(struct drm_dp_mst_port *port)
>  		/* Enpoint decompression with DP-to-DP peer device */
>  		if ((endpoint_dsc & DP_DSC_DECOMPRESSION_IS_SUPPORTED) &&
>  		    (endpoint_fec & DP_FEC_CAPABLE) &&
> -		    (upstream_dsc & 0x2) /* DSC passthrough */)
> +		    (upstream_dsc & DP_DSC_PASSTHROUGH_IS_SUPPORTED)) {
> +			port->passthrough_aux = &immediate_upstream_port->aux;
>  			return &port->aux;
> +		}
>  
>  		/* Virtual DPCD decompression with DP-to-DP peer device */
>  		return &immediate_upstream_port->aux;
> diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
> index 9e3aff7e68bb..4d0abe4c7ea9 100644
> --- a/include/drm/display/drm_dp.h
> +++ b/include/drm/display/drm_dp.h
> @@ -239,6 +239,7 @@
>  
>  #define DP_DSC_SUPPORT                      0x060   /* DP 1.4 */
>  # define DP_DSC_DECOMPRESSION_IS_SUPPORTED  (1 << 0)
> +# define DP_DSC_PASSTHROUGH_IS_SUPPORTED    (1 << 1)
>  
>  #define DP_DSC_REV                          0x061
>  # define DP_DSC_MAJOR_MASK                  (0xf << 0)
> diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
> index 10adec068b7f..4a39c95f8afd 100644
> --- a/include/drm/display/drm_dp_mst_helper.h
> +++ b/include/drm/display/drm_dp_mst_helper.h
> @@ -86,6 +86,8 @@ struct drm_dp_vcpi {
>   * @next: link to next port on this branch device
>   * @aux: i2c aux transport to talk to device connected to this port, protected
>   * by &drm_dp_mst_topology_mgr.base.lock.
> + * @passthrough_aux: parent aux to which DSC pass-through requests should be
> + * sent, only set if DSC pass-through is possible.
>   * @parent: branch device parent of this port
>   * @vcpi: Virtual Channel Payload info for this port.
>   * @connector: DRM connector this port is connected to. Protected by
> @@ -140,6 +142,7 @@ struct drm_dp_mst_port {
>  	 */
>  	struct drm_dp_mst_branch *mstb;
>  	struct drm_dp_aux aux; /* i2c bus for this port? */
> +	struct drm_dp_aux *passthrough_aux;
>  	struct drm_dp_mst_branch *parent;
>  
>  	struct drm_dp_vcpi vcpi;

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

