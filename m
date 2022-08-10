Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439CA58F4D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 01:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiHJX3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 19:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiHJX3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 19:29:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22107D7B5;
        Wed, 10 Aug 2022 16:29:29 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27ANBbf0023102;
        Wed, 10 Aug 2022 23:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=quIGPsqtLqF7aXUBe4lP+sBqoJmFgr07FA5mHK6JcAM=;
 b=kCVBBFT4TRonS7fhm0QRXdI0UjO9qurXCgUjvYh5y6rqi6tnfqjsdjKQYS+IO7JhGiFh
 yH3Sz7YlocIdeBPtvdCA6HKmfpCWKORDjw3/848AT2ubCMBMsMxT4FJLXwONL5YvAd9C
 dakJ8KOCBEoS1cn5ckxDyI5Zf458VSkL3F4IVckLGQZfeYH11/OxvZIR5yVbikLsSwsq
 feg1Fadr2EdXuXKZgqlfMzBLeAGcyzjA4ih1TT/twIc+cxW9uozkTWs6h9eT2S1cM2aq
 /HetVCmpqx2VSB+XbtIieQCUUcw+Lpd5+PSTGdrGZttKylb9Nd2zY3Cu6yezAeySRi+D Ww== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hv95ytg18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 23:29:20 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27ANTIPb020777;
        Wed, 10 Aug 2022 23:29:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3hshck6uv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 23:29:18 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27ANTI5p020772;
        Wed, 10 Aug 2022 23:29:18 GMT
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 27ANTIIo020771
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 23:29:18 +0000
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 10 Aug 2022 16:29:18 -0700
Received: from [10.253.34.2] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 10 Aug
 2022 16:29:17 -0700
Message-ID: <e6839a7e-d1f4-7d9f-68f4-f99c216f647f@quicinc.com>
Date:   Thu, 11 Aug 2022 07:28:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] tracing: react to error return from
 traceprobe_parse_event_name()
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220810150921.8858-1-lukas.bulwahn@gmail.com>
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <20220810150921.8858-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: o7JyeiHgJQYR3zvgatp7QlQDUrb98LN6
X-Proofpoint-GUID: o7JyeiHgJQYR3zvgatp7QlQDUrb98LN6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_15,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 adultscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100071
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Lukas,

On 8/10/2022 11:09 PM, Lukas Bulwahn wrote:
> The function traceprobe_parse_event_name() may set the first two function
> arguments to a non-null value and still return -EINVAL to indicate an
> unsuccessful completion of the function. Hence, it is not sufficient to
> just check the result of the two function arguments for being not null,
> but the return value also needs to be checked.
>
> Commit 95c104c378dc ("tracing: Auto generate event name when creating a
> group of events") changed the error-return-value checking of the second
> traceprobe_parse_event_name() invocation in __trace_eprobe_create() and
> removed checking the return value to jump to the error handling case.
>
> Reinstate using the return value in the error-return-value checking.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>   kernel/trace/trace_eprobe.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 4a0e9d927443..460d3ec8a256 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -883,7 +883,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
>   	trace_probe_log_set_index(1);
>   	sys_event = argv[1];
>   	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2, 0);
> -	if (!sys_event || !sys_name) {
> +	if (!ret || !sys_event || !sys_name) {

that's right, miss case sys_event and sys_name are not null, but invalid.

it should be  if (ret || ...)  ?


>   		trace_probe_log_err(0, NO_EVENT_INFO);
>   		goto parse_error;
>   	}
