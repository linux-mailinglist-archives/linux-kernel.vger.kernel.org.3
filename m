Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DD74BAAA7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245729AbiBQUMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:12:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243775AbiBQUMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:12:19 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF34A9E27;
        Thu, 17 Feb 2022 12:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1645128703;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-Id:To:Cc:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=/ncdnXpbY4SFFS0er1tKwPrwjg499WQ61cmVGx8FfzE=;
    b=i0oHJm1x9dwBejUmyWB+pi02WpJ2jLG6/kipDEZSa5Abus1VKAJGH5U3c7X03Dh1Cw
    L37QWgHPMmr/Wl9HVFyd0pCaVADPqutNu3aTi7EuigNdOxy5Fb8WfS5sSn7/njlFTvPz
    4hrh/M6r7e7o7EQ3LFl9CmI2BwsSZ6nBw5ArCbQ3cgd4HjFyrsAX732yWB8umwZNmngS
    QWdKCTy9k3ZOeKEWRlNBit1D3mKAo3svSkkKC624E02zqUfiXGhdgmuopcTKMgI0ouTI
    WxxHwZkjuakJD3bo2JKIwuPaTvbmFEkRBbFl2hK829cXuf297uxH3a5Qha+yaThnj1v3
    RjVg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHWElw4SA"
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.39.2 DYNA|AUTH)
    with ESMTPSA id Rb8524y1HKBh0LP
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 17 Feb 2022 21:11:43 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Date:   Thu, 17 Feb 2022 21:11:40 +0100
Subject: [BUG] mmc: core: adjust polling interval for CMD1
Cc:     Jean Rene Dawin <jdawin@math.uni-bielefeld.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>
To:     Huijin Park <huijin.park@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Message-Id: <27DDB061-1235-4F4C-B6A8-F035D77AC9CF@goldelico.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Jean Rene Dawin did report to me a problem on the Beagle Bone Black =
starting
with our disto kernel based on v5.17-rc1:

>> since kernel 5.17-rc1 I noticed slower emmc performance on Beaglebone
>> Black, but didn't check the logs.
>> When I tried to run 5.17.0-rc3-letux+ it booted fine, but during IO
>> traffic there were messages like
>>=20
>> [  662.529584] mmc1: error -110 doing runtime resume
>> [  669.293590] mmc1: Card stuck being busy! __mmc_poll_for_busy
>>=20
>> [  739.076072] mmc1: Timeout waiting for hardware interrupt.
>> [  739.145676] mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
SDHCI REGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [  739.231053] mmc1: sdhci: Sys addr:  0x00000000 | Version:  =
0x00003101
>> [  739.316472] mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  =
0x00000400
>> [  739.401937] mmc1: sdhci: Argument:  0x00342d30 | Trn mode: =
0x00000023
>> [  739.487439] mmc1: sdhci: Present:   0x01f70000 | Host ctl: =
0x00000000
>> [  739.573007] mmc1: sdhci: Power:     0x0000000f | Blk gap:  =
0x00000000
>> [  739.658609] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    =
0x00003c07
>> [  739.744224] mmc1: sdhci: Timeout:   0x00000007 | Int stat: =
0x00000002
>> [  739.829896] mmc1: sdhci: Int enab:  0x027f000b | Sig enab: =
0x027f000b
>> [  739.915623] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: =
0x00000001
>> [  740.001394] mmc1: sdhci: Caps:      0x07e10080 | Caps_1:   =
0x00000000
>> [  740.087208] mmc1: sdhci: Cmd:       0x0000193a | Max curr: =
0x00000000
>> [  740.173051] mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  =
0x00000000
>> [  740.258928] mmc1: sdhci: Resp[2]:   0x00000000 | Resp[3]:  =
0x00000000
>> [  740.344854] mmc1: sdhci: Host ctl2: 0x00000000
>> [  740.402796] mmc1: sdhci: =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> and finally IO errors and a corrupted filesystem.
>>=20
>> 5.17.0-rc4-letux+ shows the same behaviour.

I checked with my BeagleBoard Black (am3358) and can confirm this =
observation.
It happens only with the integrated eMMC but not with the =C2=B5SD =
connected to
the other mmc interface.

A git bisect found:

76bfc7ccc2fa9d382576f6013b57a0ef93d5a722 is the first bad commit
commit 76bfc7ccc2fa9d382576f6013b57a0ef93d5a722
Author: Huijin Park <huijin.park@samsung.com>
Date:   Thu Nov 4 15:32:31 2021 +0900

  mmc: core: adjust polling interval for CMD1

  In mmc_send_op_cond(), loops are continuously performed at the same
  interval of 10 ms.  However the behaviour is not good for some eMMC
  which can be out from a busy state earlier than 10 ms if normal.

  Rather than fixing about the interval time in mmc_send_op_cond(),
  let's instead convert into using the common __mmc_poll_for_busy().

  The reason for adjusting the interval time is that it is important
  to reduce the eMMC initialization time, especially in devices that
  use eMMC as rootfs.

  Test log(eMMC:KLM8G1GETF-B041):

  before: 12 ms (0.311016 - 0.298729)
  [    0.295823] mmc0: starting CMD0 arg 00000000 flags 000000c0
  [    0.298729] mmc0: starting CMD1 arg 40000080 flags 000000e1<-start
  [    0.311016] mmc0: starting CMD1 arg 40000080 flags 000000e1<-finish
  [    0.311336] mmc0: starting CMD2 arg 00000000 flags 00000007

  after: 2 ms (0.301270 - 0.298762)
  [    0.295862] mmc0: starting CMD0 arg 00000000 flags 000000c0
  [    0.298762] mmc0: starting CMD1 arg 40000080 flags 000000e1<-start
  [    0.299067] mmc0: starting CMD1 arg 40000080 flags 000000e1
  [    0.299441] mmc0: starting CMD1 arg 40000080 flags 000000e1
  [    0.299879] mmc0: starting CMD1 arg 40000080 flags 000000e1
  [    0.300446] mmc0: starting CMD1 arg 40000080 flags 000000e1
  [    0.301270] mmc0: starting CMD1 arg 40000080 flags 000000e1<-finish
  [    0.301572] mmc0: starting CMD2 arg 00000000 flags 00000007

  Signed-off-by: Huijin Park <huijin.park@samsung.com>
  Link: =
https://lore.kernel.org/r/20211104063231.2115-3-huijin.park@samsung.com
  Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reverting this makes v5.17-rc[1-4] work.

Any suggestions or fixes?

BR and thanks,
Nikolaus Schaller

Reported-by: jdawin@math.uni-bielefeld.de

