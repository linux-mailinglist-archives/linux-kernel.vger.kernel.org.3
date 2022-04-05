Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42334F51CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1847250AbiDFCQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344408AbiDEUV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 16:21:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64A56C975
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:00:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 972ACB81D6E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 20:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A431CC385A0;
        Tue,  5 Apr 2022 20:00:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oK7/f0ji"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649188847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dtTvKsnbPiz/iEPRO7T9fc0dbhR7Qpouw7hAuHZcwWA=;
        b=oK7/f0jibQ+nQO++4aLYVnNDKBEGWa/7cfSL8349HqQ75s9Lb0fNVeWui1udeUit4C4PbC
        D+1sD99Lc4S0twNy++TKh9i2IaN3In/mV/nHIm1GioaAQBAk8ikA4pTdIvfRsxDUoWz6jm
        vSuPxMXuQuW4ive1duqSisC4LPADm8Q=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 76c4e30d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 5 Apr 2022 20:00:46 +0000 (UTC)
Date:   Tue, 5 Apr 2022 22:00:37 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Yi Zhang <yi.zhang@redhat.com>, alan.adamson@oracle.com
Cc:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>, alan.adamson@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests
Message-ID: <Ykyf5Zuz1W8yHhNY@zx2c4.com>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

I too am seeing this. Tracking it down to the same commit, I decided to
enable NVME_VERBOSE_ERRORS to get some more information. Now on boot and
everytime I wake up from sleep, I see:

[   89.098578] nvme nvme0: Shutdown timeout set to 8 seconds
[   89.098683] nvme0: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE
[   89.119363] nvme nvme0: 16/0/0 default/read/poll queues

With that middle line in red.

Question is: is this actually an error? If not, maybe it shouldn't be
printed as a KERN_ERR. And if it's printed as a KERN_INFO, maybe it
should only do so when CONFIG_NVME_VERBOSE_ERRORS=y? Or do you think
there is actually some other diagnostic value in having this print
always?

Using a Samsung SSD 970 EVO Plus 2TB, firmware version 2B2QEXM7, in case
that's useful info.

I also noticed a ~2 second boot delay on 5.18-rc1:

[    0.917631] pstore: Using crash dump compression: deflate
[    0.917807] Key type encrypted registered
[    0.951840] ACPI: battery: Slot [BAT0] (battery present)
[    3.146765] nvme nvme0: Shutdown timeout set to 8 seconds
[    3.146918] nvme0: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE
[    3.188852] nvme nvme0: 16/0/0 default/read/poll queues
[    3.198163]  nvme0n1: p1 p2
[    3.199554] Freeing unused kernel image (initmem) memory: 12952K

I haven't looked into it much, but I assume it's also NVMe related? Or
maybe the vconsole is just initializing faster so I see text where
before I didn't. Not sure.

Regards,
Jason
