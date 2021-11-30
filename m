Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0F5464121
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245172AbhK3WRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:17:08 -0500
Received: from mail-mw2nam12on2066.outbound.protection.outlook.com ([40.107.244.66]:4592
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344510AbhK3WOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:14:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/3n08npgAG7c+MTXuMFMgMqU1dLvWRNfwHnsy0cd2FgSNwYv4hQgGifQ7c+jpyYvbfb0GCK7mZNmjYMHgrlvmr35KFmakEi/yTQRG42nRCTcd5e6YdgoOfwnTDRBPuVlbJWXc+PG3BR+uwdOkPPbfkp1EdDhtTmf9Zcs8rI/9YBHxdX2RBgFy34UgiCW+Gl5g4WlbWG5vD1mCcAeE11uxkNSU8bkF0YNSPx6o8le8UQG97tI2sYh1cUp+FYgcNhuSryFjBCOC+wzdFXTIagPv0/XOmz2LecrtZxdYXCVhq55cor/5poiRk+35FPLpKwGpp31OV2w2/8lazCVNUmJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iay8JibKOF9v1W4HzRRPNDDs/pi4dXt2sICi1+VLzsY=;
 b=PJ+/aT7uLNZ0H0DIQvpvOpjud1HGRBzUYr7jkCzt49Nw2qMButO9rjbZnYI11rM44Ft/UEQYhXvudlL4TOjwQqK6IbLBzebjteRV9ipfMKxsZ9Ko7hyZ7MvAghMKup+dsby5YqzVgEb/1WZCrHqEIXRRBL8BCUygCNuUFVOFjgR+JWEzqMxnJPd+yzXeKGaz3EAByAA63gXR/Co8X5gF0cT4Z/SqOhJwp9sXvlpVGXg74vJAzb96jaSH3crZYYV7yzlHEx8FsZwQoEaAT8DovhdxheRC2d0ZfJUBOmAZwkWvw1Sy2LldQYMGbqH0BcEBq/L7AXG9ycN56Yvi5aKT6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iay8JibKOF9v1W4HzRRPNDDs/pi4dXt2sICi1+VLzsY=;
 b=KIrOb/MBTm5IjdS8CBDA60PwkZj37+FsTVeLv82R1VD9fKSRUQ0kQUMX3jHElgOkNO4MEpTaBSjmXFOAph50k1F6WX8YsiUD/U046Z5jDhskhTdg8jD67RwwQ1WOlAmgsrWxWeMSVDJN7gutCX8OkPSixAUNxwEM3JsjU8VvVRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5341.namprd12.prod.outlook.com (2603:10b6:5:39e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Tue, 30 Nov
 2021 22:11:26 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a%3]) with mapi id 15.20.4734.020; Tue, 30 Nov 2021
 22:11:26 +0000
Subject: Re: [PATCHv4 0/4] Add generic MMIO instruction deconding to be used
 in SEV and TDX
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20211130184933.31005-1-kirill.shutemov@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <7fcf374d-42bd-75e3-3d14-2b8b59378715@amd.com>
Date:   Tue, 30 Nov 2021 16:11:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211130184933.31005-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0009.namprd12.prod.outlook.com
 (2603:10b6:208:a8::22) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by MN2PR12CA0009.namprd12.prod.outlook.com (2603:10b6:208:a8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 22:11:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5db8c883-e8af-40fe-c9d3-08d9b44e59e4
X-MS-TrafficTypeDiagnostic: DM4PR12MB5341:
X-Microsoft-Antispam-PRVS: <DM4PR12MB534192B238DB74B155CB882EEC679@DM4PR12MB5341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJoiBQ+e1h6tlnm4hh9ZX8S1Po35IKyBFCWlsn0YDUdxfNjyzfYdYwqh8l60yo19uBvk9fBVVT/2qh2F8uvRyT2BeRFQYBZPvxNJZAMZ+XEU/8Hqx5ZZmmm3X3cjfjRiQjcxjQInWPCbyHGoDJKOYxBEyORZnO02xqyJHTIDwraRaW4M3IwA6o84TAs0QA5eIazcSEG7NruME5NX5Q5uiYDIAJw1+8+/hsXBxAuNOhSG+aZxComjomOQDFHCY2rymhcmtAWyaJWviQJc7eCOpYslxPUZg6rAAr39DukyqehqZBDENTkUTEmcFcdUdT2RLHLEDV0dI85OFIjgF9RpjLAIgYS6iX7Txb0qomEkzAshMp0V/dj/ozQnwS+oYmcJ+odfPHyBp44XYmhb6rsBSGjDdlnr+I6VzUMc13BtwitlN4CzVG/YAyduZjVKq8IL5xgs6sm/Wjbg1gZQ8WhkOBgwAbwRilSiZ1y/zCRTHrGbeNYFsSGi0GSu2SxUTtJJGNyCpOSfOc9XWER18CFO6z8t+UcaprpaoiJLqcuJDEs37UD46mHBdAF0+wtEybhA0yxGMPH/15Ct8HJH8tIBIT+3jePwHzpl1KWlBKoSXcEmkXy+C8Tta9akNkaySB2DzAw+JudA7wMu25HzUFYZnFsNouI9xkhRpb+5v/hjHtXnCHCpsy2z6lvfBlB9GzNuWU/9GCudpPG4wruvNioIYD1o4+svGwXq04vg7321gAj0f9M/PNl3ROfDgoWrvip9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(186003)(31686004)(66556008)(83380400001)(53546011)(66476007)(38100700002)(31696002)(2616005)(7416002)(26005)(508600001)(5660300002)(2906002)(8936002)(66946007)(36756003)(86362001)(54906003)(110136005)(8676002)(956004)(316002)(16576012)(6486002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlN4THNyUkx3VEVMWmlKRVNETmt4Q1dLSWp4STkyMzlvaGhoSjVxZlFnY3Fa?=
 =?utf-8?B?UWxGMmVxMG1QZ25JME5uUlM4VTRLYVMwOFMyY3pzdGtJMnlWU1RNYU1TSkd3?=
 =?utf-8?B?TVZ0ODdDemhMNWZHTWdoUS82YmUrOVpjeWxzcS9jcmN4NFhGcDUyMDN4RWpB?=
 =?utf-8?B?K3dPS2xJeDU3WldBbW5TcTRLZEsxQmt6NjBGeXlra0dKTkxVUTkvclRieGFv?=
 =?utf-8?B?bnAra3E5VnNNWVhhaGJpWlhoTlRxNDF4cFFkaCs5ZlhMQ2ltTjRSZzRwQ3Q4?=
 =?utf-8?B?NUpSZEJPUnNMbEhtYy9XV1k0ODQ5WmRIQ21lS1BXRUJMdmhTV1EwY3NSeU1E?=
 =?utf-8?B?TkNUcHphc2lNcXJPeklkMmw5ekNNRWI2N2QxYWVldWc3WXNwSlJuSmNtVmVL?=
 =?utf-8?B?NDNrSTNaUWdFb0h6YlBtbmxISUJRUmV6NHFXTnJPamZReU0vM3RMdHF6Vloy?=
 =?utf-8?B?bE53Y2M3MGEyK1dKYzdTLzRWM09ic25ScWQvazhXOERVdjhmWDlqeXRUeEZw?=
 =?utf-8?B?NjRLZXd0QkxrWFBGY1RLdnhrUi9uenNZZ2FlYzdFM3NwY0kxbWREbU1qN2Jk?=
 =?utf-8?B?RkkybW9QQkdPb0x0Vi8vK3YrUy9LSkZ5NW9ZSnV6THllNDliVHJkYlVvcHhL?=
 =?utf-8?B?ay9qc2JPQi9ZenJFK1k0eUhBOEhzVDZjcnRwb1hJNUI5SUN0ZUR0U2dEMmRx?=
 =?utf-8?B?RTJHZTJwSXV1YzBITEMvZWUwbUJ0UHJ3YWUyNURWM1ViTE9aVDZEZUJYZ2hj?=
 =?utf-8?B?MUZhVXB6TEY1RXNlWTVDNlNIdUN5Vy9qa1pMNHd6RGoyNTl2WHdTem1lRnJC?=
 =?utf-8?B?RWkwZ095aGhEa1hVYnE1L1F0RFUvZmREUjlzbHJ1Z1hGSUVuc01vNmpSS09Y?=
 =?utf-8?B?eHk5UWtudFcwNVNNenhYUkR2ejlTb0NJa0h2VmNHZ3ZIRi8vcFNZVWE1YVdh?=
 =?utf-8?B?Zm9rYTI3UVNycXVhQjNTQ0lmQjVXRGcwVmJrakFLZGtRc1hiQmNuNGExdHpn?=
 =?utf-8?B?cXFmM1FlcFdMbCszY1lxYXRsZnBtUmdQT2ZwQnNmeGFLSUgxNWxPT25vdUll?=
 =?utf-8?B?L2JZZVkxdmQ1UGoxMXZGVlFjRHF4RjE2bEpSZ1cvTTlXUWxpTktZdnJQSHor?=
 =?utf-8?B?UjBjcDRFeGprTGVidGkwcDZva0ZZNjMxWUdjUXNhS0NYWTVDK0RtYjBkOGU3?=
 =?utf-8?B?OTk0MTV4dUtQUWpaTlpLRTVTTTYzS1NPNVp5akVwcTZXM3ZZVDRXV01QTkZz?=
 =?utf-8?B?OE1DVk9qeWpFd05PSk9YV0xMM0ZCNFRTNXpnaHJXeG50V2hhRE0weDJMVmpT?=
 =?utf-8?B?UUg3NHE3elJIY2xzbEdsaUV3YUFmcC9qZkhVWWZwcHhFaGRyTm9WMkNla2M0?=
 =?utf-8?B?NGJMWGNoTEd4ZitaVFdIQ0hMdW1jVzJLQXZ6QUlWdklWOUhmV1FMeEVIZ2VT?=
 =?utf-8?B?UVdUd0lFVzNOMFJlTlpJSUtWYzRhTlNxaTVwYUsvT1FhTm5DcE5WQWgvNUha?=
 =?utf-8?B?amVZRHVTYUhUOGJkVUswWlY2emt0bGVITG1VNVRETitiQU02Y2hsMzhacGwx?=
 =?utf-8?B?bFVTVXZmZXhwTE54WTEzdDZiaGxWbU1zbFU3clZmdktqWXZMYVNzL1FiQWV4?=
 =?utf-8?B?SHh5ZG9LTFl1RGJIWDBxQ0ZKUXRnYUpVNm1pYXUvRVRjaFI3Tjc2VXppRnlv?=
 =?utf-8?B?TjhNcGRpcmtTc2pNSDdjb0ZLQno3QSsvL3lsbG84Vmt6Ujl0c0xsY2d5ajFa?=
 =?utf-8?B?ckMrRy9TdDJsU2R0b2kzTTI2UXdkNjZmenpuenI2ZVhNMklwR2VSbStXc2NV?=
 =?utf-8?B?eTd2WFJCNEhBbTdTZDJmMmdOYkRrV2wwbXFYZk81SDhvTGluNW1WTGY5T1pD?=
 =?utf-8?B?NEM0NlFuMGhINTZQcndtaklHL0pRUjNwd3JRam5DbHBMbVA2em80TXBBclFt?=
 =?utf-8?B?cm1DemF0TzhBQ2ZHTnNXK29OWmhiWWw0Y2pETWE4TXM0cllWU3luTGtwcVNJ?=
 =?utf-8?B?VytNdGVBSytNWnljQTgyYjdBVVo3b0dQNGoweXBLaXJLbTJOWjNSMHVVTDFq?=
 =?utf-8?B?TjdXT0V2dTZNQnp0empxQk5IUjJGajlDbzFTYlFJdHZGNUVUSlBrd1grU3Z2?=
 =?utf-8?B?NTdIR1lHK1YrTjJKYWdBZjYyNGIyMHZGUmJjbFVOaTl5cmZ6dWY2Q3l6S2lr?=
 =?utf-8?Q?4TjHFwUdGedHeq8B0Fo6qyw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db8c883-e8af-40fe-c9d3-08d9b44e59e4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 22:11:26.2691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKnGucuhrko8c7KJRuuYGYFw6rfODuv4+x4WgYlm61IpooQBpf5PBfCYmbrqdLSn3xHnDJkx+ppDljI2TyzlZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5341
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/21 12:49 PM, Kirill A. Shutemov wrote:
> Both AMD SEV and Intel TDX has to decode MMIO instruction to be able to
> handle MMIO.
> 
> Extract insn_decode_mmio() from SEV code. TDX will also use this helper.

For the series:

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> 
> v4:
>   - Use enum mmio_type inside insn_decode_mmio() (Tom)
>   - Keep a comment in vc_handle_mmio() (Tom)
>   - Tested-by on AMD HW from Joerg.
> v3:
>   - Handle insn_get_opcode() in is_string_insn()
> v2:
>   - insn_get_modrm_reg_ptr() returns unsigned long pointer now (PeterZ);
>   - Handle insn_get_opcode() failure in insn_decode_mmio() (PeterZ);
> 
> 
> Kirill A. Shutemov (4):
>    x86/insn-eval: Handle insn_get_opcode() failure
>    x86/insn-eval: Introduce insn_get_modrm_reg_ptr()
>    x86/insn-eval: Introduce insn_decode_mmio()
>    x86/sev-es: Use insn_decode_mmio() for MMIO implementation
> 
>   arch/x86/include/asm/insn-eval.h |  13 +++
>   arch/x86/kernel/sev.c            | 172 ++++++++-----------------------
>   arch/x86/lib/insn-eval.c         | 109 +++++++++++++++++++-
>   3 files changed, 161 insertions(+), 133 deletions(-)
> 
