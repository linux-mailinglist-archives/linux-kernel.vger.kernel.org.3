Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4532258F3C8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 23:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiHJVYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 17:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiHJVY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 17:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B242865552
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660166662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CH+bsRVfRKAzxfRz0Y6zPUvP9PuA2dTgow9CTkbokJU=;
        b=RqtKHfICD1U/7rfRVju1Emb2GJrX5ouPFtWM/23GBEQvcUWlUMXq2jsWPqIlRZezGvKyvK
        xcO6mAyXklqDwgKejS5tOKpK1nGUzu6waHx6U0V3YNrZ0QQUsQ7KMUJLZyXqjBiJg5O9fU
        GC8dqYf1fUgYIjNCvfnO8j3+5BxtKxM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-v3FVPI2gMEWm_IR-wy0Fyg-1; Wed, 10 Aug 2022 17:24:21 -0400
X-MC-Unique: v3FVPI2gMEWm_IR-wy0Fyg-1
Received: by mail-qv1-f70.google.com with SMTP id dp8-20020a05621409c800b0047b6911be44so4426251qvb.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc;
        bh=CH+bsRVfRKAzxfRz0Y6zPUvP9PuA2dTgow9CTkbokJU=;
        b=f2mJk8BMUYAH4h7ck9t9XZFYJJwN4SezAPEpuX4SWWLtn22WB+O8w6/12Qavu+CEOj
         iuF0VV1AMVxINa0fzB0OVNd+5rHHF8okNF00RKpPivJwJmPKShTXlyThJW05EraXHvFO
         DhTp49dQrT5qXFxAGta7bGkf6mCeKuwvqOPC9bd5nmsWKTN4vaCojpxUK0tDV3y45Fzd
         x7+6s5e1ezWOmML81Ig0UWBwdK0EKBrxpHbxRvZcF20d1WIoByQc49ssoJaLT6re5z6V
         RupbmxpkxwcZ6lb9ucvGFJDizpaj8Zjh+0VpljVG9bXOC6ICjd79q1JjElHwgmuOwZ1y
         wTJw==
X-Gm-Message-State: ACgBeo3jXeff+oKmUCBAqK7Ci5SI7KpMRsSVKPU3XU9aXsKtU2O8wCx3
        JKFnYpnbB9AFGZvhIENuOhS59dKLfmjlxNBwpea2kJXHBubTzvz72/f3n30NBpqqFcpJx9LE5JX
        ekNWWDTPTdhzcidCHG6hOcPQc
X-Received: by 2002:ad4:5c8c:0:b0:477:d19:1a44 with SMTP id o12-20020ad45c8c000000b004770d191a44mr25810427qvh.15.1660166661009;
        Wed, 10 Aug 2022 14:24:21 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7XpKjHRWLRkaNX1FxNV371wKY9RaiC7cNv4LC+I+YThDc2iSlxEACY5NpVokJ14lxVzaofjw==
X-Received: by 2002:ad4:5c8c:0:b0:477:d19:1a44 with SMTP id o12-20020ad45c8c000000b004770d191a44mr25810417qvh.15.1660166660820;
        Wed, 10 Aug 2022 14:24:20 -0700 (PDT)
Received: from [192.168.8.138] (pool-100-0-245-4.bstnma.fios.verizon.net. [100.0.245.4])
        by smtp.gmail.com with ESMTPSA id bq19-20020a05620a469300b006b59ddb4bc5sm708593qkb.84.2022.08.10.14.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 14:24:20 -0700 (PDT)
Message-ID: <df2b8017427dc2ebab9bcf70e406d0732ef59299.camel@redhat.com>
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
Date:   Wed, 10 Aug 2022 17:24:18 -0400
In-Reply-To: <a8de299f-0868-eef7-7bef-de8207900370@amd.com>
References: <20220805211317.176672-1-hamza.mahfooz@amd.com>
         <8db8a726d1aac25b3590497db9cbdcc3fe161227.camel@redhat.com>
         <b6e10f4a-6834-fccb-0cba-0990dda37a76@amd.com>
         <3690a632acc9d5d83ae8a33dfc8b88db7fe8aebf.camel@redhat.com>
         <a8de299f-0868-eef7-7bef-de8207900370@amd.com>
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

On Wed, 2022-08-10 at 09:23 -0400, Hamza Mahfooz wrote:
> On 2022-08-09 18:01, Lyude Paul wrote:
> > Ah yes of course! Probably should have asked when I gave the r-b :). Also,
> > just so patchwork actually catches it I will say the magic incantation:
> > 
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > 
> > Do we want to merge just this patch to drm-misc-next, or do you want to merge
> > the whole series through there? If you'd rather just merge this through amd's
> > branch I'm fine with that as well
> 
> In that case, it is preferable to have all of the patches in this series
> to get merged through amd's branch.\

Sounds totally fine to me! Just make sure to run it by Harry or another amdgpu
maintainer first, and then you should be good to go.

> 
> > 
> > On Tue, 2022-08-09 at 11:15 -0400, Hamza Mahfooz wrote:
> > > Hey Lyude,
> > > 
> > > On 2022-08-05 17:17, Lyude Paul wrote:
> > > > lgtm!
> > > > 
> > > 
> > > Any chance you can apply this to drm-misc-next?
> > > 
> > > > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > > > 
> > > > On Fri, 2022-08-05 at 17:13 -0400, Hamza Mahfooz wrote:
> > > > > Currently, there is no way to identify if DSC pass-through can be
> > > > > enabled and what aux DSC pass-through requests ought to be sent to. So,
> > > > > add a variable to struct drm_dp_mst_port that keeps track of the
> > > > > aforementioned information.
> > > > > 
> > > > > Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> > > > > ---
> > > > > v2: define DP_DSC_PASSTHROUGH_IS_SUPPORTED
> > > > > ---
> > > > >    drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 +++-
> > > > >    include/drm/display/drm_dp.h                  | 1 +
> > > > >    include/drm/display/drm_dp_mst_helper.h       | 3 +++
> > > > >    3 files changed, 7 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > > > > index 67b3b9697da7..71915afd9892 100644
> > > > > --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > > > > +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > > > > @@ -5921,8 +5921,10 @@ struct drm_dp_aux *drm_dp_mst_dsc_aux_for_port(struct drm_dp_mst_port *port)
> > > > >    		/* Enpoint decompression with DP-to-DP peer device */
> > > > >    		if ((endpoint_dsc & DP_DSC_DECOMPRESSION_IS_SUPPORTED) &&
> > > > >    		    (endpoint_fec & DP_FEC_CAPABLE) &&
> > > > > -		    (upstream_dsc & 0x2) /* DSC passthrough */)
> > > > > +		    (upstream_dsc & DP_DSC_PASSTHROUGH_IS_SUPPORTED)) {
> > > > > +			port->passthrough_aux = &immediate_upstream_port->aux;
> > > > >    			return &port->aux;
> > > > > +		}
> > > > >    
> > > > >    		/* Virtual DPCD decompression with DP-to-DP peer device */
> > > > >    		return &immediate_upstream_port->aux;
> > > > > diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
> > > > > index 9e3aff7e68bb..4d0abe4c7ea9 100644
> > > > > --- a/include/drm/display/drm_dp.h
> > > > > +++ b/include/drm/display/drm_dp.h
> > > > > @@ -239,6 +239,7 @@
> > > > >    
> > > > >    #define DP_DSC_SUPPORT                      0x060   /* DP 1.4 */
> > > > >    # define DP_DSC_DECOMPRESSION_IS_SUPPORTED  (1 << 0)
> > > > > +# define DP_DSC_PASSTHROUGH_IS_SUPPORTED    (1 << 1)
> > > > >    
> > > > >    #define DP_DSC_REV                          0x061
> > > > >    # define DP_DSC_MAJOR_MASK                  (0xf << 0)
> > > > > diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
> > > > > index 10adec068b7f..4a39c95f8afd 100644
> > > > > --- a/include/drm/display/drm_dp_mst_helper.h
> > > > > +++ b/include/drm/display/drm_dp_mst_helper.h
> > > > > @@ -86,6 +86,8 @@ struct drm_dp_vcpi {
> > > > >     * @next: link to next port on this branch device
> > > > >     * @aux: i2c aux transport to talk to device connected to this port, protected
> > > > >     * by &drm_dp_mst_topology_mgr.base.lock.
> > > > > + * @passthrough_aux: parent aux to which DSC pass-through requests should be
> > > > > + * sent, only set if DSC pass-through is possible.
> > > > >     * @parent: branch device parent of this port
> > > > >     * @vcpi: Virtual Channel Payload info for this port.
> > > > >     * @connector: DRM connector this port is connected to. Protected by
> > > > > @@ -140,6 +142,7 @@ struct drm_dp_mst_port {
> > > > >    	 */
> > > > >    	struct drm_dp_mst_branch *mstb;
> > > > >    	struct drm_dp_aux aux; /* i2c bus for this port? */
> > > > > +	struct drm_dp_aux *passthrough_aux;
> > > > >    	struct drm_dp_mst_branch *parent;
> > > > >    
> > > > >    	struct drm_dp_vcpi vcpi;
> > > > 
> > > 
> > 
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

