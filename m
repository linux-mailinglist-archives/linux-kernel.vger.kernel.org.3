Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD284CC437
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiCCRoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiCCRoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:44:15 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCA110C6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:43:29 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p17so5194594plo.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 09:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3mNZQL2VC2uYb431PEz6jnFD5ZTmVgeO3AWfSaB6+TY=;
        b=TSou/dg3MxKfuVnSlJ7/9Ygb6rTt3uj1IAV4FuRAP0EFPtQzGCi18SqZsbllXX+6S8
         ntcMT0x0I5bMkPvRf+RymUl7ybQA3dv1GWojQ1350VFS3FT8qE2h7SFFXSceT7yfD2T8
         voM8RJe8gyMdGEmB0QSQndTKjgdU+d71aw2BA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3mNZQL2VC2uYb431PEz6jnFD5ZTmVgeO3AWfSaB6+TY=;
        b=027n+OYSTT4wE7GlCZ9/cDNnSQpFv2d9f8eU/oEvdm9DISq9Az2dw741GLgs6g3Es5
         SYjNXdjD9UyCOxgBYGMlJ4vEzlPTfyQa2Zlqbk3fzGzT2VHFgiR+YHiMWOxyeO1LGNP4
         ZMvNLnn4Ft9GnGGZGvO4w+qcq1lyIFY83Y3w+6ecUtMydk1GOZ6VuTtZMB33vZu2CvAL
         C35bcEANovMIcsdvWAHx2b6rcxs839FW81UAsDPlcQsqlGxU73KcIymnBV99sAgO6ig5
         Cun1aA4qOEiDaNwilqg8LjLOR7XtuRU+2vTFuTNrcqvHHefMYaZHJ2xgvKzOYe7O9mKE
         AY1g==
X-Gm-Message-State: AOAM5324WTK5OJA7cseL6fhLAGvXL68FuTXwv+CJ0gDLB3s+c6TKerOP
        HYgT4ueqybbs2gmonFWuh4IP4w==
X-Google-Smtp-Source: ABdhPJwuuWN6vPSVt7Mv7dHURNIv9eDx1oLiv+vp7zPxRp6zIMVlyTuNFHJ/8c8jo+dQfkkeI/rm5Q==
X-Received: by 2002:a17:902:d2cd:b0:14f:c169:dc6f with SMTP id n13-20020a170902d2cd00b0014fc169dc6fmr36769598plc.170.1646329409448;
        Thu, 03 Mar 2022 09:43:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t9-20020a655549000000b0036570f81245sm2536433pgr.84.2022.03.03.09.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 09:43:29 -0800 (PST)
Date:   Thu, 3 Mar 2022 09:43:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/amd/display: Fix Wstringop-overflow warnings
 in dc_link_dp.c
Message-ID: <202203030937.5BFE3EF@keescook>
References: <20220303172503.GA1731116@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220303172503.GA1731116@embeddedor>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 11:25:03AM -0600, Gustavo A. R. Silva wrote:
> Fix the following Wstringop-overflow warnings when building with GCC-11:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dpia.c:493:17: warning: ‘dp_decide_lane_settings’ accessing 4 bytes in a region of size 1 [-Wstringop-overflow=]

Can you "show your work" a little more here? I don't actually see the
what is getting fixed:

enum dc_lane_count {
	...
        LANE_COUNT_FOUR = 4,
	...
        LANE_COUNT_DP_MAX = LANE_COUNT_FOUR
};

struct link_training_settings {
	...
        union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX];
};

void dp_hw_to_dpcd_lane_settings(
		...
		union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX])
{
	...
}

static enum link_training_result dpia_training_cr_transparent(
		...
                struct link_training_settings *lt_settings)
{
	...
                dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
                                lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
	...
}

Everything looks to be the correct size?

-- 
Kees Cook
