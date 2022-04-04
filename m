Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEF64F2042
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiDDXcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiDDXcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:32:33 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ABC4992D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 16:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649115033; x=1680651033;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rfSRzuuOMCPWQIReuJhUJvddgNa1gMHj4PdD7IOpeIk=;
  b=GUfeqamfRJXJY/r2iBmHxrvXJPlmTCjQNEiDmKpqbZspFanbYUk7Z+mP
   XGNO8Y6NaihGdelGIkAONYei6VxyzqaB87ZO0agC0BQcTRhD8FkNVy5eS
   aoVcYynv+AodZCsZNrTRB2aX6xriohJAoCkepsHS9+WfVrAatATMW0vME
   /nmkJ6PtoVfrhnJQdn81ZT3d64OyOfSiTbUDNhSHtcvmjohJH2FJbVIFy
   PRZCnoXFoeoo8xyGKWRgXL4W/NMr5jAitXK+C1kre6G1zRvwjTSKnlvv+
   6dw/G3jN3eAT/4JrmiKEHo5whOmWWSHCL5z8MGm9DT66Gc3XAz2LxXG7r
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,235,1643644800"; 
   d="scan'208";a="197083761"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Apr 2022 07:30:33 +0800
IronPort-SDR: M6TfIy0yazLFeBMa7Nke9/gmtJbU/vneSEoPO1zB59ax9o5oJh/VvXw4/IlhjN1tAsNf72zEys
 U/FxNhxtkCLBT+jV7yodjhInnOCwOV2X1gzIxbaBwzM63EdDSZPjTgD4PiUzmDkObCwtHl+HmM
 jnW5PooYxO9OJ3ijse3uTQJGyjxRfoK6TDCA1Fq0Q7p0WmVYRiuCZ68tn+f1oroOhQejKtXAcO
 okT9IvboryLhwormVgsGFRVQaY5QVjSZLUKvVf46y6/kiNa9+BIfBQnth2EMzdir+Zq2D6lj/a
 gxLgRCiRVcdWOF4cROEOHZX/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2022 16:02:08 -0700
IronPort-SDR: 2l7wa22LP6jk9E5G5BoWxkdg3d5xhdfbZcU0VieTrrUYAh5EjWUh3iSNQdeV4R4iN1FVdNo2nY
 6f1OPLs9WvtbnA28R5sgIMfyz/FWbvuSv5Dk/WAOftypj/BydWTf32pm0lo22u157e4QIgl9Am
 0+BPFvQyKqGg1T2ZRsPJCf+MXUoeR7w4PZzxr1NZIUha9xFPHmfz79Qd7i7QH1xVBmSTTSqABx
 I8gTSRz4W6R/bnBLxwFncPtF4psf2zsj5BJ6tOfwNUHGHM0Jx2UdkZzulnUv0j24acahBuqscg
 JZY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2022 16:30:35 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KXRpf0d56z1SVny
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 16:30:34 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649115033; x=1651707034; bh=rfSRzuuOMCPWQIReuJhUJvddgNa1gMHj4Pd
        D7IOpeIk=; b=MHsLUaVp9zJKMa8HCkY10WpYYu5qCjblWtp40bDtx1W7E/C2SI9
        w5dlxdweXC5QgGXiv1lbNNarzHkaI8e9dignB//e/V7gveloF7OdhzSIAFoLtNCR
        RaviI2xOEkaJZnJX3dUq1vyLkPJeTya2alQOTIF70eBbemCWOrdlt1bQg8eipJhT
        432j3U7gyRkioVXIDMJAkFRSQtS16nhhRP4j/4ptUETJCQiCDahu1TndeheTZlGK
        HT6UYFxJ6are0LR6dN6hXrrKoWK3/ABc+DNc/lgCiw1Dej98JJJ33+Fv2HjbX4yF
        m1K84iEgZNLXmz8zS+YseOEandPz2zLZhrQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DUH_sjCGQzSl for <linux-kernel@vger.kernel.org>;
        Mon,  4 Apr 2022 16:30:33 -0700 (PDT)
Received: from [10.225.163.2] (unknown [10.225.163.2])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KXRpc63KMz1Rvlx;
        Mon,  4 Apr 2022 16:30:32 -0700 (PDT)
Message-ID: <fa0ade52-5d7b-88ae-5c68-c53c2968b852@opensource.wdc.com>
Date:   Tue, 5 Apr 2022 08:30:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] ata: ahci: Protect users from setting policies
 their drives don't support
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
References: <20220303034912.3615390-1-mario.limonciello@amd.com>
 <20220303034912.3615390-2-mario.limonciello@amd.com>
 <a6a17a22-0cde-9c46-0cd7-127be2cd2792@opensource.wdc.com>
 <BL1PR12MB51570E1C17A122179CCB0625E2E59@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <BL1PR12MB51570E1C17A122179CCB0625E2E59@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 04:39, Limonciello, Mario wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Sent: Sunday, April 3, 2022 20:11
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Cc: open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers) <linux-
>> ide@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>;
>> hdegoede@redhat.com
>> Subject: Re: [PATCH v2 2/2] ata: ahci: Protect users from setting policies their
>> drives don't support
>>
>> On 3/3/22 12:49, Mario Limonciello wrote:
>>> As the default low power policy applies to more chipsets and drives, it's
>>> important to make sure that drives actually support the policy that a user
>>> selected in their kernel configuration.
>>>
>>> If the drive doesn't support slumber, don't let the default policies
>>> dependent upon slumber (`min_power` or `min_power_with_partial`) affect
>> the
>>> disk.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Mario,
>>
>> Can you resend a rebased version of this, on top of libata for-5.19 branch ?
> 
> 
> OK.
> 
>>
>>> ---
>>> Changes from v1->v2:
>>> * Move deeper into codepaths
>>> * Reset to MED_POWER rather than ignore
>>>   drivers/ata/libata-sata.c | 11 +++++++++++
>>>   1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
>>> index 071158c0c44c..0dc03888c62b 100644
>>> --- a/drivers/ata/libata-sata.c
>>> +++ b/drivers/ata/libata-sata.c
>>> @@ -13,6 +13,7 @@
>>>   #include <scsi/scsi_device.h>
>>>   #include <linux/libata.h>
>>>
>>> +#include "ahci.h"
>>>   #include "libata.h"
>>>   #include "libata-transport.h"
>>>
>>> @@ -368,10 +369,20 @@ int sata_link_scr_lpm(struct ata_link *link, enum
>> ata_lpm_policy policy,
>>>   		      bool spm_wakeup)
>>>   {
>>>   	struct ata_eh_context *ehc = &link->eh_context;
>>> +	struct ata_port *ap = link->ap;
>>> +	struct ahci_host_priv *hpriv;
>>>   	bool woken_up = false;
>>>   	u32 scontrol;
>>>   	int rc;
>>>
>>> +	hpriv = ap->host->private_data;
>>> +	if (policy >= ATA_LPM_MIN_POWER_WITH_PARTIAL &&
>>> +	  !(hpriv->cap & HOST_CAP_SSC)) {
>>> +		dev_warn(ap->host->dev,
>>> +			"This drive doesn't support slumber; restting policy to
>> MED_POWER\n");
>>
>> Typo here: s/restting/resetting. Also, s/doesn't/does not.
>>
>>> +		policy = ATA_LPM_MED_POWER;
>>
>> Here, shouldn't we use the default policy defined by
>> CONFIG_SATA_LPM_POLICY ?
> 
> If they set it too aggressively we still don't want to honor it if the drive
> can't do slumber I would expect.

True. But if the default is set to a higher performance mode, we should
not fall back to the med-power mode.

We should either (1) fallback to the closest higher performance policy
supported, or (2) not change the current policy at all. no ?

See what ahci_update_initial_lpm_policy() does to check the possible
"initial" (the default ?) policy.



> 
>>
>>> +	}
>>> +
>>>   	rc = sata_scr_read(link, SCR_CONTROL, &scontrol);
>>>   	if (rc)
>>>   		return rc;
>>
>>
>> --
>> Damien Le Moal
>> Western Digital Research


-- 
Damien Le Moal
Western Digital Research
