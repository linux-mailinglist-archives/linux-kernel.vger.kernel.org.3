Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97D74CEF0A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 01:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbiCGA4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 19:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiCGA4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 19:56:45 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C2446174
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 16:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646614552; x=1678150552;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nmWt1fzmvUAKgvqkKB/5oOjkEhnHn9g+Bw9Tl/UuTlw=;
  b=OWtB952x64/ILB2Lh329E5bhjDXY79cIK8skNJe0jFmytlRjnuqcvZTq
   5LiqukJ4BRTGoOaZbcmoq459QNU4a4eQ+ZQ6/C+79oCOxeO6kY/WZVieG
   s8MSePtuLLjGP/Nv8uJ+FzIFIZbLQ2IScuZaz8ZTHxe2PE4K+FxvZdoqA
   LnNHby3AyfjgE/kYoDk89/vT9EFy4IGV4ipKt5z1Pe2dd3PCuPsSDNpxX
   MbFgLXAo9/8u1Z1xWQju09XETmEdk9XyyqW4hIr5on3/qpQa3+kYEC2oE
   Y7t+bCM4Pv7MMHmf6KVecwFGvC8qm0f06SyTYsGGUmpoKLoX18ydCDV+W
   w==;
X-IronPort-AV: E=Sophos;i="5.90,160,1643644800"; 
   d="scan'208";a="298751987"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 08:55:51 +0800
IronPort-SDR: 2hZoiAONZczbEOw2y3y4hYDlFoPZaKLacM6Wy9U+DTFpwYbUJf3wyWudHKOZTJHlr2Pm8xPrbp
 1aZpRPIrmpxpJn6ScX9NtjmnhG7BQIWc36LHoWs+rFMpNWQkficIRdskb0MvAWIkpfBHf9JmBB
 nK5MfNkFcgiJcxODC4EJHZ5eWKFgzkvxr4qW9ghKqarAzUhf7BuAUJy5huBuPtNdxiJSfetrm+
 a8qI/XQPvULF6qwtRRBoJyv7IT5HGeY9GxW1rVsw34WBLzRlSXqUYlR4FNrAXavTuCofOsNjR/
 67pakRL5seqXxR3t72sVoMdW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 16:28:09 -0800
IronPort-SDR: 8vCxws0eyun8TpegdXqv+yXKn7pBmXpDQNAaRy300ZZMJ7B/wK5XdWlqD+EuB1HC3XdczFF8SU
 HoAm2EZcGet46Z3BPBki0tUUMSgbm+X0tPexSBEhXo3lBVd/PheTbt6g7aOwN4EzwUo4bREJzn
 lMvbZzXdn+5XKif7y9vJpVyF+ie3PiuFZ74lxXpVFMLrnDQLwEXS0SdQLZpekTfKn++HlLe7DU
 chekHZM2+F5/QxNdL8trW7fICX0aqc5tFB/1jrDK57WsZe71bnAnpcC/jzEvV5uNZXU7qnWN1v
 StM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 16:55:51 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KBg4Q3M3Gz1SVp4
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 16:55:50 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646614549; x=1649206550; bh=nmWt1fzmvUAKgvqkKB/5oOjkEhnHn9g+Bw9
        Tl/UuTlw=; b=lwl7YTnp/KwzRiR4/2xzCUH+aRlQ3dT8VSfPDiqmb4Kt8ttFwJC
        JJ8T4FMAFqGJUBbVqeXx48RzUg99aIR+NmGtlQNq+/YVt7n2lgfaqvKYBHlR8E0c
        bcTF4c6oMrDKdj4mN7OvnveOf/NHx3ulViWDoT/0EtuF+POGCHwSUk5ptT2zjTSY
        P/kP0kAIVo8m7K4Y87vZmPUbxL+7yvffvycpHWfbrtpjsjpMii50s068z++nTojB
        GEhXhxbUp2MSs1KdJRrY6Z/4BmnJm5mC/1JxLS9wUQp/hE6leaJmOUCWP2GLyHm3
        H9z21CuqegyDM1CG/DJoMuexHFt4/xV+znQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LKkRFYp7_QDQ for <linux-kernel@vger.kernel.org>;
        Sun,  6 Mar 2022 16:55:49 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KBg4M43P9z1Rvlx;
        Sun,  6 Mar 2022 16:55:47 -0800 (PST)
Message-ID: <ca924db7-f137-ce48-a83b-e0079995272d@opensource.wdc.com>
Date:   Mon, 7 Mar 2022 09:55:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] scsi: libsas and users: Factor out internal abort
 code
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajish.Koshy@microchip.com, linuxarm@huawei.com,
        Viswas.G@microchip.com, hch@lst.de, liuqi115@huawei.com,
        chenxiang66@hisilicon.com
References: <1646309930-138960-1-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1646309930-138960-1-git-send-email-john.garry@huawei.com>
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

On 3/3/22 21:18, John Garry wrote:
> This is a follow-on from the series to factor out the TMF code shared
> between libsas LLDDs.
> 
> The hisi_sas and pm8001 have an internal abort feature to abort pending
> commands in the host controller, prior to being sent to the target. The
> driver support implementation is naturally quite similar, so factor it
> out.
> 
> Again, testing and review would be appreciated.

I ran my usual set of tests with fio and also libzbc tests to exercise
the failure/abort path. No problems detected. All good to me.
Feel free to add:

Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

To your V2 with the cosmetic fixes.

> 
> This is based on mkp-scsi 5.18 staging queue @ commit f2ddbbea7780
> 
> John Garry (4):
>   scsi: libsas: Add sas_execute_internal_abort_single()
>   scsi: libsas: Add sas_execute_internal_abort_dev()
>   scsi: pm8001: Use libsas internal abort support
>   scsi: hisi_sas: Use libsas internal abort support
> 
>  drivers/scsi/hisi_sas/hisi_sas.h       |   8 +-
>  drivers/scsi/hisi_sas/hisi_sas_main.c  | 453 +++++++++----------------
>  drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  11 +-
>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  18 +-
>  drivers/scsi/libsas/sas_scsi_host.c    |  89 +++++
>  drivers/scsi/pm8001/pm8001_hwi.c       |  27 +-
>  drivers/scsi/pm8001/pm8001_hwi.h       |   5 -
>  drivers/scsi/pm8001/pm8001_sas.c       | 186 ++++------
>  drivers/scsi/pm8001/pm8001_sas.h       |   6 +-
>  drivers/scsi/pm8001/pm80xx_hwi.h       |   5 -
>  include/scsi/libsas.h                  |  24 ++
>  include/scsi/sas.h                     |   2 +
>  12 files changed, 368 insertions(+), 466 deletions(-)
> 


-- 
Damien Le Moal
Western Digital Research
