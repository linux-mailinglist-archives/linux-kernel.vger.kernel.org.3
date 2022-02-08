Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9CB4AE530
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbiBHXGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiBHXGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:06:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17B4FC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644361594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Hq44IoeTfJkZkwVY9Vl9iSJryds5VqEFOHSRWPT7XY=;
        b=QiUhzl8g5640Obe+GZgf0gNwBjbtgl8qFFwRmRNEgNQ6PeWIgE7zIavZ62MjPaOMc2b/aL
        tHnJE/6qy+uvgX8UwlXRTjGspIzauy2m2bXAflHuo8mImsdNyc3qgqbPcXu8Eik/5vH4Nz
        7lwHEdauqDWQUdfJ13FqmsRhDGdcv8w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-e4zHUg_tNwCIc0Z--TC3tg-1; Tue, 08 Feb 2022 18:06:33 -0500
X-MC-Unique: e4zHUg_tNwCIc0Z--TC3tg-1
Received: by mail-wr1-f70.google.com with SMTP id v9-20020adfa1c9000000b001e33e5dbd5fso244138wrv.17
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 15:06:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9Hq44IoeTfJkZkwVY9Vl9iSJryds5VqEFOHSRWPT7XY=;
        b=J9LF8irszOzKNaQ5FDcKzYFORlKw8uVnDEAc2Bz3MpwomeHed5/eTq8oC18fdy0rb3
         LTCtNeuoXnXjUmJ7lAmpvnSwE9JtqRCShfZP5Jiv22DlMfwLhVGQN6GAmTIolY1jskIh
         Ec9+VJaAUSBV4wUmseW4pWwAnBKJy9QboLXbh0Ep9lq6fXXfl3I+9Hy2KrpZd+YoPh1/
         JyF1KWke9I/t025Hv5Ei3+LEzD3NxMOpCMSio12nJHuitP1BJyoJmWMSKm2e9bMEDBzP
         1q/yj279oGhFYWGjYwugfyoZefaBScUCuZ2aINNIDPjy8LXOh0GB0Mh26uBwIIvAIclq
         ObKg==
X-Gm-Message-State: AOAM532HiTvRycfQFUUHHyJ2VUe8Jei9I97M6bRVbrakTcVdoRz5TYLa
        9ETO2aHK/pjITbTYmi/ZEzYEZY6I0c44gYea4WPjy50UaHv7ohiOgcpUAE00vrNWnB1InS4618a
        HJWnGnuMn+ZCjPlI3uvf6wKmX
X-Received: by 2002:a05:600c:1f06:: with SMTP id bd6mr188782wmb.98.1644361591937;
        Tue, 08 Feb 2022 15:06:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmNuGMQwcN6QexrJL10FFKZYDdF5TN06r7ebrBGFi7sK9RD4aMR2dVzQHHgAbW45sC7ClvFg==
X-Received: by 2002:a05:600c:1f06:: with SMTP id bd6mr188768wmb.98.1644361591694;
        Tue, 08 Feb 2022 15:06:31 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l26sm2975339wmp.31.2022.02.08.15.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 15:06:31 -0800 (PST)
Message-ID: <4f5a94f9-404f-e803-1b61-41653c9de388@redhat.com>
Date:   Wed, 9 Feb 2022 00:06:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 02/19] fbcon: Move fbcon_bmove(_rec) functions
Content-Language: en-US
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Claudio Suarez <cssk@net-c.es>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
 <20220208210824.2238981-3-daniel.vetter@ffwll.ch>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220208210824.2238981-3-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/22 22:08, Daniel Vetter wrote:
> Avoids two forward declarations, and more importantly, matches what
> I've done in my fbcon scrolling restore patches - so I need this to
> avoid a bunch of conflicts in rebasing since we ended up merging
> Helge's series instead.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

