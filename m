Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F39E533C7C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiEYMO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiEYMOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:14:53 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150059.outbound.protection.outlook.com [40.107.15.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69172125A;
        Wed, 25 May 2022 05:14:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INglnsVD495MD4btqMyH/oKOcplVpXNPCQFRlbisn+gqdsFV39bIpZ+ruJaac8EUdifazhFeqzIgXxA6oDU7Hq9wkwM8vbBqjiZ67q7pPhX9cZtWcjjPJx+7SwUBDlBqN49R4SntGsAFqLWNJSeiA8sic4pFbBglcoJHIex1JUTCns3dG6UGkp2EVqMZ1YbYa4bIMzGSNU/hRx6YHDtNSwtZxYtTugu6M68ro+YGvfajxVCVvHybYeCkkEyLS8qQHAx8/ogVi2u0mlq0h134klQPyCktp9vyisKJctcsJv3menSdcbwskieeZWOUoDNfkx/QdcEYEnRyMupGMoNmUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhcotBR4R8tXR4RMW3mdGd1a/gu9F0Hr6iKRlcsp/9U=;
 b=IqJFGF3RmTIwXUY/hjYPH1ni+NwLZwpLbwJGTsjeCRqaHB+dWYszIV7eBDCU5CLqA2KkymuGiXz8m5MOlFM4uX3Xkk+whunefidxLUjq8ZbTeSIP1oZQfORdb44L3vmUYqujFVEzYRWGJkp3j/d7RIhDAgYTYEEQp4fxYYh9DhQ3hngwDnHhwhxQYLxJVRq+VeZ/ofHTDw29ua8hVoqjsoMRZ8TNYpOckpP4UOqrO/Ku0Uvoz6bsUMbACiygcmIrhQIxNeDFmYVvleGOXl2+7ZyuaFiXeMUiNJREkFjfgYtcbWRkeiTwNE/Y0xWk0QzpBtUj94ch3H0SkJmnlMMXzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhcotBR4R8tXR4RMW3mdGd1a/gu9F0Hr6iKRlcsp/9U=;
 b=StCGoSwgdvlT/4uX+5BKM/IWXeWxEvLOTL1D+x8Vv+7LTHOhrO0w2F5y2hxTF/UYBZIh1Uq1nvwA78dCzdeOUCwAuF4U8EdaZkukOF+JJR/i8zpmUXxsA86YyrtxIIL7H/770/2WZbHEGyTeFOfVu9AYyz2x/FDgf29g1O4F5G0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB9PR04MB9378.eurprd04.prod.outlook.com (2603:10a6:10:36a::6)
 by AM6PR04MB5461.eurprd04.prod.outlook.com (2603:10a6:20b:9b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Wed, 25 May
 2022 12:14:49 +0000
Received: from DB9PR04MB9378.eurprd04.prod.outlook.com
 ([fe80::4c85:560b:2f85:7522]) by DB9PR04MB9378.eurprd04.prod.outlook.com
 ([fe80::4c85:560b:2f85:7522%8]) with mapi id 15.20.5273.023; Wed, 25 May 2022
 12:14:49 +0000
Message-ID: <4fe4021b-1225-36a3-f13c-9fcd491f6351@theobroma-systems.com>
Date:   Wed, 25 May 2022 14:14:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 2/4] media: ov5675: add device-tree support and support
 runtime PM
Content-Language: en-US
To:     Jacopo Mondi <jacopo@jmondi.org>,
        Quentin Schulz <foss+kernel@0leil.net>
Cc:     shawnx.tu@intel.com, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220509143226.531117-1-foss+kernel@0leil.net>
 <20220509143226.531117-2-foss+kernel@0leil.net>
 <20220510094607.2ijaw6we6jml2bv7@uno.localdomain>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220510094607.2ijaw6we6jml2bv7@uno.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0701CA0021.eurprd07.prod.outlook.com
 (2603:10a6:203:51::31) To DB9PR04MB9378.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb131da3-58cc-4279-1504-08da3e482a36
X-MS-TrafficTypeDiagnostic: AM6PR04MB5461:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB54614FDB305CB8F03A051B6CC2D69@AM6PR04MB5461.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UQnFbVYMAh2C2r+y47KcYIgUQkU1W2zwPNdAcOXqqsSzsGPtFhjFoYrLeVXID1/uxmwmGehRsnp9x0ccqpCpm9UiEHe4nnxwCoJTHB1u8n5Ll6A/K++P2nSoa3GYlgwGy35EAIZN7fjPeDBwWRiMOQeDCzUh7Cx2FvNHmdxt4l/QjaIPABdhB4Zc61eniOfhhYW+NhCrPYbsswmR7caEujY8O/RaHKstPbdtVUZULPxv2oI1AO5VmaZKlJE4Be1X05iPPWXL8qv/h/Fsa7XpaX+d7mO8joRrkTrIhHoRqkMQSaSEa3/lzsovHBczOWjMY0eoNl3GGcryUmX3Ioo/1IrSzRwzEMYjP6tXcugB1aFnu6wjvHRILS5UOk4Gxmd8sIoCM6CG+3kl9kF6PVOKTxl3vIA/L1tJZvL9GK3YlRRrz9/MPcJg0qzWou2lPvSBce6QFAR8MfW/og+RI/RFZHrg2kW8sYNOJrDY3EmazCztHQv0/DuLaLKQTtRekpzE7FKLuwJRcAKwLkgVqBZglo72oAXb8fbKQSeSPwOpW//9GrnHQ9utW+IDxe5RjdAAQUlzd3MFJUDJtYfmQZhcyyPq034WmnlwUSTeyUs9CP0a7yh8DsJiDCr/RO+VG2d6QobZ1HuwlQDlAQH3AbMzmxrcg646MJICDX2Dj8oAQwwt8MxHekxQZkGBusowVvNtEtTBGazhKGFW5BlGr7thixeqRh5HIQoiCeilME1eZ/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9378.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(53546011)(2906002)(38100700002)(6512007)(2616005)(26005)(6506007)(5660300002)(44832011)(4744005)(31686004)(186003)(83380400001)(316002)(36756003)(31696002)(86362001)(110136005)(4326008)(8676002)(66476007)(66946007)(66556008)(508600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE9RQU4zblpTNUxTMDM2Rk1JbVp2dVRybDlzTkt3cUdvQnhwY1NsdHVocFhi?=
 =?utf-8?B?RDBXU1BpNmRZWmNNSTYzekZSaFhzZTBKUzFLUkptTHJIVXVYejBHaUFYUCtW?=
 =?utf-8?B?aVN4TDVXcnVwMnNGNFlQa1dVR3lqcjJWVlQ3VmJFM0dnQ3Q4bFU2R3lUQmdr?=
 =?utf-8?B?VGt0Z1lUcS9sdEVyLzJTOVAzUDAvVVFISHAyUjBvdlRXWVFhOEpEcTFXZi9G?=
 =?utf-8?B?UExydXZQSW5icTNGc1F2ZGJwK1liWUx2S2FjNzlWUzhNTGhBdVUxYTJPREZr?=
 =?utf-8?B?YlR0MUZ3ai91Z2s4YWxJN09FOEJrcVNGd0QvZDE3ZnV1T0dFc3BTbXRxMkpw?=
 =?utf-8?B?UkcvNS9McmxSd1daa3QwWi9jSFNkNlNXWUVvWUhFUG56dlhYWTh6ejlFWmFD?=
 =?utf-8?B?aFBoN1MzZ2Nlc2hxS213VVhvWkR5QnMxSVFNeHhOdGZHWWJQZ1o3WlN1QVBt?=
 =?utf-8?B?VlQvVDhnNTJlNVpNNVpZZm5zaEc4bGNwaTVsbUNabmdwZ1FwV1Q3Z0pwblov?=
 =?utf-8?B?UFRZYmRCZzEyaGw2YTFsMnRIMDJEaUI2ZkNQWEQwVHhsdE42dFgzY1Noc3Qr?=
 =?utf-8?B?T1RFcytoQ2ppN1FkTzVFcXl4aXc3b3VsZUVMR283a2x5Z3ZuZlZrUjZYWjJI?=
 =?utf-8?B?dGhraFN0UDdMbzhOSEN3T2lodnRIYjIxeGFxcFh1aUhGbUVwUVB0cDZSL2dR?=
 =?utf-8?B?UmozR2JCMktHeng0TmVMWXBtQ0pzdFhYdzVNMy9xeUUrWElCUmtBOTZhT2tH?=
 =?utf-8?B?c1pNM212N1dsd2EvMmZyaGF4MDZ6dVZYZzMyN2tma214aGg2Ri95dmhZb2dj?=
 =?utf-8?B?TUJxb2pyVWVBWGZwVWdRT0lEMkJvaGRjVGtybjNoMzdBRGtzakhJU2Z1ZXU4?=
 =?utf-8?B?TWIrRlM3b2VacFYvVGh4Smg1OGJXY0tGTURKaWRETDJNZjB0d2x3bTZnNmpl?=
 =?utf-8?B?Wm83MTZMUUZnZ2tzMGdLQ2trMG1aRGxrTEhqby9lb2RyZ0ZycXI1NHlJamMr?=
 =?utf-8?B?c096K1IxdmtEMlNmaTB1NTNuSUYxNzJWYkF2cVhtSFZyRFJWOE5LU1dYQ1Q4?=
 =?utf-8?B?YmJKajN5MnJNdThGVnZaTXBLTXE2akVic3o3VWcwNzUrZHFMa3JHbDFoUkpB?=
 =?utf-8?B?QUlvRzdaeEU2RnRlWjV5aGhKQitra2o5bkNPa01QNnYydWJaQlprVldYczZW?=
 =?utf-8?B?T3RYN2Rab2Jrd0JXVVlHdWFyMDZORFJweGpsN0JPbUpVU0JJS1lRM1k2ZVNO?=
 =?utf-8?B?aUh1ZjZLbzR3MTkyT25DaHhCdThSUGtIZ2pmbTcwaWt4N0RhR2ZsRENVRDZS?=
 =?utf-8?B?alBiMVhJSi93REJwdFF1RDZ4QXhNNjRWVW9CS3lZZCtWb2VPTkdIK1FhN3dJ?=
 =?utf-8?B?RXdqb3oyRzM3WGdvMXVHTnloUUJuWmFVb3B1SnBVUjVYOU5rRGJId1Mvelp5?=
 =?utf-8?B?RmMvTWJteFVTRU9mMnJRTFIwM25jdEx2VnBNdFlmT2VSL1NZNGVFSUs0d3BS?=
 =?utf-8?B?TkdpRFBKWTVLeWlia0dMczFxYzVXaWVmOWQwazk2SDJWMVMxbmxxd0s2cTZL?=
 =?utf-8?B?UDBKeTRUNHQ5RUsrdnMzVVM1ajBUcjgzOWh6MmZib0x1TDZjc1JucFcvY0dn?=
 =?utf-8?B?K1Z3cVYzamI2T0tGblpzcHdLMW5DWFhpRTJzSDN5a2EycjNwZWRwRGpLeHJr?=
 =?utf-8?B?Z1VpSHBxNWpOL0ZCOFY3S2lXVHpiTjRGOTdFWC9GOXhRNk1DNnV2R1NMZGR1?=
 =?utf-8?B?cUFnV1M3M1daSk1pd2lzaGplYS9yZGVaWTRZYW5jb0hWN2pDOTdUdEx3T2Fl?=
 =?utf-8?B?OTBjWUFjWjBtTGViYzVlUzRqMk55N3ZhVENjTjJVSjNweGNqNWNVQUFKK2VU?=
 =?utf-8?B?N2FVQ3JLdTlOaDlsaklWQVhVbE13ZlkxYnd1ZGczbW9sVnFudVJYT0FjZ2Rp?=
 =?utf-8?B?MHpwVzMzSE5iUUg4NlowenpuTVVORmlDWGx0NmVpS3VWQ01rbHV1dVJPYVNz?=
 =?utf-8?B?bWZJRklMSDRiSUFxWmxjSWNnVVdFVFVRUTVkVkdYaDIrRW4wYTZLaGY1Vk5B?=
 =?utf-8?B?MFg3c29DUnY4c2RXOEJlTDZaVmdmR043OE5uS0VwTG5VMUhnUytwOVd4L1Jp?=
 =?utf-8?B?amNDWEVyWGt3cWpvNFdOdUxueDNSaVB1RTBPWWwxRXM2Y3BkMXdGTEZMQ0M5?=
 =?utf-8?B?QzNZd0xKRFdIaG5JemdoclEybzJyWGdMZC9lL3V6enlCb2lURzFXeXV2MDVN?=
 =?utf-8?B?dVBnWUJaUGVuTnRGcmlYdXBUY09GWHN0S3pXSzErSXRDQ3JOeDJvZkZ4Q0Jm?=
 =?utf-8?B?RjJwUm04YU5lNGJCQm9JRitWYUVkS3BkUVg4OGJhMEhGSWZUb1NmaHFVL2sv?=
 =?utf-8?Q?zBajPBQugMpKLbUbOqyFqQJypvP/zADvtEXac?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb131da3-58cc-4279-1504-08da3e482a36
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9378.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 12:14:49.4520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DP1Q0HPysdE2xdFmA0LheeSRcdJJdsMss4Isu8NbeX1tQiwbUgv18chdvf6z/6/o9LV0fotMO8pV3sBpYdkFQAx0qShPqPpUyLSaW/EYdoegZuUKSk3ncLjG5eVtNrVV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5461
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On 5/10/22 11:46, Jacopo Mondi wrote:
> Hi Quentin,
> 
> On Mon, May 09, 2022 at 04:32:24PM +0200, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> Until now, this driver only supported ACPI. This adds support for
>> Device Tree too while enabling clock and regulators in runtime PM.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> Thanks for addressing all comments on the previous version.
> 
> Looks good to me!
> Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
> 

I didn't add your Reviewed-by in the v4 because I modified the 
resume/suspend functions, hope this is ok with you.

Thanks for the reviews.

Cheers,
Quentin
