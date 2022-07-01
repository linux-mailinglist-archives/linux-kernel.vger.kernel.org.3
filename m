Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009665638C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 19:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiGARwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 13:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiGARwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC9523AA48
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 10:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656697956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=67MJyXaDqImTHwnOnH/GBMo2aZ3gIWFmeSkeeeT9284=;
        b=dE6AyjtiQ1L2nPRgOgMpJ7gZgGSEKtloGwYpabyLng7ZFVSMWfRKqOGTlNSbkPnOB2677w
        OfsbfzHjdJKCl4INLNYX1a0/yN+oTG/ewvQVL2YwY8P5T6xEUe26e94qqI2wBhzhzB/wiT
        3BwuqbQGdJsbB0KS/PoqPel0UOHY6G8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-cYzi1UYKMTyamxtDuGPDWw-1; Fri, 01 Jul 2022 13:52:35 -0400
X-MC-Unique: cYzi1UYKMTyamxtDuGPDWw-1
Received: by mail-pg1-f198.google.com with SMTP id a15-20020a65604f000000b00401a9baf7d5so1526904pgp.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 10:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=67MJyXaDqImTHwnOnH/GBMo2aZ3gIWFmeSkeeeT9284=;
        b=Fc6QED3HoCrw+tm4cEvpbrZmK9MZHNaZqhsAZsvJ2YiiN8ZiESXye+DxKhcoAT9Kxm
         PGLgxDXZYXDhNRN/hHhuoVOs8f4UImUj76JbJ+GuqDxsVeL2rLKuIM31fKVO4EpMr4Od
         Jt6SjNkMIViR39rMzEOmYtPKEaER6g/kFAj9NOOUPBRrBqCVk7dCIdpujJNwMPbsIlCl
         mILXmUehXv4h3C47xXpguYwaBq4t5NWzD0mgdfQzwW2KFeUkjXoFAw8XpSBAH8se4mmS
         d7DfWCsD16JYpL7Dw5dfZ35wduRtmsFgLZyJ9JS9AB96UYjPXSNE1CXCjiZBJZCnMkCO
         wlXg==
X-Gm-Message-State: AJIora+0HvvSwOu9wkLHLK2+4/GKNWVyRobaUMnvtEbUmoIDKpCdP9cK
        5lXQEsNTsZF0nJGILPcedWk2YpYsimTFgRCCGTL3BPHw8iiZfb892Q/TbLu2whxjeedvltjB2B0
        UjRTEoJGqxsYON/6AeMo+rIfx
X-Received: by 2002:a63:1809:0:b0:408:417a:6fa5 with SMTP id y9-20020a631809000000b00408417a6fa5mr13486189pgl.228.1656697954699;
        Fri, 01 Jul 2022 10:52:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tiyDKemehCIPbCYtSalbzT9O2Eo+2uaZrA4LQQS6N4cxzBFgMrJZFlFqYmEd/iyq0Cd64CEA==
X-Received: by 2002:a63:1809:0:b0:408:417a:6fa5 with SMTP id y9-20020a631809000000b00408417a6fa5mr13486167pgl.228.1656697954439;
        Fri, 01 Jul 2022 10:52:34 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id p5-20020a1709026b8500b00163fbb1eec5sm15712052plk.229.2022.07.01.10.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 10:52:33 -0700 (PDT)
Date:   Fri, 1 Jul 2022 10:52:32 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3] dmaengine: idxd: Only call idxd_enable_system_pasid()
 if succeeded in enabling SVA feature
Message-ID: <20220701175232.e27zznvohnkzvjdq@cantor>
References: <20220625221333.214589-1-jsnitsel@redhat.com>
 <20220626051648.14249-1-jsnitsel@redhat.com>
 <YrfwaC06wZfUTHjH@fyu1.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrfwaC06wZfUTHjH@fyu1.sc.intel.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 10:36:40PM -0700, Fenghua Yu wrote:
> On Sat, Jun 25, 2022 at 10:16:48PM -0700, Jerry Snitselaar wrote:
> > On a Sapphire Rapids system if boot without intel_iommu=on, the IDXD
> > driver will crash during probe in iommu_sva_bind_device().
> > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> 
> Acked-by: Fenghua Yu <fenghua.yu@intel.com>
> 
> Thanks.
> 
> -Fenghua

Hi Vinod,

Should this get pulled into your fixes branch?

Regards,
Jerry

