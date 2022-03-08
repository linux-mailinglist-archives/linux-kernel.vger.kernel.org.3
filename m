Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CCB4D22C2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344300AbiCHUjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiCHUjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:39:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C74B2C13B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646771914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FoBRIeqgLPupnZmRM+iNXvFKf6bd3tq0ykamYd2tTu8=;
        b=S9O8+Imm/ywyEPqtBTfFS6pyMnS9ivbZH2YcsV9W4OkgJf2LsLY/Qr7osnaTz/emez0Ou/
        Xu2C74ottis+u+9yElzMkoQ/GUafYuU7z/ilGwQNmhkHxYPGXWbfBAAeDqRKKN9ET6yLE6
        T1wX00o9/g4FeGGebLGQ6Y23kwyQCGo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-ZPVCpXrJNsK2nE_iYeQCZQ-1; Tue, 08 Mar 2022 15:38:33 -0500
X-MC-Unique: ZPVCpXrJNsK2nE_iYeQCZQ-1
Received: by mail-wm1-f69.google.com with SMTP id r133-20020a1c448b000000b00385c3f3defaso141654wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 12:38:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FoBRIeqgLPupnZmRM+iNXvFKf6bd3tq0ykamYd2tTu8=;
        b=pMHxYYHQtb2mHmfQZc0IIyx3Irzy/Infph8BE1Irjvxx1d46ffYN61Wy2FLHe2ujFh
         ylEvqhyMXEPZV6ixgR1L3Gkt20Zwi/e+SM4NzeOzuogXRMarjiqSvngEeUiWSmqqF3ee
         VIz487UzwfNgLUQWH9tiNl+Dov7GYAM96HFI7edUfqaElbVZIWNf0/HErL/vpyqgRWGP
         8p9+5XVgb+uso8L8fhKCBhQLZIFfS1MywEk5YvMZX+5Z0ZzaXzWbdHikn+5TWPkKih5n
         345/2ver5H7qFJ38iE/rqBi8l8YR0K0QUL3FeFYDLfhQMmzmQovkiQRlUQv3HRJvU6Ra
         GOOQ==
X-Gm-Message-State: AOAM531mA0LuCRH3+uuuN5YjgK9vQNnirVLFfZsEdDsM07d1J5ZM2nPp
        JD2kmXsqMWdr79UnXrvg0D9IslyGFrPDrd/VNAvZv4uyUrKHdFcYx1OIHMmBYY7tbcMENDMQEm1
        /DQkVYpdEO6z+XI7tVMCB1ZwJ
X-Received: by 2002:a05:6000:1a8f:b0:1e8:3301:1273 with SMTP id f15-20020a0560001a8f00b001e833011273mr13579030wry.707.1646771910933;
        Tue, 08 Mar 2022 12:38:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyACu+l5d8zlO5fn6jeLt1osubbTuoLy1Qt9BUBcsvksAAefifa1CtOLhGbeqsEGUGu19bi4g==
X-Received: by 2002:a05:6000:1a8f:b0:1e8:3301:1273 with SMTP id f15-20020a0560001a8f00b001e833011273mr13579012wry.707.1646771910702;
        Tue, 08 Mar 2022 12:38:30 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l12-20020a05600012cc00b001f059bcbd7asm13726134wrx.31.2022.03.08.12.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 12:38:30 -0800 (PST)
Message-ID: <85ed6113-ad81-94a2-14ac-b5046139e217@redhat.com>
Date:   Tue, 8 Mar 2022 21:38:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm: ssd130x: Always apply segment remap setting
Content-Language: en-US
To:     Chen-Yu Tsai <wens@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20220308160758.26060-1-wens@kernel.org>
 <20220308160758.26060-2-wens@kernel.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220308160758.26060-2-wens@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/22 17:07, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Currently the ssd130x driver only sets the segment remap setting when
> the device tree requests it; it however does not clear the setting if
> it is not requested. This leads to the setting incorrectly persisting
> if the hardware is always on and has no reset GPIO wired. This might
> happen when a developer is trying to find the correct settings for an
> unknown module, and cause the developer to get confused because the
> settings from the device tree are not consistently applied.
> 
> Make the driver apply the segment remap setting consistently, setting
> the value correctly based on the device tree setting. This also makes
> this setting's behavior consistent with the other settings, which are
> always applied.
>

Nice catch. This is certainly much better. Thanks!
 
> Fixes: a61732e80867 ("drm: Add driver for Solomon SSD130x OLED displays")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

