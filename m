Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8303481EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 18:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240372AbhL3RgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 12:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhL3RgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 12:36:23 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE677C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 09:36:22 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 19DF358726E3A; Thu, 30 Dec 2021 18:36:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 0434C60BF8381;
        Thu, 30 Dec 2021 18:36:21 +0100 (CET)
Date:   Thu, 30 Dec 2021 18:36:20 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     linux-kernel@vger.kernel.org, tkjos@android.com
Subject: Re: [PATCH] android: use "menuconfig" menu entry type for
 CONFIG_ANDROID
In-Reply-To: <Yc3lLpYKXl0MAEoO@kroah.com>
Message-ID: <o0173nqs-17o2-s745-s2p-8q1q371r36r0@vanv.qr>
References: <20211230145002.7120-1-jengelh@inai.de> <Yc3lLpYKXl0MAEoO@kroah.com>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thursday 2021-12-30 17:58, Greg KH wrote:
>On Thu, Dec 30, 2021 at 03:50:02PM +0100, Jan Engelhardt wrote:
>> Allow disabling the Android driver section from within the Device
>> Drivers submenu, without having to descend into the Android drivers
>> submenu first.

>> -config ANDROID
>> +menuconfig ANDROID
>
>But, when you do this, you loose these lines from the .config file,
>resulting in this diff in the file:
>
>-#
>-# Android
>-#
> CONFIG_ANDROID=y
> CONFIG_ANDROID_BINDER_IPC=y
> CONFIG_ANDROID_BINDERFS=y
> CONFIG_ANDROID_BINDER_DEVICES="binder"
> CONFIG_ANDROID_BINDER_IPC_SELFTEST=y
>-# end of Android
>-
>
>Is that really a good idea?


Humour me - what information did "# Android" convey
that CONFIG_ANDROID= didn't already?


>What's the default these days?

There isn't really a default. When someone edits a Kconfig file to
add options for a new knob, they have to decide for one or the other.
At worst, they'll just copy from some other Kconfig file or the
documentation without making a conscious decision.

As you can see in the Device Drivers menu when running the `make 
menuconfig` command, it's a mix, but with a clear tendency to go with 
the menuconfig type. We used to have much less menuconfig-type options 
in the olden days of 2.4.x or so. I would therefore make the case that, 
on the whole, menuconfig-typed options are/should be used whenever 
possible.


  -*- PPS support  --->
      PTP clock support  --->
  [ ] Pin controllers  ----
  [ ] GPIO Support  ----
  < > Dallas's 1-wire support  ----
  [ ] Board level reset or power off  ----
  -*- Power supply class support  --->
  -*- Hardware Monitoring support  --->
  -*- Thermal drivers  --->
  [*] Watchdog Timer Support  --->
  < > Sonics Silicon Backplane support  ----
  < > Broadcom specific AMBA  ----
      Multifunction device drivers  --->
  [ ] Voltage and Current Regulator Support  ----
  < > Remote Controller support  ----
      CEC support  --->
  < > Multimedia support  ----
      Graphics support  --->
  <*> Sound card support  --->

There's just no GPIO, W1 or SSB in most contemporary desktop and
laptop x86s for example, and servers generally come without sound, so
it's nice to just hit {N DOWN}*.. quickly rather than having to
{ENTER N RIGHT ENTER DOWN}* to disable driver categories.


>Also, to be pedantic, this is a [v2] patch, right?  :)

Sorry, I have been working too long with sites like github et al
where diff -p0/p1 does not play a role (since one is sending commits
not diffs), nor version markers are needed (an update will simply be
appended to the end of a ticket/PR).
