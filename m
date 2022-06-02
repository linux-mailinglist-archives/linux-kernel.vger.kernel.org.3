Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC67853BDC7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbiFBSKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbiFBSKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:10:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9439F29C80;
        Thu,  2 Jun 2022 11:10:51 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252HEsYC001863;
        Thu, 2 Jun 2022 18:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gsHPmT80X6s0++4QdFoDpD57dZER9fnQBwqTpYG8k8M=;
 b=bQTzI3b08H7FeuYljd3E08bgrumAuanpCJjPOZPWoQsPirG6/zjvcf3ovHcTZAlv/Fv9
 RKGLND5sYThhfggb7BvKMx31d/etBQB8lXeYOxmuzH2AmKgd3liVsNKXLZGOGuhIr/Kk
 ShAWj0CIpgYAzZsEgidGq77MKaCc1QoPN7Di0ZKAAgaiYVnpMGxcNceisSgWXQ2Ru4Nx
 8T7DCkej5EvrESQ77/9nFNT0MRfC61GEauxqZgz8UIokZi1WQjswmYbBCAr87OC7FvLl
 vf6+ah/iquF0lyYR6YzKxz/YL8ZB+RM0hACwA0w2qe4sFcQ3mRvhkqfuYnPBmKQVe0ix hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3geub98pf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 18:10:17 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 252Hw7Bt004953;
        Thu, 2 Jun 2022 18:10:17 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3geub98pej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 18:10:16 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 252I64Me028750;
        Thu, 2 Jun 2022 18:10:15 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01dal.us.ibm.com with ESMTP id 3gcxt5v7uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 18:10:15 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 252IAD1o15729034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Jun 2022 18:10:14 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E302B6E058;
        Thu,  2 Jun 2022 18:10:13 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 414E86E059;
        Thu,  2 Jun 2022 18:10:08 +0000 (GMT)
Received: from [9.160.56.145] (unknown [9.160.56.145])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  2 Jun 2022 18:10:08 +0000 (GMT)
Message-ID: <04d9e84f-dc35-55f1-efd5-81114a6784cf@linux.ibm.com>
Date:   Thu, 2 Jun 2022 11:10:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/4] of: dynamic: add of_property_alloc() and
 of_property_free()
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Daniel Henrique Barboza <danielhb413@gmail.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>, devicetree@vger.kernel.org,
        Steen Hegelund <steen.hegelund@microchip.com>,
        linux-kernel@vger.kernel.org, Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Horatiu Vultur <horatiu.vultur@microchip.com>
References: <20220601081801.348571-1-clement.leger@bootlin.com>
 <20220601081801.348571-3-clement.leger@bootlin.com>
 <4b92277e-5133-2362-8d3a-fa82b0c7a045@linux.ibm.com>
 <20220602085828.2138554a@fixe.home>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
In-Reply-To: <20220602085828.2138554a@fixe.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JpYrWI8wc2385Frrq-MrJebABBiFQWgc
X-Proofpoint-ORIG-GUID: Lrldaw-daiLNpLTkOjUnIDhsjHAmAiae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-02_05,2022-06-02_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206020076
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/22 23:58, Clément Léger wrote:
> Le Wed, 1 Jun 2022 15:32:29 -0700,
> Tyrel Datwyler <tyreld@linux.ibm.com> a écrit :
> 
>>>  /**
>>> - * __of_prop_dup - Copy a property dynamically.
>>> - * @prop:	Property to copy
>>> + * of_property_free - Free a property allocated dynamically.
>>> + * @prop:	Property to be freed
>>> + */
>>> +void of_property_free(const struct property *prop)
>>> +{
>>> +	if (!of_property_check_flag(prop, OF_DYNAMIC))
>>> +		return;
>>> +  
>>
>> This looks wrong to me. From what I understand the value data is allocated as
>> trailing memory that is part of the property allocation itself. (ie. prop =
>> kzalloc(sizeof(*prop) + len, allocflags)). So, kfree(prop) should also take care
>> of the trailing value data. Calling kfree(prop->value) is bogus since
>> prop->value wasn't dynamically allocated on its own.
> 
> kfree(prop->value) is only called if the value is not the trailing data
> of the property so I don't see what is wrong there. In that case, only
> kfree(prop) is called.

Right, Rob clarified for me in the v1 patch.

> 
>>
>> Also, this condition will always fail. You explicitly set prop->value = prop + 1
>> in alloc.
> 
> The user that did allocated the property might want to provide its own
> "value". In that case, prop->value would be overwritten by the user
> allocated value and thus the check would be true, hence calling
> kfree(prop->value).

So, that was the part I was missing. I think a comment would be helpful so its
clear value can be either trailing or user assigned.

-Tyrel

> 
>>
>> Maybe I need to go back and look at v1 again.
>>
>> -Tyrel
>>
>>> +	if (prop->value != prop + 1)
>>> +		kfree(prop->value);
>>> +
>>> +	kfree(prop->name);
>>> +	kfree(prop);
>>> +}
>>> +EXPORT_SYMBOL(of_property_free);
>>> +
> 
> 

