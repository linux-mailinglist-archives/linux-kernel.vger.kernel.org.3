Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DCA4D115B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344549AbiCHH4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiCHH4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:56:42 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFA93CFD7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 23:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646726146; x=1678262146;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2p67ZeSQEYzJN6+IMZ2DPIeSrmku0WOj8oNcBKLz79U=;
  b=jJHq3BmqVZA/bqjsGQ3c84ly8Wj0Uo7QgKTeI+fYOnCnmCRfSrmRLhea
   MwV1RWlRSA+fu3fFRF/G2zJVanWESz0tS2L8of3sOGYqxpFeXzjnFIkka
   S18b7krpp6uDDJd2m515Yva9rb2Xq6fPBjr90NQMLKYex0jDWQNJ2m1kx
   bVFIusDbq7WNHdFBfk8aTbJIAiZKoPzX1rIX7DCLEaVvhl75wxdXiEnBO
   ldxRgqXIhiHuDBhDiSIRWLETRXTt5i7YS7queo4qXN3EKzHFCJEAJf14v
   kfpxn5Oa/kilxLu+25jaYxSJElMvVqe9t5hR98g8y1pEER9czZugHMHyf
   w==;
X-IronPort-AV: E=Sophos;i="5.90,163,1643698800"; 
   d="scan'208";a="151206599"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Mar 2022 00:55:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Mar 2022 00:55:45 -0700
Received: from [10.12.73.60] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 8 Mar 2022 00:55:43 -0700
Message-ID: <b5c57978-212f-55c4-2f0b-b38a8f157ca3@microchip.com>
Date:   Tue, 8 Mar 2022 08:55:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Content-Language: en-US
To:     Peter Rosin <peda@axentia.se>, <Tudor.Ambarus@microchip.com>,
        <saravanak@google.com>
CC:     <alexandre.belloni@bootlin.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <du@axentia.se>,
        <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <CAGETcx_yDtX0m4gVKahABvKamUtGg2adL1+6=gwb4U=KEhwm7w@mail.gmail.com>
 <69bb004f-0bb4-ec56-479c-5deab0ece00f@axentia.se>
 <CAGETcx8Bppn1y3Hffp2N_DPcJA6YyMEv1EFDTa1e1zOrkxbxzw@mail.gmail.com>
 <f91c6f22-67a4-076d-d86d-6be1d14bc18a@axentia.se>
 <7edb467a-c8b4-fe29-9947-f71c655caa9f@axentia.se>
 <8484ce66-639c-03f5-c5db-3574ea26690c@microchip.com>
 <075a196f-79c2-0d58-15f9-ad5e33e2306b@axentia.se>
 <3beb80ad-d6f8-8c6a-e17d-e40a644bba07@microchip.com>
 <e47c155a-f25d-11b3-3339-b2bf71b886ce@microchip.com>
 <9e24034e-f586-a721-9031-179601a69abb@axentia.se>
 <7214ea3d-1445-c0fb-2620-cdc3d6167bcc@axentia.se>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <7214ea3d-1445-c0fb-2620-cdc3d6167bcc@axentia.se>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 at 21:32, Peter Rosin wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 2022-03-07 12:32, Peter Rosin wrote:
>> On 2022-03-07 10:45, Tudor.Ambarus@microchip.com wrote:
>>> Peter, would it worth to do on your board a similar test to what I did?
>>> I'm thinking whether the source of interrupts matters or not. So can you
>>> disable your USB and use a mtd NAND stress test as a source of interrupts?
>>> mtd_stresstest together with scp or hexdump.
>>
>> That's not a quick test for me, since I don't have modules enabled.
>> I have located my SAMA5D31 evaluation kit, and I think I will try
>> to get that running instead.
> 
> Hi again!
> 
> I got my SAMA5D31EK board running, using a freshly built at91bootstrap
> and u-boot according to linux4sam.org and using the cross compiler I
> have used from buildroot 2021.08, i.e. gcc 10.3.0, then using the
> dtb for the ME20 from the original post and the same kernel and userspace
> as I have used previously. Now, that dtb describes things that may not
> actually be there etc etc, and I will try with a proper dtb as well
> tomorrow, so this was just a quick-n-dirty test. I also added mem=64MB
> to the kernel command line, to mimic our "Linea" CPU module and get a
> bit quicker turnaround in the page cache.
> 
> Anyway, with that setup I can reproduce the problem on the EK board.
> 
> $ while :; do cat testfile | sha256sum; done
> 5a939c69dd60a1f991e43d278d2e824a0e7376600a6b20c8e8b347871c546f9b  -
> 7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
> 7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
> 250556db0a6ac3c3e101ae2845da48ebb39a0c12d4c9b9eec5ea229c426bcce9  -
> 874c694ed002b04b67bf354a95ee521effd07e198f363e02cd63069a94fd4df8  -
> 7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
> c3a918a923ff2d504a45ffa51289e69fb6d8aa1140cca3fd9f30703b18d9e509  -
> 1577ed72d2f296f9adc50707e0e56547ecb311fa21ad875a3d55ca908c440307  -
> 7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
> 7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
> 
> 
> But apparently only if I have an FTDI usb-serial adapter attached
> while I boot. I also start to get good hashes if I remove and
> reinsert the FTDI adapter, which is interesting.
> 
> $ while :; do cat testfile | sha256sum; done
> 7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
> 7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
> 7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
> ...
> *snip many dozens of lines*
> ...
> 7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
> 
> It's of course hard to prove the absence of trouble, but it feels
> like it is working from both of those latter cases...
> 
> (for the "real" case the FTDI usb-serial adapter is soldered in,
>   with no easy way to make it go away, so it is not as easy to do the
>   same test there.)
> 
> I'll try to reduce the number of local parts of the setup further
> tomorrow, such as the dtb mentioned above and the rootfs. I was
> hoping for a binary download of prebuilt parts, but some links on
> 
> https://www.linux4sam.org/bin/view/Linux4SAM/Sama5d3xekMainPage
> 
> are bogus. E.g.
> 
> ftp://twiki.lnx4mchp_backend/pub/demo/linux4sam_4.7/linux4sam-poky-sama5d3xek-4.7.zip

Okay, that's a bug in the TWiki page.
> What's up with that twiki.lnx4mchp_backend "host"?

URL must be:
https://files.linux4sam.org/pub/demo/linux4sam_4.7/linux4sam-poky-sama5d3xek-4.7.zip

Regards,
   Nicolas

-- 
Nicolas Ferre
