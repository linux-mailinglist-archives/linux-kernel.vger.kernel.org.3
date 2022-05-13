Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492735266FD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382423AbiEMQ0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381875AbiEMQZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84E5A91567
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652459153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ub5KAZihY6DYhd8Dh60sSEVIjle32E0Y+oXuLhLfRmI=;
        b=aa/HZx4Qz92Wxe7fRBxcFWOQyV8mOEBbp2C5hmJ6znxPelc20P9pLCOz24wKrZdlojwwSY
        TKd+VP8DcRCzIFWlCzFArVrZwPAG3e9fp+k4Nq5O9UBEjhiwmaayaAIV2KaH/hBKQrz/9y
        3xr7/n4gfdpcsnJNjNDNwrIiXgOSeFk=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-AdNy7p9WM_u57h6jZxUtZQ-1; Fri, 13 May 2022 12:25:52 -0400
X-MC-Unique: AdNy7p9WM_u57h6jZxUtZQ-1
Received: by mail-io1-f70.google.com with SMTP id r137-20020a6b2b8f000000b0065dbbc04e94so4263320ior.16
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Ub5KAZihY6DYhd8Dh60sSEVIjle32E0Y+oXuLhLfRmI=;
        b=BMyQw+SpSZ5Ec12IZ5uGo420lssQZBR/O07zO1nD9Ubo6V9QzJhqDH7afqTmiCrmTJ
         lq6AovAVrLhn7V0yjeOCNKok79UXm3ZEKgcRPSmfe3pwR6kKpNEpc8R6kMGk0TFilicY
         mQ3SIHrUn6ljMnayoyOLHkH+gU9fM19KQFNfDuRi9CiKAFP+AV2Gh9qLC6CVikIET1Qd
         40WT16O+E1R6TnBOfoXwQLyWd8HGUizJkGMrIs47ZbCWt3CFYipXy0EK1WMcjWCz3I1I
         nuFAbIbzCiv2Ru8F1GHhCk3jPT3HPjxjqgD2p1hf0I+asmNWK9J3Q2BDyt/VSeNFyDV9
         it2A==
X-Gm-Message-State: AOAM533FqAKAAKpsnVy+9nuzNmxr2y4kM6KCuDM1ssawxqbktOAcZN7y
        BXrQVglUgud1h1nnEKLRkJE9CATfkbdZo4biHnnsXWGUDTDCSNDOf45SLRHhFVcV7sMiGUYFVgb
        097CrfCp2t4/3Rbhqslmg6a0a
X-Received: by 2002:a05:6e02:1a86:b0:2cf:5846:29b3 with SMTP id k6-20020a056e021a8600b002cf584629b3mr3006526ilv.232.1652459151802;
        Fri, 13 May 2022 09:25:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9MjoZwEcYaDWk2gqQCT9hWL1nI3AiMXUTtNXeCu+v5XL13uXOxow6nSkLqXj4afENxZZ8NA==
X-Received: by 2002:a05:6e02:1a86:b0:2cf:5846:29b3 with SMTP id k6-20020a056e021a8600b002cf584629b3mr3006516ilv.232.1652459151519;
        Fri, 13 May 2022 09:25:51 -0700 (PDT)
Received: from redhat.com ([98.55.18.59])
        by smtp.gmail.com with ESMTPSA id j17-20020a023211000000b0032b3a7817b3sm772601jaa.119.2022.05.13.09.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 09:25:51 -0700 (PDT)
Date:   Fri, 13 May 2022 10:25:48 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [RESEND PATCH v8 00/11] Fix BUG_ON in
 vfio_iommu_group_notifier()
Message-ID: <20220513102548.5cf2a3aa.alex.williamson@redhat.com>
In-Reply-To: <Yn5+GKHlQlX5bszi@8bytes.org>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
        <20220502161204.GA22@qian>
        <YnI8Xy54M3XQpS0T@8bytes.org>
        <20220504102956.0f5b5302.alex.williamson@redhat.com>
        <Yn5+GKHlQlX5bszi@8bytes.org>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2022 17:49:44 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> Hi Alex,
> 
> On Wed, May 04, 2022 at 10:29:56AM -0600, Alex Williamson wrote:
> > Done, and thanks for the heads-up.  Please try to cc me when the
> > vfio-notifier-fix branch is merged back into your next branch.  Thanks,  
> 
> This has happened now, the vfio-notifier-fix branch got the fix and is
> merged back into my next branch.

Thanks, Joerg!

Jason, I'll push a merge of this with

Subject: [PATCH] vfio: Delete container_q
0-v1-a1e8791d795b+6b-vfio_container_q_jgg@nvidia.com

and

Subject: [PATCH v3 0/8] Remove vfio_group from the struct file facing VFIO API
0-v3-f7729924a7ea+25e33-vfio_kvm_no_group_jgg@nvidia.com

as soon as my sanity build finishes.  Thanks,

Alex

