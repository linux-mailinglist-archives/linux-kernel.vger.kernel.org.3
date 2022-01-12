Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9213348BC8A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347853AbiALBln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:41:43 -0500
Received: from mout.gmx.net ([212.227.17.21]:53467 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236309AbiALBln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:41:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641951693;
        bh=uHF0ooAWGXR54vTGChda2qbPj9tBD6JBdlJPU4+vjME=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jdasv9ndBdJF+6zmGC3wpoNjDwn+HO9UZCrUEJQ/Tv1qWf3jRUGrO2LMqoE1VWznU
         VsYfZ17lmGkOlH6SD1bu7iZVdJ546McEOYAPfreitCFTuy6DGLqtXyIGifzPfOFUbL
         sxckmWd+DIf7Q2Ri4ephHwPXMb/EY+WMX1STme8k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.47] ([149.172.237.68]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ygt-1n4znb3yg7-0038gO; Wed, 12
 Jan 2022 02:41:33 +0100
Subject: Re: [PATCH] Bugfix RTS line config in RS485 mode is overwritten in
 pl011_set_mctrl() function.
To:     Jochen Mades <jochen@mades.net>, Lukas Wunner <lukas@wunner.de>
Cc:     gregkh@linuxfoundation.org, Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
References: <20211231171516.18407-1-jochen@mades.net>
 <20220102100710.GA29858@wunner.de>
 <0e0e91b8-72f8-aa31-50e2-80090dd5613a@gmx.de>
 <20220102182801.GA22268@wunner.de>
 <27017560.2684465.1641895232612@webmail.strato.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <21c124f6-43a2-7ac8-2fde-a7bebacec459@gmx.de>
Date:   Wed, 12 Jan 2022 02:41:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <27017560.2684465.1641895232612@webmail.strato.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W5ZXNZUmvomns9fZHWeaYhn6U8ZKnwprDdCMksMUzkajbIgXC7k
 iZNFoeSwZHT3kbTlbrf3iDgOeGWAQFJLfnZFLp+o3PB+JKT12byOgPL6c4VhMJoCR8vkmzg
 nWiwQ5R4jwEDg6tuK9i/s5FhbXWNVZfmB29tcG1MNlccdpw4OJpudq8ba/fmQv3lpxOkr90
 9QCaqg6zdtyj80yJaFihA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JzkNfumjzlY=:XQu8umm3dbKkINtCRcA++3
 QTnB+D5ysR9G/t0fRP7yGIlWKU9r/mpHSW6LJSzNXQmy/aOb+QC8KcsLSV5LDOpxISFVasDO7
 tdNQ0kjfaNiGQONFgByzdjU2rx7ra7OiOaKZpQG0OQNWiGKeES0biIktErROUKTEVuMFEXfpE
 sW+DvOpewxGemTP1RetjtcC6XJt0miBmCrEZVv+UCcgmNr6pnWuDzk9pRmd/ub/9nFuHgr8HP
 VQFls63dzJylCHckZJygbrDfeKWBIs/6ShDmxeKwcw/i8Jr/nbFneTNRKY7RK5bUYTiByAZEP
 SMGUZjgRmxj/ix2JeS5mNupFO5hQHMTO2hqXLe5fNemV5dcs+rqwry7nCDcZQRFBGtFmZ01C/
 vheyx75evcB4G6FbHMsgGRYU4QVC8roxEcOZR91pi4XDbKxoi0pkjfDDoQJdF3IELeKbJk+xn
 zIL6sJINagZStkzB8uqMbnD2uJDEgjNGM/JZXCZr8nNGiWNZhbLPA5qIoMx1jB5EOfv4+hfBQ
 vQEh0tOfqIPpIZmflk25kWPSXC2yAdHE3oJ1m0ph8XP1MJTY9mOAuDv8NlZH0LOwi/LB99hx9
 2oEj5E73GTDP3HiU7rOpM8SNjRAsJSjmrx8jReJHzUm+q9FearrxH6G9HAlGSOvYJ172P79qP
 4Pr7j3A0JAmNlx+qAYBoRBmK+duwXUrJazojl23cY/dng8cXgtnASOzTaZl5zlpJztL5FACg9
 c+OmR2TTaIXVmMwfEmb3DQA24EG7ZE4NB3X6/xVVv1FYe96PCTe3/VYNNYZjo+9NDpt5Kgpsd
 bbfzE/kuh201ohN9ZV2EUbi+X/azKcPoNMD3xfVsLwMqH+1Sk0DnWEGBs/dy4J7/HQblYdt5d
 ywGEuv5Ks7PAieabExwgAV0vyOYVlQt4pX/PiPFG1EjRPFM7SG4T1GWIZMHlzVGu2cqwONBoM
 dTflsAWPBxIDQFWALVXLg8sB+jlRtkpDRG71CaOdH/nfkMz3sLTbAR2d5Xd+IC/GFgTosRDF/
 W72JbNGB8zjO4BLxHS2L/74b6OZ8EWBL8zRsRzIPpmK17onhHwfKU7Ot4uvyOv2UdE4kMRpsN
 uWPyzWI2bovF/k=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jochen,

On 11.01.22 at 11:00, Jochen Mades wrote:
> Hi Lukas, Lino,
>
> please let me know when I could test again with an "official" linux kern=
el, instead of using my local patch.
>
> Bests
> Jochen

While the fix itself looks good so far there are still some style issue as=
 Lukas pointed out. These issues
have to be fixed before the patch can be accepted for mainline integration=
. Please have a look at
Documentation/process/submitting-patches.rst for the correct patch format.=
 After these issues are fixed
please send the patch as a v2, so we can review the new version.

Best regards,
Lino

