Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5F5486BB4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244165AbiAFVNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:13:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244039AbiAFVNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:13:51 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206IVb3g017615;
        Thu, 6 Jan 2022 21:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=KuEOMtUyfPPM9MezCJTSQ3xStJ2buUjqJB18gGW8+Z4=;
 b=CutrWWLqC0wenAD7aTQK9y5IWQ7WPi5gXR13bEihGS2oyiHRHz8X3ftIuNTW14GzkOxg
 SaQlGRfx8JQFPNwFUcBaN7OVnsNNGV+Gz+3/g58ByAXcGUgouo55ZAAKuL/TLxkqWRiq
 BwV2F5XBZBuQjj9b6BvcjDdx5RY5F+KyJD0V17jGW/v/4NtLLeNXHU8+550W/+5boEP6
 gZynsbX12AmTO1OlQ2bwBq+Avd2tBBaF11pnW+YX6h5t0pmip+y/YcP+gWZJqHGWKmxs
 DwJUthbbm0tl/J1WPdhypyBrWCDvB/v5RbBs4jnxKRdjLRw7CINSv7ePEmY6kTi8I06+ 7g== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3de5sfjmsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 21:13:47 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 206L4jKK021871;
        Thu, 6 Jan 2022 21:13:46 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3de5r9km6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 21:13:46 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 206LDjDa28770704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jan 2022 21:13:45 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FC116A054;
        Thu,  6 Jan 2022 21:13:45 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2586C6A04D;
        Thu,  6 Jan 2022 21:13:45 +0000 (GMT)
Received: from localhost (unknown [9.160.191.186])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jan 2022 21:13:44 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     tyreld@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] powerpc/pseries: read the lpar name from the firmware
In-Reply-To: <20220106161339.74656-1-ldufour@linux.ibm.com>
References: <20220106161339.74656-1-ldufour@linux.ibm.com>
Date:   Thu, 06 Jan 2022 15:13:44 -0600
Message-ID: <878rvsva7r.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MauGligxdyA9gUZfrr9DY5zagpl3FgWe
X-Proofpoint-GUID: MauGligxdyA9gUZfrr9DY5zagpl3FgWe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_09,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201060133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Dufour <ldufour@linux.ibm.com> writes:
> The LPAR name may be changed after the LPAR has been started in the HMC.
> In that case lparstat command is not reporting the updated value because it
> reads it from the device tree which is read at boot time.
>
> However this value could be read from RTAS.
>
> Adding this value in the /proc/powerpc/lparcfg output allows to read the
> updated value.
>
> However the hypervisor, like Qemu/KVM, may not support this RTAS
> parameter. In that case the value reported in lparcfg is read from the
> device tree and so is not updated accordingly.
>
> Cc: Nathan Lynch <nathanl@linux.ibm.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
> v5:
>  fallback to the device tree value if RTAS is not providing the value.
> v4:
>  address Nathan's new comments limiting size of the buffer.
> v3:
>  address Michael's comments.
> v2:
>  address Nathan's comments.
>  change title to partition_name aligning with existing partition_id

Thanks Laurent.

Reviewed-by: Nathan Lynch <nathanl@linux.ibm.com>
