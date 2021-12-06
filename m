Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DE446940D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbhLFKpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:45:54 -0500
Received: from mail-eopbgr110116.outbound.protection.outlook.com ([40.107.11.116]:36024
        "EHLO GBR01-CWL-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238305AbhLFKpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:45:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDmj1Snc7folCB6q9esNMTQJ41OgbMoB4PpysqnWP72jbt49gWy3hdyB9Fw6MDdsyWUrnBPvuOZFg3eDwFtq9O+LJAVZJdfHocAjKZSYW000W+4qPfB6YQJ6CgOcsF4pNAXbCe2Y9fihPj/yzld4zju1In6jWOlOZjaE/+zEuoleE2CRQaO3MxEGlinmBtKp67bu/FP6K68Susu3iIMRmHIxtWBbtjEBeKzqRYvBsEhvsf+ZqnIM16WGf7n6Nn/MgT0gBylYS4f4qnQjfjs9LXZyLGTfdwlBGJ1Fjd2gXXFSV3oy5BiLCsbPRKGBFdEI1bL68EOPZIcH7bj/HZ0Caw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yH/VxGNJZ936eFW/DrdTNODrE8yc9ZZY1iF/ZMXjVXY=;
 b=RWp0ct9JlPbkSYR6MiiPraFiP1IPahg2ChyPHsW1UCO9OLreCOYuyyPM5O1MbAxQ/iatxgf899HS+yasaCGHa7DMGacMDPnd6roDw+Vv75JVvPIT3BjFMMs+AHJIwomUidmFIDTvcOcK7bX9b+HE8VS2FBZcC6HelmJwtwfhu4ipJHNdh1Of5kjwUcL8P9Jd33gBMxNA5kgYlbCJkvgOvvA/GAzqQkWg6JchW99zoJEkkiOeCFDSvBisUc9o9vWCOq9+WGyTlpTO87UoQ4cv27YT23IcU0YWn1hDzBkxbzRCn+KTrqZ5iwSH5drKaldJJqSnuhN6u9xvo5RMgSwuSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sancloud.com; dmarc=pass action=none header.from=sancloud.com;
 dkim=pass header.d=sancloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sancloud.onmicrosoft.com; s=selector2-sancloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yH/VxGNJZ936eFW/DrdTNODrE8yc9ZZY1iF/ZMXjVXY=;
 b=H2lX0kv0B71W/ttlHtc8pFhr11dm+mwZeckRjV2+vBxe/DvyYOolVGR9QkJ8RG/aKHRPO92mXH6eUkFydlXRHLVtHClM6W4Y0KWbjRvmaQtTJoIKZ6dUKFTXExTWROKqypVCq/YmhHzqk/6QUImxOAFxilNm4XjoOxedPctYy38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sancloud.com;
Received: from CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:61::19)
 by CWLP123MB4612.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:10d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Mon, 6 Dec
 2021 10:42:22 +0000
Received: from CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e5f8:24f0:cbd5:d755]) by CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e5f8:24f0:cbd5:d755%7]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 10:42:22 +0000
Message-ID: <4f0177a1-0425-1de8-8e6f-836682d225b9@sancloud.com>
Date:   Mon, 6 Dec 2021 10:42:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
From:   Paul Barker <paul.barker@sancloud.com>
Subject: Re: [PATCH 3/4] mtd: add advanced protection and security ioctls
To:     shiva.linuxworks@gmail.com, tudor.ambarus@microchip.com,
        michael@walle.cc, p.yadav@ti.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
References: <20211027103352.8879-1-sshivamurthy@micron.com>
 <20211027103352.8879-4-sshivamurthy@micron.com>
X-Mozilla-News-Host: news://nntp.lore.kernel.org
In-Reply-To: <20211027103352.8879-4-sshivamurthy@micron.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0143.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::35) To CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:61::19)
MIME-Version: 1.0
Received: from [10.0.0.90] (80.7.160.81) by LO2P265CA0143.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9f::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend Transport; Mon, 6 Dec 2021 10:42:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9da9b77a-ea89-446b-85ba-08d9b8a515d6
X-MS-TrafficTypeDiagnostic: CWLP123MB4612:EE_
X-Microsoft-Antispam-PRVS: <CWLP123MB4612DC318CA5EDDA85E3DECD936D9@CWLP123MB4612.GBRP123.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vg2SukWkuENSVAyuMmhmtO8XGsLQaCikkBTRNRx0TQb273XYI/sLwePfN0IshmIew/DCIIRolQPmSm95+vv3y2aLTmXVZQnrqLdD7KwQeSBzRd+Tjcj2e9tHgGoZ5I+NwcnylHal/844GjZrcEwQy40Zh8HGrLEl82PyFsAQEMEUVyhNec+U/efj74y4NWpKVjvVKFzPJjgx7mBF3ybDddALrLM0LYwmRfXcqhG8UrvMGAAexZ4FQehZHsBnqN2ry1lMSApcfvCUQM+vn57kZQ6RxyT9Gk8cLIEYQVw4MjsVbBpkTEvCkkLJVGNJiKQwF4oV14zvR+ZhVx/KFYcZoVyPehwuAZCmtiY6JD2ILmjoMqfTX+c4TdW2r2ZqyyHBjgBvV9DA3tj9KRzO6lcoykCH2TKEHkHSsqPfJBbN/kpvMU+KMZq0k9SdNLPH7NUFO4Skt7KUec3r2JlYyDBFgiKKM6oHCrcmhMWUcq6UTDHCnieBZEj7TbfX2XRIO0IFPmnCZdwIFPQ8pC9XqAK8MW9a6JMDPtvhfmzaofhOkcGrIlmoANZJ8AZeB2klwR/6x+kGOPQ5RxxmUJ/eWpdyXuqwr74duFYTMBKcJFnbsYanXrqa3GhIcXCMkMOFI6u/3NGXh9zNiKUI8n+3h5OaD59LMaAGkHpbETYqDljMdQRKK1Euzei0T6mpNhnZ8B+Hi/Mh/bkrK0z6/bz0qqtDNg1quXWnJtjGsfdBR62xPDnRoFog3BUNqFpsYMFYniHX0nc/uZKQiA/OBpuaQBw6BBnnd6HM/gZA6TKkbALqjKNyHQElMfMp1VYQkGvSA/FWsbOsbcXY+KfQiDBlE15crOexJwYzGaTOMvzHXW0Nb0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(136003)(376002)(346002)(366004)(396003)(38100700002)(38350700002)(15650500001)(52116002)(53546011)(8936002)(2616005)(956004)(2906002)(66946007)(316002)(966005)(6486002)(66556008)(186003)(31686004)(66476007)(44832011)(83380400001)(7416002)(86362001)(4326008)(8676002)(26005)(508600001)(16576012)(5660300002)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVlEN3dCZjNYZEx2KzJEQnNXTUp1V21PalU4SGc2aVQ4UkRjTEZ1a2RYYzcx?=
 =?utf-8?B?YnJLSjdlWUtyektYMWxwaktHTmFMNjA0L2tzZ24zckkrTWhFN3hScDArTzJ0?=
 =?utf-8?B?b1AzYVVxRkNodmltVnhFSmprYjYyTGJ1a2xDTkFhWDRJdzZpOEFNSmNINHBY?=
 =?utf-8?B?dEg4Rlpadm9hQVJZaWJvbERaQnRmd3dIZmNMYWZ3WFZHUlFhdFpBOVJ0aVFh?=
 =?utf-8?B?Qnd2TnZYejNMNVJhWW8zdUczdnd0SWtTcWIySDhOaEY3aThURDkzNHJWVzFQ?=
 =?utf-8?B?a0JuQUVWWjZLUGRpVGVMZnRnQ0lJZkp2MGg3RVdQb2pLZTQrSEY2eVdHVGQ2?=
 =?utf-8?B?eWEwWjBHNXFnUXV2Z2prdW04T2llRmlsOUM1V3VmTlgyc3pucURVMy9DRUJy?=
 =?utf-8?B?VnBFM3VuZ1FjWFZEZ0lMdjQwejh3QytJUWtpcmM1OTd4WlY0ZnZ3ZmJMNkpE?=
 =?utf-8?B?UlVYOWhhOEMvZWVKOU1LM0JYM0FXRGxKaGJHNkdEVURlWHFQamFJUTNQdDRT?=
 =?utf-8?B?aVFFcEIwQ1Y4QUp3WEhpMndVRFd5VWF0cFhrSEpZaGU0Y013K2MxZnBySkNm?=
 =?utf-8?B?SjZXTmVaZnIvN2p0cUJ3a3JSNEl4Z2FJZUwrYzlmN3NFMjBPOEx1Vk1MM2Ny?=
 =?utf-8?B?NlVaSE5iM3JJOFlGRSs3Q1R5emNKeURUNnVOdFFVUlIwdG9ONElDOENFT1Rq?=
 =?utf-8?B?bDZUUmVLYnhWSnZsRW5KbmJUMWZLOXlWK2gxMVZvenFWS29WWkZHSkNWd3JD?=
 =?utf-8?B?M3psZXFLeWJlekhhRFd5WVJkOUd2YURJZm15c3huM3NSWTVqaXVxYmxiZ09C?=
 =?utf-8?B?WDBuU3VWbXFkYXhmQmxCSThKWkExSEx0dGNqeFQxQXdQNGVrdmNhbnVocHQv?=
 =?utf-8?B?elh3d0dtRDYzbFVDQ0wwNGpFd0s3dS9SWFF5SUJKV2dqZnAxVmVCT2F5ajNo?=
 =?utf-8?B?bG5QeXlyaUFuckRhUGpvV1NNcm1COWFZUDF1eUJiTVp5MzdxTU1sYjRRaGUr?=
 =?utf-8?B?T3NreWMwdEszNFNjNk1KeDBOZTd3WXhYVVV5YTdDQ213Wm92d3pqam8zOHBk?=
 =?utf-8?B?ajZFTFJrTXZaaGVKUDNIVXk2STNncFNjMmljN3lBaUxOWG9uM2huOWVJbzBy?=
 =?utf-8?B?eSttWXkrL21VUjJ1WW9xY0dVWTI3L1VZRXZaYzZVb2JlUEFCd05kendXMW14?=
 =?utf-8?B?T3NrNFBnM3BhVHlaODdtZk9zN3RFcTZLV1RLa2NrVUp4VjNQVCttNDdBSFVX?=
 =?utf-8?B?VGJwcWhUQ213eHVwWGNUTkQ0Z20yaEZJdzczT1JpRTNlZEpDSnFrOWRaOUNn?=
 =?utf-8?B?dllTeXpncnZFQWEvcHhuQ2EzR05rb1pGOEVFL2Q1KzJwNFgrQ1RWbm9ZOTRt?=
 =?utf-8?B?ZHlNOHIyb0pNRGxqYnA5QllPTjlkMDErTEd6VDdxZ0Y3bzZ0NTZFeFI1SEdI?=
 =?utf-8?B?K3Uwa3laUSt4eU1UeFBadWxla2FGSStDSWNVVkphemRCSzQ2cjV3UGNka1RI?=
 =?utf-8?B?Q3EyQ1FlK1lFc3lDZERCTnNkTlViSEhUc3ZFVmdBaGQ0MnlNUEdoQURSOWp4?=
 =?utf-8?B?V1dOQTZZKzNYVEQ4YXNjOHliKzh5UmpJRm1BcDcycW1EMStTeGw4NDl2dk1u?=
 =?utf-8?B?WTFFQnIvRXpjcGxtRTdzbjhOVG9iR0NCazZIbkJxVmxaS01vbkEyR09YWmYw?=
 =?utf-8?B?Yld1b3YybzJ2dFFvZDFWc1JzZzRCZXBUZk1SWCtjUHRrU2ZjNmtwTkpGWUVS?=
 =?utf-8?B?bUZNazB4WU81THlhQlFvTWlNMnhaR3J1ak5PcTFlUVdCRnB1NUVrQWxwQ2Rw?=
 =?utf-8?B?bFdUZ2hKQnRlTi9TODRnRTF4bk9wUEZBdEppa202VEVXQk01N3Jrd3BNSVM5?=
 =?utf-8?B?M0R1Q2kxZDIyU0dPNTJqakpkYzBpQzJTSFBOWmlhamdPMmxMSjUxMDVJdnpw?=
 =?utf-8?B?VmhDaTM1Z2UwT25xa1A3WW8vd0d5ZlpHaFE5Nmp5MU1tbStwUCswdzlFZFV4?=
 =?utf-8?B?c3ljT3hmZkZnc0o1UktxUjhvbXNjTnZ6QmlFYk5rOElxUW1HS0xvVjRzUTdD?=
 =?utf-8?B?dWpuNkY1WC9wSkJEcm9HWDN1amRKbTZUd2pZdWcxbEpuTHZlUllaQzlBb3VQ?=
 =?utf-8?B?VXJyWElKamhXazBnZE8rYmFNZCt6TzNDb2NwdjQ2ZkNYaERjNzFsRUJhWjJM?=
 =?utf-8?B?cVFkNElqanozV3h1Nkd0b3BsUmJ4RFNVQWk4ZnBxWW1Ra2xiaXlnUVc2NXQz?=
 =?utf-8?B?dmF1cGs4MFQxUVJWS1c2empFQXZ3PT0=?=
X-OriginatorOrg: sancloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da9b77a-ea89-446b-85ba-08d9b8a515d6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 10:42:22.6530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 840be37c-244a-450e-9bcc-2064862de1f4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YzRuTQTYxPFynJIF/D/sBcANOsi8/wiDltwsFHX4Qm/ZbbkF92y8Jj6Xw2KNB5s1X8A8LOpoUzbuw2EDOlz9zg4rJ5sWpmmnihPM3p2JUL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4612
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2021 11:33, shiva.linuxworks@gmail.com wrote:
> From: Shivamurthy Shastri <sshivamurthy@micron.com>
> 
> Added new ioctls for advanced protection and security features.
> These features are currently supported by new Micron SPI NOR flashes.
> 
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> ---
>   drivers/mtd/mtdchar.c      | 145 +++++++++++++++++++++++++++++++++++++
>   include/uapi/mtd/mtd-abi.h |  11 +++
>   2 files changed, 156 insertions(+)
> 
> diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
> index 155e991d9d75..97b97b80276d 100644
> --- a/drivers/mtd/mtdchar.c
> +++ b/drivers/mtd/mtdchar.c
> @@ -654,6 +654,16 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
>   	case MTDFILEMODE:
>   	case BLKPG:
>   	case BLKRRPART:
> +	case SECURE_PACKET_READ:
> +	case SECURE_PACKET_WRITE:
> +	case RD_VLOCK_BITS:
> +	case WR_VLOCK_BITS:
> +	case RD_NVLOCK_BITS:
> +	case WR_NVLOCK_BITS:
> +	case ER_NVLOCK_BITS:
> +	case RD_GLOBAL_FREEZE_BITS:
> +	case WR_GLOBAL_FREEZE_BITS:
> +	case RD_PASSWORD:
>   		break;

It looks like you've listed all of the ioctls as "safe" commands so the 
write permission bit is not checked. My understanding is that all ioctls 
which may modify the data in flash need moving to the "dangerous" 
commands section below this so that the write permission bit is checked.

>   
>   	/* "dangerous" commands */
> @@ -1017,6 +1027,141 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
>   		ret = 0;
>   		break;
>   	}
> +	case SECURE_PACKET_READ:
> +	{
> +		struct mtd_oob_buf buf;
> +		u8 *oobbuf;
> +
> +		if (copy_from_user(&buf, argp, sizeof(buf)))
> +			ret = -EFAULT;
> +
> +		oobbuf = kmalloc(buf.length, GFP_KERNEL);
> +		ret = master->_secure_packet_read(master, buf.length, oobbuf);
> +		if (copy_to_user(buf.ptr, oobbuf, buf.length))
> +			ret = -EFAULT;
> +		break;
> +	}
> +
> +	case SECURE_PACKET_WRITE:
> +	{
> +		struct mtd_oob_buf buf;
> +		u8 *oobbuf;
> +
> +		if (copy_from_user(&buf, argp, sizeof(buf)))
> +			ret = -EFAULT;
> +
> +		oobbuf = memdup_user(buf.ptr, buf.length);
> +		ret = master->_secure_packet_write(master, buf.length, oobbuf);
> +		break;
> +	}
> +
> +	case RD_VLOCK_BITS:
> +	{
> +		struct mtd_oob_buf buf;
> +		u8 *oobbuf;
> +
> +		if (copy_from_user(&buf, argp, sizeof(buf)))
> +			ret = -EFAULT;
> +
> +		oobbuf = kmalloc(buf.length, GFP_KERNEL);
> +		ret = master->_read_vlock_bits(master, buf.start, buf.length,
> +					       oobbuf);
> +		if (copy_to_user(buf.ptr, oobbuf, buf.length))
> +			ret = -EFAULT;
> +		break;
> +	}
> +
> +	case WR_VLOCK_BITS:
> +	{
> +		struct mtd_oob_buf buf;
> +		u8 *oobbuf;
> +
> +		if (copy_from_user(&buf, argp, sizeof(buf)))
> +			ret = -EFAULT;
> +
> +		oobbuf = memdup_user(buf.ptr, buf.length);
> +		ret = master->_write_vlock_bits(master, buf. start, buf.length,
> +						oobbuf);
> +		break;
> +	}
> +
> +	case RD_NVLOCK_BITS:
> +	{
> +		struct mtd_oob_buf buf;
> +		u8 *oobbuf;
> +
> +		if (copy_from_user(&buf, argp, sizeof(buf)))
> +			ret = -EFAULT;
> +
> +		oobbuf = kmalloc(buf.length, GFP_KERNEL);
> +		ret = master->_read_nvlock_bits(master, buf.start, buf.length,
> +						oobbuf);
> +		if (copy_to_user(buf.ptr, oobbuf, buf.length))
> +			ret = -EFAULT;
> +		break;
> +	}
> +
> +	case WR_NVLOCK_BITS:
> +	{
> +		struct mtd_oob_buf buf;
> +
> +		if (copy_from_user(&buf, argp, sizeof(buf)))
> +			ret = -EFAULT;
> +
> +		ret = master->_write_nvlock_bits(master, buf.start);
> +		break;
> +	}
> +
> +	case ER_NVLOCK_BITS:
> +	{
> +		ret = master->_erase_nvlock_bits(master);
> +		break;
> +	}
> +
> +	case RD_GLOBAL_FREEZE_BITS:
> +	{
> +		struct mtd_oob_buf buf;
> +		u8 *oobbuf;
> +
> +		if (copy_from_user(&buf, argp, sizeof(buf)))
> +			ret = -EFAULT;
> +
> +		oobbuf = kmalloc(buf.length, GFP_KERNEL);
> +		ret = master->_read_global_freeze_bits(master, buf.length,
> +						       oobbuf);
> +		if (copy_to_user(buf.ptr, oobbuf, buf.length))
> +			ret = -EFAULT;
> +		break;
> +	}
> +
> +	case WR_GLOBAL_FREEZE_BITS:
> +	{
> +		struct mtd_oob_buf buf;
> +		u8 *oobbuf;
> +
> +		if (copy_from_user(&buf, argp, sizeof(buf)))
> +			ret = -EFAULT;
> +
> +		oobbuf = memdup_user(buf.ptr, buf.length);
> +		ret = master->_write_global_freeze_bits(master, buf.length,
> +							oobbuf);
> +		break;
> +	}
> +
> +	case RD_PASSWORD:
> +	{
> +		struct mtd_oob_buf buf;
> +		u8 *oobbuf;
> +
> +		if (copy_from_user(&buf, argp, sizeof(buf)))
> +			ret = -EFAULT;
> +
> +		oobbuf = kmalloc(buf.length, GFP_KERNEL);
> +		ret = master->_read_password(master, buf.length, oobbuf);
> +		if (copy_to_user(buf.ptr, oobbuf, buf.length))
> +			ret = -EFAULT;
> +		break;
> +	}
>   	}
>   
>   	return ret;
> diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
> index b869990c2db2..dbd7bf60d484 100644
> --- a/include/uapi/mtd/mtd-abi.h
> +++ b/include/uapi/mtd/mtd-abi.h
> @@ -208,6 +208,17 @@ struct otp_info {
>   /* Erase a given range of user data (must be in mode %MTD_FILE_MODE_OTP_USER) */
>   #define OTPERASE		_IOW('M', 25, struct otp_info)
>   
> +#define SECURE_PACKET_READ	_IOWR('M', 26, struct mtd_oob_buf)
> +#define SECURE_PACKET_WRITE	_IOWR('M', 27, struct mtd_oob_buf)
> +#define RD_VLOCK_BITS		_IOWR('M', 28, struct mtd_oob_buf)
> +#define WR_VLOCK_BITS		_IOWR('M', 29, struct mtd_oob_buf)
> +#define RD_NVLOCK_BITS		_IOWR('M', 30, struct mtd_oob_buf)
> +#define WR_NVLOCK_BITS		_IOWR('M', 31, struct mtd_oob_buf)
> +#define ER_NVLOCK_BITS		_IO('M', 32)
> +#define RD_GLOBAL_FREEZE_BITS	_IOWR('M', 33, struct mtd_oob_buf)
> +#define WR_GLOBAL_FREEZE_BITS	_IOWR('M', 34, struct mtd_oob_buf)
> +#define RD_PASSWORD		_IOWR('M', 35, struct mtd_oob_buf)
> +

All other ioctls defined in this header are preceeded by a comment which 
briefly explains what they do. I think this is needed for these new 
ioctls as well.

>   /*
>    * Obsolete legacy interface. Keep it in order not to break userspace
>    * interfaces
> 

Thanks,

-- 
Paul Barker
Principal Software Engineer
SanCloud Ltd

e: paul.barker@sancloud.com
w: https://sancloud.co.uk/
