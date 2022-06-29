Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C03E560CF0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 01:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiF2XEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 19:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiF2XED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 19:04:03 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253FA1DA7F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 16:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656543841; x=1688079841;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ptrmLR99DmPF+HuZkx+sytXL0IpohrYTge6kXuvw7is=;
  b=Wi49BNtnBrlddGK7V3DVLlR2IIrnviTVS2fDK9EBCTFnDEayNagMxxUn
   XlqrJbM/sC8wBk71D3Go9j+SM+vBuglsBukSgNtlr0c9nNT4IKeU5dyUZ
   qMEHJvOnnY6klGjpmVCjTpctGL83RGBOYyM9PxjKj29EHAUkVNsT+9aN2
   XW5B1ZcQEkPzxBHzQFbvJrwpvU0nIRfFcN32MpvNcvGpiHec62aFAWVVS
   vYHAXsFCR4g7dy9t8ZO3YGccFVI6YjKfPS7lgIOBml3cE8P/2PJSUAZEY
   BVA+xFi9n/xCwVYHuhPpTn3yrBC9KpYBgZUDYHG+SxDwrxzRzKCG4qPft
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,232,1650902400"; 
   d="scan'208";a="308757729"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2022 07:04:00 +0800
IronPort-SDR: 0848zM7eVcrVz3FXwyH6A/zJEqKyyKmdbmoRm+F0W6vZogU34p4WVkdG4MnlR3FtyW5nS2U17b
 4Mb6rEM7OTYZ4dIw2K+/S41eIkUPlWR/0xdvzPE3q5UzuAnFDzA/xyvXcZkxuu9VQJxsWV4W4j
 YWjps3UGlDLguQhCrm1NTcn6XqjF5VX6h68lhdXwXIVTEFPJIJW8o7PejRF3m3UK26dZJwVgj3
 MyTir6WJ1GlvGQ+n/m0nZuoKr3CKNBqRiTjw2Zp1itKboLIsr/2qg1UH5VFSO8BsX1P9J/xoSr
 XhTm89BcqyADKRk4XdoiBrvv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 15:21:38 -0700
IronPort-SDR: YvHmEM916nhzL4pxUvcq5SdNUcdaPbIOuVTiGsO+2m8ET+D3616cEcg+NMerZndT0CbI3ekjiP
 +bCg18V142IoPDvtMiBTMQ1X5wpCb6YFj3GKAqvjvJe4KDRBVo1TyWjUmZmWbY7aiLzZ0Z9Dd5
 R63MOC9RIUmHcAcU94OqCuhQY5zqtpg+Hw8gkZHeTvssFDM8FfbLixrk4G+YaJ5AOK7eLqyPNA
 SBWZZxcf7OjqrperH7dgf0L6CFYejSCaKDHxLoE99W4iS2KUVLOF5sFAY/DvuAUNTN5Of3OCSf
 ePM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 16:04:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LYH8J1tdbz1Rwnl
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 16:04:00 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656543839; x=1659135840; bh=ptrmLR99DmPF+HuZkx+sytXL0IpohrYTge6
        kXuvw7is=; b=O0UEptYFIHQ2xrlcdooiCDQC+bLGyPQ8V0TOJAZfEsIF5Idr1KC
        hePTwDcjoYED3X0mAKifiixDGVaaY39gL3YGagavf1b7NcJvReo6g0BqBUbIHxs8
        vE1HEA0I04aw0+ndOqCXtlzv19ab3mtbSAS9CziyAJAmBQ0vZYBrTDsXTg0DI+Z4
        6OXmSh+Fmyj/ydn2/oaHFzU9XqnBIoLj11uGwnOEhv9Vxn73CM+lvCP+OnfWr1UE
        QA1zMeZ8pBTXhIFSyYkip+aVq8n/RrVrjxpkMo11E5kB/7umgmwqKEkFYzsgstHs
        mf1wz0gyRw4ln5GxbS2lhXOGIvHHUgtxLKQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BM0R-z62-DVd for <linux-kernel@vger.kernel.org>;
        Wed, 29 Jun 2022 16:03:59 -0700 (PDT)
Received: from [10.225.163.102] (unknown [10.225.163.102])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LYH8H0Jy2z1RtVk;
        Wed, 29 Jun 2022 16:03:58 -0700 (PDT)
Message-ID: <9448ff77-9b0e-95fd-1366-a5103fdb3ea0@opensource.wdc.com>
Date:   Thu, 30 Jun 2022 08:03:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: pata_cs5535: Fix W=1 warnings
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        John Garry <john.garry@huawei.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1656335540-50293-1-git-send-email-john.garry@huawei.com>
 <69ed5587-52fd-4171-b97f-091df8b377c6@opensource.wdc.com>
 <9caef01c-b601-c19f-10eb-720e8d7b35dc@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <9caef01c-b601-c19f-10eb-720e8d7b35dc@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/22 22:32, Sergey Shtylyov wrote:
> On 6/29/22 4:51 AM, Damien Le Moal wrote:
>=20
>>> x86_64 allmodconfig build with W=3D1 gives these warnings:
>>>
>>> drivers/ata/pata_cs5535.c: In function =E2=80=98cs5535_set_piomode=E2=
=80=99:
>>> drivers/ata/pata_cs5535.c:93:11: error: variable =E2=80=98dummy=E2=80=
=99 set but not used [-Werror=3Dunused-but-set-variable]
>>>   u32 reg, dummy;
>>>            ^~~~~
>>> drivers/ata/pata_cs5535.c: In function =E2=80=98cs5535_set_dmamode=E2=
=80=99:
>>> drivers/ata/pata_cs5535.c:132:11: error: variable =E2=80=98dummy=E2=80=
=99 set but not used [-Werror=3Dunused-but-set-variable]
>>>   u32 reg, dummy;
>>>            ^~~~~
>>> cc1: all warnings being treated as errors
>>>
>>> Mark variables 'dummy' as "maybe unused" to satisfy when rdmsr() is
>>> stubbed, which is the same as what we already do in pata_cs5536.c .
>>>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>
>> Applied to for-5.20. Thanks !
>=20
>    Why not to 5.19? The warnings are fatal as can be seen from the comm=
it log...

This is only a compile warning and nobody complained, not even the 0-day
bot/linux-next builds, and for years... Most definitely not an urgent fix=
.

But yeah, sure, can do 5.19 fixes too.

>=20
> MBR, Sergey
>=20


--=20
Damien Le Moal
Western Digital Research
