Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078A458D788
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242618AbiHIKlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242608AbiHIKlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:41:07 -0400
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2CCC17
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 03:41:05 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1oLMfV-0004O1-TL; Tue, 09 Aug 2022 20:41:01 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VlWXTgNoMVGqiY4nt93ukeUGdeILiI3ZgrA18aVvkpY=; b=VNK89+aTAQReF+KVCHp3m4K3M9
        Z+WvrnfafKKY3ewwqx5BGqW9KHqjhx5ywpad/J57f6ViA+LG2TTlFUnIIrmTq6Jlarga5DhoZ0XNS
        aGTu4F4kiqOhrh1gqla8fLaZLRBPUAqOwELnVUdIqZCr5GTIfmTGrytVak43wPgxFMkE=;
Message-ID: <bcebdeb9-4f6a-e931-46f5-b9be899db9a4@fnarfbargle.com>
Date:   Tue, 9 Aug 2022 18:40:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Apple Thunderbolt Display chaining
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <d484d7e5-f1aa-1096-e6fb-bbf16ce28699@fnarfbargle.com>
 <Yu0nWro4xXURbSX6@lahna>
 <87c1a001-ef79-6390-dfe2-06d2850f6e84@fnarfbargle.com>
 <Yu4Gmkous7asng6h@lahna>
 <42e81a8e-e393-7a69-7339-a020ebb57935@fnarfbargle.com>
 <YvDcudE5BRtZAtfM@lahna>
 <a1db1454-63b6-7c39-bbf6-53e53bbd36e6@fnarfbargle.com>
 <5474e599-057a-ec0f-b469-560644155907@fnarfbargle.com>
 <YvEFtPF7SBIwNG/o@lahna>
 <d234ea9b-9303-6088-0a9b-4de887a77bf4@fnarfbargle.com>
 <YvI1lQh+C0SJiG73@lahna>
From:   Brad Campbell <lists2009@fnarfbargle.com>
In-Reply-To: <YvI1lQh+C0SJiG73@lahna>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

G'day Mika,


On 9/8/22 18:23, Mika Westerberg wrote:
> Hi,
> 
> On Mon, Aug 08, 2022 at 09:27:24PM +0800, Brad Campbell wrote:
>> If I don't authorize the PCIe tunnels and just leave the DP enabled it
>> works fine also.
> 
> But you say that it fails on boot when the driver discovers the tunnels,
> right? So there is really nothing to authorize (they should be already
> "authorized" by the boot firmware).
> 
> If I understand correctly this is how it reproduces (the simplest):
> 
>   1. Connect a single Apple TB1 display to the system
>   2. Boot it up
>   3. Wait a while and it hangs
> 
> If this is the case, then the driver certainly is not creating any
> PCIe tunnels itself unless there is a bug somewhere.
> 
> An additional question, does it reproduce with either TB1 display
> connected or just with specific TB1 display?
> 

No, I've not been clear enough, I'm sorry. I've re-read what I've written below and
I'm still not sure I'm clear enough.

The firmware never sets anything up. 

When I cold boot the machine (from power on), the thunderbolt displays and tunnels
remain dark until linux initializes the thunderbolt driver the first time. 
 
If I compile the thunderbolt driver into the kernel, or let the initramfs load it
the displays come up, all PCIe tunnels are established and everything works.

When I reboot the machine (reset button or warm boot), the firmware continues to
do nothing and all the tunnels remain in place. The machine dies when the thunderbolt 
driver is loaded for a second time.

That might be a reset/warm boot with it compiled in or loaded from iniramfs.
It may also be me loading it from the command line after booting with it as a
module and blacklisted.

The problem comes about when the thunderbolt module is loaded while the PCIe tunnels
are already established.

To reproduce in the easiest manner I compile the thunderbolt driver as a module and
blacklist it. This prevents it from auto-loading.

I cold boot the machine, let it boot completely then modprobe thunderbolt and authorize
the tunnels. I then warm boot which lets the kernel detect and init the DP displays
and detect/configure all the PCIe devices. The thunderbolt driver is not loaded.

The machine comes up, all tunnels are established and all devices work.

If I then modprobe the thunderbolt driver, things break.

This is the hack in my boot script :

# Spark up thunderbolt
if [ -z "`grep notb /proc/cmdline`" -a -z "`lsusb | grep '05ac:9227'`" ] ; then
	modprobe thunderbolt
	sleep 1
	echo 1 > /sys/bus/thunderbolt/devices/0-3/authorized
	echo 1 > /sys/bus/thunderbolt/devices/0-303/authorized
	reboot
fi

Regards,
Brad
