Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED454E8633
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 08:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbiC0GKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 02:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbiC0GKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 02:10:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AE3B7D1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 23:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:Cc:References:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=r1Z4+9mP70DcRJzsHUVzWOn2gh7baT5li/8hB4Sd/Rw=; b=anv90Aq7MF3P8hebttS9c8+zs4
        ZTApTE9jcvphENrMooPQqHdh1AXfSt2/PhjSEs4bsMT50611uXn+sS7WDgUbGbdOmCg4WqJR3E9md
        AN0++YljWIaurRU1CeNm+pN+222Ssk57fWlqK/kJbIPg2UoSwPLKqPb/pwDr/GCSyjbE4VqrUy9ht
        ZIT2VjRA9bNX9e6v12FetwcskRWG5LGf3wjO7glrWBaV+2OvkHWIs2xK0dj/QGCveJQ0HvJxZUy+v
        /Li4xVWYk9yMQ9HaRaU+nGFDcFuW3emA5nUDO5ZngElk+SbSVLeUa+tmBX3wX8S0cF8pgWO/2kNoR
        yglfdpaQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nYM52-00Fpme-Sf; Sun, 27 Mar 2022 06:08:49 +0000
Message-ID: <53ce9316-1467-78ea-21a9-02a1c2438002@infradead.org>
Date:   Sat, 26 Mar 2022 23:08:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: 5.17.0 fails to suspend
Content-Language: en-US
To:     Norbert Preining <norbert@preining.info>,
        linux-kernel@vger.kernel.org
References: <YjryLd+TuigtA6co@sakefilet.preining.info>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YjryLd+TuigtA6co@sakefilet.preining.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael-
Does this need to go to linux-usb or linux-pm?
thanks.


On 3/23/22 03:10, Norbert Preining wrote:
> Hi all,
> 
> (please cc)
> 
> upgrading from 5.16.15 or so to 5.17.o my laptop (Fujitsu Lifebook U
> Series) fails to suspend:
> 
> kernel: Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> kernel: printk: Suspending console(s) (use no_console_suspend to debug)
> kernel: e1000e: EEE TX LPI TIMER: 00000011
> kernel: PM: pci_pm_suspend(): hcd_pci_suspend+0x0/0x30 returns -16
> kernel: PM: dpm_run_callback(): pci_pm_suspend+0x0/0x160 returns -16
> kernel: xhci_hcd 0000:00:14.0: PM: failed to suspend async: error -16
> kernel: PM: Some devices failed to suspend, or early wake event detected
> kernel: nvme nvme0: Shutdown timeout set to 8 seconds
> kernel: nvme nvme0: 8/0/0 default/read/poll queues
> kernel: OOM killer enabled.
> 
> No external usb device connected, internal ones:
> $ lsusb
> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 001 Device 004: ID 04f2:b6e1 Chicony Electronics Co., Ltd FJ Camera
> Bus 001 Device 003: ID 298d:2033 Next Biometrics NB-2033-U
> Bus 001 Device 002: ID 058f:9540 Alcor Micro Corp. AU9540 Smartcard Reader
> Bus 001 Device 005: ID 8087:0026 Intel Corp. AX201 Bluetooth
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> 
> What further information can I provide (no external usb device
> 
> (please cc)
> 
> All the best
> 
> Norbert
> 
> --
> PREINING Norbert                              https://www.preining.info
> Fujitsu Research     +    IFMGA Guide     +    TU Wien    +    TeX Live
> GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13

-- 
~Randy
