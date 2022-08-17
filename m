Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5265259735D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbiHQPxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbiHQPxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:53:03 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1CF9C1E0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660751582; x=1692287582;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1GWE7vy/GU+GxOihGG1AQ+L7I/enLfcn/0bM+JDtR7s=;
  b=mxzsLjoojTKz27up2g7V48gLVzsHh6+VyFBODXS8AwsHYSpoKOjVQDxG
   MnRcw1usaK3dE3HQnkSc1gk1mqS1HiGfdG2zOA6F7FIGXC3zfcYfwUw/N
   gAy57jp+vLRb+0Q2iNYpR1pFZJVercvsRgiDxfrTxt5fjxxlwmLvofOVD
   GlaZQrW+zxGo7zg8DDF4eBZleCe9zH/3ftZ6wFleqxBaAKtr6o4l26+NI
   +35w8Ke0W+okuTilhEzjKuHmKcCZBz/Wwyz28FmI0U2WVmWNqHZknMHi1
   +OXEz8xLlIprHk9X/4rLF6G+f8L9Mdo7O2KDQo+E30xsdgRrWsQAxQb6g
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,243,1654531200"; 
   d="scan'208";a="214053653"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2022 23:52:59 +0800
IronPort-SDR: hHBPqjAXMNEHxDoRGlNkdfEy6b/csoitZI/+76MMIg2zObCU1bXe2Z7Ya0w3jC/tWzLDFMpkHf
 KM+7IASHjEZj3mgiNjGauPNGZI19KbAbKfalheqnLLlDRDRdd/5khkWmFR7phRJsUZAbUiDzjl
 P6mibvI2XZ22w8pa4Q5Ap9UBP5rIbJA6xHV6BHe4CHoLm7FXEPdiiboQtFyPPSeam8osTgSY6N
 OmfWSHbbArQVJECiK4vd3dbnDTiPMxsLx1aNoE3Ho3dh2HjxGuKi4yjCXMmtZSl4z1II+e2XHo
 cQ5/HB7SOqI01rFy+Njfsupn
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 08:13:46 -0700
IronPort-SDR: qTTcFYMGzdS4n5qOZV/WpMDKahV7NPX+MeBIIgqxemJQj9vpjJFSeA9y0srjVmJfJzNgtRSH2g
 sfZEWw26gHpMufjtn3+0wLLplZOLEGRN6QIhZFPHShXkA5fQ56tuzaXcXpA8rd0w2TYf9fPURM
 N0NaIydmaA5LsfeZyKZqVXoNdCIAgnBGK6apb1ieKstH+yh45Zno9oX8ljszsVn7iIeiRh2D2w
 /NyQMXYVv/eYWJJ2hZfHv8dZ/HskShUXvN6n4jDhMZkvm42F2y8HmT+Izj5Cxk+ZIHXRe9WrCd
 NQU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 08:53:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M7CGM2dvPz1Rwqy
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:52:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660751578; x=1663343579; bh=1GWE7vy/GU+GxOihGG1AQ+L7I/enLfcn/0b
        M+JDtR7s=; b=c48fjmOxUozA1ugSnw7GiZja0C/YyyKdjM/5pPIw/39aS+fCzwE
        osgor6d5oGTx6gcshxg3MYNgHbnt7/G7dOulP1oBqq5duqFxXXDWsChQT8BfCEOR
        Rd9ZWBKpJYpMOp9WY7v2QDhSOW2nxi9ohC8Yx6hJJtkat/2EKqlzyVPqRwmGCeQc
        c1ZsTFfIqWwYIYpOrKAsYTONMGSf+APdIXU47+i8WjVi0i8y4/8hqA5S/7zULd2u
        2i2tBlHLjLchzCfFzKBkHOqTR/piSX4/kFtgdCz7U8b79B0Gw5LyRR8wElWHm9NU
        2veW5sSVxLsY/LJBCpYNxBtaU81wk6LJxZA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2fnNhLu7xHyD for <linux-kernel@vger.kernel.org>;
        Wed, 17 Aug 2022 08:52:58 -0700 (PDT)
Received: from [10.11.46.122] (unknown [10.11.46.122])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M7CGL05CWz1RtVk;
        Wed, 17 Aug 2022 08:52:57 -0700 (PDT)
Message-ID: <e1efeb1b-a876-a5c4-a8af-b30883c8457d@opensource.wdc.com>
Date:   Wed, 17 Aug 2022 08:52:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2 0/6] libsas and drivers: NCQ error handling
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com,
        yangxingui@huawei.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, hare@suse.de
References: <1660747934-60059-1-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1660747934-60059-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/08/17 7:52, John Garry wrote:
> As reported in [0], the pm8001 driver NCQ error handling more or less
> duplicates what libata does in link error handling, as follows:
> - abort all commands
> - do autopsy with read log ext 10 command
> - reset the target to recover
> 
> Indeed for the hisi_sas driver we want to add similar handling for NCQ
> errors.
> 
> This series add a new libsas API - sas_ata_device_link_abort() - to handle
> host NCQ errors, and fixes up pm8001 and hisi_sas drivers to use it. As
> mentioned in the pm8001 changeover patch, I would prefer a better place to
> locate the SATA ABORT command (rather that nexus reset callback).
> 
> Damien kindly tested the v1 series for pm8001, but any further pm8001
> testing would be appreciated as I have since tweaked
> sas_ata_device_link_abort(). This is because the pm8001 driver hangs on my
> arm64 machine read log ext10 command.

I will run more tests with this series.

> 
> Finally with these changes we can make the libsas task alloc/free APIs
> private, which they should always have been.
> 
> Based on v6.0-rc1
> 
> [0] https://lore.kernel.org/linux-scsi/8fb3b093-55f0-1fab-81f4-e8519810a978@huawei.com/
> 
> Changes since v1:
> - Rename sas_ata_link_abort() -> sas_ata_device_link_abort()
> - Set EH RESET flag in sas_ata_device_link_abort()
> - Add Jack's Ack tags
> - Rebase
> 
> John Garry (5):
>   scsi: pm8001: Modify task abort handling for SATA task
>   scsi: libsas: Add sas_ata_device_link_abort()
>   scsi: pm8001: Use sas_ata_device_link_abort() to handle NCQ errors
>   scsi: hisi_sas: Don't issue ATA softreset in hisi_sas_abort_task()
>   scsi: libsas: Make sas_{alloc, alloc_slow, free}_task() private
> 
> Xingui Yang (1):
>   scsi: hisi_sas: Add SATA_DISK_ERR bit handling for v3 hw
> 
>  drivers/scsi/hisi_sas/hisi_sas_main.c  |   5 +-
>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  22 ++-
>  drivers/scsi/libsas/sas_ata.c          |  11 ++
>  drivers/scsi/libsas/sas_init.c         |   3 -
>  drivers/scsi/libsas/sas_internal.h     |   4 +
>  drivers/scsi/pm8001/pm8001_hwi.c       | 194 +++++++------------------
>  drivers/scsi/pm8001/pm8001_sas.c       |  13 ++
>  drivers/scsi/pm8001/pm8001_sas.h       |   8 +-
>  drivers/scsi/pm8001/pm80xx_hwi.c       | 177 ++--------------------
>  include/scsi/libsas.h                  |   4 -
>  include/scsi/sas_ata.h                 |   5 +
>  11 files changed, 133 insertions(+), 313 deletions(-)
> 


-- 
Damien Le Moal
Western Digital Research
