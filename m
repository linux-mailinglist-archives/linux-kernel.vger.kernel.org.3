Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6225A484D02
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 05:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbiAEED6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 23:03:58 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:35104 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230284AbiAEED5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 23:03:57 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTG7d1Svbz1VSkd
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 20:03:57 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641355436; x=1643947437; bh=D5hIqub1AK1TnpE8ZS0hC6KxBiCmu43kGg7
        9h+232Io=; b=r/HbP8eLSsHISReLDMRXAD8jF4FoGIDPjvZbCODQFqfOYInGJTP
        JuL9QLDMsPCByp5yFccZo/7rX4zglSkC+jPqoeVvqSv0lpVLa5W9u5LmaBHeGVGr
        xXYoUx3gRoJazoeegeuTEbBn71vqXVT1599As3gBfieL+CtR1M92A0ksfI38LA4h
        8QWniSTEOn8PymoEXZWemEdiSx5+HHi3AWN5joSXAtn8rBxudooX1o+wG8h8yXPy
        JV0sr1K1oPfG+G//owKg83dSizoXuBZfrDlWLo3OtPFwkvj1HWygGLNqCS/VToDf
        0REpPVaJSuv6oXgJ8R3jlgDz8PFOPH8SRKQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fw9KtH34sWIt for <linux-kernel@vger.kernel.org>;
        Tue,  4 Jan 2022 20:03:56 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTG7Z2LnWz1VSkV;
        Tue,  4 Jan 2022 20:03:54 -0800 (PST)
Message-ID: <d2d3c903-fb91-e218-9e0a-aeb2ff9e401a@opensource.wdc.com>
Date:   Wed, 5 Jan 2022 13:03:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH RFT] scsi: pm8001: Fix FW crash for maxcpus=1
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com,
        Ajish.Koshy@microchip.com, Viswas.G@microchip.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        vishakhavc@google.com, ipylypiv@google.com,
        Ruksar.devadi@microchip.com,
        Vasanthalakshmi.Tharmarajan@microchip.com
References: <1641320780-81620-1-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1641320780-81620-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/22 03:26, John Garry wrote:
> According to the comment in check_fw_ready() we should not check the
> IOP1_READY field in register SCRATCH_PAD_1 for 8008 or 8009 controllers.
> 
> However we check this very field in process_oq() for processing the highest
> index interrupt vector. Change that function to not check IOP1_READY for
> those mentioned controllers, but do check ILA_READY in both cases.
> 
> The reason I assume that this was not hit earlier was because we always
> allocated 64 MSI(X), and just did not pass the vector index check in
> process_oq(), i.e.  the handler never ran for vector index 63.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
> index 2101fc5761c3..77b8bb30615b 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -4162,9 +4162,16 @@ static int process_oq(struct pm8001_hba_info *pm8001_ha, u8 vec)
>  	u32 regval;
>  
>  	if (vec == (pm8001_ha->max_q_num - 1)) {
> +		u32 mipsall_ready;
> +
> +		if ((pm8001_ha->chip_id == chip_8008) ||
> +		    (pm8001_ha->chip_id == chip_8009))

nit: no need for the inner brackets here.

> +			mipsall_ready = SCRATCH_PAD_MIPSALL_READY_8PORT;
> +		else
> +			mipsall_ready = SCRATCH_PAD_MIPSALL_READY_16PORT;
> +
>  		regval = pm8001_cr32(pm8001_ha, 0, MSGU_SCRATCH_PAD_1);
> -		if ((regval & SCRATCH_PAD_MIPSALL_READY) !=
> -					SCRATCH_PAD_MIPSALL_READY) {
> +		if ((regval & mipsall_ready) != mipsall_ready) {
>  			pm8001_ha->controller_fatal_error = true;
>  			pm8001_dbg(pm8001_ha, FAIL,
>  				   "Firmware Fatal error! Regval:0x%x\n",
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.h b/drivers/scsi/pm8001/pm80xx_hwi.h
> index c7e5d93bea92..c41ed039c92a 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.h
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.h
> @@ -1405,8 +1405,12 @@ typedef struct SASProtocolTimerConfig SASProtocolTimerConfig_t;
>  #define SCRATCH_PAD_BOOT_LOAD_SUCCESS	0x0
>  #define SCRATCH_PAD_IOP0_READY		0xC00
>  #define SCRATCH_PAD_IOP1_READY		0x3000
> -#define SCRATCH_PAD_MIPSALL_READY	(SCRATCH_PAD_IOP1_READY | \
> +#define SCRATCH_PAD_MIPSALL_READY_16PORT	(SCRATCH_PAD_IOP1_READY | \
>  					SCRATCH_PAD_IOP0_READY | \
> +					SCRATCH_PAD_ILA_READY | \
> +					SCRATCH_PAD_RAAE_READY)
> +#define SCRATCH_PAD_MIPSALL_READY_8PORT	(SCRATCH_PAD_IOP0_READY | \
> +					SCRATCH_PAD_ILA_READY | \
>  					SCRATCH_PAD_RAAE_READY)
>  
>  /* boot loader state */

Otherwise, looks OK to me.
I tested with and without max_cpus=1 with a ATTO Technology, Inc.
ExpressSAS 12Gb/s SAS/SATA HBA (rev 06) adapter and everything is OK.
That adapter uses chip_8072 though, not 8008 or 8009.

Feel free to add:

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
