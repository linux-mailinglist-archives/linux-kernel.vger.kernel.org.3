Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECFA53CC20
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245407AbiFCPPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245404AbiFCPO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:14:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1C21506C3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654269294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KSS+WlIjCzxfASZfHJ/pG+nFg5xuEcmHlF7DakY9wuE=;
        b=gHFBJplnId2Pu9seQbG6osjLAfccv+oXcIKOZcCq+/cdQm7bTRpTuo1yOnZko7XG/3UiYg
        U/HSoBgodrd8ZquWzwkHt9j5VL4L5lzgDoYMv8unUZbCERucDQ+3jvPbK7jaCGUXV9d/yy
        bGm/do55U3d9i2Jq0x/PuJnajgMDXLw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-DfWlx9j2MGyvOdrt085YMg-1; Fri, 03 Jun 2022 11:14:53 -0400
X-MC-Unique: DfWlx9j2MGyvOdrt085YMg-1
Received: by mail-qv1-f71.google.com with SMTP id x17-20020a0cfe11000000b004645917e45cso5458209qvr.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 08:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KSS+WlIjCzxfASZfHJ/pG+nFg5xuEcmHlF7DakY9wuE=;
        b=LMVwwYMPdgumKQUy88ktwllrNRu5/bGm2+GHMGnlCsYOdb0CrDm0n6TYE78NwPmyvF
         3Hw6QOm13gAfhDIMsMhxkvu0B1TUUOy6cQgOA+B1Jz/sb5u5IbV2Wxd+dlRsCmZZ6aaN
         /qJaqWjnzExmbSq8iplLpFummeNe72WMpOINCou5cF/8GXKJ+1SPLUVkRKrgWNWwDWAd
         w57H3/q8FnXlIu7r/Y0slP9iD323NqtEb/Bo+ksLDt6fJkgyXWpXUVoQ0Z7N0EG7khCF
         INX7yFj07yURheNMiklYzINPigiPC4GXJojctpNVXD04sTfDolsr1d5h6X2L2ikMzyy0
         HYoA==
X-Gm-Message-State: AOAM5316FcTpsybZ8ad8XNG0P+cjyjBWeTKGuPqDzTmsi5K6ZIk6zI57
        UG/ZtcNk6Aa9UDCkMNDx+mbRxTABoAqhnE2TyRG/37Z8DY3kGVvy3UMaZouJk7W3M/ornBtg1Mn
        4m3LbiXREGQPhAQ5+osHNFINn
X-Received: by 2002:a05:620a:1445:b0:6a3:9f13:7f10 with SMTP id i5-20020a05620a144500b006a39f137f10mr6753071qkl.736.1654269293268;
        Fri, 03 Jun 2022 08:14:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYV+OzB2BFz+1kTFY3RgS+1hrEcN6pQQortBLwObPtwEpeMeMFxrV3fG5J5vUdP1DDnfWMew==
X-Received: by 2002:a05:620a:1445:b0:6a3:9f13:7f10 with SMTP id i5-20020a05620a144500b006a39f137f10mr6753042qkl.736.1654269292985;
        Fri, 03 Jun 2022 08:14:52 -0700 (PDT)
Received: from xps13 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id m28-20020a05620a215c00b006a03cbb1323sm5009016qkm.65.2022.06.03.08.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 08:14:52 -0700 (PDT)
Date:   Fri, 3 Jun 2022 11:14:51 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] iommu/qcom: Index contexts by asid number to allow
 asid 0
Message-ID: <Ypola4mBuQ6zDLcz@xps13>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-6-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527212901.29268-6-konrad.dybcio@somainline.org>
User-Agent: Mutt/2.2.1 (2022-02-19)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 11:29:00PM +0200, Konrad Dybcio wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> This driver was indexing the contexts by asid-1, which is probably
> done under the assumption that the first ASID is always 1.
> 
> Unfortunately this is not entirely true: at least in the MSM8956
> and MSM8976 GPU IOMMU, the gpu_user context's ASID number is zero.
> To allow using an asid number of zero, stop indexing the contexts
> by asid-1 and rather index them by asid.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>

msm8974 will need this as well.

Reviewed-by: Brian Masney <bmasney@redhat.com>

