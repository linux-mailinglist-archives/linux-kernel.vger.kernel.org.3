Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF2A58E251
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiHIWCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiHIWB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:01:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 823A3630D
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660082513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hXClH5jdUWIe5M+ib/xHzOhaf9sL3Q8vI0p0DQ3TOBg=;
        b=WK9fWFmwB53DwlLts7hOQLl8LbxTHCs40U0FSr7v1VTk8/QU9E5ggawd+SuZIeK0T16D3w
        bTd0V7HiTA7xTAm35DnBO2Ly1aP32g62M0zvmlrgXs0cDGBP9+Zn1OFdU9+7s1gVSzSu+v
        NINgCJBzlSc7zBq3c2VoyF2crRvTloU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-37-D2Wx23hcOMO2MiEsAwap_A-1; Tue, 09 Aug 2022 18:01:52 -0400
X-MC-Unique: D2Wx23hcOMO2MiEsAwap_A-1
Received: by mail-qv1-f72.google.com with SMTP id e12-20020ad4442c000000b004796bf5f82cso6006361qvt.20
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc;
        bh=hXClH5jdUWIe5M+ib/xHzOhaf9sL3Q8vI0p0DQ3TOBg=;
        b=0v4qmC48EF4Zg8lRjyUaQ6dFFhGC15iwPmThIcwOyCm+Ky0Gy+iC+zZrcN8ghv89hX
         8wUpkRongb+/jiTOLQegA7a8h2ZfzVTNpfelfby1KfE98+8uO09v0A7N6grmvNHSdp2n
         h0nS+XW75/4p/f+O2/tUOXToc5/HE3zl6gOERsIVeIy+g3cc8L9FWBmQR7vT8x+imRte
         7RZ3ptYjBkaRHZcWCnvfgbuHv6/MjMpackQvTir5hjAphsuW0A5zkEBdppCcv3I06zDg
         upONRcpG6/pPeNekbfUaFAQLLbdcKJHfX5btGHIfvZl06WM+7DZqd75qoXpCIyv5pJLa
         aJhg==
X-Gm-Message-State: ACgBeo1tOyWHVpw6EiioyW+AHWFq0nlibfMLGkABaXx4gLavcDhTHSmH
        kx0AsSeydmjSIMbhpgO/5PGaoKtXliW99RLa5QajniFtJcxVce5uC1FCgCiNnb3NgcXq4IIp5xM
        2uaUyOy6W/zWJoTGUzJlWueMS
X-Received: by 2002:a05:622a:406:b0:343:7ae:4fe9 with SMTP id n6-20020a05622a040600b0034307ae4fe9mr4263145qtx.541.1660082511919;
        Tue, 09 Aug 2022 15:01:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7j97sgEEk3li4n4X8PZTGGsvKpjv63PR41p3SkEOYsJC//AlysS6kFFWEKTw7244zroa4EKg==
X-Received: by 2002:a05:622a:406:b0:343:7ae:4fe9 with SMTP id n6-20020a05622a040600b0034307ae4fe9mr4263108qtx.541.1660082511664;
        Tue, 09 Aug 2022 15:01:51 -0700 (PDT)
Received: from [192.168.8.138] (pool-100-0-245-4.bstnma.fios.verizon.net. [100.0.245.4])
        by smtp.gmail.com with ESMTPSA id u18-20020a37ab12000000b006b945519488sm5268186qke.88.2022.08.09.15.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:01:51 -0700 (PDT)
Message-ID: <3690a632acc9d5d83ae8a33dfc8b88db7fe8aebf.camel@redhat.com>
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
Date:   Tue, 09 Aug 2022 18:01:49 -0400
In-Reply-To: <b6e10f4a-6834-fccb-0cba-0990dda37a76@amd.com>
References: <20220805211317.176672-1-hamza.mahfooz@amd.com>
         <8db8a726d1aac25b3590497db9cbdcc3fe161227.camel@redhat.com>
         <b6e10f4a-6834-fccb-0cba-0990dda37a76@amd.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah yes of course! Probably should have asked when I gave the r-b :). Also,
just so patchwork actually catches it I will say the magic incantation:

Reviewed-by: Lyude Paul <lyude@redhat.com>

Do we want to merge just this patch to drm-misc-next, or do you want to merge
the whole series through there? If you'd rather just merge this through amd's
branch I'm fine with that as well

On Tue, 2022-08-09 at 11:15 -0400, Hamza Mahfooz wrote:
> Hey Lyude,
> 
> On 2022-08-05 17:17, Lyude Paul wrote:
> > lgtm!
> > 
> 
> Any chance you can apply this to drm-misc-next?
> 
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > 
> > On Fri, 2022-08-05 at 17:13 -0400, Hamza Mahfooz wrote:
> > > Currently, there is no way to identify if DSC pass-through can be
> > > enabled and what aux DSC pass-through requests ought to be sent to. So,
> > > add a variable to struct drm_dp_mst_port that keeps track of the
> > > aforementioned information.
> > > 
> > > Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> > > ---
> > > v2: define DP_DSC_PASSTHROUGH_IS_SUPPORTED
> > > ---
> > >   drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 +++-
> > >   include/drm/display/drm_dp.h                  | 1 +
> > >   include/drm/display/drm_dp_mst_helper.h       | 3 +++
> > >   3 files changed, 7 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > > index 67b3b9697da7..71915afd9892 100644
> > > --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > > +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > > @@ -5921,8 +5921,10 @@ struct drm_dp_aux *drm_dp_mst_dsc_aux_for_port(struct drm_dp_mst_port *port)
> > >   		/* Enpoint decompression with DP-to-DP peer device */
> > >   		if ((endpoint_dsc & DP_DSC_DECOMPRESSION_IS_SUPPORTED) &&
> > >   		    (endpoint_fec & DP_FEC_CAPABLE) &&
> > > -		    (upstream_dsc & 0x2) /* DSC passthrough */)
> > > +		    (upstream_dsc & DP_DSC_PASSTHROUGH_IS_SUPPORTED)) {
> > > +			port->passthrough_aux = &immediate_upstream_port->aux;
> > >   			return &port->aux;
> > > +		}
> > >   
> > >   		/* Virtual DPCD decompression with DP-to-DP peer device */
> > >   		return &immediate_upstream_port->aux;
> > > diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
> > > index 9e3aff7e68bb..4d0abe4c7ea9 100644
> > > --- a/include/drm/display/drm_dp.h
> > > +++ b/include/drm/display/drm_dp.h
> > > @@ -239,6 +239,7 @@
> > >   
> > >   #define DP_DSC_SUPPORT                      0x060   /* DP 1.4 */
> > >   # define DP_DSC_DECOMPRESSION_IS_SUPPORTED  (1 << 0)
> > > +# define DP_DSC_PASSTHROUGH_IS_SUPPORTED    (1 << 1)
> > >   
> > >   #define DP_DSC_REV                          0x061
> > >   # define DP_DSC_MAJOR_MASK                  (0xf << 0)
> > > diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
> > > index 10adec068b7f..4a39c95f8afd 100644
> > > --- a/include/drm/display/drm_dp_mst_helper.h
> > > +++ b/include/drm/display/drm_dp_mst_helper.h
> > > @@ -86,6 +86,8 @@ struct drm_dp_vcpi {
> > >    * @next: link to next port on this branch device
> > >    * @aux: i2c aux transport to talk to device connected to this port, protected
> > >    * by &drm_dp_mst_topology_mgr.base.lock.
> > > + * @passthrough_aux: parent aux to which DSC pass-through requests should be
> > > + * sent, only set if DSC pass-through is possible.
> > >    * @parent: branch device parent of this port
> > >    * @vcpi: Virtual Channel Payload info for this port.
> > >    * @connector: DRM connector this port is connected to. Protected by
> > > @@ -140,6 +142,7 @@ struct drm_dp_mst_port {
> > >   	 */
> > >   	struct drm_dp_mst_branch *mstb;
> > >   	struct drm_dp_aux aux; /* i2c bus for this port? */
> > > +	struct drm_dp_aux *passthrough_aux;
> > >   	struct drm_dp_mst_branch *parent;
> > >   
> > >   	struct drm_dp_vcpi vcpi;
> > 
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

