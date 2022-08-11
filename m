Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2E65906CE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 21:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbiHKSyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 14:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbiHKSyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 14:54:53 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FA79E2E5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660244092; x=1691780092;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JAaAJR7wc67hy6jnXKsnD5CiFky15y0MQprEMGqEB0E=;
  b=E6aRU6H6KtfriBElKkw2Kv5tEM0sH5Xqrj8W7hHa++bvV3N9e3s6vn8N
   FqdYFJwK48n2nffhNY6oltpjI7YUiKyOJNPKfaGiwuL/kHbg347Ls+G78
   vYCfJA21o+T/tYxMU8SylD1qzpIyAok0/NS98u6fzglkMdp4wms2jO1Kj
   sxhplYtTKvo+8pD50I7YJnil2I85aDI89rCVEA+kJjKqzEd4AoLw0sHCz
   Hvh5Tr1JqxWo3dIB9vrQjyRgSQq0IBUwMm6lWoG7oZqtDgXV6+u63JT3C
   iXnsWH9QRNq4n+HHK+WiZ4s9JPOzsPeUaCgRZwjbK74dLqJk6P8qYxNR/
   g==;
X-IronPort-AV: E=Sophos;i="5.93,230,1654531200"; 
   d="scan'208";a="206969515"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2022 02:54:51 +0800
IronPort-SDR: 1e6C9npo8WkVL99LlArf78sAlTWea4pMc5AAzZ0Kdn8DLU1+c0Tk3YE6+74KupEJdpMX9PXz/Y
 /q+yn5zluqj/cKxZ5764ezLHK7u3fMmXWYgQDh7romeBsQuUCIgKuMF22Sn75nB6WalijOGykp
 bmDseye94fsAqmKGK4zSg/HIG9qNccALt+hqQ9DjJPK102F8ikO2JE9aUEJ22SgQSYBsHdbFW5
 ePJQqIHGva+xGt0yKbrfGRT75H3zHnxuk6U8q4CycPy7/WfI/8ccdPe1EcUXF1bTMZr7IlXvGS
 KJ8q8gIhO49prT4U2XO/R7fr
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Aug 2022 11:10:26 -0700
IronPort-SDR: vgbzstQRRgg7wndtRC79PxaoK2MzsDCBrF47OyoFbx4SEgDDnaEOpMnjYj9SsO6wofksFL+tpm
 J8rHiXGIXVX7YigU2C0AKMT6c44m6+zk1KuPMsCn/LO1+pFkSwTt2gaF6M2ESACZkHTg9/xbaG
 ZLJRmQYNv/hAlaWsacC5akL4fwZOm5bBi2tyEQ1oM9mQwnVh4sgzlnqCJ8cYBe8X/r+NlWC11T
 gLdcYLg13dl4fdTlj8+6ubn5QrSGkLPeDYDJlQMJGL80H2CO24KYBTCqLlRJxq2sToP8O/sn2U
 gio=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Aug 2022 11:54:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M3bZz5rs8z1RwqM
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:54:51 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660244090; x=1662836091; bh=JAaAJR7wc67hy6jnXKsnD5CiFky15y0MQpr
        EMGqEB0E=; b=drzWJTF/t8pd3s4zbKBqUeH7KYL3iuMM9Sr8yq6MyNO1FyiWDbt
        8ksgUqwEUQ0shqqK6lA8FcvI5aSy6Ab56dX0r//scLzc4YDvRZKf9Ht9oWUF17AB
        CbWz7H4+eUGYoI4HbUQxTm+glMSJWBrIw2isiwrlYkMgRRqGlwgmNEB993uvM7iX
        qOJO938hsAkq0an3yJcdnGh7En0TAjUAxXoI6HJrKBPpoIr+wgQ6PmUcy7YxAYuK
        /1MiHD1vyIZVi/2DG96+ZcTNuyHNFAtLMnlr/k7+gP9q3u2LVMQAxHZBo3zAoaRy
        TSNUbE71jsCawDYfLvU6J9j7YC6zpNlXzuw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PBll5yZ900Zm for <linux-kernel@vger.kernel.org>;
        Thu, 11 Aug 2022 11:54:50 -0700 (PDT)
Received: from [10.11.46.122] (c02drav6md6t.sdcorp.global.sandisk.com [10.11.46.122])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M3bZy3NGDz1RtVk;
        Thu, 11 Aug 2022 11:54:50 -0700 (PDT)
Message-ID: <d2e27cb7-d90a-2f0a-1848-e1ec8faf7899@opensource.wdc.com>
Date:   Thu, 11 Aug 2022 11:54:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 0/6] libsas and drivers: NCQ error handling
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com,
        yangxingui@huawei.com, chenxiang66@hisilicon.com, hare@suse.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1658489049-232850-1-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1658489049-232850-1-git-send-email-john.garry@huawei.com>
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

On 2022/07/22 4:24, John Garry wrote:
> As reported in [0], the pm8001 driver NCQ error handling more or less
> duplicates what libata does in link error handling, as follows:
> - abort all commands
> - do autopsy with read log ext 10 command
> - reset the target to recover
> 
> Indeed for the hisi_sas driver we want to add similar handling for NCQ
> errors.
> 
> This series add a new libsas API - sas_ata_link_abort() - to handle host
> NCQ errors, and fixes up pm8001 and hisi_sas drivers to use it. As
> mentioned in the pm8001 changeover patch, I would prefer a better place to
> locate the SATA ABORT command (rather that nexus reset callback).
> 
> I would appreciate some testing of the pm8001 change as the read log ext10
> command mostly hangs on my arm64 machine - these arm64 hangs are a known
> issue.

I applied this series on top of the current Linus tree and ran some tests: a
bunch of fio runs and also ran libzbc test suites on a SATA SMR drive as that
generates many command failures. No problems detected, the tests all pass.
FYI, messages for failed commands look like this:

pm80xx0:: mpi_sata_event 2685: SATA EVENT 0x23
sas: Enter sas_scsi_recover_host busy: 1 failed: 1
sas: sas_scsi_find_task: aborting task 0x00000000ba62a907
pm80xx0:: mpi_sata_completion 2292: task null, freeing CCB tag 2
sas: sas_scsi_find_task: task 0x00000000ba62a907 is aborted
sas: sas_eh_handle_sas_errors: task 0x00000000ba62a907 is aborted
ata21.00: exception Emask 0x0 SAct 0x20000000 SErr 0x0 action 0x0
ata21.00: failed command: WRITE FPDMA QUEUED
ata21.00: cmd 61/02:00:ff:ff:ea/00:00:02:00:00/40 tag 29 ncq dma 8192 out
res 43/04:02:ff:ff:ea/00:00:02:00:00/00 Emask 0x400 (NCQ error) <F>
ata21.00: status: { DRDY SENSE ERR }
ata21.00: error: { ABRT }
ata21.00: configured for UDMA/133
ata21: EH complete
sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 1 tries: 1

Seems all good to me.

> 
> Finally with these changes we can make the libsas task alloc/free APIs
> private, which they should always have been.
> 
> Based on v5.19-rc6
> 
> [0] https://lore.kernel.org/linux-scsi/8fb3b093-55f0-1fab-81f4-e8519810a978@huawei.com/
> 
> John Garry (5):
>   scsi: pm8001: Modify task abort handling for SATA task
>   scsi: libsas: Add sas_ata_link_abort()
>   scsi: pm8001: Use sas_ata_link_abort() to handle NCQ errors
>   scsi: hisi_sas: Don't issue ATA softreset in hisi_sas_abort_task()
>   scsi: libsas: Make sas_{alloc, alloc_slow, free}_task() private
> 
> Xingui Yang (1):
>   scsi: hisi_sas: Add SATA_DISK_ERR bit handling for v3 hw
> 
>  drivers/scsi/hisi_sas/hisi_sas_main.c  |   5 +-
>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  22 ++-
>  drivers/scsi/libsas/sas_ata.c          |  10 ++
>  drivers/scsi/libsas/sas_init.c         |   3 -
>  drivers/scsi/libsas/sas_internal.h     |   4 +
>  drivers/scsi/pm8001/pm8001_hwi.c       | 194 +++++++------------------
>  drivers/scsi/pm8001/pm8001_sas.c       |  13 ++
>  drivers/scsi/pm8001/pm8001_sas.h       |   8 +-
>  drivers/scsi/pm8001/pm80xx_hwi.c       | 177 ++--------------------
>  include/scsi/libsas.h                  |   4 -
>  include/scsi/sas_ata.h                 |   5 +
>  11 files changed, 132 insertions(+), 313 deletions(-)
> 


-- 
Damien Le Moal
Western Digital Research
