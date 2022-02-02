Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD9B4A7BE0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348128AbiBBXts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:49:48 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61334 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236839AbiBBXtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643845787; x=1675381787;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=ebB5DIRkM6RPvA708tvHx1B2UHGzS4knaLmymv8Ktlc=;
  b=mkc6w55Y8vU8oYauPKDTf6NLarMicJTl+F9MVTf7xoNgcAR6x2KSLiHa
   k9wzPrGNjHH0MWKyk4WBxO3rRO6NJtBqqwRFSAJjicfe7cuqi/xnauYRo
   p28yLwRMVeyGs9VRcg+osy4fzA0/lKVmD5BDJwegi7l4MTJXx86Wwr0+E
   /xXY8RAqzsi9RimcfAesi8oy8eCQtyMenHD9jJcRrPIVJsxmDVV/33vxJ
   nV2M3Dv3EslmKYP2WODce8s3D5QMb6/XR6gcwc0NJhfXVwypOP3lL4J16
   YFdy6pV9NiJGasWq2PLtflQbYf7PfTDlD6Ab5zQco5FTlq/r3sYF6e+Q7
   g==;
X-IronPort-AV: E=Sophos;i="5.88,338,1635177600"; 
   d="scan'208";a="303922762"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2022 07:49:46 +0800
IronPort-SDR: dZUgorZL7og0ZpX2aIIaHsAnyqYKIc2xVZ+HiEB1s1NbtRVOS1k4ILesHJZ07KVyT64mZR2o4U
 ruljmeoCPrHIJO+AQiCCR9IQqeemo2k5qfq6pFSl6dSv6F5qvjyBD0pVKMENOhJUu+7t/PU61r
 BeHX60DB3c7fAVGi1EHdazIG9iDZm80Jkyh/aWogzMkb1YYy2E6NIwPlneclT6hCY0Ye/M9t4V
 /9VxCo26f4q83k8MLblVTS/1gG6OZDj0Mq94tGw7+H43LBhjrRjIb7FfhiSpeUy2j5fW4wNskF
 21dp74OQ53M4ltucYLjmfSgn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 15:22:55 -0800
IronPort-SDR: 2tHElrbZcQgIbgnDqXK1TYer3J+HBiiRAT5Jxsj8bMa5dFkshb9AfpZBvsQ7eOxWsO1kkLZNNY
 L2rJK+1w9SV0J2t2ODhYRYKa0C9WLENCWsPzTIFU3fHXPL4FqU2Mg7uLcbT6WH20+QFC81djZr
 jLZ/0HsuqU/fBAqSvmm/ZvcAJN5DL5J+EKt0QoIC5ESzMFxKTwGimhOJt03wmsGa3A3TMqvSk5
 w3eE103C+3DJSBw248/EurAQa6NCEAhZezFGDNgYseixYv2KvOTfe1x4C+Kd0z/kg2lvSOcGm2
 Gxw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 15:49:47 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jpz6y2239z1SVny
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 15:49:46 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643845784; x=1646437785; bh=ebB5DIRkM6RPvA708tvHx1B2UHGzS4knaLm
        ymv8Ktlc=; b=dZxceuL0FccPLSlzQsGU8puGmVWmxj9l+YCZ8nAQkRP3dZwiUIV
        af/NeTYVur8RfYyczqEm9WoBNnokDBxL3rikJR821k35AL1rPWRxqGn1HF7SvzGa
        s0xrJEzNFvm/2b45j6YKmjMQVe+qmgny6dk+pp68xYXxQoi6K5/UtUDnA8/XOFMh
        F8mwMh2hNZ8fId1k07NAx6hsqvLMH2xzNv8NeDwuwIlqwt15PLdlE4rIfFNxA1Fj
        d1RryfvmyX2/js+W0Ka5JwumBqzoHasEemp0QT6vRx21dQFhfxbNWhZd9PptKPDj
        szBKM0FnJa3/Ny4ULLoHm9wt4GnUn6Erlnw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vFXYRx7LeZ-4 for <linux-kernel@vger.kernel.org>;
        Wed,  2 Feb 2022 15:49:44 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jpz6v698Bz1Rwrw;
        Wed,  2 Feb 2022 15:49:43 -0800 (PST)
Message-ID: <031eceaf-402f-7bca-10c4-8959e62e7fe3@opensource.wdc.com>
Date:   Thu, 3 Feb 2022 08:49:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] ata: ahci: Skip 200 ms debounce delay for Marvell
 88SE9235
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220201071229.6418-1-pmenzel@molgen.mpg.de>
 <3437ffcb-68b5-04e5-acd5-b3857fbf1be7@opensource.wdc.com>
 <1378dd0a-52d2-c998-5713-e6875c601194@molgen.mpg.de>
 <4c3df325-dc9f-5eed-5585-7d2e5203b65f@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <4c3df325-dc9f-5eed-5585-7d2e5203b65f@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 08:05, Damien Le Moal wrote:
>>> ata: ahci: Add support for Marvell 88SE9235 adapter
>>>
>>> Since it is exactly what this patch is doing by adding a PCI ID.
>>
>> Thank you for applying the patch. I saw the summary/title change also=20
>> with the other patch. I am sorry, but I totally disagree. Reading that=
=20
>> summary/title in `git log --oneline`, it=E2=80=99s not clear at all, w=
hat the=20
>> patch does, and the full description or diff has to be read. =E2=80=9C=
Add=20
>> support=E2=80=9D for me means, that it was unsupported before, which i=
s not true=20
>> at all as the defaults were used.
>=20
> Right... I did not consider the final entry in the ahci_pci_tbl table
> which matches against the device against the PCI AHCI storage class.
> So right you are. I will restore your original commit title/message.
>=20
> Thanks for checking.

Fixed now !


--=20
Damien Le Moal
Western Digital Research
