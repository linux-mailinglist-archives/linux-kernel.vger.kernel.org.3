Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC4E5427E0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbiFHHLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiFHGSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EBEA19CED2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 23:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654668129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UsmRmrmyC0YlUnFIqRRJkIZ3ojsOtC4OxRQHrbODTWU=;
        b=Tjb77YBezB5HtWDIgiElPXSw6MxMt2Cgt9bdnRGg/t1ZmFvTNm5Fti1zulqiiv2Yo/GQGo
        Rq4GKFooiKgh440+iH89S/eSJuHmwCBifCZ+5TgnaLbWldB2UV1Wo0VZhimNMuqnQdVMlj
        HSPi0kLsz/QVYdom+h3f8jKIZ2v87z4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-_1-_uCFpMtmZH3briLCSmg-1; Wed, 08 Jun 2022 02:02:06 -0400
X-MC-Unique: _1-_uCFpMtmZH3briLCSmg-1
Received: by mail-wm1-f69.google.com with SMTP id bi22-20020a05600c3d9600b0039c4144992cso5652545wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 23:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UsmRmrmyC0YlUnFIqRRJkIZ3ojsOtC4OxRQHrbODTWU=;
        b=GPJN+1Qkte6rfw1ELCSf6fNxTASRTE1FcKW8MuR8XA433OyNeF27Cjp7daeIXKVi+Z
         E7qTkCTgGdIwZ0zIQfo6QINGD74cGVy9/oRrda1Y8waxy8FPnwi1Aj+mNOLyQuZzn4R+
         fdkLx46g4FQIGL8Bdb40UdSL0XyGiXi39pKYtc6p08VbOWBejkfKy6jIr29EeUzQpTRh
         KXTRyebY6lp6T0b84nm6AEqkzOpR9lZ8jCgHmVM+PQi3M0AFAhmEMmiYbhnzOmSsb9Pc
         0Ub4Nvk8XrKeFgjlzWOtV/V6kExOmplanIH/6ca+dNFtUAcgOCyyduVZMMtKC3DjrLxP
         Lb8w==
X-Gm-Message-State: AOAM5305PiPOLIS5tVeTp3ddONN6Yf55Wsr2TqfxlnF/i+r98P8vyjH5
        uVU528n6jsEOgOWfhxStvyAB97GqedpBaHH9vTXg7blV/CYYrzCwbJ8yf+NQobWbQk8IODeuU8u
        mKg3ET5d9dLQ350GZ4xDeK0al
X-Received: by 2002:a05:6000:147:b0:214:7d6e:cb1d with SMTP id r7-20020a056000014700b002147d6ecb1dmr24578582wrx.650.1654668125066;
        Tue, 07 Jun 2022 23:02:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHgUMf0DiGTalylNFpQjB5EiBfIrRc71DZVAGtXhPU6EUyeZBdyPoZS/71mmMYC1pA8jBi1g==
X-Received: by 2002:a05:6000:147:b0:214:7d6e:cb1d with SMTP id r7-20020a056000014700b002147d6ecb1dmr24578561wrx.650.1654668124893;
        Tue, 07 Jun 2022 23:02:04 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-42-114-66.web.vodafone.de. [109.42.114.66])
        by smtp.gmail.com with ESMTPSA id x14-20020adff0ce000000b00210396b2eaesm24124187wro.45.2022.06.07.23.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 23:02:04 -0700 (PDT)
Message-ID: <1bdd501e-01f6-a0fb-86f3-49ec19ec5bcf@redhat.com>
Date:   Wed, 8 Jun 2022 08:02:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v9 21/21] MAINTAINERS: additional files related kvm s390
 pci passthrough
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
References: <20220606203325.110625-1-mjrosato@linux.ibm.com>
 <20220606203325.110625-22-mjrosato@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220606203325.110625-22-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2022 22.33, Matthew Rosato wrote:
> Add entries from the s390 kvm subdirectory related to pci passthrough.
> 
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6d3bd9d2a8d..3dd8657f5482 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17454,6 +17454,7 @@ M:	Eric Farman <farman@linux.ibm.com>
>   L:	linux-s390@vger.kernel.org
>   L:	kvm@vger.kernel.org
>   S:	Supported
> +F:	arch/s390/kvm/pci*
>   F:	drivers/vfio/pci/vfio_pci_zdev.c
>   F:	include/uapi/linux/vfio_zdev.h
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>

