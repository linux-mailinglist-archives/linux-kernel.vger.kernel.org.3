Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7F04DA1B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350802AbiCOR6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbiCOR6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8510058E76
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647367058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fMedA9WfDLM5Ii8pfrj6jSSL52RCVYUyNjTGE84uBgM=;
        b=fD0wGxnzALVJENVAk+tvxD+OaD/Fv25/TdIN/LpwHGUTV816dxcBXUqblnF59KrhB9qUqK
        WcwLF6SbA2PxNOX8a0zNBFke5yFTGYjic+e4/dHpejaAOzNY34z/TK0zv41lun00rAJjr4
        U6PsOzkh8ZD+4WoK0K7Z5TPpao5CPn8=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-ajtI6GhIPs2tWNC9cpEA8g-1; Tue, 15 Mar 2022 13:57:37 -0400
X-MC-Unique: ajtI6GhIPs2tWNC9cpEA8g-1
Received: by mail-ot1-f72.google.com with SMTP id v7-20020a05683018c700b005af147b47beso14449492ote.22
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=fMedA9WfDLM5Ii8pfrj6jSSL52RCVYUyNjTGE84uBgM=;
        b=ye6XJDyLYXgb+5guw5Cr2RQ3vmnApD9Rqcsiyawk0ToW+3nt5TWOpW0bKKCfjL0E/R
         PFY23hc+1X9Qg4i5bhiKBYFGJCuuz7rO8/xSGH3d6vFwuIMifDVhLTnNrTmC6YrLeD5P
         F29w8VT3GBu1tt91CFT4+p8651YgbLrPFNV/Mo3YOXdkXP/CmU7q12kTb9ByHb6m3k9G
         0gxPKe6mga5C6mnrfpDLL9LjUeCI2iv/MZSqBbteGZEwRwblRXS0QcJAPeNW/Ur0gmS5
         RA26YK1LkfpgX8b+B2Y+kzUEVPtFpt9NEsC0ugIwWh65EhJ++K7JTzaqsWLDOANxAkp3
         meGg==
X-Gm-Message-State: AOAM530XFg9E/tztlP0kHHxcv/DCW4hzhSdVzhZzTvDeggBMv7Wqz16t
        I3GYH236gYHuxzuir1zsA7rrEkfpmLmZA4ALqk9Qobp+Kk9oj+JfhV/KI1NCZOU/Q/R2Ut7pAHF
        AGHugx6Kh/tih/NCxiW5GPz83
X-Received: by 2002:a05:6870:f21a:b0:dd:9bec:caf8 with SMTP id t26-20020a056870f21a00b000dd9beccaf8mr873945oao.78.1647367056640;
        Tue, 15 Mar 2022 10:57:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE0G+Iyi868FpnRpeqpjvFcGN9EznuWhCxB2z8lLfYG22OepTHiVkPgi+Sek7WhuBRDRt2Cw==
X-Received: by 2002:a05:6870:f21a:b0:dd:9bec:caf8 with SMTP id t26-20020a056870f21a00b000dd9beccaf8mr873941oao.78.1647367056433;
        Tue, 15 Mar 2022 10:57:36 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id q39-20020a4a88ea000000b0032165eb3af8sm7321527ooh.42.2022.03.15.10.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 10:57:36 -0700 (PDT)
Date:   Tue, 15 Mar 2022 11:57:34 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
        yishaih@nvidia.com, linux-doc@vger.kernel.org, corbet@lwn.net,
        hch@infradead.org
Subject: Re: [PATCH v4] vfio-pci: Provide reviewers and acceptance criteria
 for variant drivers
Message-ID: <20220315115734.71facb10.alex.williamson@redhat.com>
In-Reply-To: <20220315175039.GL11336@nvidia.com>
References: <164736509088.181560.2887686123582116702.stgit@omen>
        <20220315175039.GL11336@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 14:50:39 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Mar 15, 2022 at 11:29:57AM -0600, Alex Williamson wrote:
> > Device specific extensions for devices exposed to userspace through
> > the vfio-pci-core library open both new functionality and new risks.
> > Here we attempt to provided formalized requirements and expectations
> > to ensure that future drivers both collaborate in their interaction
> > with existing host drivers, as well as receive additional reviews
> > from community members with experience in this area.
> > 
> > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > Acked-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> > Acked-by: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > 
> > v4:
> > 
> > Banish the word "vendor", replace with "device specific"
> > Minor wording changes in docs file
> > Add sign-offs from Kevin and Yishai
> > 
> > I'll drop Jason from reviewers if there's no positive approval
> > after this round.  
> 
> Sorry, you are looking for this?
> 
> Acked-by: Jason Gunthorpe <jgg@nvidia.com>

Yup, thanks for volunteering!

