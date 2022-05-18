Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105EE52C1BF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241195AbiERRva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241165AbiERRv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A112A34B87
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652896282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJ+xSRnSFvEGswaWNolRShdcOC68wGWylvI087e+KjY=;
        b=JxWePoxMQQdLIZCAlzuX3XJA+V59E1GBtBurv0ojyygs69Lk+yUf7V7WoyWO1QAdrgsC90
        7iePVwwnhH/I+9unPf0miIpF92Lzdik446ZlvyaqsL9UicJf5tw/M3IYKhmpSpMhCPDKAN
        oG3OrQCBexCHY/W+YS4qaHGWL1G0uCY=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-NTzRWrkRNMq9icOsRnM6Ew-1; Wed, 18 May 2022 13:51:21 -0400
X-MC-Unique: NTzRWrkRNMq9icOsRnM6Ew-1
Received: by mail-io1-f71.google.com with SMTP id m205-20020a6b3fd6000000b006586ca958d2so655541ioa.22
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=uJ+xSRnSFvEGswaWNolRShdcOC68wGWylvI087e+KjY=;
        b=Ftzdu5Dkxbd6QnhaFfTzpbm1zEJaoa5ASFhsuyfkjSY2svCJRHUja1vLAzjr+cbkSg
         hUYc14SUYmtDtWhour8z8QajxL/C3FsvIGLzO0XeZDzhHJArSHCha+T6MaAfdLIuuxQG
         gaOyQpsQZQjsSQcG6CXMRGF6HYUSiKgK0SuMLVofEWBV40dnhP88INGqZC77S2n+2xST
         Lf3DCfR1dmgijR3VrFcBcjtP/20GuhCTi/QwuwozRSkYt2+7epVunUUMILdi5uxALhNY
         9AALqPghZBsXp92fhrzeLKSJJoAmvX3/DLgXNeSNXoitr6kJZSg4kntxH+qnHF64Vigg
         1seQ==
X-Gm-Message-State: AOAM531f5//8ugwsqPpW+ollsqEGQZtdFiO8EJxxs2Iegpap/0MWV8sp
        89C6bK9ZTnfiJVG1bID79eovBFAXYVeXWTZNT2CgsykrZFcrDCx2Etghh6aW5mZYVrSZaLp/BO3
        Dw7LXrrnoCl2sDjPnDP19JwYr
X-Received: by 2002:a05:6638:14d3:b0:32b:66f8:75a7 with SMTP id l19-20020a05663814d300b0032b66f875a7mr404981jak.114.1652896281092;
        Wed, 18 May 2022 10:51:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyb4BOk5OcdiFkqhrazR4KqwiZOKrgrLN0MLNaJZAn1o52qCQjbcEGjldKQvBXAMqZP6cTqlQ==
X-Received: by 2002:a05:6638:14d3:b0:32b:66f8:75a7 with SMTP id l19-20020a05663814d300b0032b66f875a7mr404968jak.114.1652896280897;
        Wed, 18 May 2022 10:51:20 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id o4-20020a02b804000000b0032e529ace22sm21448jam.174.2022.05.18.10.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 10:51:20 -0700 (PDT)
Date:   Wed, 18 May 2022 11:51:19 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/uapi/linux/vfio.h: Fix trivial typo - _IORW
 should be _IOWR instead
Message-ID: <20220518115119.2e618c39.alex.williamson@redhat.com>
In-Reply-To: <20220516101202.88373-1-thuth@redhat.com>
References: <20220516101202.88373-1-thuth@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 12:12:02 +0200
Thomas Huth <thuth@redhat.com> wrote:

> There is no macro called _IORW, so use _IOWR in the comment instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/uapi/linux/vfio.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index fea86061b44e..733a1cddde30 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -643,7 +643,7 @@ enum {
>  };
>  
>  /**
> - * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO - _IORW(VFIO_TYPE, VFIO_BASE + 12,
> + * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 12,
>   *					      struct vfio_pci_hot_reset_info)
>   *
>   * Return: 0 on success, -errno on failure:
> @@ -770,7 +770,7 @@ struct vfio_device_ioeventfd {
>  #define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 16)
>  
>  /**
> - * VFIO_DEVICE_FEATURE - _IORW(VFIO_TYPE, VFIO_BASE + 17,
> + * VFIO_DEVICE_FEATURE - _IOWR(VFIO_TYPE, VFIO_BASE + 17,
>   *			       struct vfio_device_feature)
>   *
>   * Get, set, or probe feature data of the device.  The feature is selected

Applied to vfio next branch for v5.19.  Thanks!

Alex

