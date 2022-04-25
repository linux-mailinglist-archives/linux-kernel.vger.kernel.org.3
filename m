Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1EA50E9D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245072AbiDYUAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiDYUAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:00:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AE16D1B0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:57:41 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PHrtAH018583;
        Mon, 25 Apr 2022 19:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rzOZY05sMrf/EyKUousQ6nG2a/dktO7YtCTvwGbjOuM=;
 b=qg2UlzpS3EuA3J84Ud5upf4v8a/UKSuL5EYUZomON0y0hMP4ceGFJdU3pYK0HdnBoUGM
 AFX4TAg4Nr7gccDkocq3FudHUNjtzsW3gHYJMu2Vy2P52HqVzBy8tQtV6dm6K/PGfL0C
 FD/ZuK2uDvEMJBMoBnZ40YQQp4TFDW/stBTivqZuMvl0agPiDvx4gW78ondPHIV+3C0w
 Dns4CVaBxyBa/7AQ74yA8ZsJaOYHVt1EZo9XpmtXJ2S7rssDM6aFE1hH9/EsgnKOYX7a
 FmyEuMl0wgZUWmgDF0N63IHBngY4tmbMXrAW3CtGrGMw0235W59A5e5j2DRJ2awvdU/S KQ== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fmtt7jwmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 19:57:04 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23PJcPkd022079;
        Mon, 25 Apr 2022 19:57:03 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3fm939kq6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 19:57:03 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23PJv27K30867730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 19:57:02 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0E346A057;
        Mon, 25 Apr 2022 19:57:02 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 642876A047;
        Mon, 25 Apr 2022 19:57:01 +0000 (GMT)
Received: from [9.160.2.163] (unknown [9.160.2.163])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 25 Apr 2022 19:57:01 +0000 (GMT)
Message-ID: <7426c4c7-b2f2-5453-bdab-a88c7308b212@linux.ibm.com>
Date:   Mon, 25 Apr 2022 12:57:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] powerpc/pci: Remove useless null check before call
 of_node_put()
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Haowen Bai <baihaowen@meizu.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1650509529-27525-1-git-send-email-baihaowen@meizu.com>
 <c4613523-de98-b824-175a-89fd66931bd6@linux.ibm.com>
 <87levv98fa.fsf@mpe.ellerman.id.au>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
In-Reply-To: <87levv98fa.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z3dM67XhDBJtArThUik2_uqDk28TRsRp
X-Proofpoint-ORIG-GUID: z3dM67XhDBJtArThUik2_uqDk28TRsRp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250087
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/22 07:32, Michael Ellerman wrote:
> Tyrel Datwyler <tyreld@linux.ibm.com> writes:
>> On 4/20/22 19:52, Haowen Bai wrote:
>>> No need to add null check before call of_node_put(), since the
>>> implementation of of_node_put() has done it.
>>>
>>> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
>>> ---
>>>  arch/powerpc/kernel/pci_dn.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
>>> index 61571ae23953..ba3bbc9bec2d 100644
>>> --- a/arch/powerpc/kernel/pci_dn.c
>>> +++ b/arch/powerpc/kernel/pci_dn.c
>>> @@ -357,8 +357,8 @@ void pci_remove_device_node_info(struct device_node *dn)
>>>
>>>  	/* Drop the parent pci_dn's ref to our backing dt node */
>>>  	parent = of_get_parent(dn);
>>> -	if (parent)
>>> -		of_node_put(parent);
>>> +
>>> +	of_node_put(parent);
>>
>> This whole block of code looks useless, or suspect. Examining the rest of the
>> code for this function this is the only place that parent is referenced. The
>> of_get_parent() call returns the parent with its refcount incremented, and then
>> we turn around and call of_node_put() which drops that reference we just took.
>> The comment doesn't do what it says it does. If we really need to drop a
>> previous reference to the parent device node this code block would need to call
>> of_node_put() twice on parent to accomplish that.
> 
> Yeah good analysis.
> 
> It used to use pdn->parent, which didn't grab  an extra reference, see
> commit 14db3d52d3a2 ("powerpc/eeh: Reduce use of pci_dn::node").
> 
> The old code was:
> 
>         if (pdn->parent)
>                 of_node_put(pdn->parent->node);
> 
>> A closer examination is required to determine if what the comment says we need
>> to do is required. If it is then the code as it exists today is leaking that
>> reference AFAICS.
> 
> Yeah. This function is only called from pnv_php.c, ie. powernv PCI
> hotplug, which I think gets less testing than pseries hotplug. So
> possibly we are leaking references and haven't noticed, or maybe the
> comment is out of date.

Looks like we leak it. From pci_add_device_node_info() we clearly take a
reference we don't free:

        /* Attach to parent node */
        INIT_LIST_HEAD(&pdn->child_list);
        INIT_LIST_HEAD(&pdn->list);
        parent = of_get_parent(dn);
        pdn->parent = parent ? PCI_DN(parent) : NULL;
        if (pdn->parent)
                list_add_tail(&pdn->list, &pdn->parent->child_list);

        return pdn;

The question becomes whats the right fix. Doing a double put in the remove path
seems wrong, and looks gross. We no longer store a reference to the parent
device node in pci_dn::parent but instead a reference to the an actual pci_dn
struct. Seems to suggest we can drop the reference taken in
pci_add_device_node_info().

-Tyrel

> 
> cheers

