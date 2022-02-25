Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF684C483A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiBYPBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiBYPBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:01:42 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDC71E4810
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:01:09 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D33523F1BC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 15:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645801267;
        bh=FkU2gOdn2xGABSYHRUy35muG2CC0vuUozeaWL5Zy+WY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=dtv7rP6259AZ1SHyhvaSzl7Mg/6M+VFnTzxtfRTezR6xOJkIdSOrv4bINeiDL7gwK
         ufP/+DdwK0P0AP+zn3/YAc1fNihnLHLTf3vG8ZLWCxQTlDOZOAFY2mkHsfI46ldn1n
         FsneRVdi0N9Vsrf/nx5ijkz+rTPOs5oy7HwV+M7ht86maMxoYu5qJRDVfKPo/ZZR2w
         w9ZegY0OwOvbaKIsfphmdqSUutPuaYwM3zanf08JkwQg+QhaXhI5/whQIxI9WT0WDU
         4JH+5/GX5umSWI8ugHFey4ITfZCe0Iqw+lpdOp8BNAgk+XGjI++40oOafNYgSuNXyZ
         5+GBGw1Y54Mjg==
Received: by mail-wm1-f70.google.com with SMTP id ay7-20020a05600c1e0700b003813d7a7d03so621656wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:01:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FkU2gOdn2xGABSYHRUy35muG2CC0vuUozeaWL5Zy+WY=;
        b=gvG/xybj41329SUQCl9Ht4N57Je0X0lSSeRALG5UcHQFkPq1kaSL4fDsaf3KDCdwbD
         CShaodSiDjQbBrVyFQM9ZfGWzfNFnKpee7pszo7eAJVbDg9QrvX2ETpKhjJXYqLCfkuC
         bCva1tLVUOGq2oCCYvJJCXA1a5DyaY3xGYYeCC7QyeaoI1Fck4LNArx0Fj6TbRcovFdx
         37yYFitWEKyh6slziA2CpIvQYMbgf/JMhkAB90n+e5zcVvhUtF4s4/Rp6ZanoMckhMai
         mgxIgbKk2ATa6TYXN1T7614RcG8EFHGHblqng+//OazvYWtPa/Y7LEuR1z6d92AzVXYa
         MuHA==
X-Gm-Message-State: AOAM530RSOX+Tea6y020r72MNMxZokcUx7HJtwwc9qyu92Y7wi0xXQeR
        oAXkHqcdVaRZxm6GiEFI481uvXPlUALg8sy0Pg+VN4AFTUo4d09IdYavo4LEzWeH8aZBwlKQXY+
        iGd2/0hTg4c9M+Ul+KlnXfuDL78p8WgavmMkIG9DXQA==
X-Received: by 2002:a5d:5302:0:b0:1ed:e1d2:f0fd with SMTP id e2-20020a5d5302000000b001ede1d2f0fdmr6610777wrv.585.1645801266882;
        Fri, 25 Feb 2022 07:01:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxN1+UNzBg/eC7kDf7ekQci8yZiV5FtBTZawvHTK83D4OV89DFOny0v4a9sH8j5mmEhULnVZw==
X-Received: by 2002:a5d:5302:0:b0:1ed:e1d2:f0fd with SMTP id e2-20020a5d5302000000b001ede1d2f0fdmr6610760wrv.585.1645801266664;
        Fri, 25 Feb 2022 07:01:06 -0800 (PST)
Received: from [192.168.0.132] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id k26-20020a05600c1c9a00b0037bdeaf5d30sm3000004wms.36.2022.02.25.07.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 07:01:05 -0800 (PST)
Message-ID: <546b11fe-5eb6-03f0-63c5-881c9d4a293c@canonical.com>
Date:   Fri, 25 Feb 2022 16:01:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] memory: emif: check the pointer temp in
 get_device_details()
Content-Language: en-US
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, ssantosh@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220225132552.27894-1-baijiaju1990@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220225132552.27894-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2022 14:25, Jia-Ju Bai wrote:
> The pointer temp is allocated by devm_kzalloc(), so it should be
> checked for error handling.
> 
> Fixes: 7ec944538dde ("memory: emif: add basic infrastructure for EMIF driver")
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>

I cannot find this report. This is an open source work and public
collaboration. The “Reported-by” usually means that the issue was
reported. Usually in public. Can we see the report?


Best regards,
Krzysztof
