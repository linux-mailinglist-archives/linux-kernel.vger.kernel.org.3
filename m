Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54ADC58D059
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 00:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244529AbiHHWx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 18:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbiHHWxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 18:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 307D61B790
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 15:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659999201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rPqclY0FSVViUDl2UYDey0E/+Y0xI7OX+B7XXIVceOQ=;
        b=cUK37MfCwGRL2QJrxzaModC/ZDSFAGfDYRFB4yNmVubP8A/FXXRCvZTtM6DSjw3UTXK+ox
        qjpiPbZAgK0wDxOkijClQj9fiT94n1Rpb4QXW+bF8yL3MmBEc5GDOB0QKp4OGl4rn/tehm
        xc7qVIV2KsYaNKccGByAxphOVGqren4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-yVTVuMzIPVKH4hrOb-JXTA-1; Mon, 08 Aug 2022 18:53:17 -0400
X-MC-Unique: yVTVuMzIPVKH4hrOb-JXTA-1
Received: by mail-qt1-f199.google.com with SMTP id k10-20020ac85fca000000b00342f51f0b13so4203018qta.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 15:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc;
        bh=rPqclY0FSVViUDl2UYDey0E/+Y0xI7OX+B7XXIVceOQ=;
        b=kxVO/oWmqVwdB4pMLbcHdVEfO1z82Bt3hDsZ8xqA4xEhiX5i4EQ7ErEFw5rOM1u733
         TFHnWBiSidQr/ruDlH9k7Jax0+0Fn+QaXw85X/XMTCrLxsHpY0rPN9n2+bULtvfvtrFO
         /9lpGeJbWLnrtgwRaZy0RYoRCgQoim3t48DeuhGgK5kksRvEF5YcwzRsGNBnX5O3xIDs
         pMXtNTQ4h0LCrdWXlEuv+U2odibTIs+f3h6I/J2aC+bob7ifQ7z4R/DMadR8oTaUdJF8
         URoNy9l9DXyfs3wYtdALNWSnNKUEBQ2rKuLLU36mJG2+3UOBCo2r8Brjgd687IuNx2pA
         PwuA==
X-Gm-Message-State: ACgBeo1IiK8nqT5vNSSujENeBFkXvjZTdPV2LXCpNWvOjaT/KxjSOJaB
        5dhWYLfCpk4jOQMQakYWUh9CjRB2iS8VG4hghPn5bR/heHcJ7kO23yiuJ2Yu5s11qQetOmJbYwz
        YbnMIhonYZ0j4uhVe+8/2eR15
X-Received: by 2002:a05:622a:19a7:b0:33e:ca27:6206 with SMTP id u39-20020a05622a19a700b0033eca276206mr18143210qtc.629.1659999197050;
        Mon, 08 Aug 2022 15:53:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6keWmjIk9Kdkkn+Z2BPeGcqVR5KnxuwQWKh/amSVfycmJNCYkwfkDof+GiBWGMkH9wNX9cLQ==
X-Received: by 2002:a05:622a:19a7:b0:33e:ca27:6206 with SMTP id u39-20020a05622a19a700b0033eca276206mr18143191qtc.629.1659999196813;
        Mon, 08 Aug 2022 15:53:16 -0700 (PDT)
Received: from [192.168.8.138] (pool-100-0-245-4.bstnma.fios.verizon.net. [100.0.245.4])
        by smtp.gmail.com with ESMTPSA id bj41-20020a05620a192900b006b91c0b6404sm7731982qkb.41.2022.08.08.15.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 15:53:16 -0700 (PDT)
Message-ID: <4ea5f21ea66446ad7924bc883af30b136fa0ca22.camel@redhat.com>
Subject: Re: [RESEND RFC 18/18] drm/display/dp_mst: Move all payload info
 into the atomic state
From:   Lyude Paul <lyude@redhat.com>
To:     "Lin, Wayne" <Wayne.Lin@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <sean@poorly.run>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
        "Li, Roman" <Roman.Li@amd.com>, "Shih, Jude" <Jude.Shih@amd.com>,
        Simon Ser <contact@emersion.fr>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Claudio Suarez <cssk@net-c.es>, "Chen, Ian" <Ian.Chen@amd.com>,
        Colin Ian King <colin.king@intel.com>,
        "Wu, Hersen" <hersenxs.wu@amd.com>,
        "Liu, Wenjing" <Wenjing.Liu@amd.com>, "Lei, Jun" <Jun.Lei@amd.com>,
        "Strauss, Michael" <Michael.Strauss@amd.com>,
        "Ma, Leo" <Hanghong.Ma@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?ISO-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, He Ying <heying24@huawei.com>,
        Anshuman Gupta <anshuman.gupta@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Juston Li <juston.li@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Fernando Ramos <greenfoo@u92.eu>,
        Luo Jiaxing <luojiaxing@huawei.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:INTEL DRM DRIVERS" <intel-gfx@lists.freedesktop.org>
Date:   Mon, 08 Aug 2022 18:53:13 -0400
In-Reply-To: <CO6PR12MB54896ECA603462858C9AFBA2FC639@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20220607192933.1333228-1-lyude@redhat.com>
         <20220607192933.1333228-19-lyude@redhat.com>
         <CO6PR12MB5489BAFF2DDCD67F8BDCD827FC819@CO6PR12MB5489.namprd12.prod.outlook.com>
         <848f35a693b26bfd15b3c6539eacd3e313dcd3a7.camel@redhat.com>
         <CO6PR12MB54896ECA603462858C9AFBA2FC639@CO6PR12MB5489.namprd12.prod.outlook.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-08-08 at 10:02 +0000, Lin, Wayne wrote:
> [Public]
> 
> 
> 
> > -----Original Message-----
> > From: Lyude Paul <lyude@redhat.com>
> > Sent: Thursday, August 4, 2022 4:28 AM
> > To: Lin, Wayne <Wayne.Lin@amd.com>; dri-devel@lists.freedesktop.org;
> > nouveau@lists.freedesktop.org; amd-gfx@lists.freedesktop.org
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>; Zuo, Jerry
> > <Jerry.Zuo@amd.com>; Jani Nikula <jani.nikula@intel.com>; Imre Deak
> > <imre.deak@intel.com>; Daniel Vetter <daniel.vetter@ffwll.ch>; Sean Paul
> > <sean@poorly.run>; Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun
> > peng (Leo) <Sunpeng.Li@amd.com>; Siqueira, Rodrigo
> > <Rodrigo.Siqueira@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David
> > Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Jani Nikula
> > <jani.nikula@linux.intel.com>; Joonas Lahtinen
> > <joonas.lahtinen@linux.intel.com>; Rodrigo Vivi <rodrigo.vivi@intel.com>;
> > Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>; Ben Skeggs
> > <bskeggs@redhat.com>; Karol Herbst <kherbst@redhat.com>; Kazlauskas,
> > Nicholas <Nicholas.Kazlauskas@amd.com>; Li, Roman
> > <Roman.Li@amd.com>; Shih, Jude <Jude.Shih@amd.com>; Simon Ser
> > <contact@emersion.fr>; Lakha, Bhawanpreet
> > <Bhawanpreet.Lakha@amd.com>; Mikita Lipski <mikita.lipski@amd.com>;
> > Claudio Suarez <cssk@net-c.es>; Chen, Ian <Ian.Chen@amd.com>; Colin Ian
> > King <colin.king@intel.com>; Wu, Hersen <hersenxs.wu@amd.com>; Liu,
> > Wenjing <Wenjing.Liu@amd.com>; Lei, Jun <Jun.Lei@amd.com>; Strauss,
> > Michael <Michael.Strauss@amd.com>; Ma, Leo <Hanghong.Ma@amd.com>;
> > Thomas Zimmermann <tzimmermann@suse.de>; José Roberto de Souza
> > <jose.souza@intel.com>; He Ying <heying24@huawei.com>; Anshuman
> > Gupta <anshuman.gupta@intel.com>; Andi Shyti
> > <andi.shyti@linux.intel.com>; Ashutosh Dixit <ashutosh.dixit@intel.com>;
> > Juston Li <juston.li@intel.com>; Sean Paul <seanpaul@chromium.org>;
> > Fernando Ramos <greenfoo@u92.eu>; Luo Jiaxing
> > <luojiaxing@huawei.com>; Javier Martinez Canillas <javierm@redhat.com>;
> > open list <linux-kernel@vger.kernel.org>; open list:INTEL DRM DRIVERS
> > <intel-gfx@lists.freedesktop.org>
> > Subject: Re: [RESEND RFC 18/18] drm/display/dp_mst: Move all payload info
> > into the atomic state
> > 
> > On Tue, 2022-07-05 at 09:10 +0000, Lin, Wayne wrote:
> > > > +struct drm_dp_mst_port;
> > > > +
> > > >   /* DP MST stream allocation (payload bandwidth number) */
> > > >   struct dc_dp_mst_stream_allocation {
> > > >    uint8_t vcp_id;
> > > >    /* number of slots required for the DP stream in
> > > >    * transport packet */
> > > >    uint8_t slot_count;
> > > > + /* The MST port this is on, this is used to associate DC MST
> > > > + payloads
> > > > with their
> > > > + * respective DRM payloads allocations, and can be ignored on non-
> > > > Linux.
> > > > + */
> > > 
> > > Is it necessary for adding this new member? Since this is for setting
> > > the DC HW and not relating to drm.
> > 
> > I don't entirely know, honestly. The reasons I did it:
> > 
> >  * Mapping things from DRM to DC and from DC to DRM is really confusing for
> >    outside contributors like myself, so it wasn't even really clear to me if
> >    there was another way to reconstruct the DRM context from the spots
> > where
> >    we call from DC up to DM (not a typo, see next point).
> >  * These DC structs for MST are already layer mixing as far as I can tell,
> >    just not in an immediately obvious way. While this struct itself is for DC,
> >    there's multiple spots where we pass the DC payload structs down from
> > DM to
> >    DC, then pass them back up from DC to DM and have to figure out how to
> >    reconstruct the DRM context that we actually need to use the MST helpers
> >    from that. So, that kind of further complicates the confusion of where
> >    layers should be separated.
> >  * As far as I'm aware with C there shouldn't be any issue with adding a
> >    pointer to a struct whose contents are undefined. IMHO, this is also
> >    preferable to just using void* because then at least you get some hint as
> >    to the actual type of the data and avoid the possibility of casting it to
> >    the wrong type. So tl;dr, on any platform even outside of Linux with a
> >    reasonably compliant compiler this should still build just fine. It'll even
> >    give you the added bonus of warning people if they try to access the
> >    contents of this member in DC on non-Linux platforms. If void* is preferred
> >    though I'm fine with switching it to that.
> > 
> > --
> > Cheers, Lyude Paul (she/her) Software Engineer at Red Hat
> 
> Hi Lyude,
> 
> Thanks for your time!
> I was thinking that our DC just mainly takes care of HW related programming. 
> Struct dc_dp_mst_stream_allocation is only used to construct a copy of the virtual 
> channel payload ID and slots count of payload allocation table determined by
> dm/drm. ID and slots are only things required for programming HW registers.
> I think there shouldn't be any spots to try to construct the DRM context from
> this dc struct since there is no such concept in HW level. Our HW should only 
> take care of local DP link and it doesn't have overall topology info.

Looking at the code I wrote again and realizing I slightly misspoke, looking
at the code again I think I probably can drop this. It's likely I just got
totally lost with the DC codebase and thought this was necessary when it
wasn't. Will drop in the respin

> 
> Thanks!
> 
> Regards,
> Wayne

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

