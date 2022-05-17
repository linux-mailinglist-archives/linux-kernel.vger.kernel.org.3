Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09ED1529AD0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241145AbiEQHaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240998AbiEQHad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:30:33 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428524504B
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:30:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=au9V40mRGCEGGrz352ZhRXKMJoKnYWHz2zsqAcMT6i4D2zj4sQpE65t3GQBYqgAP/oIAHmGPBxuxQ9Vj1wWIqSkTa2Qg2+/IiUNIw2U4LhhHu4jEIXXExcIkWqr/Uhh76ngNt+baocftTKXl9R7N2bt8TaLI3Gu9Qb+0IPwmPdEej8Fdk80bHfjzEQdjsHwnB5jabkvwuxfaiRsrisk1DqIoKsy+mYSj0jEYoh4JBqO3JdfccI3uMqDTgoVTxve3UJ4EelK7ZCu40xaO+R4wu1O8005orTVOLeIG0qH1ToP87bcnsviKJi1Ia5aFbf3rx3/22J+AfNMvBGVUH4hO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lt9QPW4y0OWTB3QSglji3jpfxvt/ksOJrK6BnXXnIyE=;
 b=hgbDfbpQt+2FIaYMlbTyJla5x2UPJ1cR/XWaUZoQEV4fv19rzkh0xd5AK0W0gRSlQH20489LfMOhOOAlA3xb7gzDLCEWLHz8b1XPY1faBbXCgJrG1Zp3ervAeSUvBforyNZEMR3NsVoMi23RsYUIJmSVlPlzzmQ/poXiuLir/NqT8jDhia1ISI2waIUuPQPpOR82OUrlUN42BPJT2dbVxIN8YQGR6VXM2XNwzg2PtD4qCchtL/tCyig1rMuEH1ATmS7FJaormzB0enRkGbNxkzIn17HT0/Tl/9oyAZtT9tnxwTXoTCDXWGBYQIy0JcFM/M5miJdaE7pDA+je6XGfaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lt9QPW4y0OWTB3QSglji3jpfxvt/ksOJrK6BnXXnIyE=;
 b=fvHQGFrzC4XPPqnwotEssC56JwN4+p/0wo2zDlMxJXn00M9kdqyIMVyTInSHhF8fHEgZn3z5DNpSJbJDWtkn7sq2I7PQ4Zvmn7WtYtqOTOqZGvgg0N96PZ1CsXdJolP+fptJi9FSPnXcD7/3VDkifTC3yfqRYyqQjqkfcZ9MIuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY4PR12MB1784.namprd12.prod.outlook.com (2603:10b6:903:11e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 07:30:30 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 07:30:29 +0000
Message-ID: <c1479285-7fd8-b73a-9672-6e0d7db4cbdf@amd.com>
Date:   Tue, 17 May 2022 09:30:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dma-buf: fix use of DMA_BUF_SET_NAME_{A,B} in userspace
Content-Language: en-US
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Pekka Paalanen <pekka.paalanen@collabora.com>
Cc:     linux-kernel@vger.kernel.org
References: <20220517072708.245265-1-Jerome.Pouiller@silabs.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220517072708.245265-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR04CA0076.eurprd04.prod.outlook.com
 (2603:10a6:20b:48b::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb665c0b-995c-4402-256c-08da37d71e88
X-MS-TrafficTypeDiagnostic: CY4PR12MB1784:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB178483060032CB6329A83CA783CE9@CY4PR12MB1784.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rgQYoHj/+aax7andBmCr74bDVu2lcP410hADdOdYwUFv43/B3OGM1Kp9tdOqpGSeQddDyU7KhmA/mLZo0hX7tIYXrJocxinDv5B04xuulZ7hZNP274tsXiZ6ef5rqTcjKbPAFKpJPlFqFWq8TqWd9Ni1Brg2kZZvMxoXIaPzvZYhB7niYizCrWSjynWmogEMxce2ZQuIbRQRGLxGwmn0ZF16YZu4NzahW73j93Bgr6RICQi2IkxSAIsrL4tZqlUsPC1/0ejqoolSDkDzT65q99MpRp1gjlgNReszDhhBmb5VhGnTi5ZYQxpcP70wnEDfAS/vAXUlmzeapRcERZM4xOlhDpdV8cgwlP5qov6RvOzFKw5GieNRoaxIIcLB1yL+clKToIwWCj1yrC/RRsKwVQPjMfmoMy6gxPfmT4pcVWGXdVexoEIvpTRoUPz8D01EduGJ7LR5T58ibdcj0B+HLvNSKqifIqNduwbWGO1Cjf5KaHG90cKtva2A3FitljdozEWi6xnrHQDxte15VFfZlVjTG5V6TlH5oJzSkovn/0v/j3DptFXZCtCsfp010o7zazAvv9gkZR9TMQU0Mfw8W27k+s3zA+GIkPvAdkJhfOfbHWfRvzC6cjEeV6d72DfZM/LtHnqt2OMgo63PSZxAqvZ/xqBCooIkS9lqpAwPA+V4otCV6kov8sDEOgMRdg5Y96ITQUeTDHgYm7d0r6aU3mytOXVJ2wt0SIpz9d9VVj4U3DTba2QmTNWJNYDg4KMVzlcqjycv79LO40pNnkpvPhsaPwEmDRaW6eoIKJd/GOqE0VFab0ldsjOdVhlRysc/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6512007)(26005)(2616005)(83380400001)(31686004)(186003)(36756003)(6666004)(110136005)(66476007)(508600001)(86362001)(6486002)(966005)(2906002)(31696002)(45080400002)(38100700002)(316002)(4326008)(5660300002)(66946007)(8936002)(8676002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEthTS9kUUlEYzhoSXY1NS8yc202WHR0UktKb0xsWUJPNFdwQklOdkNRbUpt?=
 =?utf-8?B?R2h4OHJnWENxeTRBK0MzYkUrMnlMLzdpL25xR1R2TnNSSUVTYjNnOVBqVmNj?=
 =?utf-8?B?VTlpV01DMHprOEd0T0h1c1NCajBEazJsR0ZuTnBqOU9ka3RvTVhSNHRIdjZU?=
 =?utf-8?B?a1ZtcWs1bkE4ZWdmMkkzanprQkMzMm9rNU5jejZDRno1Z0V1VmdrTUkyN3lY?=
 =?utf-8?B?VGhzanVmOVFmNzhha3F5Wnd2dFQyTVQvL044ejhjY0ZVSUxlSkRBZ3R4WmxR?=
 =?utf-8?B?MEM1YUVHRWU3V3VqeVBuNi9RQzRXbEVHSkVMMUxoSGZjSzNhY0R4QmhBQmpF?=
 =?utf-8?B?Y0RWOXcxRDlHSWxSSG45WE9tQVgwaEdjZTNpdVlDbzFDdHdYTHB6eHhac3d2?=
 =?utf-8?B?YjhYRk9XZ2tHTS9pbTVDRlZKTDZSbSttczBVazdvMjlER2NCcUpGS1d2b01w?=
 =?utf-8?B?Q0hCaXd1d2dJQU5qcjhzMG85U0ZMT29ZQlNEQU8vRnE1dlZqcy9rNFRHaStT?=
 =?utf-8?B?K0ZEVVEvRk52dzY2MlU1MTQ4ZGhUWUE5RHVnblVjQUJjUXRaQlBYZlZSNzFD?=
 =?utf-8?B?VzZPdkUxZW91Q2ZnbVpwVUQzWHJZS0xYK0R3VnRQUEwyaktYVXV0WnRBZ2Rw?=
 =?utf-8?B?TVhtY2FhM2FYengrN0IrV3FRaCtrK0JIcGJjREJDSldLQWo3b1g2TXh6U09L?=
 =?utf-8?B?Nm9lcjMvVGo5QzIxOENKWDBXVDR3U2dvM1Z6UW03bWN1NDVkOTIwZGxrUWRJ?=
 =?utf-8?B?S3lBMWVrVnVlM29YQjU5NDdrWGNoTWJCclhzb29aU1JlbW8zeTd4OTRoWnhi?=
 =?utf-8?B?YklvZU5vR240Mzc5QUNjeWpLRlZ6M0l0cGRGT1hTdmJqQitQb3hid0wybzl3?=
 =?utf-8?B?aVAwZmFBZjdMMndtQzR0QUlKU1VUNUNIQTJVMmpIdklLNkdBS1QrR0ZNRFd1?=
 =?utf-8?B?V3R5c0xGeW5WVFJNUXFkbWF5L1NHSG5zOTZzZXQ3M3AxVFl1OVhLdkFRam50?=
 =?utf-8?B?bEloWkpRc2Mra20xZW5tZ0VoR0NPUlV2YXhyMkdIaldTaWQwTk1nb21kSWpL?=
 =?utf-8?B?cDVaTUtnbldYMlZ6OVZLNlIyYVhwNm5va3BzemVIVG4zVGF3aERBTHFzanlF?=
 =?utf-8?B?WEw5d2hBYVFEQ0dxQ0V4SllMOUlSZnM4UjEvd1JjYUMxS28zNHlPOHk2a2xm?=
 =?utf-8?B?QkFoWnpJL0RINWkyS2ZidWsxdUlaNGtNRTY1VEdZRDNBa3JtUEZuTmtQUzBF?=
 =?utf-8?B?N052eFVyLy9Bd09VczlhbmlKQWNWVnYraTExUmJGRUh2aFhNaHJhdFNXTnJi?=
 =?utf-8?B?OFRaQjlsZ3VnRno3TFlGekw4dGxlYkxnSmpNWHJmeDhXWkVCSjFCRlJLUFFo?=
 =?utf-8?B?MmRvRTZFRDFSUVY3dDQwOHhVd2lvN1B2eVBMbUJTSGNra0JsQkV5VGlpYzV3?=
 =?utf-8?B?Wi9ydG1HN2NJQk5yU2twYXBHZ3NKVWFYZDEvQkx1Y0hRbUFPNTd3U1FVUnpx?=
 =?utf-8?B?dnVjZDJmSnZUN1NwN0x4c2phUWJsVHhDNUhnMGxIVi92bjZBOTdmSkQ0b0l1?=
 =?utf-8?B?Y0xpTEFFZHk2aDNVb3hVWW5zRWJiWXFYaEtTZWZkNjBaNFBuOW81VUsydW54?=
 =?utf-8?B?YmxEWHdDRnphMEV3OGVXU0VZMDlJdDk2WTNpUEw2eGZNcDNSd0hZOStkUU15?=
 =?utf-8?B?Ukl4NGtmQ2RRQUxmcUgxcEd6ZTArbmQyUHNjZGx6T3dXeVhWM01DRnRmbkRD?=
 =?utf-8?B?VklXbFF1ajJRTmFOTHdVZWl0Zi9KTUJGaFNBYnF3N2JUU0tGTXlEUDRFWFdX?=
 =?utf-8?B?UkRSUlVXbmMveVFPQ0JjNDNWMHNCU3B4K0tURHBudU1DMUNrSm9lTkVsWEpH?=
 =?utf-8?B?UjVDeExUTXZFZEt2T09jTnZwZ0FXL0w3SEdBRDdvUHJnai9XN1FuSHBVR1VF?=
 =?utf-8?B?VlRHdk5XWnQ1ZHg4MGxnUlB2RHZIRnJyOFc4Ym1kekpLc2xpVHZBb0t3YW1j?=
 =?utf-8?B?aW85ODRWWVBxa3pHTjVTR2J0aWVRQ003VDhlT21JaTlmeU9KMVYxL1lqVnNC?=
 =?utf-8?B?RFo4L21pd2FKWitWQUV4UHlWeWhNTnJtTTErMTZQam5QWGprWWU1YmljM2xu?=
 =?utf-8?B?VHRiVmJNRE0rRzRjK0FGM0ZEWDI2bFhiQW5QazllK3hEQit2S3B4SkZmZjJp?=
 =?utf-8?B?UUVOME9hZERWbnZIZE41UVlhUjJja3JXa1dsamdMZE9NVUJ2cWk2WHUzTE9j?=
 =?utf-8?B?aFRNdnNXa1REYy9Db2t5U1Jkb29HLzBRVjA1MzY0Y2txbzZHdlNMTGVNdkFJ?=
 =?utf-8?B?L0VwaEhIV1JZZlpPN05UZXRZWWQ4QnBCR2JzMFRMb1d2end5d3NFZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb665c0b-995c-4402-256c-08da37d71e88
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 07:30:29.8269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8cvNdM1DxEMYgLfSkTkPhsIaZsFZ2C0+0itDDHp9tYK97wMrESWnhWZVfBFZM8d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1784
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 17.05.22 um 09:27 schrieb Jerome Pouiller:
> From: Jérôme Pouiller <jerome.pouiller@silabs.com>
>
> The typedefs u32 and u64 are not available in userspace. Thus user get
> an error he try to use DMA_BUF_SET_NAME_A or DMA_BUF_SET_NAME_B:
>
>      $ gcc -Wall   -c -MMD -c -o ioctls_list.o ioctls_list.c
>      In file included from /usr/include/x86_64-linux-gnu/asm/ioctl.h:1,
>                       from /usr/include/linux/ioctl.h:5,
>                       from /usr/include/asm-generic/ioctls.h:5,
>                       from ioctls_list.c:11:
>      ioctls_list.c:463:29: error: ‘u32’ undeclared here (not in a function)
>        463 |     { "DMA_BUF_SET_NAME_A", DMA_BUF_SET_NAME_A, -1, -1 }, // linux/dma-buf.h
>            |                             ^~~~~~~~~~~~~~~~~~
>      ioctls_list.c:464:29: error: ‘u64’ undeclared here (not in a function)
>        464 |     { "DMA_BUF_SET_NAME_B", DMA_BUF_SET_NAME_B, -1, -1 }, // linux/dma-buf.h
>            |                             ^~~~~~~~~~~~~~~~~~
>
> The issue was initially reported here[1].
>
> [1]: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fjerome-pouiller%2Fioctl%2Fpull%2F14&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7C4b665e3c2222463014ec08da37d6b3f4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637883692533547283%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=prj%2BSOuf%2B1IWK1XKGD381LhDuL9qOoj7lYy8xMoV%2B6o%3D&amp;reserved=0
>
> Signed-off-by: Jérôme Pouiller <jerome.pouiller@silabs.com>

Good catch, Reviewed-by: Christian König <christian.koenig@amd.com>

CC: stable?
Fixes: ?

> ---
>   include/uapi/linux/dma-buf.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.h
> index 8e4a2ca0bcbf..b1523cb8ab30 100644
> --- a/include/uapi/linux/dma-buf.h
> +++ b/include/uapi/linux/dma-buf.h
> @@ -92,7 +92,7 @@ struct dma_buf_sync {
>    * between them in actual uapi, they're just different numbers.
>    */
>   #define DMA_BUF_SET_NAME	_IOW(DMA_BUF_BASE, 1, const char *)
> -#define DMA_BUF_SET_NAME_A	_IOW(DMA_BUF_BASE, 1, u32)
> -#define DMA_BUF_SET_NAME_B	_IOW(DMA_BUF_BASE, 1, u64)
> +#define DMA_BUF_SET_NAME_A	_IOW(DMA_BUF_BASE, 1, __u32)
> +#define DMA_BUF_SET_NAME_B	_IOW(DMA_BUF_BASE, 1, __u64)
>   
>   #endif

