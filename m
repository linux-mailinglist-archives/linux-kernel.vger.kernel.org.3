Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65EB584BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbiG2Gap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbiG2Gam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:30:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7F36171F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:30:40 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ss3so6790647ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bWSzqeEFY473AbdSEUh9RG/IE8UaIJYtfYVbaWkdYLI=;
        b=Wj6z8JseaJL8shZrXFYt9zLi8frLlWM7VjSpt8ww4nN/PTi7fMQtSunYnSvW5IJJco
         n4nbWOvksWH91xNv9Cz+P3ZTMdxyen7JrPlO2p5p49Ho7M8ZvFXM4JMFD8SxZtGD0mj2
         mnK3VuVfyhrZc7D6SlEb/uy54GLUFIKRPD0W4SpbPKFe/zsrqf79RvwR/B2GadalG61g
         4kEr6GJxZIBX4XfzfId4qcpTUGuEhoqVIk7+xmBPo8ia8apUVKm1Zl6mykaQfkcUY5QT
         LXDQuN+yy3zf3XdOXUhx6oNd8EN49WZRTU7oLW0V/iyIxWirTnxjUzo3GF8LLZMBXIfx
         B6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bWSzqeEFY473AbdSEUh9RG/IE8UaIJYtfYVbaWkdYLI=;
        b=EOsUNbgXoBv8W0a+79CG/0ecNS/60HLDGhNyR/sxXSbnQHD/MZt/sOCgFVIjVtQh+H
         ISG+0la9jWcfQg6iurw3hUqRyRaTB08PaSV/N9RyGuvcHYF8+3Cylwnm/8Mt5bRhUnbp
         6z7Urj4bOdePzU9MwkDS/V2cW7fIHMDcN8vJ/pI5ETXT1lmvUh4QuiXwfymJuHepz9r6
         BBXD1BBV7ygqZWZYlue62Jj+J5sziPfrXhg0HZ8+cLZp3wuNSBL0GkZvBW45HMc0O+By
         ogz/Ynu0+PseRQ3ZD9f2oqW+EAH38rK2rnpV24yIym+J5Kbvqr4Esu4TF1b+uuUofh4a
         BVtQ==
X-Gm-Message-State: AJIora8k5DXyfP2piM03FyLcNWBCBmIAjBXhE0oR7+DpSSeddJWm322o
        /3skSQUNbI1Xih2Efn43SFyhMg==
X-Google-Smtp-Source: AGRyM1tXSeZepdVJUwVji9mBkqKmaR2txlk7uUtwvQR5UHYc18vHGUX5u160UpPWMkXHv48FY6QMKg==
X-Received: by 2002:a17:907:2889:b0:72b:50c8:c703 with SMTP id em9-20020a170907288900b0072b50c8c703mr1719190ejc.694.1659076238249;
        Thu, 28 Jul 2022 23:30:38 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id kz21-20020a17090777d500b0072b6d91b056sm1289871ejc.142.2022.07.28.23.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 23:30:37 -0700 (PDT)
Date:   Fri, 29 Jul 2022 08:30:35 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Li zeming <zeming@nfschina.com>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/net/act: Remove temporary state variables
Message-ID: <YuN+i2WtzfA0wDQb@nanopsycho>
References: <20220727094146.5990-1-zeming@nfschina.com>
 <20220728201556.230b9efd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728201556.230b9efd@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Jul 29, 2022 at 05:15:56AM CEST, kuba@kernel.org wrote:
>On Wed, 27 Jul 2022 17:41:46 +0800 Li zeming wrote:
>> The temporary variable ret could be removed and the corresponding state
>> can be directly returned.
>
>How many case like this are there in the kernel?
>What tool are you using to find this?
>We should focus on creating CI tools which can help catch instances of
>this pattern in new code before it gets added, rather than cleaning up
>old code. It just makes backports harder for hardly any gain.

What backports do you have in mind exactly?
