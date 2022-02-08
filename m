Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE5F4AD711
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359520AbiBHLbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiBHKzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:55:42 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0813EC03FEC0;
        Tue,  8 Feb 2022 02:55:42 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id i30so18189068pfk.8;
        Tue, 08 Feb 2022 02:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=sWE38xa95W+xhxHgrq7WzsZ2vv/Ie+VkpJNorAGjDbg=;
        b=pl2KrerUPO7MVE2mHCZefx2Cu4UZm40ckE4roweTe44c4Ba20GwJgU1rTKso9u6o2M
         Kj3sbpYEtJt4vQQewuqFXCPntHNfgIjnnjOGwmasAEudNDqcpfQ+kkfBlpHs2u5eVDM9
         2o7krHmcBdbWj5VIOdLbo+N8O+Oo4bslLwDmrHVgLP76c1DSwPNr60Q4iLlxUqaMVl8x
         sYhks3hdQEVr0uo7ZQW+08cLx9omr0tfW1W3mxhZZlix82+kKoKxjYaiylZKwt5u6BZm
         nv70sxkFlTdmMcEC8Ds+KF9wMOruXjUJ/onhU0oV7Bx6J7F7/3x1pPT41IFJwRO2m8WC
         bKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=sWE38xa95W+xhxHgrq7WzsZ2vv/Ie+VkpJNorAGjDbg=;
        b=3xtatWAKpkg85YtREj0I9cHFYNIP3TqahqugDrVLthe5i1QrLQTGqZivQ4Nnq+uLHZ
         fiP3P14qidGGUuNHV25ianpeh0zXC9QHe5bxFXCrjHahl5Eol8BcyP0yOxbSQPXG6tUB
         /qzImL4d/njhex/QkTih6HZNsHMDJvZSX7mjldLDKI/viY5li9d73yvt6aP2Wqe+NP6t
         DDKhXBlLn0NQ8+nqj7vqpsgQOVE/hXAKe9VJf947R4426l/qnesQYdKYqkbJvioIqw+9
         Gaq7W3raaX75XrJqBYlaySZ0hZsK4OGVaXhEW1VaJp+p8M24Nx4ZXxWx592NAqMvodxR
         A+rA==
X-Gm-Message-State: AOAM532zwAVUlMz3Ca3ZdcxbINOdDYUoZBxWgPIw0N+hZsm+rZ32Kblr
        hfxZ64+WbcnbT6xPJpjJPnzx0+aSHjA=
X-Google-Smtp-Source: ABdhPJzDfm/XaP31aWpiNpsnafHmrMc0SBrpe7htyOBDrSByBdrMOLx1+2RuXa1fzkZlUAECj3XIAw==
X-Received: by 2002:a05:6a00:c94:: with SMTP id a20mr3833402pfv.41.1644317741126;
        Tue, 08 Feb 2022 02:55:41 -0800 (PST)
Received: from [192.168.1.100] ([166.111.139.99])
        by smtp.gmail.com with ESMTPSA id lk8sm2489742pjb.40.2022.02.08.02.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 02:55:40 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] block: drbd: possible deadlocks involving waiting and locking
 operations
To:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <3b992e3b-bf1a-426a-5e76-a822f5bf6e6a@gmail.com>
Date:   Tue, 8 Feb 2022 18:55:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My static analysis tool reports three possible deadlocks in the drbd 
driver in Linux 5.16:

#BUG 1
drbd_adm_attach()
   mutex_lock(&adm_ctx.resource->adm_mutex); --> Line 1810 (Lock A)
   wait_event(device->misc_wait, ...); --> Line 1824 (Wait X)

drbd_adm_disk_opts()
   mutex_lock(&adm_ctx.resource->adm_mutex); --> Line 1582 (Lock A)
   get_ldev()
     get_ldev_if_state()
       _get_ldev_if_state()
         put_ldev()
           wake_up(&device->misc_wait); --> Line 2108 (Wake X)

#BUG 2
drbd_adm_invalidate()
   mutex_lock(&adm_ctx.resource->adm_mutex); --> Line 3024 (Lock A)
   wait_event(device->misc_wait, ...); --> Line 3030 (Wait X)

drbd_adm_disk_opts()
   mutex_lock(&adm_ctx.resource->adm_mutex); --> Line 1582 (Lock A)
   get_ldev()
     get_ldev_if_state()
       _get_ldev_if_state()
         put_ldev()
           wake_up(&device->misc_wait); --> Line 2108 (Wake X)

#BUG 3
drbd_adm_invalidate_peer()
   mutex_lock(&adm_ctx.resource->adm_mutex); --> Line 3101 (Lock A)
   wait_event(device->misc_wait, ...); --> Line 3107 (Wait X)

drbd_adm_disk_opts()
   mutex_lock(&adm_ctx.resource->adm_mutex); --> Line 1582 (Lock A)
   get_ldev()
     get_ldev_if_state()
       _get_ldev_if_state()
         put_ldev()
           wake_up(&device->misc_wait); --> Line 2108 (Wake X)

When drbd_adm_attach()/drbd_adm_invalidate()/drbd_adm_invalidate_peer() 
is executed, "Wait X" is performed by holding "Lock A". If 
drbd_adm_disk_opts() is executed at this time, because "Lock A" has been 
already held, "Wake X" cannot be performed to wake up "Wait X", causing 
possible deadlocks.

I am not quite sure whether these possible problems are real.
Any feedback would be appreciated, thanks :)

Best wishes,
Jia-Ju Bai

