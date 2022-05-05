Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19CC51BA7F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344233AbiEEIee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349549AbiEEIe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:34:29 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10D78DF51
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651739449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rqBSEx+prjdTiMrGpV1aqsQTWQSdTrwVLGOaM2DRpu0=;
        b=SaW+KQDzDROhkrRdqSx8kfZYe8C2T28O81x98p4j+O0AL7detuwtVCAfb0ANRKAbpNcjkV
        YSeOHL7xdBh/EZKcxZUZXHrmw0j34gLakAnAyowX//U6PjlF5KZFGMOJ26H/EmMH/EDfqG
        8shM+4z3GyyGCEUSy9NBHzbrSAWx1qI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-_l--jUg4PhukUwKfGvmJgQ-1; Thu, 05 May 2022 04:30:46 -0400
X-MC-Unique: _l--jUg4PhukUwKfGvmJgQ-1
Received: by mail-wm1-f69.google.com with SMTP id 205-20020a1c02d6000000b003928cd3853aso1244723wmc.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 01:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rqBSEx+prjdTiMrGpV1aqsQTWQSdTrwVLGOaM2DRpu0=;
        b=f1R+SJCeEqNqPTYqrRgKdXlLaDhQdFpW2Pgqn/qXYaVB/Nk1+mgfDapzx8m3fCsPq/
         dDNw4qGy/pab9qlc9vnDLWT/75U1hc1/tIIZclCX8L+iOxilsHbwlt8jLMu9BcuYRk6b
         DJIJJ+FGesJ9xiaNSqiCSnYZ860tGhLeSQap5aX8YaC1l0xaPFPjra9sllZupdWTU5i8
         7lVnPb/KYDx8OJzz4rJdgmzacRhJE3M69tOL1z5wrSM2UXgmUC5SNWn7VKmL17QJeFtx
         VKefLn4NA06ckTWbfsxGDk1JasR3t2k1bwQqlYtol+VEqvjzqSP+nAIgwGV5gCkbuD5j
         o/+w==
X-Gm-Message-State: AOAM531dalOSeZQe/q0wfhLvU+iCWdGnHm18BDar6CwvjbN9vm8E/Vr6
        kUkbNg8vUflF3EgP4eFHXx7Rs0hROXu316cW10RMeBHSkNw8nlQm39NAcMAwIKLV+q9TVwh7Ki4
        uGUznsog7RnS+qN6GXj7wwP9Y
X-Received: by 2002:a05:600c:21cc:b0:394:12ff:dd8d with SMTP id x12-20020a05600c21cc00b0039412ffdd8dmr3524889wmj.132.1651739445193;
        Thu, 05 May 2022 01:30:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFHaBQnPBJ08w4wMFqpq4uA/qAMN794Kl5iBycIsNges0PhcSzS7HhVQE1ACXB2xwj0udL/A==
X-Received: by 2002:a05:600c:21cc:b0:394:12ff:dd8d with SMTP id x12-20020a05600c21cc00b0039412ffdd8dmr3524869wmj.132.1651739444856;
        Thu, 05 May 2022 01:30:44 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l18-20020a1ced12000000b003942a244edcsm846083wmh.33.2022.05.05.01.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 01:30:44 -0700 (PDT)
Message-ID: <14afd90b-0bf3-aa01-3b97-db7e29fb858a@redhat.com>
Date:   Thu, 5 May 2022 10:30:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/3] fbdev: Fix use-after-free caused by wrong fb_info
 cleanup in drivers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>
References: <20220504215151.55082-1-javierm@redhat.com>
 <e0bc775a-f17a-adf1-9b2c-4be91468b7f8@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <e0bc775a-f17a-adf1-9b2c-4be91468b7f8@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 5/5/22 10:16, Thomas Zimmermann wrote:

[snip]

>> Patch #1 adds a WARN_ON() to framebuffer_release() to prevent the use-after-free
>> to happen.
>>
>> Patch #2 and patch #3 fixes the simplefb and efifb drivers respectively, to
>> free the resources at the correct place.
> 
>  From a quick look, vesafb seems to be affected as well.
>

Right, I wrongly assumed that we only cared about efifb and simplefb but forgot
that vesafb is used when setting a VESA mode with vga=foo. I'll add it in a v2.
 
> Best regards
> Thomas
> 

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

