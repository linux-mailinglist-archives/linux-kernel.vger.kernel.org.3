Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C304C1133
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239839AbiBWLYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239834AbiBWLYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:24:21 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FD490243
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:23:54 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id w27so12698571lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Ksde3dsjmZ6z4W3gPyFM7vvXyQW8lLSnM2Jx+bGn6kA=;
        b=oqNk7Gve/MBzDonLtAobtwDjoEKRBkZPObrM2miHQMA0eVwjUOtkpcqcY+KMAlYJb0
         Q0f13poP5DocypMJrLMijaQrCbYln5K0k2ozEs3uAwnxF2cnn03NXg4HsdC2PqwpVDHK
         7KFdX9aUzpr55224jFG5fbuE6ZpFGVMX4RUlp0Jvk5URntPid/KjV7WJ+1wQP153ZRAt
         Sab2YQcK/tXCe2PKbqgHk4rea9q/clZfcaw83zZfz6KYH8KaiRcACdn0wR4xdsmDR9Yp
         q3VNXa9kDi6KUgIiW3Lauw585xyrdoa4pmb5+ma/tBkjDLv6PO8auBiQcKKi3gn6cDWn
         A5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ksde3dsjmZ6z4W3gPyFM7vvXyQW8lLSnM2Jx+bGn6kA=;
        b=HSxLTt6pcRVtRIrA8QN2zU+aGZPFinP1sWhdEEIyIFojnc4CQz7y28b5udJuLqq5sg
         H2CARH+vZnnjMzvq4W8lWlOrVRikmH5NClEQiTuWzHgdtTChoHFvThf0xU0oBarqsxob
         EAhCH6Ntbpm17mRRyavXyf4xMp7Xr2D6fTGHnyW/oectc16QyyIgbLlUmlHK9nPjIW+D
         kmdNdPt9E3vAjmfvbxhcmJPi1vncI9NZdkwzF87AJY8ZTgdc8ezCD2lMLNj70sQiwhT+
         lHMECjf9epiN0Ywq4W/N0TyKTm/sfdr4SRn7yaxtlWT9xqvUacEGfLPXj7Nsm39VJEkQ
         Y7Ng==
X-Gm-Message-State: AOAM532J0qoQ+VjdZt8EeLExbBRRiYojvBIoCnlSlHzA40VvF1iIk/Si
        K3D6S+IOrHTfP9/Y5601INU=
X-Google-Smtp-Source: ABdhPJzAkuIKdRdFUWMkvs/cSSbMToLzFChYvkaVltRouzRSHurrG7FpbGOHDWdVE8GfpXbztNYktQ==
X-Received: by 2002:ac2:554d:0:b0:443:6539:a299 with SMTP id l13-20020ac2554d000000b004436539a299mr20663855lfk.552.1645615432696;
        Wed, 23 Feb 2022 03:23:52 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.64])
        by smtp.gmail.com with ESMTPSA id b8sm1623929lfv.298.2022.02.23.03.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 03:23:52 -0800 (PST)
Message-ID: <81102f38-3e1f-ec36-3119-a098bd5a85c4@gmail.com>
Date:   Wed, 23 Feb 2022 14:23:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [syzbot] KASAN: use-after-free Read in dev_uevent
Content-Language: en-US
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        syzbot <syzbot+348b571beb5eeb70a582@syzkaller.appspotmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
References: <0000000000005a991a05a86970bb@google.com>
 <00000000000033314805d8765175@google.com>
 <PH0PR11MB58805E3C4CF7D4C41D49BFCFDA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <PH0PR11MB58805E3C4CF7D4C41D49BFCFDA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qiang1,

On 2/23/22 14:17, Zhang, Qiang1 wrote:
> 
> Cc: Alan Stern
>         Felipe Balbi
> 
> Hello syzbot, Please try it:
> 
>  From 574d45ff924e2d2f9b9f5cc3e846f8004498a811 Mon Sep 17 00:00:00 2001
> From: Zqiang <qiang1.zhang@intel.com>
> Date: Wed, 23 Feb 2022 18:18:22 +0800
> Subject: [PATCH] driver core: Fix use-after-free in dev_uevent()
> 
> In dev_uevent(), if the "dev->driver" is valid, the "dev->driver->name"
> be accessed, there may be a window period between these two operations.
> in this window period if the "dev->driver" is set to null
> (in usb_gadget_unregister_driver function), when the "dev->driver->name"
> is accessed again, invalid address will be accessed. fix it by checking
> "dev->driver" again.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>   drivers/base/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 3d6430eb0c6a..a45b927ee76e 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2317,7 +2317,7 @@ static int dev_uevent(struct kobject *kobj, struct kobj_uevent_env *env)
>                  add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
> 
>          if (dev->driver)
> -               add_uevent_var(env, "DRIVER=%s", dev->driver->name);
> +               add_uevent_var(env, "DRIVER=%s", dev_driver_string(dev));
> 
>          /* Add common DT information about the device */
>          of_device_uevent(dev, env);
> --
> 2.25.1
> 

you should use '#syz test' command to ask syzbot to test the patch. 
Basic syntax is '#syz test: <git tree> <branch or sha>' and syzbot will 
apply attached patch (if you have attached it)


More about syzbot interactions here [1].

[1] 
https://github.com/google/syzkaller/blob/15439f1624735bde5ae3f3b66c1b964a98




With regards,
Pavel Skripkin
