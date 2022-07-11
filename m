Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A574570472
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiGKNiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiGKNiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:38:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C9B23DF09
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657546696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lHiL2oAl6jhF+7DkvWPJ3P9qRNjPPTKgP/FgDh3LiIw=;
        b=IlSSFshM630P0kVtm/pv4JdI/Iil50ybzCLRGt4HnyMKDYXieHj8Uq7YoEQKMFyjIw0DNq
        BnMCeNhXZ3JDB1bTQulzs7fwEwZ/PZS5dD66zIXRXQOwPh5d7GCkf1Dlqxqj7Z1KAA6ErY
        OHCaHyW4yE17xBLlPgkfF+0xFTlhHhk=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-DYQUylliPtGf5PPc4Hu2ng-1; Mon, 11 Jul 2022 09:38:15 -0400
X-MC-Unique: DYQUylliPtGf5PPc4Hu2ng-1
Received: by mail-il1-f199.google.com with SMTP id u9-20020a056e021a4900b002dc685a1c13so3226048ilv.19
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:organization
         :mime-version:content-transfer-encoding;
        bh=lHiL2oAl6jhF+7DkvWPJ3P9qRNjPPTKgP/FgDh3LiIw=;
        b=HpedhYg1vRg40J3scr45813dTYtrdemx1+H749ETnqxxLH2Y/4GRNYEgPcGHRGGYpe
         xbS4J59FmuNfiG0DqZZtIpL8WOxonzOSCkiigF3u/eJKOkeagYZthffLo3DuIpCpo2Kg
         e6FrRb6PkxDQ9GmVzrEH5dB46itOifmHCH/S14KptkE8kiQzRaDFaq1ItyfuirCe0w8B
         1nj18TYTomRaoIeIizQDgpM3ZdcrkFswmIdrjp+TfJAow/WhAGr+GCH62BbKp2IrrltO
         bycKsZKIW3b4ENhJodSfMGSGOwxLZTcu2yIkoDQDNOWkClnKkOYBWNleOUYBE2lvYOnI
         nNnQ==
X-Gm-Message-State: AJIora+bBnS4FKOYlm+KX0EH+NWOTDxu+kQCEzbAd0tashXE8k5r26U0
        SiI8ZqDOlrldvJs3ZIxBF8nVnDsi3n6/eUT7kzCSDa7pMNVguscCLHOhZUyi6zd/zXgRxX+egbJ
        cldA+jvdT6qwlf3kg0Htg9apt
X-Received: by 2002:a02:c8c9:0:b0:33f:3647:e751 with SMTP id q9-20020a02c8c9000000b0033f3647e751mr8361449jao.225.1657546695059;
        Mon, 11 Jul 2022 06:38:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sWOVGhWZEuFrc4S9IWJ1JTJ8QZona3S7/lpBX9gdQIWMIUeEeqj6Pygc3nCxq0BcHOUzmF1w==
X-Received: by 2002:a02:c8c9:0:b0:33f:3647:e751 with SMTP id q9-20020a02c8c9000000b0033f3647e751mr8361441jao.225.1657546694790;
        Mon, 11 Jul 2022 06:38:14 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id o15-20020a92dacf000000b002dc366ae7easm2714674ilq.74.2022.07.11.06.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 06:38:14 -0700 (PDT)
Date:   Mon, 11 Jul 2022 07:38:13 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [GIT PULL] VFIO fix for v5.19-rc7
Message-ID: <20220711073813.3134a64f.alex.williamson@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 88084a3df1672e131ddc1b4e39eeacfd39864acf:

  Linux 5.19-rc5 (2022-07-03 15:39:28 -0700)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v5.19-rc7

for you to fetch changes up to afe4e376ac5d568367b447ca90c12858d0935b86:

  vfio: Move IOMMU_CAP_CACHE_COHERENCY test to after we know we have a group (2022-07-05 16:06:50 -0600)

----------------------------------------------------------------
VFIO fix for v5.19-rc7

 - Move IOMMU test to unbreak no-iommu support (Jason Gunthorpe)

----------------------------------------------------------------
Jason Gunthorpe (1):
      vfio: Move IOMMU_CAP_CACHE_COHERENCY test to after we know we have a group

 drivers/vfio/vfio.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

