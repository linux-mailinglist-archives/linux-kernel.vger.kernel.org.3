Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1835570FD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 04:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377931AbiFWCSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 22:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377918AbiFWCSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 22:18:40 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E983C38D8F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:18:39 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso1137824pjn.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8ktKbr7uBGDRIVppttuunEQkJn1Tz5nrNAaC4on+v0g=;
        b=PZy1DCFm6VpQWMaVejGZNjuXi4UybX5QZT64O/psnQdBhPkjjm48qJ7dPLqMPWDBQd
         lCPHJ2ZagZYPSMb4tCRN95tBV163wrNzlIRgtF5zO0Zkxomcc9DA48gDBYr8MJm3I5k7
         vaDUsv2VR8jpun/P8LdR/apzQTZ8MU3ewo+hW8/JIMXZSw7wuT7wU1E6IvXUmiBvsCtR
         u5aAorWCcFj3lc+I8qa2GU5Orecw1CbB0oShX4mboKDgwM1Nya9yk2xxyZ8/31pHAqKi
         h/iN/GEqhK9ZxZfowmvHCuXOK1bMp1iXDQErigcbp++0H1G4vV+klEjBQOFAlIAbNM5o
         8T7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8ktKbr7uBGDRIVppttuunEQkJn1Tz5nrNAaC4on+v0g=;
        b=FJXb2OEN7GA1lDz8cDXQG0v+PyITfF3tvC22iXA1t16p2C4tbDvhQe90nczHJw6hJY
         E5lcwRdcgRphduVSZhVyNGstx3Rf30FFEqQBEX89mrGC63bousfBTsGsbVuiHbpxs7g/
         pOoaX6cUAw1IduC8mhmuVQ4Zh9D3xaOHHrsnjLWhJ7Oek8hycNYToDahp4PXME2DOwbX
         84k7v+YjH3SlhHPbonR7Hi1a4I8A2J8VcA++ab+4wLDiPIe2yhh9Q/z6Z0RajnSbUGdE
         NclBKB85SGV7ylOfKSPXjvTlahYy9JS7PrSMRbCVxvWeGA4p5FUVdU/I48Db2F5E/11v
         p/qg==
X-Gm-Message-State: AJIora8DVZmuA2TlEMRhga+3HwX8B6+zqUXRfGAfkyjiFLABeQhxPHyz
        4T4vhyziAHg3U6n+QXxyMIE=
X-Google-Smtp-Source: AGRyM1sQThxRbXyIFTiEzJVpV6QhVBvyJ0zMT9vUlv3siu/xzAiDGYHLugyfHAmo3rWLsrZDWAfk7Q==
X-Received: by 2002:a17:902:ce85:b0:16a:4637:c4da with SMTP id f5-20020a170902ce8500b0016a4637c4damr7061580plg.82.1655950719413;
        Wed, 22 Jun 2022 19:18:39 -0700 (PDT)
Received: from [192.168.50.247] ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id y2-20020a170902ed4200b0016a09da5541sm10859253plb.135.2022.06.22.19.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 19:18:38 -0700 (PDT)
Message-ID: <2c51aa6e-1947-a4b2-c9af-f8c12b6a1985@gmail.com>
Date:   Thu, 23 Jun 2022 10:18:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm: i915: fix a possible refcount leak in
 intel_dp_add_mst_connector()
Content-Language: en-US
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch, ville.syrjala@linux.intel.com,
        jose.souza@intel.com, Bhawanpreet.Lakha@amd.com,
        matthew.d.roper@intel.com, heying24@huawei.com,
        anshuman.gupta@intel.com, james.ausmus@intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220516071922.22955-1-hbh25y@gmail.com>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <20220516071922.22955-1-hbh25y@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/16 15:19, Hangyu Hua wrote:
> If drm_connector_init fails, intel_connector_free will be called to take
> care of proper free. So it is necessary to drop the refcount of port
> before intel_connector_free.
> 
> Fixes: 091a4f91942a ("drm/i915: Handle drm-layer errors in intel_dp_add_mst_connector")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>   drivers/gpu/drm/i915/display/intel_dp_mst.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> index e30e698aa684..f7d46ea3afb9 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> @@ -841,6 +841,7 @@ static struct drm_connector *intel_dp_add_mst_connector(struct drm_dp_mst_topolo
>   	ret = drm_connector_init(dev, connector, &intel_dp_mst_connector_funcs,
>   				 DRM_MODE_CONNECTOR_DisplayPort);
>   	if (ret) {
> +		drm_dp_mst_put_port_malloc(port);
>   		intel_connector_free(intel_connector);
>   		return NULL;
>   	}

Gentel ping.
