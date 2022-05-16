Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C865281AB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiEPKSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242353AbiEPKSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:18:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83254DEB5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652696319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OACVO52ZlkJLVKrD7n6wC0HSWrpeefnl2+wSjxpBQF0=;
        b=RePW0bzPnv32eDsJ78i9V5brt7bnPmM18+/F6qSmd9DQgQeLvBJfkH/dh43H5U2WJSkF0e
        x0/TpQYqLNzwiqR1PpOwh/Md+Z3JHxmtLnLKuVE3E2rGqJdF8XsaKWFGS/9lBQXbzlIfWb
        RwEaMMsK55L6BOGiXnTPQEypD7CKF00=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-IfcFC3PKMviy1WEdJhcf7A-1; Mon, 16 May 2022 06:18:38 -0400
X-MC-Unique: IfcFC3PKMviy1WEdJhcf7A-1
Received: by mail-wm1-f70.google.com with SMTP id t184-20020a1c46c1000000b00394209f54f1so6540833wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OACVO52ZlkJLVKrD7n6wC0HSWrpeefnl2+wSjxpBQF0=;
        b=SmMcSfAoui5Lbn27OeMfJrqSoYux4mmkz956bkwOZQP094ka/5YhCSMrS6CMQw/c4h
         j4RUDSnUixlPRtSSU9gU0D1g+UhTdvmUNq9sQPuyuBYrFVm+3R9OMPRLcdImV0Bns9Bi
         Vc6PEhmSa6uwVLetpG3+ta8Nr56T2VuTk8RUfnLYR33P0xeYMvLEMFr/cwTsodYX+MFf
         m0gc9gCv/mQb8zmycBSl5k/5P4Me8vJoqtJMZS8OYAKEyIk3VGkSQ7kXec4Ns84PCIcW
         TVyM79bAUsnxkADMk0i8b9DanO/IOdIu0F7q7OqzafjqXFjqdnx+CkW2po/3Z1WKd+t4
         6k8Q==
X-Gm-Message-State: AOAM531/vEh2kZne5cO4BeGPtJX6+ZuY4MXMili/phoHSTxP1PNWSgyg
        VQKvkSVxv2s+7r3DYnLp0dV+erYHyIHLHVu7IEn/4+n8l7s7lDqDfFyjnQEzFQWnH1B7PWfJ/un
        z5UXynBYyAzLbMwHZD0uFD9+o
X-Received: by 2002:a7b:c5d0:0:b0:355:482a:6f44 with SMTP id n16-20020a7bc5d0000000b00355482a6f44mr15891221wmk.58.1652696317257;
        Mon, 16 May 2022 03:18:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSQwk16SVnaahPaNGx+BespB0LTg4zYLJuuHiR6B6yKfb6IpUnFfwvGw90G+5SaudWYJ2Tlw==
X-Received: by 2002:a7b:c5d0:0:b0:355:482a:6f44 with SMTP id n16-20020a7bc5d0000000b00355482a6f44mr15891198wmk.58.1652696317047;
        Mon, 16 May 2022 03:18:37 -0700 (PDT)
Received: from [192.168.0.2] (ip-109-43-178-142.web.vodafone.de. [109.43.178.142])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c1d9300b003942a244ed1sm9612438wms.22.2022.05.16.03.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 03:18:36 -0700 (PDT)
Message-ID: <96d0a6a5-e50f-429e-9616-178ac1d9883a@redhat.com>
Date:   Mon, 16 May 2022 12:18:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 06/22] s390/airq: allow for airq structure that uses an
 input vector
Content-Language: en-US
To:     Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, pasic@linux.ibm.com,
        pbonzini@redhat.com, corbet@lwn.net, jgg@nvidia.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220513191509.272897-1-mjrosato@linux.ibm.com>
 <20220513191509.272897-7-mjrosato@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220513191509.272897-7-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 21.14, Matthew Rosato wrote:
> When doing device passthrough where interrupts are being forwarded from
> host to guest, we wish to use a pinned section of guest memory as the
> vector (the same memory used by the guest as the vector). To accomplish
> this, add a new parameter for airq_iv_create which allows passing an
> existing vector to be used instead of allocating a new one. The caller
> is responsible for ensuring the vector is pinned in memory as well as for
> unpinning the memory when the vector is no longer needed.
> 
> A subsequent patch will use this new parameter for zPCI interpretation.
> 
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   arch/s390/include/asm/airq.h     |  4 +++-
>   arch/s390/pci/pci_irq.c          |  8 ++++----
>   drivers/s390/cio/airq.c          | 10 +++++++---
>   drivers/s390/virtio/virtio_ccw.c |  2 +-
>   4 files changed, 15 insertions(+), 9 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

