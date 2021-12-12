Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E45471A36
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 13:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhLLMyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 07:54:09 -0500
Received: from smtp-34-i2.italiaonline.it ([213.209.12.34]:54174 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229985AbhLLMyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 07:54:04 -0500
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([82.50.51.121])
        by smtp-34.iol.local with ESMTPA
        id wOMammqwPUpmcwOMamGyIl; Sun, 12 Dec 2021 13:54:01 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1639313641; bh=Mu6DObjl4NjaDHGHcI+cH71n6ivJ3cELCJZmt93mjOo=;
        h=From;
        b=tK78/E7yg2F0gOx+rU96RGNTqXLK+SBRlZnvX+tsvzU2zt0o+Jy+SdEWL0FO4oTov
         C7gblnAXZTe5IYRI27qI1ZnrzmmldSRVnHomxLOBRfOYWyCJctGuKm5CJkU1R7hsfz
         uo6mapLVuoWf9RO6hRh8s5yIZ12LStYmPCy3L8T4bKuiH9qJNcFH43LitM47QiVC7B
         LapMpxpLSjSNjtwpTlUSda1yxPlnGVBDSg9GO24EBNat6JJdPM4h87joxRjnEzL5lt
         KFKZ6WGdGQz9Ms8rofB3S5j1ID/yiEHDdGh0PYPdixDwhwtIa4G0OSiCACIbc/tUG9
         4cT7Fyl/7jbZQ==
X-CNFS-Analysis: v=2.4 cv=VsDmv86n c=1 sm=1 tr=0 ts=61b5f0e9 cx=a_exe
 a=xtCFBUu/Ze6RtP+zVSd77w==:117 a=xtCFBUu/Ze6RtP+zVSd77w==:17
 a=8I0KCcMPWWhMFVcpAy8A:9
From:   Dario Binacchi <dariobin@libero.it>
To:     linux-kernel@vger.kernel.org
Cc:     "Andrew F . Davis" <afd@ti.com>, Felipe Balbi <balbi@ti.com>,
        Rachna Patil <rachna@ti.com>, Wolfram Sang <wsa@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jeff Lance <j-lance1@ti.com>,
        Zubair Lutfullah <zubair.lutfullah@gmail.com>,
        Vignesh R <vigneshr@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Brad Griffis <bgriffis@ti.com>,
        Dario Binacchi <dariobin@libero.it>
Subject: [RESEND PATCH 0/3] input: touchscreen: am335x: fix and improvements
Date:   Sun, 12 Dec 2021 13:53:55 +0100
Message-Id: <20211212125358.14416-1-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
X-CMAE-Envelope: MS4xfF4DdcLXCoY0YJggC1A/zGE1daSGJ1y0kOs+yr+ynnqmiltxHTucCBzBzUM3j8rSF+afXC7fFIrMEb7VZPf14ll2rYq/oIjzYe01ENK2Cunk9N9K40a8
 0vGNZsDTAWemdfQrxurvg7mXqRwX65N6KSXJ1vkOQxSwXBSIeM3XK3H3CVVBA02rha5mhY/waY9oxkH+otEiiz8dP86rcJYzt5M+eAj9UWhDzsAjcY1Mpl3L
 fHgLpYsVE/DGVSaYmeTTU/l8aEMcVvpwnEDQwfghExludvLd/ixCiQ6EAQe7ppcbDJ/YfDO/JlTKKJ/0LRompFwtVhzJ6HkzBQtwKDS4DLUrP2IkB/15MRxg
 wHsUTXkEpwMQRcnYy32xGqP3b1zGFvI8YEgpL1CpvNtBmBA8q2FSb4Rfwb+nZ5Vpy4BhqiEbzNFI86SBK1dnHdmuBH2wxbJWp0q9Zz/b8sdQbIPdPrBicnSa
 zOHNKiouSltzA1IUHra3c2hoXir9rnYmaVdqCFllJBYRB1ik/h61uCJxDXpH+jQVYoVRq9xewiit/dLZmBTrS5EpJUu3OFi0m6+OyHpaYLvkEBgAYNp2VBY0
 0rPu2OE9aLmLVRtpN3Tu1C0EUymYSE2AqPiHNYmunYT2JApyQeobrYbjlXQAbLAOS4g=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series grew out of a touchscreen validation activity on a custom
board. Oscilloscope measurements and driver source analysis led to these
patches.


Dario Binacchi (3):
  input: ti_am335x_tsc: set ADCREFM for X configuration
  input: ti_am335x_tsc: fix STEPCONFIG setup for Z2
  input: ti_am335x_tsc: lower the X and Y sampling time

 drivers/input/touchscreen/ti_am335x_tsc.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

-- 
2.17.1

