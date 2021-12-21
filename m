Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D91447B680
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 01:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbhLUAjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 19:39:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55418 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231365AbhLUAju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 19:39:50 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BKMXn64022063;
        Tue, 21 Dec 2021 00:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pJWP2Dxbq//tgGh2ocH4HUS1hE/2OXhsKSEwQgCVods=;
 b=mUn3z2oE30K/ksGTnwMpR7UEAEo9Vm/sD3jkC9EtR8fznKrK2gc4ROvtMQyZGoPXj4C9
 oYAmCc989lE73fIaq4dgV49yc5ZotdFPJ0iKIe0sWVOEL5yCFEmVL8gVuT2681iXuAuO
 zjP8tRtNE+JzQFmiMsVuLT5V1ZbWjBzKlUoLcGRVDN973mNVLjvcN3zO39l66LB9zE7T
 doIJsC1oaCzMJeTEouTD5tXxTsPzIMnsXnNMfLEJLHjUAgmabp2GDxXnhfkmarNg7Btg
 Ce0MNRKuIw57/1VXFQ37OmSFvilWAMi8OBYRbT9f3Uz7R++ISSG6qZGNtbH7XQnfl6vW Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d1skerbh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 00:39:42 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BL0dfDj032349;
        Tue, 21 Dec 2021 00:39:41 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d1skerbh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 00:39:41 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BL0YUA2012585;
        Tue, 21 Dec 2021 00:39:40 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04wdc.us.ibm.com with ESMTP id 3d179hq9sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 00:39:40 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BL0dbxH20840798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 00:39:37 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A469B78068;
        Tue, 21 Dec 2021 00:39:37 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 029807805C;
        Tue, 21 Dec 2021 00:39:35 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.65.210.85])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 21 Dec 2021 00:39:35 +0000 (GMT)
Subject: Re: [PATCH] tpm: Fix kexec crash due to access to ops NULL pointer
 (powerpc)
To:     Stefan Berger <stefanb@linux.ibm.com>, jarkko@kernel.org,
        peterhuewe@gmx.de, linux-integrity@vger.kernel.org
Cc:     Korrapati.Likhitha@ibm.com, pavrampu@in.ibm.com,
        linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        linux-security-module@vger.kernel.org, gcwilson@us.ibm.com,
        linuxppc-dev@lists.ozlabs.org
References: <20211212012804.1555661-1-stefanb@linux.ibm.com>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <1052cd36-1b85-5d36-045f-5c5bf9f0fc4e@linux.ibm.com>
Date:   Mon, 20 Dec 2021 16:39:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211212012804.1555661-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QyNPFZP8_EbRuNziPa7ZwPP5OjW4qjZt
X-Proofpoint-GUID: bqMRiNrnxVf4QSAoFvw2J_KnKY2riSYc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-20_11,2021-12-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 clxscore=1011 mlxscore=0 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210001
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/21 5:28 PM, Stefan Berger wrote:
> Fix the following crash on kexec by checking chip->ops for a NULL pointer
> in tpm_chip_start() and returning an error code if this is the case.
> 
> BUG: Kernel NULL pointer dereference on read at 0x00000060
> Faulting instruction address: 0xc00000000099a06c
> Oops: Kernel access of bad area, sig: 11 [#1]
> ...
> NIP [c00000000099a06c] tpm_chip_start+0x2c/0x140
>  LR [c00000000099a808] tpm_chip_unregister+0x108/0x170
> Call Trace:
> [c0000000188bfa00] [c000000002b03930] fw_devlink_strict+0x0/0x8 (unreliable)
> [c0000000188bfa30] [c00000000099a808] tpm_chip_unregister+0x108/0x170
> [c0000000188bfa70] [c0000000009a3874] tpm_ibmvtpm_remove+0x34/0x130
> [c0000000188bfae0] [c000000000110dbc] vio_bus_remove+0x5c/0xb0
> [c0000000188bfb20] [c0000000009bc154] device_shutdown+0x1d4/0x3a8
> [c0000000188bfbc0] [c000000000196e14] kernel_restart_prepare+0x54/0x70
> 
> The referenced patch below introduced a function to shut down the VIO bus.
> The bus shutdown now calls tpm_del_char_device (via tpm_chip_unregister)
> after a call to tpm_class_shutdown, which already set chip->ops to NULL.
> The crash occurrs when tpm_del_char_device calls tpm_chip_start with the
> chip->ops NULL pointer.

It was unclear to me at first, but IIUC the problem is the ibmvtpm device
receives two shutdown calls, the first is a class shutdown call for TPM devices,
followed by a bus shutdown call for VIO devices.

It appears that the class shutdown routines are meant to be a pre-shutdown
routine as they are defined as class->shutdown_pre(), and it is clearly allowed
to call class->shutdown_pre() followed by one of but not both of the following
bus->shutdown() or driver->shutdown(). Even tpm_class_shutdown() mentions in the
function comment that bus/device shutdown to follow.

> 
> Fixes: 39d0099f9439 ("powerpc/pseries: Add shutdown() to vio_driver and vio_bus")

This patch left implementing each vio driver shutdown routine as an exercise for
the respective maintainers, and instead just big hammers anything that doesn't
have a shutdown routine by calling the driver->remove().

If tpm_class_shutdown() quiecses ibmvtpm enough implementing a no-op
ibmvtpm->shutdown() with a comment saying so suffices.

However, the generic TPM code is still introducing a bug that an attempt to call
tpm_chip_unregister() after tpm_class_shutdown() will crash as mentioned above.

> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm-chip.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index ddaeceb7e109..cca1bde296ee 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -101,6 +101,9 @@ int tpm_chip_start(struct tpm_chip *chip)
>  {
>  	int ret;
> 
> +	if (!chip->ops)
> +		return -EINVAL;
> +

I wonder if a better fix would to have tpm_del_char_device() check for valid
chip->ops and call tpm_class_shutdown() when the ops are still valid. Calling
tpm_class_shutdown() allows for some code deduplication in tpm_del_char_device().

-Tyrel

>  	tpm_clk_enable(chip);
> 
>  	if (chip->locality == -1) {
> 

