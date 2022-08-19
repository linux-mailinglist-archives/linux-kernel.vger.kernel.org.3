Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4906359A831
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 00:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238647AbiHSWIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 18:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbiHSWIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:08:46 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C054D817
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:08:44 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y127so2471064pfy.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=cLkatCr2VyGfSQl50/DhzPmM9OxUG+Dr4hhXiugtgZs=;
        b=m9DvhnoRuWxhnNFRKFtv34M69lxSh9GYstL3O5+XaAY9wMVKi3KKVWCJFEF3ybl8u/
         YiPJxiFWBgXwWia7JSVhmE9kQbYpNR9gCofvYZ/iWIfNmyjdVyhKXIz3F/tE5gRKP7hC
         V8D8yiuAeyG/FcH/gekAq5hS6z8nenrcYVsaj0QHl9Lh+KcYRmJ9gWwOEc+DRaSu98cg
         0D8AE7n7+J9huuJzARLg/g5pjym8qXBr36zIP3gZgoArGmjefmDDjF7B/ClZHdLgn1dC
         8BxCf4YfEKrYH3y1sm7naH99r+kHTmnSRXfPyF632YukNIWZWvGuDVNNCS1GnNgmLJT+
         F8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=cLkatCr2VyGfSQl50/DhzPmM9OxUG+Dr4hhXiugtgZs=;
        b=PHQKG6e4ffzVAVpuUnSwLHcGqoNgDqwaePIoiz94WGEocHHh6bptgU4BeySD4TaT2g
         2eYmBBLZkbnCApyeqD5JMXPIdoOqRPGs68sUJE7LTv12mF6uKcOirouUKKKKCoJyDwRZ
         CWKPBRRZcOISF7KK5ZD7RJZQdY6sX/04IJRWu13ekd+ybPAmzi0H+MsktYO1fkjf+pIv
         WIpwFR3R1ZYjVQcSQ/teSxS1iQd3pbGhMPFmuXFf601W3QHzxJPVtQm6xPgAhXP7ODtR
         pRvBMKcZ+Q33ZKEwATNS6MlwGT5vZh0i4Y6+o1rDGx8iG5wn9DRTxEgyjnwssDjny8It
         3dmg==
X-Gm-Message-State: ACgBeo3dHw41eY0w9rEqw5sX1HRKOiijAazgNbsIwPkuwuoTGn6MuYvq
        LyUL0jM5F46jE8T4gmiCvpw=
X-Google-Smtp-Source: AA6agR5UeK+q/R8dph78V5lXs6EQTU9rgUC1PhCet/unfRaIiKmsh+8uE1o6dydz2/AHrbAXRcXM0w==
X-Received: by 2002:a63:491f:0:b0:41d:89d5:b3e7 with SMTP id w31-20020a63491f000000b0041d89d5b3e7mr7882177pga.18.1660946924018;
        Fri, 19 Aug 2022 15:08:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z62-20020a623341000000b005360dc9c45csm1792192pfz.43.2022.08.19.15.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 15:08:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 19 Aug 2022 15:08:41 -0700
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
Message-ID: <20220819220841.GA3230067@roeck-us.net>
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
> [9:0:0:0]    disk    QEMU     QEMU HARDDISK    2.5+  /dev/sdd
>   dir: /sys/bus/scsi/devices/9:0:0:0 [/sys/devices/pci0000:00/0000:00:07.0/usb2/2-2/2-2:1.0/host9/target9:0:0/9:0:0:0]
> 
> Rebooting that VM happens in the expected time and without triggering any
> kernel warnings.
> 
> Since the issue has been observed in qemu, how about sharing the sysrq-t
> output? I recommend to collect that output as follows:
> * Send the serial console output to a file. This involves adding
> console=ttyS0,115200n8 to the kernel command line and using the proper qemu
> options to save the serial console output into a file.
> * Reproduce the hang and send the sysrq-t key sequence to qemu, e.g. as
> follows: virsh send-key ${vm_name} KEY_LEFTALT KEY_SYSRQ KEY_T
> 
Unless I am missing something, this requires a virtio keyboard.
So far I have been unable to get this to work with qemu arm emulations.

Guenter
