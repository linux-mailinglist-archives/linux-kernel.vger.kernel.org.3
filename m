Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6A759A752
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352021AbiHSUz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351912AbiHSUzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:55:24 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646F7F03
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:55:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 20so5067347plo.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=H2n3wyd22XqfBHQtxoS9ZE3dzQZzgHlgD8UAIwwzZHo=;
        b=YKtiwSXPb8Qdhkvsr3OWJcCj240oEeU16z8ri5CYHHthfh9F+eygv0eYS6zDVawBVl
         RRsSk7UkxObT7KJbVH5ZGj3GKu3TzaWXLLfcFh6LIVek25cSPGjeEFWdP2bc52szwuem
         NjwYBGXq9HqUKds8wqwlr5KjE53CQDONIpJNxGeLBUc4QwwGXbgsF8xEPngobHNdP1JQ
         PwtxAHalKN3xrFnRvCkrxzE8+plm9UwnGgUZffHTBDc0nQpvUsyim05QWGGqlLHjEV2y
         MAphLt+JMS21fN36e5pwWXxwPbBKNU+DQbvdtM+fEhi0YOnCbZsYV3bcdG56qiC5MVXt
         STVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=H2n3wyd22XqfBHQtxoS9ZE3dzQZzgHlgD8UAIwwzZHo=;
        b=Ta81B1TCd2vRKsyZRMe9cSzvpidSozgh0SsX1zyBwjlIz0x7TjNx6BfZ7sIO3ddGkC
         pKKyQEGRyQHjPPsHTac/5vtfKRfgH3Q0Gl5QO+s9F+tYDXuxIUkYXdhMMMNh7GEE+7SF
         olLjpkuiz7utEJcmJap6thAe1PVaMHtwpLmZhB9VUIWm2nBEcw5oNsjQ8cRia91LPpWk
         RtEcgHZ0ML7r/RRoinTMBYC3Eogo0rKtr+B1tgxHF4+z6OZn3rtvueAFwZFdPO1/KdNb
         RU2Vwj53d4Wwq8wNbt9ULVln7ekH103SVw5HKPye3iHNrnenuTj9+rhNIiriz4dyR5SM
         Rg5A==
X-Gm-Message-State: ACgBeo37a+n7cs7fa4GiVi2v7y3TGSY+faMZEwDWv3AxhuGfE4HNn52d
        qhfmEJs6PSatqEd1uaLP/LA=
X-Google-Smtp-Source: AA6agR5avHemvW2jekUK/yhGPnaXIxFk65uIalqg4HggjJNug3yVXgLEGksurLvkmF6eFK8Fy50+hA==
X-Received: by 2002:a17:903:1106:b0:172:68f9:f68 with SMTP id n6-20020a170903110600b0017268f90f68mr9089310plh.50.1660942521679;
        Fri, 19 Aug 2022 13:55:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c76-20020a624e4f000000b00535f2b5a23dsm2653120pfb.155.2022.08.19.13.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:55:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 19 Aug 2022 13:55:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Isaac Manjarres <isaacmanjarres@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Saravana Kannan <saravanak@google.com>, stable@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver core: Fix bus_type.match() error handling
Message-ID: <20220819205518.GA3151965@roeck-us.net>
References: <YvsoYzIhOtX9DOi2@google.com>
 <20220816111311.GC1108868@roeck-us.net>
 <YvvQOBk9T3J1uX8k@google.com>
 <20220817010559.GA1880847@roeck-us.net>
 <YvxAfiSOrzy7/c1J@google.com>
 <20220818225932.GA3433999@roeck-us.net>
 <Yv7bd6Yl8+thp2CY@google.com>
 <20220819112832.GA3106213@roeck-us.net>
 <Yv/MKymRC9O04Nqu@google.com>
 <baa1f65a-d983-0518-3979-7099679995f2@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baa1f65a-d983-0518-3979-7099679995f2@acm.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 01:01:29PM -0700, Bart Van Assche wrote:
> On 8/19/22 10:45, Isaac Manjarres wrote:
> > It seems that the patches mentioned in [1] are causing a hang during
> > reboot for various ARM emulations when booting from USB. Can you please
> > take a look? There's more information about what defconfig, rootfs, and
> > qemu commandline to use at [2].
> 
> Unfortunately I can't reproduce this hang in an x86 VM with kernel v6.0-rc1
> and a USB disk attached via virt-manager. The lsscsi -v output shows that a
> USB disk has been attached:
> 

The problem only reproduces with various arm emulations. I may have missed it,
but I have not noticed it on any other architecture.

> [9:0:0:0]    disk    QEMU     QEMU HARDDISK    2.5+  /dev/sdd
>   dir: /sys/bus/scsi/devices/9:0:0:0 [/sys/devices/pci0000:00/0000:00:07.0/usb2/2-2/2-2:1.0/host9/target9:0:0/9:0:0:0]
> 
> Rebooting that VM happens in the expected time and without triggering any
> kernel warnings.
> 
There are no warnings. The reboot just stalls. Also, the usb drive
attaches just fine. The probem is seen in shutdown, not during boot.

> Since the issue has been observed in qemu, how about sharing the sysrq-t
> output? I recommend to collect that output as follows:
> * Send the serial console output to a file. This involves adding
> console=ttyS0,115200n8 to the kernel command line and using the proper qemu
> options to save the serial console output into a file.
> * Reproduce the hang and send the sysrq-t key sequence to qemu, e.g. as
> follows: virsh send-key ${vm_name} KEY_LEFTALT KEY_SYSRQ KEY_T
> 

Will try.

Thanks,
Guenter
