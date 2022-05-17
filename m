Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9366F52AC49
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 21:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347770AbiEQTxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 15:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiEQTxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADF3F517F1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652817180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HwEpCwWlcxdGpOh2tFBezSPA0lfra9DVTBWTEtNs0uA=;
        b=cYQCcyv0STn88qos2771zcZmL5rA23B8GhTeORsh+GZJiSTvOZPkb3gb4dOfus6Lj4yX2X
        L9/CZAEK9nDriuncj6fXgbrbOvEFW3GZ8szFX54qCTQLobs7tIP8yBNWEVB+CkyDFFVwMY
        AR8E6VW99HS0uoil8QG9Xe9HX5MZaRk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-6GqKLClIOAOuOIrnxxTOSQ-1; Tue, 17 May 2022 15:52:59 -0400
X-MC-Unique: 6GqKLClIOAOuOIrnxxTOSQ-1
Received: by mail-qk1-f199.google.com with SMTP id c84-20020a379a57000000b0069fcf83c373so14452581qke.20
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=HwEpCwWlcxdGpOh2tFBezSPA0lfra9DVTBWTEtNs0uA=;
        b=6IXh+KMC1Pp/gvZXS/dyab/m3ViAOTNx/PsnpcekHB29kOB2A4trjgHh79pCgEkrlw
         xcR3Uu8lvtPq8/BaAau4KKAGnWpaNQ/yQNGr2wxFeuXmI/RoFKQb+wPiLE7r/N7vYijd
         5GJL2PymLIAJsY20UHPh+/YnPiN1wj+yL8VUE2a+6urzYU37vvMLmGwTblQhfu4n6UCl
         tIdL3nrvoDRAc8kIUv+QkbN/8ZoTuTD2Q40z+d2pdjUQf395cafnBopGj/bPQ8DqcMK2
         XvdlHuywK+LGx/5GfOhs9gy3di3F0AJyeSCzTVkBK0b5IO0rpHscD43syUjPproCCBmP
         ubXg==
X-Gm-Message-State: AOAM533l2W1sGcI9ThC5nx/ddjq4x8peKZa2xCUUOjkpVEL+dYKpi1xH
        u+VI5SHsjO9VhMYMrgsiUA/8Rss2wqaXEAwLvflvFu6eidpVUYjKwAH8fEIJuxp8AUeOnPVg8ov
        yzNJPnfMyNdFfBbHsaCOaWYXC
X-Received: by 2002:ac8:7f04:0:b0:2f3:d6d6:8406 with SMTP id f4-20020ac87f04000000b002f3d6d68406mr21140163qtk.509.1652817178777;
        Tue, 17 May 2022 12:52:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzI74W9XBXed/MCxieJlQiY3NWMHtAwR2gds0+hD9NzYRsIWSES9Qsw4mJKcoCLwfVUxPTf0A==
X-Received: by 2002:ac8:7f04:0:b0:2f3:d6d6:8406 with SMTP id f4-20020ac87f04000000b002f3d6d68406mr21140150qtk.509.1652817178417;
        Tue, 17 May 2022 12:52:58 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id j63-20020a378742000000b0069fc13ce1efsm61251qkd.32.2022.05.17.12.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 12:52:57 -0700 (PDT)
Message-ID: <876ef490a577b8af71d1a8d24a55e43616b7d45b.camel@redhat.com>
Subject: Re: [PATCH] drm: dp: fix a possible memory leak in
 fetch_monitor_name()
From:   Lyude Paul <lyude@redhat.com>
To:     Hangyu Hua <hbh25y@gmail.com>, airlied@linux.ie, daniel@ffwll.ch,
        tzimmermann@suse.de, jani.nikula@intel.com,
        Bhawanpreet.Lakha@amd.com, Wayne.Lin@amd.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Tue, 17 May 2022 15:52:56 -0400
In-Reply-To: <20220516032042.13166-1-hbh25y@gmail.com>
References: <20220516032042.13166-1-hbh25y@gmail.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to the appropriate branch in a bit

On Mon, 2022-05-16 at 11:20 +0800, Hangyu Hua wrote:
> drm_dp_mst_get_edid call kmemdup to create mst_edid. So mst_edid need to be
> freed after use.
> 
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  drivers/gpu/drm/dp/drm_dp_mst_topology.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/dp/drm_dp_mst_topology.c
> b/drivers/gpu/drm/dp/drm_dp_mst_topology.c
> index 11300b53d24f..7a7cc44686f9 100644
> --- a/drivers/gpu/drm/dp/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/dp/drm_dp_mst_topology.c
> @@ -4852,6 +4852,7 @@ static void fetch_monitor_name(struct
> drm_dp_mst_topology_mgr *mgr,
>  
>         mst_edid = drm_dp_mst_get_edid(port->connector, mgr, port);
>         drm_edid_get_monitor_name(mst_edid, name, namelen);
> +       kfree(mst_edid);
>  }
>  
>  /**

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

