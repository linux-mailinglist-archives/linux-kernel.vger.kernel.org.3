Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C811508EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381316AbiDTRxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbiDTRxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:53:21 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C533381B7;
        Wed, 20 Apr 2022 10:50:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MM+OYq6ZInIxxs/nmQhjh3ZuaL+YrzML7FS2kK+HxV2MXPqVAWxgAKD2yhQqmVH6sFEjTk3GQQTU/olYQ+aBkZkUDRDFbaQk2/OIUTDnOdZ5hxnlOLg/cXV0d6MjEMissOoH3TwpxI3sCXrmbMBuL/EEuH+H4kgW1GMf9oDYmY9qDmHqRn4OGyN5ognlutwX4BavUX+hlO3K4Gtcfv+XXAxTLtu5eRZBL1l1nZ2f5EuKZyNOWW39VXtHUusFbAO63ztVVo9dVBwTR6nCZPbIbQvzwoVUemk/XMMvLuYl+2LqazjVcoBI1RyjOKrYBolZ1Rj2lkmJ/qEiEcyv7n+HgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9QnEBTtRlB27sQZ9Zu+9hAwVl77KojFR1eTiQ3I2GE=;
 b=Qgta9UGdj5RohI/IPb56XQ1QiRy+8EZu8nuB9hQEcUWcz4wANYMal4B8ZTLND1L5NKnwxtHL+uPBCmih3ICOfhphCn0r1HdTg4l7eZ1WTIM2PMxvlDwBUbslq3Ip8sKy46pZngI1Kxyjr5o3CWh40sQ5Nu46UzSG2k1Zvw+e6qkZAMjNxhXDLqDpcbg4qEIvdXbIBqsIIESudIz2h2kKr1tdnSvaHjSFleK9h+CoZ4InyOTL9GmtJ3F38T4i8++eeMpaGpXoc/PMprMkhe3YsVNXAo5RlqizbM7Lb8YT18zQmnWKIPSC+3APIM1+8JlnWG7FfgtUgSpoaga0WPeT5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9QnEBTtRlB27sQZ9Zu+9hAwVl77KojFR1eTiQ3I2GE=;
 b=KYG+OG+L2bBCW5/G9j59rYKVSyBXPAFy/kcXy8h9UL/waMNF66PC/q/TBKn40AbVbTMPxyR+fQBYNbntxoUckfwutVbOz677ZqYo14g5PLm7qJ7S8E724wECWnqRWR8of/xVpIUHufXyI5jhcuFJfqPrWtJmKk/zJHcWOdRKjCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MWHPR1201MB2525.namprd12.prod.outlook.com (2603:10b6:300:e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 17:50:31 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6480:2f5a:7cd7:e0c7]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6480:2f5a:7cd7:e0c7%4]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 17:50:31 +0000
Message-ID: <ef4e8730-5860-5e81-cd20-05caa279e004@amd.com>
Date:   Wed, 20 Apr 2022 23:20:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] HID: amd_sfh: change global variables to static
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, basavaraj.natikar@amd.com,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        nehal-bakulchandra.shah@amd.com, Shyam-sundar.S-k@amd.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220420142244.556429-1-trix@redhat.com>
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20220420142244.556429-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::7) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 388fe62c-ecfd-429a-b518-08da22f64332
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2525:EE_
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2525DAA531FABDDCD8D28D64E6F59@MWHPR1201MB2525.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGyTh4Iw9YAbq7JhFtDaOA6ojX+EB+1KGxMK2NPXDAnlFCpHoQHi7x8FPRUhxZi5XD1KDGxPyeJcRY39voUm5vq5TzHXCPIUBcvg8iWlSefKbDTHnr0GzFaf1O6oDj1FAkaWKg1P0OG8xhnECiPYzuulN0pH2+DSvsyUaKRmgzE/e5Oil2VaJ3Og9Ei5Nhy/pYvlbcny1RwCDO7CTj0TjGSR9XLrpVFOpe2/dzEWwd6N+2IHnFFaGjXDkiH6akh4MhNLNjC6L9VaTxjOn/2CTKPIEpZ8sLo4+QJfAJ3h+L9fOMUhfKogRsyY6EvlIOh1Jhg+yHiGXpPeqnCrsWc/6eL6kqr/JcG+1c/8ZDDXZaA3f2plkw0gGfgG7FWMxCRHPv61zwArqC+QdQd1Cfp9QnGgjawI9MIgLGuCalpu/GvS/yBI17vqryIaudl5Qs0mvrEcInxL8gz3LFFB0nDmOG+BvO3e8XkvAOPEwEZJVvRVRktDDXaqAQdPRvCyGT6XtRKC5TP3YC5a0xPHqUzoqCxNnYVIwmdxuNy9Su6Oo2U6wEBfUBGvGkgrl32YGoSAdGtlL22DB5U20yjWmikYJUYCu3bdZQrLanh2bPwY+GFpkddwcyNCkOO8KRSmVzLD85249+1yNe/BNgBL4U/5e8E+kOxN1oQ1oqv9clOxv7C1+F/NTz6dbMADWJPvjng3Ks2fGrIoULMv/3JYdQHnMcHgFhisDX8dN2M7YDN6Ipo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(38100700002)(8936002)(508600001)(31686004)(186003)(26005)(66946007)(4326008)(8676002)(66476007)(36756003)(66556008)(83380400001)(6512007)(6506007)(6666004)(6636002)(6486002)(316002)(2616005)(53546011)(31696002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGd0TzRMNUY2bXNjQWZoUkZOdU4valAzWDNYQ2JjVGk0VDFWUlNkOHA4Szc4?=
 =?utf-8?B?c1dHdUx6YSszRDV6aERDa0pQM05obTJNMUhDVTFFZEI5amRvbHRrRWM0bzNq?=
 =?utf-8?B?Q0NqYTFaVXlzbURUY0h0NXpPbG1OWkJnaTdBS1pETlkzWUtSdzNZSHFtcnlj?=
 =?utf-8?B?cDRnZkRLVko5eHhvNVdaemhLbHB2aHh3eXZpVlhKdGNMS0x5T3I2a0RnemZ2?=
 =?utf-8?B?ZXZoblBCV1pHUFBSVzFnQUhSUFZZY0JtNjcxU1FXRmZlYWFTY2JOWWVzc1pB?=
 =?utf-8?B?MmVmYzNNYS9sT0paU04vL0ZEZnNRYk50UmxKYVI4WG1nMHJxTXZKMTB2UExW?=
 =?utf-8?B?WVlNU2lHWFpRVEkzMURnTEwwYzVOSmFhVlIwT0oxSEVlWHJzeE1nOEl6dy9Z?=
 =?utf-8?B?Y1BCT294T2hJOENJVUtMRFljQVBialJ0U3daMVl0NDFRUTBJT0hGTlFDNk1D?=
 =?utf-8?B?V0paQmpJREF5akxEa0hFT0hDeUpDVGcxVlltS1F3OWpqNkhxckhuSTJQemkr?=
 =?utf-8?B?eG1SeHM3UXZiR1oxMVdxUnlSMFFNRUlTS2xrVndNUTBadGp4Ulh3M3REQkRy?=
 =?utf-8?B?ZlI3UHVtbWJWNXFkVjJNSnRDMmMrcGU0NG0zN3AybnZTbjBWL0JCVkxyelRD?=
 =?utf-8?B?QmxpVGRUeVNuRDBPWVZzdW1NdTN3WUY5bUlRdFEvS0FLbkd3Q2FtREhSaHdH?=
 =?utf-8?B?YXprdjgxYjVid0x2cXkxL1dPOTBKTUNHNGUwNlowdis2UTN4TGpZenJBY0px?=
 =?utf-8?B?UDNMclhMTUp5S3pTNVRQZ09iMFJxK0xKNmIxeGJjV1g2YThKVXNMeXVrNDZ2?=
 =?utf-8?B?ditSTXI5RWtMbFQ1OUNFd3FDajdEcU9rOUFCYmN6Q21PcmI1NEpVS2FyaG1h?=
 =?utf-8?B?QXFLeFBETkJ2VHo3UGlIeXBIOFRrejNWeDFtRDNSS0VFRW9aZVpqZHY5OVdJ?=
 =?utf-8?B?SndFUVMvNHQwNlZOZWROSFU2Um9PMEZPMDZyOUpqczNuNm84a0tRR09CekZE?=
 =?utf-8?B?WEkyd0M0MVEzY3BVcWdZZTBBZjlWRUNQN3ZKV0ZyVFVDWTI5RTNCZExRa2RW?=
 =?utf-8?B?ZElaaUVqYmk0b0JSMkNhT01XMTlvTDlmMk55S0VJbTJyQTdYUThhNXZEd2Rk?=
 =?utf-8?B?QUhCeUh5amtpcFJlTFVqTXNoWldOVEZzSk5sY3Bta09QWkxkV3pnSWdDK1JR?=
 =?utf-8?B?cFBxeDBnV2JVQndFeHhCNE1IREdDbVhkM1ZOL1ZJd2dKTHdlZzJua0kvV2Zs?=
 =?utf-8?B?YUdMVitLR1Urb282VUlhZjlqd09rZFNMMEFBWlF6M0NPaGFLKzBKK0FOL200?=
 =?utf-8?B?d0JYOW5qN0VobGpYRUU1UXBodWhMTldqSkh6cnBsMEdCdEVoWFhrckZOZExt?=
 =?utf-8?B?bmxTTFVsTWlEVXpTL3Z4RWw5UTVIeUFvVEpBZXNlV0JoTHZFNkJBbFNKbzdY?=
 =?utf-8?B?VDBLWVhkUklpN2ZoMlpqV1hYTnV2QVA4MzcrQ1UvOXlpOFE0VnhlMFNIdUFE?=
 =?utf-8?B?QzVvY1pYUlRwRllvQnhweGhNcllRYUorcGI4cW1rdEFiZHN2MVNRc3NHWGZR?=
 =?utf-8?B?NGxDSVZFdU9Sb1d3RVBORVNvTEZPVnFtSXVVcFBnblMxS2w1YnI2NDRmdzFE?=
 =?utf-8?B?aEZsSER2c1ZDWnNVNCtkNW12U1c0bk5KelU5bHVLSlBoZXMwSkdQUlc5T1lL?=
 =?utf-8?B?OVd6bHczUDFBT3BoRHlRbTM4TzNRcjBYRE1UVC9CTnRHY09BN052Mm9DRXNJ?=
 =?utf-8?B?UGxpTFlJV2V1SjJkRGVKYWV3N3BLNHY0TzlieHR1a1V0VzdTVDBINXBxVHZv?=
 =?utf-8?B?SGZ5cW9UN3pSakxuODNhT1ppSjk0U1BoaFBtQ1k0NFI4UkN5T1ZaS1N6YWhF?=
 =?utf-8?B?OEVqL0wzVGZQTWtDTnN1cE50WlAxTEo2NVI0Vi9wSzRNQnZUbFNCeVUrL2R6?=
 =?utf-8?B?V1JRZUNqcXNYT2dENmVJV0NjMnVsNktZSTBFRkh1eHNMRjlFRDY0RlZJaFhn?=
 =?utf-8?B?Q09Nak56anhKaStpajRQNnhmazY4MUFMZTY0dGRGUjJrZS9GZHN3dFJUWDFl?=
 =?utf-8?B?QXRvNFR6NUFjTk5HZG42UEN6b2tDYlNCSGNBMXlNM2phTjZFVXZLUmgrZXJM?=
 =?utf-8?B?TSsxVFhXU0I4N2JRZ01aQTU2c1JLNElTakp6STZUNjJJa0ZidGJoYkplRzFT?=
 =?utf-8?B?Q2dERStkZnh1aWNtc0NiaXBucVJncTBVeFQ4dGZlbHphbTNQQUFjNHUzTkdv?=
 =?utf-8?B?MFl1RU9FaDlLTm1mN3pzV3BkS1ZmMitqcHI2blBZSlJOVHVxRDFSZnJqdFcv?=
 =?utf-8?B?eE9MM05xeGI1cjQxcHhxN2x4SVp1VlNXVG5BTzFrOGswMzFUMFNOUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388fe62c-ecfd-429a-b518-08da22f64332
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 17:50:31.4791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSOHKlIv3pzAFffdo1HAKoVSqt+48aDw2/6LPrS2pIJcpSwiXOiZTN+qmYofWm9zz9jDuc0SBTUAkKVmGkdJaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2525
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/20/2022 7:52 PM, Tom Rix wrote:
> Smatch reports this representative issue
> amd_sfh_hid_report_desc.h:182:10: warning: symbol 'gyro3_report_descriptor' was not declared. Should it be static?
> Similar issues for comp3_report_descriptor and als_report_descriptor.
>
> Global variables should not be defined in header files.
> This only works because amd_sfh_hid_report_desc.h in only included by
> amd_sfh_hid_desc.c so change the storage-class specifiers to static.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h    | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
> index b07dc4bbb858..7a2b4e434e4f 100644
> --- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
> +++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
> @@ -179,7 +179,7 @@ static const u8 accel3_report_descriptor[] = {
>  0xC0			/* HID end collection */
>  };
>  
> -const u8 gyro3_report_descriptor[] = {
> +static const u8 gyro3_report_descriptor[] = {
>  0x05, 0x20,		/* Usage page */
>  0x09, 0x76,		/* Motion type Gyro3D */
>  0xA1, 0x00,		/* HID Collection (Physical) */
> @@ -340,7 +340,7 @@ const u8 gyro3_report_descriptor[] = {
>  0xC0,			/* HID end collection */
>  };
>  
> -const u8 comp3_report_descriptor[] = {
> +static const u8 comp3_report_descriptor[] = {
>  0x05, 0x20,		/* Usage page */
>  0x09, 0x83,		/* Motion type Orientation compass 3D */
>  0xA1, 0x00,		/* HID Collection (Physical) */
> @@ -512,7 +512,7 @@ const u8 comp3_report_descriptor[] = {
>  0xC0				/* HID end collection */
>  };
>  
> -const u8 als_report_descriptor[] = {
> +static const u8 als_report_descriptor[] = {
>  0x05, 0x20,	/* HID usage page sensor */
>  0x09, 0x41,	/* HID usage sensor type Ambientlight  */
>  0xA1, 0x00,	/* HID Collection (Physical) */

Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

