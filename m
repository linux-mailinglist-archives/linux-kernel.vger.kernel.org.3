Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4004BCB83
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 02:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243307AbiBTBhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 20:37:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiBTBhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 20:37:36 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2574B4162B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 17:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645321036; x=1676857036;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sA62GIn4J7Vn1J8aTsNQLtDPF43p9ytzlEaBVC5jSkw=;
  b=U/fHwuweJ7Vju6pob2qQYvoUYC3DjAv75I92dHfQaLOtaCAKvHExrSX3
   Tv43ETountj87SD0DAM6jMU9sksdLCNN6OFKEbJ91ip+gyz/Quu4ImVsB
   xvctbNQhy2G9B0pzr4Z06CtUCS3mgyqifFHo9eJjleKGvqL/zgOZOc/RZ
   cYhNv/CIBFYh+fhCn8q45HCe97tziSSC6KzaXpxu0mdalAiVncyUZymCg
   9FkU5dWL3V52uekRCUhtMRKs+XpHusNC6dSQYc5SKMU8stn7AbsufVhYG
   tTfHX8ICijeZGg9Ribx8qJjdr0FCvKlammB58hq/rY3dFrWNKKgE/RXRG
   A==;
X-IronPort-AV: E=Sophos;i="5.88,382,1635177600"; 
   d="scan'208";a="192333133"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2022 09:37:15 +0800
IronPort-SDR: xJ/XfUs+P3qT902250/hlIOxHyQZvY4by7ThW6wYb5RdWSu48ZxAVzDtR1s03ODzziqEndir71
 SVh6BTcXi0lJavDN8u2gBIAwmncy6UjOk/FNaM5BKiReEz+z2yrJrMgdwSWcEphg5wi9uZwp2R
 5I2kGhJ8EtJd7SI9sXR7Kv75ef7oLB77bKOqO2uRha3eOAQg0zgd+rJAQhMInq9oV3+wWjEkiu
 8P9mWzf/LvBjfeyAORrk0l24jfhvtcTAqZVbP2kFChgiXmwxyV35TF0ChFf2vHMS9CUmHIA4Ls
 r+woI8PLAbJSAyIyLdatn8cG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 17:09:57 -0800
IronPort-SDR: 5lHzhG0c/9bLgfs750aTvFsQhmW95+jwBNAtb9w17rMVKXnxL+n1O5t/Tq2q7zFNQ9tdlWE0HJ
 f75GJ5MRgZ86Rlsl/iiAgBF7Jyz5jGH88LiagghtxVHRsCas4yEl33gTRSKdYVnno2RlvnyJM+
 FSMgMBnFE5p/K/N72Nai56thsroGENICRThTQnXLzmolDpwWG+UUgw33m3SzvnatdKHzOLnK3D
 2Jowo/GEDVVHk2e5tJ7sVzzwbSMkf2m7E5tlIT6TuoM5CdgYozL4jtPVhH5opiS4fYe2ePRUQh
 QuY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 17:37:15 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K1Sj649HTz1SVp5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 17:37:14 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645321033; x=1647913034; bh=sA62GIn4J7Vn1J8aTsNQLtDPF43p9ytzlEa
        BVC5jSkw=; b=sMnG9vHr3Nj2EDJv+2DzQnkkhfjha2fa1kvJdm+SzAVf8VH8eAA
        TwLYiYRhPGOcsMd0npt18GrjIQy0UMXEzTwzEMpLHd/biEeExWOfD+JGK7tc/0RS
        sbbmkIziZRHn1NBmWmlyOyMC34pPPZJxOCcTl2Zhqp8ROMWfDN71jGJl+xl+Rlps
        quYi1O9dULdrUtAqUxifXANCmv4pgqeqEPMxJq3JR+HPFtHDGxZoIx+bijcI0XnG
        obgZrxeTmOCpCDy9jO2D+VWOUzNAs3ghh0fm7eoQBamJkWTBdu7FL2Xurmr4ANGE
        Po4KWtZ02aZTn4U13XRaTRTVJ4lbFBpj0wQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PiCaNujmbfRo for <linux-kernel@vger.kernel.org>;
        Sat, 19 Feb 2022 17:37:13 -0800 (PST)
Received: from [10.225.163.78] (unknown [10.225.163.78])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K1Sj33bjNz1Rvlx;
        Sat, 19 Feb 2022 17:37:11 -0800 (PST)
Message-ID: <0d4f988d-881c-3717-f9d8-38739cf17e91@opensource.wdc.com>
Date:   Sun, 20 Feb 2022 10:37:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 00/18] scsi: libsas and users: Factor out LLDD TMF code
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        artur.paszkiewicz@intel.com, jinpu.wang@cloud.ionos.com,
        chenxiang66@hisilicon.com, hch@lst.de, Ajish.Koshy@microchip.com,
        yanaijie@huawei.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, liuqi115@huawei.com, Viswas.G@microchip.com
References: <1645112566-115804-1-git-send-email-john.garry@huawei.com>
 <yq1zgmmh675.fsf@ca-mkp.ca.oracle.com>
 <b9aea895-4b24-4529-0d87-5148e6990c95@opensource.wdc.com>
 <yq1ee3yfhnj.fsf@ca-mkp.ca.oracle.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <yq1ee3yfhnj.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/22 10:31, Martin K. Petersen wrote:
> 
> Damien,
> 
>>> Applied to 5.18/scsi-staging, thanks!
>>
>> Did you push this ? I do not see John series in the branch...
> 
> It's there now.
> 

Got it. Thanks !

-- 
Damien Le Moal
Western Digital Research
