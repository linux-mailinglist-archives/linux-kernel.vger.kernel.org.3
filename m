Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0874BB09A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 05:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiBRETQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 23:19:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBRETO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:19:14 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB4113195B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 20:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645157939; x=1676693939;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NHtkgbMh6NXQ8widMJrekjBEmQlk/5ZVl1GQklUkRAU=;
  b=SJkgp/PfaRLBB6E7DLex0XQwAl3t8nBb15gyTSWLqqFz+tQirmkbxNdg
   RwmJG4a5CMzSdmLx4GTSJ01XbVYqbpVRzVfFPgJ3Df5TV45ucRTVTQ8eN
   gNFOgvMZPjuEHjXi5lkWxgJeT81BPDUduODtrk2/bhn4nkMV06NMiBWei
   QKD31ml5IWBwYaR162OQSTfXbnm+Dd2AQEeVvT0UyPvhZpJbGaZS/xPGy
   p8LlW43FuohxjsuQ9gpsv2JSXjp8VwJ+p5QZev0zgdlov8nM6L1HDCUF9
   doinLHbkTM6mrkkBN5y72pzTACsNAqWUeyWzKCUQxFkloOWn/+XwzPnpR
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,377,1635177600"; 
   d="scan'208";a="194229786"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2022 12:18:57 +0800
IronPort-SDR: H8FLT5K0SXRVq6TjpSzFLsrmit3jAkvMBS0CHc0UWpNVmAOK3mQcFQOt1VtRgkHEnZZAoWuq56
 p8CyI6ZwqBQQ/ajE/NLD/Tzem97LNHZl6ch9obtC4jZnkWphF3RNfj56x6E3DwiLQbKeiwe2hP
 /GV8FMh3jcgpbox6uQT9SnkK0q0ptsXNmebV/1rpSsNlBBwXOaYgYkwuoC8egoA9adrBhonoqA
 hpBHHRm4pSj6EY3DQYO1StX+2MGbWe9cyy5+e+LPN4w4seCIkxz3vPIhUYNscSqnXBY1/3csXM
 5cuxzTUCuxZGjQ8OagFScVNs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 19:50:33 -0800
IronPort-SDR: MuBRD4N+c1h4bJTlCrZH15QnuMJ9Fs8g326wsJDrsDMKI+CD8tbk7jOcTRD7nFYd1Ztzc2jHdx
 M3J17G5ncV7rS4PmLEvEP+peksKYAA6DQMTnsYf/7UaiucsTT3xhdFVxoXOkEmSLYWgARuvUyf
 +ISW9RJ/zPsk6reSWMM90EvuTOc9LIntVQiRomUruWD4GBPKouzxlUP8ZaGBz2bfF3zlsYf7MR
 T8Vien4ytzfTYYwuQbr3qDs0Fa6kmAYNQ29oVOjZ6JlMNzZBTncwIt3rYnraC9RusxHcmY1m6f
 A4I=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 20:18:56 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K0JNb1pQNz1SVp7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 20:18:55 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645157933; x=1647749934; bh=NHtkgbMh6NXQ8widMJrekjBEmQlk/5ZVl1G
        QklUkRAU=; b=qtG86AepzypzOHFq4PqMoqkS5YbSGB0RYRLaBHmsDX4yZb1aEKb
        LPHHgRKPVeUUjaD68MKGugmNlK9gReNg/E13JKTrZCDem5620LTPWX25tyVyKeCP
        eFy9vSGehdJ+q55/4kuxKLxn1SK+o7QDOe1LLB1MmQfCCOiH9iVG4gwkBgp4chDK
        2nzP9h3byeo1Umji/RC/mCYm2Wrl+nJkp3vuWueeyhnCXNBMOzn63KPFuCzVjicZ
        4rDK9hyjxDjmRqM5fn43KapPvAe4B/I6RTcQj+4/n7JxuChpsKOmqVssD3I5I9Z8
        20tClbD2Zh+uTMsG5Tasn4vzlOT+VqjY4Cw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GkLBEQxUi1gl for <linux-kernel@vger.kernel.org>;
        Thu, 17 Feb 2022 20:18:53 -0800 (PST)
Received: from [10.225.163.78] (unknown [10.225.163.78])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K0JNV75Syz1Rwrw;
        Thu, 17 Feb 2022 20:18:50 -0800 (PST)
Message-ID: <5ecf520e-588c-d756-1cb8-2224535b550e@opensource.wdc.com>
Date:   Fri, 18 Feb 2022 13:18:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 00/18] scsi: libsas and users: Factor out LLDD TMF code
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, artur.paszkiewicz@intel.com,
        jinpu.wang@cloud.ionos.com, chenxiang66@hisilicon.com, hch@lst.de
Cc:     Ajish.Koshy@microchip.com, yanaijie@huawei.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linuxarm@huawei.com,
        liuqi115@huawei.com, Viswas.G@microchip.com
References: <1645112566-115804-1-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1645112566-115804-1-git-send-email-john.garry@huawei.com>
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

On 2/18/22 00:42, John Garry wrote:
> The LLDD TMF code is almost identical between hisi_sas, pm8001, and mvsas
> drivers.
> 
> This series factors out that code into libsas, thus reducing much
> duplication and giving a net reduction of ~350 LoC.
> 
> There are some subtle differences between the core TMF handler and each
> of the LLDDs old implementation, so any review and testing is appreciated.
> 
> Some other minor patches are thrown in:
> - Delete unused macro in hisi_sas driver
> - Delete unused libsas callback
> - Delete unused SAS_SG_ERR
> - Add enum for response frame datapres field
> - Handle unrecognised errors in sas_scsi_find_task()
> 
> I have another follow-up series to factor out the internal abort code,
> which is common to hisi_sas and pm8001 drivers.
> 
> Based on mkp-scsi 5.18 staging queue at commit ac2beb4e3bd7

I tested this series with my pm8001 v5 series on top. Everything looks
good, no problems detected with both SAS and SATA drives tests. So feel
free to add:

Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Martin,

This series and my pm8001 series have a conflict. When applying the
pm8001 patches on top of these libsas changes, patch 28 has a fairly
easy to resolve conflict. Let me know if you want me to send a v6
rebased on top of this.

Thanks !


-- 
Damien Le Moal
Western Digital Research
