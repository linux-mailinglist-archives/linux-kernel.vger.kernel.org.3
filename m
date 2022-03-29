Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEB34EB69B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbiC2XTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiC2XTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:19:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D13ADD4A;
        Tue, 29 Mar 2022 16:17:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 31C6A1F44074
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648595851;
        bh=vNOmry5ThwZXsotfcrBezmCsAHRH+JMNFUfaSsIR1GY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D4P34mYNJY6M7Oz8ATv7zNF8aeyzQ2jScIuorEl7BXVhy3SrlRhjvPvzZczvzXyKa
         WjScuOK6EJM040rfOLlkgvoeO7A0n4GrlLpbl+l1agHYy0on9x+TpKw0dZVmZYCSgW
         c5ZdbL4hVqVe6DfgZw9LMT8DhovSzp3goCLGL/tsGNX4tstvvytqBS84uxiZMSq2hx
         kNK86GV8wFomze2ERyiokH6qPpIC+4p0WT3BfjEmciFMar+6uLSNba2MvG9+Sga0De
         DE7RccOC5/qo9tk0dibZzuU1oRwS+x7gqXYDGGEeN5JTnlbYhaevaY8M+yKE50vfRy
         UU9LWMInwT2wA==
Message-ID: <74a98688-67ad-6f8d-da1e-8fa0b32cff71@collabora.com>
Date:   Wed, 30 Mar 2022 02:17:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 9/9] drm/msm: Add a way for userspace to allocate GPU iova
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Emma Anholt <emma@anholt.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sean Paul <sean@poorly.run>, freedreno@lists.freedesktop.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220329230105.601666-1-robdclark@gmail.com>
 <20220329230105.601666-10-robdclark@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220329230105.601666-10-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/30/22 02:00, Rob Clark wrote:
> +static int msm_ioctl_gem_info_set_iova(struct drm_device *dev,
> +		struct drm_file *file, struct drm_gem_object *obj,
> +		uint64_t iova)
> +{
> +	struct msm_drm_private *priv = dev->dev_private;
> +	struct msm_file_private *ctx = file->driver_priv;
> +
> +	if (!priv->gpu)
> +		return -EINVAL;
> +
> +	/* Only supported if per-process address space is supported: */
> +	if (priv->gpu->aspace == ctx->aspace)
> +		return -EINVAL;

nit: -EOPNOTSUPP ?
