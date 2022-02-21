Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F256D4BD7C0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346740AbiBUIBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:01:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346734AbiBUIBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:01:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5A425EA;
        Mon, 21 Feb 2022 00:01:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43B7160FDA;
        Mon, 21 Feb 2022 08:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F76BC340E9;
        Mon, 21 Feb 2022 08:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645430467;
        bh=qvDbxDiZRGEUPbWcdjncapc1GDhk0SQWWnmNRy79Mas=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=sM4h5lKiTLkqUCWxFoLINDUqlZ3U6PPvmpfswxsW7S7Kb/80voes0CqIilU1K5ROX
         2nwG+c8ZsPvxgr87X7MucXAMuUL1a94BjiZW76hbDLwv6tAFCsmaUGpY4m42DcFd3J
         ntVAIPPH/LO++ZimKpdfYPsAhbhAKT8aDMUHEHGBg8pIsAJ20fOU0g8ZxB0kTZQQlM
         Q52FWb+Uity8rUcuG2EYeXYteaTlO6rNJ5fWWqHj93xOrDt6Q3GVfyxO7RFQpKM2sq
         K/6BI4mCI7cJYJPZu3Ai7V4bC/E1X+6QeRqHoa5KOA8JjzDSOYIw7YnqEWD3DgMlpl
         c2qoWKyS2MYUg==
Date:   Mon, 21 Feb 2022 09:01:02 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
cc:     syzbot <syzbot+35eebd505e97d315d01c@syzkaller.appspotmail.com>,
        alexandre.torgue@foss.st.com, benjamin.tissoires@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in thrustmaster_probe
In-Reply-To: <cd08c05f-f648-071f-d8f5-0a022cd35b7b@gmail.com>
Message-ID: <nycvar.YFH.7.76.2202210900420.11721@cbobk.fhfr.pm>
References: <000000000000d181a205d874c066@google.com> <cd08c05f-f648-071f-d8f5-0a022cd35b7b@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Feb 2022, Pavel Skripkin wrote:

> On 2/20/22 18:27, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    c5d9ae265b10 Merge tag 'for-linus' of git://git.kernel.org..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14ccc65c700000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
> > dashboard link: https://syzkaller.appspot.com/bug?extid=35eebd505e97d315d01c
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils
> > for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175ecbf2700000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109973f2700000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+35eebd505e97d315d01c@syzkaller.appspotmail.com
> > 
> > usb 1-1: config 0 interface 0 altsetting 0 endpoint 0x81 has invalid
> > wMaxPacketSize 0
> > usb 1-1: New USB device found, idVendor=044f, idProduct=b65d, bcdDevice=
> > 0.40
> > usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> > usb 1-1: config 0 descriptor??
> > hid-thrustmaster 0003:044F:B65D.0001: unknown main item tag 0x0
> > hid-thrustmaster 0003:044F:B65D.0001: hidraw0: USB HID v0.00 Device [HID
> > 044f:b65d] on usb-dummy_hcd.0-1/input0
> > ==================================================================
> > BUG: KASAN: slab-out-of-bounds in thrustmaster_interrupts
> > BUG: KASAN: drivers/hid/hid-thrustmaster.c:162 [inline]
> > BUG: KASAN: slab-out-of-bounds in thrustmaster_probe+0x8d5/0xb50
> > BUG: KASAN: drivers/hid/hid-thrustmaster.c:330
> > Read of size 1 at addr ffff88807f1a59d2 by task kworker/1:1/35
> > 
> 
> Looks like missing check for malicious device. Need to check number of
> endpoints before accessing endpoints array
> 
> 
> #syz test
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Thanks Pavel. Could you please send the patch with proper changelog and 
SOB my way?

-- 
Jiri Kosina
SUSE Labs

