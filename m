Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08ADD4CC2C6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiCCQaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbiCCQaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:30:10 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82D319BE7F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646324964; x=1677860964;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VAgz2vhs3PqyekpxFO87UXkBgw8sk7MSyxO2iB9CLC8=;
  b=iGvI8lzV7ghWudVeaXxHeabQwZ3+w9XssTXJnM84yxWy2C8plsW1dbDg
   hQF3lfC2hAkm9oPWdtBg/Ljs9EZWX/xHYaxeTQZpoFuR/EP9xv8wB7+LU
   qWmyfKT/7D59PU7Z2FRLCSGORKKtAaQj5L/ShPM7m1XhPaeGR72EzDSZS
   x+erySmTRrUWdgz9Cmrlco8h6wnTbZW+2QrTAq9sfTt6rHeqWzTy+glAT
   nullX2O0X1odeRQdEZonSkfARfnROl6GfsZJ1+pz0BXD944iQEqIvbLO6
   3B7b8CXov+NDyov30Eu5yCpkrn0MWbb+deJ7+QEmBESejDi74HCwB8gZo
   g==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643644800"; 
   d="scan'208";a="193333115"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2022 00:29:24 +0800
IronPort-SDR: 5jhaWPT0AYHRJOJk0MEWImZVg8pA3F0pZLk2M65ZDibT4+L/27JuSkQUw5ZV+Q2OH+6MGWKKC9
 XT+OnlGjKVUjjUMdEJfREMDaAY/wQ9S3DV1yMDekmbivbeKhBe4cPKW6sQTnR8+15lVqocv6hH
 Tf7lDKuwyhY7zH1NmIQsrp7CpqpyyDo8s6XLfnCxH+PD0zDpl7OLwQpls2TjoQpjutUwPBj8zu
 ssmMPLgwCTXqiys2BYlAneRdWmCkIZ264F8UEojwyEjsZ2C/zyHKO6jxQe933Q9SRMBMJyNF/o
 RDrrN/7tErima1OyX2fYR/Gl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 08:01:48 -0800
IronPort-SDR: XhwvEsLQm19irvlA43zAXyoA4d7N2YC+neCZTcg5rEyvJNLR8mZwKbfAzCh4dyDGk7u7UGK8mu
 1krBX8KOLboj7hX8J0sZKcVuBt9crWsa0ZZ2Hl02xFFnfpoFC/o+GGySOOCCYcYWU92GPsJS6E
 NqCyczn7YCFfdlphZv1WWqHG8THZw/OL4B4Uf91KgOi6fI4yu6v2+CqIzF+rOIeTnMjukOCyj4
 qgeD/08cc8ZezUXZzfoVTk8UrZtN/zYmH4zUQcZqLKq47lg8RBu5A0J34+lE8l9Jh73xVKhPOv
 Zj0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 08:29:24 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K8bzR658dz1SVp3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:29:23 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646324963; x=1648916964; bh=VAgz2vhs3PqyekpxFO87UXkBgw8sk7MSyxO
        2iB9CLC8=; b=hdiVjcp3NrPjLgy9kUQlL5AVY2bVDNV3Ql79WPIPyS/HUg+KM4F
        AS4K+VG7nQxbL6Cc35yMIDFUXg2WGeFv9mnRhi5gkd4mF14EPTtV2Pdvx6QlkvPt
        9zNxoh3PSNpTHNdlvcMEHv8eR63ry+wCKZ5CMPNZzrnssm1gHr4R+xRyniuh9p17
        UQD8N8GD6vTDzfcLXcdaAlaXvU4VxxOUu030PgX3DrY/o71Lb+ZE6ZFLfRTqfgm6
        Nyx3t+3IVinYmIk5iEjz+kh6WXZyRp9ZGJLAt152JpXX2F0PlGt4kMTt0V9T+uch
        SfqeYuvg+dz1yxigBQLVcDMhLy/Tffdbaiw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Dv-MKY1_9Wfl for <linux-kernel@vger.kernel.org>;
        Thu,  3 Mar 2022 08:29:23 -0800 (PST)
Received: from [10.225.33.67] (unknown [10.225.33.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K8bzM55c7z1Rvlx;
        Thu,  3 Mar 2022 08:29:19 -0800 (PST)
Message-ID: <eb107f83-373f-c489-502d-a1655271c06b@opensource.wdc.com>
Date:   Thu, 3 Mar 2022 18:29:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
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
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/03/03 14:18, John Garry wrote:
> This is a follow-on from the series to factor out the TMF code shared
> between libsas LLDDs.
> 
> The hisi_sas and pm8001 have an internal abort feature to abort pending
> commands in the host controller, prior to being sent to the target. The
> driver support implementation is naturally quite similar, so factor it
> out.
> 
> Again, testing and review would be appreciated.

John,

Traveling this week so testing will be difficult. I will try this first thing
Monday next week.

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
