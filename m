Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B0957F06F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 18:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbiGWQdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 12:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiGWQd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 12:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F8E619C3B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 09:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658594007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7RhhPlmh/dGI5CL58sn53hCX8DKgVY5/Lyve4O4jeUU=;
        b=NEZTrPagShtynqeXxOuMFzUB18lW4GmDbLfwvg346f23r1eN9SZupLmi9j1IIoW9AnG4tB
        T+vGCvDEXjn21wdh8BXgBpt9w3owbwK44hFolQrD/ziTIdaqfei52U/+JV+0jq9rI2NlDx
        f50EL1OOSJCAx8Xb44lMtdd4zjPD21w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-FX2C7h_DPt-YST-0d43wtg-1; Sat, 23 Jul 2022 12:33:25 -0400
X-MC-Unique: FX2C7h_DPt-YST-0d43wtg-1
Received: by mail-qv1-f71.google.com with SMTP id p6-20020a0c8c86000000b004731e63c75bso5006471qvb.10
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 09:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7RhhPlmh/dGI5CL58sn53hCX8DKgVY5/Lyve4O4jeUU=;
        b=vu+XNBxwsieJ3IAm/BC+dMTMmbFqAz7wfc6oivf67gai00C8Koro2+OCxbOVhjDfCg
         Q/kRiXp8I6lepxeaq5lxcQ0y+2rPRzI3yUNzJDVJkT6EXqeEulawJ4eb24jipICWrHEF
         IzNeFWUplE3h4emu8yx3lmMM9QRcX6Kpb0CwkQU+V2hVuhxPOESiU7FTCUynb3xyt7VE
         bVjESZYiVpKzncBHiUDUOFOPXanMu+gqy1d0ZXDEMCBMuz854xVP/h2mAgeY53VJWpST
         MtD88seHzsMe+Nzw7AwAANrzPP2ug+Uo0aTaLe806+wJdQgrHRsSIUqDUx4yzwjYXdOe
         tpHw==
X-Gm-Message-State: AJIora8CX87bGYfKVc8unCK2vzJldzFxvsKulf4BHmqEm/MgkN0DCMHz
        AWKL5dCEIvcrGzvlanua+PS9AuRaY/0RWbrTpOIXwwrfa/wkvWyLxHRZIggBrWnEeT/bA+gLd70
        6KkxxB/wBB0arwyULwGi9Tt5C
X-Received: by 2002:a05:620a:254e:b0:6b6:bc2:e083 with SMTP id s14-20020a05620a254e00b006b60bc2e083mr3766711qko.317.1658594005331;
        Sat, 23 Jul 2022 09:33:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uF6O4GIcegNS7OhgngfC4nGoV/PV/fGplM98i5ZGB1zyX12JZNAI9d5d9GqBYsmqUFuvIjVw==
X-Received: by 2002:a05:620a:254e:b0:6b6:bc2:e083 with SMTP id s14-20020a05620a254e00b006b60bc2e083mr3766698qko.317.1658594005124;
        Sat, 23 Jul 2022 09:33:25 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id o63-20020a374142000000b006b5e3bf0eb8sm5461107qka.19.2022.07.23.09.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 09:33:24 -0700 (PDT)
Date:   Sat, 23 Jul 2022 09:33:23 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Disable guest vapic logging during early
 kdump init
Message-ID: <20220723163323.7cam7o252qdi66ic@cantor>
References: <20220721003439.403435-1-jsnitsel@redhat.com>
 <Ytq2GRX7UJjvXk4w@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytq2GRX7UJjvXk4w@8bytes.org>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 04:37:13PM +0200, Joerg Roedel wrote:
> On Wed, Jul 20, 2022 at 05:34:39PM -0700, Jerry Snitselaar wrote:
> > diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> > index 1d08f87e734b..2b00d7f28df7 100644
> > --- a/drivers/iommu/amd/init.c
> > +++ b/drivers/iommu/amd/init.c
> > @@ -815,6 +815,11 @@ static void free_ga_log(struct amd_iommu *iommu)
> >  #endif
> >  }
> >  
> > +static void iommu_ga_log_disable(struct amd_iommu *iommu)
> > +{
> > +	iommu_feature_disable(iommu, CONTROL_GALOG_EN);
> > +}
> > +
> >  static int iommu_ga_log_enable(struct amd_iommu *iommu)
> >  {
> >  #ifdef CONFIG_IRQ_REMAP
> > @@ -2504,6 +2509,7 @@ static void early_enable_iommus(void)
> >  		for_each_iommu(iommu) {
> >  			iommu_disable_command_buffer(iommu);
> >  			iommu_disable_event_buffer(iommu);
> > +			iommu_ga_log_disable(iommu);
> >  			iommu_enable_command_buffer(iommu);
> >  			iommu_enable_event_buffer(iommu);
> >  			iommu_enable_ga(iommu);
> 
> Looks about right, but I also let Suravee comment on this.
> 
> Disabling the GA-Log under a device still using it should hopefully not
> put it into some undefined state.

Hi Joerg,

Yes, I sent email to Suravee a few days ago as well to see what he thought,
but haven't heard back yet. It might be a couple days as I think he is
overseas at the moment.

Minor, stupid thing, but I wasn't sure whether it would be better to
name it iommu_disable_ga_log() like everything else called here, or
name it in the format of the other functions relating to logs. I opted
for the latter.

Did you see my other email about kdump kernels on vt-d with scalable
mode and passthrough enabled?

https://lore.kernel.org/linux-iommu/20220702154956.x2dxqalzjuzjraxk@cantor/

I've been looking at it, but haven't figured out what to do about tracking
the copying if can't borrow a bit in one of the pasid fields now. Any thoughts
on that?

Regards,
Jerry

