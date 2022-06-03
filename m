Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D5E53C433
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 07:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240491AbiFCF2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 01:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiFCF2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:28:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8143819C;
        Thu,  2 Jun 2022 22:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBxzxDMojYcsQDI65Ll5rrmpSBON77xJT4DQgoVwfQVCazlAnrIxplYAjb4gRFZDP37u3zT2n8cnmhzWZup+3kTude+lu4U/HkU/lWGy+Mis4NHk47jVNSFCjLvkXjLARIoku70S0XofXR64J9gpz6qBv71exKqysV029MiXGqQV4EqpC3KlXAurVMAbctJ7iCl+HCR/ldLAFYxbOq/wU/8gKV11Hfm5MC5e7gAr9j7iM9hhZN0NYU9J8rjoLMytDZB3OSXSTnDyvvpwmRRAsEo7GqUsUTIYuslcZeRJ4HW+kMts6Gb529SGVlBefcy3uB8hw7Sz9B+PQZoj2H+jfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NII/+76QUkKz3DGEpOp6TncNu8SXgxAtXq0Xr+emVRI=;
 b=odgA6e3ll8eXXAQKsal0MqDuPoaoIDFPVzAl3k9iN1O3pGWiex+UVC6eDGlGkaZC497vosCm6CvqKcoUeYfuv02l7SffzzOZLwTPcyQ24ExY4g/t/YthfzAU8SFAGYq1pMtkM0d3AQ4CZuYS7IDJADBGgw7/eesQFFbOC4krp07iXZgV0CgZ5N0xSjWv2nAP7DoomUMMiLWSmCLoT0xObDFeUjnH7J77If3XbUhle1Z+xr4xN4PED4CdeDIjFSMuWP4OqY6sCj8SEDF0LySWFmSUO1bZMRT18buIY9eus8z24IcISkzUEOJKnagZZrlKmbc4kLJFwEICze0lJ9dNeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NII/+76QUkKz3DGEpOp6TncNu8SXgxAtXq0Xr+emVRI=;
 b=mjr21YhZjBzndaWh9aazE2VtIXQDa0wmV+vXDB7uymOe/Z6i1gs6+btWWjhfp3iHpYbW+oSX/uDpg/e1rBB87iA0rhdyN7g/x2hx28USsLNmOKQRAFeJ+oRru+yeTDfSp60RCgp6jR34yR7VLJO3Z6Kj8e6f2wC9gVJe+bLJdSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CY4PR12MB1350.namprd12.prod.outlook.com (2603:10b6:903:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Fri, 3 Jun
 2022 05:28:31 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5044:b3eb:8442:fe92%9]) with mapi id 15.20.5314.013; Fri, 3 Jun 2022
 05:28:31 +0000
Message-ID: <76f02f9c-139b-f26b-0cc6-6edc486f5244@amd.com>
Date:   Fri, 3 Jun 2022 10:58:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v5 1/8] perf record ibs: Warn about sampling period skew
Content-Language: en-US
To:     acme@kernel.org, namhyung@kernel.org
Cc:     kan.liang@linux.intel.com, jolsa@kernel.org, irogers@google.com,
        peterz@infradead.org, rrichter@amd.com, mingo@redhat.com,
        mark.rutland@arm.com, tglx@linutronix.de, bp@alien8.de,
        james.clark@arm.com, leo.yan@linaro.org, ak@linux.intel.com,
        eranian@google.com, like.xu.linux@gmail.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <CAM9d7ch2dtTjhSt9i96yr4JLEWy7EgNArRvSURE4h5gLL6=7EQ@mail.gmail.com>
 <20220603051223.4272-1-ravi.bangoria@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20220603051223.4272-1-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::8) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed1d793e-b82f-45fb-3b7f-08da4521e515
X-MS-TrafficTypeDiagnostic: CY4PR12MB1350:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1350FA842A9F6CD6AB7ECF47E0A19@CY4PR12MB1350.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AzULvVNOnJ1HQkFqjrIMQlaf1iD3HEmSxfyCK47soV0jmRzED6afCA9C1enDQiBhtPYlI6cVhVnIzJRcMLvbgZuj+sKeJCgg2NQ/IfNXxzMBDUN27XbtRJEEfPEMEUnMyyhLYHUKuB78TeYUf609vTSPwfh7JOg8HY0t1x2o/qAkhMpxaFW0N45ItaP2qHP9pBOrMIQ3YP162miJqNtHdcMjtMDyxdGqCepxqTmictnO/AgXe+DD+BYHP/F1vTPmvMNIPw7CRC+8rr6d5vO5P+Km73Qt+EKI+/IczAZWp3NxMMJ9hCbTBkjnXCyqKIJP4LZxoNv06GOVJpYBuXu9Uy5kgf+mCJinvIf/lG8qC15fXHCbFk5A4ezQG6c7l4K9x307dfRHNFYXArntPtYtlyAtPZw4IJbH+cypHiX9IJNqrv1D+lLZ80Fo/jxs5All58ye/SfMotiY4LilzUXZF5qyGqIOFxFx6+jRP0JpynJJakYnNgaqsUfvP4nO1t8RgxB65O7OlsY4uruaG7XzSyXWhzaVYjK4KNmE8t9kHjJlEW6Rc9625bqwa9aoxn3af5/vJDrx5WaSUWSjC0+FMyO9Ky05pIkhmesrpVTDDhHGTtcfB0th/cxx/PQn07VlwpARlWQPgbTW3WsxHabemDAFWxHJhv1Vj2KHn8oxix0w60+CtC2zjLJe+ag7yKRKnJNYhsbwEOdSpb79w8NOCFSpKYiReadGfHFHnVDVEmk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(7416002)(186003)(2616005)(26005)(6486002)(36756003)(8676002)(31686004)(6512007)(66556008)(66946007)(66476007)(316002)(53546011)(4326008)(31696002)(2906002)(44832011)(4744005)(508600001)(38100700002)(8936002)(5660300002)(6506007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHh3ak9YWjQzT0NXSlRlSkZpSG10NjUvN1hpSi9wOE42dHVzRit4R3NGcG9y?=
 =?utf-8?B?YU9WNk1SUUpNWEptcm5nWkd3Y3FOZGZZUUdzR3dWK0IxS1ZQckxUUTJ6MXRV?=
 =?utf-8?B?MHhxWTNndDViVVcxRUw1RTNpd1JmNkkyL2RCV2traTZ0SDRKV1dEeWZRZmYr?=
 =?utf-8?B?cDNFR08vd2FqbnZEQ3dhVWdUU3hLN3pyTWR4WFk2b2paQStqa0R0TXROeW1F?=
 =?utf-8?B?ckMyVE9LazFXRGpFUUpPVGhsZHdWLzJGczVqSlNxazA3eFNidDlvd0t2Vzdh?=
 =?utf-8?B?N1hMVlZBYU1OUnVkS0RuU0JqbE1wSzVOZG1NSGNRZGxLcFVmd2RqNy9VNzJk?=
 =?utf-8?B?bXNYc1FjbkVpOEtwUVozU1AvUEhVRUtJdFlRc1BvYU9hUWZUc3BWSDRmalBB?=
 =?utf-8?B?M0dYVHZlUnpMaUdFaVo5bnZYZElzV3VRUjB1TkVGNGQ1SGJYd2ZIV3B1c1A3?=
 =?utf-8?B?N2lFenRDQnRNWWtnLzU3R0NubjJ3aWNyT0phTk9FZzl2ZVdyR1paTitOaFk0?=
 =?utf-8?B?YlQvYkhJek9SUG1Xc05wYmhWUVo5cGR1OFArMUVndGRXL2tXUGx6eTN6RHVv?=
 =?utf-8?B?U3Ixa25laWZkNVBiLzdFbW01U01MMFR6UEQxRFdudWNKOUN2STNkM1VTdWZF?=
 =?utf-8?B?Y002WVd0dU5wbEp3L3B2OEdwMG9HQys3TjUyZ3dKbnpVZVcwcEoxZlVEK0gw?=
 =?utf-8?B?VVMzZUZiTTFXb3lRSzhhUHNuMExmRG5pRFoxL05pVlgyNitqM0lqVThHbzdU?=
 =?utf-8?B?Y2xVNDBqNHY0UndQME1GN2JwUVkxeTR6TkFQMDJraGhHUXJ3cnRwTksyQ0Yy?=
 =?utf-8?B?UWl5UE9zNnpRNmprNWpQRFBLT0N5Rlk0dndST0U5VEtmakFnS2RHUnJNSHBT?=
 =?utf-8?B?N3BnMnFvWUlSbXZKQUhVQUJoMHc1QldXSWlkNHQ3dldrQUtwSGl5b21SN1R6?=
 =?utf-8?B?bVlpcW0rQy9BaTRPcEplbjFJakg1ZWZPRlFpNWhZTEptalRnS3VNbGthTnNX?=
 =?utf-8?B?TDF4MHY5aFMrVHRMQXUrTUN5ZzBXeERPWnducGpaVmVXVnozc1BLVmlsY1Vx?=
 =?utf-8?B?RTlEQ0xUQURiOWJzdDdHR0VWRk9wRXBWWkkvOTIvb2FGbGxQN0pRZUtCemFM?=
 =?utf-8?B?QnpXcjVpTGFkT25SWnBnaWlyeTBPNjBmMUF2ejVGcEVCR3kvSTFiaFV3ZU5w?=
 =?utf-8?B?RDFvTS9aUHBzMGhiOHltRjYyOW9uT0QySTUwb1dzWXlGUUZJYktXQnRmNGVZ?=
 =?utf-8?B?RFU5U2NXbHdoVXB5WWNjeGhRNlkwVlRKb2wvUlRBL3BxNU5GaVMwMVZieWZQ?=
 =?utf-8?B?L1hzc2dIMklCZmRJMWY3b1JVYlAzcVdMUjBuN0NJemtOZkJwelJNUndzZEhi?=
 =?utf-8?B?QWhxMFRZR2lwNWtTbGlnLzdXZVp4VlBNUmZBY2xpU1NqYStyOTJRRjd3Ynht?=
 =?utf-8?B?Z2hkZmFUZjdURGJRMXFVaXBWSmxleERabVVkamUrbTBvcGFuSTZIVFkvaUc2?=
 =?utf-8?B?UE5uN3BGWFMyWHhuN3labER0dHA5WHN6MGlTK2wzZnVnWVJJcXFwM1FkNm1v?=
 =?utf-8?B?MGwxK2dwV1FFdWMzbWFkT01BR0lmYm4vclBmcDJGNnRsOWg1eVUxYk9uSlRT?=
 =?utf-8?B?TjVUVFNqUnUxVm1lQXE5WXRHd0NORXVGT05QY0FuZzBzOHRVNndEek01aExp?=
 =?utf-8?B?UXRCTmF1YTFQV2ZyMzFnQlJ5a3RBaUYwSGk0bWowRnBGdUJXdmpZb1J3Nmlr?=
 =?utf-8?B?c3hSWHRhb01HK3YrN0htR2tEN2tHbFVEdU9qOEZMbDE0TnpFYTEvdmcyTUZ4?=
 =?utf-8?B?cGs3MjBJZGhPdmhUa0lEcHpSKy9uSHVsSFFxVEhDVHRObHgzWVlNcWRBRHl3?=
 =?utf-8?B?TkpLUlpFc2RMdEx6YkxtaVpwR0xCZzZRdTFxTnpQdlJndGQ3MGJDSTdBdTJP?=
 =?utf-8?B?dHlHckpPeGpmYzhmSDhUNE9Xc2ZteExCV05rTDE0Yzg1OFdXd0xpMXNISlMz?=
 =?utf-8?B?SHVOVTV0cCtUWlU1OFdHREhQMStNaDFZRzVHVmN0UURSY2ZtdEhCMDJoUHlZ?=
 =?utf-8?B?ZXhXc2EyS2ppK1p1QjVOR0hYTWxZM1ZyZ2tmNTFNUlZteGRUcWxwSGxpck4y?=
 =?utf-8?B?eXYvTjQ1LzE0am9TajU5SExvdktFdG43SnFKUlhJR2FBUS91ejhRaXB2SGUx?=
 =?utf-8?B?M2VJcmU0WXUybCsxZ0E5dnRqcHMvd2hOcEh3ejFWVVFHcEgyRFp1aW5LYlVo?=
 =?utf-8?B?djBLQWJ6YmpkQ0xyM2k2dTJhcUhnazA4bTJQbGx1dkQzNnowSVVzb21qTFNl?=
 =?utf-8?B?MnlCZXRzTG43SXMyRmc2TmdNMlJIWjA3TEJRckp5RmZ4K0hyOHhqZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1d793e-b82f-45fb-3b7f-08da4521e515
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 05:28:31.0501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0B1pXkcfSGcuXC5t6E7Ew1d0aS6Y7SWVNIzGIDghx9HZEnmh5dTiFMr/WfyXUAV6juUFOS9WyyN0LtVRepJKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1350
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-Jun-22 10:42 AM, Ravi Bangoria wrote:
>>> +       if (ibs_fetch_pmu && ibs_fetch_pmu->type == evsel_pmu->type) {
>>> +               if (attr->config & (1ULL << 59)) {
>>
>> It'd be nice if we used a macro or something instead of the
>> magic number.
>>
>>> +                       ibs_l3miss_warn();
>>> +                       warned_once = 1;
>>> +               }
>>> +       } else if (ibs_op_pmu && ibs_op_pmu->type == evsel_pmu->type) {
>>> +               if (attr->config & (1ULL << 16)) {
>>
>> Ditto.
> 
> Thanks for the review, Namhyung.
> 
> Arnaldo, Would you be able to squash below trivial patch into original
> patch? Please let me know if you want me to respin the series instead.

I'm planning to respin with asprintf() change. Sorry for the noise.

Thanks,
Ravi
