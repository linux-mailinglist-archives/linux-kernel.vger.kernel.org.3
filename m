Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF76505D99
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347193AbiDRRm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347190AbiDRRmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:42:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9C23337E;
        Mon, 18 Apr 2022 10:40:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCK5ox7/M9jzxpvlr/dPmE+L0xM4syGuZ0wRfFoZlYrYCb9rwbLUfyHAEeVJ6m0ZctuwZtY7RxP0WLM6TjppiMBC0WtaN2inFRbrsOs1fc2JbWcZBMgVUuloCa9kn0PnRWMrwUwd4Xa/4NG52qde0Y3j1kYXq0qS6NJxxX7epplY3c3NSACqgKlAQtl8TJBlby44I+snFaKwjO8VgkJuaMZGnlJ58WlP28sFvUDhdmLbKaom9vnjg35PCJPzW5iLKEMBLQaZTzQaPWiyDdWV20w2KoI5dg+ZK9aLxa6k8snEXEXLILVtRw0i/fLgiYMkfHSMEumZMpyLzH1bRoqRAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9Wh/gKa+bzlbToIk/7JiOOOMfqGBaYhIcJ27qCIDoU=;
 b=BC82ORjpL9TwFlHNNctf8FX5YYYcX8Je1V70o3RnOBYe7aFpjoIdUpqzm/iEFCbVvQYiRaBoqV/MbOVV8D9o04p5zNIwdASEfliE5lmCy8Qm/pdHmW6dLiYEve8hm2NHeFt6RkWAbZl+RKJJuqHhTZqSHW6R4cNFWzRZ8xERMW0OpwUBPCaQaelk5L8Cl+JB9E7UeyAFp+UkUZdwNShR5zHIuEuPgwg7yQ0ub0Uj0bvMGO4dAHpfU40WAqFTAHESrSrRrVxh7HUsyJG3+W/qVuh4ogij2hiWfO1jVf/G6I2/0fpQXUmNxxWIc+2ws8DMJOXVZVGFibTPVPmWA4ynrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9Wh/gKa+bzlbToIk/7JiOOOMfqGBaYhIcJ27qCIDoU=;
 b=KylbbuBU7v8ZOfjTa6v0FbU7uOsAw/uq20Yftx0S6PT+9kSUfa9tGgClXcBQVKFA5PwzEZ07Y17W0GYxw9D68kLfswvLwGxs5H4T6Y3YkOLyDkUj5z/hYvVzhjQSpBoll90YxeAETJOuCgJ8YFsQTiShZjHMsckaXAsc1JCOJJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 17:40:13 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::781d:15d6:8f63:a4e7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::781d:15d6:8f63:a4e7%5]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 17:40:13 +0000
Message-ID: <18e9197a-9e8d-a06f-3a55-bb548e649258@amd.com>
Date:   Mon, 18 Apr 2022 12:40:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [tip: x86/sev] virt: Add SEV-SNP guest driver
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org
References: <20220307213356.2797205-44-brijesh.singh@amd.com>
 <164940891958.389.8256762641375131456.tip-bot2@tip-bot2>
 <CAAH4kHZpwbJSE6tDz-3ZzMH75rmgDYvBQ5_gLteXRmEk54yORQ@mail.gmail.com>
 <Yl2cffonOopK6JrM@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <Yl2cffonOopK6JrM@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0021.namprd14.prod.outlook.com
 (2603:10b6:610:60::31) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 990141e9-e9ee-4579-ff01-08da21627df5
X-MS-TrafficTypeDiagnostic: DM8PR12MB5429:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB5429C65C0BD5B4B9CC2F24B2ECF39@DM8PR12MB5429.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dqO/jmtFv00QEiBjYO+rJ6hku+nMFlka7B8wQGwjdsONG4s9LYHpcOTMYbal6s+HBmWrB9JG+E1snLk/YImUfGmhYghSy2HB1o7FiSKYULqVy00SVfpxg+u3A+Du6ZeZVdxIIZqq0R5eILy0opNEkMaKuWHP14qEZ4/IU6MiWGPY9k5+CovNYQkW4+eXtHNY+s2ATi/s8IK6rHw6Sk77C5CS4ub+4G0h80IPjv41VzSJzB9B+6ykCxPx9opDrSIgBR2Wn+CGV+cdhNeZwSHSEuO7Q+FkLhC/QhsW1kX2slS3aADtMn474iiJDo0D5ez6f/j2CcHVCbhYR11YesjRx5dWK5qAYjrXVB7j5hvjhDd6oZjPm5jkT4qNTMg77OSErV1oQhF85vqB/kfhWaTqJ541Xj/ZkW7K5ESkmGlNxiCh79vM97dhIpHUakCCRe/jcE8+1NNx8sOq2vDjOjPBTNJLl1MAcGwoV9Wt5mDoXERk6J/gdU22ylg67fcfX3TqyWewk5Oq4z82WGnupveH4ZEtpSQ9RhMIdm//8670MO2oQg2bbozplt2NgybORV65BBMFXmpIn8wizpjIa0zwZ4FzDoT9o9hy0+H+tyJW4k83JpTwV5NVG22Ab1cjUd8kBrzVdlNpssz7pWNWfw6mfIn9hGvJAGeEo4auh3XqdBR5cucngKuprvibo5pix/cQGBrPyAklVYDGXueY3hkSuP3DwfLvTCTWt39TsV6DoPDKXx7/orOESkT3af/BYdQpCPnp0TKQjvZaNP4aApzI5gt6IPEjFOTx0SeVn2zRIlF7s0VCQGIjGt7DYLBNacio
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66556008)(66476007)(36756003)(66946007)(53546011)(8936002)(508600001)(5660300002)(45080400002)(31696002)(2616005)(186003)(6486002)(966005)(2906002)(86362001)(8676002)(110136005)(316002)(31686004)(6512007)(38100700002)(26005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0F6OE1pZnA3czZ1dy9BSE8vakFCZ2dWQWVNWnlCVmE5eU1OVHFobzA3NGZ0?=
 =?utf-8?B?VjhEM1pmcmpBMDM1SEZ6MkJjdSttZm81NkpNME5LNDFUdHNJckxieFF2SVpl?=
 =?utf-8?B?RXlvcUc0eFRMbEFpUDJTcWFhYytFWXJzL2tLTVUzVlZSUEhOb2R1bk5nSk82?=
 =?utf-8?B?bWQxTFVoU3BPaGpBNzRTVnZIMTNOWm5KYXQvZE5STDl1MUhjaWEwRWpnUzBl?=
 =?utf-8?B?dHdaYVJvQjhOdElHb3ovYVB5RzR1Qi9QNi9TTnRqWm9Qc3htamdqdTlVREJu?=
 =?utf-8?B?WHM2RHRWdEwwZDhqZzR4amVPeFVOa25ZdzRJckdQT2h4RWZ5TWJRaEtyajVa?=
 =?utf-8?B?Tk1tNC9Nb1FFQnFIbzNMeFc2dVo1UEx0L1JXSkF5cm1veTF6U2lBRFhVc1Vj?=
 =?utf-8?B?TXhJM2o0S0hOSVFndElqeEs1YnVoL3VHL1lsUDUxcWZVVnpKdE5PeUdNY3Va?=
 =?utf-8?B?U2tqb3gzaVFIaVlGVm1PcmpBd3FIZWNOL1l6MlFYVUxqZ1U2eXhOaW9yZXVF?=
 =?utf-8?B?OGo0cEtxQ2dNUmNsTjg1ZDQzcnQvRzkvWGEwWE5LZ1BwU05aUkFQVDlUYmta?=
 =?utf-8?B?cjd2Y1FETEtKZDBVVzlpeURxTk9zZnZhckFLa1BTcG83aDlOYXVWUXhwUmFQ?=
 =?utf-8?B?VVdBM1pkcmJrRmtZSGxtdndyS3d6bnZUNHN4YlE3RkxjTkpsOG9TaFBudGxQ?=
 =?utf-8?B?NExnaitCOXJBNmY3MHBZVFBRaWtjckl0YkI0OW1LRy9iSkVBcnQ0NFAzR3JH?=
 =?utf-8?B?RjdxSHhuR1lNMENNdFlhSDI5TWxQc3ViMk1MSUhSKzJNVG9Oa0ZVOWd0bmc0?=
 =?utf-8?B?UGphVU90cUFlOWRVRk9sRmozOGpCMXdVb3MzMUtIV2VDenIyM0hoRFZxRklh?=
 =?utf-8?B?K3QrM0N2a3JyaG9CeW9QQjBGMHRSRHhSRi91RG5Tcy83ZW5YVFArZ2FwUGlG?=
 =?utf-8?B?bEUwemQvay9sS2FzbXNsMTRDcEFaVUp6MXJhczE3NG9MQUlYUnl3cUJOM2VK?=
 =?utf-8?B?M3ZYY3YwU2tQOHo1aTVHY1NRbVBKMHl5dzBaazdKVmhSSmlIVmRkKzJPeFFY?=
 =?utf-8?B?U2JwT2tEdURJY1NnUUV5TkU3KzRTK3dZb1J0Q3p0aHFkRldOanczZmw3ZjNG?=
 =?utf-8?B?U3ZHazU0QjVnRStZZEtwNnZINU5WdFphS0ZNVnNKR2NMK2haQmhCZk5TQk5X?=
 =?utf-8?B?NmNaZ3IySHhGYWNjTEpjWFdpazhQVmJ2bFVjZXFlYUxERys4amUvRGhXRUw3?=
 =?utf-8?B?UWUrQytybk9Wc2RUd0xFRnZPdzl5cWcxbzcwUVowZHU5amhGWHFEYjRBSUhm?=
 =?utf-8?B?bmhESklpTDl4RzdPTlRlbFFnby9VOHlUK0F3ZDNRSnhRcXR6T2N4NStPVTJR?=
 =?utf-8?B?dCtTcGZKZ3BHcEJGMldRWHlKUFBDLzFtRCtHeUpBYUpyQk1lQkFkeG80Y1Bi?=
 =?utf-8?B?blR1WXBCOFdpQzE2bkFvNGRtVzd4ZjA1MzkzNkZPMFBuY21qejdzb2pNTTV0?=
 =?utf-8?B?ZDltZGVBaXZrNUhLOFVoUzg5K3p5ZW5qME95ZS9HMEVUa0RRdGJ6cFBBM0sz?=
 =?utf-8?B?T1JzZGFZc0hxQ0I5ZUpWNGZzci9CQjFLUEVkQ2EzWXNiakZ5L2dwNENFN2li?=
 =?utf-8?B?aDBleXFIRkIzQzJ4TXdwS1dGWkVxZXNjY3ZJUXdYS1QzZms0eWVIakNzckMv?=
 =?utf-8?B?VEZOcUZ6M0VOMGpnc2dmelh1MmxNbXlTQzZ2VGh5TXhxTCs0Qno1cnpoZUVq?=
 =?utf-8?B?bWtOK0lic296TndpR0lJdndhdkxqc2lGZEp4VlVoQks3OUpMVEJRODlWRmZG?=
 =?utf-8?B?aG9lV0VpVm8rRDNYV0VpQ1V1a29kaVdEMWVtR1MvUW5PK1FDeDQ0ZEJuRlZ4?=
 =?utf-8?B?RFhueEFEOElwN01pcjhNOXdMU1JFNmlFb3lMalhCMDdIaS9nTnQ2S2NpcFFJ?=
 =?utf-8?B?QmpSaDJKdUhZbzRRekRsSWpFSTZ1UWdYdEJTTmhSTHhDOSt3a1JiaHFvb0da?=
 =?utf-8?B?TVZSMzFqS0NmVU91MVBhcXJhVGw5cVhSV1VvNThXVVJsSUVEUmVqdEphUFIw?=
 =?utf-8?B?bTRqdms4M2xJZ1VxU2gweE1tVHN1WEZEdTloa09JaTJYUDRPYXZ4VW1ZaXMx?=
 =?utf-8?B?QitkbTFWbVkyOTkvb21ucjEzdmZRTWQrR3NyNE51M1JDSG1lbE5valYzdEJW?=
 =?utf-8?B?bEtzdStXd3d4YkNYU3MzYzZFRlgzYWx0aWR2VmtzSU9tMEtnaEF3bVUzYjRm?=
 =?utf-8?B?bDVGS2U3V0VVektVSXludkJnSEljUTB5ODcwZEkwK3QvOFA1cVN3WFlHV3NS?=
 =?utf-8?B?YmRHYlB0N3lzZHcvYnZTZmpxcGhydUszdlVuV1pxYzdGVE1kazJXUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990141e9-e9ee-4579-ff01-08da21627df5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 17:40:13.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QI7/T5IEqeV2KQ6P78EYxlV9IiqM5TpaQ6Wuz6XcILwVCRSrCHKtLOM5OfmQSFnEEx+x440IlIAqVU7ejJdAiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/22 12:14, Borislav Petkov wrote:
> On Mon, Apr 18, 2022 at 09:42:31AM -0700, Dionna Amalie Glaze wrote:
>> What is the intended name of this driver? I see the following
>>
>> +static struct platform_driver snp_guest_driver = {
>> +       .remove         = __exit_p(snp_guest_remove),
>> +       .driver         = {
>> +               .name = "snp-guest",
>> +       },
>> +};
>>
>> yet...
>>
>> +#define DEVICE_NAME    "sev-guest"
>>
>> and
>>
>> +       misc->minor = MISC_DYNAMIC_MINOR;
>> +       misc->name = DEVICE_NAME;
>> +       misc->fops = &snp_guest_fops;
> 
> Gah, I have raised this in the past:
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2FYNxzJ2I3ZumTELLb%40zn.tnic&amp;data=04%7C01%7Cthomas.lendacky%40amd.com%7Cb0af127a9aa44b85a23508da215ef064%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637858988899530603%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=p7S%2BjZjFODp%2BSg2z2SKZIKLgyy80roI3UQpCZ2Dc2t0%3D&amp;reserved=0
> 
> but that aspect has veered off into the weeds.
> 
> I *think* this should be called "sev-guest".
> 
> Dov's driver which is mentioned in that thread, ended up being called
> efi_secret so I guess sev-guest.
> 
> Tom?

The driver name is used when registering the driver in
snp_init_platform_device() and isn't really referenced after that. The
module name is sevguest.ko, while the device name ends up being
/dev/sev-guest.

All that really matters is the device name that is exposed to user space.
But if we want things to match, then, yes, we can change the name that is
used in arch/x86/kernel/sev.c and drivers/virt/coco/sevguest/sevguest.c
to "sev-guest" if that works. Do you want the module name to also be
sev-guest.ko?

Thanks,
Tom

> 
