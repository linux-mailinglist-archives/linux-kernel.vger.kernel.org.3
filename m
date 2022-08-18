Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D9A597D04
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 06:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243106AbiHRERa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 00:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242983AbiHRERQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 00:17:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C8E910BE
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 21:17:15 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HMpFUM028738;
        Thu, 18 Aug 2022 04:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zNLZYmX2p5iSZQSeBnGn7bq7FBQS1XMrv0gSv1lLN0c=;
 b=I0GS9YNC3ORADBJW1M5JoO4ub4UJvuMRGtGFkrN7OEuXEgSv9gP9U3q/tFtEj3yx/bI8
 xDPvx9WjuPpG83g3E4ro92Ji2sMdQ9Si3qnWf6iAPGk1oJ7xDX5tDd9Sf78Gtj14xl8V
 lut/8jU8Ei4BEgFY6nUwdRcL+TZfxJvdugHgUBmu4ELuIAxl65i3CLSUe5cRXywUOUeY
 zb6012LTR5ocjblSxJwZj12haHhb8UTbl/ayHKUcaGe9f3TuLZbnK8BRogdhAkXKkxGm
 jSZpl4zZ8HePJdUmvjAjvs1fE6+ECvO83DW3C5Q61HW0gUoKeiSg8ucBJozTtyKOcAt3 Bw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j181xhcnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:17:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27I4H2Og017942
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:17:03 GMT
Received: from [10.232.65.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 17 Aug
 2022 19:25:27 -0700
Message-ID: <4f90ea32-4d18-dcf7-0ca1-586f7e6c8043@quicinc.com>
Date:   Thu, 18 Aug 2022 10:25:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v8] mm/page_owner.c: add llseek for page_owner
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <vbabka@kernel.org>, <minchan@kernel.org>, <vbabka@suse.cz>,
        <iamjoonsoo.kim@lge.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20220816020748.18040-1-quic_yingangl@quicinc.com>
 <20220817091324.59afdb143b6330974f4e9e4c@linux-foundation.org>
Content-Language: en-US
From:   Kassey Li <quic_yingangl@quicinc.com>
In-Reply-To: <20220817091324.59afdb143b6330974f4e9e4c@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: REoGvHdDLkWb0kwcqqLzvZg1W8l0x6AA
X-Proofpoint-ORIG-GUID: REoGvHdDLkWb0kwcqqLzvZg1W8l0x6AA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_02,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 mlxlogscore=679 spamscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2022 12:13 AM, Andrew Morton wrote:
> On Tue, 16 Aug 2022 10:07:48 +0800 Kassey Li <quic_yingangl@quicinc.com> wrote:
> 
>> There is usage to dump a given cma region page_owner
>> instead of all page's.
> 
> So... dump all the pages and then parse out the ones you're interested in?
> 
> Presumably this is too slow and presumably you have a use case in which
> this operation needs speeding up?  If so, please fully describe all of
> this in the changelog.  If not then please fully still describe the
> reasons for making this change.
> 
that is correct, I will update the change log for detail make it easy to 
know why we need this change.
