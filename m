Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6754C951B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbiCATwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiCATwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:52:20 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4BD5938A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:51:22 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221HclT0005247;
        Tue, 1 Mar 2022 19:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MouVo7w91t4SsdQ6PvZTAXvOzPAp8CNaYjEobzvIgJM=;
 b=gkp89Fnpu0Mxbcnwp4/+koCrYjRYSxL9uaxPS2QamnGfwaDuW7+QpYmiBKGszGpfogkl
 rn9GDIxXk6lmrltHuIm8+8iclBQV/xS7Fpj8NbFofdRhdBPvZNJ5QqudygrHFB0uSir7
 +L+raE2Bt4WPJo1UAWaSKAWkmndcIpeaW1QzEaIo2uuuUzQBIVLTARfHWG3dtm9kLZ7n
 bb5ib4BbFpvpMHN20k+KR4eWlXBTfMG78PS2EfcPZsaucmHILSG/td1gURN+zBfOtt29
 sUGbDWxvLHklu2QveLs2rxnqeiPp9lkiJ5+tPi1uE3L8ThP/rbcfL/6qZzSIhfySMAmA rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ehpd4wtx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 19:50:17 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 221JcEJF025465;
        Tue, 1 Mar 2022 19:50:16 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ehpd4wtwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 19:50:16 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 221JlxTO007093;
        Tue, 1 Mar 2022 19:50:15 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 3egfss5fct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 19:50:15 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 221JoEwh55116082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Mar 2022 19:50:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4174B2067;
        Tue,  1 Mar 2022 19:50:14 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0286CB2066;
        Tue,  1 Mar 2022 19:50:14 +0000 (GMT)
Received: from [9.160.109.9] (unknown [9.160.109.9])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Mar 2022 19:50:13 +0000 (GMT)
Message-ID: <825f5cba-a62b-a691-225e-22f6bb9b10a8@linux.ibm.com>
Date:   Tue, 1 Mar 2022 11:50:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] powerpc: kernel: fix a refcount leak in format_show()
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Hangyu Hua <hbh25y@gmail.com>, benh@kernel.crashing.org,
        paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220228091103.39749-1-hbh25y@gmail.com>
 <87o82pomrc.fsf@mpe.ellerman.id.au>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
In-Reply-To: <87o82pomrc.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bLTeE4ofWdYxIBK_qwW0l4KABtBqpXPu
X-Proofpoint-GUID: jhHchhS53kz9ByTeVmiqoANFmnfJuf9F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-01_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/22 04:55, Michael Ellerman wrote:
> Hangyu Hua <hbh25y@gmail.com> writes:
>> node needs to be dropped when of_property_read_string fails. So an earlier call
>> to of_node_put is required here.
> 
> That's true but ...
> 
>> diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
>> index a0a78aba2083..cd0fa7028d86 100644
>> --- a/arch/powerpc/kernel/secvar-sysfs.c
>> +++ b/arch/powerpc/kernel/secvar-sysfs.c
>> @@ -30,13 +30,12 @@ static ssize_t format_show(struct kobject *kobj, struct kobj_attribute *attr,
>>  		return -ENODEV;
> 
> There's also a reference leak there ^
> 
> So if you're going to touch this code I'd like you to fix both reference
> leaks in a single patch please.
> 
> Having the error cases set rc and then goto "out" which does the
> of_node_put() is the obvious solution I think.

update_kobj_size() in the same source file provides a good example of the
suggested solution.

-Tyrel

> 
> cheers
> 
>>  	rc = of_property_read_string(node, "format", &format);
>> +	of_node_put(node);
>>  	if (rc)
>>  		return rc;
>>  
>>  	rc = sprintf(buf, "%s\n", format);
>>  
>> -	of_node_put(node);
>> -
>>  	return rc;
>>  }
>>  
>> -- 
>> 2.25.1

