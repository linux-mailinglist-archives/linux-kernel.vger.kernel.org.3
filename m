Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5ED2516F62
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384951AbiEBMSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384943AbiEBMSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:18:08 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9929120B3
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 05:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651493678; x=1683029678;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=upcjxMBu+P7WwqT0zp8eXVNlC+8I1RqcfjsnBpDAUsk=;
  b=XUjugT7GvT4GHKWM04O5wXMZw8cU22iMd0sDTE+9tkIUY4JDRONghRug
   0Vomal8cH4zWgrWZ4ym3478/Xv81UclMchklxYASXM8I/3CcaG5r25zQG
   YsfUOJB8wnDtm1n/0Slejde5rXcP9Prz0EEmkbJr942Ei9GHUjaR0wpsb
   IxxuPXtYeeznGgtwMdZyD0jt1Bhz4VQkSaT1FWxvEG4GTjwydkj2obECB
   mShLyzM6uTP4xDIUJIhK9mNbEXI4b38mhBOQu/oMJbWVpa55VUky+0Xko
   4imM7u+wjrnSy8LyKbOtCtvgv3jNFthESvCu6lzlXciVB5Eyzdop4Y2D4
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,190,1647273600"; 
   d="scan'208";a="303545442"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2022 20:14:36 +0800
IronPort-SDR: ISx7bbVZS5keDKf7JX7oqXXE9Xho5CeaDGl6RUqxnl61DR32TcUCodIwsfdiDGefkb+TTC8emw
 NLZwvprb8daOK2Dq8VThbDLHRaUFHk58JRUCjDJ+5gsPWndy4KnAXgtKDb1E9gw+44z/gGyd6F
 PI1YdnLjUrUBHgtR5MiPl9ydld2AhGGuoO4+aRsaL6XLm0hioleep7pQwU/K6kMCqcxcNM9wTb
 IsOaQv9AHow3xw2xwqyN426pRbJOeJEWn2u3aDeDm15X2II+g4ePjO69rmIRe3u5vAFXRsMbGr
 O544QCktnOd0chWKUFQ/4srT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2022 04:44:41 -0700
IronPort-SDR: 3grF/NDXUQQgyxlHUsJ7HuwPZMOczzbjSXfd7hosS6IAjh3KKOWkYCVK+RpMkIJm6tsgv3ebAM
 CDaB+/KkaEADGxQ4/HpN9LVoQtJQrXn24uHCQ9pEIoR7LSQaa6dS4tVv5QSHCs8jAzqUr/rWj9
 1lnUxHZnSGPBJ41LSotAFAg1UIeFerXbeGfBUv8FmN29nbVvVCfbu45ii1rzroqZemWivf9DSW
 6OOVeVFOGsGxWuRX0+G992eNR+9GtbEiSpbQqRR6lT10M4dJZX0tdM7fw79IoIeXVfpz2yCO0o
 YY4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2022 05:14:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KsMTm5lXTz1SVny
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 05:14:36 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651493676; x=1654085677; bh=upcjxMBu+P7WwqT0zp8eXVNlC+8I1Rqcfjs
        nBpDAUsk=; b=ciG1pDAWwoPGHqJ1HX4eF9v2xlPWggbWDb1uKGSNO/jkj8TEDpa
        ILi9HAbkAFNq5EiDhdSuVQosgo82rHtnp1u+5RraiVW1JKJnulP6lgEwewflYcZn
        SLU2nqSrCmvaBlOlhq/SwUz0aYIxD59HoZfzPFAJDB0k2U9prTJ30nuAfheIJUi6
        cxSGNnQB+pIT+qHg0gj218RXQsNIz7HUN6KLbDp7SK40cYGKfLGC+QPoZ1ef02fi
        CGm1HBmySTkuifTYQNn+nm3D/0IlH3vsNc4RSAOlTiP0Ce5dxFXvF9P5lhzKnytM
        U2jRb8KhbGXd9hS/QVpsB1BuBNTzztKOoGA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zNZ0s2PESyFP for <linux-kernel@vger.kernel.org>;
        Mon,  2 May 2022 05:14:36 -0700 (PDT)
Received: from [10.225.81.200] (hq6rw33.ad.shared [10.225.81.200])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KsMTl4knDz1Rvlc;
        Mon,  2 May 2022 05:14:35 -0700 (PDT)
Message-ID: <260b95e8-74bf-9460-cf0d-7e3df1b1a3c7@opensource.wdc.com>
Date:   Mon, 2 May 2022 21:14:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [dm-devel] [PATCH v4 00/10] Add Copy offload support
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     linux-scsi@vger.kernel.org, nitheshshetty@gmail.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
 <6a85e8c8-d9d1-f192-f10d-09052703c99a@opensource.wdc.com>
 <20220427124951.GA9558@test-zns>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427124951.GA9558@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/04/27 21:49, Nitesh Shetty wrote:
> O Wed, Apr 27, 2022 at 11:19:48AM +0900, Damien Le Moal wrote:
>> On 4/26/22 19:12, Nitesh Shetty wrote:
>>> The patch series covers the points discussed in November 2021 virtual=
 call
>>> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
>>> We have covered the Initial agreed requirements in this patchset.
>>> Patchset borrows Mikulas's token based approach for 2 bdev
>>> implementation.
>>>
>>> Overall series supports =E2=80=93
>>>
>>> 1. Driver
>>> - NVMe Copy command (single NS), including support in nvme-target (fo=
r
>>>     block and file backend)
>>
>> It would also be nice to have copy offload emulation in null_blk for t=
esting.
>>
>=20
> We can plan this in next phase of copy support, once this series settle=
s down.

Why ? How do you expect people to test simply without null_blk ? Sutre, y=
ou said
QEMU can be used. But if copy offload is not upstream for QEMU either, th=
ere is
no easy way to test.

Adding that support to null_blk would not be hard at all.



--=20
Damien Le Moal
Western Digital Research
