Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF7555F1A5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiF1W4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiF1W4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:56:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 979C12E9C4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656456961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jybXg/FUgJez1sldBOUSITHswGwsCdpMTH0/zg4mKAQ=;
        b=LJ+Pw089Uk6eFpjVMb4BwvzZ21MA2IiCXY76EpkkhCuacbekSrOAX19jdM89OZ3jnTdorf
        ntbNxP7HBUmDOPkmXYpnz7bjAPuBQ1fFptCZCCW+5TCCcSJ48rGFVQdk0g69QDwIzl6V2o
        J1sjN/pGO5OmYMO7Q4vkdT1QHN1Ac7c=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-jAUbFO89Ml6NOFOFTmvmzA-1; Tue, 28 Jun 2022 18:56:00 -0400
X-MC-Unique: jAUbFO89Ml6NOFOFTmvmzA-1
Received: by mail-qv1-f72.google.com with SMTP id ke24-20020a056214301800b00470b5eb1debso8140130qvb.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=jybXg/FUgJez1sldBOUSITHswGwsCdpMTH0/zg4mKAQ=;
        b=SRJAsYJmqrNbwerBlicj3SYkT0Axk0IobKaDlyEDnjEkVLyCdl93JoVoA6bqrWrdHD
         QgXIhbHQYSSAr/GgJdOcIgoYl+DDQeY2OINU+MFws8Bk9nB0+Yx0YX5rFG+AUe/8Ui/e
         8m0FghbTlxe3mPDqgFQIp1UQGave17/5WifiMNvpa3TiTx2Ud6nE1hL2XYMfclQz+vwy
         NM1Em/MlieacnxVSDk2v5Gxyfo0m3lAojtMfYJmd+B0+8r5DMXJaCJuQO6uMEBggq/dj
         0XmDjdBszytMFtUkGIG7UMAr2ElKoRrwE+UkjOiy63dPmmZ/WZhy/u5NvYVRygXjASUM
         nNBQ==
X-Gm-Message-State: AJIora+fpk2UaexY9KbXI8gsgYwbCvAENFKela4OS8kHjR5p7yNbL5pW
        hg5S0jV91GpnbG3znUMVeQy6r2BQDRbpsf5DB9cCGpaqoAZxR3bN4slUeWvVSq2uXv76yMpaS55
        AMaZEwyEQ/3RTlSRJOOuHid4y
X-Received: by 2002:ad4:5b8a:0:b0:470:9844:82eb with SMTP id 10-20020ad45b8a000000b00470984482ebmr4500442qvp.80.1656456959705;
        Tue, 28 Jun 2022 15:55:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uv0diZbu7DdlAqriM5qJnTjzPu331swtoRWodUD0GwGzVbEhqdjcba19pYI3CvpJYTRfV0qg==
X-Received: by 2002:ad4:5b8a:0:b0:470:9844:82eb with SMTP id 10-20020ad45b8a000000b00470984482ebmr4500421qvp.80.1656456959441;
        Tue, 28 Jun 2022 15:55:59 -0700 (PDT)
Received: from [192.168.8.138] ([141.154.49.182])
        by smtp.gmail.com with ESMTPSA id r4-20020ac84244000000b00317ca023e33sm9361586qtm.80.2022.06.28.15.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 15:55:58 -0700 (PDT)
Message-ID: <4119ed8c7ace96e1fa46b34fd9e8404828c3e57d.camel@redhat.com>
Subject: Re: [PATCH RESEND] drm: i915: fix a possible refcount leak in
 intel_dp_add_mst_connector()
From:   Lyude Paul <lyude@redhat.com>
To:     Hangyu Hua <hbh25y@gmail.com>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie, daniel@ffwll.ch,
        ville.syrjala@linux.intel.com, jose.souza@intel.com,
        matthew.d.roper@intel.com, anshuman.gupta@intel.com,
        heying24@huawei.com, james.ausmus@intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 28 Jun 2022 18:55:57 -0400
In-Reply-To: <20220624022813.10796-1-hbh25y@gmail.com>
References: <20220624022813.10796-1-hbh25y@gmail.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nice catch!

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-intel-next

On Fri, 2022-06-24 at 10:28 +0800, Hangyu Hua wrote:
> If drm_connector_init fails, intel_connector_free will be called to take
> care of proper free. So it is necessary to drop the refcount of port
> before intel_connector_free.
> 
> Fixes: 091a4f91942a ("drm/i915: Handle drm-layer errors in
> intel_dp_add_mst_connector")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp_mst.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> index 061b277e5ce7..14d2a64193b2 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> @@ -839,6 +839,7 @@ static struct drm_connector
> *intel_dp_add_mst_connector(struct drm_dp_mst_topolo
>         ret = drm_connector_init(dev, connector,
> &intel_dp_mst_connector_funcs,
>                                  DRM_MODE_CONNECTOR_DisplayPort);
>         if (ret) {
> +               drm_dp_mst_put_port_malloc(port);
>                 intel_connector_free(intel_connector);
>                 return NULL;
>         }

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

