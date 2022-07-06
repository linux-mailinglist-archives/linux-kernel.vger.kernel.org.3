Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5FD568752
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbiGFLvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiGFLv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:51:29 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDF328714;
        Wed,  6 Jul 2022 04:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEqG+jSytFO5CYYKqYEO4VxGmPwLwxODs/GGLbfwuiANm12PNF6FgOKqfWZ48/k2ITvGcpp5TnNHitZRKIm40iUR/V/ryfU3/5OjrAL9I3P26Ny80354kKOyv6FZ+03silkYpByKQggMQy8ol3HPZA1T/iZ3wgFB/WvzSWGR/3PQLMvZttiIog6Im1Mu7tzK+TOumrVvZXV0XTYErMNgcHRhaIpcwR6zZcjLzuf8srq5v07xJEz8ve1kzJ9iJgsHr3NCpFR9YNAR0XI/2qpkfET6EqOmsS3YdweOQF450juGfPDXAkv0+5kudnf9YoXG7H2i8AMkQ2Va1xyJjGLx2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xWzRtrWKFRYpw89gDbhArD9FHUR9yHjUrXvIoKYqd8=;
 b=W3IRhr/f/bzxE5hiLbR40VAxCr6HqUncda/U4hlPI8mP5PsYykEBIFr9t/HbBQ9PVz0wB9sPc/5GczI8YPcE5rUn8H3nILIEGAuAiE6v1URuAglu/JA1tKat2U2GhvRUSCaYDeMn3y9KbmO9rhvgo9rhzvFR4NZh12m6CvoNl3i8tcWcviJJGps91AiuGnZbKceRGb6UoNeZKVy8OKNsINVQ/y7/w+OV5Mq2atGqQLEvQjyRhqDSCKQiWUOjFQMS6UnyIc3ewaJiXuE8xHmB3DJB3Mf6rp8suE9kD8gVM/7f3amWg1sRVqYmyCs2tbSK3X7tB9r8JF7PV2+EdKMMDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xWzRtrWKFRYpw89gDbhArD9FHUR9yHjUrXvIoKYqd8=;
 b=JAIsfzpV7v835VmqBrviaSRMvji+MUtbrwbdOftVKsWI9SsDZ1cFqtUawaoERGMNgfHxpOUW+Y0aPFtiqreFHOpmuM/noA8rH1Ro/yYYECC5EGQBznoT57amPu8w49epJ1EM2cTWlk5L13gzKFvrRfNfBnSp6mz+iNVIq4aU4Uw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN2PR12MB4640.namprd12.prod.outlook.com (2603:10b6:208:38::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.17; Wed, 6 Jul 2022 11:51:26 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::447f:59a0:eb30:ec26]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::447f:59a0:eb30:ec26%9]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 11:51:25 +0000
Message-ID: <7e445f26-7c18-7fdb-8e5b-cc8694edf570@amd.com>
Date:   Wed, 6 Jul 2022 17:21:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: linux-next: Signed-off-by missing for commit in the iommu tree
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220627084115.559a257f@canb.auug.org.au>
 <84e26670-5e0f-61b8-8912-42bd048faf16@amd.com> <YsVVFkpB/HB27+gP@8bytes.org>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <YsVVFkpB/HB27+gP@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::31) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 406f19a5-ebca-41b5-bb9f-08da5f45dabb
X-MS-TrafficTypeDiagnostic: MN2PR12MB4640:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PNibCY8ljOs/MwJ8U+OxtV+tcynjTOjxmY1t+PzKlTi0uDiUUjfy1apvjFZ0eQn8wwmE9ItB0R2fSs5x6hl4l1Z4yq7gaBOqFyZN/P/7xeIR0UbrQSEeE42Th5zojDkMwApGRUwC7e53QsZ5A5RNhyoEAw4fdFoYegrCemqDUadV354xTndJ+bdu6zvf6epMAg4Ac0gn7nh1c/mZjMlwnWytZNrXebhi+QTvs+T0EU0mdRgX+hJgFR3P0qmq1gTExluPz6YxTSPgh+eswtp22CZ0rtgoxPXgp9LXN6zIki40kUHA8hs9mopT9F6D9JWRwcKfus0dNyIDIyKR2iFh/o8nKesU227VlgdxU6ln6uhoSIIs7W1FvnnCASZMzA/RmZnZWor01VuUaks2/8PkHcR33EROJW4JjvXu87SRpoPfzHmalu6SfUzss/Honuu3G+JFS8sy62cFeiRWGPNXbuS3OQntUaO/dSePSELL2dmaJobKkoAR06ztwsEGntusM+1bMDeF5zcdibU5zu+UeGXQG34fHe7+VA+zxuR8I7a3NofDiKzhTWzWlI8dHCUbiBpkoV6D84b11juY7JYaMNA6FJwk1mVRZDJ+nom2WwmhxyPII6QNlQyYEpZH0sUoSsX9tZj0NahT3m/btruXprmg0kHdkqO2hH/aFbUoI0gZkXb0immFgnD/Do5Sd8LdpXY4SjEd90QTL23XcjiFk6eK79veuS5qwgUf0zGNlb9eqNRU8JsdRaqJiARx25WdcmWpmNjeabagCDtJq4J9t5UpzEMBXXGWtS50YDJF/OzmEOo2DgHvAP8KBmREEr2Vx5tPFxKgAz+PlZ8Gha66tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(31696002)(86362001)(38100700002)(5660300002)(4744005)(8936002)(44832011)(6486002)(2906002)(41300700001)(6666004)(316002)(478600001)(4326008)(8676002)(66556008)(66946007)(66476007)(53546011)(186003)(26005)(83380400001)(31686004)(6512007)(6916009)(54906003)(2616005)(36756003)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWc1WVVYVjNaeXJOd2FpQXJtODFMdEJzZGhPOU5NaXBGVFFaZ3BKV1phNW9w?=
 =?utf-8?B?UmtGUE1MUm8vdDZzc2dJa2c4K0s2ZkpFNzg4ZWV5YytZN3ErYmFZUWJ2VWpq?=
 =?utf-8?B?NnpjNzZack54cGpiV0kwUzZ6cXBNcnk3RkpyTHRoVWowK3MrS1JVR3VpdU54?=
 =?utf-8?B?Mmc4WVlwYnppQVJ0UnRlbms5NVhhV1F1OWxXcmQrMmVMYVhsZG44RXRVRXlQ?=
 =?utf-8?B?YVg0Sjh1a0hCWWdlVEVRUUdWOHREV1kyeUJwVTRsQVF4VmQrTTFaRVBybnJP?=
 =?utf-8?B?ay9PcFdNK01vSFdhME05T2VwZThrd0lsYnBZS0ZPK2xUdkZwWEtxeEQxOXhq?=
 =?utf-8?B?aGtuYjZlSDVvdzFEclBwV2FUcmtkbDhNYmw1Vld5SE5scGViVGlHNmNJdDN6?=
 =?utf-8?B?MXpkQThlS05KODlVMGtaMXhKZ3ROZFVVWEpjbndGYXRFSmxKM1REMWlzeG1H?=
 =?utf-8?B?Z3pHVFAwK2p2OU5NTThCNFRMVFpqWW5tNHV6NXhTeEdlWFNyazRraEpxTGRk?=
 =?utf-8?B?L1RSRTh4SWFHZUZpbFZOc0tMdHlVdTJRaDZxak5PNWFEQkxDMitNSkgvY3Nz?=
 =?utf-8?B?dW5yYm0zTlljS2p4YUphZ0RVQ3kzMDNqNTdkeGtmMGFPTC9DSXdsY1ZQTE9G?=
 =?utf-8?B?MjJVQ1MrMVVtZlU4YnlVZXQ4bmlTYWRtcVFNelRRNFVTbWtaa0dHRDI1RXR4?=
 =?utf-8?B?c0gxQTcyV1FVcURheW5uSHFIa1Qxemd0bjcvYkErK1UvTG9iRmE3ZSt5Zkty?=
 =?utf-8?B?WEZFNVpIOFJsMFRqZzNYSlBvMEdsb2NhNE9PT245V1d1d2Noc3M3bFY3TXMv?=
 =?utf-8?B?eTQzcERTY29vM25UZlo3alFJSHRtU2RuK0tBNXI4Ymw2TGRxSGNsQzljeDVz?=
 =?utf-8?B?cWwrcXBlSm1jVndxbDBlSkVsZUpuNVBXVUI1eENLZHpMSUo0bW9SUUI4ZWph?=
 =?utf-8?B?czdjR1o4SloyNGVsODR3ZTl4M3JKTG9iSSswSys2emZBYldDM28zZER4dmZn?=
 =?utf-8?B?bnV3SWdqY0dBSEhScEJPc3Q4bWlBK1NxTWlUdHNXOVBvSit5NGVXQjlsK0xu?=
 =?utf-8?B?K3A1T3BZZDVaTmx2c2hBcGEwbkZNejlMMTF5Y0hRWFplSXQ5RWJDMnVWYXRh?=
 =?utf-8?B?WGlRdzFCVmI5aStRbGdzMTBSYWdEUXMxb2M5YnZERHpFQkxNS3VYNFFYdk92?=
 =?utf-8?B?MlJzTEtwRGZXRHJXdEN4aS9iU0pEdnIzaHo2a3RGRGFQVWxZSnM1VVdIdEpR?=
 =?utf-8?B?QXNHNmlPODVaS0FJeG0vWmNBQjJLdll6Nm1SQkh0MHp5RFZWdEJMKzJYS0Vm?=
 =?utf-8?B?YTNxRUNYS1NjSXhrYmNTQlBvY1JhM1NVYXhyQ0gza1dzMXRMTk1sSkUyY2RQ?=
 =?utf-8?B?M3NBcjR4cDFFNkd2cmI2MTlWSW85NXd0ZGxvdjdQNVRmSEt2MVdXWG9VaTBs?=
 =?utf-8?B?TTRwbVFYcHo5Y3Z2MlhWdGdNQnVhU20ycnVPeEY4QVQ0a0VMTE9ZdmxLNksx?=
 =?utf-8?B?bFI2Uk03UEtieHo5d0tmUmx5N3NxNS9XOHhSdXNyZEMzYXJHTkt4dUFaOHNT?=
 =?utf-8?B?bG1hMWZpK3hGc1VxWjUwb1BYTG9QbVhqQitRaXZuUmt1UmVqc0xwTkMzTGRk?=
 =?utf-8?B?WXptcTZOd29oWEx2YkVkaE1NUGdlS1psQU1VSWJ2d3BTZHc4S1h3RWgzUUtx?=
 =?utf-8?B?U0RsclVRemtyanBCYStST1Uwckd6RXhlNGV1aDhCUmg5N2hEdUxtMjBkcHRj?=
 =?utf-8?B?cm5EQXIyWVR1dll4SG1HZGhGNzdxaGZPUUxNZzhoZUFIYnd4dlc0dzRhRkxh?=
 =?utf-8?B?c2hOSlJIcE1lZU1qSFREMG9SZGZyejc0cFROTTJpc1ZZaXJhcG4yWGxKQlYz?=
 =?utf-8?B?WFA0TmJQL3lJM29yc0M2UE5jRXY0c3VhMklBTm05aUQ0Tjljb1JrZmoxakZQ?=
 =?utf-8?B?eFRKbFJldjNoZy9ObFpWc1RRUzhvTDdLMk90dEEvc2lIV2ZVb0REcDdHRkp1?=
 =?utf-8?B?N2wwQnhuVE81cGtzaUh6VHBKMnh5SWFLYjF4WVV5akZVZTRqWWxXMW9oSTFU?=
 =?utf-8?B?S2k2UVFxK01sajhpZm90NE05MEFBSGdWRlpEbzJJS3l2akJuRkJhWHpXNkt2?=
 =?utf-8?Q?4wdROrarYOpgQUeRbvDNUroF9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406f19a5-ebca-41b5-bb9f-08da5f45dabb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:51:25.7073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Evp5X64O0UqL/7SA+Z3rUK6+ir3uCGSqHl+i6WFpvCgstnjNinww7xSyi6PFhLBrm+BURn32SV9Zqfdsh+PZKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4640
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 7/6/2022 2:55 PM, Joerg Roedel wrote:
> Hi Vasant,
> 
> On Mon, Jul 04, 2022 at 04:55:28PM +0530, Vasant Hegde wrote:
>> Sorry. I didn't realize mailing list is changing "From:" header. Will you be
>> fixing it in your tree -OR- do you want me to resend patches with updated
>> "From:" line in patches?
> 
> It is best if you could re-send this with correct From lines and I will
> apply it then from my mbox. Please Cc iommu@lists.linux.dev.

Sure. I will resend and copy new mailing list as well.

-Vasant

