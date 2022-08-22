Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5BB59C0F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbiHVNvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbiHVNvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:51:06 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FAC37196;
        Mon, 22 Aug 2022 06:51:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftf/Qv51FzTn4TnGfnumFsI9DERue6aw3tigrx1luCDpPz9O8AvbJbsRonYd27/kpJ5qROyHc2JdUlUt9ACs1oqeYp4ZxwWMdOuuhkX+6ABLyh3rkIUHEEYg5bLZAf9wB032Tktxn0DyLmtemgpQq8mopZ8WxUVN4HCj/uWyygKo3MEOaKg3BnBpvH1FxPm6NsByXZlSwOxdEkfwB3fkhUAWYyzPhvsuVh+2jM+raQVS2HmK6Ohf6aXTp3ZQgBgK9U14NXAylqfIzWjdJfYp5BjlGvdMz2mk4r1kY30V01VRzXxFz2GO3kq6JCyFN+8TJCLYb1cHCh0wCuXdNjDH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRXk7qPgrJuqygVMlQMrb8XlYDni0NqtKQJbryIRvV4=;
 b=ZRRZGsJpLReA4Wc/nFw49POawimmeShdouh9yepO6hQiAVEufcBvo5WXJ/CsNX7LL1XtVEStOCRSBthRhdmg0glvx5nNUi7G9SvPLoTqV2GpyO0ae2JAFNP9azYWOfqzBGtYigaVbULO3AVC8MAHU7W+YE+sW9Wp0mQElvmZ+bIgXivIFmCABRDnl5Q/d0t+cYdVaVar5/un/PA1hUkGmJsfc3D/dXxLwEiAMULIeeCGIoxR47wcBKftwlipnL9CBbPhXiM5pm1VBi8XhK1kZX/Bv+NMsR4BNkgmlp51jEqV77Uju/aHL3zS9FUNz0TG6n0EsZOPZPEmpVfj3C1cFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRXk7qPgrJuqygVMlQMrb8XlYDni0NqtKQJbryIRvV4=;
 b=ywPG2cUMS1LSOjTON3tRN+yy0vPEgNuafSws1j46/jpaZOPqsA6Rd0Ta48Tvqu846wsKKU5L2FzYk+dgFWa/hEDmgt4Fh2yOkpcctefg1kvFPfVIk+E90DFWeGSF11KNZsjH6DovF8N8XqxM3E/jt9KUn9oogrgG3YtVtWwOkQI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN6PR12MB4767.namprd12.prod.outlook.com (2603:10b6:805:e5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 13:50:57 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973%9]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 13:50:57 +0000
Message-ID: <f78c547f-ce1a-f5c3-ff0b-fad2f9ac53c7@amd.com>
Date:   Mon, 22 Aug 2022 08:50:54 -0500
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
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0056.namprd14.prod.outlook.com
 (2603:10b6:610:56::36) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d113e4e7-3d49-44f0-d25b-08da8445572d
X-MS-TrafficTypeDiagnostic: SN6PR12MB4767:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wv3wRBIZ0hnLdzNCVMtXcbFzQKGdEmZudWggFNXl55dFOozuph9uGh5XbmcjsQFHeL/jLAbHOCgPsa8c9i6X663sfIgXYAVwIvsfEab0e0WCD3I1vi6nbxihqyjZaMoJUAOcIWAhLiDzEmUKljvfLqdAdMbAMWKytoOmerbKRJWJluzfHKA1dA2B7mo/1dSNDCvrZIzmQXSHT+xdxY1OqVqUwkbUfE5FdLv1ZSnDu+30AxLm+iJSExHSkskFrdHmbNwL4USV0bsRKtpGb6VIQGDrQgcDLZ9mhXRPXKGbVXv6k45+F29d+aVzB2z5jWzIq7miTySXyCozgzl2uaWFXp9CwEV9kp2R53Ok0nnxIeX7aB2eo5fwoQSxsShmiSunKzm9p22dq798wH3t5ZjhUltrhHBnOkt+/OxACu4WatnSe8SteBnD/jWt/wIjwamIPhJDqRIrZfYyBp7fIZnvpsRLROQ+dz7Tbc+7XpSZqAt9OD1x9HnbNVq2GUYpXDD3KXy0HE6O1KfQt0HdYXwptzy2mIoF9R3QQdo78M81cM67hRzMjcYG8sVgssH0VieW3H0bb2zZKSOJClCXKkuxsSNWZ09ALQWngeavW0V4X8Dpy4ywvfo/gHjqjxz6wEut2Rz60MxdGCZUBmQzFbw5EuT9uyxZNyvbF3/AeRjAExnxuCb6QHKyogreUETyF7Zz6iGfu34sWTXQSvTFLevc3pbxwd/Ghe99sXzmjB3qjtvXcJ130CdBxe7yZEG0ULoYhaerC2ofwFy2F+o0IhEHx0Sjg9yF7skxBXBlP6LSXUY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(6512007)(2616005)(186003)(4326008)(8676002)(7416002)(4744005)(5660300002)(41300700001)(31686004)(36756003)(478600001)(6486002)(26005)(53546011)(6506007)(6666004)(31696002)(86362001)(316002)(8936002)(2906002)(66476007)(3450700001)(38100700002)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG9YVnIzRnM2TVlGVGIrUnFGUG03aGRLS2phTlFqclUwa0ZzekpXK1Uxdk91?=
 =?utf-8?B?aitTNFRsL0x3NXdtY1VNbVM3Y25jbEJvQ2xvcWUyTFZEQVV6b0Q3L1Q4bTVE?=
 =?utf-8?B?ZHNCYVc3UnNZRjJDa3JHUnZLOTBZVStQUkJHK2N6L3hHOG1UYXRKQU1kSmdk?=
 =?utf-8?B?MXExaW4xSVdNYUgrZVN3Snc0NFUxM0hlRTZzUjVITXpmbUxIOXBTWjVYOUxm?=
 =?utf-8?B?cUt1SngxNjZyMEZsMk5RMGRRdkU3ZFJEVXdWazNTN2xGS1V6SFVlS2NrTDUv?=
 =?utf-8?B?NW1CeCsxdFpUeU5wbmhGTzgrWFU2UGUya240SjlSSXNqTmVNcHFRQzlDMHBl?=
 =?utf-8?B?dWFtRVNZZ25qMy96ZHRubG5tYWo2ZHZzMXRGTWhLUnl4SnNPVVcyeFdyTFUy?=
 =?utf-8?B?ZkFtVm43WXlqSldmM0h5V0hZSVQ3ZmVROFdDMkt0VG1pRjdSVzNkOU94dElz?=
 =?utf-8?B?SnRTOVEvM3Nid1JhNHc2dkQraHJ1WDZRTmVTUDR3TVgvdDM4Qm0xdXRBUzJm?=
 =?utf-8?B?ZktiSUdURXR1dXk1SzM3NGREMGxJRE40MS96cjBGRHhiY1FHWisydEpGYUxR?=
 =?utf-8?B?R0ZXRkduaW9CQ2lzejBpajBua2h1aS9OOTJMRTNqOFhZbHBKWXo4QUFGRzF5?=
 =?utf-8?B?VWhEeUFmWFl1VFQ3S3luWDRtUk9ZdUVWZ3pmSlNoWHBHcEJsNW5acjUwdGFH?=
 =?utf-8?B?RzRiZmRWYWhNQUE4M3FCTjhRTndnSCtyeXdQeWVGS1phUHJyMTBVZTJSeS9u?=
 =?utf-8?B?aDU5MU1QWUhKb3JoZ29YUDhDZ2RzdWdEam5LU3pkN3JvSyszc1FMV2s1RHpM?=
 =?utf-8?B?N29VZUlyQmI0MFNPaTQrOWorSnMxZ3JtTHZmaTBsM3NrT1U2SnlPelk4cXlJ?=
 =?utf-8?B?MU9nbXF2UVk1MVpjaytnaHhOdnlQUFIxUnEyTjROWWlzR0c3SHRudHB2UzF6?=
 =?utf-8?B?UUkrTFpzbFUwYXNxOVU3Z0gvS0liMmc0dXpZZG12YkRRdVFBRXIvNm02MFlW?=
 =?utf-8?B?SlRwQTZHbnViRDlMYmZ4bW80UWhPOE5ES2RaNjNYazhmZU8xelJaR0xHQUh2?=
 =?utf-8?B?RFRXMUYvWnVwaUpVYUNCSHFidzZ4WTZpTi9TMjlLSmREUEg3OHNkd2NjV25v?=
 =?utf-8?B?MVNnalRmalQ1UFRZSzhsRFpqY0pVVllGUERrbkhXN1AyZjBpNjJTRGZ3VE1s?=
 =?utf-8?B?emllUnBJd3NFUWc4cnAyYW4rNG9PUTBJWm4waFc3RWtQSy9ob0tlMHl1VGp1?=
 =?utf-8?B?RENWSnNUanAyWW9saWk5MjhyN3RHaW1FVjdVYUd6bDhIakNMOWxIUWNyUWt2?=
 =?utf-8?B?eU1RYTR1S09FdVN3S1pMVUd0WEhMakFZT2lsampybDdzaTVRR2doTXE4Wmc4?=
 =?utf-8?B?Q2thaUpnNkVGMEpDUTVxTm80RFJzV1ZWTXhqTUNna0VlVWtYb2ljQnczaXVi?=
 =?utf-8?B?UUlReVgzU2JMb3ZYVmYxVUcwUXBXbkFSSkVIRmpTM0wzZlVFWkU3RUxqanc1?=
 =?utf-8?B?bGdXTTdjaVNGdGk1OHNtQzR5Tm5iWmRpa0NYcWs1dWdhNHlJUjhnRk0yaVJj?=
 =?utf-8?B?cmdhWnNOL3VvaC9ybnd3RmFsYndkc3lLd1p5Y2NNek4zTjQ4dVo2ZnNHQnUx?=
 =?utf-8?B?aWQ1SmYzWXZjeWU0OC80enRyUE90cmx5MGVCaVA3QzVnRExYbXV6NmN5WFZz?=
 =?utf-8?B?cVVkWlhqQTlhWHhFcmtPSjY3L2Z2ak1YT0xpd2tmNmFuOFhETWtIc3EwOWo3?=
 =?utf-8?B?ZkdHSDFpWGoveWhES1ZHTjdUTWZ1R1B6azhhQ2xRaGZxVlk2K1dxRHdGV05I?=
 =?utf-8?B?eDlwS3B4RXR2eGpzZ0Vzb2VQbSt6aDJBWWJ6a3o4QWJId0NwQVlzMUdwVHdR?=
 =?utf-8?B?dFNSYUpWSTdrL09aUzJrVEhVQTNBNjJ4a2Vnb25uZC95QVM1a3FLZ1BNdTVQ?=
 =?utf-8?B?QTZhUHpPWE5ReUZFVGd4VTEveEE4MStoU0JuYjMrd1VMVllpRkZPaHBMMSsz?=
 =?utf-8?B?ckhMdURnZmNWWUJrbjh5UHIvQVRzcWN4clJxYjRHblZUUzZSK2RRMTlOTVVm?=
 =?utf-8?B?OWRSODBUZXNWUXNFYjN2QUtlWExzYzJ5djJEd0FMd3RseFJ6TzdlWGRhcXVt?=
 =?utf-8?Q?vuBw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d113e4e7-3d49-44f0-d25b-08da8445572d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:50:57.7983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUcYzdhVoSyr1HX2k2W++NEXJLcMtHOnCrtuAQIILb+R0QDyIYrcKMTHLyjLZ2de
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4767
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
Sure. Will do.
>
> Thanks.
>
-- 
Thanks
Babu Moger

