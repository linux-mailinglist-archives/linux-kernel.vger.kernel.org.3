Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1F4516F70
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239282AbiEBMUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384987AbiEBMTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:19:53 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B7015FD8
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 05:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651493783; x=1683029783;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Mmb6FF+PbRqpffm582WWKWb30Gfw5wn7OBAUJ+Olo/w=;
  b=WMvJKRUe/RSspfbXQBwUsk77l0Cep54aoTEVxock7jj/NwqwYc0mayNJ
   XP56jEu3Dr10PJ1SAxdu7iXZbkwlild7taGGb59ruMA8uYSwPoZ3+2tZZ
   R4DosJI7q957tTfdRuYd2Nyvn2DSOqbit4aKWhXNhPGSzjTxyRdPYKCnt
   rtdLkzSZZdzBSeektG/iRvFpT7EEYIZlsZ9saRjWbV0cUs5sYUqyQ87Yo
   F0Xvn1+18bkC/9G/jouf8zQS/6mQ+vP3hajJsf34rB1/37Kuo/Pjq4ZlN
   /pVi0oCjcW0BvfWNXnRODOMIQbH/zvoJLEIHwekbCLivcnf6q70IIPsrw
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,190,1647273600"; 
   d="scan'208";a="311305190"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2022 20:16:22 +0800
IronPort-SDR: 1w+5Udh8xA4mf5jhR/aQL/xcoZmNZZ6i97V4MLPiRE7+xUfmF5J1R7fLThJpBbjZ+UqoqOBQT8
 HL26dxqrAOk9K+zrM8LQ58SOQKjmLU/5QwgP5NOBdsqm0w1y3eZQr3G1pKjGRcRDz97Mma+MNg
 OG+VPAT11TJvY1uQUlqTZrdYYhG/lk0+LYc1e9CUYPK+kPO9go624B05kzBANrFSM75uve5XcE
 irNiiwQnmiq+wt/4CZpEl1/WGXxk8NySoQLTz7wIrDWm8ag8WmwAK5W2ozVNE4aMbSSkrc/jyq
 ek4QaWjogwFZYrRpYvL3nobS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2022 04:47:07 -0700
IronPort-SDR: sgkBUKS6jxwnzcGbvWPLFzRMa3pUnYok6BbLUsuxX6tOg3wSUr0rPLVvDmmBbOXlARKPAZRjXr
 DbHsAUamRG/FzU57rf5tVszKW8heEPCGUS4ips+jD6rGGAnkGZw8dTze3zqziTQRKSzkZSTG7M
 6jwaXoLyPuwsXg6YV8v12BUyEKJmXwTwtSNpYEjS0h2amChXnNAySFifoOoll2qCb9NjvmAp6n
 mHKDrL1JLs2T1n30mAqVDV4Wh0pY6z+8l+AIZZcydenJxD+AjrkIVwLdQKQYjRaf23TWwrSnVF
 EtU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2022 05:16:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KsMWp1kSjz1Rvlx
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 05:16:22 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651493781; x=1654085782; bh=Mmb6FF+PbRqpffm582WWKWb30Gfw5wn7OBA
        UJ+Olo/w=; b=ir7xhRFBi2/RFJ2rJ+hllCYGYFtpqylm1j10dApznRoPZPQ28hl
        bFxjt2sR2vMty9t3G8wk1ut6OemckQ8U6VMIRq2VtOg2zfhifar1rB3x3pahn9u5
        zKexf+Sa6EI9PM/Q/jNnMWJTbKRs8jVb7l2ABZ45qOS6mFJxUp7ra6bl/WVe8u7h
        8z2yJwAfAoRPRdFULR6BmBI62hIlyIst9jFWTuwVQIYuqcb7gMG2xTRk/ZRHa/gS
        CkxghkjsBn+XD0zoVQxS52pTzTTXLffRpGReZo/arHkuA29TTc9sn2cO1zNb3Bgk
        PGASNSJNbtoqjhKwhhdSRGm0N7v7RpbLNJw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3eRkE_BfNXeF for <linux-kernel@vger.kernel.org>;
        Mon,  2 May 2022 05:16:21 -0700 (PDT)
Received: from [10.225.81.200] (hq6rw33.ad.shared [10.225.81.200])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KsMWn2C5Wz1Rvlc;
        Mon,  2 May 2022 05:16:21 -0700 (PDT)
Message-ID: <84da2486-7a20-f3c7-43e9-60a29c7429fc@opensource.wdc.com>
Date:   Mon, 2 May 2022 21:16:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [dm-devel] [PATCH v4 00/10] Add Copy offload support
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     linux-scsi@vger.kernel.org, nitheshshetty@gmail.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
 <6a85e8c8-d9d1-f192-f10d-09052703c99a@opensource.wdc.com>
 <20220427124951.GA9558@test-zns>
 <260b95e8-74bf-9460-cf0d-7e3df1b1a3c7@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <260b95e8-74bf-9460-cf0d-7e3df1b1a3c7@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/02 21:14, Damien Le Moal wrote:
> On 2022/04/27 21:49, Nitesh Shetty wrote:
>> O Wed, Apr 27, 2022 at 11:19:48AM +0900, Damien Le Moal wrote:
>>> On 4/26/22 19:12, Nitesh Shetty wrote:
>>>> The patch series covers the points discussed in November 2021 virtua=
l call
>>>> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
>>>> We have covered the Initial agreed requirements in this patchset.
>>>> Patchset borrows Mikulas's token based approach for 2 bdev
>>>> implementation.
>>>>
>>>> Overall series supports =E2=80=93
>>>>
>>>> 1. Driver
>>>> - NVMe Copy command (single NS), including support in nvme-target (f=
or
>>>>     block and file backend)
>>>
>>> It would also be nice to have copy offload emulation in null_blk for =
testing.
>>>
>>
>> We can plan this in next phase of copy support, once this series settl=
es down.
>=20
> Why ? How do you expect people to test simply without null_blk ? Sutre,=
 you said
> QEMU can be used. But if copy offload is not upstream for QEMU either, =
there is
> no easy way to test.
>=20
> Adding that support to null_blk would not be hard at all.

Sorry. Replied again to an email I already replied to. vger keep sending =
me
multiple copies of the same emails...

--=20
Damien Le Moal
Western Digital Research
