Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0212B4F091E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 13:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357049AbiDCLqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 07:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354322AbiDCLqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 07:46:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AAE240AF
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 04:44:54 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d10so3114137edj.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 04:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IZLmfYYiHMASMGiAaySluaKm3Ejc/bYH6rI1Fy0LecM=;
        b=pkHFF8vKDj0+bhl66MmU7CW3T++RKKps8T9B0LNFT0LjtxsV2/VWWxR7nF2BYj8kF/
         3BCIL4Dq8VPQbwilS9qWko4juT4O06Fq10ypwMkPKFxecmp4D3GcNYVxTBR+H/Sa+l0K
         qW6poCDQtwbqHtSiyZSKq5YvxVffCkqfkcrJMElwvr+8x++TjM15/hRNmwAhAysFPTDC
         L1UxxCAKXA8ugt6QyMc51q1qfpjQqXfoDZXZ7JCQJ7u0V4j4E+z+rUAifSdWKG5yt7Cl
         r0QKgoHu4jQkzIeDLPiOBsdGtuMC3FVM6jauv8VpLaAm5unZCq0rcwiEnwOINcFH64pm
         Q8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IZLmfYYiHMASMGiAaySluaKm3Ejc/bYH6rI1Fy0LecM=;
        b=B8HPKsmSK2UjGd93l/GBYQF9FHyZTjnkta/LTLsJK8yO6Hyr8ViL+RR6iMkeo/s5at
         fpwUCl2ItjmqRobfwAyiE9HvImz/a7n4jtA84sXn6qFia9hcNKzexH93l8IkMqi/G8ea
         1UrwdApr7y8cp/wFtgCQW9vNTF7Xmw1hzFhEM23YEugdvyHYvQn2KBaqVD5f14A+32C9
         zW3hRj3PoTcsehc07KsScxRRxKrvOlcWmKlusDRlK4FslG/ovkAZOqLsnsV6O/2Hs5XA
         cWSASWJGh579+RcR0aHUjCNwVyFkVlVLbezuAZQczdZszKudU6ojMXcPAAuPWfWD0oMA
         MBAA==
X-Gm-Message-State: AOAM531w7w6beInjGG8Sb7+WTW1KN+KZ/TniSQW3MF90RXlzN6Ri2QFl
        w2AypkjuGEBIwKBWFitbGMvO/JPNMMM=
X-Google-Smtp-Source: ABdhPJyebQIFACE7Zr/M6pV2MjsfmyEJEUN7XCMOOuJn14VZOlfBnhcMR2wstjmC10ZaJ+3T97Q0Hw==
X-Received: by 2002:a05:6402:1a54:b0:41c:cddb:3142 with SMTP id bf20-20020a0564021a5400b0041ccddb3142mr952751edb.106.1648986293319;
        Sun, 03 Apr 2022 04:44:53 -0700 (PDT)
Received: from [192.168.0.253] (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id kw5-20020a170907770500b006db075e5358sm3095226ejc.66.2022.04.03.04.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 04:44:52 -0700 (PDT)
Message-ID: <6250c266-f00b-6062-9864-ef78d5c4a04b@gmail.com>
Date:   Sun, 3 Apr 2022 13:44:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: staging: r8188eu: how to handle nested mutex under spinlock
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
 <942bbcb6-725d-9b47-5dfe-f105d30ea6b7@gmail.com> <7365301.EvYhyI6sBW@leap>
 <3097543.5fSG56mABF@leap>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <3097543.5fSG56mABF@leap>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/22 13:24, Fabio M. De Francesco wrote:
> [PATCH 5.10 67/99] tty: n_hdlc: make n_hdlc_tty_wakeup() asynchronous
> https://lore.kernel.org/lkml/20211220143031.649396763@linuxfoundation.org/
> 
> I hope it helps,
> 

Thank you for the link. :)

thanks,
Michael
