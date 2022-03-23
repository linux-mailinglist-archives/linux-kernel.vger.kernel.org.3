Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAF34E4E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242646AbiCWI0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240689AbiCWI0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:26:06 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEB86E7B7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648023877; x=1679559877;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vHgfnIqvx4gqj9+Qz5CGEkAMw0dBTsI78EXcq1RRvVg=;
  b=iQh2s0uKlznYBo6Bz5SfcOVjjmFtmNiVB4tEJcL5/khCefklSTI/xUnf
   kL6CpFbUHtl51rq7vEcrjotYsWo1SUBL/uQAoxadW7pTbz9bf9to5VMbs
   fZJcInyGWt47Ngp7b6pDEM54IVHDGWY3SDoIOmNsUk8PHBjS/fUxnwSg3
   mRlcypBPFL9M6sJ0ihPUz1rIQvImNW+KjrSSGnYkqbapkXqiUHSPCm2hf
   Ij9FglcinhRV+1DZrGBcVCWxD4VG1VhvzooW43W9ODWVuqjtePmVHIo8o
   c2EgbOxQmT+ypt9IINHaeoxY0Mb8iI+jcXzeU9vfDcePjkJN0obl78Za6
   w==;
X-IronPort-AV: E=Sophos;i="5.90,203,1643644800"; 
   d="scan'208";a="307996882"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 16:24:35 +0800
IronPort-SDR: JKLLPK7yVkphSuG9Mmt/rpRsc6ruWNlEjZ1kKxYLcYGh/LFDJ9yNFjkRqRxWiUIkp7c1lDBj7s
 krsmx+VPHuu2mXYLGbX+d1fblpyFA2mAMWon6/gvVJZERCbrLUjcJriK76I36oNzRBgbxvekYY
 RmtxoGYF+4qjzCnj1s1ujSGXZCRbNTYkAVx9lrDauEvOBj1GfCE/X1+oLvqmJV6byG0G9pJruJ
 dgHAWLPUO/IG2SUOpU6inmTbLje/6t4Wv1FcIAVXi2mLze0Gg2x3DZU9iTQ8YZ7IBJTAF0xncH
 7Mzh3uzxR0RidxRY7kWIQDpV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 00:56:29 -0700
IronPort-SDR: KEFIP2p03SJwxI+ZI8IO3ePUYuhDJSsOHfvaVco5Q3PoOBO1UCRnNC/SCx6KInQjqDg9Ja7Jpi
 2e6H2Ovh7sMR60apfNAJtCt/FPxtbR/sAZGNVQ2XggFF3ZpAU9xfNl9JdjOTo8yHzDO5J0Dvbu
 7pdooOqZtkf3CZkD3D01GFdmmXnuRBlYSB70ozBVm3bS6winu7NqpkZSsBEJcxMtrOuSfxSZ/8
 RloCXzIeRIzZtzA95/VdaeA3ITuzlLuMCFT9zUHlaqBEgck1Dt7/Mre+Jqt63mfCOzJtnKMM2j
 Mss=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 01:24:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KNhGq4TXZz1SVp2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:24:35 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648023875; x=1650615876; bh=vHgfnIqvx4gqj9+Qz5CGEkAMw0dBTsI78EX
        cq1RRvVg=; b=QeOURQO6QMEdw+C1fIb7ToRGR8cxhk33N7trqAHH9Sr+0EL9rJn
        944TIHiRTDEE83Ro4gjVFiI7WHug/np+CLTES31GfU+BRt4ye60EdGdz+zc9QsiL
        xHAf8Y5u5w+k05+IT8VM0h/U8Z6iVbTHP4j8PZwyb2jz3nCRNpLkwNdDe5L54PP7
        1GtClfpc1gYGWYgkKu6aBuns3gF8LHK85kRSrSSxdn3lNAwotDEYFYuSfO5TA2oP
        8Gjy8Mbtqj49WlDroOLnWiYlppda35TsachpBipMjnvn8J7gppPLRNGHyyK9qlrN
        hWdsYSdoen5nKmkmaVq3UVa/cfCFJtGRYhQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KfmOL0Keq1MQ for <linux-kernel@vger.kernel.org>;
        Wed, 23 Mar 2022 01:24:35 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KNhGp0rMzz1Rvlx;
        Wed, 23 Mar 2022 01:24:33 -0700 (PDT)
Message-ID: <d9837420-1cbb-ed5e-7043-985d9eb9d065@opensource.wdc.com>
Date:   Wed, 23 Mar 2022 17:24:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 3/3] ata: ahci: Skip 200 ms debounce delay for AMD 300
 Series Chipset SATA Controller
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Mario Limonciello <Mario.Limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
References: <20220321212431.13717-1-pmenzel@molgen.mpg.de>
 <20220321212431.13717-3-pmenzel@molgen.mpg.de>
 <BL1PR12MB5157DDFD5E75360F032346D3E2169@BL1PR12MB5157.namprd12.prod.outlook.com>
 <cc7b4426-f6a6-e6b1-4aaf-0a713ee3d388@opensource.wdc.com>
 <5fb6af7b-d84f-cbae-7eb1-543f3a7e53e4@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <5fb6af7b-d84f-cbae-7eb1-543f3a7e53e4@molgen.mpg.de>
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

On 3/23/22 15:55, Paul Menzel wrote:
> Dear Damien,
>=20
>=20
> Am 23.03.22 um 06:01 schrieb Damien Le Moal:
>> On 3/22/22 06:51, Limonciello, Mario wrote:
>>> [Public]
>>>
>>>> -----Original Message-----
>>>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>>>> Sent: Monday, March 21, 2022 16:25
>=20
> [=E2=80=A6]
>=20
>>> I seem to recall that we were talking about trying to drop the deboun=
ce delay for
>>> everything, weren't we?
>>>
>>> So perhaps it would be right to add a 4th patch in the series to do j=
ust that.  Then
>>> If this turns out to be problematic for anything other than the contr=
ollers in the
>>> series that you identified as not problematic then that 4th patch can=
 potentially
>>> be reverted alone?
>>
>> Not quite everything :) But you are right, let's try to switch the def=
ault
>> to no delay. I will be posting patches today for that.
>>
>> Paul,
>>
>> With these patches, your patches are not necessary anymore as the AMD
>> chipset falls under the default no-delay.
>=20
> I am all for improving the situation for all devices, but I am unable t=
o=20
> judge the regression potential of changing this, as it affects a lot of=
=20
> devices. I guess it=E2=80=99d would go through the next tree, and hopef=
ully the=20
> company QA teams can give it a good spin. I hoped that my patches, as I=
=20
> have tested them, and AMD will hopefully too, could go into the current=
=20
> merge window.

Yes, correct, the plan is to get the generic series queued as soon as rc1
so that it can spend plenty of time in linux-next for people to test. Tha=
t
will hopefully reduce the risk of breaking things in the field. Same for
the default LPM change.

With the default removal of the debounce delay, your patches addressing
only the AMD adapter are not needed anymore: this adapter will not have a
debounce delay unless the ATA_LFLAG_DEBOUNCE_DELAY flag is set.

>=20
>> It would be nice if you can test though.
>=20
> Of course, I am going to that either way.

Series posted with you on CC. Please test !

>=20
>=20
> Kind regards,
>=20
> Paul


--=20
Damien Le Moal
Western Digital Research
