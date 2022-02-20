Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA99C4BCB5D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 01:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242911AbiBTAib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 19:38:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242538AbiBTAi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 19:38:28 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE68354FB2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 16:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645317488; x=1676853488;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DIVsCpJFE7keUNwhK2x1zsb0W8lm6x7ths8HP2F4cRY=;
  b=CH3hZ2awvWnordwt8qQsN8TQ/QlGSxAm8JG0WHcROwJXAoCDeRa+Z9Tl
   s/UIBgDfiBVKkHsqJ//91WR6e01ailKIwuxYe/Fr4orrp/8fqAYFk8PLi
   W//z9E3c7+QfU02DgeBx9McnnKtUGz7vu5syuuDgqQTRsXgRk2e1hTpo5
   LBXFIrQGWTdgjRwN5GregwIHuXR0eVy9xrgvftQ17AuLLT/pDYluOXXA8
   rXp+aXeKY5oDZ5ATMCTpjDDbrsSRajwLEyOleWGjpADnQc7SVbAmWm6qL
   GYESRZZ3bArYskJ78CiF6uCvPRizQqoYgCeJpoumzUf6C23GV1Jdeio4U
   A==;
X-IronPort-AV: E=Sophos;i="5.88,382,1635177600"; 
   d="scan'208";a="297519181"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2022 08:38:07 +0800
IronPort-SDR: +Nc3dXJMQl9BAKJuGGg6BdIQOsqZScrU1+5f0XxIWDarOoUFGfYJY4cmJIQd5VUkh2zW4MXFL1
 4V+V69CLTleo2ZPy4RMuN5mSn0moMLSZ1up9kwwI4/QDCYDgg6+BEAE1XWw8/Q8wJ8POyFnc5z
 P+bOoc0IdotDqvJ/0s9BRIP7099at/ZKykdRzcF9q3M8+LDvzr5nmBySN6+hWnPkcVA9Qi4Tgf
 jliZBruUCPOuGzRLIGaq4sr8eY9G1AHVFrFqrYRPgOLTQkGKRhatFNoGqX/ubmGCmMoZ0Opfs1
 0OTOtd9GuptC26oF9BeEELis
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 16:09:43 -0800
IronPort-SDR: G65s+gwVklmCPXaK2JK51NCR+5ejXcvS6NiZsZ9N+df2ruv5vcYtCP7VJSXCo881+bUVfTS6c7
 GgLdpWrjufdj734FACidUdwFQP7eWs1Dk5j+FDCLmBvGUx0r+MXwvDpl6wT2FuZFb1Bwhor3YM
 coslXLRrcA4lHQROOAQPLh/S9HuCeRP29SR4L6yvwb8hH93zmHceeVKui+Jn6JkmyY927hp5b0
 BUPBploIsqRem6vv8nFmEM+hgRmwsPRYUg0VpCMCQbGMlNuK85swu8u55ROmTYpUxfhypMFhhe
 6Jw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 16:38:07 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K1RNt41ttz1SVp5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 16:38:06 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645317485; x=1647909486; bh=DIVsCpJFE7keUNwhK2x1zsb0W8lm6x7ths8
        HP2F4cRY=; b=Fy59Ld++C/Lu0mMc8exLg8NdLaXDvwfjiL7+uqgIcuR0yBaeHfv
        WZ+YvpzqVGGnKPRRAZtbXTO6HxgurGHEDv8nLwDzxR8VX4KcShBlLKOtPljym7p/
        pPQKfbI/oSIIcgFxlkxAtlfqwWjPT+U4zxhBKegEPzeGxmg9HCwMO9X2BwUB6XxF
        oSV9Wl2PWA4GMya9y6dAk63bsQVyjR4qslyGDnFcSMfmTsKx+5g6q0ZepmR3CFns
        Qv9q/5S0jlDyT8DZ/n5eiKUO0MKEc6v3PKz3nQa9oj1Q9xZIs0QBWHPWXwUJ2YRN
        1m8iN2eQ2kixMZ/GymL5u+jdp2UrRReJIpA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0-cOI_tZMof3 for <linux-kernel@vger.kernel.org>;
        Sat, 19 Feb 2022 16:38:05 -0800 (PST)
Received: from [10.225.163.78] (unknown [10.225.163.78])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K1RNq3B9Nz1Rvlx;
        Sat, 19 Feb 2022 16:38:03 -0800 (PST)
Message-ID: <b9aea895-4b24-4529-0d87-5148e6990c95@opensource.wdc.com>
Date:   Sun, 20 Feb 2022 09:38:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 00/18] scsi: libsas and users: Factor out LLDD TMF code
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.garry@huawei.com>
Cc:     jejb@linux.ibm.com, artur.paszkiewicz@intel.com,
        jinpu.wang@cloud.ionos.com, chenxiang66@hisilicon.com, hch@lst.de,
        Ajish.Koshy@microchip.com, yanaijie@huawei.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linuxarm@huawei.com,
        liuqi115@huawei.com, Viswas.G@microchip.com
References: <1645112566-115804-1-git-send-email-john.garry@huawei.com>
 <yq1zgmmh675.fsf@ca-mkp.ca.oracle.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <yq1zgmmh675.fsf@ca-mkp.ca.oracle.com>
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

On 2/20/22 06:55, Martin K. Petersen wrote:
> 
> John,
> 
>> The LLDD TMF code is almost identical between hisi_sas, pm8001, and
>> mvsas drivers.
>>
>> This series factors out that code into libsas, thus reducing much
>> duplication and giving a net reduction of ~350 LoC.
> 
> Applied to 5.18/scsi-staging, thanks!

Did you push this ? I do not see John series in the branch...


-- 
Damien Le Moal
Western Digital Research
