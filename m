Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC1959B673
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 23:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiHUVj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 17:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiHUVjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 17:39:53 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F63C1E3FD
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 14:39:52 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id x15so7775254pfp.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 14:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=TBTta4D/RBg6tfd42bSdioiS4BURRGR92bmrXX7PSxk=;
        b=a+AAAAGlxNu0iSrh8ke0N/QwPo3tadXJSGg+6ovsQm86s8uR7Ln6f2FINygfc2rmI1
         tjnpaX+Et9HEMiJb3vG2AVL31eFJ+xZPmUxJMjLBBD3OCX9aZpRuLCySR5dEQEUtXW1K
         bpLenT1NQCjgxBnPOQiRoDtMenL2Lp4UrovEhkz3axujoE+SWn81FCFGfA1+i4eWML3O
         TkHU7s6PPBohXsJZB+xfFK+68XudtOqtX+N6Oa2IPV0y7tbOtGcljP5ssvnnoXcXCvjO
         pyKVuQB8zFzglbwoJrL6hBgmIbs9/8BQWLsUADrmJFX1mL0/yLGY7xpoIh9ezETZhjzH
         iowg==
X-Gm-Message-State: ACgBeo2sFD+M5s+1IurG3Y5mbJ2PdXXsUtwTbfNnAhoZ/RgxQycNm+TQ
        2iwM1eJFiNpW/HIxTN4U5wgcPtSiLLE=
X-Google-Smtp-Source: AA6agR7jBOTXtAvQb55RQQdijz5f57/iDe1kqGfzCOx66Nn9Fu6G2GOy8remsvcztaKAOyV13OWctw==
X-Received: by 2002:a63:445a:0:b0:42a:306e:5e30 with SMTP id t26-20020a63445a000000b0042a306e5e30mr12115659pgk.40.1661117991746;
        Sun, 21 Aug 2022 14:39:51 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902a3c700b00172bf229dfdsm5189073plb.97.2022.08.21.14.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Aug 2022 14:39:50 -0700 (PDT)
Message-ID: <27d0dde8-344c-1dd0-cc26-0e10c4e1f296@acm.org>
Date:   Sun, 21 Aug 2022 14:39:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] driver core: Fix bus_type.match() error handling
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Isaac Manjarres <isaacmanjarres@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Saravana Kannan <saravanak@google.com>, stable@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org
References: <YvvQOBk9T3J1uX8k@google.com>
 <20220817010559.GA1880847@roeck-us.net> <YvxAfiSOrzy7/c1J@google.com>
 <20220818225932.GA3433999@roeck-us.net> <Yv7bd6Yl8+thp2CY@google.com>
 <20220819112832.GA3106213@roeck-us.net> <Yv/MKymRC9O04Nqu@google.com>
 <baa1f65a-d983-0518-3979-7099679995f2@acm.org>
 <20220819220841.GA3230067@roeck-us.net>
 <12b231ea-dc7d-bb09-3986-32a07a63acd4@acm.org>
 <20220820114801.GA3958319@roeck-us.net>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220820114801.GA3958319@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/22 04:48, Guenter Roeck wrote:
> INFO: task init:283 blocked for more than 122 seconds.
>        Tainted: G                 N 6.0.0-rc1-00303-g963a70bee588 #3
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:init            state:D stack:    0 pid:  283 ppid:     1 flags:0x00000000
>   __schedule from schedule+0x70/0x118
>   schedule from scsi_remove_host+0x178/0x1c4
>   scsi_remove_host from usb_stor_disconnect+0x40/0xe8
>   usb_stor_disconnect from usb_unbind_interface+0x78/0x274
>   usb_unbind_interface from device_release_driver_internal+0x1a4/0x230
>   device_release_driver_internal from bus_remove_device+0xd0/0x100
>   bus_remove_device from device_del+0x174/0x3ec
>   device_del from usb_disable_device+0xcc/0x178
>   usb_disable_device from usb_disconnect+0xcc/0x274
>   usb_disconnect from usb_disconnect+0x98/0x274
>   usb_disconnect from usb_remove_hcd+0xd0/0x16c
>   usb_remove_hcd from host_stop+0x38/0xa8
>   host_stop from ci_hdrc_remove+0x40/0x134
>   ci_hdrc_remove from platform_remove+0x24/0x54
>   platform_remove from device_release_driver_internal+0x1a4/0x230
>   device_release_driver_internal from bus_remove_device+0xd0/0x100
>   bus_remove_device from device_del+0x174/0x3ec
>   device_del from platform_device_del.part.0+0x10/0x78
>   platform_device_del.part.0 from platform_device_unregister+0x18/0x28
>   platform_device_unregister from ci_hdrc_remove_device+0xc/0x24
>   ci_hdrc_remove_device from ci_hdrc_imx_remove+0x28/0xfc
>   ci_hdrc_imx_remove from device_shutdown+0x178/0x230
>   device_shutdown from __do_sys_reboot+0x168/0x258
>   __do_sys_reboot from ret_fast_syscall+0x0/0x1c

Hi Guenter,

Thank you for having shared this information. I think this deadlock is 
the result of holding a reference on /dev/sda (by the mount() system 
call) while calling scsi_remove_host().

It seems wrong to me that ci_hdrc_imx_shutdown() calls 
ci_hdrc_imx_remove() - I think that function should only do the minimum 
that is required to prepare for shutdown instead of calling 
scsi_remove_host() indirectly.

That being said, the patch series "scsi: core: Call 
blk_mq_free_tag_set() earlier" probably will have to be reverted because 
of the following deadlock reported by syzbot: 
https://lore.kernel.org/linux-scsi/000000000000b5187d05e6c08086@google.com/

Thanks,

Bart.
