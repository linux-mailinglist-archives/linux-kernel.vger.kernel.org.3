Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E8F4848FF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiADTxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:53:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229962AbiADTxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:53:36 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204Imvgk018871;
        Tue, 4 Jan 2022 19:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gJrZxwfTZYQL/Utzfoow+YBWBL1Ftq4ZELsOh7odyrw=;
 b=muTIsEE1B2CuATmGTZostSQOPCmAjE5j02hcCf55WwMB+fUHsnzY0O/vg4Slt5ynWbQw
 X1E6/tGZxKpULUzMM3c8N/mEGSC0n7G1SbRV6JXqPZ3f4ykfQu1MqAMWkMirM58eMyzF
 vmxseuAUqxwoMjjZhepfQMKTQbSJe5RM+CZrVqhbKg0/Pc7Nmnw9lE+s/isWTMEg4jLG
 7SauEOmlhAOOMFukRlt05G+0mpN7Q+9bOKSWPWTxYnoutjP/bmjZWvjFiWcePxf88ebZ
 GEHJRPYg5sOVdEHpYWPSX+7CzCh1+RaqpQP2tyXO9flqISpjkXPQ9KrPWBEO+mRQy6hx Ng== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dch82nybh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 19:53:21 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 204Jm8n1014078;
        Tue, 4 Jan 2022 19:53:18 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03wdc.us.ibm.com with ESMTP id 3dcv2qrpky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 19:53:18 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 204JrIcC35062072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jan 2022 19:53:18 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 027AB28059;
        Tue,  4 Jan 2022 19:53:18 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 334DE28058;
        Tue,  4 Jan 2022 19:53:17 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.160.94.20])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jan 2022 19:53:17 +0000 (GMT)
Subject: Re: [PATCH] powerpc/cacheinfo: use default_groups in kobj_type
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Parth Shah <parth@linux.ibm.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20220104155450.1291277-1-gregkh@linuxfoundation.org>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <4f0fbbce-1601-7a59-7019-b78e695bc2bf@linux.ibm.com>
Date:   Tue, 4 Jan 2022 11:53:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220104155450.1291277-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -qb6CNl_uZf8bns4Y_ekk3MEyN4dDNkO
X-Proofpoint-GUID: -qb6CNl_uZf8bns4Y_ekk3MEyN4dDNkO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_09,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 clxscore=1011 impostorscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201040126
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 7:54 AM, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the powerpc cacheinfo sysfs code to use default_groups
> field which has been the preferred way since aa30f47cf666 ("kobject: Add
> support for default attribute groups to kobj_type") so that we can soon
> get rid of the obsolete default_attrs field.
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> Cc: Parth Shah <parth@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Reviewed-by: Tyrel Datwyler <tyreld@linux.ibm.com>
