Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FD94D6FF1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 17:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiCLQDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 11:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiCLQDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 11:03:32 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1F383443F9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 08:02:27 -0800 (PST)
Received: (qmail 1619048 invoked by uid 1000); 12 Mar 2022 11:02:26 -0500
Date:   Sat, 12 Mar 2022 11:02:26 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     syzbot <syzbot+f0fae482604e6d9a87c9@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, pavel.hofman@ivitera.com,
        rob@robgreener.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] memory leak in usb_get_configuration
Message-ID: <YizEEq6gib/FNLKr@rowland.harvard.edu>
References: <000000000000351b8605d9d1d1bf@google.com>
 <Yiu4tCONfHVH1Qfv@rowland.harvard.edu>
 <d17aef8a-adbe-9d90-3173-60eb2f0828a5@gmail.com>
 <Yiy7gEfSPZlfLHSY@rowland.harvard.edu>
 <d82e80ed-566d-9516-2cc2-60278b56ea8d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d82e80ed-566d-9516-2cc2-60278b56ea8d@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 06:45:08PM +0300, Pavel Skripkin wrote:
> > Unfortunately, that won't tell us where the extra reference is coming
> > from.  Here's one thing you could do if you want to continue your
> > debugging: At the start of the probe routines for carl9170, usbtest, and
> > spca501, add code to print in the kernel log the reference count value
> > for the usb_device and usb_interface.  Maybe you'll be able to see where
> > the refcount goes up.
> > 
> 
> Unfortunately refcount for dev and inf stays the same at the beginning of
> each probe function:
> 
> 6 for dev
> 3 for inf

Can you find out how those numbers compare with the values for actual 
working USB devices?

Also, can you see what the device's refcount is just before the 
device_add() call in usb_new_device() and just before the put_device() 
call at the end of usb_disconnect() (both in drivers/usb/core/hub.c)?

If they all are consistent with each then my guess that something is 
failing to drop a reference is probably wrong.

Alan Stern
