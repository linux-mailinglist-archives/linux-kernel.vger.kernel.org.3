Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA74575546
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240808AbiGNSpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbiGNSpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:45:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD41C2655A;
        Thu, 14 Jul 2022 11:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HH4eZo8LOWH0d1IHOlK3zZbUIbHmWZHPHTG+gE4LfGsnrpU4TvDJyOkvfFGUGdxCtfnPMQQIXOB53XSEzg2nmBQmUd5vgOdUQtK4FKrL98TGocGlOoBsnma7zq8+GrY94Mbh1nCxzSmTrQgYEVpmJqT4cuKyw4Pm4FlPnibN5ZBcg4oIaZkYES4DP2Uw2RGHTQeMVKZj5vCMHQ9QFv2zyGs5NveH1KNuz23mK8yGbO1fHkr9ds3ZcTVK7rxFMRsASNO6CmxPoAPXWXkn/dwIo1xN1oxL0a8lS35rvBwoazYcGn6OH5a2QQwfMbdIFL3G5jLWsKw1BAnCnY6hz6Ws1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ue5rm0wjtCVMUyaxf0BrGA5jnpQJuSCEXdoDPQp/vyQ=;
 b=aytBURp2gwmTWJ/I0445Y4vxdgTvOB71HnAdItu8FMaVc4cXYR5Kk+xAnvW8259xIqOJAySBC3Yv/mTfA4g8Ae7d7PY7oHTB54ou7Xg5TICGD1oe6RUqfJNNKq2l2cU0r66937f9oPQTiU3QwyJOWIk0LuPsYOhrxCArSej+Jx52xZPu2lKP+eUkCRro9HkRPAeFm75tveePzrDv2VdKvZC0M16HBQexAAhq8fj9ZrMys9eryVsFXiy2YIUHkDCM/4Fc5CnBQven1sTRtUvQ+vhbuuD/m8T8t8qYjw1o8WmXcYiZhgoWtSB1njRlwOuDV9JddbNV5v8q3ayNf/2rSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ue5rm0wjtCVMUyaxf0BrGA5jnpQJuSCEXdoDPQp/vyQ=;
 b=JqmwCujL9RGnyM92UZ9E7k6C+fiITzUBZmaUCoAjM/gh39N6rSIlsY+jHs1iAXAbVjWmXrk4w+NhPEoDh1rEmSEbistvJ682x7Vghzft1F/dQjFo+DVaXABJahZgASqKwA6V7oRydGdMlo0z7lbKzqUcpa+iboQeP7A2HKa0QZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CY4PR12MB1335.namprd12.prod.outlook.com (2603:10b6:903:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 14 Jul
 2022 18:44:59 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::2ddb:590a:f046:b38b]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::2ddb:590a:f046:b38b%5]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 18:44:59 +0000
Message-ID: <9f6f77f2-7a46-7735-2be8-c39e39e6af22@amd.com>
Date:   Fri, 15 Jul 2022 00:14:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] AMD_SFH: Add a DMI quirk entry for Chromebooks
Content-Language: en-US
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
References: <20220714053752.5124-1-akihiko.odaki@gmail.com>
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20220714053752.5124-1-akihiko.odaki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::19) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 650de3a2-7f38-4f5e-94dd-08da65c8f416
X-MS-TrafficTypeDiagnostic: CY4PR12MB1335:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f7gF7JnZX4DsYE0zWJWrUj9VoX5hbwM6QNsjYe3YE3Zt46x8qmIgWC3Cve92hMgxJwrYoVDqT+yH9vs41GJVo1Z3c6Nx9aqpitc6HR/N97Q992CQd3FQAzuu710OVFtBbd6mYyGXF4eglSWeN+1BqaL4qe2owhDsNTcDEC51c8Dy/t8Ej2Cy0sPK9x+pTptxlZOHwdzQomM/FIqolELr9jIXRY8yQUWiFBnpPcfSf5t0fmV5QLV9k6do4OxBuxbyKpTRG5S4ONXClf61cZqZnM+SM3PYO2ARf5LlWojhQ/7YAsIJFahb1q6S0KpKHgntlN+fTUQ3kc6VBxAAM58GCrpDVY9FS1j14YM7qfY12l5o98thZtUrUlLysDjP7mmcIrRDgHWJ/Ftai6vJ9ISEmagkVCvUnHOZ2nubzXPQsDE9uT9xRLEh7ZdvPDVKy2jYailGA0rdDUOlRo1lKAp2QCED1fxGd8N/mbraszPhgmoO7hxLnQPlSEUUDXLVHtlCXeXIEt656cU3LAPSJJC/1SKa8/qG2yj5OVK5/WU8VYxXFp36Dsk4/R+uDLIQnq2OYswdzhBWrU8C+dXTbjAzTF6bgwnvL0xhSVg/LVtdQuAR+ig2bjwW7v4TEetVrGSPgmZ5arLIKkRjeVJllgxWTUll7iftAgRoUi47zjU7HUFudIjyzBTkvbisCeCe9+L+FaDa56+6/tyznyhyp5tF+NRP8NZNlcNr8VyRaJoR6m/0P9k5giURtqIF9BjeDfvbXVJY/1EaUP5LZErr5IZVxSvxBs0nraQKC8mIdAoUASTWntVlh8HgPf3YQIux1mngdHdHV/6/xgpIJve/T94CdXsHICtXuwS6i2NMHIWSpGc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(26005)(316002)(8936002)(4326008)(6916009)(54906003)(6512007)(6486002)(2906002)(41300700001)(38100700002)(5660300002)(6506007)(8676002)(36756003)(4744005)(6666004)(31696002)(83380400001)(186003)(53546011)(66556008)(66476007)(478600001)(2616005)(31686004)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUxjSytsQlBZRjBvUXhNMXZqNzc4VXRtRksvRFA4YUZXSzRCKzZYajZwOE1q?=
 =?utf-8?B?emJnNnVEbFBYZllCYWJrVGNta3ZjcE5hWVhueGVMNjBKakRCZUFRQ2Y1Tm90?=
 =?utf-8?B?U1JLS1k0NXZFaTBuNENMTTRMYnJ4MXB2dis0Ti92cElHTmVQbXkrcEgzRHpH?=
 =?utf-8?B?MysyUjVGWjhEQTNxSE9MaXZ5cFUzTGFXWG5LeTdGeXdvMG04NklYTEpVcjlQ?=
 =?utf-8?B?Rys1Q3JPNll1Q0M5c3hKMW5MRklpMGhhYVB6NXBWMkN5Q2FEU3NHVGdPdzNI?=
 =?utf-8?B?UUpSLzFNcDdpV0ZKTytSMmRpUmVOZjBWRHBicHNSYTZhZHFZRjBuMjF2a20r?=
 =?utf-8?B?NThUckxHVGNKVTJ5VS9IMUZqdW9POFREclAxanVWK2VlODdxVFUzOXhiT1RZ?=
 =?utf-8?B?bllVcGtDWHk0SnFkTWpyRmRTNktpQ0s5N1IwRjhDRUg2RFNMMXFBY2VoNXor?=
 =?utf-8?B?UnpRRUsxRUhZczRnV3VtN0NSMm80bFFEb0puSUd2WU9iUlJEUkFlamkrZ0dj?=
 =?utf-8?B?L2lCSVV6bnhrN1ZsMU82NTNadlZ2QlpzQm5MckNXdHF4ZXR4WmZFNFBCbEFr?=
 =?utf-8?B?NmIrMFNlbWY0TU5GZmFZUXFTdFBNcmNoUmlMTmtLT2N2TEUvVVRmbktGNnRK?=
 =?utf-8?B?WkdhQy9sQk93eG81cVFzZmRna0Jtbm13d2xJOUZOWFd2bWhhdi9JK3RHYWdw?=
 =?utf-8?B?NkRJNXQyekRWY3Ayb3NSMkk2NnRGRkJrZFR5R2ZaSytSR1VyNGhzRllUVG5G?=
 =?utf-8?B?cGR4VUk2eGxSNTdvbjQweG5zb0tJeGF0OFgyZWQ4SjI0ajBqL2FSUDBuUGxD?=
 =?utf-8?B?OEpzbzRTQ2dSbGxtWjJlOVpwWGduRENITy92dG9oM1IrNzdTVTVUS2RhdlBR?=
 =?utf-8?B?ZTJtYWNDSjZvdElFTkloWThGem1BTWlWcGswUEV2NnFpWnJXdEhhem5LLzc5?=
 =?utf-8?B?VTVwV0ZIRWJZb2lPUTFMbC9panptb2R5U043cVZlS1lWNWJ6R25DN0d0dW5Y?=
 =?utf-8?B?WjRaRk9EWE82blQxMzFLQnJRRlVrMjBmRXBZYXdIdVBDVlNNL0NFd25lRWFl?=
 =?utf-8?B?ZndFSm5QV0tFWE5DRGdTb1pTOHU0K25DV1cxeEFDVHBNVkkxVWRMWFJIbjBu?=
 =?utf-8?B?KzRuNEpqaFF1L3BId0lFYmtudjZYdk1iVGZHb3RPelEwOXNvUjlhcEI4ZklP?=
 =?utf-8?B?WUpja2tIRFVES2kxalFCbjZQTmdGa1FWc3lkQTVoc0tnb0Zub3pSWU8yV1Zt?=
 =?utf-8?B?QVN6UUZkYzhxYllvRmNyNHdrNHpRZGxHU3FDQlBjelUrUVFYdUt0VXZ5QTZi?=
 =?utf-8?B?eWVmVkVEaFd6ZEtmb2Z0WUVzQVVnc1M2ZmdGL0VkSHlnUmRlM3kxakhxeERh?=
 =?utf-8?B?VUw4clE3UEprUGRmU3V4NlhQMUt5YUNWUjE2ODkzdDF2WlZQcW1MUkZRTnlM?=
 =?utf-8?B?K0xCbEwrY2VENG9nQXZDYjRrZHdDWnpsL0Q2Z1BEUktybmIxVkdURFZ3bmNX?=
 =?utf-8?B?MHZNTVg1SHJXdWx5NHN5Y0xINEsvbGltY0xiejVpQnVaVG9qUWUvWFJlNVI4?=
 =?utf-8?B?TFc2TVFtaE9WbzRBU1F5UThvRnhZeWt4eFVoYWI0L0t0dVZRYWRMSERmMlZM?=
 =?utf-8?B?bFArSjVicVR6Sy9pZ3ZKWC9naVRVWDdWSktHdGtQRnFZalY2T0JqS0k3aG5n?=
 =?utf-8?B?K1QrcVV2UXFmdStucDhibU5FeDZoRmpPRmpiQUFkY0VsSjhuREU4YWJZWlpF?=
 =?utf-8?B?MnZpS0dCVnoyU21memdobE1QME5ZbkMrV2w4VDNkTEswSUVabzJBZTJHY1Rt?=
 =?utf-8?B?aVlMOXptN1k1REtvL2x0TzBOZnJMRDVKZ0pOMnpYYU45RytBSnNhZHcybmxT?=
 =?utf-8?B?dmpQTTY3bUc1eGhZUzF3QlRiVUpQaWlRaVlrTDdKMmRkcUxCRFRMekJndEJv?=
 =?utf-8?B?QzUvb3owRkJNM093LzJrVlVrajN1TllNSmlnRWNoazdZMW9XRytNN2JtZVhV?=
 =?utf-8?B?TVhtZGYwSk8zTmUwYVNjS3hHR3JSTFdDek5YTitzQUc3dFp3OWtoQjFoR3kx?=
 =?utf-8?B?T2wzSDNRMlM5M041UlRic0FuS3hmOHY5QnF2K0VvTUlUUTBxbnhGSWNBR3pu?=
 =?utf-8?Q?JJULmNsd6CXyVkf1j+BUtvlPL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650de3a2-7f38-4f5e-94dd-08da65c8f416
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 18:44:59.1831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiYe3AujBX8exp2gVA/vZh01F8He8AIUnGMQVPgG0jsrYJ3VkFH7f33KlPd65KjIuFL0L1OFD1vw4sbwBRniaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1335
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/14/2022 11:07 AM, Akihiko Odaki wrote:
> Google Chromebooks use Chrome OS Embedded Controller Sensor Hub instead
> of Sensor Hub Fusion and leaves MP2 uninitialized, which disables all
> functionalities, even including the registers necessary for feature
> detections.
>
> The behavior was observed with Lenovo ThinkPad C13 Yoga.

We are checking for few things with respect to this issue
internally.

Please hold on this patch. we will get back soon.

Thanks,
Basavaraj

