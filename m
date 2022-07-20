Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289A957AB1E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 02:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbiGTAtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 20:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiGTAtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 20:49:08 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50040.outbound.protection.outlook.com [40.107.5.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221731BE86;
        Tue, 19 Jul 2022 17:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRDTfCP9D4QUKx7pOllrqg/djfFKf+ckkjs0LvKN71T/AnmB5x04DwaTDOswi6cMVbXZx0uGITp+ekLveszTcrUCpnu46ryikmxR5s1RrTMje8ecZe6PLo06eP5/NnV9CpF1qhw4tOLNFLt+dONBWXKin3QW17M5+AyFQaV9wfknVQaxyn51+hFA99OHGLApEssH1kGujiihnAyph7eOz02QQcRO1Biz9mLx8H9sSuHR6yv4LW0Nv2b2bi0ZceH1EVnI6Yr+UdKnLgYwmuY70JyiAX6eERHT/hy0shH+qeMbZSkAqWZF705L5x4sK3O1LOW0NnVtN+Sj2/Gkwx5PKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1Bx1jGQ5NKKt0EZOMhXKoSUclPhu3P3FU1UB0roM/U=;
 b=GN3xed1wiaDXSmpXzEGsn4jNNuzvtQox944GJ1chM6vhga45fdQudrZ1Ku4w7mq0Qoslxmg8+BtK3/uAUfYAZBjrQ4sWxMCW7y6ULXAdx8atyfG7MdeVUf/p+HactBWIXx2018caEWGL/Yc0jF9rD1ONiIAjKuKK+DuL5irW0JCK4BLYqjdMEtR0iekZq26x4Qk8VE1ndgSsjuXWbw/vrs8eyzjYoNZGUaJuOx5w0i/8Phd596xrqSU6imNNjp6JmHU9sIGMG2tLQEkS29O1vpNvl773rPWHIH/VvKhlX7Ji6Os3aW0ffTXkg+4EdmAEIjybgR4Gb3HiQyaeQds4cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1Bx1jGQ5NKKt0EZOMhXKoSUclPhu3P3FU1UB0roM/U=;
 b=JLIC0Cq3mi4udoCcwBLEtkhiTuxGDR3yl9+HyoZE1vTTnkNPCt8D3mw+ScSaAdA8/RUP+Ao3QIOp1r5VhpCJWxtQRTryJm/9YE/3/GL0EAQgzEW1NKYOXVT6+0TFsMkej52jc/UqpSfeahlS40hW5o0QbHL7wRH5icM4ZiTlVxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7851.eurprd04.prod.outlook.com (2603:10a6:10:1e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Wed, 20 Jul
 2022 00:49:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 00:49:03 +0000
Message-ID: <7fdd22ee-e9be-3a68-d6ad-3fae7499ffbe@oss.nxp.com>
Date:   Wed, 20 Jul 2022 08:48:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] remoteproc: core: check state in rproc_boot
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mathieu.poirier@linaro.org, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20220519064111.3244079-1-peng.fan@oss.nxp.com>
 <YtOK+XU+dtqfnsox@builder.lan>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <YtOK+XU+dtqfnsox@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdf99569-6cea-4902-9620-08da69e9a42f
X-MS-TrafficTypeDiagnostic: DBBPR04MB7851:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tkBogFD63h627dgd6oNzKPULeIf4ypcw76Zq13AHJLjbVvSQuyzNBxmSB5Nq9rtgkNOpIO40/9g3o+A7Kaqr0ptqrGPa8nT5wYDCRIR13sfEyp66LRVc9p9sOdSF+1nK6B2t9rlgAN8fA1PjwMjWKImw/e1Rh+ni9o7uNShkr7IyEqhMaH6Hji5hUDiug88ndz7dQ00/5K72ndBrbIUMmw0FziVxtg8Lj/zNL49wKo7KC609sjGUAjd7+wxFpzyFWUvo6tH1IWjW/IGTCMNraOK+EkTCDf5f8A+2LekE+CMgdvcePc7mIxddmYlqIjmn6iuMwKO/5/Lm4EH0DW2l2Ub9rUsz3Or//7SnsqtVCFSy1u9zptCp6R9cTJDtOk4r/4vO6h5BEfimX8k4sSqZJq/OK4gUiGMsHwTYDtSqKkYJrMQaiKgx1nWicEzsqZ4tW8LDgv+HEa8o4chYfeWCW0exGl1ab99d5QlJGHCXLcrlajR3V9bzpj4D8nd79U+feo9V5WJaWlOoJ9JsnwQeOW2GuMCk1Gz8cQK2NJMadXmRcX6rTFgTV5gVvyEFjBIheBJUrk69BB0KHCes4J7Gk4g2O5Yjg4YRUJ2/emevTIh2fok1x2qJ6bLEac4iV/UrKKOvydPfgcPVdZ9KBtDQ73gClZNkmt7PMh/+s3FD1fb6szV7o/VN9X/kYlJeYPmY57HU0hqPwWPNST8AkLd042WM8r+qcSEyy9McJh5jyXbplNdM/rgrYoHqy/Xw6pyCPwf0eFE0BI1W6JgE73npp7DmcbI71knqvVYPxSJ8A57b9kHSQ6wxdqjGIw7IJNlIlbMs3h/Mn9gevJpTWSa3HZX8/TYmeGN7VKbsve0uunk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(6666004)(26005)(41300700001)(186003)(478600001)(2616005)(2906002)(83380400001)(6512007)(8936002)(52116002)(53546011)(6506007)(44832011)(5660300002)(6486002)(31696002)(86362001)(38100700002)(66946007)(316002)(38350700002)(6916009)(8676002)(31686004)(4326008)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVhHSmp4YVdheENqc3NiRU1LbmNFVnF3aVJTUGF2amZmTjkzRWJnSmhRYUds?=
 =?utf-8?B?NytzeTJlbGQ4bnpZa1ZoaVN2RW1XYW5ISThBQXZFdCsxVVRjVjVQWkQvbTk5?=
 =?utf-8?B?b1FrMTZOZUQ2NHByR1RlMkc0ajg1bEpXa2ZFY1V0Y0RzdktWZTMwUExycTdH?=
 =?utf-8?B?aXhlQVQrYlFxWE90RjR3aWJYcGZBTWFvS0xwYWNvaENJN2hGWVh6SFZhU0dC?=
 =?utf-8?B?a3hzOHpLK3RERDFWNmRxeWxMdE5UeGRWQWJKTW96RnREMWFQVGFKT1crdEs3?=
 =?utf-8?B?SjNNdHdkd3RqcXAySGVEdXhNblBTUUk3aWl5aDFNYlhFK1Zyamt4MlZtQjVo?=
 =?utf-8?B?ZGtIVlFrZ0RUOG91bFh2VkhtaHREckpCSG4zZjNzZk9qWFpLWTdORmlpSnUr?=
 =?utf-8?B?M2hDOGMvSWlqUTViYWNNbTIvZHZROXdNVUZKcUwvOS8xemhhT3NsNkpGL0Fi?=
 =?utf-8?B?bjdVaGd1VnNhbVc0b09FY1VWeWgwSGJVZThEb0R4ZnZlL3I2aFkrTk5aanFT?=
 =?utf-8?B?OWRzME55alNPdEUwK0oycDFvMmg0ZVJCbzdMK1NBWGlTMitkb3Z0cVpGWEFH?=
 =?utf-8?B?azVFanpIVjdaTk0zN0xWbDNnbnRpbTQzUCtkTU16VjBDZU1qSEF1U2tidmNo?=
 =?utf-8?B?UmxnOXZ4b1FWckJKT1ZwWXlrcWk5OGhuNzAwMktaNU03S3NyREtDRzZYZHNU?=
 =?utf-8?B?b2Z1aFlja0V4RnUyMTIxYllvVzdiODFUdzRiWWZPZmpXSUovLzB2cWhOTi8x?=
 =?utf-8?B?TGRNcWNLWjVYaWFCRTF4K0d6U1IzVkZicElxeVowYU5ua0VkMFl1ZFNSWHk3?=
 =?utf-8?B?MUp1SHdEL3IwMmpDZnlwYzd1WjV6NERhak41MmhSanRXLzlENXR5VC92SmMw?=
 =?utf-8?B?VHYveTBXamp0N1VQanh3ZVdNTHREVnJjN09sbHoxUFFxeXQ5dG81aGtUVEFJ?=
 =?utf-8?B?blU0THd2MEYyMkh2bmxUdE4zYXVzbnRLUEY3dk5JazNSdkk0eWh5T0JoRmZD?=
 =?utf-8?B?WlhaK1ZBdk5hbVFnRXBZNUxWTUd4dk1QaFlEUHNadG5zUkJrU1liK3l6L2NP?=
 =?utf-8?B?czRkcnpHRDM1bzJ3aDByU0J6MUJUYUdEdDJicDUyQ0g5OXFEVzhmbXAxNWxQ?=
 =?utf-8?B?bmNTZG84dmdlMk5TUE9IYlZ5a2lIdUxYOWloL0JIZ1d6bStqKzdObUhHczE5?=
 =?utf-8?B?dk9jcUt5elNHUTRSVzB5RVp5cjFGSVRnN1F2L3BHVHV5MWtudHdxOEVSRXRv?=
 =?utf-8?B?S0VFM3cyQTVCOHFHaHlHUXB0d1FYL29wNTdncitkaUkzeGNYdDkrbTN4MTdw?=
 =?utf-8?B?S1h3cEFHWjk4UFBRSS9hQ3p6ak1UWkNYcHdUdDNlRGFFRkNyWjRqT1A0ZWQ0?=
 =?utf-8?B?TlRwOUxJd2ovRzFIYjJna0VoSHdJZ1poODFxdUpsaU5qT1ZSNlJOMTJJWWRY?=
 =?utf-8?B?N0dHYVRGclQrYzM0amI4YThpMXpSTnJNUmdHejM2RWpJSW5LRGlrZ2ZVTkVv?=
 =?utf-8?B?VHlISWxDWDN1a0prS2JDN1Nkc0xveG5yMnZESldKUk85VktBa0d5U3pyWEc1?=
 =?utf-8?B?ZGp1SXAvT0N5dUpVdHRBbjdIZmFlRnpiRFQvNlFUcU9kOHB5VWJ3VHFZR2NR?=
 =?utf-8?B?RFV4YzBDVGhMTHdFbVE5dVlSOWNFVUlEZGQ1cUJNaHIrTFQrSGVtRFZzT0Jo?=
 =?utf-8?B?WXBrZC8yWkowM1pVbk9GUlpTSjd2bk8yYWxtZUJLMHcxUmJTNTYrUTZCZW0v?=
 =?utf-8?B?WGJBL3N5SWtaR3lpVndOdGZTcDY0dmpuWGN2WnlXSTljR0ZnOURJREVLZVl6?=
 =?utf-8?B?cERDM2R3TDM3MzJtY3l1RDFiL1BwSHU1TThNN1BWSGk3WnlWV3VVMnN0WHp0?=
 =?utf-8?B?MEs3dkx2SCttWi9wMnFZWGF1RUZZT3hPbWJYMDU5UDRGL3NTbDlWTmczRjVj?=
 =?utf-8?B?aVU3MVlpd1BJcHBzMnhzWm0yNDllRVNhTGhQY3l4L3ZOZXBvVXgrcHVvVnRt?=
 =?utf-8?B?OHJteGxiSXJWQ1ZUTysrS1BXdncwbFVaTVFzOFZxK1d0UDNTY1J4YTQ2TS9O?=
 =?utf-8?B?Tk5xS28yOHVtKzhlM29zTUV4eDl2a085UFFzbFZ2N2tjZFU4T01jVllVcGhX?=
 =?utf-8?Q?6opFn+9s3i3X/w5PkqdZsxsPv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf99569-6cea-4902-9620-08da69e9a42f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 00:49:03.2818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+0ANtapYSBJqOQn+Uax7Kngzlmls425TtU8ZodteaiUB5e+pNvt+8njNk4OqiB2JwB8oUSO1v4GDEanzpf05g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7851
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/2022 12:07 PM, Bjorn Andersson wrote:
> On Thu 19 May 01:41 CDT 2022, Peng Fan (OSS) wrote:
> 
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> If remote processor has already been in RUNNING or ATTACHED
>> state, report it. Not just increment the power counter and return
>> success.
>>
>> Without this patch, if m7 is in RUNNING state, and start it again,
>> nothing output to console.
>> If wanna to stop the m7, we need write twice 'stop'.
>>
>> This patch is to improve that the 2nd start would show some useful
>> info.
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>
>> Not sure to keep power counter or not.
>>
> 
> I did discuss this with Mathieu, whom argued in favor of keeping the
> refcount mechanism.
> 
> I can see that there could be a scenario where multiple user-space
> components keep the remotproc running while they are, and if there is
> any such user this ABI change would be a breakage.
> 
> That said, it's more than once that I accidentally have bumped the
> refcount and then assumed that a single stop would tear down the
> remoteproc...
> 
>>   drivers/remoteproc/remoteproc_core.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index 02a04ab34a23..f37e0758c096 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -2005,6 +2005,12 @@ int rproc_boot(struct rproc *rproc)
>>   		goto unlock_mutex;
>>   	}
>>   
>> +	if (rproc->state == RPROC_RUNNING || rproc->state == RPROC_ATTACHED) {
> 
> If we were to do this would it make sense to boot it out of anything but
> RPROC_OFFLINE?

It is just a bit confused if started twice, need stop twice without any 
notice.Not a critical thing, we could leave it as is.

Thanks,
Peng.

> 
> Regards,
> Bjorn
> 
>> +		ret = -EINVAL;
>> +		dev_err(dev, "%s already booted\n", rproc->name);
>> +		goto unlock_mutex;
>> +	}
>> +
>>   	/* skip the boot or attach process if rproc is already powered up */
>>   	if (atomic_inc_return(&rproc->power) > 1) {
>>   		ret = 0;
>> -- 
>> 2.25.1
>>
