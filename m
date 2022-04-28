Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA23512DF4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbiD1IQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343821AbiD1IQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:16:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 876C8771CD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651133612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lWQrFegs4y+/AqjpDTmKtLV6ErynfS4+Zm1sxeLo25E=;
        b=DSV8vJXeribrJ4CcPlXxoTgiqMcV+qydo6CvcpLtqSBTx8HqyVub9GIeNc7I0rjlni/6T3
        Plq2IJ6idLeECoKUMNuzM/8wqMDPV6hZDAKiVN3yAIO+fz97ZMdLTzKMGF4hJ/NDQ/wjeA
        KjJjy+gO/ArjMsokHthL3WgHZkXyhn4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-NCOD99D3N8GF5yYtIrnzJg-1; Thu, 28 Apr 2022 04:13:31 -0400
X-MC-Unique: NCOD99D3N8GF5yYtIrnzJg-1
Received: by mail-wr1-f71.google.com with SMTP id g7-20020adfbc87000000b0020ac76d254bso1636245wrh.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lWQrFegs4y+/AqjpDTmKtLV6ErynfS4+Zm1sxeLo25E=;
        b=wQ1jLSDqeSTKUDraAtjOmx9NL03YlAs2488+qy+Unt5SXr0vDVhKJ7jlMqyLPgPzJd
         t/YBuzVK07dUE+zGu3kzNFOIS0qcI8kaT6RTCo6u9TsHmvwu1tY1hEEIIYCgWSMxwV3m
         meXPW1+sbFheAqS+jD9baYMenCLd+Y8rQSdEiUsKFll1mNlNPBRG6DGhRPArizNuyfF9
         MuKN1SPTue2Fd+bCkcM3Jy0hZ7dx4OGsE5/+B4CnNkjIRGGFXNsYlZKVVTMjR9R26T4A
         +8cVWU+lFsTmvlL553Mm7lRSR/mP4jCjESXM+IJQIy1cH5BqDtKxnDmHALXSuYn0iARr
         J8Rw==
X-Gm-Message-State: AOAM531GtQFTYrH93/XlRFBdMLLB8mEVRvNix2cPzv10CSziWQJIDYIn
        xvmVtsppKOqCkOTs5rHRjpb4oMWT98XjeYRQCQJAatK8TsUBvkve5qsfOG9UwwYgTtiaelGAic0
        P1n0k8nC2+5mGZA/0SASVPw6F
X-Received: by 2002:a5d:6b0e:0:b0:20a:dd17:e452 with SMTP id v14-20020a5d6b0e000000b0020add17e452mr14573005wrw.501.1651133610066;
        Thu, 28 Apr 2022 01:13:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgeL9zqCpTQRUUwTrQ96T14Z4BV1IgTzEd+WfFAxKG95THdyAPR/GzuQnbUbjUr0bb123U6A==
X-Received: by 2002:a5d:6b0e:0:b0:20a:dd17:e452 with SMTP id v14-20020a5d6b0e000000b0020add17e452mr14572993wrw.501.1651133609861;
        Thu, 28 Apr 2022 01:13:29 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b00393eaf94077sm4124458wmq.8.2022.04.28.01.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 01:13:29 -0700 (PDT)
Message-ID: <262043e4-feee-5540-9a43-8871cb51764a@redhat.com>
Date:   Thu, 28 Apr 2022 10:13:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] drm/display: Select DP helper for DRM_DP_AUX_CHARDEV
 and DRM_DP_CEC
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Lyude Paul <lyude@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
References: <20220427215528.237861-1-javierm@redhat.com>
 <46446e78-60a6-1b8c-1bb6-1c005489d58c@suse.de>
 <6f3b8d37-0a70-a035-e87b-5aa72926fff9@redhat.com>
 <af31d343-202b-ffaa-c6a9-b20247938dfd@suse.de>
 <1d456654-6d06-ef35-b9a0-519db7d5b35e@redhat.com>
 <cdad47d0-939d-9eda-feae-78cf204a0ae6@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <cdad47d0-939d-9eda-feae-78cf204a0ae6@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 10:04, Thomas Zimmermann wrote:

[snip]

>>
>> Right. So giving even more thought to this, now I think that we should just include
>> drm_dp_aux_dev.o, drm_dp_cec.o (and probably drm_dp_aux_bus.o?) unconditionally to
>> drm_display_helper-$(CONFIG_DRM_DISPLAY_DP_HELPER).
>>
>> After all, these are not big objects and drm_display_helper can now be built as module.
>>
>> I don't see that much value to have separate user-configurable config options...
>>
> 
> I don't know the side effects of this. We're exporting another device 
> file after all.
> 
> For know I'd make them depend on DRM_DISPLAY_DP_HELPER. If someone 
> complains we can revert and fix the linker error by adding stub 
> functions for the missing symbols.
>

Ok, I'll just add the depends on then to fix the linking errors and then either
adding the stubs when disabled or just making it part of the DP_HELPER can be
done as a follow-up.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

