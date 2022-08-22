Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5742559C10D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbiHVNzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbiHVNzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:55:12 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D40399F0;
        Mon, 22 Aug 2022 06:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyUp7DcmNu+IIyPFefelLWo9HW7Dh8rZhr3EAeKmIAQhss0b4cgwDwyp7+pRRbS2IKY92ptM5PBzPZTMfAlUDpIw7gKfnHuE5ax2zxSLYqdY5pmcGQFhlksIdw3WLWGffOVKMEKYVSYvL0KX3xphshXfpJMtpgJPAn3KcUDNCpWnzNiSDN0QYOUmBQu3GMX3fKiAeSV0VS2xgjMC54kYc6s0L3z7t3I0OGP0vTY9awnzgCs2K8hfKaWjntzVAfLBq2ki58sAwDCLQO21eMdpGzSKfZIt8ts08AXphEXZMDm5TRNn+RJMBwUxrKHjm8JobA/wQjI6vw3C7P7UmT6QPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IEq2o/WkoMmH5Le+4gyRllLvmsfhmEirgPmbv9G9O8=;
 b=L9pHyYjX7a/K35sClpWkVccPsQv23GZe2YenyI3Htyb/c1G2E06j48vE81RJqRO+Oe029FyLrRfmoWIHviEI/UJ3CbVkoi6PygbhO6PbkLl7F8uYINgF3cJx+ylZz1mre0+8mJz0xTIKm00tAKH2ovlZE8UoLuvKVwbRKv0eK6KG73EQua+hIRZ/UvfuS8ZZ3o+E9aTbT803G/1pJLr72V4ST4sh/PJso4v7sQym1l6Ip5zWl5tuBRXmVMvOitB81c5SS1UrenkEkESnL4yy7F9V8BkTztAm5JDMygfWS3dNHDwV5FuBRuUQZAY+7PFenAPw5j27yoh44Qy/FiujWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IEq2o/WkoMmH5Le+4gyRllLvmsfhmEirgPmbv9G9O8=;
 b=XPbp8B4MJ+4WpimhEo41MotRK+5P1uoz0tPvLTVvKpE6cWYTc2/WrEzKSHGzfvJeLxtoKznctmT3hWi7bL/5CnvHsribIIoOXaRqL67T3+TAMflUpzWZIdLt0UW3V6O6FSAnDqFcovzDR0TJ988EaLov1N0djbD7Hrz6iBrw87M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 13:55:09 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973%9]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 13:55:09 +0000
Message-ID: <9888d756-4bb1-a48f-3301-5dbd00bf6530@amd.com>
Date:   Mon, 22 Aug 2022 08:55:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 08/10] x86/resctrl: Add the sysfs interface to read the
 event configuration
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, fenghua.yu@intel.com,
        reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     eranian@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117586269.6695.16560984025494646306.stgit@bmoger-ubuntu>
 <d75aa75d-92e5-f946-8b41-fd63a6169eb5@gmail.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <d75aa75d-92e5-f946-8b41-fd63a6169eb5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAP220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::8) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21917d68-e38f-4f2c-0d16-08da8445ed03
X-MS-TrafficTypeDiagnostic: MW5PR12MB5598:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FXka55ZkbCl5JLOxpZMRwLVS0QXKq6AFfSJEFnjh4qb1CSA8gFQbn+cFU4R2vD4TBiINyaIJkHe3QegaCdWq0iKD0Nkkp7nbgJuXqBo8mKLsTKL53k6W19eDcjZGR5qUXBVJRMjfr8LD9oCljR4wYUlg28261NF3FtL3kFuAZVWloSiRNripuhIwFpVaOrqHeP+I7qkG+0Lnd3LrLXyF6N3NEeffu23yrSfvrmL8nHEOEcRgWMZd8gJo/KCqwA/YLRi0iA9n+pMbHqXcFTU5j19QjKpOyWKR6FonO40R3uVVFtx1ni+l+FAj1aJjjzRqU+S4WvhTc2hsw23Ozv02SWh9mFZ3wmirgz2NdAR+b41GCpcYTSXgX/YRZudwMLWHVrvHV3EYe3ZpBXls3HjpsAp+3EPnvlivqrsLyHinlDbWf4X3OSDkAq2zcmmKSowSTvbC+DCJqtgMwnZ2CeW/G70IcdwE4NFECNJ3l7mZsHVhKUUPzKBRkLOQLKxxjb69i0hWpIg10DK1HO9a0h2SGDJb930RtAL1i6vX8Vr3y3llBaqhhLf3hF6S6sV8V7ERsEuQY5gQWK97HusUEO6dh9rWyhTL0QK9/+OwteDvhco0hUx9t5kv5dJR2FvE0DsAvECj94xa7kbIMC9l5fXHNtEER5Hl0duKD+sZpk3ydP4XCJXV0lwE8o2CJ+zfFwm7A/V28F7WS3IXWBWrlXb7Iz36iD3oPb9PMVj9m/UAqAihUMdQ8a+CwQewH6LVbuK3Nd7igjcTviMceazX2PrS4Lh2rpFnp6RN3dDAnsbCn9g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(4744005)(66556008)(38100700002)(66476007)(8676002)(66946007)(4326008)(31686004)(31696002)(86362001)(36756003)(186003)(6512007)(26005)(83380400001)(6666004)(41300700001)(6486002)(478600001)(7416002)(316002)(2906002)(2616005)(53546011)(3450700001)(6506007)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTlDdFdhTE1WMzB4YWlPNTRtek9nNUxCRXhTSTZKWHZGYW4zSFZmc01SUTUw?=
 =?utf-8?B?OEQ1YjRmSTBKcWF5YzYvR2Z1U215UHNPNXEyQ2hvTWYwdGdwbXg3MkRFVTZZ?=
 =?utf-8?B?ZlNIK2J4QjJJbmxyMzBDVk5TaVJwS25ORFBZRUN2Si9CcmdGd3ZzblpUayt1?=
 =?utf-8?B?Y3c3TDFxM2I3MmRDU0lVWSsyRmFRdkViak5jZmZaZjRGYUNPVW1mOG5icHNy?=
 =?utf-8?B?RUIrYjhZVnl3MEI2Rko5c2xBaHJzL0xsWE1uN2lkYTlzY3Nia2JqRHZFWEtp?=
 =?utf-8?B?SStIdTRRZytXK1lmUTRvUFhvVFM2SWZQbS9FVDU5eG0wdmJxaDNiWXQxWTlE?=
 =?utf-8?B?bVBsTjRRZ3NlN0sxUzQ1ZEJaeFBLUTFzWDhVYmowMDNkUVJ6SFZpWGdNdFQv?=
 =?utf-8?B?TGxwWVVMMnJqL2hBR291WW95Ky9wR2YyZHhEYldsTk1lWXBScnJSbUNub2dT?=
 =?utf-8?B?WGV0MHFvV1FENnRYWkZoTm5Uc3M4TURTUWZnbzhYLy8wMGpZUDc0c0VITUk1?=
 =?utf-8?B?SGpDTlRBZDlSTTZ3NndzcmFvUHUreldkbUhENTM1TmIydUdqMGtNaW5HOG0w?=
 =?utf-8?B?UCtDeXYzaTVrY3RLVTZhOG5XYzZIb0dURFliOFJIY0JmdW4wYlRwNFhwcGtl?=
 =?utf-8?B?UHoxOGxnRnEwZjc1ZURyMmJMUjRJWkVCMUM3aHFEc2NFNVhiY0l6YXprdUlW?=
 =?utf-8?B?eE84ei9wNWdCdXNqMUZyRTdKOVc4dmxCS1E4eUFpUVd0aFVNTk9aeVI3cVBF?=
 =?utf-8?B?M3Zia3Q2VThKb0V0bW1LcHdhRWtPTzY1ZWMybmd3VWxzNWVjVVpIUHRtZ1Qy?=
 =?utf-8?B?ZUxnUkVkd0dGSXZoNFpqeU1IM2pMemNnWGlIVFJaYWx2ay9zVjRxaVlMWXha?=
 =?utf-8?B?MzFkN1FvQzNpajdkTEJITnhEdUhnK2NrVlhtZE9BL3JuelpBRnc4elBRdmFN?=
 =?utf-8?B?c2U4K0xLSUVCWEJFTDdvazlFemd4cEgra1dWdHJkanpOV0RJRE05Ynp3dDcw?=
 =?utf-8?B?Vmp0ZE52R1Q1U2hWTlg0WUp6MkswWjRKeXcyTVhXbWM2Wi9XTlliaHBEdGVI?=
 =?utf-8?B?RHZDbUgyckEzVEVnUEQ2TjZyc0VMWnJnSEliWTFycDNpUS9pcTJGb1EzVUky?=
 =?utf-8?B?VWNBM2J4R3BZMlV5REVOT1ZVblp2TzIwS3FCZk4rc09RRUJpSW1oa1ZyV2Qw?=
 =?utf-8?B?U0d0bER3MEtDZjIyS0VmMVNKNlRabFRPTWFhZFY1MzN5VUx2bkpNZkNXeTRw?=
 =?utf-8?B?OVg4c2FPNWVJZm11SGwyclRWdmVNTS9ZaEU2WlRlQ1M1L1FqWXB2UWRXaEdo?=
 =?utf-8?B?ZWFFaENlL3ROdEZXQ2NHc0tNSkdZMHplQWZHdzNmUm91YUR1VGtmd3NuQSs3?=
 =?utf-8?B?MDNtSklraFUwN2l3cVc0SlJpQmQ3ckpWT1RmeWRLK2VmWjlMNDM1dGF4dldX?=
 =?utf-8?B?c3ZiUk51cnJLYkgwWkd3cWVpSXFwckx3RkFoVjFNQmd2bCtaandxMU5BMkhk?=
 =?utf-8?B?WENoQzZtOVZJTnh3N0tsTDZZZ05mR0Y0SHVyM210QU11WEJwazdGWlpvQms2?=
 =?utf-8?B?MnlyUWJDcDBXSXhVeE1zWjMvRFBZZkNSM1E3Sk5HbW1BT2dWU0ZKek1PSDIv?=
 =?utf-8?B?QXozUUtVYnNFVXhZZUdkK1hiSlJDWjBVRS9XTlJpSmQ3NXd5bFpvVjh1ZmNQ?=
 =?utf-8?B?UDg5bDJkUFJiZzhsQy8vRklDZFBGK2xscEpaK0t2TFN4dXVFcysySFFBMnRs?=
 =?utf-8?B?Z3lpWHNMWXBndFRXMzUrWExkb09DZ2JaZnc1YmpvYVJ4NU00ZWpVRjRvMk03?=
 =?utf-8?B?T0M1aXFlb2I5ei9xOFBCN01vRXZZNmY3bWVHR2xyWFA2bmNXNkVLM2lSWnZ1?=
 =?utf-8?B?cmlLY1RSS2ljYVdrc1c0V3BiNDY3MkdBYlVTSVVFMjNnQ0xHUmdJV2FaM2lv?=
 =?utf-8?B?UUV4MjJsSGpYcE1KZUFCT25kL3dLSE1VOE13K2tHN2UwK3NIeE92c3JsS3Fw?=
 =?utf-8?B?cFJ2Mm1rYkhKOUc0djMycnVHbnNnV3Z6WndMSHJwUno2MlcrZmJxZ2l6MFBG?=
 =?utf-8?B?WnZCMlo2SnhUOWdlaVNHWldEcUZmQXhCejMzWmhpNjhPM3JoUjcrVHZMNGNw?=
 =?utf-8?Q?0nLo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21917d68-e38f-4f2c-0d16-08da8445ed03
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:55:09.2074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DywjcNP9ypXu77cNdiGW1Rngg9ESTPZ6wcBZbdy0cO0/VEaFs+oXgTtQWZ3P4bEO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/22/22 08:47, Bagas Sanjaya wrote:
> On 8/22/22 20:44, Babu Moger wrote:
>> The current event configuration can be viewed by the user by reading
>> the sysfs configuration file.
>>
>> Following are the types of events supported.
>> ====================================================================
>> Bits    Description
>> 6       Dirty Victims from the QOS domain to all types of memory
>> 5       Reads to slow memory in the non-local NUMA domain
>> 4       Reads to slow memory in the local NUMA domain
>> 3       Non-temporal writes to non-local NUMA domain
>> 2       Non-temporal writes to local NUMA domain
>> 1       Reads to memory in the non-local NUMA domain
>> 0       Reads to memory in the local NUMA domain
>>
> If the table above was in Documentation/, Sphinx would flag it as
> malformed table. Regardless (because it is in the patch description),
> I'd like to see it properly formatted.

Actually, I ran "make htmldocs" and didn't see any warnings. I will try to
fix this though. 


>
> Thanks.
>
-- 
Thanks
Babu Moger

