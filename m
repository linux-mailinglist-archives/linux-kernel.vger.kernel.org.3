Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD745172C8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbiEBPlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbiEBPk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:40:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CBAE617A
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651505848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FtmrmbNbUodN8xBVKQQN7UAM6hiil8M4dt+c4wutNgM=;
        b=KlStS1Um7vOVhLUyP8+K+W5u9eeNHJITljpej/N3p0yM96uzpjESfv4tL3hE+fDaeFZuuX
        zASprmbdzyTIcRvdRNauiQqFa10uFlPoWdkYmBTI/RppXibx9w5Q2mX68r5i6Mx47PJMti
        6lbAKL42BQpwVY71a8mLJrq0LU5au9E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-hOm69-d2MQCvAGtnxcRnxA-1; Mon, 02 May 2022 11:37:27 -0400
X-MC-Unique: hOm69-d2MQCvAGtnxcRnxA-1
Received: by mail-ej1-f69.google.com with SMTP id oz9-20020a1709077d8900b006f3d9488090so5454339ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 08:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FtmrmbNbUodN8xBVKQQN7UAM6hiil8M4dt+c4wutNgM=;
        b=aL/2ClysDIuPrzgiGCyWPNUBYBDNBAvRi0UOK+PkRJAPb9o22aktFkKvPWlXIol17b
         3vREEveDx8IWF0F6oovC77L43Op/wGd2LuNAoKCiwdmnyyBMsQe1nygBLa/AkE/V93Sa
         aO51XOunaBa1EX6kn7WyIwfjaHO0nOLVJ+zSWg61wguAOsXl/2grOfRecb8r+uzfo3Iy
         AsHi2ZTsJoWYUyvDmjfMfixDytbm8oCi1/nX1VudrUJ3UjNckTrEhxNBXGi7uI8f58NV
         SkXrvko0q6eK4mZqwb4417m3tKEpwxFB9zA6ClXgzOX2Mjh6hW1jhHQps13m8asBmi3H
         edrw==
X-Gm-Message-State: AOAM530XVLv2rUX5DqtP5mGu5ggNLjcsPPQ4AvemqCNs/QJ49DPOfjn3
        an57KAEdsdsmBlk32ejzwfUlWuasKjj9n928JR4ksUE4Nv0Z7asHUUqdRtc4NVGKxihRcDpCn18
        9fIW9tScpBFK8UvpbmDFps2ka
X-Received: by 2002:a17:907:971f:b0:6f4:31b1:253 with SMTP id jg31-20020a170907971f00b006f431b10253mr7485981ejc.342.1651505845384;
        Mon, 02 May 2022 08:37:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIuTt3ysaaj/BM4Uq1MCtPQbwCm7mu5VlApoLhK181Tb/WKYTk5UAPU0d+JQxVnjsRcqygFQ==
X-Received: by 2002:a17:907:971f:b0:6f4:31b1:253 with SMTP id jg31-20020a170907971f00b006f431b10253mr7485965ejc.342.1651505845139;
        Mon, 02 May 2022 08:37:25 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id og10-20020a1709071dca00b006f3ef214dccsm3658047ejc.50.2022.05.02.08.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 08:37:24 -0700 (PDT)
Message-ID: <65d6f4e5-9c28-f57b-0d34-f827604e0709@redhat.com>
Date:   Mon, 2 May 2022 17:37:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] platform/x86/intel: Fix 'rmmod pmt_telemetry' panic
Content-Language: en-US
To:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        David Arcari <darcari@redhat.com>
References: <20220429122322.2550003-1-prarit@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220429122322.2550003-1-prarit@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/29/22 14:23, Prarit Bhargava wrote:
> 'rmmod pmt_telemetry' panics with:
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000040
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 4 PID: 1697 Comm: rmmod Tainted: G S      W        --------  ---  5.18.0-rc4 #3
>  Hardware name: Intel Corporation Alder Lake Client Platform/AlderLake-P DDR5 RVP, BIOS ADLPFWI1.R00.3056.B00.2201310233 01/31/2022
>  RIP: 0010:device_del+0x1b/0x3d0
>  Code: e8 1a d9 e9 ff e9 58 ff ff ff 48 8b 08 eb dc 0f 1f 44 00 00 41 56 41 55 41 54 55 48 8d af 80 00 00 00 53 48 89 fb 48 83 ec 18 <4c> 8b 67 40 48 89 ef 65 48 8b 04 25 28 00 00 00 48 89 44 24 10 31
>  RSP: 0018:ffffb520415cfd60 EFLAGS: 00010286
>  RAX: 0000000000000070 RBX: 0000000000000000 RCX: 0000000000000000
>  RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
>  RBP: 0000000000000080 R08: ffffffffffffffff R09: ffffb520415cfd78
>  R10: 0000000000000002 R11: ffffb520415cfd78 R12: 0000000000000000
>  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  FS:  00007f7e198e5740(0000) GS:ffff905c9f700000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000040 CR3: 000000010782a005 CR4: 0000000000770ee0
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   ? __xa_erase+0x53/0xb0
>   device_unregister+0x13/0x50
>   intel_pmt_dev_destroy+0x34/0x60 [pmt_class]
>   pmt_telem_remove+0x40/0x50 [pmt_telemetry]
>   auxiliary_bus_remove+0x18/0x30
>   device_release_driver_internal+0xc1/0x150
>   driver_detach+0x44/0x90
>   bus_remove_driver+0x74/0xd0
>   auxiliary_driver_unregister+0x12/0x20
>   pmt_telem_exit+0xc/0xe4a [pmt_telemetry]
>   __x64_sys_delete_module+0x13a/0x250
>   ? syscall_trace_enter.isra.19+0x11e/0x1a0
>   do_syscall_64+0x58/0x80
>   ? syscall_exit_to_user_mode+0x12/0x30
>   ? do_syscall_64+0x67/0x80
>   ? syscall_exit_to_user_mode+0x12/0x30
>   ? do_syscall_64+0x67/0x80
>   ? syscall_exit_to_user_mode+0x12/0x30
>   ? do_syscall_64+0x67/0x80
>   ? exc_page_fault+0x64/0x140
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>  RIP: 0033:0x7f7e1803a05b
>  Code: 73 01 c3 48 8b 0d 2d 4e 38 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fd 4d 38 00 f7 d8 64 89 01 48
> 
> The probe function, pmt_telem_probe(), adds an entry for devices even if
> they have not been initialized.  This results in the array of initialized
> devices containing both initialized and uninitialized entries.  This
> causes a panic in the remove function, pmt_telem_remove() which expects
> the array to only contain initialized entries.
> 
> Only use an entry when a device is initialized.
> 
> Cc: "David E. Box" <david.e.box@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: David Arcari <darcari@redhat.com>
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/intel/pmt/telemetry.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmt/telemetry.c b/drivers/platform/x86/intel/pmt/telemetry.c
> index 6b6f3e2a617a..f73ecfd4a309 100644
> --- a/drivers/platform/x86/intel/pmt/telemetry.c
> +++ b/drivers/platform/x86/intel/pmt/telemetry.c
> @@ -103,7 +103,7 @@ static int pmt_telem_probe(struct auxiliary_device *auxdev, const struct auxilia
>  	auxiliary_set_drvdata(auxdev, priv);
>  
>  	for (i = 0; i < intel_vsec_dev->num_resources; i++) {
> -		struct intel_pmt_entry *entry = &priv->entry[i];
> +		struct intel_pmt_entry *entry = &priv->entry[priv->num_entries];
>  
>  		ret = intel_pmt_dev_create(entry, &pmt_telem_ns, intel_vsec_dev, i);
>  		if (ret < 0)

