Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D11A553AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354060AbiFUThp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348473AbiFUThn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA1742D1FA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655840261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qu+hqkp0ZSoYmNwiO1knCkx+ca27suxkvWUEOC/mfPk=;
        b=C1iWYcPC9cw9LlzpE/3a0VAj2Jzb4QFBo9p+mbp6Is3I96svecLNwrhMRgwjgXgAYHXzOP
        8xNmw3nzAYTeqrcb+LSoCEnB8Twoi5fI9emKTnzYuDv0Z/OKfnqYCAMZvI/eG/y3bJj8Dw
        Pco7Vi6yuj+hld8Or7qJ+oaHGlFAlMk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-L2IiRJVbP5uiM9GT-r3qOA-1; Tue, 21 Jun 2022 15:37:40 -0400
X-MC-Unique: L2IiRJVbP5uiM9GT-r3qOA-1
Received: by mail-qk1-f199.google.com with SMTP id y8-20020a05620a44c800b006a6f8cd53cbso17529157qkp.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=qu+hqkp0ZSoYmNwiO1knCkx+ca27suxkvWUEOC/mfPk=;
        b=iRVrWgmpidHJoPGPggfW4T7+XsEOHspMgv2576GHxVDydQMh5H3mycetZqsn7in9LH
         K/2a0jixMJtCNV3vXHyVk9uBtNIFQPg490X9RTgaXWiPX/XI6qqxql54vaWYwr0JsfyE
         sR8NjJMeWfjUWGyPBtwgxwA1xuiVhbWEfXbDsqwjMhk6O9TlIdauK5uPS8+quRmngmM1
         jWXgR+yTlWJXddGlV1Tm3aSTOnxpCWdFOsFUI8OP1uSFIDD8Fn4Un/y1lwSz/EGzeko3
         BSf6d1tdFuEL1NcbWAoLnlO6jinQJrXmRY+MebozMk+nvcmkU6rZyGVRkbk+obJTknpW
         Q0Aw==
X-Gm-Message-State: AJIora8D1snmXaRigb3DXWw56R2PbDLJjzMuCab9ut7xXOf/uUHiXWsv
        ToNsP0uj7scaL1wzSXXFlP3RaFxf5331yQ4eS8IaymfHXabqOr5eAJ2GL+B0f6m65/ueXq1sRoV
        YQl4j6Gqn84TkznIVQO+trT4m
X-Received: by 2002:a05:620a:28d3:b0:6a7:4622:6da8 with SMTP id l19-20020a05620a28d300b006a746226da8mr21552942qkp.541.1655840260210;
        Tue, 21 Jun 2022 12:37:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tDZnCDXrNfnnhHJs9Wcc9ITw4Hnhpqjh0ps0HnfSLrIwbq7dpnHJ5fkHKap+vHwesdk2nAQw==
X-Received: by 2002:a05:620a:28d3:b0:6a7:4622:6da8 with SMTP id l19-20020a05620a28d300b006a746226da8mr21552932qkp.541.1655840259973;
        Tue, 21 Jun 2022 12:37:39 -0700 (PDT)
Received: from [192.168.8.138] ([141.154.49.182])
        by smtp.gmail.com with ESMTPSA id f9-20020a05620a408900b006a740bb8578sm15626152qko.83.2022.06.21.12.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 12:37:39 -0700 (PDT)
Message-ID: <758b642ece93bd025d24080bf1d33703ba6f6ee1.camel@redhat.com>
Subject: Re: [PATCH 3/3] drm/dp_mst: Get rid of old comment in
 drm_atomic_get_mst_topology_state docs
From:   Lyude Paul <lyude@redhat.com>
To:     "Lin, Wayne" <Wayne.Lin@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@intel.com>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
        Rajkumar Subbiah <rsubbia@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 21 Jun 2022 15:37:38 -0400
In-Reply-To: <CO6PR12MB5489D6138C8CC26344618172FCAB9@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20220602201757.30431-1-lyude@redhat.com>
         <20220602201757.30431-4-lyude@redhat.com>
         <CO6PR12MB5489D6138C8CC26344618172FCAB9@CO6PR12MB5489.namprd12.prod.outlook.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! Will push these two patches upstream

On Mon, 2022-06-13 at 09:59 +0000, Lin, Wayne wrote:
> [Public]
> 
> Hi Lyude,
> 
> Feel free to add
> Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
> 
> > -----Original Message-----
> > From: Lyude Paul <lyude@redhat.com>
> > Sent: Friday, June 3, 2022 4:18 AM
> > To: dri-devel@lists.freedesktop.org
> > Cc: David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>;
> > Thomas
> > Zimmermann <tzimmermann@suse.de>; Lin, Wayne
> > <Wayne.Lin@amd.com>; Jani Nikula <jani.nikula@intel.com>; Lakha,
> > Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Rajkumar Subbiah
> > <rsubbia@codeaurora.org>; open list <linux-kernel@vger.kernel.org>
> > Subject: [PATCH 3/3] drm/dp_mst: Get rid of old comment in
> > drm_atomic_get_mst_topology_state docs
> > 
> > We don't actually care about connection_mutex here anymore, so let's get
> > rid of the comment mentioning it in this function's kdocs.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/display/drm_dp_mst_topology.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > index d6e595b95f07..9f96132a5d74 100644
> > --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > @@ -5458,8 +5458,7 @@
> > EXPORT_SYMBOL(drm_dp_mst_topology_state_funcs);
> >   *
> >   * This function wraps drm_atomic_get_priv_obj_state() passing in the MST
> > atomic
> >   * state vtable so that the private object state returned is that of a
> > MST
> > - * topology object. Also, drm_atomic_get_private_obj_state() expects the
> > caller
> > - * to care of the locking, so warn if don't hold the connection_mutex.
> > + * topology object.
> >   *
> >   * RETURNS:
> >   *
> > --
> > 2.35.3
> 
> --
> Regards,
> Wayne Lin
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

