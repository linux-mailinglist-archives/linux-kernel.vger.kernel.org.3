Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1A05A1F9A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 06:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbiHZECR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 00:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiHZECO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 00:02:14 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB172A255
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 21:02:10 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220826040205epoutp011cbb2313a7410cd0bb813e973d6bfc23~OyTEd7L6f0583405834epoutp01P
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 04:02:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220826040205epoutp011cbb2313a7410cd0bb813e973d6bfc23~OyTEd7L6f0583405834epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661486525;
        bh=MBD3K3P3J3skXsq862gMYBryTHZ/3pcRsvpMXjV0TvM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=sNfIaGURZO/F9rGXradWPE3A7NOSihH5Ag1pH0qf3YlCLwzCALvwQHUSCK1OCcwzH
         PWAd04nMMiepZ3YTx16lVnHtlw0ABvNx8uYbU6BdpYR7NoePt5vQjWM852N5/2wwMo
         0Wz4GfUETEA6/lltop3uA4AybdBy8+WMG0Hjpu6k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220826040204epcas5p450102b67404effa9c07bff82bc6000b9~OyTDs2_rp2832928329epcas5p4d;
        Fri, 26 Aug 2022 04:02:04 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MDR3t6Gy9z4x9QB; Fri, 26 Aug
        2022 04:02:02 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.0A.54060.AB548036; Fri, 26 Aug 2022 13:02:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220826040201epcas5p2f94d6fb31fbe023b369e00812692cbe1~OyTBUGhII0036000360epcas5p2J;
        Fri, 26 Aug 2022 04:02:01 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220826040201epsmtrp194b806a07005414f551503093623c67f~OyTBR4xbN1288312883epsmtrp1N;
        Fri, 26 Aug 2022 04:02:01 +0000 (GMT)
X-AuditID: b6c32a4b-be1ff7000000d32c-a9-630845baf4d7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.BC.14392.9B548036; Fri, 26 Aug 2022 13:02:01 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220826040159epsmtip169049ef95172d791436b30987e887ee9~OyS_oTxDN2569325693epsmtip1R;
        Fri, 26 Aug 2022 04:01:58 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc:     "'Ard Biesheuvel'" <ardb@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "'Alexandre Belloni'" <alexandre.belloni@bootlin.com>,
        <linux-samsung-soc@vger.kernel.org>,
        "'Tomer Maimon'" <tmaimon77@gmail.com>,
        <linux-omap@vger.kernel.org>,
        "'Avi Fishman'" <avifishman70@gmail.com>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>,
        "'Tali Perry'" <tali.perry1@gmail.com>,
        "'Nancy Yuen'" <yuenn@google.com>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Alan Stern'" <stern@rowland.harvard.edu>,
        "'Patrice Chotard'" <patrice.chotard@foss.st.com>,
        "'Patrick Venture'" <venture@google.com>,
        "'Vladimir Zapolskiy'" <vz@mleia.com>,
        "'Claudiu Beznea'" <claudiu.beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "'Benjamin Fair'" <benjaminfair@google.com>
In-Reply-To: <Ywe6/AKzVL/77Fhi@shell.armlinux.org.uk>
Subject: RE: [RFC PATCH] usb: reduce kernel log spam on driver registration
Date:   Fri, 26 Aug 2022 09:31:57 +0530
Message-ID: <07c701d8b900$987dcef0$c9796cd0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE+q3nSdIaCERkMHuLgOUMV1aT/lQIBke/SAkR46wUCQ7PKTq6/unbg
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxje6Tk9pxCrh8LGJ0TX1TC8hNKOtp6qbGRecgguYVt0EcZK055R
        QmmbXpC5izBCpUBBpwZW2QSEyhiz3AW0yJjgCHHMqGwuwHBC5K4pC5YiYy0HN/497/s9z/e8
        z/flZcGcFTSElaoxUnqNXM1D/ZHWn3Zsj+g4yFIIGix84tScHSMW/34CEYslRQyi1DkKEwOd
        zzEi55IDJZzTLRjR+GiQSdztKEOJC1XFCFE60MkgKu25MNF93umV9T3BiNNLv6JER1c2Rnia
        pyDC2dWAECueHJgwe+xoTBB5d/AOTH5b9yk5XtyCke22YYwsbzSRjbUWlBwavI6SN76pw8im
        qpPkkLsaIv+pOIeQF4bdEDnfuDWenZC2T0XJlZSeS2kUWmWqJiWaF/e+bL9MLBEII4RSYjeP
        q5GnU9G8A4fjIw6lqr1hedwMudrkbcXLDQZe5Jv79FqTkeKqtAZjNI/SKdU6kY5vkKcbTJoU
        voYy7hEKBG+IvcTkNNVUtRnR9Qdkjo8sYVlQ6aZ8yI8FcBGoH3EjPszBr0HA1ROeD/l7sQsC
        ZwrKUbpYgMDt+hnohWJpOpdBHzghYG6YR+hiEgLW37KZPhaKR4C2S2bUh4Pw3eC85SbTR4Lx
        ayh47BqDfQd+uBgstNi8JBYrEI8DVycyfW0EDwNXpr9fvYeNS0HOlUKExgGg7+uxVQzjr4Kr
        s2UwPREXLI7bmbTXIdA9ZlnjBIPJnpuYzxfgDj8w46hbi3AAlJ11MWkcCKZuNWM0DgGTxWbM
        Nw/ASVD5PIRuq8DsZcea9C3Qda8M8VFgfAdwdETSVhuBdWmMQSvZIM/ModlhIGfuPkLjUO+D
        FqyZei+vOIWdhl6zrQtmWxfMti6A7X+zcgiphTZTOkN6CmUQ66I01PH/vluhTW+EVjdhZ1wb
        9NfoU343xGBB3RBgwbwg9p5eRMFhK+WfnKD0WpnepKYM3ZDY+9pn4JCXFVrvKmmMMqFIKhBJ
        JBKRNEoi5AWzz+2CFBw8RW6k0ihKR+lf6Bgsv5AsRsmDz5zfeVpPMlgXk/qOSoqFv6PLX2rn
        /7Qzj+CbXRtlD91Z7dUfYb9wfyjKrloeXhitvePqEMcGtxsLS/aWnjXMPc4/Yi374pk043P9
        0weJqprDnbbbBfMxFtuuZXMhJ/u9FevRJIasJ4vBDP1wYALhk38gE4alR52JmdDHLeqwhoSZ
        Y73HUwrcGb32hJGtW1wxoUXV28bZN5IKZn9kFurCEyIr3k79ea91U8C92A3stnCBdMQSVnOf
        f2woPMq/Jb8/r8Yj2l4v8LyULNtw2X1iG/5VnTa2/5nI8XrriuLdUeCf2KxsYr2z4DQlBy4/
        zLv1Abvplcrrua1brMrh/YEXeYhBJRfuhPUG+b9K7Fi3kgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWy7bCSnO5OV45kg6f7jCza3y1jt/j55T2j
        xc/pfUwWM/Y+YLY4v+8Pu0Xz4vVsFntfb2W32PT4GqvF5V1z2CxmL+lnsZhxfh+TxaJlrcwW
        h6buBWo7+Z7dYsLvC2wWuw40slv82vKK0WLvgY0sFv9/NTNbtP1axuYg4nH52kVmj3lrqj2e
        9m9l99g56y67x4JNpR6bVnWyedy5tofNY//cNewem5fUe9z5sZTR49/CKSwes+/+YPT4vEku
        gDeKyyYlNSezLLVI3y6BK+PV0jaWgtOCFU/v/WZvYJzB38XIySEhYCLx+3UrUxcjF4eQwG5G
        ib8rJjBCJKQlrm+cwA5hC0us/PecHaLoOaPEhHONLCAJNgFdiR2L29hAbBEBc4mpnUdYQYqY
        BY6zSdz+8hSq4x6jxLe1p8DGcgqYSnzbOguog4NDWMBbYvuLCpAwi4CqxLrXq1lBbF4BS4nm
        dT0sELagxMmZT1hAypkF9CTaNoJNYRaQl9j+dg4zxHEKEj+fLmOFuMFN4tCTThaIGnGJl0eP
        sE9gFJ6FZNIshEmzkEyahaRjASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4MSg
        pbmDcfuqD3qHGJk4GA8xSnAwK4nwWh1jSRbiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQ
        QHpiSWp2ampBahFMlomDU6qBKW26h0nai5rlrAl/82880kyZ6B3o+LkjXsLiauMd+aPvA7ZN
        zmnO53kkM6P5JUfEzaUmTAGTTs1ekfmn49sSJc3WmbO712wJrY6S2+9yplMzpEDk0bWCWHOf
        fR+qJt/MEiirk27p9/zf/Wr7iluvzjD4a91nDfD8mOPMez0obpsQV9vUWWbqy8+qrP5qZ+LM
        efjKikS9wun6TQ1v+b8c3TqZZ1HhX9/u31sLco/zeczeIyaw54e+mkx6e8f8v6YXaqx86kUd
        TvI8zzN9F6M9w+b1yy+5D+9MYJ25WP3LjB072e6IS926kfFX2zynW0ZM6cqFa7fEV61jvCj/
        lPdFE9fjVJ+nEyZqRTvU/VR2VmIpzkg01GIuKk4EAFXyc9F7AwAA
X-CMS-MailID: 20220826040201epcas5p2f94d6fb31fbe023b369e00812692cbe1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220825170354epcas5p28a5f1a4b13507b5c40ca235560a6ba56
References: <CGME20220825170354epcas5p28a5f1a4b13507b5c40ca235560a6ba56@epcas5p2.samsung.com>
        <20220825170327.674446-1-ardb@kernel.org>
        <065601d8b8a7$6fee5850$4fcb08f0$@samsung.com>
        <Ywe6/AKzVL/77Fhi@shell.armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Russell King (Oracle) [mailto:linux@armlinux.org.uk]
>Sent: Thursday, August 25, 2022 11:40 PM
>To: Alim Akhtar <alim.akhtar@samsung.com>
>Cc: 'Ard Biesheuvel' <ardb@kernel.org>; linux-kernel@vger.kernel.org;
>'Alexandre Belloni' <alexandre.belloni@bootlin.com>; linux-samsung-
>soc@vger.kernel.org; 'Tomer Maimon' <tmaimon77@gmail.com>; linux-
>omap@vger.kernel.org; 'Avi Fishman' <avifishman70@gmail.com>; 'Greg
>Kroah-Hartman' <gregkh@linuxfoundation.org>; linux-usb@vger.kernel.org;
>'Tali Perry' <tali.perry1@gmail.com>; 'Nancy Yuen' <yuenn@google.com>;
>'Krzysztof Kozlowski' <krzysztof.kozlowski@linaro.org>; 'Alan Stern'
><stern@rowland.harvard.edu>; 'Patrice Chotard'
><patrice.chotard@foss.st.com>; 'Patrick Venture' <venture@google.com>;
>'Vladimir Zapolskiy' <vz@mleia.com>; 'Claudiu Beznea'
><claudiu.beznea@microchip.com>; linux-arm-kernel@lists.infradead.org;
>'Benjamin Fair' <benjaminfair@google.com>
>Subject: Re: [RFC PATCH] usb: reduce kernel log spam on driver registration
>
>On Thu, Aug 25, 2022 at 10:53:44PM +0530, Alim Akhtar wrote:
>> >Drivers are typically supposed to be quiet unless they are actually
>> >probed,
>> but
>> >for some reason, USB host controllers seem to be exempt from this
>> >rule, and happily broadcast their existence into the kernel log at
>> >boot even if the hardware in question is nowhere to be found.
>> >
>> >Let's fix that, and remove these pr_info() calls.
>> >
>> How about just change pr_info() to pr_debug() instead?
>
>Do the messages serve a useful purpose that the initcall_debug kernel
>parameter (that doesn't require #define DEBUG to be set while compiling and
>thus can be used with any kernel) doesn't provide?
>
Ah, right,  initcall_debug will do the job.
So removing pr_info() from init call looks good.
Thanks.

Hi Ard
Feel free to add 

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


>--
>RMK's Patch system: https://protect2.fireeye.com/v1/url?k=3b37dc19-
>5abcc93c-3b365756-74fe485cbff6-6a25f0b5c8476bae&q=1&e=752dac9b-cfef-
>4919-8665-
>8a220aac5d96&u=https%3A%2F%2Fwww.armlinux.org.uk%2Fdeveloper%2Fp
>atches%2F
>FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

