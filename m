Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C62D4C2DF7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 15:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiBXOOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 09:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbiBXOOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:14:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6755A25454A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 06:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645712016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DI4zjY4lS3dLYa5nzsSOjq7YbhKMDTz4i784koPAZIE=;
        b=YRzqvLuVF73vgHGuk6nOG41GuDyWsM79scktHXY/g7QJYKnKktfQ7qCUc1ZPC6TfR0jEX+
        AKlqm+Zdm6gZtqNnK7SxVsj5DGCkz0iRKGfFRju/0zC7ZHSAkaJyOYUiRuNyFCP77CFPxt
        9gTu/G81/hEWAGJ6gSngLxS/wx15xo8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-3gVO2ModNcWju_68QcHLPg-1; Thu, 24 Feb 2022 09:13:35 -0500
X-MC-Unique: 3gVO2ModNcWju_68QcHLPg-1
Received: by mail-wm1-f70.google.com with SMTP id 187-20020a1c19c4000000b0037cc0d56524so2765193wmz.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 06:13:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DI4zjY4lS3dLYa5nzsSOjq7YbhKMDTz4i784koPAZIE=;
        b=Z9OY/B/LGwOzI+xW3pG8ZvEv4pR00+D8tAUBgirjJ8qPmZHU0XuxRB9fQWtZzfW9iB
         NbNh1Q79iQCEtnw4a8MldW0/GnRqUHRrNpQB+nkr0WLFERYEiEOy1OsZzEUPTp8XJoWL
         gSiZ12nW42XPRl9xduM5OspLIOc1qBvYMA+9svMLljYdjA27BvMllQ7lRPlMbqM/uVDT
         lxKl97wVR+4YHX7YBt0zHlOfswpDuVSBksceGuCc0AG+EMvgB+qLjDt8xTvEcXl6IckA
         RkOJBh1/SBlzli6otVuCEW2mt1Tww8xuSQfUB635kLGWR9ltU93Hwvnelc6Z8YrVlMm5
         nGPw==
X-Gm-Message-State: AOAM5313y4AQ857KHrqU+PbcZaOu8/DbzsAl/nrz5IK6Mceb1IyImKIS
        CJR9qUHETvuijKf42o9l2BTEci3CSlb9X/WxIMjOgFSBhNPx/gU4yJnHn9Z7GZRORjsT5CaKqjU
        l76TP3vcsZW5OHRis72ASwoKm
X-Received: by 2002:a5d:598a:0:b0:1e6:29fa:bab1 with SMTP id n10-20020a5d598a000000b001e629fabab1mr2418370wri.671.1645712014040;
        Thu, 24 Feb 2022 06:13:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfe4fe2v5GNRVeILo1VPG5IYB2PUYvG9TFe/BPVsWuewrn8CyZCp4t8/Wq1fckULquHMMqfA==
X-Received: by 2002:a5d:598a:0:b0:1e6:29fa:bab1 with SMTP id n10-20020a5d598a000000b001e629fabab1mr2418357wri.671.1645712013830;
        Thu, 24 Feb 2022 06:13:33 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f3sm2887683wri.6.2022.02.24.06.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 06:13:33 -0800 (PST)
Message-ID: <fe202ad8-3035-6ff0-e298-8228c6aa61bb@redhat.com>
Date:   Thu, 24 Feb 2022 15:13:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/repaper: Use format helper for xrgb8888 to monochrome
 conversion
Content-Language: en-US
To:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
References: <20220223193735.213185-1-javierm@redhat.com>
 <af865ac6-0353-0004-dec2-f227ee8bb01d@tronnes.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <af865ac6-0353-0004-dec2-f227ee8bb01d@tronnes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Noralf,

On 2/24/22 15:04, Noralf Trønnes wrote:
> 
> 
> Den 23.02.2022 20.37, skrev Javier Martinez Canillas:
>> There is now a drm_fb_xrgb8888_to_mono_reversed() helper function to do
>> format conversion from XRGB8888 to reversed monochrome.
>>
>> Use that helper and remove the open coded version in the repaper driver.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
> 
> Tested-by: Noralf Trønnes <noralf@tronnes.org>
> Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
>

Thanks a lot for testing and for your review.
 
> Do you have commit rights and will apply this patch?
>

Yes, I do. Can apply this later today.

Best regards, -- 
Javier Martinez Canillas
Linux Engineering
Red Hat

