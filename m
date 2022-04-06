Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286904F626F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbiDFPA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbiDFPA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:00:29 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE554757D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 21:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649219934; x=1680755934;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=l1Bm7QPPtqmpP24p4868SaRdvCArEDBF3cayUe1+0rc=;
  b=jHwA3LD6YmbPvsleoQx6Za4Jnoq3GK06r/LzyeCjezgnonyDWoyfhri2
   2fV96z9agw5UWoceD16WK9puuj4OZiGedqbwMlXTnjQ1OQFFPppxGa694
   fMKm8k2bI3sVDcOUbd9DvWG3pAnl1iov0AYvc4eLXkvipPVlo6SnxFoDv
   xC4/EJ52iYre/pdRWxU4pOsADyVNllhRs3M5xbUl8ccCeKN2TpxxJq/+z
   LgPD6e7lDD/KM7/1ZdUU4EMeCXsm0usFhj33jARDD7o3dxsLph0MH44Jf
   CAnkTUeDNaYkAmYpuo4g84zdEV9zzJmMsL7tjzF/LzZguy9cqQVPcKsXw
   A==;
X-IronPort-AV: E=Sophos;i="5.90,239,1643644800"; 
   d="scan'208";a="309164968"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2022 12:38:53 +0800
IronPort-SDR: xTcTzmHW8E6ko7iT7B86ira8wiU02JfIxm5DO8BUmJ6hNulA/qWdZyk2VKMvz91+Yw2v4Tug0h
 HIjPes45vLrxtuB+NcGQeJAjaO31ddiwDekEa7aIkFplZyP2BBBQkTinqbpIpBRYQ7cHUYJhwC
 XjYx7jbrgrKFwQZlBqxX4c7eEkVBMmzw8HYkLA76JFRAmmXIEF9LCeptUZVa7s0e02fnAx2Qu6
 WylPZrtkp/vu1GpTb7bYgfsvcW1cHuA5zGFmHJ4neKeYNC35+toMnYzmt/N0rVTR9NeQjYtjm4
 qzNwrAlzNXhL6WCpCWEAuVRb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2022 21:10:25 -0700
IronPort-SDR: yx/r0jv/LU8XpPTksMDa2yo+nSfEPRlw9RKsRSK41w7HkmRBuBQQXxjIEILmRz1fQFNfSTo2bX
 Q3tCBjO3tUJSm7FexR5AV/CdwwDmrYFPGZFMEQhEplf4pglSHEm2CQvgH433yPP1yKVf0Xlg6j
 +3mp3Qb983886iDhiyYwDjGJ6MQW+CeK8xWVL1e4qoRL8EGdC4HhSPAM9jWXx131T+HQ39ZQ4l
 5p9lyxSViDx1laUOuoK2WEbcxLPTbri33l34KIJA7X/oqPbCnAJBdz2kOjFCiA85MrFe3U4hdb
 glY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2022 21:38:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KYBbw64mVz1SHwl
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 21:38:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649219932; x=1651811933; bh=l1Bm7QPPtqmpP24p4868SaRdvCArEDBF3ca
        yUe1+0rc=; b=d0J7xioqe1a+JudR9zIq5NAOApZ7ocwlGuC9inMvQaBYQO+l33X
        SNnY2bfebSpEAXwdb+SPZqtvdRou0LWgiId4p+wfRUeeK1a5ypT5iO1FSSetIGeE
        CqRoG6b9GjiyzKUufu8+5i9plg/BoxDr0oXrraWRfb81dNOaK3jTQFIFx7lWunAr
        PGUc30ZvQ1lX7sbnU9KWqtBnf7KPMFmvIXBm6lAuQLMONS4bD8YTopsNsxgyOPR8
        O53fclp8X7wDB4BUhVS/hVdp8EWJ4d4XRzXtscVNGxzQug5EBwvL2bVU1Vb2yKzv
        88kHoxc8lMHLRpMxuiRZEIArqXWk/OC2aLg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id knDgK2CSD39D for <linux-kernel@vger.kernel.org>;
        Tue,  5 Apr 2022 21:38:52 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KYBbv5dWjz1Rvlx;
        Tue,  5 Apr 2022 21:38:51 -0700 (PDT)
Message-ID: <0548f45e-5ab6-c905-2d49-ab52fbf4c098@opensource.wdc.com>
Date:   Wed, 6 Apr 2022 13:38:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/2] ata: ahci: Protect users from setting policies
 their drives don't support
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, hdegoede@redhat.com
References: <20220404194510.9206-1-mario.limonciello@amd.com>
 <20220404194510.9206-2-mario.limonciello@amd.com>
 <67c7780d-79aa-cfc2-82bc-ccca8ca4af69@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <67c7780d-79aa-cfc2-82bc-ccca8ca4af69@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 11:24, Damien Le Moal wrote:
> On 4/5/22 04:45, Mario Limonciello wrote:
>> As the default low power policy applies to more chipsets and drives, i=
t's
>> important to make sure that drives actually support the policy that a=20
>> user
>> selected in their kernel configuration.
>>
>> If the drive doesn't support slumber, don't let the default policy for=
=20
>> the
>> ATA port be `min_power` or `min_power_with_partial`.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2->v3:
>> =C2=A0 * Fix typo
>> =C2=A0 * Try to reset to CONFIG_SATA_LPM_POLICY unless that's too aggr=
essive
>> =C2=A0=C2=A0=C2=A0 then take MED_POWER.
>> =C2=A0 drivers/ata/libata-sata.c | 12 ++++++++++++
>> =C2=A0 1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
>> index 044a16daa2d4..b41de7e03dce 100644
>> --- a/drivers/ata/libata-sata.c
>> +++ b/drivers/ata/libata-sata.c
>> @@ -13,6 +13,7 @@
>> =C2=A0 #include <scsi/scsi_device.h>
>> =C2=A0 #include <linux/libata.h>
>> +#include "ahci.h"
>> =C2=A0 #include "libata.h"
>> =C2=A0 #include "libata-transport.h"
>> @@ -368,10 +369,21 @@ int sata_link_scr_lpm(struct ata_link *link,=20
>> enum ata_lpm_policy policy,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bool spm_wakeup)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ata_eh_context *ehc =3D &link->e=
h_context;
>> +=C2=A0=C2=A0=C2=A0 struct ata_port *ap =3D link->ap;
>> +=C2=A0=C2=A0=C2=A0 struct ahci_host_priv *hpriv;
>=20
> That does not work. This function is used by the ata_piix driver too,=20
> which is not ahci...
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool woken_up =3D false;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 scontrol;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int rc;
>> +=C2=A0=C2=A0=C2=A0 hpriv =3D ap->host->private_data;
>> +=C2=A0=C2=A0=C2=A0 if (policy >=3D ATA_LPM_MIN_POWER_WITH_PARTIAL &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !(hpriv->cap & HOST_CAP_SSC)) {
>=20
> ...which mean that this flag needs to be moved to struct ata_host to=20
> keep this function generic for different LLDDs.

Here I meant having a ata_host flag equivalent, indicating the adapter=20
supports slumber state.

>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 policy =3D (CONFIG_SATA_LP=
M_POLICY <=20
>> ATA_LPM_MIN_POWER_WITH_PARTIAL) ?
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 CONFIG_SATA_LPM_POLICY : ATA_LPM_MED_POWER;
>=20
> I really prefer an explicit "if () else" for readability.
> Also, please revert here to CONFIG_SATA_MOBILE_LPM_POLICY.
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_warn(ap->host->dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "T=
his drive doesn't support slumber; resetting policy to=20
>> %d\n", policy);
>=20
> s/doesn't/does not
>=20
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D sata_scr_read(link, SCR_CONTROL,=
 &scontrol);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rc;
>=20
> Also, as patch 3 of this series, can you add the patch that changes=20
> CONFIG_SATA_MOBILE_LPM_POLICY to being "3" by default ?
>=20
> And please use a cover letter when you have more than 1 patch. The=20
> change log can then be in the cover letter instead of in each patch.
>=20


--=20
Damien Le Moal
Western Digital Research
