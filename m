Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A60D55F2AF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 03:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiF2BPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 21:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiF2BPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:15:00 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EBC22BD6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 18:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656465299; x=1688001299;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AYc1C7eAxiSsjnqUN0DfBfGp3xXz3pkgOLsc25aNAnI=;
  b=XzUi4qerupP5mc5cAeD6+DbOmhHTU/v5ELbeEZSjijLe+t6i3IxP6F69
   HThxXnad5DF0fsUn5uNoicZ8pqyJGa1/Cos8o4wjXGUdCPfZ2GKsmbwA9
   kBDP0rDlecq+uXBGwICgZxIk56d4THbjqV52VQIL+rdq+4okHmjGjun+c
   RYH45HWzD2D+KLUcHy9xKwwpVPhQEyuf4psfth/2VLPQeVJa0L5Dw99bs
   8uuMoXKn3PubTIWsAIaYi06MR0Wa+7I8CEOSTikBZAvnXQY563RdVRGCb
   8+PfJz6/DPzqcjrvVJCcKp+WE3e5bJ+lHSg+jgFHVXq/JPn6vwEp1mCIs
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,230,1650902400"; 
   d="scan'208";a="209212492"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 09:14:54 +0800
IronPort-SDR: j3CXdZLrCBLS9ICP40rBNtfRjhdL8HhwqBnLForRWQXHb+AbIIVb5u1QfdRSLOwWIBtVTeGmmq
 LpsBETUudFivZmIwixnU3q4rAC1t4U1GETXJUoTBn4qcLJ1LtANuP2/m6lzvCAROfwdXl1oyM7
 FPL/v53HSJbWTjM78fHbtt96a07mCrsqSJQ7ZoNMJQFmgpClyNtUy47nir4wALeNf6zp/3xF3Y
 C54IsTMPjORG+UoCi80nquUcTuV5batKstAQSV36pChPY4VtMgyHUcVMjztNbQ7ZXpEqRW2PWN
 hBuaA95uMbrUryn9HuERa78x
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 17:37:16 -0700
IronPort-SDR: sjE6FRkllAT5bsZH6LBrxsCRBNPjB4ujitYNXnObmF3khzrBToBbzjKF7LDK6H/zsUSG883414
 xthAtKKYlCLbvUD35eQb0n9CiOiGgTuSsszUZkJNJg55yt/J1OrMJTuRjSs0YFsLDzWMqLkwV7
 4ZAsFRjbqUSS1iMRQTouJL9LgMjWcgrxK64QPfQKNz6LAz2d9iRCJdtOm8aIP+Rsk08njfzhtI
 TgS5slc8P0SyYge/mF1MRwq7NN65984XQ5TCI/wHYstcDREM3lM+sSo/BcTvYpyxuQFOgHdhgw
 jHE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 18:14:57 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXk5q5v7nz1Rwnl
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 18:14:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656465295; x=1659057296; bh=AYc1C7eAxiSsjnqUN0DfBfGp3xXz3pkgOLs
        c25aNAnI=; b=L+6U2OIAVD0dFDb0iy7lxvcqo3tUox6FvfgHf7QQNcBCRFrDd0n
        wohPyiEeCAMGb+PZXUd63cDeaipUrfLckDK+ULIIjKxMqxBA/KJv1MbvfXe5T95W
        a9OJohnTf2PIhLgKoqn6+UOzZnpgQz6yVrVqn3wA2z+rGVvxE0KgUgTUKzWfmXRq
        I/yeTq24PFuQfBIfXM2ZRZKJiz/aVwfFvvVNqideW3tR7WcFf1pw73FjYybJQIuz
        fwhnuyG8M9kf9zrg2wS24fVqUWyhsv80qKzUjpKFvr4oNsi+sAKCl6Jxa9U9/vqB
        XUfO998RBhxIiM8ufMhIZVNacfogOyScx4g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YeoX_yndRDPw for <linux-kernel@vger.kernel.org>;
        Tue, 28 Jun 2022 18:14:55 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXk5p2XxVz1RtVk;
        Tue, 28 Jun 2022 18:14:54 -0700 (PDT)
Message-ID: <9fd807fd-f019-4ad2-7f4f-6746e05098bf@opensource.wdc.com>
Date:   Wed, 29 Jun 2022 10:14:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: pata_cs5535: Fix W=1 warnings
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        John Garry <john.garry@huawei.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1656335540-50293-1-git-send-email-john.garry@huawei.com>
 <16f727b8-c3b0-c828-0c5b-6728a6e7934f@opensource.wdc.com>
 <9044b81f-76db-75de-db74-f45d6e5ea71e@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <9044b81f-76db-75de-db74-f45d6e5ea71e@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 19:05, Sergey Shtylyov wrote:
> Hello!
>=20
> On 6/28/22 11:59 AM, Damien Le Moal wrote:
> [...]
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
>=20
>=20
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>=20
>> Looks good, but I wonder why I am not getting this warning. I always d=
o
>> W=3D1 and C=3D1 builds. I tried allmodconfig now and I am not getting =
the
>> warning...
>=20
>    I can confirm the (fatal) warnings with RedHat gcc 10.3.1... but som=
ehow they only
> occur on x86_64 with allmodconfig indeed (which is strange)...

Compiling on x86_64 with allmodconfig with gcc 12 and sparse-0.6.4-2
(Fedora 36) does not give the warning... Weird.

>=20
> [...]
>=20
> MBR, Sergey
>=20


--=20
Damien Le Moal
Western Digital Research
