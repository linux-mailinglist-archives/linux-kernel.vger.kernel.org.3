Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3304BA463
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242403AbiBQPaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:30:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239673AbiBQPaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:30:01 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98FD2B0B2D;
        Thu, 17 Feb 2022 07:29:46 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id p14so8094884ejf.11;
        Thu, 17 Feb 2022 07:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SdNsn33s2vqrmQrJpjzrM9XwN56LeRJmp4LOd8dZoak=;
        b=pJzLECZFS8HAu/ThmLu9FQj6w/XVV4XVVP7YvND/CgvqTXm4hInd7wvi3fxO6g7xpr
         tsuC1drjCzzSg44Ibmg3jjQYJyuOhmPQIZX0mIGbs79SLIMXOR8eqRPYPFr6FlT0vcpc
         MN0G6gKuBAFe9mvEc6uUiRwol7N0WYkJT8o4BiaM0qbIod5sPtOhvs3T4cZ2hqhTAQiO
         aHXI9w0WGCOHhfAMZy/wRNsef5Tfa5yC5PtRrx9OdC9VHstzOgMIGx/HXn62mdHbR5Ix
         kpV6aliPf40QaM0Qn0chv+tOW6sCVdB0y0zEKzvz+NHzK5n+B3xl+8qYWP3OcdcJy2y2
         Kq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SdNsn33s2vqrmQrJpjzrM9XwN56LeRJmp4LOd8dZoak=;
        b=Y8Z9eu7bVpWraDBkanjrEQtR/SrPKEnYoHjPTi+oO4JsuLF+U8C2XHCeSeEyQ+w+OW
         tNkdXDfLVu6I7MOK+7GFm0CWEkFPLcALrVwKfAMuOEUd38kcsyGblzFvMe34w5YwsgCl
         bn3Hq+QdD2Ut5NKjrTlEJsmTsfv4Vu5UzHbGbOxkJKuQNczQTSE4cgW2P7TjsjDZBK5g
         lBiNpolo6eOSGXX91wITWDOShLOabsegPG4dZRzU2RL2FGL6cvq9rrHgFcRNoaBS3PDh
         4SUgzPuGopbz8rJKq39QmvIWgJh3HPN+bNycEWzKeIyxZUMo77Pk4qGc/zdpoxrm9Icy
         QOyg==
X-Gm-Message-State: AOAM533/yMe5a3zyjsiJ+4wq3qy8+aP0dxjLW9URwJnCNOHbnipqabEy
        /CYtUpsOodxgTg8esVyul/58ByM7oik=
X-Google-Smtp-Source: ABdhPJzZoqfXTR8DJX7/ovMs2z7Mq6EmglzQJrdy+1mfwhhenI60YKJCUMhDS5dDRiRHNtrl1MTkuQ==
X-Received: by 2002:a17:906:1b12:b0:6cc:fd05:a553 with SMTP id o18-20020a1709061b1200b006ccfd05a553mr2708579ejg.445.1645111785419;
        Thu, 17 Feb 2022 07:29:45 -0800 (PST)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id g6sm1300780ejz.170.2022.02.17.07.29.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Feb 2022 07:29:45 -0800 (PST)
Subject: Re: [PATCH 3/3] drm: omapdrm: Do no allocate non-scanout GEMs through
 DMM/TILER
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, tomba@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, merlijn@wizzup.org, tony@atomide.com
References: <1642587791-13222-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1642587791-13222-4-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <5b6d3e7f-c638-fdc7-5080-44d34abed610@ideasonboard.com>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <a3ed3a2c-86ce-1c85-e8aa-c08b54ad1a43@gmail.com>
Date:   Thu, 17 Feb 2022 17:29:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5b6d3e7f-c638-fdc7-5080-44d34abed610@ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.02.22 г. 14:46 ч., Tomi Valkeinen wrote:
> Hi,
> 
> On 19/01/2022 12:23, Ivaylo Dimitrov wrote:
>> On devices with DMM, all allocations are done through either DMM or 
>> TILER.
>> DMM/TILER being a limited resource means that such allocations will start
>> to fail before actual free memory is exhausted. What is even worse is 
>> that
>> with time DMM/TILER space gets fragmented to the point that even if we 
>> have
>> enough free DMM/TILER space and free memory, allocation fails because 
>> there
>> is no big enough free block in DMM/TILER space.
>>
>> Such failures can be easily observed with OMAP xorg DDX, for example -
>> starting few GUI applications (so buffers for their windows are 
>> allocated)
>> and then rotating landscape<->portrait while closing and opening new
>> windows soon results in allocation failures.
>>
>> Fix that by mapping buffers through DMM/TILER only when really needed,
>> like, for scanout buffers.
> 
> Doesn't this break users that get a buffer from omapdrm and expect it to 
> be contiguous?
> 

If you mean dumb buffer, then no, this does not break users as dumb 
buffers are allocated as scanout:

https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/omapdrm/omap_gem.c#L603

If you mean omap_bo allocated buffers, then if users want 
linear(scanout) buffer, then they request it explicitly by passing 
OMAP_BO_SCANOUT.

Ivo
