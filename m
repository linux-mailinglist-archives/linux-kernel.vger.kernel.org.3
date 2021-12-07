Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB8846B8D1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhLGK1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:27:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:27812 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229528AbhLGK1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:27:50 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B79A9cL019273;
        Tue, 7 Dec 2021 10:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oplJLGeayVyg+Vd4VZgYnki8gn2zF/yx/ubE30j7AWE=;
 b=J9QpGUQAgIrtA518jKir8QbxUJ2/fKKn6rSN0DDBisjiIhtur9JAMgGy4sAvjoJ0ON8f
 ev8jHkAyO8lwn3bzNjgCnvAuzD/azu38yhHgtHohwatWGfR93h8m+I8m0RjL45JCBruU
 pYaOacLIPdJXz1DFpDY1i2zP+Efu50tT42ff/60VMCx4Su4B0YNc2k6OBugu9a5dJ/Zp
 8LlpZ5FV0JBoTl+5z4Rgqkl8EVhxbDtBxngo69/wIeTIxUcu/pNld3jWoKulfcYKYLlO
 EYFAOuZEUtTuBALyrgLY0jZcGvsAtKunmQfn/AISuDJzY6IfUzaqRAm2x41T6yP/bxlV FA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csbbqnb6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 10:23:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7ALNuU195714;
        Tue, 7 Dec 2021 10:23:56 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by userp3030.oracle.com with ESMTP id 3cqwexeu1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 10:23:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBojoadnGF/eZYqEMvIy+FsQE9HwIu6wr9FRd6VyoomZEZ1BFXpBERzRYFMajaLAlxQkXETOOU0oGZuDb28WzUGDiTPqBGDFHP3ecqhGoaPM38Mfk2/VDAL6tz80NhEiY1RqibF1PTSgmT03GDEXVt7wh8nQOZHyHJNZBHPeWUUhLjLEfCm+sdD9+n4hsPGwFsDTEWlj11MWxMFIgUmtqbMUL08vaXj5C5pQyCiB9XknJjqGN3npsmcrGckgtsgy9487LH134P1GJ+BkcOVZvy57a0242rVD6M9MZSXuzJ2HEBaQJ6uk68hh8x2onRMNKFFoyPMu2ElYBAAJIVD2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oplJLGeayVyg+Vd4VZgYnki8gn2zF/yx/ubE30j7AWE=;
 b=f8OlEHaPfCb5Lxqk+1LJMqYkWVDnlARUGG+UnSPlD76K+DlNGm2xo4rBwKBtB9gfETer5X8nFUOeu2/scb3NviYNJwm+eFGKJ1nYUEOgIgoV0otPki1QCrMns/T0Eflmq5AK3fnzR4yoXvi5FvDFoI/WJt+8fPyvJ+9LOPvUBaZEvoACAaFyjaCloZtgx3W+KpCm5udR0WLemRNZDEFA15MKDbLd+7tjWJ8m089Qax6j6Q0HvWQjyyGdoY6iWGWuIlFdmumKlB9+MDxIibwzRVvWWOpO7SxvDttgS6Go4tu/5EoSHAuo1IYuMWAb7uHCFcIwJQPzFQT4rTv6WO5z+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oplJLGeayVyg+Vd4VZgYnki8gn2zF/yx/ubE30j7AWE=;
 b=JaB1Fl3RpVSlF88GfYb34iZb7c2dZf/5zr/5fWR9L8UOtMQwhfLw5xSc1sXx8QjPsDU1F8P/toQwwZHf2VY+uVYXE8hET8SwKgE9B/xWl4BtlEivtibR58JZOGIZobBfp1nz2MArnDDH2dckCCOuqiNBJlGk6T7woLtA+FKH3Mg=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by BLAPR10MB5028.namprd10.prod.outlook.com (2603:10b6:208:307::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 10:23:54 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::693f:564:30a5:2b09]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::693f:564:30a5:2b09%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 10:23:54 +0000
Message-ID: <bc0baa2c-e747-b290-672d-619d7925753a@oracle.com>
Date:   Tue, 7 Dec 2021 10:23:48 +0000
Subject: Re: linux-next: manual merge of the akpm-current tree with the nvdimm
 tree
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20211207173938.6d619ba6@canb.auug.org.au>
 <20211207065556.GA4786@lst.de>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20211207065556.GA4786@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::18) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
Received: from [10.175.205.145] (138.3.204.17) by LO2P265CA0006.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:62::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Tue, 7 Dec 2021 10:23:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0a7a1eb-8a89-467b-d0d7-08d9b96bab88
X-MS-TrafficTypeDiagnostic: BLAPR10MB5028:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB50289DD73559FC918EAE2305BB6E9@BLAPR10MB5028.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80/y2M2QxgYLiXgFBSCqCj7bIOf4vg2VE+BQbOQ/YSoyhBK7W7dmOxI68XinUQ2WUabQX7tysFTyLP87P7DWORnoJ/1rZnLL1O0V1wuL8dqL82T13XyPnr6m0YGwFXF9uzOlBRi86MgPEFY3AbkZ+OlUgWu1pCAPNb1t9jZxcy4+gWp6qlciLJISeH4618JYxaos1VeHnqNTn8PeY6lQqRYPYZIb6laVpPtT7gFF33QLPzIv+VtsN6Io03yHEQT5wtrGbJ71wv2Svj7b2Zsl0vxLTal/5cSQ9qGcMMzVD7A/OYHU60t2BTe7ww6SbpKkXIl3ZljC229kOGDZTD8WjEFZuAYBtVCu3AczX8SGLc3V7NSNJmOEpBVuO9YBSnsSSH6nDbQeKEaZP+fH8PFNehXDApy4uF8yAk20jBvhOdRG0sgcw7Jy+FuK1yr72lMBfk660e9/mCs41vdhj0Y9j/xvRmrqfO9J/eTxxQLX2giyfu/9pBxtQOvJpshe2Uds7F+MzbyaIb6SRDBE9OJwOuVTERkoKl27AHVVjvvcCaYxrassIQ+oF1SOSBSAOmUgYXkCgwpu9orcfZPl83cT70YwTmudfVskpjxaEbFTmmONKaC6OreySeic4iftTUwJMoERP6cWB396WnrhJ68Lp+dj6Cg46VUWGpT9an0WZxRrJPie/56gCxQlhz/Q9bbQ4mV8R3zEZeunlX3ywaQGnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(2906002)(86362001)(36756003)(2616005)(956004)(6486002)(26005)(53546011)(4744005)(316002)(5660300002)(508600001)(186003)(31696002)(110136005)(66946007)(54906003)(16576012)(6666004)(8676002)(66476007)(8936002)(66556008)(4326008)(31686004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG9haTRNemZKQStvMUlqVDVNRTA1OFlPMEVxS2NsdW9US1ZhUHpkMmZsQm9E?=
 =?utf-8?B?OHBlaEpNb0FSOGNqMHVuaC9FcFM3U25GNERnRW5DeUF1cUhvRmdwdkJGS1Q5?=
 =?utf-8?B?NHBWa1E4TDMxMjUxbldPdGtqblRtaEk3MkZsTmt0dVVNV3N2QjArd2s3N1hi?=
 =?utf-8?B?MlNHSWV6Q05qaXVIY0RhMjlCZS9QdHdyNk5oY1AxRjV0R3RicDZrNzh5d2ZT?=
 =?utf-8?B?SDBNMkxnVGtJTVBlNVBLL3doMTVNNE9SOGQ1SnkwZlMxSklEMHR2blFIMjQ2?=
 =?utf-8?B?dnZaS2pFcDgzNjhMWGRYVUZic0lYQmlVNUVaVVdpZjVtQmRURDZwYk51aXlX?=
 =?utf-8?B?V2VCUlpKaUVVdEJ1SkhxRGhHOFlLSlFBNE9CVDRlaFluSnh4Q3JHSUl1Z0Vy?=
 =?utf-8?B?VmFFdzFDc1QvalVpTXVob1hmNUQ3VG1YYlowSk95UDNwNG5JdEdkYTRGSUtU?=
 =?utf-8?B?YmI1cWxEZWNDQ3BNKzZkWno2WktrNDVVNnZPckV2OWtNWmp3cFhFVW9ocHFt?=
 =?utf-8?B?YU10K3VIRWFnRHlXOWhFdE03REU0dXFCSzNldXVZUjRBcWRFVDNoR2dycXlj?=
 =?utf-8?B?aWtaQ00vTzFYbzRGVFdybFdaSFEwU0N5UzB3Ui9xU05SbzRHU2N2ZVVKNVJS?=
 =?utf-8?B?YmVaK082SHVxMFlCZ0psNVowYVcyVmtzeldqY3FkUlB5bzlqWnJtdTZnNXhp?=
 =?utf-8?B?cm5hTGF2TlRZK3N5cFNMdWs3WEk3T3RvcWl1V3JReEJJc1NDMittd2RPODRP?=
 =?utf-8?B?SnVwZmlzQ09QY25UT0NHU0Ric2hacjJUV2pZQ29pNldHR2NVTG14d05ScHZ0?=
 =?utf-8?B?aWo4TWFDS1pVcDRGRUxiUUpBbHN4TUZvdFJ0L2RoSXRkWi9BZkRWeDhqU1lz?=
 =?utf-8?B?c2lUK25oNFY5Um5XQlpxOUtVaVdmNDl0RnBTZWhqdmhvNTMxT2dqWFdmNXNO?=
 =?utf-8?B?dHN2TXN3MWh2ajduL1lRZTZVWkxsOWpHOFlzaFo4MnNCb3V4OFhvNHIyRXl3?=
 =?utf-8?B?QU5GbkZlL3NyRnh2RTB0RkxFQXZhTlNtVUxmZE5BaDEwZXZYcUlnQVI2eXhP?=
 =?utf-8?B?U1pwOCt0cWN1ZU5Mc3dNcTY2SFVjZlJXMWhVSUlKMjJFdjRhRE1kUlc2ZGZI?=
 =?utf-8?B?K2MrRnF4eFU2c2RBZnNKRjBMY09zVFk5aCtieU5QZWFNUmdHUGNKYSt2Tm5i?=
 =?utf-8?B?OVR1OHlNTWhSdElrNDFyVDJEck05blp5MWYrLzIvTUNOeDdieXBtd3liNzJ4?=
 =?utf-8?B?bjh4RVJwYU1RQVF6cjNGbi9BcHVLQnl1bVd5TUxMZ204MnppRzNTaEEzQUVj?=
 =?utf-8?B?ZEZTWDMrMEY0WHY1dzdCSDhpVDRjajVCVVVsZUZJbi9wVkJiM2d1QnQrb2tE?=
 =?utf-8?B?eEdPanJ1bHpCS3JvNmZETG04TDZQbGNRSkwwcXhXQ2x2MEEyUTRBekRMeWcx?=
 =?utf-8?B?Y0s5OGwrSzRjOHEyRTJpajZKcGtEVjMxUUc5OWNnTkMzNmplaklqOElSbGp4?=
 =?utf-8?B?RVk4UGNUOHJxWDNnKzJOQXNtS0RKZkF6aUZ6VGk0MHNrTFJRTW1ocUtINEFu?=
 =?utf-8?B?dWZHemN0MzdhZkErd1VmL3BIWnB2RTdvbjU4c1RnckdUM2JmOCsyU3pMb2lS?=
 =?utf-8?B?RzBnR0FBWWlLTzVlNmU2WGxTUXhZVndYSkEzazRLV0JnTXFEbXhaVytMN2NG?=
 =?utf-8?B?c3A1ODRQUmlzTHloTlpieWUybFIvRzcyNkREekVtTUZaZmhoenJCOGVXT3pt?=
 =?utf-8?B?eXdSazRPM3A0L2pNTW41dHNHc1A0TWlTSndTT29zek55aDZiM1hjeWNCTWR2?=
 =?utf-8?B?WVAwN1hxU0dmYXo0TDNmTWFPM0JTUGMxR2NCU2VUM0hTSWxmOTJ2YmoydFhn?=
 =?utf-8?B?dDdQekVwY09iSWk1Vkk2bFRwTmJManA2VmpVdTRURGxFbHkxVkhiUHJxT0JY?=
 =?utf-8?B?UkNGaW1DNHFwbk4xaFFzam41VkpZTzNjaVZnbmNQQ2o4ejJrYzhIY0Nsdzlo?=
 =?utf-8?B?Wmw1Q2tPOTJQK3BWRjEyb2NUYzA2ZXE0NWd4VzByV1p5OGFVWS90K2VvRytB?=
 =?utf-8?B?K0lwS2plaTZZcEp2M09nd0huV1p3ZFQrVE9kVnRXWWtGcUV3dU5aTGJOMmVM?=
 =?utf-8?B?N3FaWWI5VzNoeEtkY1M2M2NjRDY3Mkg4bXUzUnp4SFRUbmx2ZThKa0tlTWRK?=
 =?utf-8?B?L3BMNjZacGtMd2JnbnlXaTJwWVFocnFxc3VWODg4TzRZczIrUGdHNGFob3R6?=
 =?utf-8?B?eUhWa3huWHhZVndjTWNlQTlkV1R3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a7a1eb-8a89-467b-d0d7-08d9b96bab88
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 10:23:54.3125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JiI9ZA5iWj/8agO9/g80nOSjsTN7peJhMpfNybrqg2S+LVxqhaLQejOID7x2y2mPUMKAge2MOMyIWHjrK5Kw5uRxkw2nvOqxpoRTohVDVbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5028
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=782 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070061
X-Proofpoint-GUID: 16pDhS9No2Xm6osf8f8GebTXL7_7gd47
X-Proofpoint-ORIG-GUID: 16pDhS9No2Xm6osf8f8GebTXL7_7gd47
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 06:55, Christoph Hellwig wrote:
> On Tue, Dec 07, 2021 at 05:39:38PM +1100, Stephen Rothwell wrote:
>> Hi all,
>>
>> Today's linux-next merge of the akpm-current tree got a conflict in:
>>
>>   mm/memremap.c
>>
>> between commit:
>>
>>   b80892ca022e ("memremap: remove support for external pgmap refcounts")
>>
>> from the nvdimm tree and commit:
>>
>>   30156644eb0d ("mm/memremap: add ZONE_DEVICE support for compound pages")
>>
>> from the akpm-current tree.
> 
> The resolution looks good to me, thanks.
> 
+1, the resolution looks good to me too.
