Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D096C49DAE2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbiA0Ghw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:37:52 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60449 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbiA0Ghr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643265467; x=1674801467;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tGvF4cWve7EEzEV011ffF9D8MZiAEFVUtGKB3LIdNZ0=;
  b=ZS7pm/xzZ34vwUojWrjRZbLpWDcX75JDLr/svY/hDMX6AKez9bU73n9f
   RfYW1B6ynOzaXpd7RB0XDPRY+cwNV6FiR8swvEA3mFk8SBNItJHoJ2mkL
   aQWYszWD90AF048xvB+qkRShH73rsyrdzFJSB3zdW47IaoqVRmPt5BRyu
   Q8fg/wcuRZMJUxK37TW6bLyCVg8ers2bFKAjamgU7Zz9L+lJMN+m8TjdM
   KgrvQye0pDKOwwSCiz3i4JZnd9o58ZX3pn9ocKU6vYHZQFNkJ2KAgm0yh
   ZaSgJAksqdV1J5Mth2fcQAMKXCOg/7ki10ODkGeRAMtR5v7oBWkdd3AN6
   A==;
X-IronPort-AV: E=Sophos;i="5.88,320,1635177600"; 
   d="scan'208";a="303376022"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2022 14:37:46 +0800
IronPort-SDR: 5WT7cSTrVJAciFHQF53BVlGCifldpedRDoSonAeO6vCjKkP2wE8X77swUeYZeNuPdRrVGVDvzb
 ct2TRZS9heFfE4HDPrKFrHOTWy/9w+pZ1Fvrny6uwZhFC74OE3fDD7FzvHXAXSI44llr0swjik
 J31xc5Uu5aaPHecg7o1/M2DcxGwFFeTBAVItKmtm5kAKJdtIo5XNOVpexCq2AFcguNmqp3R6gU
 tPiPF5HG15kYYrCh7CS7dkH1X1F59M6qNGes9AKU3TUl4EshvJ1WVJVQFsEbS6YnHg26UQKrDT
 WxvWl44QVSGjJi8LWlWeQpGG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 22:11:05 -0800
IronPort-SDR: Im9fqODW3EMOMVpUWpxhntwLQlvraZUPqxC53GZk7jktxcjG/qiQrY5egt0RF4q7ASqHAr9UoX
 1WDuCeNZZgiSYukSh6Cmw+ivJqyJna0zrtSy/3M7UEUq7Ok5VBJhrihRia01l5tsrT2c7Mezgl
 1rsr81JHz/RjefdPoqD96Kh2ET8Dwh374s7zuH+ZTEEyu9QW2ltZHKf0YEpT3fSMmpmSPM1FQg
 HVerj0X6Imv70YCJrdVUxrGXGa6SVWiJCIpt9z8hmmXR2avkfcbDDl+v26zNGQLaYm5+bFWBiW
 mWo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 22:37:47 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JkrVy4XKtz1SVp2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 22:37:46 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643265465; x=1645857466; bh=tGvF4cWve7EEzEV011ffF9D8MZiAEFVUtGK
        B3LIdNZ0=; b=m6vpFnVyyuVJY+f+JW2qFy4GVcJ/ixSRaaVmi7/4/nFL5kVCdgP
        C5ObwHD0qKAPOOtc98gdh0Gkf2iuf/J4ljsSVYhLn+7GdiZFoVCgLw1cdyIao5oM
        bn3m/FDyU9nwvNXof0Niv4tiG+GEECcGRpoyw7wLfCJpI4d/IbTaOG2tIF+JHiFi
        j4bA+oXmGdzY9P+8ySX2absWQgAdGdlDJ2jpDANQm76cjtoIsV58TicZdMEM+LQb
        RUIzqN9N9FZM7+jFgEX46mQ7T9/3vbCsvVqG5Ekpxqrb8HN1lBK9+H+KiVhvW/Wv
        k5JMcbRn/db4DuOIZducgTJL6W7E2ykpqIQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id E3Lr7LS7hbCv for <linux-kernel@vger.kernel.org>;
        Wed, 26 Jan 2022 22:37:45 -0800 (PST)
Received: from [10.225.163.56] (unknown [10.225.163.56])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JkrVv1tGrz1RvlN;
        Wed, 26 Jan 2022 22:37:43 -0800 (PST)
Message-ID: <1893d9ef-042b-af3b-74ea-dd4d0210c493@opensource.wdc.com>
Date:   Thu, 27 Jan 2022 15:37:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/16] scsi: libsas and users: Factor out LLDD TMF code
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, artur.paszkiewicz@intel.com,
        jinpu.wang@cloud.ionos.com, chenxiang66@hisilicon.com,
        Ajish.Koshy@microchip.com
Cc:     yanaijie@huawei.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, liuqi115@huawei.com, Viswas.G@microchip.com
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 20:32, John Garry wrote:
> The LLDD TMF code is almost identical between hisi_sas, pm8001, and mvsas
> drivers.
> 
> This series factors out that code into libsas, thus reducing much
> duplication and giving a net reduction of ~250 LoC.
> 
> There are some subtle differences between the core TMF handler and each
> of the LLDDs old implementation, so any review and testing is appreciated.
> 
> Some other minor patches are thrown in:
> - Delete unused macro in hisi_sas driver
> - Delete unused libsas callback
> - Add enum for response frame datapres field
> 
> I have another follow-up series to factor out the internal abort code,
> which is common to hisi_sas and pm8001 drivers.
> 
> Based on v5.17-rc1
> 
> John Garry (16):
>   scsi: libsas: Use enum for response frame DATAPRES field
>   scsi: libsas: Delete lldd_clear_aca callback
>   scsi: hisi_sas: Delete unused I_T_NEXUS_RESET_PHYUP_TIMEOUT
>   scsi: libsas: Move SMP task handlers to core
>   scsi: libsas: Add struct sas_tmf_task
>   scsi: libsas: Add sas_task.tmf
>   scsi: libsas: Add sas_execute_tmf()
>   scsi: libsas: Add sas_execute_ssp_tmf()
>   scsi: libsas: Add TMF handler exec complete callback
>   scsi: libsas: Add TMF handler aborted callback
>   scsi: libsas: Add sas_abort_task_set()
>   scsi: libsas: Add sas_clear_task_set()
>   scsi: libsas: Add sas_lu_reset()
>   scsi: libsas: Add sas_query_task()
>   scsi: libsas: Add sas_abort_task()
>   scsi: libsas: Add sas_execute_ata_cmd()
> 
>  Documentation/scsi/libsas.rst          |   2 -
>  drivers/scsi/aic94xx/aic94xx.h         |   1 -
>  drivers/scsi/aic94xx/aic94xx_init.c    |   1 -
>  drivers/scsi/aic94xx/aic94xx_tmf.c     |   9 -
>  drivers/scsi/hisi_sas/hisi_sas.h       |   9 +-
>  drivers/scsi/hisi_sas/hisi_sas_main.c  | 235 ++++---------------------
>  drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |   2 +-
>  drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   9 +-
>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |   2 +-
>  drivers/scsi/isci/init.c               |   1 -
>  drivers/scsi/isci/task.c               |  18 --
>  drivers/scsi/isci/task.h               |   4 -
>  drivers/scsi/libsas/sas_ata.c          |   8 +
>  drivers/scsi/libsas/sas_expander.c     |  24 +--
>  drivers/scsi/libsas/sas_internal.h     |   6 +
>  drivers/scsi/libsas/sas_scsi_host.c    | 220 +++++++++++++++++++++++
>  drivers/scsi/libsas/sas_task.c         |  12 +-
>  drivers/scsi/mvsas/mv_defs.h           |   5 -
>  drivers/scsi/mvsas/mv_init.c           |   5 +-
>  drivers/scsi/mvsas/mv_sas.c            | 177 +------------------
>  drivers/scsi/mvsas/mv_sas.h            |   3 -
>  drivers/scsi/pm8001/pm8001_hwi.c       |   4 +-
>  drivers/scsi/pm8001/pm8001_init.c      |   4 +-
>  drivers/scsi/pm8001/pm8001_sas.c       | 180 +++----------------
>  drivers/scsi/pm8001/pm8001_sas.h       |  13 +-
>  include/scsi/libsas.h                  |  23 ++-
>  26 files changed, 353 insertions(+), 624 deletions(-)
> 

John,

I did some light testing of this series (boot + some fio runs) and
everything looks good using my "ATTO Technology, Inc. ExpressSAS 12Gb/s
SAS/SATA HBA (rev 06)" HBA (x86_64 host).

Of note is that "make W=1 M=drivers/scsi" complains with:

drivers/scsi/pm8001/pm80xx_hwi.c:3938: warning: Function parameter or
member 'circularQ' not described in 'process_one_iomb'

And sparse/make C=1 complains about:

drivers/scsi/libsas/sas_port.c:77:13: warning: context imbalance in
'sas_form_port' - different lock contexts for basic block

But I have not checked if it is something that your series touch.

And there is a ton of complaints about __le32 use in the pm80xx code...
I can try to have a look at these if you want, on top of your series.

Cheers.

-- 
Damien Le Moal
Western Digital Research
