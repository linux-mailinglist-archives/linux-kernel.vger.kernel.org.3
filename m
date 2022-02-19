Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE084BCB1A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 00:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242433AbiBSXFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 18:05:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242214AbiBSXFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 18:05:38 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3CB5371C
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 15:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645311920; x=1676847920;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kHJ/r1f2SyCAt1W8EUkUx9OyONl6xS5Ptg5B6Feh0xM=;
  b=gl6jI01vhc0iKwUhg2pS1oENtEghlQVhIpS2YXTiUzJ4mMtgG7Y7eSON
   q1EVkEW62eGVaMqXxITcCf7QCMQtKNW+2xw6elKPCjRMoJRPeMBPVQtX3
   rgUyKhXLL4ccLLqBzJF85QgFaV6BWm7hmez1+togsKAN55yinLs/PBa1A
   1PCpZ3CbXLAk6Wr0dCvVT+Kuc8mf/UYOfEoUpC+tKJ8aBqUTFmziqCgms
   ttQ6PW8brCzY5j5BLcw/PQV8bs3I7eb+MyeM4xXcvm0w3OgdqORPYhrp4
   JqzjxqCSlVvdk7uz31Vw3LZR5w8TO/x58aeosjujsAiWDCzX4rHla3KyF
   w==;
X-IronPort-AV: E=Sophos;i="5.88,382,1635177600"; 
   d="scan'208";a="194376852"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2022 07:05:18 +0800
IronPort-SDR: mC9/7cPmKvHCFnexLwibRXbw2pwv5aa1xmgl7VAcg/knGkNEqNwOuhP0WssifH1LdGBhcqP0Lz
 +2xv4VTmNypfzYdgreLs9VrbMUim0WqHF2RoQQsMtbLkMZmBzKAb23uhp2uK5fcaEmkAU7U5cS
 +ul09AWKw/iiOx4wIgKpwLPV6QUAvtZpVs1HPPCw3bCNyaTmO+PmSZ2ld5EumphDpWZv+FBqq5
 tnMuxbJmicPFKCdZMq7j9hpZktqB9emlm35ud0QfErUVH647cXpZ/kbc8dOyWGLcRLMMNzrj48
 7UBgzWdLQwI731iRG4WbuaVV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 14:36:52 -0800
IronPort-SDR: 0oUaj1xcx+tsh9RvLJtqh7g00ZLwfjpRcryExEKfbSm6CPmRTj4pymX0MGZs7N6klP/QrthwHl
 LBW9deUbgI++pK4OtFNQYdrMvfnEVZZBxIkuVxh8ahFh5I9j6SY7JBB4mr1l6dBrukN8dsXHWS
 Z0KThkPRcjblEZJFA8ewpSjkqehgqOWUDYE8haPwFgzS/RoQrG3uddeAXXhWwbhdLnZi0fmyyZ
 EZe//yTnurTmA01muNdCJiLNcut241XnxNHY3lv8kBzY9MHHvbo7oIiTDAhrB7CPbriDXt4HWc
 AzA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 15:05:17 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K1PKm3lXKz1SVp7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 15:05:16 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645311915; x=1647903916; bh=kHJ/r1f2SyCAt1W8EUkUx9OyONl6xS5Ptg5
        B6Feh0xM=; b=mvVsPULYTrI6Ny31vsA5J2N+E98vYwcfCrWjY6dhSATKu+Jfbgd
        8KcsE9NjBoTwUXGTRQmcEMuOOWXPh7IUwdqyVC3F1ujvBq5vJD83Xt9tS7C4Pwb5
        l+LZ/r4t0c/yhq3/y2Ae9MRuzVIzF063bZ2Y6STkeca9IAoKNzLWLXRNk9T8Oq6N
        GhEjz2hPaH6Jl5BIG+iQxZGt3ZxhZP19d/fLfRflEWQ3kMu3DUk3XQfx4fYOqbZQ
        Rt3OY0B2oklTst/aBbFE0Vwm9ZWiR1N/2EnXCciljI4GQpxfWF/dL5Ax2/jFg7X+
        nQnvycO72Ady5ddceihZ7O+3vBGuv9KjjDA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RXMb3PVy3ywa for <linux-kernel@vger.kernel.org>;
        Sat, 19 Feb 2022 15:05:15 -0800 (PST)
Received: from [10.225.163.78] (unknown [10.225.163.78])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K1PKj1qGyz1Rvlx;
        Sat, 19 Feb 2022 15:05:13 -0800 (PST)
Message-ID: <8a2b6e4b-6721-dffd-5bfe-70ac8004deaa@opensource.wdc.com>
Date:   Sun, 20 Feb 2022 08:05:11 +0900
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
 <5ecf520e-588c-d756-1cb8-2224535b550e@opensource.wdc.com>
 <yq15ypail31.fsf@ca-mkp.ca.oracle.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <yq15ypail31.fsf@ca-mkp.ca.oracle.com>
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

On 2/20/22 06:53, Martin K. Petersen wrote:
> 
> Damien,
> 
>> This series and my pm8001 series have a conflict. When applying the
>> pm8001 patches on top of these libsas changes, patch 28 has a fairly
>> easy to resolve conflict. Let me know if you want me to send a v6
>> rebased on top of this.
> 
> "fairly easy to resolve", huh? Sure, if you manually rework the entire
> patch.

Sorry about that. It is easy to resolve once you have been staring at
the code for days :) Sending v6 for patch 28.

> 
> Please send me an updated version of #28. The rest of the series is
> fine...
> 
> Thanks!
> 


-- 
Damien Le Moal
Western Digital Research
