Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA574CC251
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiCCQKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbiCCQK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:10:27 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316BB1795FA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646323781; x=1677859781;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GpRawJriRF6isWjZeGSrbVsznzwhVcciAP7KisG1ixg=;
  b=ZcBXnJPmIXOjNbzdjW7wgY/5QXyXKNZy8y84e1eL/uIdvrV5IoQ+xf71
   RLJjN2ELyvQ2Ap0aw/zchzue4rpundqj75ilfteHOvwGbnUU6010E04Ei
   MfIRSVk9WA6s/vcwwAm+3bW1RgwukaWTE2JE0BL0dIH0KcLDybB+I8Aps
   mOnGikArKLx6pu9VO38gHA/eP5TZh/HLtjRz0qUEJ7EN1MOc2lHrCUpCt
   RShyCC0AINRpGdxXKAEWBM88J/2Ci4N0az66YRdf5Hvkd8UUPpUhMycA1
   qweG47jC7JcxyRMcerJGZklJythKGQ+Mnj7NlktdIGvQYCDrcSDaefFEc
   A==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643644800"; 
   d="scan'208";a="194403236"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2022 00:09:07 +0800
IronPort-SDR: IWbBZta4xR9y2gqdy9pyibnOHwmf/ZxOpc/9/swvP8YZZSccrN0oZLE62QmQVjduvwMR/OHG95
 K3UTtUQz/b+GSeTmAuIW0YOjBHwpTwoIw0Z5GnHNQCqsNDrzjgjVakxNtUnafz8+9QBo8igLFx
 ZsKIXe8XAWkof3Y2QW9hxrtFt3lbgVLvW2LnGkbjw6eblenp6SBOZaoFveO8c5x8fwJwLm5yis
 KxHiiKxovZlaqWgcKa+8KVLgoMynsVjAX6MOR4dkQ6D6RzMWdkZdhE90/Egp0PWqqJNre5/u+/
 jPxocayt9ZZN4b26xaGIduc1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 07:41:31 -0800
IronPort-SDR: OA5QLQfOgyhShpcXr3b69IsLSeQKYqiuhV8ifIWApl9ilw4Y0KoPp82IoKkjpt40DsK3SKTLm9
 wyOScAXPQuzYJwjgR1RRMs8koiS/gO6RMrYWPSfYgEdNSk1EMX+KlZcADtiS24lljNl6p4iIx/
 jxi6+RLfF46KvQo/qgeenokZWbs5E4H6Ut8ot54HiCo4VkjpQJWs88GutqIIjWFE9y4/P0jtGZ
 M46/Iw10VIfo+rVXdjBTDYDtTwFSR7MGqT0GALk+BWzXmtZaULny0Ww2OJuPc1wXJlWdHGUypZ
 4mg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 08:09:07 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K8bX335tnz1SHwl
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:09:07 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646323746; x=1648915747; bh=GpRawJriRF6isWjZeGSrbVsznzwhVcciAP7
        KisG1ixg=; b=PBkPB9D9zhQUoMzOI+TefdvrqE4IcZ6LQesZY/a/70NL1U82wFc
        1WzIUi54WLcR7FqT7dkXG6UwnQf8ghzsPWrTjh/LqfFa384pWYOylb1+EjOyenjd
        tGi8DIo/9f/6zgkNre2GOh0Mg50xEVZ2qVIzItR+CJVS/BfQt/jCIoEbu8RZA/lQ
        c9WVoe0Nrcr4CcNNTb1DMH8d3i7zx37URv0s3B7Njj/uz1zXQwr0+G5IYQmWfBN7
        E3duiLthsxlBMUndpPj8npurTL8SYl9hBfWaKNvuRxk23jop61p8gr+oXLICtlkM
        nDgljm9aiFM8Dvg4xXfK2gOz/afao3zXoTg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mjFxx4yylLZJ for <linux-kernel@vger.kernel.org>;
        Thu,  3 Mar 2022 08:09:06 -0800 (PST)
Received: from [10.225.33.67] (unknown [10.225.33.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K8bX137zzz1Rvlx;
        Thu,  3 Mar 2022 08:09:05 -0800 (PST)
Message-ID: <18137b0c-ef7e-bce7-b3bc-9e19d6f1d2c7@opensource.wdc.com>
Date:   Thu, 3 Mar 2022 18:09:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] [RFC] ata: ahci: Skip debounce delay for AMD FCH SATA
 Controller
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220303100453.30018-1-pmenzel@molgen.mpg.de>
 <20220303100453.30018-2-pmenzel@molgen.mpg.de>
 <0a7c8ee9-1e09-75a4-3241-883fc8540561@opensource.wdc.com>
 <edd464f1-916e-191a-3683-45b623604e4b@amd.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <edd464f1-916e-191a-3683-45b623604e4b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/03/03 15:19, Mario Limonciello wrote:
> On 3/3/22 06:23, Damien Le Moal wrote:
>> On 2022/03/03 12:04, Paul Menzel wrote:
>>> AMD devices with the FCH SATA Controller 0x1022:0x7901 do not need th=
e
>>> default debounce delay of 200 ms.
>>>
>>>      07:00.2 SATA controller [0106]: Advanced Micro Devices, Inc. [AM=
D] FCH SATA Controller [AHCI mode] [1022:7901] (rev 51)
>>>
>>> So skip it, by mapping it to the board with no debounce delay.
>>>
>>> Tested on the MSI MS-7A37/B350M MORTAR (MS-7A37).
>>>
>>> To-do: Add test details and results.
>>
>> Please squash this patch together with patch 1. Since you are adding a=
 new board
>> entry definition, it is better to have a user for it in the same patch=
 (this
>> avoids reverts to leave unused code behind). >
>>>
>>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> I am travelling so could not test this exact patch just yet, but I ra=
n
>>> something similar for several weeks already. It=E2=80=99d be great, i=
f the
>>> desktop and AMD folks could also give this a try.
>=20
> As we are trying to drop the low power definition for 5.18, maybe can=20
> this wait until 5.19 so we can see if that sticks so this doesn't get=20
> caught up in possible reverts?

The "no debounce delay" addition is a valid change regardless of the "low=
_power
is default" change. So I do not think this is an issue. But you will need=
 to
rebase your patch to include this change :)

Going forward, I would also like to have the "no debounce delay" as the d=
efault
too, after the low power default change settles and hopefully sticks.

>=20
>>>
>>>   drivers/ata/ahci.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>> index 0fc09b86a559..44b79fe43d13 100644
>>> --- a/drivers/ata/ahci.c
>>> +++ b/drivers/ata/ahci.c
>>> @@ -456,7 +456,7 @@ static const struct pci_device_id ahci_pci_tbl[] =
=3D {
>>>   	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
>>>   	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD=
 Hudson-2 (AHCI mode) */
>>>   	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>>> -	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power }, /* AMD Green Sa=
rdine */
>>> +	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power_no_debounce_delay =
}, /* AMD Green Sardine */
>>
>> Really long name, but I cannot think of anything better...
>>
>>>   	/* AMD is using RAID class only for ahci controllers */
>>>   	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>>>   	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
>>
>>
>=20


--=20
Damien Le Moal
Western Digital Research
