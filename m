Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89EE5967EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 06:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiHQEEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 00:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiHQEED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 00:04:03 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674585AA11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 21:04:00 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id E9FD84014F;
        Wed, 17 Aug 2022 09:03:53 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1660709034; bh=vEUeKsVSsYoxf7ROoW/Jp/R4kHXxb6KHdnCvItudHtw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ptdJlb5UTK/Eq6xpMDV4UTnkrQKd4RFRiraygK5Q4BdRcxJqZzqRfq2rOo64ohKQg
         zFD7cZgbD/bugcb7ZAOysPcqohRFLmWRhyVt+OwX/1tYTkyp/VYRbuxrLGrbCALuXJ
         QMrookeH8cTiEjHu6zATWCWVQa2YVJ+If4xi/qI5tcuY0HqKGoqnujCiKypLHOQq0B
         aMnyOJQfS5GgB3auoAIVDrUL3xAhA/JFRycgoYAeHECqU98/07O9LB9JXskAXTQ4vh
         oXIvRh7pF6Ml3yZKUf6cjswnZzxorZa8IpRe1hmZiZ4IYY7L9cKhBmsjFFAjoqwKWB
         umqNugMRn82Ag==
MIME-Version: 1.0
Date:   Wed, 17 Aug 2022 09:03:52 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
Subject: Re: [PATCHv4] speakup: Generate speakupmap.h automatically
In-Reply-To: <20220816183310.uvmcojucjdhcb4vk@begin>
References: <20220612172244.il3siyq7ueqnvah5@begin>
 <20220816072843.1699317-1-nikita@trvn.ru>
 <20220816183310.uvmcojucjdhcb4vk@begin>
Message-ID: <c48cdee9ec664ea765cc41b41786df1e@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Samuel Thibault писал(а) 16.08.2022 23:33:
> Hello,
> 
> Nikita Travkin, le mar. 16 août 2022 12:28:43 +0500, a ecrit:
>> After that I also had some weird issues of the build system trying to
>> write speakupmap.h into the source dir and not the output dir (the
>> source is read only due to the tooling I use) but this seems to have
>> been resolved by cleanly rebuilding the speakup dir.
> 
> Mmm, how did you get/update your source dir? The latest version of the
> patchset does generate it in the build tree.
> 

It's just a git tree for Linux in which I've checked-out the
v6.0-rc1 tag and applied few unrelated patches on top.

The thing confused me a bit as all other artifacts were properly
placed in the output dir with an exception of the speakupmap.h.

My guess would be that I had some cache left over in the build dir
from before this patch, when the file was hardcoded so it tried to
recreate it as it was. This seems reproducible:

(Please note that the build tooling I use handles the output dir in
the output below)

$ sudo rm -rf .output/drivers/accessibility/speakup/
$ git checkout v5.19
$ make -j12 allnoconfig
$ make -j12 menuconfig # Enable speakup
$ make -j12
(... Builds correctly)

$ git checkout v6.0-rc1
$ git cherry-pick bc239d8740f9
[отделённый HEAD c32cda0a1b44] speakup: Fix compilation in some build environments
 Date: Tue Aug 16 11:39:52 2022 +0500
 1 file changed, 1 insertion(+), 1 deletion(-)

$ make -j12 allnoconfig
$ make -j12 menuconfig # Enable speakup the same way
$ make -j12
*** pmbootstrap envkernel.sh active for /home/travler/devel/pmos/linux! ***
make: Entering directory '/mnt/linux'
make[1]: Entering directory '/mnt/linux/.output'
  SYNC    include/config/auto.conf.cmd

(...)

  CC      drivers/accessibility/speakup/buffers.o
  CC      drivers/accessibility/speakup/devsynth.o
  CC      drivers/accessibility/speakup/i18n.o
  AR      kernel/built-in.a
  CC      drivers/accessibility/speakup/fakekey.o
  HOSTCC  drivers/accessibility/speakup/makemapdata.o
  CC      drivers/accessibility/speakup/keyhelp.o
  CC      drivers/accessibility/speakup/kobjects.o
  CC      drivers/accessibility/speakup/selection.o
  CC      drivers/accessibility/speakup/spk_ttyio.o
  CC      drivers/accessibility/speakup/synth.o
  CC      drivers/accessibility/speakup/thread.o
  CC      drivers/accessibility/speakup/varhandlers.o
  CC      drivers/of/device.o
  HOSTLD  drivers/accessibility/speakup/makemapdata
  MKMAP   drivers/accessibility/speakup/mapdata.h
  HOSTCC  drivers/accessibility/speakup/genmap.o
  HOSTLD  drivers/accessibility/speakup/genmap
  GENMAP  ../drivers/accessibility/speakup/speakupmap.h
/bin/sh: can't create ../drivers/accessibility/speakup/speakupmap.h: Permission denied
make[4]: *** [../drivers/accessibility/speakup/Makefile:58: ../drivers/accessibility/speakup/speakupmap.h] Error 1
make[4]: *** Waiting for unfinished jobs....
  CC      drivers/of/platform.o
  CC      drivers/of/property.o
  CC      drivers/of/kobj.o
  CC      drivers/of/fdt.o
  CC      drivers/of/fdt_address.o
  CC      drivers/of/address.o
  CC      drivers/of/irq.o
  CC      drivers/of/of_reserved_mem.o
make[3]: *** [../scripts/Makefile.build:465: drivers/accessibility/speakup] Error 2
make[2]: *** [../scripts/Makefile.build:465: drivers/accessibility] Error 2
make[2]: *** Waiting for unfinished jobs....
  AR      drivers/of/built-in.a
make[1]: *** [/mnt/linux/Makefile:1855: drivers] Error 2
make[1]: Leaving directory '/mnt/linux/.output'
make: *** [Makefile:222: __sub-make] Error 2
make: Leaving directory '/mnt/linux'
Run 'pmbootstrap log' for details.

$ sudo rm -rf .output/drivers/accessibility/speakup/
$ make -j12
(...)
  HOSTLD  drivers/accessibility/speakup/makemapdata
  MKMAP   drivers/accessibility/speakup/mapdata.h
  HOSTCC  drivers/accessibility/speakup/genmap.o
  HOSTLD  drivers/accessibility/speakup/genmap
  GENMAP  drivers/accessibility/speakup/speakupmap.h
  CC      drivers/accessibility/speakup/main.o
  AR      drivers/accessibility/speakup/built-in.a
(... Builds correctly again)


Nikita

> Samuel
