Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A8558932D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbiHCU2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238664AbiHCU16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:27:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DEA35A3FD
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 13:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659558476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVq6qfh71Z4eyfH2Jr7IUkThH+5zHyp5mI30K20IkZo=;
        b=RCWuYes8YlKC3Edz4Y9HXW/tUad8qH59UFhrTvnNoAiJyZ35WEmr8z59XXedH63AMwO24t
        yUvFClOrNlRoievoQ2VOz9GGN0+33b1i/tH/qs6o687lQkCqaneNjRtwhWaKjAoJU5lgoc
        HBY3Xx6wqhXhtL5GmDXwO+l8JmmxY5Y=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-ZBGfC-xvPquZaeSGukkZqg-1; Wed, 03 Aug 2022 16:27:55 -0400
X-MC-Unique: ZBGfC-xvPquZaeSGukkZqg-1
Received: by mail-qk1-f199.google.com with SMTP id l15-20020a05620a28cf00b006b46997c070so14489717qkp.20
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 13:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=oVq6qfh71Z4eyfH2Jr7IUkThH+5zHyp5mI30K20IkZo=;
        b=Zrh6mvRa42nDn22dR+bNY2tRWmTqJylM51yoeK2seHyTwcLdu4zD0RBtRASCOxcbNl
         ioyfe+i0rB810kSiqDSsIrYuApvInacveXS4gZPhRcWKX9fuBddb9tfG3LINr0ECoJkS
         ABoi5waKEVv1gxS+gx1Y/Y0pHCr1A0LbYTcgd0yvWQR+Yt4I6KdqMkPf2AKDshIXrVIf
         3mbzWwtBRfMdh26b2XjXnvOA+ylmdkalx3xnm2pzz51uatEFTEumk52LlT2ZBB4zL3WC
         f5acdDbty2XXJZyVU44ny69au9qIZHD4iOaXhzDVf1jHY+F9BwvrvIxiHrvJUSqj+U4t
         FSog==
X-Gm-Message-State: AJIora8pYIb3Na36ggzGoGfTAgvdHQ7Y6/1I007/vTJ7EYUu3GwO70qi
        7afYeB7heknx9XoMBbyiGQBfRmQ/SbEq7kR71XwRN9Vc8ihesylVpd/Tq1jXJyWt0yikI8yu8da
        osAz4bL007WXrOZHMw0I/0XRK
X-Received: by 2002:a05:620a:1a20:b0:6b5:fb66:c0ed with SMTP id bk32-20020a05620a1a2000b006b5fb66c0edmr20320471qkb.582.1659558475275;
        Wed, 03 Aug 2022 13:27:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sYkLbaReZU3W97WVBuS4zUUlBeI7W8a0WinyCLm13NPrWmXKMpW3LlStpLdb0upC3LPX+pRA==
X-Received: by 2002:a05:620a:1a20:b0:6b5:fb66:c0ed with SMTP id bk32-20020a05620a1a2000b006b5fb66c0edmr20320447qkb.582.1659558474989;
        Wed, 03 Aug 2022 13:27:54 -0700 (PDT)
Received: from [192.168.8.138] (pool-100-0-245-4.bstnma.fios.verizon.net. [100.0.245.4])
        by smtp.gmail.com with ESMTPSA id r4-20020ae9d604000000b006b614fe291bsm12931459qkk.28.2022.08.03.13.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 13:27:54 -0700 (PDT)
Message-ID: <848f35a693b26bfd15b3c6539eacd3e313dcd3a7.camel@redhat.com>
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
Date:   Wed, 03 Aug 2022 16:27:51 -0400
In-Reply-To: <CO6PR12MB5489BAFF2DDCD67F8BDCD827FC819@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20220607192933.1333228-1-lyude@redhat.com>
         <20220607192933.1333228-19-lyude@redhat.com>
         <CO6PR12MB5489BAFF2DDCD67F8BDCD827FC819@CO6PR12MB5489.namprd12.prod.outlook.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-07-05 at 09:10 +0000, Lin, Wayne wrote:
> > +struct drm_dp_mst_port;
> > +
> >   /* DP MST stream allocation (payload bandwidth number) */
> >   struct dc_dp_mst_stream_allocation {
> >    uint8_t vcp_id;
> >    /* number of slots required for the DP stream in
> >    * transport packet */
> >    uint8_t slot_count;
> > + /* The MST port this is on, this is used to associate DC MST payloads
> > with their
> > + * respective DRM payloads allocations, and can be ignored on non-
> > Linux.
> > + */
> 
> Is it necessary for adding this new member? Since this is for setting the DC
> HW and not relating to drm.

I don't entirely know, honestly. The reasons I did it:

 * Mapping things from DRM to DC and from DC to DRM is really confusing for
   outside contributors like myself, so it wasn't even really clear to me if
   there was another way to reconstruct the DRM context from the spots where
   we call from DC up to DM (not a typo, see next point).
 * These DC structs for MST are already layer mixing as far as I can tell,
   just not in an immediately obvious way. While this struct itself is for DC,
   there's multiple spots where we pass the DC payload structs down from DM to
   DC, then pass them back up from DC to DM and have to figure out how to
   reconstruct the DRM context that we actually need to use the MST helpers
   from that. So, that kind of further complicates the confusion of where
   layers should be separated.
 * As far as I'm aware with C there shouldn't be any issue with adding a
   pointer to a struct whose contents are undefined. IMHO, this is also
   preferable to just using void* because then at least you get some hint as
   to the actual type of the data and avoid the possibility of casting it to
   the wrong type. So tl;dr, on any platform even outside of Linux with a
   reasonably compliant compiler this should still build just fine. It'll even
   give you the added bonus of warning people if they try to access the
   contents of this member in DC on non-Linux platforms. If void* is preferred
   though I'm fine with switching it to that.

-- 
Cheers, Lyude Paul (she/her) Software Engineer at Red Hat

