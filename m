Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C6A50BBB5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449436AbiDVPcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379791AbiDVPb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:31:59 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88155D5FF;
        Fri, 22 Apr 2022 08:29:05 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23MEwQKI028996;
        Fri, 22 Apr 2022 17:29:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=7OtoQsmkk74HkzZwgy+GPk/bwOwOBCrV453Og/7yYoE=;
 b=dHszagQgj2uytg0rBRYm6gs9htdcYMiV1vk0wrJg6qVNC5/hEleqC1i3JJqeM6NECE7z
 BUU3SoHs1Qrqmn7WIBls/beBcaz58jBkDtH2g2uQA6T1KcUcXzDewwk+N4cQTFX6/zhk
 lBNZCmnfEMZDvLhowTfsyiA2Mifzru9eTCZaxi44y24zxnRxrVCVnf6CWupjXR5g5lcP
 CY8m/uDi/7qccLBB44SNY5noPNpnstPMmXpMg/OlW0Sssn3fB3sQg2m4I6eSQwXZzzeM
 9R6gFaVdvkW6gj1eci1IUjJu4G3lLCZ+344AmC8R9Aw6D93TTvaD5cRLGGJJtBYEBDuL dA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fk4fvg0bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 17:29:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5195410002A;
        Fri, 22 Apr 2022 17:29:03 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4B35A233C76;
        Fri, 22 Apr 2022 17:29:03 +0200 (CEST)
Received: from [10.201.20.246] (10.75.127.46) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 22 Apr
 2022 17:29:02 +0200
Message-ID: <93383e14-736e-56c8-2f96-d295d5019ddc@foss.st.com>
Date:   Fri, 22 Apr 2022 17:29:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] rpmsg: virtio: fix possible double free in rpmsg_probe()
Content-Language: en-US
To:     Hangyu Hua <hbh25y@gmail.com>, <bjorn.andersson@linaro.org>,
        <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220418093144.40859-1-hbh25y@gmail.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <20220418093144.40859-1-hbh25y@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_04,2022-04-22_01,2022-02-23_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/22 11:31, Hangyu Hua wrote:
> vch will be free in virtio_rpmsg_release_device() when
> rpmsg_ns_register_device() fails. There is no need to call kfree() again.
> 
> Fix this by changing error path from free_vch to free_ctrldev.
> 
> Fixes: c486682ae1e2 ("rpmsg: virtio: Register the rpmsg_char device")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>

Tested-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

Thanks,
Arnaud

> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 3ede25b1f2e4..603233f0686e 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -973,7 +973,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  
>  		err = rpmsg_ns_register_device(rpdev_ns);
>  		if (err)
> -			goto free_vch;
> +			goto free_ctrldev;
>  	}
>  
>  	/*
> @@ -997,8 +997,6 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  
>  	return 0;
>  
> -free_vch:
> -	kfree(vch);
>  free_ctrldev:
>  	rpmsg_virtio_del_ctrl_dev(rpdev_ctrl);
>  free_coherent:
