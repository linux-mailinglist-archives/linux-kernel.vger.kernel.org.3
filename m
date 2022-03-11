Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4C74D5D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbiCKIl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237503AbiCKIlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:41:24 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105411BA15E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:40:22 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id q13so7120963plk.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wwuk7jbsEHLeFz6+/LJoj/dUalVItLfs+0Q0dolP684=;
        b=AscHYslyW40mq2rObPXzCvGCX+EoUScZoojvmNC7ldKXcJk1h/Wj4jkAA9eDsVibbI
         wxtr9ieSMsc3g4KK+YNxI2L/I3k2J23Mn5cM9TgxWRW63yA8Y2T8Rd25fya+t/TUcdPC
         VBjSu5sY9Fsk6jfHKGhnq3zE0I1Jx9eU32Gy7/QJX6n5GHWeV+s5xyFcXBpAgctZ9e1j
         OnR5wMfeeJKau5C053ouHlcQER6qodF9fPvhK1XQ0qAd13Zq02C9ImJXa5cpq+NPU0w3
         kp7JWxA6DUPLTpwKpcQNtp4/AT4fx2516iKJtjXHUNDOBHYHzvM7wcw8jcYakE50ZUoA
         +JYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wwuk7jbsEHLeFz6+/LJoj/dUalVItLfs+0Q0dolP684=;
        b=DQDdZB8EMlkyOgfMbTYoaADHokLRs2tRhtz9oXrIGacmp+KlYn2jng46vG1gn6tGZ+
         fk64ARtoVq9fAjYW36qHreUOmwN6FjZjHz1leYCpqUsVnAis/oQFVSryqYeW5peV9ASu
         2QUKG4fd5H9GA0aquDC2hcFt16jS/sockCTiO2gzi7ierRboiCF0ZAo9+VrUqQLCo4NW
         1JK/7twfJOEws/yCYbjmGmfkSAFZGAVZpUE8XUR2ZE6a1AhzOXRUKRxpkzwdWNjFTTjp
         hwQJj7qwx8mnh/wNPZH48MSRHTsgpkOoWVibaEFipDPP+hhQ3ZviIpSs+twPiFEUipob
         BjNw==
X-Gm-Message-State: AOAM530o994Bn55q3I3oLluf/rrKsm9nDoy569xwbYM4Bh8ie4+Vfc+H
        /pvHhLOk8ZfFq6M3+SZ0MVyx0Id+ahD0Sw==
X-Google-Smtp-Source: ABdhPJwMI9VDRfAs/35Zo71vuqOBm7lSCHJlhIDhSpWXI0sH8nY+eBpFvl4Zco19ACPc6BMoC1S5XA==
X-Received: by 2002:a17:90a:9294:b0:1b9:48e9:a030 with SMTP id n20-20020a17090a929400b001b948e9a030mr20436733pjo.200.1646988021602;
        Fri, 11 Mar 2022 00:40:21 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id m11-20020a056a00080b00b004f791d0115esm1119613pfk.171.2022.03.11.00.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 00:40:21 -0800 (PST)
Date:   Fri, 11 Mar 2022 14:10:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Fix potential NULL dereference
Message-ID: <20220311084019.w45kfluiamgosivu@vireshk-i7>
References: <1646987730-7597-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646987730-7597-1-git-send-email-baihaowen@meizu.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-03-22, 16:35, Haowen Bai wrote:
> Fix following coccicheck warning:
> drivers/staging/greybus/bootrom.c:301:35-39: ERROR: fw is NULL but dereferenced.
> 
> When goto queue_work but dereference Uninitialized fw will trigger a NULL 
> dereference.

Please have a look at earlier attempts like this:

https://lore.kernel.org/all/2015099.xVv48VzNit@linux.local/

-- 
viresh
