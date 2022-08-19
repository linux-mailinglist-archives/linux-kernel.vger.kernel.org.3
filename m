Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5737959A6CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351480AbiHSUBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiHSUBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:01:34 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DC2C2E91
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:01:33 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso5798056pjh.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=18pRZIOLjEtmIICsoeTLcQwS7bT2ZifIcBeO5f96LPw=;
        b=NPi+L9heFp2rFXdmIib+qp0r0vKXTQ/CcjGJlmA5zFnHGU9DfLGm4ON0XpRYjoslrS
         wUWS11xJsT9EUujYGDjXSMYj2rSf/4prAgkRdq6ugPio3tWmyul+sbSNi30mI0DvSF9f
         0xCWEQnSF/ndP/jAFOirMriTatMd5Xlxld7Mj+YbXXPxbKs7tDZbXwzzrcrK9njqeQvw
         8t1V5i/naMU3ZtlHUx2B3K4uuxkGrge0h3HLT3TFcrUZNeXQY7AbGKasj1V4R4BCc9fR
         2/mXs4/XdhAe6hjvhmkVY1tC7V6fH3IfLb/PIw4ewuGn37XQ9T+Oa+8O/ZlRFZmjTjW8
         G1Jg==
X-Gm-Message-State: ACgBeo3gNKd95ngzs3LxXnfKAb7oCQ2HUec/BaQyFq+J/jDhbVvCKt53
        JyKp5Ss8zdMbmafggCTzZKU=
X-Google-Smtp-Source: AA6agR7PeS2DulNjzrDsgVaR0KUqFHGZlgZV13SYQNgdq+QN4kAFTk8GGG6EHClSZS9iei94E+wx0w==
X-Received: by 2002:a17:902:8f8a:b0:16f:975e:7c6e with SMTP id z10-20020a1709028f8a00b0016f975e7c6emr8951219plo.136.1660939292385;
        Fri, 19 Aug 2022 13:01:32 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e5c600b0016d88dc7745sm3540099plf.259.2022.08.19.13.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 13:01:31 -0700 (PDT)
Message-ID: <baa1f65a-d983-0518-3979-7099679995f2@acm.org>
Date:   Fri, 19 Aug 2022 13:01:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] driver core: Fix bus_type.match() error handling
Content-Language: en-US
To:     Isaac Manjarres <isaacmanjarres@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Saravana Kannan <saravanak@google.com>, stable@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org
References: <20220815211919.2028890-1-isaacmanjarres@google.com>
 <20220816042507.GB1108868@roeck-us.net> <YvsoYzIhOtX9DOi2@google.com>
 <20220816111311.GC1108868@roeck-us.net> <YvvQOBk9T3J1uX8k@google.com>
 <20220817010559.GA1880847@roeck-us.net> <YvxAfiSOrzy7/c1J@google.com>
 <20220818225932.GA3433999@roeck-us.net> <Yv7bd6Yl8+thp2CY@google.com>
 <20220819112832.GA3106213@roeck-us.net> <Yv/MKymRC9O04Nqu@google.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Yv/MKymRC9O04Nqu@google.com>
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

On 8/19/22 10:45, Isaac Manjarres wrote:
> It seems that the patches mentioned in [1] are causing a hang during
> reboot for various ARM emulations when booting from USB. Can you please
> take a look? There's more information about what defconfig, rootfs, and
> qemu commandline to use at [2].

Unfortunately I can't reproduce this hang in an x86 VM with kernel 
v6.0-rc1 and a USB disk attached via virt-manager. The lsscsi -v output 
shows that a USB disk has been attached:

[9:0:0:0]    disk    QEMU     QEMU HARDDISK    2.5+  /dev/sdd
   dir: /sys/bus/scsi/devices/9:0:0:0 
[/sys/devices/pci0000:00/0000:00:07.0/usb2/2-2/2-2:1.0/host9/target9:0:0/9:0:0:0]

Rebooting that VM happens in the expected time and without triggering 
any kernel warnings.

Since the issue has been observed in qemu, how about sharing the sysrq-t 
output? I recommend to collect that output as follows:
* Send the serial console output to a file. This involves adding 
console=ttyS0,115200n8 to the kernel command line and using the proper 
qemu options to save the serial console output into a file.
* Reproduce the hang and send the sysrq-t key sequence to qemu, e.g. as 
follows: virsh send-key ${vm_name} KEY_LEFTALT KEY_SYSRQ KEY_T

Thanks,

Bart.
