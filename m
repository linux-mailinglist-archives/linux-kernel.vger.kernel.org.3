Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD5E4B2F23
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353626AbiBKVOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:14:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353587AbiBKVOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:14:02 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B60C49
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 13:14:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzZSGxamPp/r8NWxCfQMawyLOU9GCxrEJpUIXcsv7OsgaEOQDZyUIeJk9A8zxqxPaQKLnTveaL6az4upOVkN646Dl4l1h6ixMVfiqpU8/SuChNGJx43ic3HTpG5i/H40uZdHsibzlpG0gFNrxqi1nsvPJKyJAtTAvemXqKbZhSW+y6nA5krwW+/iMzyP/fGcYy8Xe0fjwOjMqMUzvfhXMSaMfk0B/d2+xpXT+CNsQdDJqg4EcVkVMyJuPxV43zg7eauRj/3y4FN3qm2ikOqD13uYcKAxsCPfh60jruKNJNFntV8NJH7pbLui4Om+rJr4IUKKCosyxfyzUm6Nn+MVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xac7Hbg1RmPnjtIyWqwXg/4osQn2TJoo/2NFKmddjiM=;
 b=ggHdOlDSVWdF/wCJbf3NLa7OTY2lImeOhs4TEqsc1GKRQLFltR8htEtIJ45Wc9r8QWNpLDYKs1s8i4LyV/GU+zQyknw3M63OIbut9i4hnaM84P6vfT+6k8tYCywaoX0B7SG5efvRWOfiyE/s94lkj2UQ3BaPvh3zfJXLJrzHxsJQ8jqPPxUg5Ziqk66xkB6i7TNFp5Ah8a3uqHgMJw4PNCpCBy0mmWhq+DBR56b7C9xCwz3GD07Sx66ZTTe1i9jWzIXdfKLkga4VBAOb9vA0KVR35Clq3rszNoPYjVV8Kqb41YWYzLQ2QR8MJFKdNs3fYQCHICBcXS4Y8uH9uI2kPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xac7Hbg1RmPnjtIyWqwXg/4osQn2TJoo/2NFKmddjiM=;
 b=xHWt+T6JJVbs/YkCaVWGbjLqmATC7aFoNDoSWAOxEJrPiH/4Uf5sWGRPoFbULvbEeKEXq5fl4oiMtfu9MnnYIgR35JcVlJAo0s5YCmwJ2TjjcNQ9kB8EaOyJFAlAQ1icGKgJXEDZ+l3vttRtEwA76pqpzZ2UcU9MZxK772RKAQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MWHPR12MB1280.namprd12.prod.outlook.com (2603:10b6:300:12::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Fri, 11 Feb
 2022 21:13:58 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b%7]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 21:13:58 +0000
Message-ID: <0c3b0565-e80a-2f92-46b4-52f1d70c6f87@amd.com>
Date:   Fri, 11 Feb 2022 15:13:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/4] Only export SME/SEV/SEV_ES features when activated
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, hughsient@gmail.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>
References: <20220211210255.9820-1-mario.limonciello@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220211210255.9820-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0185.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::10) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcc5627e-d4e1-4a59-4af9-08d9eda36b48
X-MS-TrafficTypeDiagnostic: MWHPR12MB1280:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB12801CAA7B909019F675D313EC309@MWHPR12MB1280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fDQlWqmnIVsPIPlLgn8ESICg2X8woLDAOyfHLDZG0tBUcHmTxLDAP7KNOCZLXk/OPMFu2xCGkilyaueyQBjTKfjp2FN5Op5vI4/fV55xmwFacVJBXFjHtyaLlDVnsQHjazkMzHjhmOVgjJ6q7p7ZwfeQmheStlu1614yTJBpaJZl2b6FdCKLK5ixF1MLhX1jUh2ha3mZVeEcUXleTcfPAVUJTLn5K27TYplJNxFNwJuwPq6x9J/nEbMaoiFX20LKVlqmG2pcoq8D98MqSH3jkcYApeXd4IV3V0wyAguXbuSVyZciirwFqCC4vRdRknxhTxkWdRSE/PYgz5LUoOzQQcVRXgsl4crL2W5j8kak5NCghjveDMibj8Y/2/KPz1eEkwb3Z58dGZn14pPXZ0LbdLrmQv9jABGGeSsMvrZqn9IMP5mveHualnsa1Cvbm+NMRI4AVgG5Rd/nI7/AI6JphyIA/6REYloq0Ota+cd446/K6V+7CQHkTFQkD6W3z7d6amqnXEC4nu3cMvGUSiKVdGaRyvBp4t/uVpS3XGdP2MEqCfwRku5HeuDnBwrBgexthBtDhoAEPHfqIevanA3F1twXj2VJTKeLVCMQ5rrGRNXi841sF6agCysYIoZ3ctuk58dTHLpPJ0pwdfcSVlSTG3I6lCssNys7YttC+kcHsIbgdg+pw+RHTkEBTi+YQMbMcta0ZaK6lCaQCuCCDpFI7cOYApWKl7qOUH2JTrB4X13w7HjlUXwgsn5XIYi0rKPJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(2616005)(86362001)(6486002)(110136005)(316002)(31686004)(54906003)(36756003)(31696002)(8676002)(6512007)(66556008)(66476007)(66946007)(6506007)(2906002)(83380400001)(8936002)(38100700002)(508600001)(186003)(4326008)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUdjeXB0VWVYL3EvSzVkOTlYd0ZqdWV4WElaS21uUEl6NkJWakRhSUVOaFVS?=
 =?utf-8?B?T3VrZ2tNRGViOU9YSFFyTGNRWE1kamp2RE5GV1NTWXZmNXAyUmZzUjArOHpF?=
 =?utf-8?B?Q0NBcVFXV2FnSml1Vi9FakhyWG9lMnRpMHV2Ui9tTWo2dFVwbm5ETlcyRDZ2?=
 =?utf-8?B?am1SUUFES0d2ZTg3TnJhMy9SWW9JZm42UDc4eGlRRGx0clhRR0p4OU4vLyta?=
 =?utf-8?B?R0VreEZPQmZQRldlQW02K2lxN3RQRkxQY0lSNEFQMHhRVWh5VWtDQy9VTEtI?=
 =?utf-8?B?M1Q0NnVsc2tBb3ozTlZ4OWNSZ01iZjhML2xhN2JvVFRSRjBqY3R2WEZjempU?=
 =?utf-8?B?eUJiM1VrdWZEQ2xhcVhzQXVob1RNcWM0V3hKcVdvcDNKa0hiQzBUeDlpSmF4?=
 =?utf-8?B?YjZ6ekpMSVdrdDJ2S1laRHJERlNyTnAwclZqck9uL2xGTlVwZDZTZTNQUDgv?=
 =?utf-8?B?ekZDTHNlSWhaMEVSMytQbmM1ZG83bTBGdTRETFBFQjdiUS85c29nTmk3aDlH?=
 =?utf-8?B?Vy9xUmZoMVZhQlNIMGhwYzQ5Vk1Ubk8wNEFRdk5xUlNyN0ZFOG13NW9mY09Q?=
 =?utf-8?B?eGR6VFJmbkYxRHQ1U2tTRFZFRnlZcCs3eFlkcEZZVDUyTFZ2bDNhcU1VM3dw?=
 =?utf-8?B?Y0NFZ1RrYXNFaHhlLytubUU5Z2txRHhGclUyazBNVjd6clRqR1kySkVCVmx3?=
 =?utf-8?B?bmdYaUNuMWxtT002V0FlWDlqcXkyVlRFaWc4cTMrU2VVSHZZYncxRUJQTS83?=
 =?utf-8?B?MzVSZk9SN01PVGVxS21UM09COVNTRjZwNWRDTTRoRTBYb3FMOG5PejY4a1B0?=
 =?utf-8?B?K0hBOEUxWWJtNjU1Y2pRbHhEWmY2WHpiUDVEa2xHbUF6eE9qeUpHZGZPTWht?=
 =?utf-8?B?WGRWMk1RMTdPK1dHT1Z6cUpaUWVPZy9XbXBhaldyRUo2VWQ5c2Rkei9WZTY0?=
 =?utf-8?B?VmFZTWVzZ1FsQk1leUljYURkK1ZnVHNaVXFKdVVTQVZJdFZYbkxPK2lPR1Rl?=
 =?utf-8?B?YzhNZHErRWxwaVFraUluZmliSjNGeUNjaTZUdlZ0cGtaN3Z3OTN4WDJhTk5x?=
 =?utf-8?B?N2gzbUZxVWZqaGJxd3l5Mm56OS9JcVZjQ0ZBejdsUEJ1K2w3MEFTbTdHSkJo?=
 =?utf-8?B?QzFuSFFQOERxbFFwOGtsTTE2VldGdE1KUkNzQXFnWWw1WXJNUDBjRWdGcTFr?=
 =?utf-8?B?cW50cjdTT0lBSUppd3UwQ0ZPNE9BdEpzcU9qWmRibDg1TkJQSmJDQ0N5K2c0?=
 =?utf-8?B?OFBsanN0LyswUVdiRW9QS3RvbGoyc21Na3FlZVYxQUlrZDVTNFdGVVVDcTRQ?=
 =?utf-8?B?dHRzaVVMSWdOdElMQSs1b2ZrVUx0cWNDYTR4bXVnWlZZeDQrR1ZWekdRRGt1?=
 =?utf-8?B?WldMVHZyWVdzYmN6ekNzSzdCWUtzcVdyZ1FEaWV6YU44dllhdENGSk85Q0JS?=
 =?utf-8?B?czhZa0N6eEppd1dQVnlnK0Zyek8vVXlXbUtDaHJ6dTNOckF6L294SlJGT085?=
 =?utf-8?B?cnN0OVZzWWZNSUVOajNqampGSkZJUzZicWJ5UUlnTTQxS0w3bTdGRE01OGVw?=
 =?utf-8?B?TU1USnBJT2FZdWtBSkZsT0RGcnJLYllTMHEwZ2haY1FIY3hPY25CN0Mza0Qx?=
 =?utf-8?B?QWJnTVJrSGh1dmIrdnM2R1lyV3VsMDI3a1hRTWRLWTNKbTZ5cUJVeS9qQ1dW?=
 =?utf-8?B?TDJjdC9XN2lRUUxhU1RrZnhQeXNVaVczU1EvWS9WajEvckJ3Tzl5VHhKTmw3?=
 =?utf-8?B?RWovd1hyNVBMaDd4OEU2NWFUV0hYWHZRbStFRUR1TXcraXh5R014elQ2RFBk?=
 =?utf-8?B?ZlJKbCtvcWk3TjhDZzEwTHUyT0VhQno0QlF3cGM4Nm5yWTNiRmJpUXdhNHZN?=
 =?utf-8?B?c1d6Qk9Rb2hJQUs1c0pTQVJTbmZxVFhkdUJOU0hsbUswZXNzc0RFUFhvUXN4?=
 =?utf-8?B?eFVBVlVRQXpOOXJCV214ZGtoUUtTS29YTUxXaWdnNFRvQjArYWRiQ2JqaTRX?=
 =?utf-8?B?UzRhZ25zK09JRVVvY2t2RWVqb24wWGhTK21hRWR4eW5pKzI0TW01UXVmcitq?=
 =?utf-8?B?aGpVL3A2N0d6anJUelE4Mk9ObUhUWGh2V0hHSXR6cVdyMllaalZEK3VDaWFp?=
 =?utf-8?B?WkM4c0w3ODJrNjJtekVUTERzNXJsa2dxdXJmZE1TcnlXejAxUWNiL1V5aS9H?=
 =?utf-8?Q?zpijjHGnUfyBpfvDqu8ii0M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc5627e-d4e1-4a59-4af9-08d9eda36b48
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:13:58.8893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9hjYTwBAaFt8fwim8DszjCwgGla8rBBtaABRvMN2LRhe/N+mLZdoOMxy6aPsYqQkKhu050otytRBLWU5rKHiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1280
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 15:02, Mario Limonciello wrote:
> Currently SME/SEV/SEV_ES feature flags will export if the CPU supports
> them but even if the kernel has not enabled the features for any reason.
> 
> To let userspace react to these feature flags, only set them when the
> kernel has activated them.
> 

You really need to wait for more feedback before issuing a new version so 
quickly. Especially since you asked a question about doing this just for 
SME to which I agreed.

Also, you've used cc_platform_has() incorrectly in patches 1 and 2, so SEV 
support is broke in the hypervisor with these changes.

Please just fix the SME concern that you have.

Thanks,
Tom

> changes from v1->v2:
>   * Squash old patches 1/2 together
>   * Add new patches to KVM/CCP code to use `cc_platform_has` instead
>   * Don't use `cc_platform_has` in the early code, just check `sme_me_mask`
>     and `sev_status` directly.
>   * Split out SME and SEV/SEV_ES clearing as separate patches in case
>     SEV/SEV_ES need other more involved work that what is in this series so
>     far.
> 
> Mario Limonciello (4):
>    crypto: ccp: Use cc_platform_has to determine SEV presence
>    KVM: SVM: Use cc_platform_has instead of CPU feature flags
>    x86/cpu: clear SME features when not in use
>    x86/cpu: clear SEV/SEV_ES features when not in use
> 
>   arch/x86/kernel/cpu/amd.c    | 10 ++++++++++
>   arch/x86/kernel/process.c    |  5 ++++-
>   arch/x86/kvm/svm/sev.c       |  4 ++--
>   drivers/crypto/ccp/sev-dev.c |  2 +-
>   4 files changed, 17 insertions(+), 4 deletions(-)
> 
