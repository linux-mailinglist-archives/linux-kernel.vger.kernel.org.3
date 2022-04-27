Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287A3512509
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiD0WJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiD0WIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:08:48 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047B3116D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651097135; x=1682633135;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ltiub3iDq6D6Wb7M/70Y0VAAaW3D7ZlOojkFrPEHoeo=;
  b=Skr8I68pPMUR8cKi472dj8zdn4PkG/n9dfNhokP02ci3cERKVdOZioRH
   frEioB3FZ1BoI3the+3gdpWcVY+VPyHGX4jrhWEWIqrmeEKaChnlK3Maa
   BUH3ogPnKm9tHdOWwiumM/BVL3viCR4/HLGjQ9CoYGWG9ZTOvJb1GOFpn
   Paqsghnds83ZLrmNfJOVTRh1m87xjATOTqtoq6eRvuaCIERqVkrDMPGJD
   sPOIYQUfDVHPLcK9cQmYQPRLh3EdSsoVB8i+vwjx0rISr/yrCZOLvA76c
   /tJVQsmeTNeLTNkwmuu34vWd2RPStbaRCpjQZx4m8v85R74hWSL7kcN8V
   A==;
X-IronPort-AV: E=Sophos;i="5.90,294,1643644800"; 
   d="scan'208";a="198996977"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 06:05:34 +0800
IronPort-SDR: 0r5Q4ZNYO6bh4+cerOAUOdmxTjEP125t8HeUuj67yl3N7ChyEQq/6a+RKXLKtzhqh95Gk6ufr6
 N5didciv4LmkFXmCwMhJEy7Iy7My/kFVdLOSMMo9126FiD8xPrRWLE3H8aJNvH78yMNNxsdT0P
 2glcaZmQUsHgf5RQBgRaiYOrFc+YMVGingxMlCUSn1T++RTiyHkxeOLKCU74kpUDpL7S+HzWlI
 MHwfPN4q4Wi8Cs5+8/QkZMM26k4SKe2HmiGfKS8c5nDAuDLR8kskIxGreTiNLN07mbb1wcSY2p
 i5baUeUrBgHDDkthAS/4BSUP
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 14:36:27 -0700
IronPort-SDR: xotCpNalKIcyU+0M7pNRr4dRqpnD/blx5HRoYy4ZZEdX4m41eKdFK8+F+QeDUECKeb+43OB8Ep
 eGlkuskUK4c4g3rNYXHW3AuwQu9ynyqZSpAAHZ0TG7KB5NCOpXBhnKwjUvYDkgBJxvNsBEHtNJ
 0E1rQgwsKilbvwDhgHNLGUMIPME8vqfFp28WKvBvEvZj49oLGeBk0gnSHXMO3cSSy7YWqmkq/x
 pGNmBTfktPvmUU5v3DSVC7LGtSjfYjn5tIRJ42yGJ1lj7H579c+ieMj8tLhcYro9amZ9X3PBT3
 O0w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 15:05:35 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KpXqy5yfmz1SVnx
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:05:34 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651097134; x=1653689135; bh=Ltiub3iDq6D6Wb7M/70Y0VAAaW3D7ZlOojk
        FrPEHoeo=; b=tf10gyOH0lx9kTAQMvmNEOqbTNS9DLTOZB9qsNe71qSj+MlslLY
        F2EMsRT1hYv8Uex+f8eyJX1V+hNKxnq0ZvLAwm2N9h1bKDM2qAdaXd8XFxq2OFtZ
        V4RlBXCG//INUr7wVIQqFsb2qymtVwVHXuxY8eD6UpYIYKBOcpCxEpfLcPWyOf+Z
        a1goiEri2UoD+WOlXIFCHSZYAnDDnYTLxwQ44EG/xQ6NBuYZ4KdX6hPN8R/IC8+K
        mjJuGAhmLtYWSzjRHY0sOUl5Yj3top3PIke6IkXYtsIwx8o7NXzckBhJqqv2uDvr
        xwDwWqUps86ht4CXLQyUclRDU1FKcwhVZrQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QHkGM9_GOfPw for <linux-kernel@vger.kernel.org>;
        Wed, 27 Apr 2022 15:05:34 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KpXqx1gFtz1Rvlc;
        Wed, 27 Apr 2022 15:05:33 -0700 (PDT)
Message-ID: <c285f0da-ab1d-2b24-e5a4-21193ef93155@opensource.wdc.com>
Date:   Thu, 28 Apr 2022 07:05:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 00/10] Add Copy offload support
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
        linux-kernel@vger.kernel.org
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
 <6a85e8c8-d9d1-f192-f10d-09052703c99a@opensource.wdc.com>
 <20220427124951.GA9558@test-zns>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427124951.GA9558@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 21:49, Nitesh Shetty wrote:
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

So how can people test your series ? Not a lot of drives out there with
copy support.

>=20
> --
> Nitesh Shetty
>=20
>=20


--=20
Damien Le Moal
Western Digital Research
