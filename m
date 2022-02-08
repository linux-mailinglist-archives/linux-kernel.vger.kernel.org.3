Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9CC4AE5B5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 01:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239038AbiBHX73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239016AbiBHX72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:59:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7A68C061577
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644364767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1B+HhoEdav6Cob3bPb/BF6nu8D/2OQMn0TX9fIjaHGQ=;
        b=ic2wNtBUam2bz3I4ll/IUk94uFAfcHQdZaWPQd7Hg+vh4iRcpSU//sYaSmkxWOpXWX8Dqf
        jJ7dLcG3zHG9eU3zRy9SURbxI+vMn7Ud03/0m+klpZoeBEFWgFVh6Px2etZcYHvuf8dK01
        lp69zuxLHkDb/xBdiBYGlXxCzxoJS08=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-CuqG3tJ7M4qhx5ukxKXnTQ-1; Tue, 08 Feb 2022 18:59:25 -0500
X-MC-Unique: CuqG3tJ7M4qhx5ukxKXnTQ-1
Received: by mail-wr1-f71.google.com with SMTP id g17-20020adfa591000000b001da86c91c22so308821wrc.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 15:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1B+HhoEdav6Cob3bPb/BF6nu8D/2OQMn0TX9fIjaHGQ=;
        b=dU1KnwZTTu4rG4DEP4c1gd2HopDu/VsGAysKJf8YIkPI8qaj70EEodxCnehG6NoozY
         4jWQiA8h8X1S9iohvE0oZR0VdJmVsJkwg+h7OVAoaQvXmZ0PeykNqd18m5A/IFnr36jl
         klIdQOO+zKGtbr+behyW7Ih3HeCOabMmiiC5bACOag+QeXsHqboh+ANj52U+Ybe7TwmL
         pZuYQ2zEzoyl1AhMAiRSC7O8EmapmWPTul3nx+hICXG1PthRFdBNw4INjwoYO1WeKdC/
         Tv5pp3dtppxXe6Oqxzv/fO1a7hcvyEPL/seAvOFFq6gK6j5/EFLhqaHLv59D0ULodBwT
         nLWw==
X-Gm-Message-State: AOAM533CKtUW8FUGskg0ZrE32KjhcKTZeCrQjw97hIIMnksKlVtPeRCm
        SUut5mmtCjCC7AfTA5bfhQaU4xY0F9w2u9dSWDTc9mZfxGfAte89+AtPuUcxt4JeUuW53u+veOf
        BgXHOAhysw+gM2kQf8G8D73Jg
X-Received: by 2002:a1c:4c19:: with SMTP id z25mr302718wmf.105.1644364764702;
        Tue, 08 Feb 2022 15:59:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwyxrdx5PAN39E9zDPgBt3t7VCZ+YkAG7VKuS1GxY71C3wn6MOzwm1KHjgao+aMLB+p3UZbTg==
X-Received: by 2002:a1c:4c19:: with SMTP id z25mr302707wmf.105.1644364764502;
        Tue, 08 Feb 2022 15:59:24 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l24sm3859205wms.24.2022.02.08.15.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 15:59:24 -0800 (PST)
Message-ID: <c58f7b96-8d8c-030e-9fd2-358e259127e4@redhat.com>
Date:   Wed, 9 Feb 2022 00:59:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 06/19] fbcon: Use delayed work for cursor
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
        Daniel Vetter <daniel.vetter@intel.com>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
 <20220208210824.2238981-7-daniel.vetter@ffwll.ch>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220208210824.2238981-7-daniel.vetter@ffwll.ch>
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

Hello Daniel,

On 2/8/22 22:08, Daniel Vetter wrote:
> Allows us to delete a bunch of hand-rolled stuff. Also to simplify the
> code we initialize the cursor_work completely when we allocate the
> fbcon_ops structure, instead of trying to cope with console
> re-initialization.
> 

Maybe also make it more explicit in the commit message that the delayed
work is replacing a timer that was used before for the cursor ?

> The motiviation here is that fbcon code stops using the fb_info.queue,

motivation

[snip]

>     /*
>      *    This is the interface between the low-level console driver and the
> @@ -68,7 +68,7 @@ struct fbcon_ops {
>  	int  (*update_start)(struct fb_info *info);
>  	int  (*rotate_font)(struct fb_info *info, struct vc_data *vc);
>  	struct fb_var_screeninfo var;  /* copy of the current fb_var_screeninfo */
> -	struct timer_list cursor_timer; /* Cursor timer */
> +	struct delayed_work cursor_work; /* Cursor timer */

A delayed_work uses a timer underneath but I wonder if the comment also
needs to be updated since technically isn't a timer anymore but deferred
work that gets re-scheduled each time on fb_flashcursor().

The patch looks good to me and makes the logic much simpler than before.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

