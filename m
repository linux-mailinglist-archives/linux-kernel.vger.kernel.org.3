Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD29351A591
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353477AbiEDQdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbiEDQdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:33:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5F0447044
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651681800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9NfP/UR6OPnC+oXgVhupwYcLyZYqW5PBXZPnFnfatuk=;
        b=ZnUgYYzcykOk6fBzwVCuAtOMKJ1g57xP8heHjIZvHtjJdvLVPV0RQHJN0P5LclpQ6NZSZF
        3CtqilZEHP8ReCQeqsi06WCs/GU3sc2VYCHPMpDWHSwyJ/0Z6uqFj0cqRhYcBjUI6V8wXg
        UmZ4bVNFiWpwHLrZwDT7Y1TVuE9Cw5c=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-S1grIYglPY61RFN8sGndDA-1; Wed, 04 May 2022 12:29:59 -0400
X-MC-Unique: S1grIYglPY61RFN8sGndDA-1
Received: by mail-il1-f198.google.com with SMTP id f18-20020a926a12000000b002be48b02bc6so941102ilc.17
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 09:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=9NfP/UR6OPnC+oXgVhupwYcLyZYqW5PBXZPnFnfatuk=;
        b=UP4zysnKMQrYmdgDzkAaq/k7ZaTZsx4qePlxG+XVyjBxKnIUimZG4LFogxJjXWt3j1
         8PEFMNRL+haI7tywgNexU3boxpEUk/NXRzYJPb+L3JXC6e3R89GBo0sN/MgshgGX7Amc
         FQDGcGUdKSL4vHxbywfYvPPxl4zUuKdmu+w3FaJ9xtJltZ8PjGFB925dEQbOIZLKg+4+
         jiCR6Tlqb2TPPicH/MoY2eTY5HJg//f3eejCbfjIYqdzzKgGQuzVAom77Nngqs+q5bCh
         O2U3oAvbBFalrB12z1oFEEdlSkiF7UFyclxWbg9XhGikkVYNi0a94/tNJ88mDS1RQ46z
         mQZw==
X-Gm-Message-State: AOAM530xZSeO4VAwrjuvHhSN8INH5OPG7/XyUNyV7zQd8yKs/S4CThPM
        BLOi2aBpvHEqleMaF+nIPFcbYK58dB+BVptwj/6r9rQYlpsDpR7BYanh3TciUVIMzeoARgDkON1
        q5FTxAWkk0/kzVfnoaMYytAIu
X-Received: by 2002:a05:6638:d0a:b0:328:73fb:b1d1 with SMTP id q10-20020a0566380d0a00b0032873fbb1d1mr9317800jaj.132.1651681798497;
        Wed, 04 May 2022 09:29:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR6bryE40k5D++tCeFIB0474lSTQMcR229H0fNBSGuVad/VwNuHzUMzmxnfKY82WXLYiKgzQ==
X-Received: by 2002:a05:6638:d0a:b0:328:73fb:b1d1 with SMTP id q10-20020a0566380d0a00b0032873fbb1d1mr9317776jaj.132.1651681797984;
        Wed, 04 May 2022 09:29:57 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id z9-20020a056638214900b0032b3a781793sm4812788jaj.87.2022.05.04.09.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 09:29:57 -0700 (PDT)
Date:   Wed, 4 May 2022 10:29:56 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RESEND PATCH v8 00/11] Fix BUG_ON in
 vfio_iommu_group_notifier()
Message-ID: <20220504102956.0f5b5302.alex.williamson@redhat.com>
In-Reply-To: <YnI8Xy54M3XQpS0T@8bytes.org>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
        <20220502161204.GA22@qian>
        <YnI8Xy54M3XQpS0T@8bytes.org>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 4 May 2022 10:42:07 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> On Mon, May 02, 2022 at 12:12:04PM -0400, Qian Cai wrote:
> > Reverting this series fixed an user-after-free while doing SR-IOV.
> > 
> >  BUG: KASAN: use-after-free in __lock_acquire  
> 
> Hrm, okay. I am going exclude this series from my next branch for now
> until this has been sorted out.
> 
> Alex, I suggest you do the same.

Done, and thanks for the heads-up.  Please try to cc me when the
vfio-notifier-fix branch is merged back into your next branch.  Thanks,

Alex

