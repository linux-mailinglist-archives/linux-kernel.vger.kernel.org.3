Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CDA502F2B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 21:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiDOTTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 15:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiDOTTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 15:19:51 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A10349C80
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 12:17:22 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id w23-20020a056830111700b00603c6d1ce73so1893084otq.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 12:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PdIDFGQW4UYiVf0M69peoSmdiojSEaqNuqBV2NqZc8U=;
        b=0BVtvbGjVzsjRc+2SRZo6FtQuKRHY0bMFiXstc0wjsPiOk9WCBEGmJBfKuqAeGof45
         gpVDYqx32IFNfcTzBnn5cmZHoNgFQXCjq3eUHdjkvnIh/1xTI6r8WMhPytEUjT6uLYLJ
         cExJu5uJ0tdB6kjwdbK4Um6lTlZtKF62leIkSvASocAuXi20DEQFaqFdYwqHmzgeTSJL
         EekXUfNNzLHhW3+ARTGLRbGhQAG4qLidXgubjdDELCqmJYGfghXaLulX3paNl4nmI/M1
         YLOnsZLjHZYAAh0zt5EGwOZ7QQEUW0b1rfibLnT9dMZleNB+b9Hby1YoCoXi5gI5i+UY
         Jukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PdIDFGQW4UYiVf0M69peoSmdiojSEaqNuqBV2NqZc8U=;
        b=rXsZ4Lbo/HCyKhZ/uFv9x5N8BMZm8tuuPXLZfndrIxRmI047hbTV7pt7Zq5VAgjC1D
         Twc9qYrCA1WFYBi6frvBXVs7JXTH6WxeEDcq+GrhhOA8FK9xMmp4tp/k0UJxG5RPVXVn
         9F5bsRj7ICJzWV9tAzAfKgZzvBf9SOieFHDd0gVL3uxjRLbUEqrZstorqGVgzQdwAMUs
         10yvzShVT5ZUcCr3yw74m/b7orcdbG+Wo+RB9ySxdvvGiMIvK65WGQGY+mamIMJgLyom
         PPNFBmkyFg8gK87MvzKmkR/HcjOtrzrWU3A6HjvkaKKbfkN2Z63lBpKqCc45U+RT7qbf
         gkog==
X-Gm-Message-State: AOAM533tl2lqSwcvG83sHsjnwWloA0HZS2VDSIW/XY1P3NxNPmu56LHi
        D9ap4rlFli/ET9uWnNCDbr+fgw==
X-Google-Smtp-Source: ABdhPJwufc9Dw5netOvXCeF2GG9ESvEIF+T2ecye6tMC450yb9o/WVAtW1iX7f2vcwiYoZEUnqk7kg==
X-Received: by 2002:a9d:6503:0:b0:5e6:d8b6:f684 with SMTP id i3-20020a9d6503000000b005e6d8b6f684mr198853otl.289.1650050241494;
        Fri, 15 Apr 2022 12:17:21 -0700 (PDT)
Received: from [192.168.86.188] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id eq37-20020a056870a92500b000c6699dad62sm1949141oab.41.2022.04.15.12.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 12:17:20 -0700 (PDT)
Message-ID: <76a7b33d-6f8b-e660-c64d-027b1bc8e308@landley.net>
Date:   Fri, 15 Apr 2022 14:21:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] sh: make !MMU iounmap an inline function
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     kernel@axis.com, hch@lst.de, kernel test robot <lkp@intel.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220414081257.1487499-1-vincent.whitchurch@axis.com>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <20220414081257.1487499-1-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 03:12, Vincent Whitchurch wrote:
> The current definition of sh's !MMU iounmap makes it unusable in certain
> kinds of code, such as this instance caught by 0day on a patch posted to
> the mailing lists:
> 
>  In file included from include/linux/io.h:13,
>                   from drivers/mtd/devices/phram.c:21:
>  drivers/mtd/devices/phram.c: In function 'register_device':
>  arch/sh/include/asm/io.h:274:33: error: expected expression before 'do'
>    274 | #define iounmap(addr)           do { } while (0)
>        |                                 ^~
>  drivers/mtd/devices/phram.c:150:44: note: in expansion of macro 'iounmap'
>    150 |         cached ? memunmap(new->mtd.priv) : iounmap(new->mtd.priv);
>        |                                            ^~~~~~~
> 
> Make it an inline function as it was earlier.
> 
> Link: https://lore.kernel.org/lkml/202204131446.omJ5mC54-lkp@intel.com/
> Fixes: 13f1fc870dd747131 ("sh: move the ioremap implementation out of line")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Tested-by: Rob Landley <rob@landley.net>

Worked For Me.

Rob
