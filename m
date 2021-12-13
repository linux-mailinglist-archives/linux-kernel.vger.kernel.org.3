Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04B3473078
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbhLMP3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:29:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42780 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233642AbhLMP3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:29:20 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDEn2lh027482;
        Mon, 13 Dec 2021 15:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=zTT3EgOCaBVx3Yd8AM7PuDlbF/y2Vjjcw1If8RtzBwA=;
 b=JwPU+0Lycq4cCQ7kjJvYJpLs9yO0/xUCdWLzI8ffV6JfakfnTyvnYYq71/FJx2p7nG5n
 4qJ1GSIxyBLz9h6ElTW3Is5K9W51IJHf1JGdfEm5F7gDfHT+N+yRcolqImW9mj+VTMoy
 NciW/vmiOK9rVB+UHA0BzDQoNJSi+w873AEg/Bk7aoX7l4WJqgT5DCP9M4RbfWv2sIar
 +InEEJbWRTbCxHHpuXmRjFiuD8g1dtmV9YpGYJS7ltpDdbYr1pTcZRcz537v3O1lVua8
 fMvBo3+KkcwjTNWQY7/cceoU425G24BLlHOEuKNjzLzks9ay998H1Ypniw+3aexK3oP8 KA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx2nf90da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 15:29:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDFAQRq096692;
        Mon, 13 Dec 2021 15:29:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3020.oracle.com with ESMTP id 3cvkt341d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 15:29:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwRCK2Ew7B6speXubN1tzdJGS1cqnV809KYZqQ5Ii6jQXnJBOEhX7DxDibE4ZU6qX4x04jwln28PKjjUKsWrrzwfmYzEFA/6PRD6QJDYSsVvFi7W5RV4tKY0xq2OIIVY2NGysz/rzShhGyzKQ/d3N/bW0IMjE6QYxTjIM5w/L8YnbYQDXagEagUeKsPHIw9BVz3NlMmDzTPH2edg6nyAvJhnru2R7rxfTBiOdbVLUtdzzaO/+W2eNvwvPn2wxRXLRihcKthuwtFiWYiwhNxSKVWHmfhKiWenPNGSzWggl682rca4jTBJHGsMqpORo1c08tJXJxwBubBcaH/3XZNDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTT3EgOCaBVx3Yd8AM7PuDlbF/y2Vjjcw1If8RtzBwA=;
 b=Ux7TPaBY4boagbiT4wcc5clUxzeJQohTZtoLajaHjsTnY/85T+O64x5111wtkFDt1GszJvzbdMYIgRQhkyRWfA08Ourm7yXMUcNqtmNP+/C2eTgo7rrFJ2npTcSaoWoPhXwJIbzw2J6Y7XNi8oOUJVXxycFjyeyvHmpageOocf37ImNYt5WbKVPukqQgfHEt0PV+616ENdzTSPiiyk0oAirqnFCGJ1W7h2kVUqEaCsU+3g2xtQOPiMHLVv35nBwjGbH0Fomb75If8WgPSx/1ZnytR/j1r1y6D1itKWcTmh74i6wARVDUsUsfqkwRuB96z+drkE2l/VbSvz4uQTQ49Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTT3EgOCaBVx3Yd8AM7PuDlbF/y2Vjjcw1If8RtzBwA=;
 b=aYeHP/TREvgtX9t8w2T4Mnc9QkmpEup/tVsUS7KWJqnE1FszSx5Kh2H86AMrJy57UwbF1aHfspQc4kCsOMcWS9anVA7qtAo8qf1jHELCqlwhKEBXIjWhriN84C/IrBxCsG0/gVR6Me5EG77cT7/lJKROz5aYJWLTg9bZl09ej90=
Received: from BN0PR10MB5192.namprd10.prod.outlook.com (2603:10b6:408:115::8)
 by BN0PR10MB5062.namprd10.prod.outlook.com (2603:10b6:408:12c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 15:29:12 +0000
Received: from BN0PR10MB5192.namprd10.prod.outlook.com
 ([fe80::4440:4f39:6d92:a14c]) by BN0PR10MB5192.namprd10.prod.outlook.com
 ([fe80::4440:4f39:6d92:a14c%8]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 15:29:12 +0000
Message-ID: <8d91b763-f038-af05-8917-6bec2da186b4@oracle.com>
Date:   Mon, 13 Dec 2021 10:29:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     "geert@linux-m68k.org >> Geert Uytterhoeven" <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
From:   George Kennedy <george.kennedy@oracle.com>
Subject: [PATCH v2 RESEND 2] video: fbdev: cirrusfb: check pixclock to avoid
 divide by zero
Organization: Oracle Corporation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:254::29) To BN0PR10MB5192.namprd10.prod.outlook.com
 (2603:10b6:408:115::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27b3006a-d1fc-4f6f-a8cd-08d9be4d50ad
X-MS-TrafficTypeDiagnostic: BN0PR10MB5062:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5062214F65E59B6F8D70F7C7E6749@BN0PR10MB5062.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OG1kR2LVChBBifJy5LZzMSKek1tRfmMwDx5PjPPIwwAHkTGaeAsn9ZZiv7erQfkL5ZXs9jc81nbkCKFqpeNx8qIx6HnCuMEMF29unL/M9AHUNy84oTA+B1vxRddqPwSV+IFg4DUaqbkazwy6o+kMq9DwDB4Q2GLHdQWVgDm/hwz3SyJ14Ws22bOJyOqw0fH9H0EbNzCvB7gAL3SQcLWjDRYmiwxJ51MojD9lSVBemEc0/qIWl3s7WwDEFgpQ6WsiOHRNhAJPEc9JD+RGgpRFObVkyq0UtcdHxZs+Zf38UbUJkmq6l7/QsDb6GBhRuZIH+eWjz82S1BWK44hIB6/5/G/HOy+aJ+FP4RMxL3zn3ia1hCRXPUmP8QE3gPZA4gfesqMs3PsBMvMgM4hDKDnlgW9Gwd7qlz75CJhIYGnGOZ1F9FABDfxyZPw6jz14PbNVMTNXF0B8vhlh1ulysAN04DLjIr6f6wFSp6aHS+DIyW66X64BsidZjSWCO5GYciKGS+hd5cxcba0thxrbPeHYL+tCPoc3WPLyYW37V6NcwYB7HLFNRYzFGhD65C1IsW8tITagM8fN3HhoUDuyhQWvoJCfrIXNNfhykC0zg2FHufVsf05u0rBnTBdOVwN4cyT8wVtojxIu3Zy/gftWzrs7NgP/S+VGefqAxAAYIs8vnkiqFdm7CTumyr4T8BSgDAjTN27De17U0wGNION5M3V5eLUgedAKMaSo+3tQemXd5GK/kqYrPGMf7qKmticFgeu3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5192.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(110136005)(6506007)(6486002)(508600001)(6666004)(4326008)(86362001)(31686004)(2616005)(8936002)(8676002)(5660300002)(107886003)(31696002)(36916002)(6512007)(316002)(66476007)(44832011)(2906002)(38100700002)(54906003)(66946007)(66556008)(83380400001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlFFYW1GbzV0d3lCKzF0R1YrQUI4NEs3ZzUwYXFJOHN4NjFNZmxTbG01UTFB?=
 =?utf-8?B?c3VyWDY1SDFjbXB5QkIxZlRVTkV4SC9TcEFLMTVRZ2dycWZCZlJOc1VTRWVq?=
 =?utf-8?B?UVdDWk1EZ1hyNWUydG1IckI0VnF4K0swc2h2dlNqcHZQcmp3TzMrNUpRSlZr?=
 =?utf-8?B?L09wN2hWSVd0RXVIT09XcVZ2QUhQTkg0d044WjVMaHBTdWpZbVJXcmhnbjh4?=
 =?utf-8?B?am52T0lzVG1ka2d0citFMDVsejBLNm92UlJFdTFVempvcUg5c1U1eTJ5SVJW?=
 =?utf-8?B?U3ZRVWZndVhmN0E5bjN2Z1Q3MEl1ZEpBQkxNbWRTNVJhU0t0Y1lkUDhxcHBX?=
 =?utf-8?B?SmVtMkRmRFE4T3RPbUhVWi9nRm1iMi9HVDRjSWlocTR4MUdjWjJ6bzVEUnRJ?=
 =?utf-8?B?bncvSXZJT1dCb0J2V1A3QWNKa0pja1BMWjNEd1dPd204M3FqSGhFWkFTRnk5?=
 =?utf-8?B?V2FNM1BlU0o0OE1nOTZrOW5nYW1tOVByQkZWa1Z6bWdaOVlhU0NpMnMxQm00?=
 =?utf-8?B?eTRUeU54b0dVWCtjL0N6Y0VjYTdHWWJERHdBV0lhemZHaEg0ODVuczR4bUhI?=
 =?utf-8?B?a0E2QjVGcER6ZDJ4b0t4ZmJZelZIcnJzaFY0ZkdsaUpuUDgvVzV6c2R3bkg0?=
 =?utf-8?B?azZTZHloWFJkdHFRSFliNXluVnBmbmFGQVl5bkpQSFhmK0Q5dmhwZjB1bG5M?=
 =?utf-8?B?ZlpVYjFkUEtZMFJYMmhWMWM0ejRtdFkzdHFpWjJXZ3ZLQXowVy9ZbmlQSjNr?=
 =?utf-8?B?VThZVDlkeEdpdEhDcEZ3OEhHRWtXeFhMY05vbS8zelFFTVR5UHpkaXFJVUlL?=
 =?utf-8?B?OFBhM3E2cWNZVnJZSkYyNnlMR3RHV3I5TFg4aDZPbG0xeEdlMEt5bjFobHZE?=
 =?utf-8?B?REJFZC9HampGbXB4ZHVndDVHbDlGWVVGVVhkQmNlOEt3NmU2c1JRM1NpR1M4?=
 =?utf-8?B?YmIwK0taM1I1alhqNUFqWHFMUVAyL0VYdjdzVkNXd1FDQTczZ2k2elN5Yk5n?=
 =?utf-8?B?Zi9GVHFKbUZvV3ZVcmc2SzRoRHBKS0NqbW9iS051b3VTbUI1NkJFRkxRaTE2?=
 =?utf-8?B?enRNU1pqVE5XMzU4WVhVZ3ZaRjAyZ0w3R3lPZDFPRFY1NEplc0FQNmNDd016?=
 =?utf-8?B?MThuSWNhS2NQVXRCQ0NQd0dVbW5BNDRYR0M5ZWpkZnQwSWV6SjVseWJ2VkNR?=
 =?utf-8?B?MEJMTUM2QWZqSHhwSElzejVSK3laN0FrUTVkWEZxMUorbTdaUlI1SWNOeTU0?=
 =?utf-8?B?bXhvT3BjSHZVaW9tdG5xWENtZDNxdldTaUh3ZEw3Mytqa01QTUFGZjdTcnU2?=
 =?utf-8?B?SnRzeFlNd2w0L09SM2JUQ1R2NkZyRmF4UUp1akRBZVJ6QU5Gb3FadlpSWUtO?=
 =?utf-8?B?YlZNSWN6VUJHVDB3QjBJeFBqam92QUE3VUJlb1pQc3A3USt0dVNFVzNMSCta?=
 =?utf-8?B?bUZIUVphQVZ1RkJhZFUxL0l3QTlXZkZEWms1azdCanRBVVJYZkZjaVljcTNz?=
 =?utf-8?B?OGNuT1FpMk00MndRRUFsbGF0N1FhN2NWZ0Qvem03UmVXRWFFUnFYYXphcnhS?=
 =?utf-8?B?S01NRU0yWU4rRENqMFdFNUlGZDJYekRQeUE4amI0d3QvV2JoYUQ1a1IwTWhj?=
 =?utf-8?B?ZU9HV25XclJPZzJjZkpwL2h0VDAzbkpiaWpwRWcyM0lWWDR4NXpodmVRZDE3?=
 =?utf-8?B?MTYvNUxSNWJreldyVmJZSUgydjRqRG1lbHFwSkJVSlYzMENxdFF4MC9obmlV?=
 =?utf-8?B?TEFoRUg5cFRrSXNrZEhRNGhuSmg5T2VWUFR5L3ZDNkF2c3kxazBNTG91aE9B?=
 =?utf-8?B?SzBxYlgxWEs3MXlGMHNtLzV3dVBRaFQ4WHFKaWR4VUpDZ2o5Wlh0VitwMlRJ?=
 =?utf-8?B?MUJpOGFkVC9jSzZCSHNoR3lPQVg4S1F1MjlFWXYzbVBiNHJVbmdCNE9Qay8r?=
 =?utf-8?B?ZWlUZkZCVEQxbmV1enJJOWp1SmY1WnExMTVSS1JQNVNVeVBrc3dGNE4vcUtn?=
 =?utf-8?B?TVpwcmY2VkwzbUtuY0RUQTVWaG9pOEhZOFM4cE83Um0xYzM2eE9TeXREM1pJ?=
 =?utf-8?B?THphbVZUc0NwU3ZybURhQVJza3dSUVNJcC9oMVNLU0V6U2sxQVZZYWhlaHQy?=
 =?utf-8?B?RXB2Z2RlR0FLd1ZzaUdzSW5qNlZ3cXNEZDVQcDEvN2lybmNrSmgzWjFXY0ZG?=
 =?utf-8?B?RmVRSEgrYTBLTTJBbDJwMmVEbVJmbmozWkU3TzV0Lzd3U2J5SmV1d090aWZQ?=
 =?utf-8?B?bzBmZldxc2k5SG8vOEYyL0VncUd3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b3006a-d1fc-4f6f-a8cd-08d9be4d50ad
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5192.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 15:29:12.6203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+7i2beIKfsWnYW8wAD7K2pQ9AAYc9DRZcZDsrUNrE9OkBTHFLjFB/fSk2Bp6vBvmpADlYkVlDaa7Cr7LIBvreEe8lqzvW4saB1ZleQ6bY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5062
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10196 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112130098
X-Proofpoint-ORIG-GUID: bW0ytRJXY2ku8OnStMuPlpa40RD7yBDS
X-Proofpoint-GUID: bW0ytRJXY2ku8OnStMuPlpa40RD7yBDS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do a sanity check on pixclock value to avoid divide by zero.

If the pixclock value is zero, the cirrusfb driver will round up
pixclock to get the derived frequency as close to maxclock as
possible.

Syzkaller reported a divide error in cirrusfb_check_pixclock.

divide error: 0000 [#1] SMP KASAN PTI
CPU: 0 PID: 14938 Comm: cirrusfb_test Not tainted 5.15.0-rc6 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2
RIP: 0010:cirrusfb_check_var+0x6f1/0x1260

Call Trace:
  fb_set_var+0x398/0xf90
  do_fb_ioctl+0x4b8/0x6f0
  fb_ioctl+0xeb/0x130
  __x64_sys_ioctl+0x19d/0x220
  do_syscall_64+0x3a/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xae

Cc: <stable@vger.kernel.org> # 5.4.y
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: George Kennedy<george.kennedy@oracle.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Hi Andrew, can you pick this patch up?  Some of the fbdev drivers have
maintainers but the cirrusfb.c is basically orphaned.  I sent this patch
in Oct and again in Dec and no one picked it up.  Geert has reviewed it.
Obviously the original code just crashed so this shouldn't be
controversial.

v2: Geert says that instead of just returning an error, this is supposed
to find a valid pixclock and use that.

RESEND: Added the Reviewed by: and Cc: <stable@vger.kernel.org>

Thank you,
George

  drivers/video/fbdev/cirrusfb.c | 16 ++++++++--------
  1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/cirrusfb.c 
b/drivers/video/fbdev/cirrusfb.c
index 93802ab..3d47c34 100644
--- a/drivers/video/fbdev/cirrusfb.c
+++ b/drivers/video/fbdev/cirrusfb.c
@@ -469,7 +469,7 @@ static int cirrusfb_check_mclk(struct fb_info *info, 
long freq)
      return 0;
  }

-static int cirrusfb_check_pixclock(const struct fb_var_screeninfo *var,
+static int cirrusfb_check_pixclock(struct fb_var_screeninfo *var,
                     struct fb_info *info)
  {
      long freq;
@@ -478,9 +478,7 @@ static int cirrusfb_check_pixclock(const struct 
fb_var_screeninfo *var,
      unsigned maxclockidx = var->bits_per_pixel >> 3;

      /* convert from ps to kHz */
-    freq = PICOS2KHZ(var->pixclock);
-
-    dev_dbg(info->device, "desired pixclock: %ld kHz\n", freq);
+    freq = PICOS2KHZ(var->pixclock ? : 1);

      maxclock = cirrusfb_board_info[cinfo->btype].maxclock[maxclockidx];
      cinfo->multiplexing = 0;
@@ -488,11 +486,13 @@ static int cirrusfb_check_pixclock(const struct 
fb_var_screeninfo *var,
      /* If the frequency is greater than we can support, we might be able
       * to use multiplexing for the video mode */
      if (freq > maxclock) {
-        dev_err(info->device,
-            "Frequency greater than maxclock (%ld kHz)\n",
-            maxclock);
-        return -EINVAL;
+        var->pixclock = KHZ2PICOS(maxclock);
+
+        while ((freq = PICOS2KHZ(var->pixclock)) > maxclock)
+            var->pixclock++;
      }
+    dev_dbg(info->device, "desired pixclock: %ld kHz\n", freq);
+
      /*
       * Additional constraint: 8bpp uses DAC clock doubling to allow 
maximum
       * pixel clock
-- 1.8.3.1

