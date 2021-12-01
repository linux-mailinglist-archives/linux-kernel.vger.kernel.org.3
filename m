Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37C04659A0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 00:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353740AbhLAXIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 18:08:53 -0500
Received: from mail-dm6nam11on2079.outbound.protection.outlook.com ([40.107.223.79]:16992
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353745AbhLAXIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 18:08:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtxD+Ku18MUGXJRavM+WIDD6EYRtlw5zdvbYxJtrX2QqsfqLej7BMpx+aRxMZ3jmwlcneFjmA+A+isItMfTR4iSLl+DzMPj6Hgu4TNqRqRVcyxjJZgjQ3IcPqIS4sWp1CnU+9ZheQ4SJqNHgtpi05nMIARScoKqFivAmGk6mvy433qpcu8uRKd4cXsKGexXh8Ne9KnLXLicjVlrVWutCnfTdp+umPk04d7enHPjAVFM5lC0fxxE3qeqq/iKqxnd9HcVClkAl80c9Nf1CeNEWT83mvKu3aiQ+cWE2so63up7yr4FY/UZhlJjFuhRvyCqVZdfqY88HutFiuLcufjsBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wmn/7OGbyVjOnJq4Ywz63EP9alME85BIgCJIIFwUM6k=;
 b=mRafu3IpoH1lxup0nbVq819yDxtx1kd7Gell18Iim//Vqj0Dfdpwyrh2zyYQbBbWH/e/Xc6DbGksU6KwSrWTH9c9vA71d/YZMb4LiJRLHjvB/CfGIZHhLnt8cy3zv+XDeQH2h9NdB/jD6r/g08WBCZIzIfVGTyhBpIgF7wYgshlAaSqE51TP8YZ1BahpC06WHroC5S6+bRJhmBm5gGrxAAhdq4LgwrYy/bpelAHASticO4xraNcMi4RFee92J/vm2u6BpOoU2E7mc7hik4I61EtdHpahjK3jgVwRp+ReCCdiTtNsjGQVgIwn6lQX6AWBTJvh3MlX3WtcPPmhThR9OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wmn/7OGbyVjOnJq4Ywz63EP9alME85BIgCJIIFwUM6k=;
 b=yyX8uiESYJeU7jSJ+an2dzTyiqmfK1gfp1U83jbdu+rcER/xx7zULx2G/hv58D5Arj69sJZOExjNy8Qq+v/NvnEFrsQdmeSnEmixWKOeqUslHW6u54115fvf0r4+2OElYS5uz17G66OXOrO4VRmCO2dFtT2Vd4X8yN2/MV11F/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN6PR12MB1330.namprd12.prod.outlook.com (2603:10b6:404:1e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 23:05:19 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 23:05:19 +0000
Message-ID: <f2a0d460-8e18-c1b9-9187-c7f941b67a40@amd.com>
Date:   Wed, 1 Dec 2021 17:05:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 11/13] perf tools: improve IBS error handling
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        mpe@ellerman.id.au, maddy@linux.ibm.com
References: <20211201010217.886919-1-eranian@google.com>
 <20211201010217.886919-12-eranian@google.com>
 <25f7b261-3f2a-942d-8d3f-d501d9dc9612@amd.com>
 <CABPqkBT8gLPzZrwAxeBbkftaFxecDv2Xo1x6dS86emRcZELrhQ@mail.gmail.com>
From:   Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <CABPqkBT8gLPzZrwAxeBbkftaFxecDv2Xo1x6dS86emRcZELrhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:208:91::16) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
Received: from [10.236.30.70] (165.204.77.1) by BL0PR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:91::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.8 via Frontend Transport; Wed, 1 Dec 2021 23:05:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddffa1c3-7cd2-409e-38cb-08d9b51f0bd9
X-MS-TrafficTypeDiagnostic: BN6PR12MB1330:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1330E1D186F15DD5C660594487689@BN6PR12MB1330.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: luCPjzefjCQ5oYZAugcah+EPFRURe7e0jxLzT+fwh8LgWGM+J/J/2ucnfVbnpNLJNpnCcwdL/qDd+gcOS14U+KEL6JD2uVogjenlLY4ptkh3mxbHHwWgFOeBRkbkQ3tXWEIB28ieRbnWw3+UcH2NoXDKi3QHNCnlzcBdS2DAJgjPWs/4TpbGs0m5sPAuT2i74xIdJyHwwO00EvaL7nXpqNA4L0i9exXOZG0O00VkFUKVtFPo7hQr0GwSZnQ4wQ5osPhxfrkdutaJ85CQVTTdFLjJUJVlDQgw7TyytAlxbghwjqXhe/bdoqEiYhBf28m74Oy+F4Q6xNFA3WKmZNPgQY4Mlt8D+qc1IiNrEM0kaZbNuH8c76fAkUF2vAUktv5ugMnuW6nUx6+XipNeV88N8uCX0apycybV/kzD9853FnPCBqlJ0nLF8TJZfWiCXgahALWm5C2sYWl1nxGKbmWgFLOm6Hnow0gFnXvKJ9elaGjdEkyIyJthl202nNhCwbEHo41MWSGdIvZTIbDBHhktMt1ii2fQkLerAOnICiw99wGOCLxI7CTMXw8qisWJGlNqcYwCH5tXKMIPytySLqfCha84rDnsv808j1mwEFksTqaHG7XFfmc2ppSC+x54eweLVeRbbb4u4TP8AV5V3+Zh8t+IJj6WIiooAChCpyywxRP+xqiL24TQKag1Qqtc39UCzN/7gWx330hSGGgSQq7Xj0QQ5Fzz/v8h88VtlaDCkZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(4326008)(508600001)(66476007)(66946007)(31696002)(558084003)(5660300002)(44832011)(38100700002)(66556008)(6486002)(316002)(16576012)(2906002)(8676002)(6916009)(36756003)(26005)(53546011)(31686004)(86362001)(186003)(8936002)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVBtN3FQSFh2MFJrQi9wTzhCZmZpanZRR1kvVHVqVTR1dE9mbzRGQlVMMDlR?=
 =?utf-8?B?NUExY3A5NzRieGdQeFQwZ2JKZ2lYRDlMbGZ0RUtqWjBlMkJNeDJ1ZWNCVXVv?=
 =?utf-8?B?eEZvb0xrTXF4b2pycUNucTBpUmd2UFVpVldLQWVGd0dxaEh5bGsxcktXaEUw?=
 =?utf-8?B?WXp0RnlFaFFFWGRXekVwZXRjdmJHYU84cDJ1dExwWnIyV1graEMrZXo3eHVX?=
 =?utf-8?B?MHJac2ljMS9QUjY1SUxPL3RlblJ4V0hzTVdDbjZqMElBa2xzVlJweEpBSlhp?=
 =?utf-8?B?L3R6WFFmMTVBcys2eEJ0S2twWkt5Vzhxc29uZXZTVUlWUEdTbWhpMEc1VWc2?=
 =?utf-8?B?WlRIUmVtalcvblUrSk44akFnS3BQcWgweHYxVEIyWkk5WE02YmJ6S3ZBeDVs?=
 =?utf-8?B?WDVrMjc1RDhQYzZNTTZ5WnVxVUZ4bHVuRjkvQ2d0Z2haNDJxMzZVWWxseG1U?=
 =?utf-8?B?K3A1UG01c0NXalBzZVB6bnFJOWZ0R1BTQ2ZFcWxGQ2lJbE4xelg1S0xLSnZE?=
 =?utf-8?B?VHZmTVRrNkMzcUJTaFJuQnpRSlFOWWl3QkdTNTFIUHp4SGtXeCsxUjBkcG1m?=
 =?utf-8?B?RVdjTndnb0I5dmNJU0lTWXUzRm1WNkFYenJuaVUwcHVGN2lFbGd0QjZHSFRW?=
 =?utf-8?B?cFZWZmJudENzT1VhL1JaS2trTjJhejY1M2drOXc3am5KK0trNVFjQmZ1Nlow?=
 =?utf-8?B?ZXo1OVpvNjUrdUlnU0hCYUJlZGtrcXF2RWFnczM3bzJrTGxpNU5BbnJWTzhO?=
 =?utf-8?B?K090Wk1qVk9KTnNIUUNKYTdPRzF6UTFVbWlnVENNczJnTWw4SEQvWlFRRmk5?=
 =?utf-8?B?dFNRYU5WV3F4cTNXaVQvTTR5OHdQTkMvci9zbTRudWNrZkFUbm1odmtoTnRk?=
 =?utf-8?B?Z1FxeUhxRnhSR04rcHR4VVA2MWs4N1FzUzhFZjEzbE5GVGlScTJtTDQ3RFRx?=
 =?utf-8?B?bEFWU3AxMTlWOUpRckhlZ0ZlM2NIY1ZjOW9GNlRVU1dvclpSaTIyanRHSmtM?=
 =?utf-8?B?bjBqVzJYOVJwR0JiakpRc2ZWeVhMLzhReE5kMXE1QkcyaVY5cjVZTm9MWFBk?=
 =?utf-8?B?WXlDYXhTemkvbUxrZDJ4cklLOW5GMmoxVVZGVU1ocFo3N0R6bWgwYUpobW9u?=
 =?utf-8?B?RDM1TUw2TVJCMU9nSzl4RlNXcUU5QWNTcjRyY1c3TmZQSFlIb0JFN21rb3JP?=
 =?utf-8?B?Zys5UzN1WU1XSmlIYzQySHZ5blJYb1FHaDhJZ3R0c2RRYVhNTG9ZZE9Iclg5?=
 =?utf-8?B?OEw5WTZOQjhWM3FYcFA1YnhlM1ZONlpRVVc2cERiVVp0Tm50RXIrZStZMG9z?=
 =?utf-8?B?MU5lMGVPRmQ0ck5tdU9JdXNKcGVGQzFTYW9FVTJYL1lVc1Y1ZjVlM3hwc3dy?=
 =?utf-8?B?UVMyMldDbUdseEJFek9BejZsWXlXRTJlWGQ1U1h4MEpIT3Vqd2xrZ1hnUm9N?=
 =?utf-8?B?bldKK2hXNHg4SHdGVlZJTzNXa1F5SkRqb0p3M2QrMUo0OGpETW1OcHBxRWZD?=
 =?utf-8?B?MzhlTkFFbEdhSmgrWXovZmxJOVQyQUNrZUVPNURrT1FHbUR6WUllejhYeXpi?=
 =?utf-8?B?MUdNSzBEMkdDUkJzMTNBMDZwZytiTWJGTndwUm1RdTlyZVZPY2lVTEV3b1FJ?=
 =?utf-8?B?Uzh6Y25QU3ZKOUxvUVdVa0dCcWlWU29vNXJPOWc3MTFzSXlaemNtQmw0RExo?=
 =?utf-8?B?a0NNRHB5MHNSZXBqQTlxd21xbk9ZSUREYklFMnBxYWxtQzkxOWZYUG5VMFAv?=
 =?utf-8?B?VnV0V0JTQzRCNG51WmZSQzBJbFk1QzZmRVpLQ29XT2I5YnNCTjZMaW1HcVEy?=
 =?utf-8?B?U2hsNDBnRVp4TzQ2RVNzc1R2MzRzV2c4cTFldjAzYWxoQ3ZGcmtNRGVNc0sx?=
 =?utf-8?B?a296QkNudTZSM0IwR3dwYjhBdmtxaTlYcWFDZ1l4cmxxMmw4VTl0cWhHVTNC?=
 =?utf-8?B?aFkzbi8zY1p2NkszYk1SbmtzVkkweXZ1bFR1NjVMRTl4THZUdUtwa3lPS3hK?=
 =?utf-8?B?TkwxRGdhUXVtdjJ4UytvZWFvNzcxbkJJdUtqblErNEQyYjlObzlMK1p1UzFV?=
 =?utf-8?B?djNidjIwZU9EeGpaMHpOazVnZ0l5NUZYOFlMeHpGZmN6cTU5dWEzTWRDbTZk?=
 =?utf-8?B?UVdWVEI5cVpRS3ZVcEhySWpsRHVTMmFibm1kc3M2Z1VhT0RadGs5WXBEcFBh?=
 =?utf-8?Q?lXgtO050K1/DXoYXyNDSJLE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddffa1c3-7cd2-409e-38cb-08d9b51f0bd9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 23:05:19.8144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/FbvFw5PS5K665hbL6T+OlgVtmwrAhguv0yUS3Joue0JbS7IAXgssCCJl4vgAWR4BSe8r5u912Oi7tAHRyVWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1330
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 2:40 PM, Stephane Eranian wrote:
> Could you send me the patch you want to integrate in the series. I
> thought I had integrated the change in V3.

I sent three patches attached to a direct email to you, Stephane.

Thanks,

Kim
