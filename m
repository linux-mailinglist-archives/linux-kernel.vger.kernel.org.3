Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E8F4A77D7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346585AbiBBSXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:23:06 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13486 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234473AbiBBSXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:23:04 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212HY7Vx009705;
        Wed, 2 Feb 2022 18:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=zTT3EgOCaBVx3Yd8AM7PuDlbF/y2Vjjcw1If8RtzBwA=;
 b=d7mXZ1ZXMDf39JOBzKW+BQlAKhBTnr6bR1XwZNnFkVpFkecdCGkCvJQATsaCzNKHxisD
 vBGi26bcU79IKQzVBcSFhO+NQ7Ytsu7lq+2up1HuZGb7KrGPerBxEtn1xpSymEaM+dlw
 icpP92sBzMQxA7WMdF/cOVZqPawbbTZUtXCtAXcfnESiQ+L+r5/leXADvoMJ7cmwkPt2
 spui8kyx8mc05Ok0wxWuMvoZ+d6TtJU7N4M42Cv+4WEtrgTFZqX1zR6hORensZuVmRdq
 M8osN/q1L+gy4+miKD6kO8je18RzC9xv5bEMbIiZVZTF57UEMjdfXpT3oXN8HOZhWdD2 Jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fxxhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 18:23:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212IBTQp008222;
        Wed, 2 Feb 2022 18:22:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by userp3030.oracle.com with ESMTP id 3dvtq38j6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 18:22:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQfoQMTiQn5O9NJEHbdfIaG6YMdYw0z1uSPtvd0KDaa49msBKnoUev7xh+owHmFqnEG1R0KJ2DPm9ZMJaI4AB+b4AetZyUCGLhi5FPVWtYzonDbSEMoBXkN2K2cNHdqAPTvB+KwsIaj0U6Ld+RQIwbKtHbjNx0/LevjCZOCiB68YSeySUhWA/PndKHVBeTCS81Xh2gQfocrEaqtnPLxhMui7CtNc7NP+LJJVIN06MUTypds/h84to9IWiRUdMMbcjENEJLEnJCxHGf9qBYNSYqujuP9b2euFuRHf2gJ8Oy8rOrjBEpS/lteXCODLYmZasPHDfrCKA/Yg8l2ty8OtQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTT3EgOCaBVx3Yd8AM7PuDlbF/y2Vjjcw1If8RtzBwA=;
 b=HJBFgJ++Hn+aLBAIOSOIt4BUDTvBSftc1dqgt5Gmuyyo/k9bfu/5LEajeQ8It7E6UPHN67M1ej/nYO0nv1JRTG51j3Bq4RR8NTw+QJz9ssMxyzQ5LaSfVuMjSHe33c5UQb4Y0yvkRTq170jPxTOCD4NxM126lQl1P+jm+ymSggaXIDtKnXeAt7QaosthLpjwQTdIIl7XTJ51lhjzupTcYQrCMBbn1rS3UwiNCw4Z+8VNw/OObKHSGVTEUapJlDDahjtD9VDgENCIif7T3gdLqLigRxNcMo31Lz4vtC2dqqLrsvCaZPis5n9dXIKMqODzgieRk9PjazJ6RJkfFjFMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTT3EgOCaBVx3Yd8AM7PuDlbF/y2Vjjcw1If8RtzBwA=;
 b=nloKrzg+7alVsX5trc1Ufi2ad8BRh+r8cum1I8aZIqPEHzKAwvyobwPvovPKTPmp/osWWm/ffBuOhoHjImrQmSDfm0JdDtn4lGQ0/rEyM4BvVJAhigriq9eEoHMPUw8QFHpSf/I10qUzvmq7K+rg9qJXGgvwxZI09Gjqr+jenbg=
Received: from CH2PR10MB3752.namprd10.prod.outlook.com (2603:10b6:610:d::23)
 by BN6PR1001MB2052.namprd10.prod.outlook.com (2603:10b6:405:2c::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 18:22:56 +0000
Received: from CH2PR10MB3752.namprd10.prod.outlook.com
 ([fe80::d5e7:fe0d:ecda:1c93]) by CH2PR10MB3752.namprd10.prod.outlook.com
 ([fe80::d5e7:fe0d:ecda:1c93%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 18:22:56 +0000
Message-ID: <87838c92-484e-d9f0-4840-f9e9db712c9d@oracle.com>
Date:   Wed, 2 Feb 2022 13:22:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
From:   George Kennedy <george.kennedy@oracle.com>
Subject: [PATCH v2 RESEND 3] video: fbdev: cirrusfb: check pixclock to avoid
 divide by zero
Organization: Oracle Corporation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0143.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::28) To CH2PR10MB3752.namprd10.prod.outlook.com
 (2603:10b6:610:d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaebad79-67f1-4377-644c-08d9e67908f9
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2052:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB2052C7AA0A1A3360D0343762E6279@BN6PR1001MB2052.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yIcAaWvdUQzgLy3z+XN1FRsa1XCL1KNMsrngcXKJd2JLdLff2q/LeoEb72cucYaCCXP0iUBn18xBI1Hex2U6CNH07e2ScLqRlKkvusRW+ScNfPH1bXBNEitiV9hkQ8jhdHDBS7jcUaGFpg0gEh/vuqwegwT9Bau8D3aD63xYCIRMbrxsL3P87A47A0LjcopYeVy2V2wXr1YCDRohMeWdMpnU/TY5z8KrvvcCtGs+MOlZp13Py8L5hZyp5sUetKCozXBbtiXwaW8PO667sTgo5pEn4ZJyrKDHPiD2mMJkU25YphXxIkAzasnkXjdLORbIE6E+bs74oiZ9Avba3X41giTp4Dl2F/3VyH8MkqsOVusr6LM6mK5/McgWV4IKIAmYvfEHJBSdK6I5NmfUioIGVHM2hdCRAxN8j1TSsicHgojgOi6y8L942A6qbC6cJSg4JDXupIhjabLLoAvjTJJ0xC17KqQi/FS5O6oFsMegrzTkJq7x7L4kqjNIlDFZn0NeVoTO0iMPmTp7+fdg0oXmmqSWuK8iD/NUAB/Kuo/22Cu9aBWSJPRHRkOPSeaz56zNFiEt91VGM5l81yGC6z8XQ0WXTOnp2HsCvKtxyzvBeYJTzPKmIo1co+koljfZc0CshQUDAd8zWTeOgVxFB7rp65CQegSm7U+t9SE8JYpOHGeIqeBXuaU/djJyO25i0eDCx7j/FbLjc4jzzuWk6ZCf6WkEl+gxjI7t+eGotEQSRI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB3752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36916002)(6506007)(6512007)(2906002)(38100700002)(83380400001)(2616005)(107886003)(44832011)(26005)(66946007)(66556008)(66476007)(8936002)(6486002)(186003)(31686004)(508600001)(8676002)(4326008)(86362001)(31696002)(54906003)(316002)(6916009)(36756003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmR2alNhUmwzcEVTUzROOE9GVmtSTGR5NTRuKzU0OTZpR2JVeU9qTlhuOXF4?=
 =?utf-8?B?ZWJmaFNnZFhLY0swcFdMd2xoRitBam1qUkVYMHpDZTJGRUV1MDRvaHRrYU1C?=
 =?utf-8?B?Q2NHc3VHa0FVS21ObUZYS2R5bWYyRVViNDh2a1RSTUorcVQ3RUpEcEhJT1lo?=
 =?utf-8?B?dDc3Q2tWdk1wbXFIa3JPc2NoZGg3SjJMamU5UnpteUxQajl6TVVjcW5wTzNL?=
 =?utf-8?B?ZTh2SkFndGRpTXlzVXdUMndvTHlnNEgrSjZHaE03Q0NBVzZ2SU8zVSsxM2Zn?=
 =?utf-8?B?blZHUW1kZWl2THRQU0JHc3IwZDNQNWhRb3Q1U0pndGcrQU9FVDVWVSs2OFdO?=
 =?utf-8?B?d21FQ3FsZlVaekM5NThTaU9jeE1zQkV4bStyMWRhWTIreDBydkNvbEZMcHVk?=
 =?utf-8?B?QlRuTGhNVHY5bUdET29UV0RQM1hxR0I1L1lMQnMzbHA4aFVXeTRYTVNEc2dL?=
 =?utf-8?B?eFdnaVV4Nko3c09qMEhwMlhiTGlOZC9FdENIQmNMTlFyeTJ1NHllZFBuaElo?=
 =?utf-8?B?d3BlWUhBR1FMbXJ3M29VZFNSc3AvbFBzOGdQVlZwVXpTNSttM0M5SS9VdG1l?=
 =?utf-8?B?MWR2TUdGZGpRdzh5dVdIUUNJRjhrVFdsQWp6T1VDQWIwZ1BUQ2Z0L3BPTnVC?=
 =?utf-8?B?bUUwbzhxMFN2eUI1ZG94aE53ckFTU3VZWmNWZms4MEhlaGtsS05SS01NUkYv?=
 =?utf-8?B?cUtFVERwUzE2NE4vQ3BybVlBVElvSHRQR2d4NXdqQWozYXFwM1dvZkd3TGpN?=
 =?utf-8?B?Yk5qdGxsRHVHcTg3ampiMVp6enU4Y1puTy95Si9zYmYvZFBiNW1HVHd5ZlIx?=
 =?utf-8?B?WldCWkE0ZUsxL1M3ZHk2TFhUWERtRXFuQkc0ZmFkMVZEQU9TclIrdFVwYnJv?=
 =?utf-8?B?SFFaTGh5SUowZzdWRlhLZERlUFhZdlN6cmg3elhPWm9nQkpmeEJIY3Bua3Zp?=
 =?utf-8?B?cUpoYnFpNTIxYXhJTjRrOUdoQnJlK1JaTU5pWmVkK3NpRE0rUG5QRm5sVkVJ?=
 =?utf-8?B?TWpDN2lLcnJVMzJSTkZKQzZtSkVIY09RYTNlaHFmOHpBdkRUeDlhaGduMzZZ?=
 =?utf-8?B?RllSb1BYZk5oUkVxWlVScjVHeWhpeVA5SEtJRUM5K1hDd3hKNk5pUmlpZzRq?=
 =?utf-8?B?dEdmZWFYSUo2ZDZpMGxWUzlUVDBsUEd0TWFUWnQ3bXJrbUJOUW4yUWp4aHNJ?=
 =?utf-8?B?VElDU0JCVStoSEc2ZnEyTFFBTU1OaisraThLYitsVzVKTUNrS2N1a2lFV0Zz?=
 =?utf-8?B?K1B1ZHBwWkF1dFhTckdGVldOc0diR2xnVUVwODVOZEtVQzBzOEczdG02YjRk?=
 =?utf-8?B?VGVWOVIyd1BWMTMzdUlXTXl4N3JmOWVHLzdPV2YyTG9uemIrRzE5ZGQyYlNH?=
 =?utf-8?B?WThqSy9hd2R5MVowYjE4SXVPMXNManJNVVh1YXRjZ1dVRGo1Zkl2NGpOQ1Rm?=
 =?utf-8?B?aTVoaGV5Y3RFOVhKTUtmdkRWbTJySVlWalRvVWl6WFprZE8yN1RtV0dLdG1R?=
 =?utf-8?B?QVYrYmRXUmdGclk2QVFjL2FUYlNGN1dObWN3Nmh2T1dWak0wK3h5eFdEd2kx?=
 =?utf-8?B?REgvT1h3Q0pOOEhzYzZXM0xZRmNHb2h3RjV2ajhXd3NPcEZDamFsNnVNcnVx?=
 =?utf-8?B?eWlFNmtoMTRtNTg2SFpLcEp2N1ZNNlJrb0hMb3JZMk9ER2lTcVlubDdSSGov?=
 =?utf-8?B?NEpJdU9CTXJkZU1GRU9FZkVYbnFkWkRFQVFmZkVqQ09GMWNxM3NXSzBEZU5m?=
 =?utf-8?B?SlErMmtmNjNCZzU1OTNOQzVVdzZ6ODJoaHg3VlRacExNMmhrSkVIaEZINExz?=
 =?utf-8?B?WHU1SXRFVWFmNXdoaUxDVndmMzVFUmhiU285VVYvTlIzRVp2WFdsYmRvUzFU?=
 =?utf-8?B?YnZ5K084azc1TStsNDNLOXNMSFhlM3E4dk1jZTgyR1QrU2drd01HanI3dHFS?=
 =?utf-8?B?WHZmbXdLd0VrZHlMUkNEVCtJbkxvK2UzV0lrM3F0VlliRFpZZ0YySmpxb2xr?=
 =?utf-8?B?elMvMVhkLzJrZFF4TEZnMDlkVkdaeDcxeE1Pckk0OFh6elRuaU9RWmZoMHhp?=
 =?utf-8?B?L0VYNSsrSmtTTDBURVRIN21US2J4a3RUSGxYVkp2cTNnTmxvS1N4VjYyWktw?=
 =?utf-8?B?S1cwaGk0SmJTQlJ0QTBNQ0d0eGpnTFRHNGp3Z3o0bC82aDEvWmJxRExYdDVO?=
 =?utf-8?B?SCtCa3c1U1FlTzRSNXNqQW1KZnIvRzdkM296Rk05ZFUzcjlqeFprUWNJeW9m?=
 =?utf-8?B?OFBvOElpUDVXTzNlTlAySHpaMlNnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaebad79-67f1-4377-644c-08d9e67908f9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB3752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 18:22:56.7035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NV4L7cajIWe4fz5d+NGudL3BKHz+nm+B/154VsMWTOQpJuQByaO+KRNvwCXpLcq5cIMhKNOHH3AMT9QnuLi7tkPz5CvY4V25kZrPDEr0mGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2052
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020102
X-Proofpoint-GUID: N1XL77oq2mKF_IU55PRnL9_qTOQW4ztB
X-Proofpoint-ORIG-GUID: N1XL77oq2mKF_IU55PRnL9_qTOQW4ztB
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
