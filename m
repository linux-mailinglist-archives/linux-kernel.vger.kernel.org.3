Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6598352000A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbiEIOlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiEIOkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:40:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEB2F3EAAF
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652107018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n4x1JmNs0lN7zeQuuaFUFxxo45axmawzrmuIq6d0Zls=;
        b=EySKNhYcCHL/N+0VN/t2VwlWCmPrMJyr0lv59WdD6nGzyXA1L7/9h0bMQcHd7OKr2TDubW
        /SOdsyuAaetyXz+N3v5AaKNJVGv2KfVNEaGnf0BXuvZdk11u6Bpw5eqqsCzRHq03BVvZ+D
        EyCx9A4c5qazkn0RsPki5LkRq79fKIk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-YtOae5DSPCSi59tmlf0qEw-1; Mon, 09 May 2022 10:36:56 -0400
X-MC-Unique: YtOae5DSPCSi59tmlf0qEw-1
Received: by mail-wr1-f69.google.com with SMTP id s16-20020adfeb10000000b0020cc4e5e683so1575063wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 07:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n4x1JmNs0lN7zeQuuaFUFxxo45axmawzrmuIq6d0Zls=;
        b=J7NMvBgRMAx35g9JPU+sTAILlj05ov2k5PKvK/dFELSTQBQg7v3ZF7lOoMpu+Fra3Y
         AA86EXNklgb9aLeAmjB/Tmg2f6TsQhzUZc+B/cN9vhavqmZdBB/ZbrzYkoMAMFstbNPH
         bsd/ka162uAJZgcfh81ut/LQZIoHgDpO9ecQwotUb8D57aCW/GHpyengu9Z2wOBDom4A
         FYYbfl2qwYz1GMRnbfQv0N9tuvVang/IHSFG62vzNDZgOQIYXDpe4OYExGoCefTpPbkC
         5yGh1PqQkDSDUzJIrVo/7WHt6o5AwnmSao70ZqkgrulvKOXbbMUxfTRo/7/K3E45NTkj
         5pzg==
X-Gm-Message-State: AOAM531Ql1XNKc2OmjwYCtzsrt+mkrfawH97UnnDffIrU4It0QINNC/b
        11jVDESZngT/l604pdsK/Sx3RDxZi/3+8odNkgaxvU5uU6phUydYhBVNgJzwTc7F+XdJQM+uRIp
        xzE6z3uNz7fQCt7ybDNYHIAV3
X-Received: by 2002:a1c:cc08:0:b0:393:e7d2:e580 with SMTP id h8-20020a1ccc08000000b00393e7d2e580mr16812232wmb.145.1652107015560;
        Mon, 09 May 2022 07:36:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGrLL/VVSw/WOa5yPynAZPNzHztUeFn+CzxclQK7K/jvA6IsiCIdA26rF3Brew3Axf9EMHww==
X-Received: by 2002:a1c:cc08:0:b0:393:e7d2:e580 with SMTP id h8-20020a1ccc08000000b00393e7d2e580mr16812218wmb.145.1652107015350;
        Mon, 09 May 2022 07:36:55 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j14-20020adfe50e000000b0020c6a524fd5sm12998987wrm.99.2022.05.09.07.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 07:36:54 -0700 (PDT)
Message-ID: <d0c7f668-e7db-f835-b410-6a6af516ceed@redhat.com>
Date:   Mon, 9 May 2022 16:36:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] Revert "fbdev: Make fb_release() return -ENODEV if
 fbdev was unregistered"
Content-Language: en-US
To:     public@timruffing.de
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <642f515e-aa71-7c90-a715-e49dcf12baee@redhat.com>
 <20220509140149.34734-1-public@timruffing.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220509140149.34734-1-public@timruffing.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tim,

On 5/9/22 16:01, public@timruffing.de wrote:
> Thanks for this patch. Do you think this can be backported to LTS 5.17.y and

You are welcome.

> 5.15.y, which are still buggy? It's not a big deal for me but others might
> profit.
>
> Background:
> The patch solves a regression from 5.17.1 to 5.17.2 or 5.15.32 and
> 5.15.33 I was about to report. On my Thinkpad T570, I got random "BUG", "Oops"
> or even panics when during booting with efifb and plymouthd (and then sometimes
> also problems when shutting down because). I had bisected the issue to commit
> 27599aacbaef. I could provide more info but I don't think it's necessary given
> that either aafa025c76dcc7d1a8c8f0bdefcbe4eb480b2f6a or your better patch now
> fixes the issue (I tested both, both work for me).
>

The patches to fix the fbdev hot-unplug regression will get merged in mainline
soon and since all have a Fixes tag, they should get picked for stable as well.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

