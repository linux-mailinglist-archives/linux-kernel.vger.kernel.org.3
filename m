Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338C95785DF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbiGROyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbiGROyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:54:22 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F94B101F0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoWNMbO3NcxB8Hdq1cpr+DJM95EEpDW6KGsj/jG4yiqvPLN7cOXLqN87VDapxLUM2qMYCnD3Px1vtkSDkXIYd+0VPN3ENYUrsJmFbtE5sA6NdpLnsz+MhwJYcXYYO7OqT9UyzF+mj0HNweg8DleJ06eUDCfEFy+H7sf6XQUp5Q87hr65b3ecnd9sWWwESeaQOzCU+rsYK1p7ooVt+gpfiM803nZ/ST1xymIFVYAQdjnizwlA0eRgFk/Bwg2BYtHVRMcL4Kkw6t5ZuNN+JQCdx/0AePgROQMhSxMeQLgCAgpUxI12hPVFCsct/q89mAisqVjVJvFVhFwo8O+p0/lDbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1hYaXUGQ0SYTTUIAbQ2+OX7BFBBEjuzPhMqCGKBmuE=;
 b=nqvL1kamlMuDTxzMx/XJ9LpGdcpEETXIu8IFrZJx0cMa5WrcKyngyBke90RdwDLOA0GaftKGIpWCi8SCeDXJDQARM8C4AUESfN5C9TVhTJXcYbKKBKTrww9KqMyXCEi3ZyfvPMSTcaWA8wIcP6TMl8Eq5R5h4Wx35wEZSvggYaOjAYXuv4cKt8yvniKMDXTVawrwpkALjdqyH9tpGWc4BPgpGPsmNfQbmUvq3VpV+cB5A58cIlsPPjHavOHMPrjd5EfU675Lh0pe6evZlohNSAc8g+NEl0jZvC9F6uuEXv3JOcD/1fa92Yz/mbjo/t0mt+qNvE813JCTtWXyoXqxOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1hYaXUGQ0SYTTUIAbQ2+OX7BFBBEjuzPhMqCGKBmuE=;
 b=INBZI7Ony6MY0Qwxc1P//ip0JkYF3rfQCVfAkYNBzg1oanmaUc54V+IPFUqa9ypS4P0+LcEXKb+LM9XvCWE+mKJHBzWRfzfLZ/cRXzGMjo/5yFv9zQEW3sO1mIbicMseBmcsGuVnKvxUeRJWg2sqYXvbG3wZCLSPoISwz+kG5Hw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by SN7PR12MB6959.namprd12.prod.outlook.com (2603:10b6:806:261::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 14:54:19 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::9dfc:d340:841f:a6fb]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::9dfc:d340:841f:a6fb%5]) with mapi id 15.20.5417.023; Mon, 18 Jul 2022
 14:54:19 +0000
Message-ID: <be498c32-bed6-d31a-ae94-6006dd59ea1e@amd.com>
Date:   Mon, 18 Jul 2022 20:24:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC FIX PATCH] x86/e820: Stop kernel boot when RAM resource
 reservation fails
Content-Language: en-US
To:     Boris Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        dave.hansen@linux.intel.com, nikunj@amd.com, hpa@zytor.com,
        Abraham.Shaju@amd.com
References: <20220718085815.1943-1-bharata@amd.com>
 <E7A3FF43-C49F-415E-81C6-CD14F4107349@alien8.de>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <E7A3FF43-C49F-415E-81C6-CD14F4107349@alien8.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::21) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e69d27cf-8ef5-411c-f621-08da68cd644f
X-MS-TrafficTypeDiagnostic: SN7PR12MB6959:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FfBi1a2aMwkwjcP1ShKWN5U2VzIYBRKbLpwm19If1u36aC9GwVrhjAofDuCz54d1yg0MUCStrnA7Fx2Sck+8B5IDTtkG3rxwa6p5EEqVQN4e9ITjOXYp2v5iOk7XyNEKinQvie/DbwJwp7e8jN/GU18kDvUV/0XF+bavyAI1uquGhoahwb6IvM9jQxPFILd/rpBAz3H8Sb5Af5ywcl9D5w69xVYDe9HKC6LIZlvXM1SnbCah/FtQCFxtBtxItH5m4frlDA/qjQ896aEjzcjgIyClbFZNu2fqQc2pbqO872vkXfXYW/bahsPZGZ+Bc7KUtpGJyHHeFWKudJLOl6y5i0/FGazK+tTRAZ9Iz5fzlWVMo21NOMUPzjPbLZaQxRq7JOTkzLsvp9PNBs8EO01CLNAo+SMdyMW+OpXQRPg5uoGPaIuIruSCxWtSrEqlFQviJagJ/zOvbp9ztU3Gh49dZQ7jVN3tkLz0VrURkUIHojvufKReuqUoh4SyNyrAHc0d6ttt7vMzf5V2X5NFYylcTaAjJNKFLssAdCMBYxkZc2OXchy+iuoVxzPKRb4bdi5LFaQLlxvBkNgOzkK/j9ZQs1sP4hQUyl9P7h+Jx3pHT36WKNWJRUHPVBv53FfbSWYDqFEGiDTM59l6sBGeTbqLdCmaRkO8bZQlragzgDD1kIDBM2JIP7coU3e4Oxg8zYhtjEX8QQQeCesxHR9+WD5v87sj5+Vl8rMSrIMH5qKnHhM1ahN2kWrHQxYNRnicvHqokJmGDxMqDenSAnT9/AmEmk39GXTBSfS6xvR8nj4V1daD8gkHivSkrDyt2qXJKUkM+j/izppwIPx5niMDWePDNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(36756003)(31686004)(38100700002)(2616005)(316002)(6506007)(86362001)(53546011)(66946007)(31696002)(66556008)(6666004)(83380400001)(66476007)(478600001)(4326008)(4744005)(2906002)(6486002)(26005)(6512007)(8936002)(186003)(5660300002)(8676002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWRMS25kSE4wRFluUjhISE9ZSDhZTnlyenp4bjZPUkRXVldEUzFWeGR1NWFX?=
 =?utf-8?B?N1AxTW9Wd2hLUE1LeE1qME1XZVNFa05LYVEwZ2RPMktRN0pwL1BMcmdjWTlO?=
 =?utf-8?B?L0g1ZS9BTFFldytvaGlEaklsc0UzQmxKblZTd0J5VWFWWFl1SCtEWFFVc1Yy?=
 =?utf-8?B?eEZOT0NLVmxtMVZLL3V6QVc0bjlkWnBQNFF3YlBuWmVtTzVRMENXT3RFMVBS?=
 =?utf-8?B?TzBCSlNSenRDT0lua0paejZ0dXlPTjZ2NUZJUDNvbXE0MElsM041V1FBUDg2?=
 =?utf-8?B?M1h4RFdTajZKTUZMTENNRTBiRkZRQ2tKNHVHV1Fkb0pOdEV5NkJQQmhnaE05?=
 =?utf-8?B?a2lwWlhFZTRDUDEydUNzVFBXNlNJSVJiRlFxS2o4WnR3SytWMXlENVlQck1s?=
 =?utf-8?B?dzdrYnJ5S0gxUTRHMzZGYUlEZlVwNEtYNVplU3d3VU1LeHRPWm1iQm4yY3Fl?=
 =?utf-8?B?NFdINXlMczJOMjBkakVpZkorL2ZpR3liSTRSNUFTR0NWNjJYQUlMdmdubURz?=
 =?utf-8?B?bWFKeTBOT2hQNlpUNWVFMEdHUGhQNHhuYkFiMzdVcGVvL3hjU3dhSVQ3SHhw?=
 =?utf-8?B?dHA1amJZcWd5Qm5iVE5XaHpILzdnYjgwckZSK3BGbFFSMlZvb294dTBFZVVk?=
 =?utf-8?B?ZHozNHM2SjBjLzVxREl4bm9yTEhWMG95cW9zTjlnZmtBRHdLTmlEeHVyQkxQ?=
 =?utf-8?B?QzRQSzV1SVUzMXA5Y0w5YUdoUXVaRjVmRHJiZGxJcHpMYTFLUjVJaVRTUEti?=
 =?utf-8?B?U1llbmlBV3dQSzJ2OWdMQWI4c3ptNzFSMzd6UjdsRzhXT2FmdmFnVDhUUjY4?=
 =?utf-8?B?cWJJWlpGUnVnZWZTanNJVlNITmhPanc3NDhuZDI5WjFmelhIaWYxMFQ5eVlR?=
 =?utf-8?B?NTNRSmRHVEF0clcxVzRlelhZVTlvczlKbXJ3VDZUUlNRT0s4WkJKSmVHWEFZ?=
 =?utf-8?B?TFpkMm84K0J6TkZCK1hVNjhIQnozSHg1TnJITFNnemkzR2wrWHNFVHJaa0d4?=
 =?utf-8?B?aGxHcjJoUEtITktnMCtZelg0SnVoSklyYWFhdC9HWjBhMU83V041OVk3OTVT?=
 =?utf-8?B?WVVhdnlMUk15a0k5blFRVGhaSHllZDhubFJZQm5LRGtHNmhWNXE3NTQ1by81?=
 =?utf-8?B?OFd3MDBpTUpHRjRSbGRiUm11Sm5Va3hVanpua29GK29OUVl5ZzY0b0VSUWl0?=
 =?utf-8?B?RUNCbUg0aGszK3MyYkl3ckJYNWExQ3JpNytadjJIZHJlU3JERE1yTVpnVVVC?=
 =?utf-8?B?cUFOUzRwSmtGN2RjOWlDSzFTMjJWUjZJYmFVbVFabUhqT1Y2L0hyQVU3ZkJJ?=
 =?utf-8?B?V0g4MGpWZXZTVDJaS0lSVkRlLzZMelFaczREWU43aXU2MEwyc2hxNmFCeVdW?=
 =?utf-8?B?VG81aVJncDJxUlp2alV0OTFFamJIUGR1WWhyOFU0M2lmck9NdnNHOVFFQlZr?=
 =?utf-8?B?ZUw0QjdZN056U3VGejNOeUNJVVF2bUpyd01vUHlKRm5VeVpjRlVoRFdUT3pC?=
 =?utf-8?B?YUh1Nk5CK2orN2xRanNWb2ovYndHOTA5RFhrNVlsS3JNZUN1QmVDSjFHZlFo?=
 =?utf-8?B?RnpxNVNGMVIwWk02OUhGbC9zcmc1R08wMmVvWjJWSWZ3SGNyYVBJMnVYK01F?=
 =?utf-8?B?TnByY1pCTWRsbHlKb1dROUdVNlFvcnM2WXR5cVpTaVNCWHBLdGJBeklFbkZ1?=
 =?utf-8?B?L1ZKNTk2c083OHpDS2VWOGdBTWwydUZsbzluY1ExaWozMzdzMVdjTTc3RENT?=
 =?utf-8?B?L1NySnRMMjNkVERIZ2locFczbXZ2emtwMHRHNEtvK2MxeEZVTGd2YkZGWHZV?=
 =?utf-8?B?MU0yc3gvbGxGRTNJdlg3THdKaEtXTkNKMjM1SkkreThoa2ZKMm9MZVF2QzI2?=
 =?utf-8?B?dnBFa0dqNWt4Zm9rVmZFRUlqc0laT284Y3QyS2FGK3JZNWt1UzRCMGZUVkhD?=
 =?utf-8?B?YjI1aUUrZVpnUEh0YVljbldjekNzWkVSaVU2NzduVzhWM0VUVVlheEtTcndz?=
 =?utf-8?B?eXdkTmYzclVBdFBjYmR5N3p0RkphaDdDdmpKRVVIeGJYVVQrQkpQRk9yNmtQ?=
 =?utf-8?B?NlQyWjRFNlVDeXhMZ3FUT2pNOXdjS1JTWXpMYlBVM3VlandCSlp2cEltTVpH?=
 =?utf-8?Q?R/O2kpAxmjpu1zeARR2StGw5p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e69d27cf-8ef5-411c-f621-08da68cd644f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 14:54:19.0396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NezoSD31emXjMChBrXNvJlhrzxLLXDWBWE2RQH2QKRgal1AWHFEzcbR52y4X3qtB6QGbTN+Cf6csRzRQ0lem4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6959
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/2022 4:12 PM, Boris Petkov wrote:
> On July 18, 2022 8:58:15 AM UTC, Bharata B Rao <bharata@amd.com> wrote:
>> Currently it is possible to start a guest with memory that
>> is beyond the addressable range of CPU. This can typically
>> be done by using QEMU without explicilty specifying the max
>> physical addressable bits (via phys-bits or host-phys-bits
>> options). In such cases QEMU will start the guest with more
>> than 1TB memory but would implicitly limit the phys-bits to 40.
> 
> Why does the upstream kernel care about some weird qemu guest configurations? 

It may be a weird guest configuration, but it looks like
a kernel bug exposed by QEMU.

Regards,
Bharata
