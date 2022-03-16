Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBE04DB4B3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349298AbiCPPTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343798AbiCPPTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50ED73B3D2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647443885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/uVU27MUQYVU+wgJKpbBvrcqEJY7UjfllrQP2RhSbk=;
        b=dTQBUtzX3h0/frdZ2FQ+nBlTGHIcpqRC/ZDhktfHVHf3ZCuN89yPUi0fKQIwERvU80/1ES
        lcJGt5ntkeaPqM+Voo2Y2XguOAPgCMCQV21m3VbzlxUs7+xGtXWJQsDXhCO/eotC+OUqyB
        23b7kde0pRlbp+aBkDO9dmZi+1OX1rk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-AxUZb6LhM8aDZrXzeKvAwg-1; Wed, 16 Mar 2022 11:18:04 -0400
X-MC-Unique: AxUZb6LhM8aDZrXzeKvAwg-1
Received: by mail-wm1-f70.google.com with SMTP id c19-20020a05600c0ad300b00385bb3db625so2905028wmr.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=w/uVU27MUQYVU+wgJKpbBvrcqEJY7UjfllrQP2RhSbk=;
        b=cVHwvKVBH/F2UNbH/Iw/dZCRnq+syp26SXjG3pcQ2dEnJfhgaN7D7aX4hQ/PIJCC5w
         ovVrDjeERpi/zLv/7eHoRrHVEzmrOiflVtJETf2FstGWxZVuPDTMbLIs2SlY7h89tLGf
         ndkJOlZju2HKQUs5/0dl6Y3U2oX5ywPm2suBr5Qys1TI+Z1IthBjkqz0w6sCtuHgNrn9
         F83fRI34KhinZ7g3F7fXAN4AySVVjtBd8h4RGdsouIPKynjHVto9M9RfphVxqs01H1xf
         PmNOjbf2Vc22CkNWePj1W/BzK/94XbYc6EzwlKb5zQO3dKxMxyotqxmyx5GObtoTErma
         uf9w==
X-Gm-Message-State: AOAM532yLJlkfMmaYtS2YuMKQhsR+wdc130yxgosiY0dvPsqNAc5wJsr
        bIWyBCliH+W8zQg5yL4sf8oMpCMkYBUR3QyvpodJ7CUFsG4gxMPLEZ0J8WULfpRthT+JZWLc579
        b0cdMgVFsjVxZmrWPJK+ehz+d
X-Received: by 2002:a5d:6610:0:b0:1f1:e606:f097 with SMTP id n16-20020a5d6610000000b001f1e606f097mr384064wru.134.1647443882865;
        Wed, 16 Mar 2022 08:18:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgX7M3pSLfvswnCZinlxjE/UiPfGgG3EjL14bFT0DvEZXH3YwTrW3SFlGgJ6FkbccoaVZgJQ==
X-Received: by 2002:a5d:6610:0:b0:1f1:e606:f097 with SMTP id n16-20020a5d6610000000b001f1e606f097mr384044wru.134.1647443882590;
        Wed, 16 Mar 2022 08:18:02 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bk19-20020a0560001d9300b001a65e479d20sm1847666wrb.83.2022.03.16.08.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 08:18:02 -0700 (PDT)
Message-ID: <0fa87883-829d-93d0-f0f3-7d3faa8d060c@redhat.com>
Date:   Wed, 16 Mar 2022 16:18:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next] drm/solomon: Make DRM_SSD130X depends on MMU
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     YueHaibing <yuehaibing@huawei.com>, airlied@linux.ie,
        daniel@ffwll.ch, maxime@cerno.tech
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220312063437.19160-1-yuehaibing@huawei.com>
 <08e81f07-99d2-62a3-8eea-b2c0432b4d18@redhat.com>
In-Reply-To: <08e81f07-99d2-62a3-8eea-b2c0432b4d18@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/22 10:18, Javier Martinez Canillas wrote:
> Hello YueHaibing,
> 
> Thanks for the patch.
> 
> On 3/12/22 07:34, YueHaibing wrote:
>> WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
>>   Depends on [n]: HAS_IOMEM [=y] && DRM [=m] && MMU [=n]
>>   Selected by [m]:
>>   - DRM_SSD130X [=m] && HAS_IOMEM [=y] && DRM [=m]
>>
>> DRM_GEM_SHMEM_HELPER depends on MMU, DRM_SSD130X should also depends on MMU.
>>
>> Fixes: a61732e80867 ("drm: Add driver for Solomon SSD130x OLED displays")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
> 
> Indeed. All the DRM drivers that select DRM_GEM_SHMEM_HELPER depend on MMU.
> 
> Acked-by: Javier Martinez Canillas <javierm@redhat.com>
> 

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

