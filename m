Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830904B9862
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 06:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiBQFmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 00:42:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiBQFmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 00:42:15 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5573D2AC4A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 21:41:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5a6XBkkvFMTue+WDRmhm4G7+1/rw5voxDQalzYf0B8wl3Iqho77u/iZ9Soph3Jy2O4Jm3oBhBXIywAVYmyUacN4UfiEOFQAyk1IJuIJK6e/BRzfAd52tlp+RFjHMb8u1DCUW5Xe9CFRaZa3iTe3yEn7sXg2EzfKOo8h1NFWJWYaGaeGy/DrZSNiATgkik3K9ru7MozXAbqhitLkFSM3JgcdlZS0gL06WKh2xeX8cnGrel2/LhXek3bv8p/LI++j73OKq+bzwNBDuIJuWwHHlfaKR3OCQKQh3dC7O+RuDygXLPFfiIw/Mi9ZWAZZzzX7pgfl4fCZu3WWMEVZH8Toaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErOvVrRs8t4jLwbkRSEz9Yg3lFr2aInJ09oECaQbhS8=;
 b=MJbOpt3V+J0gvM2bShGU12m2MKdadAQm0Xt88Jhtq0ZJxufXyLj6WUbfaNFFf/k0dIjDVQGK/TtjenX7VhQdDY9zNiq/qcRcytfeL9Y0mDjTnc+HUs9vUumv3TRYDcbC48Fiz23u+oSj4nNcSFT5qmhm0BlGbRoj7RB5zA0dhVXJGzoTfgOkdT1fxKQoEhdeZiC59UT6nMyxa03+hpRvFt0Wb6OWVQDu/d7zG8GpAB72On2ohec/ZeNDOvsRJbnYnp2bJrq5yCGn2vvf+MH7XEJNSv8CNWrQ+CAjR26BwMav13BR6k964fHit1hplKpHoxOwW+SMfuy+bqZi+shOOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErOvVrRs8t4jLwbkRSEz9Yg3lFr2aInJ09oECaQbhS8=;
 b=1yjiCB86r/mdFrnn2JVmQaMlrnsius9XoU2Ao572Ip1PJdriZZY0ouu0i/GUSML7FqSOPSGu7q/o8b0LQiiqHj/4NrWOncQjGFp3ZIxE+LEPxwD8eloEEYaW38rbxf59jtC7B8Wrswfc3SO67D/4sxjW/2roRM+0gXMUb8olV2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (52.132.180.152) by
 DM5PR12MB1355.namprd12.prod.outlook.com (10.168.234.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Thu, 17 Feb 2022 05:41:57 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432%2]) with mapi id 15.20.4975.017; Thu, 17 Feb 2022
 05:41:57 +0000
Message-ID: <4ec70d25-3dcc-a1b4-0b51-0c84123d09ad@amd.com>
Date:   Thu, 17 Feb 2022 11:11:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Content-Language: en-US
To:     peterz@infradead.org
Cc:     aubrey.li@linux.intel.com, efault@gmx.de, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
References: <20220217050220.27799-1-kprateek.nayak@amd.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220217050220.27799-1-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0141.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::26) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbb74bb6-7330-4c95-5091-08d9f1d835cb
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB135515AD09324BC82AEA962898369@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Z1WuuYhIDRsssytCiTpuaJoo2LcaHSJOvguc8LfEHeelsmKN2YMMagGeF3uFjZF8hCox313QDjmIU3a26CiSaPXKekIREXx2xKi4ChAxa+LEBOxtgjTCwTIj64gsBFK5Xzo7YQWPQS7lnKI8cECWYHIakal/wCF1dbU7J1UHgDK99JTe94QW8S0XVX5RtrHGbnWXpsY8XCIafrbW0JHXYeq95At/HTouizsoM8Zrv7VbRlE6EH7iAA+BdJh/k8R7WymO8jWCah/NN+sgwkHgy8l7XnKcZM1S0MJ2LrbBHTTgx+r/smJ9BbeXO1SRtGjH3B71qwdTPbW2Ffojk3EZAmR2Da3h8iFMOj+KvZF53ucO5spliWXMX//ajkeFinWbkb1sMksCiVYurFN/B4jbKaYUEfwUB9Ybp82h+1VEjqdCVPjaE6ZNp2kmFcXN7NCdFPHZ/helmlcnOyGMo0BHh6/tsTdhqAZSXZtxVUUNgpfD6arC6xDrO6+HvTibIpWYeW8mI5NEFzzk07BXUHF4wVTsENFxNGOC/dTlhV/PA98jvuIKxBGKG6T+tbTiMGBHSnQg6t/sGfoWEnmLY1yYX7saqHftDdoFjfu/kVXdEHndPBuNxJEGSPB5jpt+bAMAXzluFsMc+jEggkrqQe3As6Pj4hI+Cnf0JOiFtpmvgMgbn8n9s5n4lXdiuAjkHjh7tL0NtTVMGL3HVcNxBM3TbuIaB/8eWIShb+eOoO7MXc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66946007)(4326008)(8676002)(8936002)(2616005)(38100700002)(31686004)(6666004)(31696002)(6916009)(6506007)(186003)(508600001)(26005)(86362001)(2906002)(36756003)(7416002)(6486002)(558084003)(5660300002)(6512007)(316002)(66476007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3FEWFg3ZjVnUjNQQURpUGpCcm9lZmtoM2pubGtyL3ZScVZyQ2diYzhnY2ZF?=
 =?utf-8?B?WUpvM3lVSFVjd3NiUGpLaUhKN01IWExhWEpXZGltdHJYamhReWRrbmRjYUtD?=
 =?utf-8?B?Ymt6L3k1WC81WnF5V2EyMXA0UE90QlY4OVBOVXBvZVhyeEdUSjM3Vy9EYnZF?=
 =?utf-8?B?UkFMMUdHRGtRbzdpaWxKNmJoQW9ndWVMeU91YzFOVmFlWlJHTHJ5MlpSRG0y?=
 =?utf-8?B?dXhjTzVFbWJBU0RWZEp4bHRsbGtxMkRzQUJyODFBMkk5T3VvNUVRbUkxOWc3?=
 =?utf-8?B?MjU0SHhqcHRTSlFJaWhsMHNRUU9CelZyS1N5N3dBdXExOEN5ZHRzVW93WGdr?=
 =?utf-8?B?RmFNZWNpbitudUlSZ2dTb2YwK3JuZE1yL0hhVHJuOVpMTHZXNTlsTFZra3Fu?=
 =?utf-8?B?dE1GQ3duRUpIak82TFpTY2tFR0g1emNjT1llQUZmbEFCZVRJVXh2eXFDMDFB?=
 =?utf-8?B?RTJhUnFQd3doMDBZNEM3Sk5nZ0xRaE0xSWlWcEJ2L3NLVVFEM25YcGYzenQz?=
 =?utf-8?B?K0I3bUFPYWtXQ01mNHV5dFNrS1MxcjBBSlpqa0YwMkxwZ0RWYW5XUUI4cXA5?=
 =?utf-8?B?QzdzZWhIdTVsTmlrbXRLKzBjWDJGV0RRdGNyWWpYV1FjQjE2TXlDUzE2N2Jt?=
 =?utf-8?B?MUFXdE5pUmZ1WXRqNnM2dGdINmNlV0EwWTZpYVFFUzBYekw4a1pJR1N4bzBJ?=
 =?utf-8?B?SUc4NGlJbGJ6YzhlaHR6V0Nqdkc1bU5jL3dYRHAyeVR2aFYxenFwOHBLZnU1?=
 =?utf-8?B?cUZWWm1weVo1clA0QndBeHVmLzFXTmw0cVBiQ2dVanI0Vm1GRmh0ZjJneUdw?=
 =?utf-8?B?S1FWNVhzdU9FaG5ZdmdvQWwwbGROZUo2QWt5TXZER0lyVGNuY2VDTGZaZ28r?=
 =?utf-8?B?QlNEcERDNW44NGpZWFBCa2h1cEt1MDBJbitWL1ROOE5zSFJ2MEtQQnplR21C?=
 =?utf-8?B?MmtkMnJIZTNodzNNYnZpRGdXYzJ0bUc2eklTYXNIZEpua0d3Wnk5YnVQdFlD?=
 =?utf-8?B?N3J6UGdOa2MweTZNMTViSW00Uk9qRnE0WVVhckdtcnc4RUdkNHpoMUJ1LzdC?=
 =?utf-8?B?b1ZYVkx2V0JSUDk0M2dMbjlITHR1ZGZvY21FSGJDczlUTFg2S1hhVHhUS1E2?=
 =?utf-8?B?K0lrdzNNSnBuTnZWV2xXaE5wTjA3SHEzbmkya1d2QmpkQ2RxNGU2RjZobHNO?=
 =?utf-8?B?VVhtY2d0SURiWWJQS0crUDdmVWxlY0J3VHFjQ2daWGo3MTViOUlManB3QlN2?=
 =?utf-8?B?UXpCWS9BWmlSN3RpL0FhZStzYmgxRW9Dc2pvajlvbTIrWHJOeXdFeGRrYlVy?=
 =?utf-8?B?N1lRMXdRbUc1djdkaHplV1BaZ1VhUFlzcnNtRjAwRjdxaE9LVUEwV2lXRUZ5?=
 =?utf-8?B?VFRsUDdPb3JySDhhbUR0L1pXSnZ3UjRzYzhQWldjZVpialJ1QlVFZ0dDMjc4?=
 =?utf-8?B?YkV1TTliSkswZStld0REQkRTVkxTZjBJdUZwK0JFemcvV29aOVJIdnpWS2F4?=
 =?utf-8?B?OTRzYjNFVGRVSUJyTEtlcnhvMFRRdHFUK1pBdlVmTkl0K0poMkFsK2Mrbity?=
 =?utf-8?B?Rm9ZV01oOUY0clg0Qk55M0luS2dtbXc5YmVKQmxSWTBzR29TSm1ZZjdOVUxU?=
 =?utf-8?B?TGE2VEdnTmhNU0dSTFhiTGlNUnBEYVI2WXhpZHkrMTdJUCtxQlo5djBjdVZE?=
 =?utf-8?B?eWN2aGxoQ2hYUGJSbVk3Rzk2a1hlUVUwNHVlMy80SVdjSmMwYnNFZmF1Y0xs?=
 =?utf-8?B?bDl1QzFMcGNPRnlhY1hHWFd0OXB3NzZRNUUyZ1dwd2R1Q1hpaWhvdG9HK0xE?=
 =?utf-8?B?ZmhmcUJVUW5PL2VwQXdPdDNSaWFDWUdHZDVoaXU3MGNPZnkrb3IwcTRRWktn?=
 =?utf-8?B?aTJoR0FZNm44dndwREE4UVlHRWJQYW1sZE1WdGNpdUJVNERSclhkbHE5SVla?=
 =?utf-8?B?YTAxMlA0RUpVd0ZWTnNKRUZyZVo3NUszOVpZYkFRbmtuanQ5QUJUK3ZmcnJE?=
 =?utf-8?B?bU5lS0ljRU5xZENwVHkrOTRQd0tkTmlheVRHZHpiQTd6R2xrNzZrZlpwNndR?=
 =?utf-8?B?ZWhOSGJWdE04LzE2L0twdTdzNm9NdU4zRnYzVkFjVVJiVWc3a3dFOHgzZUNm?=
 =?utf-8?B?SFo1TzV1eDdKUlFMTHlLbVFDQWdYRTFROWNITWRSVm9KZGNBK3Z3S1N3N0cv?=
 =?utf-8?Q?s1eGJrw4NLkoN4ukIalqQnY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb74bb6-7330-4c95-5091-08d9f1d835cb
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 05:41:57.2382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mel04DRUV+7MOaHPdFWfFqUF3gBmIsOeez960JMu1o+oxZDLpu7OeUTTSTZE19clQkJ9CZ0L0ghRfCSBL22iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Everyone,

Please ignore this patch. I updated the commit message of v1
instead of v2. Probably should have had my morning coffee
before sending out the patch.

I'll post a v4 soon with the updated diff that adds Mel's
suggestions.

--
Thanks and Regards,
Prateek

