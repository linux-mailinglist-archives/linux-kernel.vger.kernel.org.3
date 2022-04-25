Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F330150E170
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbiDYNWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240630AbiDYNV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:21:58 -0400
X-Greylist: delayed 334 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Apr 2022 06:18:52 PDT
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88D6819C1B;
        Mon, 25 Apr 2022 06:18:52 -0700 (PDT)
Received: from [192.168.20.2] (unknown [77.239.252.99])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id CE6281401AA;
        Mon, 25 Apr 2022 13:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1650892397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NtMvqtWv7gKAIjVSrogMl1TwJ2S/Nzn3ITgo73M/4VU=;
        b=qA8EsmCX23eV9yoU59uUqUrWZCNGRa+SlrMMUxE16M/Asod97hVFwxb4iosyhKn1zfLCZT
        MBTK2hsffB7ym30XRxjjE1c0HdTagnkxTMAoIW1m/VpElg3MkZ84L40M8tZyL7aS1RlvM+
        ua0sNfBHbLwgYo1lZBJ+HMzSgFHciBc=
Message-ID: <b1c64333-c6a5-defd-ae27-0fb307647cb3@postmarketos.org>
Date:   Mon, 25 Apr 2022 16:13:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: dts: qcom: sdm660-xiaomi-lavender: Configure WLED
Content-Language: en-US
To:     Dang Huynh <danct12@riseup.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20220425032824.211975-1-danct12@riseup.net>
From:   Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <20220425032824.211975-1-danct12@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.04.2022 06:28, Dang Huynh wrote:
> WLED is used for controlling display backlight on this phone.
> 

Hi!

Interacting with wled changes brightness indeed, but results in the 
following trace in dmesg:

```
[  499.906317] ------------[ cut here ]------------
[  499.906478] Unbalanced enable for IRQ 39
[  499.910118] WARNING: CPU: 4 PID: 74 at kernel/irq/manage.c:774 
__enable_irq+0x4c/0x80
[  499.914094] Modules linked in:
[  499.921705] CPU: 4 PID: 74 Comm: kworker/4:2 Not tainted 
5.17.0-sdm660-07615-gd33d148796b0-dirty #23
[  499.924800] Hardware name: Xiaomi Redmi Note 7 (DT)
[  499.933988] Workqueue: events wled_ovp_work
[  499.938571] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[  499.942803] pc : __enable_irq+0x4c/0x80
[  499.949687] lr : __enable_irq+0x4c/0x80
[  499.953506] sp : ffff800008a73d70
[  499.957311] x29: ffff800008a73d70 x28: 0000000000000000 x27: 
0000000000000000
[  499.960890] x26: ffffad5f9fa4efc0 x25: ffff60283e4baf05 x24: 
ffff602781f65130
[  499.968010] x23: ffff60283e4baf00 x22: ffff60283e4b7180 x21: 
0000000000000000
[  499.975128] x20: 0000000000000027 x19: ffff602781136600 x18: 
ffffffffffffffff
[  499.982243] x17: 0000000000000000 x16: 0000000000000000 x15: 
0000000000000001
[  499.989363] x14: 0000000000000000 x13: ffffad5f9f92fea8 x12: 
0000000000000357
[  499.996479] x11: 000000000000011d x10: ffffad5f9f987ea8 x9 : 
ffffad5f9f92fea8
[  500.003597] x8 : 00000000ffffefff x7 : ffffad5f9f987ea8 x6 : 
0000000000000000
[  500.010714] x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 
0000000000000000
[  500.017832] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 
ffff6027820c8000
[  500.024954] Call trace:
[  500.047230]  __enable_irq+0x4c/0x80
[  500.062686]  enable_irq+0x48/0xa0
[  500.078190]  wled_ovp_work+0x14/0x20
[  500.093761]  process_one_work+0x1d0/0x320
[  500.105080]  worker_thread+0x14c/0x444
[  500.120700]  kthread+0x10c/0x110
[  500.136347]  ret_from_fork+0x10/0x20
[  500.151981] ---[ end trace 0000000000000000 ]---
```

-- 
Regards,
Alexey Minnekhanov
postmarketOS developer
https://www.postmarketos.org
