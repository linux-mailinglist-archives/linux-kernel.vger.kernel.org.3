Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0233659D1DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbiHWHQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiHWHQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D495758DD8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661238959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Il0sasf1rmdUin35WzTgnPhTCMVfyK1Nq9+6f6LdDpI=;
        b=XzPNSZt37qDMWwVo5t7Z0AtcYRVFZeWfx+q8vO2xmY8wN84wIgNkoWRLVYv5UiYtoQCsfp
        TWMuAwHnw2CeFre2wWsfk6l+xjfA9Gi3SZMyl3AW9pKr273Ia360C6mMep11F6Czpfziez
        6JNcA82TC+js9mOfzKYXclL+V3ebjeU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-587-956XQy8XMv2p3qwmUDWcqg-1; Tue, 23 Aug 2022 03:15:55 -0400
X-MC-Unique: 956XQy8XMv2p3qwmUDWcqg-1
Received: by mail-wm1-f70.google.com with SMTP id p19-20020a05600c1d9300b003a5c3141365so9843379wms.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=Il0sasf1rmdUin35WzTgnPhTCMVfyK1Nq9+6f6LdDpI=;
        b=gC7HkZxKMqVGD6a8tkGy5Pptg6QuASWwL8rhkFjWG3RIR6l1mXFkeb1P2rylKpdRdC
         CzLTpYj8d8tJ06cXF+vyYl1ClrVa5BC9RoEVy8fIiKFZX8mRFv+ZsJy9ycgt4og+TXYD
         okKVsYuAS14bEBnuqaDfa1mDju1hxhPvU5DWkWypNtt4TbK7Hv368ZAMCz3dajMJ9kVV
         1iEkPCN+YVNMZP2nHSGrEId6BgdJvwu+ikqRXeZYvzqb1K9btY1hoe+K4MLSyqKhx0s0
         14e64QkvtIHya+l40g2+m0UTNz3Ll5ptFXJCZrjsjdSYxE5hHtA1pgG+0E5XKcLYyj4h
         oFoQ==
X-Gm-Message-State: ACgBeo3V0r+Y7lkJHsjxc8S54vsRgyWGqGFie6N3+bsW0KeVIBkyABCN
        i0ZBkEvYfiN0KJ8uWPnDvGii45k00blDUsMB2L65qhR0QkpI5jDXUN8FNzr4b+/fomgz2hpYY3C
        CKfwL8tQujr/MbeNsxnQ2vZIE
X-Received: by 2002:a5d:69c3:0:b0:225:221f:25c with SMTP id s3-20020a5d69c3000000b00225221f025cmr11871589wrw.49.1661238954612;
        Tue, 23 Aug 2022 00:15:54 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5tPE6EDKqWGMRqYwPqG4ws37oKb0chXbAyuDzb6FstQmPHq7WGh3J3UD8GuwtvJu9GhpI8OA==
X-Received: by 2002:a5d:69c3:0:b0:225:221f:25c with SMTP id s3-20020a5d69c3000000b00225221f025cmr11871575wrw.49.1661238954351;
        Tue, 23 Aug 2022 00:15:54 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id j14-20020adfff8e000000b0021f0af83142sm13260423wrr.91.2022.08.23.00.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:15:53 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Wei Liu <wei.liu@kernel.org>,
        Deepak Rawat <drawat.floss@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v1 1/4] Drivers: hv: Move legacy Hyper-V PCI video
 device's ids to linux/hyperv.h
In-Reply-To: <PH0PR21MB30259340B9E6BA09DED4CEC4D7719@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220818142508.402273-1-vkuznets@redhat.com>
 <20220818142508.402273-2-vkuznets@redhat.com>
 <PH0PR21MB30259340B9E6BA09DED4CEC4D7719@PH0PR21MB3025.namprd21.prod.outlook.com>
Date:   Tue, 23 Aug 2022 09:15:52 +0200
Message-ID: <8735dnxwev.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Kelley (LINUX)" <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Thursday, August 18, 2022 7:25 AM
>> 
>> There are already two places in kernel with PCI_VENDOR_ID_MICROSOFT/
>> PCI_DEVICE_ID_HYPERV_VIDEO and there's a need to use these from core
>> Vmbus code. Move the defines to a common header.
>> 
>> No functional change.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 3 ---
>>  drivers/video/fbdev/hyperv_fb.c         | 4 ----
>>  include/linux/hyperv.h                  | 4 ++++
>>  3 files changed, 4 insertions(+), 7 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
>> b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
>> index 4a8941fa0815..46f6c454b820 100644
>> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
>> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
>> @@ -23,9 +23,6 @@
>>  #define DRIVER_MAJOR 1
>>  #define DRIVER_MINOR 0
>> 
>> -#define PCI_VENDOR_ID_MICROSOFT 0x1414
>> -#define PCI_DEVICE_ID_HYPERV_VIDEO 0x5353
>> -
>>  DEFINE_DRM_GEM_FOPS(hv_fops);
>> 
>>  static struct drm_driver hyperv_driver = {
>> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
>> index 886c564787f1..b58b445bb529 100644
>> --- a/drivers/video/fbdev/hyperv_fb.c
>> +++ b/drivers/video/fbdev/hyperv_fb.c
>> @@ -74,10 +74,6 @@
>>  #define SYNTHVID_DEPTH_WIN8 32
>>  #define SYNTHVID_FB_SIZE_WIN8 (8 * 1024 * 1024)
>> 
>> -#define PCI_VENDOR_ID_MICROSOFT 0x1414
>> -#define PCI_DEVICE_ID_HYPERV_VIDEO 0x5353
>> -
>> -
>>  enum pipe_msg_type {
>>  	PIPE_MSG_INVALID,
>>  	PIPE_MSG_DATA,
>> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
>> index 3b42264333ef..4bb39a8f1af7 100644
>> --- a/include/linux/hyperv.h
>> +++ b/include/linux/hyperv.h
>> @@ -1516,6 +1516,10 @@ void vmbus_free_mmio(resource_size_t start,
>> resource_size_t size);
>>  	.guid = GUID_INIT(0xc376c1c3, 0xd276, 0x48d2, 0x90, 0xa9, \
>>  			  0xc0, 0x47, 0x48, 0x07, 0x2c, 0x60)
>> 
>> +/* Legacy Hyper-V PCI video device */
>> +#define PCI_VENDOR_ID_MICROSOFT 0x1414
>> +#define PCI_DEVICE_ID_HYPERV_VIDEO 0x5353
>
> I've never looked at this before, but shouldn't these move to
> include/linux/pci_ids.h with all the others?  And we've got
> another #define of PCI_VENDOR_ID_MICROSOFT in
> drivers/net/ethernet/microsoft/mana/gdma_main.c that
> could be deleted.
>

Oh, true, include/linux/pci_ids.h is much better. Let me send an updated
patch (detached from this series).

-- 
Vitaly

