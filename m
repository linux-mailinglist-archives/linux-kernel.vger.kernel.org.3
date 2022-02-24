Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A9D4C218B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 03:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiBXCI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 21:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiBXCIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 21:08:24 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CAF2717C;
        Wed, 23 Feb 2022 18:07:53 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id x18so582508pfh.5;
        Wed, 23 Feb 2022 18:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Uv2rCp8QaBEfsJ8idQ0xOtWsAg2D33Aox4De34JFITE=;
        b=OtkOvAsDXiiIQwb0IXhNwjFB7mIU3sS9AVWAo4/DD8sy3AA+0favut4okIKw3WJ0BJ
         PUCLgD+3ZXT8J/qyxVdAa6G9CRxRnPtwePJ0847tAEZZ14Rccxk9KXnIyLdNNavtJA84
         VvqQBKp7KwTj/kn3lzJ99zfV4oU7xWo3UbXpQ0ckRUAONzrQB1Wg997imPpXPWfBjiTz
         LnMtn922TEplmI58N0QibruJTemqrt0TGKDHjXk3ChS7Ml0eUdu6gQWxjyzwPIoFysMT
         RUiHFv9degsnc2bv9BZcQogR3ISza5XzslXJbI2nPericPZWLVy2AT7Xo+dD5E58EYzY
         W0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=Uv2rCp8QaBEfsJ8idQ0xOtWsAg2D33Aox4De34JFITE=;
        b=0qNuV5X7YW94n3Ip56pbFiRQspv6cUTe8IsaDZLX4cihzTwcKVlgcf7sgUuEli3u5D
         J2AiRvONYpkWEieMChJmjSx8Ke4G/mn/xN1UqDlUrEdBinJSsxjxDs7Eg4RjkZaasawi
         VSkwCHKDR+WkLqDYnaV22GcgL1GasWNIFXfGWbkxNPY33eZi2nZUWFle93h5GSgRycOu
         jpdIOa5E8yPqgF8fvqWSKamzsr31tJ/pfruOSherPJGMo+uMSBQ7FLQYhtGSdEYeGAG0
         Q1/x+TsdpZrmpD0GrzgizPZAX8jfOxYt+8dWzId+LYVUn5jH4acoyi+vj4eUOTvNJcuS
         Tm8w==
X-Gm-Message-State: AOAM533Kjkp9uHgq3xMdWD6GCJUa491a1DqyyBWTzm2S5f4tExwFcyKU
        YdTH/WMwVF+KDMhko9E1Ek1TiYHQS30=
X-Google-Smtp-Source: ABdhPJwrZY3mxQAdKkSY1wspnRMI4eDzN1kUtRk5ug102s6I5QhQGcHfMNHYYYiNiucdcwqyT/FZZQ==
X-Received: by 2002:a63:1719:0:b0:373:9a4a:368d with SMTP id x25-20020a631719000000b003739a4a368dmr561321pgl.134.1645668473172;
        Wed, 23 Feb 2022 18:07:53 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id m19sm800659pfk.215.2022.02.23.18.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 18:07:52 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Feb 2022 16:07:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V4 1/6] blk: prepare to make blk-rq-qos pluggable and
 modular
Message-ID: <Yhbod7pJ1X4CGhEZ@slm.duckdns.org>
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <20220217031349.98561-2-jianchao.wan9@gmail.com>
 <YhUbCH+dhKkgMirE@slm.duckdns.org>
 <2e17c058-8917-4a37-896e-1093446339f6@gmail.com>
 <39db454d-ca30-fb42-3d72-899efa34fb78@gmail.com>
 <YhapCurbiI21WYmm@slm.duckdns.org>
 <efd94670-9d6d-5651-358c-2f88646298cd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efd94670-9d6d-5651-358c-2f88646298cd@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Feb 24, 2022 at 09:51:04AM +0800, Wang Jianchao wrote:
> The initial version of this patchset has two targets：
> (1) Add a sysfs interface to open/close the policy per device. Then we needn't
>     waste cpu cycles and memory if the device doesn't need the policy.
> (2) Make the policies modular, then it easy to maintain the code of policy in
>     production environment as we only need to close the policy and replace the
>     .ko file.
> 
> The loading module when open policy in sysfs interface is just to avoid modprobe
> manually. There is similar operation when switch io scheduler.

Each rq-qos mechanism already needs and has a way to turn off itself.
There's no reason to add another layer on top. If the current way of
disabling isn't efficient, we should improve that instead of adding a new
layer of interface on top.

And please don't add a custom interface to avoid modprobing. All it adds is
unnecessary deviation. There's no benefit to echoing a selector to a custom
sysfs file compared to explicitly modprobing it.

Thanks.

-- 
tejun
