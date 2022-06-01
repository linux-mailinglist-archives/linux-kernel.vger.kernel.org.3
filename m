Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D9D539FF5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351041AbiFAI6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350991AbiFAI6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:58:41 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EB45B8B0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654073919; x=1685609919;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yekFtGAN4w5p9PA5IUJd0rrnGMpkzjL2GetVtAzLt5g=;
  b=OoXwJdAQcEvlSjd+6WxSebotWwp6aQfUPOH+Zt0IiN2mgMdOiPDtkejS
   H1MW4FFSHABnPPL7Pk0T2q71Gpq59V6HZTgmPXRlwYSQ4Q3k2ho8P73Dc
   G4JzBdPNzcm2rKVR5ZivmcE3gaDJLXG+qbC67+SJNzBhJ8ojfXFvMXOXL
   wOVUjG4XvyZVVnrBgv9pKiRbjGE3Uf4qNnDjxYXDuNUBC4pDDLP3UZ5uT
   sSchdemA1yO14I1kusj2l2xI2mSiPztEz21Cy+1LGy8K6/Pe8kOa9VdIS
   Hg9ilSs7Hx+jqkHRakq6cTQhkyHXrX5GpQ0aIFEbzmfechWA1NbJn3gy8
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,266,1647273600"; 
   d="scan'208";a="206835107"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2022 16:58:38 +0800
IronPort-SDR: IVTBIen0mvYA32A3XgxVP/U+8kezkBzy4CcyA+jHjWSlwba+IlhIyRwgPz0wzDKmXfs8xZBoJr
 grby71ndkC7NEfkgIPQ++mhvH1iXrp5MJUxWRvgkvOi8zTxc97We4uqAttZi8YmczlzdS2jgGA
 nCAcVdtXGwfaRiKcyE4LrupKA03zf5itvDozq/UKtBbHrh/CtltxR3zrE1pGealv890a1YU9/O
 dg2iQZMQVpyheNjkCmvi8s34DzRLxtSjTCoguow+e8BUu5BoNb3carFELKD9u/uXElKo4P/tTw
 QXaOWtIaZk98R4ycQSSyukey
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jun 2022 01:22:20 -0700
IronPort-SDR: yNnfB7HTNnm9ZHMU41EbnWIuWppmgETQgCd+5/V8fXX1L+UccZ57bRZn5EhPeDKvCrHTMyXUJK
 QSSl+/5IvxqcAJs3xIgxaYeoZ8VCh67oNv6hyRfOuIODVSqwuk+9g5vgx9cPswpoCGHAwDnPyx
 UnC+BShXzZuiUTxBCQXRdgoNiR3yJdP+cVvOvxmq/lANbVPnMNoP7moAEZxfNjDye9Td7fbtdb
 js3p1SN8GhdLP18xS+oJY7BoiNXQOHNd+o0Z7kBFNLJFKB+4nFfvGuS7oRyBDUhtAZfdy7eUzw
 L98=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jun 2022 01:58:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LCjjp1lVcz1SHwl
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:58:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654073917; x=1656665918; bh=yekFtGAN4w5p9PA5IUJd0rrnGMpkzjL2Get
        VtAzLt5g=; b=eO0FLVRiepamJCS9LGoLsEj2MVtNlZuwkihjqgxxKyIKnF394Ho
        yW043E6mDLqEhmAWVEdQ4QyxU22FpSx9II99fLTKBJe/woxFIzb3vZYsLeZPqjBE
        DTmPISUK4UjJcO17oV80au9sFEyORaCJQvoGw/Ai9Vth9Kzz20g2ipfm0xwfFywO
        AksUlbBGAjFCaeftHdGGbIcL1x6vsO+6t3rbfZ6BnWuSPS6LOnHS2dvPwz+q/eEG
        53hTJ/sKgyJO2F/aIbRDlqpU5KQGRA1zULKDHw52bWjbtBsJQ/GE9iJRzaOJ9Ru+
        RXRDXqFtwy6I+oA8tzPNVn5e3FJRvurwJpA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SChruGuBDXfX for <linux-kernel@vger.kernel.org>;
        Wed,  1 Jun 2022 01:58:37 -0700 (PDT)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LCjjm6M3jz1Rvlc;
        Wed,  1 Jun 2022 01:58:36 -0700 (PDT)
Message-ID: <3135eed0-b7e3-42fa-5b6c-80360f34e428@opensource.wdc.com>
Date:   Wed, 1 Jun 2022 17:58:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] ata: ahci: Skip 200 ms debounce delay for AMD 300
 Series Chipset SATA Controller
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Mario Limonciello <Mario.Limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20220321212431.13717-1-pmenzel@molgen.mpg.de>
 <20220321212431.13717-3-pmenzel@molgen.mpg.de>
 <BL1PR12MB5157DDFD5E75360F032346D3E2169@BL1PR12MB5157.namprd12.prod.outlook.com>
 <cc7b4426-f6a6-e6b1-4aaf-0a713ee3d388@opensource.wdc.com>
 <5fb6af7b-d84f-cbae-7eb1-543f3a7e53e4@molgen.mpg.de>
 <d9837420-1cbb-ed5e-7043-985d9eb9d065@opensource.wdc.com>
 <b3e4435d-335c-1aba-1920-c225b46d09e7@molgen.mpg.de>
 <f6c78650-f22f-fcaf-a660-b1fc4ea7f641@molgen.mpg.de>
 <22f69d9a-7d0d-a408-70b3-11295f14b82d@opensource.wdc.com>
 <67950993-2eb9-c180-7c80-98c9954c9b22@molgen.mpg.de>
 <85f8c8cb-b4b9-b3ed-e79f-a1a161c9b672@opensource.wdc.com>
 <65012735-0a92-1071-e8e0-9d101c247a64@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <65012735-0a92-1071-e8e0-9d101c247a64@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/22 01:18, Paul Menzel wrote:
>>>> With that in mind, I am not planning to apply your previous patches
>>>> for 5.18, as they would conflict and would only end up being churn
>>>> since the delay removal by default will undo your changes.
>>> Obviously, I do not agree, as this would give the a little bit more
>>> testing already, if changing the default is a good idea. Also, if the
>>> conflict will be hard to resolve, I happily do it (the patches could
>>> even be reverted on top =E2=80=93 git commits are cheap and easy to h=
andle).
>>
>> The conflict is not hard to resolve. The point is that my patches chan=
ging
>> the default to no debounce delay completely remove the changes of your
>> patch to do the same for one or some adapters. So adding your patches =
now
>> and then my patches on top does not make much sense at all.
>>
>> If too many problems show up and I end up reverting/removing the patch=
es,
>> then I will be happy to take your patches for the adapter you tested. =
Note
>> that *all* the machines I have tested so far are OK without a debounce
>> delay too. So we could add them too... And endup with a long list of
>> adapters that use the default ahci driver without debounce delay. The =
goal
>> of changing the default to no delay is to avoid that. So far, the adap=
ters
>> I have identified that need the delay have their own declaration, so w=
e
>> only need to add a flag there. Simpler change that listing up adapters
>> that are OK without the delay.
>>
>>> Anyway, I wrote my piece, but you are the maintainer, so it=E2=80=99s=
 your call
>>> and I stop bothering you.
>=20
> I just wanted to inquire about the status of your changes? I do not fin=
d=20
> them in your `for-5.19` branch. As they should be tested in linux-next=20
> before the merge window opens, if these are not ready yet, could you=20
> please apply my (tested) patches?

I could, but 5.19 now has an updated libata.force kernel parameter that
allows one to disable the debounce delay for a particular port or for all
ports of an adapter. See libata.force=3Dx.y:nodbdelay for a port y of
adapter x or libata.force=3Dx:nodbdelay for all ports of adapter x.

I still plan to revisit the arbitrary link debounce timers but I prefer t=
o
have the power management cleanup applied first. The reason is that link
debounce depends on PHY readiness, which itself depends heavily on power
mode transitions. My plan is to get this done during this cycle for
release with 5.20 and then fix on top the arbitrary delays for 5.21.

Is the libata.force solution OK for you until we have a final more solid
fix that can benefit most modern adapters (and not just the ones you
identified) ? If you do have a use case that needs a "nodbdelay" horkage
due to some constraint in the field, then I will apply your patches, but
they likely will be voided by coming changes. Let me know.

Cheers.


--=20
Damien Le Moal
Western Digital Research
