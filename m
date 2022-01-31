Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D754A503A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379131AbiAaUge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:36:34 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:15068 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349116AbiAaUgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:36:32 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20VJxNtx015908
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:36:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=XO4je/kAbYtpKQ+znma+SxIXcObHjpHvUDjGilymHuk=;
 b=g8DscDgps8U3qfSGGGTNiOJMwaOdJU86TXqwAEqu8bhsL7d8crssHgc7tL3Fq2gcfPxZ
 19XFcS094AIJruw1zqZG91ks20m7k2cfYwQvZB6O+FIThSIB1G2Ozf95rmaJKyfFTn6J
 YOaVmk0d0lAFHK/pXs9Pn2IFODeZufOfqFo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dxer3ub4w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:36:32 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 12:36:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCBKN4ftk5b82grT3cuJ5X0M9wwn+9c8zL5X9iHpV0B4NKyDH60n+uVU1U0Mqnr32KS0eRvw8mbMSW7qOwUEVBqYyy+xUogezNPg91vPJTgwg6rJzLutbgZOCDQ1KeIGMu5vw8sVLb1HbfGxXM3pF5ILfxo7rc9mwk2kVzkWS2taHbfCWOPiMRekzIMfniOvEKxsIW5Jvxrt0ahDzMmaxxalQsXpst8lTTn8QfkfiuwotpNcTXJxI2a6F+aqcv+/WI1LglBT12ssuTPW+NmfnnWh7Z/v5oc+M/4N/wPZ7t7t9UtKZiSC8av5/ZBAdv0xgTE/fAn75rhJe4ja7Nu8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XO4je/kAbYtpKQ+znma+SxIXcObHjpHvUDjGilymHuk=;
 b=SmSdR1RbMawCT8KzNxlSFtfid24JjiWhQvAoEwAuzePhJJCJFF4vTQQderGvAC/InP7i/QvZKRyfzD2vsEE/jM3TmYURe0mVghJIqXBj0xzxG6Hjac/XkutgSDZToQiisDk8IJLav77hoUhQKwqqCzWtqiljlL+C30jrAlIyASj4dFIyr9PUPO267j5RYl2GmgfFHFJfj39kKSBm+Sr6zin3G3ptQw8wqyNcuFKcigCjZX1JrJuv+KyayyjV2WFL12KupC55z87qWBq++hedbRUGmJ++tobVzTHJATvfVo7wbV3Qb9vQ38pCvH6sKAq1iBSpF5PTXmwT5Fs7iReMFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by MW2PR1501MB2121.namprd15.prod.outlook.com (2603:10b6:302:c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Mon, 31 Jan
 2022 20:36:29 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::d1db:c0b7:3515:9551]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::d1db:c0b7:3515:9551%3]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 20:36:29 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     "trix@redhat.com" <trix@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib: zstd: clean up double word in comment.
Thread-Topic: [PATCH] lib: zstd: clean up double word in comment.
Thread-Index: AQHYDgCFZGbuS3SgUE2sqPL7ZC4Pyax9qHAA
Date:   Mon, 31 Jan 2022 20:36:29 +0000
Message-ID: <007504A7-BA2C-43EB-B61C-BFDA56E951BF@fb.com>
References: <20220120132006.749016-1-trix@redhat.com>
In-Reply-To: <20220120132006.749016-1-trix@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18073578-5a55-4585-0c77-08d9e4f95c06
x-ms-traffictypediagnostic: MW2PR1501MB2121:EE_
x-microsoft-antispam-prvs: <MW2PR1501MB212164C411A526CBE51715E5AB259@MW2PR1501MB2121.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9DYCmV8gSQkLbSO4GUbFG2ZyDyPcT5ZsCtovEuE78rbe8f3UNoMuzt64WcSpD/TPwHP5Um1s04vHWMONbDKDOOv1Rdip/ANC0yd9q8UNT7j9ds49cJU25uou2c3+qLkll+vW+xZPFQOmni+5Pnw4UqSDKCqoxuowCC4aNl50aaOrcRBleC+ix9ZEiYpHVnWo0LEPhkaGflR7JmSBn+P6nT1+cfqZJIFNzLgE1oj/WZs4y8dXspkpDGz4FN/thWCwX61BU1XSG2uDZceCLUjA+bFSofMy65nnFxDoNEaYkbkjSVCj6Kd4q9jnWkdiYu25IqsfLddJ2ilROPMeWARkPwZnBRIWS37haZQ6KpjAujEYZP/ny1Mt0H7Lid533wd/uq+SBXA8C+S7+qvX6S8hPIKf9S8e18ObgFF1VvI/iW2NYJKDh2KL/B+XzCzmKOETz2Rp0iXx9GsTKVLS8NEeqwEda4c0lwCI0ahGI+GdXOZpfOLpHHE4noRI+9/QBTSWXwYGX8g2Kdq2Nkmi+UT8aHP8C/IuGgp52Ak6My+gGAioWCBfa3/9dW9Mq1P9bOKO+SAGqlwqx243r9XUNgmvksG0QeaN4JraHZoLk7HHi3E4qwYJcG7ooiDe0Jayrm+e13lSXOhsEVruz7YLuF/MArm4W62LhZdjtGKBstNRComL82CDnadMGrReiBHI0kEHdBSDLxgdmEy9pQuApzDJOGoAa9UQI+EcXzkHYlrhYAr9KjkYByJow7j1avmYLrLII5qzHhM87zpNbKYwJqulQSFTO0h8DIyWKd9v4IBTC2CkVxzNt76mPnzgd9RFG3EWMB9wG28dBKoHbxlH/3x1S9lVTZWqSTRqzszG24FMt1U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(36756003)(86362001)(83380400001)(2616005)(5660300002)(66946007)(76116006)(316002)(64756008)(66476007)(6512007)(4326008)(6916009)(66446008)(8936002)(2906002)(66556008)(53546011)(6506007)(71200400001)(6486002)(966005)(38100700002)(122000001)(33656002)(26005)(186003)(38070700005)(508600001)(45980500001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kq74vsEPHbxiKMfKaXRkaKtKre+vdXqkfzdmHLtmQB3vgVI90QUs1y/ZEYDg?=
 =?us-ascii?Q?F+btsnQWY5dekA6ws7JWMbpk5w7eW0RSL5d7iirsIV90ybO23Ah/B+mdkUR3?=
 =?us-ascii?Q?HF7ezNdfawtNvmV8wzj3B+QI6LxtwE4dhm/plQGWbyhXiOA1zYWmtsAIDAfj?=
 =?us-ascii?Q?+OCc+aWjED023bjhS3uMQzJ8tbQNftB7QH2/usEmnnai3X8sHqbQ+YW1Tgt7?=
 =?us-ascii?Q?1i6m0MLuhxde1QopCQ9lyreF/gZa5wVP5VNhJUBVCeLya9LIb26eoZbkp+eo?=
 =?us-ascii?Q?NRbETAdHMnJHqja+0JgeboWllurVkmAbnRf3WxDzE0n/MnefbMDTtgx6cOto?=
 =?us-ascii?Q?4YnNExYgGDA/ly0Y7rPPeFto5C/WJFsttu5dGmTagU/WkBout4jnv62MQrkn?=
 =?us-ascii?Q?wBZC6Wa/xf/mB7GLPh/tFB9q3N7K10rYHeSUDx1uSDS1hKwoAd0EJpbHzfde?=
 =?us-ascii?Q?UgxzEJxCMA3G1r2aufPKzHlndo1dsoCdn0BWgnhoDfNkgwkRNhQugf3DlUqS?=
 =?us-ascii?Q?4VLj6Ce9L9MoX5uAgjNRdYI5uTbNe2X97O8Sgcb/Aeu3Zh0hvNsPRG4tUtKd?=
 =?us-ascii?Q?PQnjIk7jm7F8gEFQOrmkk0bMi01vH8AaZsvzeyLyVNukeUs9exgSgMJ2V+zo?=
 =?us-ascii?Q?1cJTGtNT7MVfyWQUqXp6eMsXrnzD42evXIQYe39ncyR1Z1anFRyiDWpXHOiK?=
 =?us-ascii?Q?+r5IJM8SYCXaKMQkplf8VNLnTQohnR8vRbqC+bfgAhKbseC2bJkAVAhMhsmB?=
 =?us-ascii?Q?Sps488WP8dbcufp7Ie6FPeSs9wH9ScyWcQAdts81hDu0poAKz05dtyVc5VmB?=
 =?us-ascii?Q?8qBsPqEFwN5vrfdSN6OlZDTthKuvwoLEXYeE1cDq7vKkUBraRIplvTriD//g?=
 =?us-ascii?Q?x7PfgAQ2Vu+UdWi2kCIsU/azx3DVY0dqjX/xVCEA15wQKE4TxT/CJkOO4w3m?=
 =?us-ascii?Q?aj3pdR2UuncFV6sVtX3SM9gsJlnImzw6GozgxT8bL7QrRJgN5wO8UpKKUBAb?=
 =?us-ascii?Q?QAABfNzF9OorSPuyquWhrK8brtCECmzay+l8uQO+nrgsOG+Jc2dLDJ4OAgoM?=
 =?us-ascii?Q?ClzCUIQZbQxra8GFbZOAHphcXxfgNVk5xJwCGSxNXxAIdfOfvmXAL1U5Uka3?=
 =?us-ascii?Q?A8DW3PIDtM5Amb/ac0GjAG7+puPO5lIMAyFTeVD0s1SMXsb9gBKVl04DsbOV?=
 =?us-ascii?Q?agrcbuEfiFSwINIBFl6r3Fl5Hcw8laVTVyFbVlQx9UtbNDoEhDuXQBI6p+TI?=
 =?us-ascii?Q?HE4GuMU+UNugaia29HrYUhd8k5OubBLxsjHaMrbS2/CEtXKwTwUqe0SMQpBv?=
 =?us-ascii?Q?zlSCKa6M7evSU6E6NsQIUcENQXtVgeSa6M5GO1dHwNZnDOM+x3mIh0LHt+Os?=
 =?us-ascii?Q?0E6pBhcDW6P+U2/cUhAkZ+c4ByXQKzdbm5JxAEPqRmneIoF9+Cv4idk3MYd/?=
 =?us-ascii?Q?AMtkSQkEg3Tcj4GEX1NKrquNO8jeB3Fi1ZpfuqENHgHXt/tqHb9oTUW1s2uy?=
 =?us-ascii?Q?cn1r08EawQ/jiJHwXa+VXO49Sjeu/k9PuAp5fwYCFRSanPmudil05p0v6r4K?=
 =?us-ascii?Q?LXCwztAnJKhB/yoMRz8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EE6858BFCE3BB149A7FA279A8CD5F22E@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18073578-5a55-4585-0c77-08d9e4f95c06
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 20:36:29.0900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ym85fsEMjRmGQRDUSLjn8n0hKuT8LQAssKYJZVxGP3G1DNzV2u43fn9yGS6OrBoA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2121
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: RszbePa6EawMvi-ThcOSB9BJkh0-RuJl
X-Proofpoint-ORIG-GUID: RszbePa6EawMvi-ThcOSB9BJkh0-RuJl
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_07,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 20, 2022, at 5:20 AM, trix@redhat.com wrote:
> 
> From: Tom Rix <trix@redhat.com>
> 
> Remove the second 'a' and 'into'.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
> include/linux/zstd_lib.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/zstd_lib.h b/include/linux/zstd_lib.h
> index b8c7dbf98390f..6b91758b61af9 100644
> --- a/include/linux/zstd_lib.h
> +++ b/include/linux/zstd_lib.h
> @@ -1330,7 +1330,7 @@ ZSTDLIB_API size_t ZSTD_generateSequences(ZSTD_CCtx* zc, ZSTD_Sequence* outSeqs,
> 
> /*! ZSTD_mergeBlockDelimiters() :
>  * Given an array of ZSTD_Sequence, remove all sequences that represent block delimiters/last literals
> - * by merging them into into the literals of the next sequence.
> + * by merging them into the literals of the next sequence.
>  *
>  * As such, the final generated result has no explicit representation of block boundaries,
>  * and the final last literals segment is not represented in the sequences.
> @@ -1377,7 +1377,7 @@ ZSTDLIB_API size_t ZSTD_compressSequences(ZSTD_CCtx* const cctx, void* dst, size
> /*! ZSTD_writeSkippableFrame() :
>  * Generates a zstd skippable frame containing data given by src, and writes it to dst buffer.
>  *
> - * Skippable frames begin with a a 4-byte magic number. There are 16 possible choices of magic number,
> + * Skippable frames begin with a 4-byte magic number. There are 16 possible choices of magic number,
>  * ranging from ZSTD_MAGIC_SKIPPABLE_START to ZSTD_MAGIC_SKIPPABLE_START+15.
>  * As such, the parameter magicVariant controls the exact skippable frame magic number variant used, so
>  * the magic number used will be ZSTD_MAGIC_SKIPPABLE_START + magicVariant.
> -- 
> 2.26.3
> 

Thanks for the patch! I've merged it into my tree [0][1] and will be included in my next PR.

-Nick

[0] https://github.com/terrelln/linux/tree/zstd-linus
[1] https://github.com/terrelln/linux/commit/88a309465b3f05a100c3b81966982c0f9f5d23a6
