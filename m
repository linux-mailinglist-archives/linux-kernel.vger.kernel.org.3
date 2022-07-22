Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A746457E337
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 16:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbiGVOrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 10:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVOre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:47:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26F43CBE7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:47:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8P8CqukQS+Fo/V0P8epMFOieT9AKtvzwVfhuyaTnvCZoQ/nwdHPvUJWQL6oB6depBe/7Yc+lT0tbXBe4OdXmUM+xPm6x7UCtuzMEhgZsch1E5hWByKtoMvRLsycr2LsFyA913Djsp3yXwWLqFsx/LAEA8V25brbqnkAkc1mklH1i0CKS7CKQD3a02z7mePDgMD7XooHLZmZ6twe8kQhQvWRUvZGdCl7oF1Lk0BbepY6UabiOYGgu9B95xnWTfWlqupmPGO2C6WpfU+Oq7Tqv+V0Zb7zXLvogRFN1aicRhZOzq8WLxHEwDq24blsWu1ZylT7E9e8XvpzeHZLuc53Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+K29ARDCfRWJTeRnA7afImG5Cb4K3f85c6//5ZPgsk=;
 b=NNzo37OP2fASq56k/d+SZwW04wFVD0LkPJ7rPeshcJV6Fdw1oSJNYepFBfP4yMMjbyTW0Eu3MGC0h2djAyWM5MAoro8ilKY5Dtn0Vz4mp8qXD+NMcua8l6MnaOujJ/vEuGrZ+Qh4w5iHX7J5a7HGfPa0Lr+2Q61hxmz+fWLd86i9RcplTJ7kQ/BP0nLkh7+rc/JDYoBhc9QaC5TWVP6MtT/ZS/AwRuSa/ROTz3z4c014TqNz0ZatWjAn1Z0LGVx+f/5rCxB3h9QklhThxA9IUDxq/AIkLU1KDFHPa3o6loyyIegK9PekWaOHJnBR/muhT8UBVWU1Lu41neNunqD01w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+K29ARDCfRWJTeRnA7afImG5Cb4K3f85c6//5ZPgsk=;
 b=k0ezUcr4WsRuppXfzH286iyshTYHV3CgcgFVYW9SGjISPpnbOEw4gRADECswBslNgHXGc3FtLzza4c8A+Bl6sl0fjZ9GFefKXwu0KPtV2HLh32eKzmbsLgabWL7lDJaq1T0urEmt5pBnsRi0uii7YoGn49MXEaFC27yv/jSuzCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN2PR12MB3856.namprd12.prod.outlook.com (2603:10b6:208:168::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 14:47:31 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9%3]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 14:47:31 +0000
Message-ID: <78aff052-64f1-a044-6ed3-e5f48325476f@amd.com>
Date:   Fri, 22 Jul 2022 20:17:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Question on perf event context swap at process switch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::28) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a97c78eb-f665-4889-53cc-08da6bf11ad6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3856:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhdxSmkG/MeJkLx550lboLOXdE+e6sDRDqydR3IF4gY5Tl7s3b/PKP06dkJWuobWmdQraLgKB4vjH7sAh4dszK4AAvTNSCTpNn/qYuUwQa63yHP/HIQhFtqvueMAWKuFzQG6ej/5g72ln/jDE1lxn0IQ3CVQw1whD6g0GDNwmnE8Nl3jtVgxN7lb1oSJCxiNm5j6CAsHj/03bWjzCtS79uVtTPD7hpz7ksZTn2SE0mkOAlxWHUSXPoOUDlMQHA1hD2Dx0HWMD+kO1Up5QZaV3KLq0/76JrqmrhavE6UFsx8g+BiNHGENPMU0wwpFuO9OvSUidUAZt36l54gsZvRI/FW8h3WJPTNSp92uvQjKgkbCwkP8PHH89nC7+CmSLTT0zMYzW3VfHcDVTVYjktlxHGmunndFocp+NVL56ggCWLX+ko7vH+M/iwIn48oarVAiX7J+V8tqPHjjX5kvoGJngya+F0oqNdx8qgsUa7I1RSS1HSMMud1hIfPiZOGfSF0KIBmv1SneHhXpYFZnfc4HpSfl5nviOtPKxtzpY0Wqt+WxtInfg/sBMVm5zTN1MkitFxE9fG9y7UKJ1eP66bJpX1Hkxa7epaU24x8p+JAKyZEyHwUszGgrUZzd7F8l2yDbBDlXnDD8lZoqXAggZe267bdql1gpxfeWY1q05bjgfB3WBBbFazEKMqLi7Nz3eiZyrm5GzO44/pchKGA2iGTMW/rM1lC+zanOk0MYQp7jCePsMjmsMLyW9BFNS4Mgw8YJ64vftwX1pb/Bb0pHabQheTnm2x+ogpwW2La532XPxCJ0UpL8yZdZ2cIkuIgJjglj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(8936002)(38100700002)(6506007)(6666004)(6486002)(5660300002)(2616005)(4744005)(41300700001)(478600001)(6512007)(316002)(54906003)(66556008)(4326008)(26005)(8676002)(66946007)(186003)(44832011)(31696002)(66476007)(31686004)(2906002)(86362001)(36756003)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elF0UzB3ZUZhdHFpN1hjSHc2d3pHaG5EN3lZKzVQaWFpUHc2TWM5NEpuSk04?=
 =?utf-8?B?SU5GTUhtUkVMMzBzZlprZmJybEhHTWhod2VGZGpBaE9OY0phWk1oVmxPbTVO?=
 =?utf-8?B?UkZPYVRseGhxTks2alhnVndsMCtmVkZ5WmhjSVIyY2JvUFRndFRLV29Qbzg1?=
 =?utf-8?B?M2RhUDk3ajd3TXVpSFpPODI4SmthMnhQY05HeUFGdjhqUnhzNnV1QjVBVFlZ?=
 =?utf-8?B?U2RZd3hHTXJOa2hJUEkxVUdEVEdJTWw3dmRIOWYvTVg2VTBNUTJCaTRsYitN?=
 =?utf-8?B?bS8wUnl2RldsS2p2amNUcjJ1SkpuMEtYcU41U01tT0dvckZTKzIyUlNMRlMv?=
 =?utf-8?B?WFJSTnpwU3BxWDhva2tnVXdyUDFMTFlnOGJXaXlJc0MwWjhjTDdOWW9qTFhG?=
 =?utf-8?B?MWFHZmtXaFZMZU1mN0gwRzhCR0NUL3dpVXdFSE95OW5QcTR1ZHFOLzgyU2cx?=
 =?utf-8?B?TXFGRzdQT1p4V2xkeWJVb01pYjFMbEMvTlc1L2FrRERJRmpsOGc3a1dvOHY5?=
 =?utf-8?B?aFA4YzR1VE81RVVOOFZISDR2VUtCRjE1Q3VxaEZOaGtqWjRRRm9RemNwUDd4?=
 =?utf-8?B?VWM0N21Od2VRbkhZNVcrWHd0SmRYdEpKOEFOMDRsUTg0T0VwOVZ1VVlBeWk0?=
 =?utf-8?B?QlRLdGMwc1lHMHpnTUM1aE5zY2syS0srSWhuUUlDN0E1T2lGWjlTZW9wUG0v?=
 =?utf-8?B?bGFJRU04M3hPK0syQTQ1WjB5MVRDS3VSdmQxSTRkMTZQK2tnMVZBQUdnMUtP?=
 =?utf-8?B?RU1nWjZkMFZGcForOWhMYUo0N08zc2VyQ2JJdHlPNTl1Z3I5S0xMWE00akNs?=
 =?utf-8?B?alRlK2k5b3hVbE9PS1FaaEdPYmUwcFl5OGdTOUtXekJjQ010L3dlTHdzRXdG?=
 =?utf-8?B?aFVKMmFuMnRDdkU5dTBSd1dMbjBaN1dPTEhqd1NsTTg1V2FzWFVzM0RKNllI?=
 =?utf-8?B?djBrckgrT3RvbXFpZVEwR1Q5YVhCanJoMzlwdlBJUENid2lqQkNYNUpiMGlz?=
 =?utf-8?B?UlpQeWdYbDJsdE0zMFhqQmVKS2Y4bmo5YmtSZTI1VVFFVUgyN1p4cW9KUnVj?=
 =?utf-8?B?UlBlNTMwMmJMM1pzYjY1azMxR1I4c0pySWV1c0NCYi9HS2tsYXJLMnB4RXFw?=
 =?utf-8?B?TS9rTVE2cGlvNnRocHp3Mlg5UFRvbE5HcXcwK1hGbVdYQVdyQ21zL2owYWdp?=
 =?utf-8?B?UUtQVytSeTFWd3pjZEhhdTV4VW9aa2NZQ0ZEQWR3aDRBOGx2SDJJOVNhQjFm?=
 =?utf-8?B?bHVMUUtjcW1SZlk5NEdQZ3dsSDRHMTZUUE1KZlBFcFovRkFJMjRSY3RZVEVt?=
 =?utf-8?B?YzJpNWs0SUZlQS9ubGhLaHpPdFd3ektjNHJNODZvZXN4Mi80TS9oVTBVbnRp?=
 =?utf-8?B?NTl0a1dtRFRRWVhjRDlHbEE2aTdEZTFTUUw3YzFCbnBIaHdkZXVCVUYzSzBH?=
 =?utf-8?B?dVJ2aFhDTHZOYW9MNTNpUjZmaGVXVDYxcEhQV1RzZFJZTjFkR3Vma1Jqd1Nh?=
 =?utf-8?B?eDBnOVZ3eTh4Z1VvQkxkL3JXSExKZ3ZTZDJEVmVmQXBrQTA0MXY5VzhpYTB4?=
 =?utf-8?B?UzcxMkRFVTZBdndDT1ZLYzRZWVNYVzBBMGpjVzJoTWR3cGxPMWpxUW1Gc0h3?=
 =?utf-8?B?enpFWjdFeUw5UjZnaDJaOTNsUENVMVZ1M0NEN2ViZ00zOFpwMTRnZzlJakpm?=
 =?utf-8?B?clJxcXMxZ29lSFEzUWs2b21XSFNUeHc1QkJrbTJrakdQRTZ6TEZmalhjVkFP?=
 =?utf-8?B?RXBUNldKYXpFL09aMjdVRnFtbEpmWTl2dGZyVVZjZGZCYURXc1pvcTJ1TWdR?=
 =?utf-8?B?WlNjcUl6Rnh2WTBhS1RXRlNYUkszOHVkWkltd2dFQkNTZFZBQnJna0x3L3hG?=
 =?utf-8?B?SVNBelNBT01ndmpXdVkxNjlkdlBEQlUrNm1EY1R0UlZuSFBrdHNQV09jWnBD?=
 =?utf-8?B?aDFNdGhLbm15V0E3ajFodFhBLzViQ3VTUEExczhvK28yYzhXYzF5TnJMcFIv?=
 =?utf-8?B?T0Y4T1RTOW5DOElVYzVCK3o5L3BaSnN0dG85MDRuLzJoOGViaElBSGpKQzI0?=
 =?utf-8?B?YmNRYVY2TTk2NzBwZzlaY2puanRjbWVMVmFzcXdxYmJlR2dsSjZFN0hpYkVw?=
 =?utf-8?Q?XofVdHGfLjcOA5Ywp+w/Mv+/t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97c78eb-f665-4889-53cc-08da6bf11ad6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 14:47:31.1796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7xzWWFre6TekaaSiyIJvog7jvwSvi2JNS37QjeufG0qIDfD/7pWdqIz2KliTmA+0wjnWIBPL6muCcFWnOvgag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3856
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Consider two processes having clone contexts (for example, two children of
the same parent). While process switch between these two, the perf event
context would get swapped but event->hw.target will point to other sibling's
task_struct. If that process exit just after one context swap, _free_event()
will call put_task_context() on sibling process' task_struct. Wouldn't it
result into fatal error later?

Thanks,
Ravi
