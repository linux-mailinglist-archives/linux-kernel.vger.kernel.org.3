Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EC34EBFB6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343592AbiC3LXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiC3LXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:23:05 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732001480EB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:21:19 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D02BF40735
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1648639277;
        bh=TYIh88yIeHUuSh5FuLrOE1UpftWa66VuLXC2dIfncZE=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=LSycFpuEb+tbLSWffAbGaYa9ryeT5odotHcoerlUHe8yNR0mQ2/bQcPXjoIC+d7Ja
         Mlz4io032k4SgmHSzgyakCg+XFfX87/e37Xiw1AuQgKzDDPzbzIB9/61ewps48hLKu
         3cvcE5WOzTbWsI03NqTlKxjRdDH+s2NuAsIGW1B3nmdEAZo1G/vyYOKjUTWUUZK9zh
         K2UXWPyruRewSm3mEJp/29MaeactZM9tOGX/0q5jZe674vaSnPyxYnQoPD1OdDSKeq
         /4m9tMTp7hivcdlxqtJNyhVv8KrC9wku7YgmPoFGj/BBgPPl9OIHOW9eJ4uNsCSD6L
         oDdhDqWhvy7WQ==
Received: by mail-ed1-f69.google.com with SMTP id f2-20020a50d542000000b00418ed3d95d8so12769386edj.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TYIh88yIeHUuSh5FuLrOE1UpftWa66VuLXC2dIfncZE=;
        b=qnMUDuwGMKSNlFo2YxhCo4QHqNguQGkf9Xz5a6jYNgxehvCiDXz8C+dg/8dRQi4LoV
         5L0m8ngiCzxuwT/Yz1nVZZjeWOKcxrRjKa+T/WlmvCmqFiJuAdusUvLOs8JqJrN9jBm6
         WZs7Inwezs15MpnBE9LOKziocnTzWrq17WfLRKEdiLmG5OlG3znovPq/io5FU4N97LFM
         9tXLzUzXZjAh77L3YRhnwUf9f7IhpFsZNdO0LVrliaYyY8sRpswiqZyYRkcNQ/pB7qzy
         lVoUBNR7mC9CbhgBKMpjq+H414xav5PW9gUSJgsXDLA0yBXHjeZj7nPhcZKZ+oaSoG4p
         EkJw==
X-Gm-Message-State: AOAM531WXz9JrdzRxEyXDQ0ovlG3u6pV9khDoIAU1+8Uag85CT82TlF5
        0UyXTjeT8nG7/gDWU1VyX0tpmB4NJiKGN0I6lc0uhf11BKpo2DxqG7CxU9v8E2efeD3vl7LEivX
        zhRl2pwPABf8BErJ1mS0ap8IouwWDJrwaOnxEU/luCg==
X-Received: by 2002:a50:bac3:0:b0:418:edb0:4ae8 with SMTP id x61-20020a50bac3000000b00418edb04ae8mr9710915ede.219.1648639277124;
        Wed, 30 Mar 2022 04:21:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwHEqUNojq/IZX+ioyLwrflRSU8wB5rBy4BqenMe2TFM3PjOmzz+qZirs5E/f8pqDLzgea6w==
X-Received: by 2002:a50:bac3:0:b0:418:edb0:4ae8 with SMTP id x61-20020a50bac3000000b00418edb04ae8mr9710881ede.219.1648639276836;
        Wed, 30 Mar 2022 04:21:16 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id b9-20020a1709063ca900b006cea15612cbsm8003639ejh.176.2022.03.30.04.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 04:21:15 -0700 (PDT)
Date:   Wed, 30 Mar 2022 13:21:14 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Martin Wilck <martin.wilck@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: filesystem corruption with "scsi: core: Reallocate device's
 budget map on queue depth change"
Message-ID: <YkQ9KoKb+VK06zXi@arighi-desktop>
References: <YkQsumJ3lgGsagd2@arighi-desktop>
 <f7bacce8-b5e5-3ef1-e116-584c01533f69@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7bacce8-b5e5-3ef1-e116-584c01533f69@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 11:38:02AM +0100, John Garry wrote:
> On 30/03/2022 11:11, Andrea Righi wrote:
> > Hello,
> > 
> > after this commit I'm experiencing some filesystem corruptions at boot
> > on a power9 box with an aacraid controller.
> > 
> > At the moment I'm running a 5.15.30 kernel; when the filesystem is
> > mounted at boot I see the following errors in the console:
> > 
> > Begin: Will now check root file system ... fsck from util-linux 2.36.1
> > [/usr/sbin/fsck.ext4 (1) -- /dev/sda2] fsck.ext4 -a -C0 /dev/sda2
> > root: clean, 99646/122101760 files, 11187342/488376336 blocks
> > done.
> > [    4.636613] sd 0:2:0:0: [sda] tag#257 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
> > [    4.636655] sd 0:2:0:0: [sda] tag#257 CDB: Read(10) 28 00 00 00 4c 10 00 00 08 00
> > [    4.636689] blk_update_request: I/O error, dev sda, sector 19472 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > [    4.636734] sd 0:2:0:0: [sda] tag#258 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
> > [    4.636772] sd 0:2:0:0: [sda] tag#258 CDB: Read(10) 28 00 00 00 4c 18 00 00 08 00
> > [    4.636796] blk_update_request: I/O error, dev sda, sector 19480 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > [    4.636840] sd 0:2:0:0: [sda] tag#260 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
> > [    4.636877] sd 0:2:0:0: [sda] tag#260 CDB: Read(10) 28 00 00 00 4c 28 00 00 08 00
> > [    4.636901] blk_update_request: I/O error, dev sda, sector 19496 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > [    4.636944] sd 0:2:0:0: [sda] tag#259 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
> > [    4.636971] sd 0:2:0:0: [sda] tag#259 CDB: Read(10) 28 00 00 00 4c 20 00 00 08 00
> > [    4.637005] blk_update_request: I/O error, dev sda, sector 19488 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > [    4.637049] sd 0:2:0:0: [sda] tag#262 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
> > [    4.637085] sd 0:2:0:0: [sda] tag#262 CDB: Read(10) 28 00 00 00 4c 38 00 00 08 00
> > [    4.637118] blk_update_request: I/O error, dev sda, sector 19512 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > [    4.637161] sd 0:2:0:0: [sda] tag#264 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
> > [    4.637197] sd 0:2:0:0: [sda] tag#264 CDB: Read(10) 28 00 00 00 4c 48 00 00 08 00
> > [    4.637221] blk_update_request: I/O error, dev sda, sector 19528 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > [    4.637270] sd 0:2:0:0: [sda] tag#284 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
> > [    4.637306] sd 0:2:0:0: [sda] tag#284 CDB: Read(10) 28 00 00 00 4c e8 00 00 08 00
> > [    4.637332] blk_update_request: I/O error, dev sda, sector 19688 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > [    4.637375] sd 0:2:0:0: [sda] tag#286 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
> > [    4.637411] sd 0:2:0:0: [sda] tag#286 CDB: Read(10) 28 00 00 00 4c f8 00 00 08 00
> > [    4.637444] blk_update_request: I/O error, dev sda, sector 19704 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > [    4.637481] blk_update_request: I/O error, dev sda, sector 19664 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > [    4.637485] sd 0:2:0:0: [sda] tag#282 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
> > [    4.637487] sd 0:2:0:0: [sda] tag#287 FAILED Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK cmd_age=0s
> > [    4.637491] sd 0:2:0:0: [sda] tag#287 CDB: Read(10) 28 00 00 00 4d 00 00 00 08 00
> > [    4.637491] sd 0:2:0:0: [sda] tag#282 CDB: Read(10) 28 00 00 00 4c d8 00 00 08 00
> > [    4.637494] blk_update_request: I/O error, dev sda, sector 19672 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > [    4.747771] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
> > 
> > If I reboot multiple times fsck requires a manual fix and I get dropped
> > to the initramfs shell. Some times the filesystem gets corrupted and I
> > need to redeploy the box.
> > 
> > If I use the same kernel with this commit reverted I can reboot as many
> > times as I want without any failure:
> > 
> >   813c6871f76b ("scsi: core: Reallocate device's budget map on queue depth change")
> 
> I would not have thought that this causes possible corruption.
> 
> > 
> > For now I've just reverted the commit, but I'll try to add some
> > debugging and collect more info.
> > 
> > Let me know if there's any specific test that you want me to try.
> > 
> 
> Please try this:
> https://lore.kernel.org/linux-scsi/yq1ee2kumrh.fsf@ca-mkp.ca.oracle.com/T/#t
> 
> It never made 5.17, which I would have hoped for.

Thanks John! It looks like this one is actually fixing the problem.
I rebooted multiple times and I didn't get any I/O error or corruption.

If you want you can add my:

Tested-by: Andrea Righi <andrea.righi@canonical.com>
