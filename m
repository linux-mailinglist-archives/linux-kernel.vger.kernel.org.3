Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FE5553839
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbiFUQwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiFUQwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:52:39 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011CA2B1AB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:52:38 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LGoHYq007232;
        Tue, 21 Jun 2022 16:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=aUJ3IZOT+JOaPHtfPsoF5SXvwW8kxNxRFMPWSzEwn34=;
 b=F5VBcdsw5az3Zi7k/aCpAlO4MQH/gHryLX1TEtNBE/Fu6KayRKuzABZbVTtOzBx19Bdz
 Sk0ThsPCF3Dn8Iip5ovmGOBTgtINMJp44JHThjl2bu47fMMNTIgUkD2U1G5BRcrmzEEn
 wZF1DDfk6IZFkRNIgPbPFQ/7P+aMQiasWnKSykUSBKV6zWGJ+fiZzO4/Mv746iZwI2Og
 Oxqq3dsrs3TSpmOt77RtHlSyfobGcz7CZmtqEUb+D8jKjyBXR3FYSFi9Z/hnwImJtF6h
 uZa3AH9c0aMdBYoVlTF8FA3NCyduR6vLwn3ZVr5UCPPfLRagyanTTO1QYS4atCBdHtYb aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3guhv1r1wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 16:52:17 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25LGoUtT007751;
        Tue, 21 Jun 2022 16:52:17 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3guhv1r1wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 16:52:17 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25LGpd9n011831;
        Tue, 21 Jun 2022 16:52:16 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03dal.us.ibm.com with ESMTP id 3gs6b9jeea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 16:52:16 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25LGqF3G12059036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 16:52:15 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63739AE05F;
        Tue, 21 Jun 2022 16:52:15 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24664AE060;
        Tue, 21 Jun 2022 16:52:15 +0000 (GMT)
Received: from localhost (unknown [9.211.80.5])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jun 2022 16:52:15 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        haren@linux.vnet.ibm.com, npiggin@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] powerpc/mobility: Wait for memory transfer to
 complete
In-Reply-To: <20220614135414.37746-2-ldufour@linux.ibm.com>
References: <20220614135414.37746-1-ldufour@linux.ibm.com>
 <20220614135414.37746-2-ldufour@linux.ibm.com>
Date:   Tue, 21 Jun 2022 11:52:14 -0500
Message-ID: <87y1xqm01t.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rltyrwAvAEkm6dqZCO_S_n00ZqOBO4Uh
X-Proofpoint-ORIG-GUID: 7Zsolw1wbWx1ZBvsiuQ0MzP1ou-yk6Z-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_08,2022-06-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Dufour <ldufour@linux.ibm.com> writes:

> In pseries_migration_partition(), loop until the memory transfer is
> complete. This way the calling drmgr process will not exit earlier,
> allowing callbacks to be run only once the migration is fully completed.
>
> If reading the VASI state is done after the hypervisor has completed the
> migration, the HCALL is returning H_PARAMETER. We can safely assume that
> the memory transfer is achieved if this happens.
>
> This will also allow to manage the NMI watchdog state in the next commits.
>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/mobility.c | 42 +++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index 78f3f74c7056..179bbd4ae881 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -427,6 +427,43 @@ static int wait_for_vasi_session_suspending(u64 handle)
>  	return ret;
>  }
>  
> +static void wait_for_vasi_session_completed(u64 handle)
> +{
> +	unsigned long state = 0;
> +	int ret;
> +
> +	pr_info("waiting for memory transfert to complete...\n");
> +	/*
> +	 * Wait for transition from H_VASI_RESUMED to
> +	 * H_VASI_COMPLETED. Treat anything else as an error.

"Treat anything else as an error" does not match the code since there is
a special case for when the stream handle has expired. So that should be
dropped from this comment.

> +	 */
> +	while (true) {
> +		ret = poll_vasi_state(handle, &state);
> +
> +		/*
> +		 * If the memory transfer is already complete and the migration
> +		 * has been cleaned up by the hypervisor, H_PARAMETER is return,
> +		 * which is translate in EINVAL by poll_vasi_state().
> +		 */
> +		if (ret == -EINVAL || (!ret && state == H_VASI_COMPLETED)) {
> +			pr_info("memory transfert completed.\n");
> +			break;
> +		}
> +
> +		if (ret) {
> +			pr_err("H_VASI_STATE return error (%d)\n", ret);
> +			break;
> +		}
> +
> +		if (state != H_VASI_RESUMED) {
> +			pr_err("unexpected H_VASI_STATE result %lu\n", state);
> +			break;
> +		}
> +
> +		msleep(500);
> +	}
> +}
> +
>  static void prod_single(unsigned int target_cpu)
>  {
>  	long hvrc;
> @@ -673,9 +710,10 @@ static int pseries_migrate_partition(u64 handle)
>  	vas_migration_handler(VAS_SUSPEND);
>  
>  	ret = pseries_suspend(handle);
> -	if (ret == 0)
> +	if (ret == 0) {
>  		post_mobility_fixup();
> -	else
> +		wait_for_vasi_session_completed(handle);
> +	} else
>  		pseries_cancel_migration(handle, ret);
>  
>  	vas_migration_handler(VAS_RESUME);

While this may noticeably lengthen the time it takes for drmgr to return
from the system call, it seems like the right thing to do. The migration
should not be considered complete until the VASI stream poll yields a
"Complete" status. And we still need to add code to send gratuitous ARPs
through ibmveth interfaces while waiting for the transition, which would
likely build on this.

I believe the HMC and associated software can cope with the drmgr
command taking a longer time to return in cases where the partition
memory needs a while to completely sync to the destination.

Apart from the small critique on the comment in
wait_for_vasi_session_completed(), this looks fine to me.

Reviewed-by: Nathan Lynch <nathanl@linux.ibm.com>
