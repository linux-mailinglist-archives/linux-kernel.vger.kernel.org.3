Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4B14F51F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1848995AbiDFCcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388230AbiDEVxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 17:53:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641EA6D192;
        Tue,  5 Apr 2022 14:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdQzlQN1xlp30ytfTiFYeZwJx26pUWTZDFNfEbbj9LW3ql3M8cMRFSAyYEIIKkNFpTu50vRGv4nDy4evzmFngtKXdAX64t1fUUPWq1EARdt6RZIZRCDio9ZkWhGJVQaJQZjDnYs6rXQuglmJ8LZMGg8j8VK47EhI9aWqpKxv1gYZ4Jz09ZuZAguQybCvvsttAns2wxzTIxbCRDvs0eb3r+nPfKV+nKnqG1pYk7K6K+OdFFrX2vg0g3lYLUPRwaEhmJFoqoY5mmd/TcJW5hYX/WZDxG8dRyigoqJNARXYzTOv1M+Nawn/s4Lo6F/hwZYHOfsO9KM2ZDWEpET2OA15hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UW1Yfs24V8bZknxIXrxavPyzF6TAomdnVHdkxjr1qbo=;
 b=B645fwS70G1fdzX/Ze/Gs5nZsDIKyA+RzQkPSEiI1uqaLYASh2G8GSNsOTlF50GTrT8X6Ez0LiuxDGMLVlK8RLBLCFVXLLDjTyLDAuWngGyhDXUbhPt0BMkaG34ubs5THev5o7wSuwt+DjRspIL2m/Gs8nv0gAHIba8osFVXyPrxHeK9XG9g8QghrFNX3lYcpYsS2O1lGdaD9w7xSkE7KNol1JfRj7GevweQ8w3Ufymd2Aesw/ulX9XvqWSj5jrWacU6eLHmw/ZyUsKgdWmr5bWX9Yaa2PvrhPR7M5h/mV+jiEcYB9gPvo+X4takYzF4kpR+++9fuXEB9/cvZS1IbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UW1Yfs24V8bZknxIXrxavPyzF6TAomdnVHdkxjr1qbo=;
 b=1NnvQ6luIeJ4CEE7eYS26ieqVpVKY23nvPPjTYSRz3fKexEgKMI+VZNWjRlRLFHqcTrpxc2UY9lrPF5zcqQ9djrs7iCPKcwu8GqEirD8YVzyvuwYrDiPIoJ2L44QSfpfkCx8Hl67aWvYJhczF6i3gIBOssP5tNNz6LULIMaLQ9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB4880.namprd12.prod.outlook.com (2603:10b6:5:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 21:06:53 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1946:2337:6656:ae2e]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1946:2337:6656:ae2e%9]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 21:06:52 +0000
Message-ID: <a20da39f-845d-5b63-6efc-53d91fe86278@amd.com>
Date:   Tue, 5 Apr 2022 16:06:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 4/4] crypto: ccp: When TSME and SME both detected
 notify user
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER" 
        <linux-crypto@vger.kernel.org>,
        Kerneis Gabriel <Gabriel.Kerneis@ssi.gouv.fr>,
        Richard Hughes <hughsient@gmail.com>
References: <20220331211213.2844-1-mario.limonciello@amd.com>
 <20220331211213.2844-5-mario.limonciello@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220331211213.2844-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0082.namprd02.prod.outlook.com
 (2603:10b6:208:51::23) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 557fb6f9-f3cc-46a6-6171-08da17483562
X-MS-TrafficTypeDiagnostic: DM6PR12MB4880:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB48804FEE1C6468FAB53347FBECE49@DM6PR12MB4880.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJLGE2a3P26wc+cY5mFSukOZbGiNuF7OiipdARKl/duvoZJx1E9S/NJVsIXee0WFV4h8cPoWKHnnjkKKWsxx7B6g/huCOr8rMZYHJk2IeCio/vSo7tKWP7K2AWnUQiE9ffae68rjWObSXgtNzndycvopebSWj3PEmgtNEw+3M/LYnZ3gAyC3RiF7d78DUqDgFQcGpk5LlJQ6KC7+3EqssLXGKlvOxjr+SpSB6lMHOfr0rV5IiRaFvZZv1eN6N8y9wqoJZp0W3jsQiHMAh1oFEZJxK2JinpLBnUU3WdVfhvGeXasjJQkzZbk05iFfhojQdEsv8KzvG5t7Yr1oCvm+dZWCJfbAyI73EpkXFR/bFtbX+8j7IXfUmyHBeDzS+s4eYda1oZawNFuPXZ3GZhgPPtPgTcP3sms3dOhQwSeEUf8LKWvcr6NMbL1VGFAMmfzxvyMzgzrghE/SkGyXKQ05EGIXyn+LTNeRpbvx6k4xYXwDDzFjgekzaiVEWXjsveUPXVOJgOsQ+dsLbnX2Y0EeEmemLELWKZgkDcZ2a8fepcRFsm8enENBDoY46ki7S29RagYlpAjDzpoBbUJEJTSSQR9KLdnJ4QGLJlbRitJmzZ5gPJg0NVJt/tW6c0Egb1uffMPLhBC/FOvBep0od+mkmuZvf7Sh5zDoYzK7BCgQwwYEaFMKePVHzb0nIFf3R+Tn7HB1qdFowovlz8Pwv+OJLBX9QQD3TI+xAgfjIA+xQchQkQ3TD34NGdIbJKfyh1C9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(2616005)(6512007)(6506007)(4326008)(26005)(316002)(86362001)(2906002)(54906003)(6486002)(508600001)(110136005)(31696002)(53546011)(66556008)(66476007)(31686004)(36756003)(66946007)(8676002)(4744005)(8936002)(83380400001)(5660300002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGRORGd0OU5xZ2JFNVorTVJaR0VJZXByZ0VTTld1NXg4bnRHQTl4K3Q5R1dk?=
 =?utf-8?B?QVpZWHdxOUY4Z05hcGRteGkyOXc4WWhaUmpld0RPTEpWUVh4ZTVGeVUycEpJ?=
 =?utf-8?B?M0E3TGl2UFI2M2ZndGRHc2drdVgxMGpuUGVwRFhCYzBHaGE1VHRQYTAzMi9U?=
 =?utf-8?B?cjFySDJVZnpTRkp5dG1HWkd2M21nMW1LdnBBa2w3N3NQMjhkWkhBK0RmdjBL?=
 =?utf-8?B?bGtKbFJOV1Y5K3QyNzNyY2szdUxmNHoxUWg0RkNMNlo3K1VOYzV6aXl2eCtD?=
 =?utf-8?B?RzBiMjhUU0plRUNKK3JTbkU5QVNWTFFPdHN3SGNqUUt2QjdlWXhUYmFVRWlH?=
 =?utf-8?B?WGYvbm10MWhaek9VZElsZUp4UWRlUnc0NExBNVh0VmNoYy9MSG1JYUFZR0sw?=
 =?utf-8?B?L2NYRjgwY2ZsaUtTQVdlNUEyaHUwYm1TZzhUZnlzNklRQWV4SDhvczI0Y21n?=
 =?utf-8?B?aEUzSTc4YzU3amJGVXVkeXB3SDJwMlJ1KzFjaXZsMWYvV3NacXF0ZGVEaWRq?=
 =?utf-8?B?RGdRVzhNY29NSDJDQzZlM0cralQ2TVpNc3FxVmtnUXRKMkFFa25rVEc5cGNL?=
 =?utf-8?B?VFBJMVkvT0R4QkhTMGVuYXFXZFJpY3FFdS9tMDVTaUtzc0Z4WEQrOFJ6NWpC?=
 =?utf-8?B?czBkd0E4dUhMYnJxWjU1b3NFeWdncVFlN29BZmFHek1JK3V3M1Q1K0VWUS9L?=
 =?utf-8?B?WXZ0enp1cXhQbDJ2S3RMVGR3ODMxYkdaejJ6MURCOExDNCtzOGJrZEJTKy8x?=
 =?utf-8?B?VzZnQWdTdXoyYXdva0E2emxIQzd4VGljd3lYM0w0UmZNanBUUnhsSFVxbENX?=
 =?utf-8?B?c2szYXRZOEdVdWkwV0M2TW10cDZ2djBNWFJPZmhpWlgzNnplTlEyakZJY2M0?=
 =?utf-8?B?TklLbkQzaXFsVW5aODlTM3F3Zkh4T2h4UHIrM3FwYWJ1TXpvcXJ6bHI1RDlu?=
 =?utf-8?B?bFV5c0trNlM2cjVKTXRnS0tTN2xhdUR3QzFyWWxtT3prd0FqM29DY2NWUmNB?=
 =?utf-8?B?a1lnOGRnYWNnSDBBYW5IWXBrMzNyM3hnczNhZTVHR1d1Ymt3Q3dLbnh4NzdO?=
 =?utf-8?B?N0xLcTFJVCttbnhhVUtNUXlCSHp5NVI0RW9vTmpldFBCdTE1TDdjVGtmSW1F?=
 =?utf-8?B?Tkhlb054UDdKdzZoNzN0QXdCOEViUnE0VFdWZ0R3VU14ZElHZHE2czVFVG1N?=
 =?utf-8?B?WUhYQWYxOVpyWmltWUdNRU1VY2hScER5SEprbHhQRWZIcGVlTUxFK1M0MEcw?=
 =?utf-8?B?Uk5Mc2ROaXNRWjlRYmpjZGl3NXVKK2pBRkUvZlRFR2hJTU1maUNkd1Y3cHZy?=
 =?utf-8?B?Ky8ySVJVdi84SVJyenNJOFp1elhSck12SUlDdzl5WUhzMVljL2JxVmVBQTM1?=
 =?utf-8?B?dEErWjlOczlOSFVmUDRIcmc5R3dqeG9tODhyV3Qzc2Ftbjl4R3JtTjY1MWFo?=
 =?utf-8?B?SU9zSWdnNjRxaWZZNHY4R1k0ZWYwQVEwMWttU3ArOVFENUowY1RWYm1ZZE1s?=
 =?utf-8?B?ZVg3d04wTlpSRFo5djFZcExJd3dPcXBRRlgrcGg2UDNSb2RpZlpzOXNQdDhR?=
 =?utf-8?B?N3dTYjNubEgxVm5EUUV6dzZnQzNhcUhmdDB2ZEZTT3dURDF0RFNUQlc5OVl0?=
 =?utf-8?B?b0tVQlpKRGpSN3MvUkFwalluUWxidDdCMXpDcGMyeWNrYWE2aGY5RHlZcVM3?=
 =?utf-8?B?aGdkMlRidWp2Zm9lSjFyVktGYVJ6OFhScEJxblhvYnBKK1NZbmF4MTZmK2c3?=
 =?utf-8?B?SUt6WTZEb1BTc1pNakUrLzZTUE9sdXF6eXJTT2lRRGR2aUk5SG9ORnh1RGhE?=
 =?utf-8?B?ejVaS0xqOUZVT2syaWNMNnBEbEFsQTdDR2xkdHBJc2dOWkhBSXFhUUVCdnhG?=
 =?utf-8?B?bHVMUlFPamZubmFDSklqWE1JQTdRR2VGdWQxYzZsT0l2TEpzaEFKSmgzS3pN?=
 =?utf-8?B?NVJBMmhEU0diUzg1ekNwUmYrZ2d1VGNpNE56bUhKZzgwN0hKV0x4YlRQNUow?=
 =?utf-8?B?cGo0cjA0SnYybkNoVXpnaVRGTGoraHNkZHJ1cDJhR3A1WGdocWtwaXljSXN3?=
 =?utf-8?B?VUJ2a2xpMEdxNjJpcnhxVmJNcmdoMVlOMU9JeVNpU2FGVlBaSzNkc1pYNGx4?=
 =?utf-8?B?OHVkVUdTbHEwUzQ3ekdwTndUZWFTRkRsM0FpQm1zeDhVYlo2QVB4UGhVakJR?=
 =?utf-8?B?MERheGpyZHRUa3RnM0pObGRKb25NNy81cjlvQW83eTBMVkNrRzhzd25NOTZC?=
 =?utf-8?B?UUJLSWN5Uzg5UjhuTVF5bzBWUmJ5YjFlQzJTbjl0K3NwRjZVQmd3RTBPZ0o3?=
 =?utf-8?B?ME9KOGMzbFZ5dEF1SlRLWjdpSmlja1UySGRLZThBdUxqNU5GbCtvQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557fb6f9-f3cc-46a6-6171-08da17483562
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 21:06:52.8632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXJbvv4Wp2MaCi4OL8fQcqyAGd7UrjgKk+7XY+BJzB/L1itq8Rv95W1SuNgehhZv2Fh7Jvbmx19VvyLKoUSm9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4880
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 16:12, Mario Limonciello wrote:
> CC_ATTR_HOST_MEM_ENCRYPT is used to relay that memory encryption has been
> activated by the kernel.
> 
> As it's technically possible to enable both SME and TSME at the same time,
> detect this scenario and notify the user that enabling TSME and SME at the
> same time is unnecessary.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---

