Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90AA5ABA22
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 23:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiIBVfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 17:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiIBVfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 17:35:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E4E6B64B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 14:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662154504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8tLM/3lJtaAYsqKeYEGRVJvBSiRQW7/b6UjPp23Gpt8=;
        b=eecIaoIdClM+KXOx0uIB/YIrNJ5+wAZ1Kles7Z2tKWklohoWWjo++g8Zq/7ThbaZ/PByuz
        QeNxCvuQWHT/EEFQ/hjjiR60QuZOCBq0qSFYB4yCTDh1Y1WOHThzvD1b8tjHS/oPs8NYlt
        VBzyWZaM9sNZwYTKP2xNlFschQ658P8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-586-HQUKKrdlO8Kgy_W44t_YFA-1; Fri, 02 Sep 2022 17:35:03 -0400
X-MC-Unique: HQUKKrdlO8Kgy_W44t_YFA-1
Received: by mail-qv1-f71.google.com with SMTP id h13-20020a0ceecd000000b00498f5b113e6so2077379qvs.21
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 14:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8tLM/3lJtaAYsqKeYEGRVJvBSiRQW7/b6UjPp23Gpt8=;
        b=Sj3gaCXhWnqSlGD8AteY79lFtPMiyI9DD64K45nLvxC/DUpqnNeb6udra+JaENUm94
         iVP8IpWejlgSiQfNpW3qFtEH1Zhl5L5DmY5n3s+zMmURqJnIkzItpNIXu5Y3oCdIr3US
         xjucJUxhV7Ck3hAk8pTRI+5AJG3UTuZo3PEDk1GQeKER0MgUs93qZC/lC4qRyw4ICK0n
         ocn0ezsj45QuEj9SKBdbE/EIdLslIcfwgVdMrzhYJCjNMQUcacoj32niWomVesZUYgZU
         G9M/plAig02nWueGYQG9M97i1uhUIDabvjTsPKcysp7EhwZ3yh79xSB88++rJJTY+eTh
         0Dww==
X-Gm-Message-State: ACgBeo2HcQLE2nLuF9DnYqTZRlA9wlDPcm7mjYB9rf6ljMHfv2hRMwfB
        l4HOK5AtM3PTzvt2RGN5OvKwYzlFVkke7eHXnqZCySsRJLE5EKUNS6r6FO2lc66gApJpBrGeWf2
        VNzXWXZXonBZ947I6CRhnaRbt
X-Received: by 2002:ac8:5a55:0:b0:343:72f9:7053 with SMTP id o21-20020ac85a55000000b0034372f97053mr29376140qta.518.1662154502915;
        Fri, 02 Sep 2022 14:35:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR71MqC8+ulzndg1RInO2Lgus6TlkwKGDoiDVHA9iSaBYpFk7mer7xfBbfAfM9XAI4bEWzDHfA==
X-Received: by 2002:ac8:5a55:0:b0:343:72f9:7053 with SMTP id o21-20020ac85a55000000b0034372f97053mr29376127qta.518.1662154502700;
        Fri, 02 Sep 2022 14:35:02 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c48:e00:e786:1aff:4f5c:c549? ([2600:4040:5c48:e00:e786:1aff:4f5c:c549])
        by smtp.gmail.com with ESMTPSA id s4-20020a05620a254400b006bacf4703c5sm2215158qko.111.2022.09.02.14.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 14:35:02 -0700 (PDT)
Message-ID: <cde7369a1d078249244759662989427b1f853bdd.camel@redhat.com>
Subject: Re: [PATCH] drm/dp: Avoid Reading DPCD_REV Before Native Aux Read
From:   Lyude Paul <lyude@redhat.com>
To:     Fangzhi Zuo <Jerry.Zuo@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
        Ville Syrjala <ville.syrjala@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Date:   Fri, 02 Sep 2022 17:35:00 -0400
In-Reply-To: <20220831221321.748264-1-Jerry.Zuo@amd.com>
References: <20220831221321.748264-1-Jerry.Zuo@amd.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Wed, 2022-08-31 at 18:13 -0400, Fangzhi Zuo wrote:
> The attempt to read DPCD_REV before any native aux read breaks
> majority of DP2 compliance.
> 
> The spec. requires DP_SINK_STATUS to be polled for the reset status
> DP_INTRA_HOP_AUX_REPLY_INDICATION during the clear training stage.
> 
> Polling DP_SINK_STATUS each time gets DPCD_REV read first
> that makes non link training regsiter DPCD_REV get read
> during UHBR link training. It violates DP2 compliance.
> 
> Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> ---
>  drivers/gpu/drm/display/drm_dp_helper.c | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index e7c22c2ca90c..c7aa5bafa667 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -571,24 +571,6 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
>  {
>  	int ret;
>  
> -	/*
> -	 * HP ZR24w corrupts the first DPCD access after entering power save
> -	 * mode. Eg. on a read, the entire buffer will be filled with the same
> -	 * byte. Do a throw away read to avoid corrupting anything we care
> -	 * about. Afterwards things will work correctly until the monitor
> -	 * gets woken up and subsequently re-enters power save mode.
> -	 *
> -	 * The user pressing any button on the monitor is enough to wake it
> -	 * up, so there is no particularly good place to do the workaround.
> -	 * We just have to do it before any DPCD access and hope that the
> -	 * monitor doesn't power down exactly after the throw away read.
> -	 */
> -	if (!aux->is_remote) {
> -		ret = drm_dp_dpcd_probe(aux, DP_DPCD_REV);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
>  	if (aux->is_remote)
>  		ret = drm_dp_mst_dpcd_read(aux, offset, buffer, size);
>  	else

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

