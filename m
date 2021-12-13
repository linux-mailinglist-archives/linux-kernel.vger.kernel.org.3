Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B765D47309F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240153AbhLMPeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:34:04 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55162 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233104AbhLMPeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:34:00 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDEmo08012389;
        Mon, 13 Dec 2021 15:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=ddg0iE4S2HRDUpv+v4vRhH1BWvJk8x7LeTFzRU8G580=;
 b=b43bmrfg4uaNy41y9y481uzaUQd47QLKbcmYAsSXm/1LMfXs619l7CpUnNyXW60B5Gu6
 DOk3F1eOvuGToDRLiy3ljI7cZJAmuCVciwkSFLuaZHJO+wNY7s753xBPxyqRlts34Ydv
 ia/40NbaSwsyJd7JasdjAGFirp3c9UoPBAKmyfBokWflKu8gneIfkfEmslsk0aAYJMCm
 D010hqZbXbt6X9N5HX6bSRHcV9D+NQnf9GLgx6cVk0Kg6/V7mRrMdyWkNUFXl6vssUZT
 zUTO4VCnec8P5z1l3dJkJUlrmSbVlbzjgPoG+onqURBB/f5D2EyXdPNRQnle1OPCFJp0 tA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx5ak8kf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 15:33:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDFUSqr011709;
        Mon, 13 Dec 2021 15:33:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3020.oracle.com with ESMTP id 3cvkt347yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 15:33:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G03+YhE4BNRxPYDO3X+B9tjUviiZ4Z0CKe0NDtXDg1zvk4aNLOfGVrii5J5GSNkaeX8YVCstjZ5pkAyGY98aRgbpGViUn/utqR+vPBcrywuY7RYK3RYqYd5gnTv1q0SA8X9cfiF9gA4V+F6QZ7PJRc7KIhkjhQyNz1ZHedJh6adBBh3a4pFm65y5Cv++6cBS8DPY43XvZny7bDYPQclRj1eVDdbpQOZEyakqOYrlILQ/FFCcjyWfvYKFY5QHfl89801yIXJ1aTWUUYSDNwja3FSrkZKqw7QCpHcJrGXWXTvxkWxUlQpJGCF5Lra9JdnKeFhAZ327Ob30ubswViZQag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddg0iE4S2HRDUpv+v4vRhH1BWvJk8x7LeTFzRU8G580=;
 b=OPO3JnfNtCTJV0fy0EkXLEJgsO9J6LJ3JwVtGe/BOmNsYDI5p/bajR9wDM32q93nWjarL2K9BuPUYsyGsLahDTfYyOPqiua5rKWb9J8L1XK1oBKgtVm6Iy2bGZuDMskgxf7LESNnx1EFrDchXPFq7Y1zEHnNk8Lce1rvAmbiD9vMuqjByfxEyvenlP4MO7HfS9Bzm0h+ELpmegPRiHqvNxB7XvPkAC8rl+efxIpDNTLhny9b7FyySY4bPrhDBhCcHVeeNXpJpxugq24ygJhL/OuSDDH5YnkyI+bQ/1L54GLl7epIbg/fykIg9U5S9baTO//P63yGIwT+C+/l83wSeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddg0iE4S2HRDUpv+v4vRhH1BWvJk8x7LeTFzRU8G580=;
 b=HTepbvCbQrGVE+5suF2vxMpmuX1/VasiwjzhHxoGTCMd+5HZooax5nyyZyDjg0VHwbfhrcdociBacpHIJdaaM2BkcByzK3Fic+CjAKWgkWWPX0mQRdKTr37fMFXXjUVVniM3f/CobVNfTx+J9sHMJIA0yUTYks/upamJV2XM0lU=
Received: from BN0PR10MB5192.namprd10.prod.outlook.com (2603:10b6:408:115::8)
 by BN7PR10MB2561.namprd10.prod.outlook.com (2603:10b6:406:c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 15:33:56 +0000
Received: from BN0PR10MB5192.namprd10.prod.outlook.com
 ([fe80::4440:4f39:6d92:a14c]) by BN0PR10MB5192.namprd10.prod.outlook.com
 ([fe80::4440:4f39:6d92:a14c%8]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 15:33:56 +0000
Message-ID: <1f57bc3d-d125-7e09-4699-0338ddcc50f1@oracle.com>
Date:   Mon, 13 Dec 2021 10:33:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "GEORGE.KENNEDY" <george.kennedy@oracle.com>
From:   George Kennedy <george.kennedy@oracle.com>
Subject: [PATCH RESEND 2] libata: if T_LENGTH is zero, dma direction should be
 DMA_NONE
Organization: Oracle Corporation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0054.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::29) To BN0PR10MB5192.namprd10.prod.outlook.com
 (2603:10b6:408:115::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1552b29-2353-4743-03e2-08d9be4df99e
X-MS-TrafficTypeDiagnostic: BN7PR10MB2561:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2561054D29AA39C27B3CB45DE6749@BN7PR10MB2561.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UNg7bxzH1UXySZuJ5nxrzfNeHW77E774v3u4dusULhpgO0b0XB+Px13gUTL5dFVGMezR35vELak1mgc+dFCqFJfiwg+XPi4qIwvHvfIwTtfBTbdqgDegk45lIRECwbpedvPVtPBGAnhbWr5lOpDa4yRoijZh1RP8RXi1NLvvlutUpyQQIHvlIE9dpz/wSSFPmPuunaFi7X2YtALU5upTYiR9xn96a7BUgpQs1kgd5wZmvXZe7vMp5cc4vAaK358noX9FJ1di5Cnz24CoIk24QQRE4agOsFUc6NDI61X/RJAGG+fVU82l31jW0OSwcfHYWVLUmRa6+Yog8vQ38emkQij0VVGxuV6uewV8TypzpHeobisv16LN17GIMk3J/i9bmTlTCl/mDGc58ohKHNps2gOX7Q17zdMVR3S2nnlt9z4x+Q6bShSxfgD67F3VO20Z89I3R0B1Mm3jlThMXeCrcY7y0vOirW7ZSuXYC8n3LRnQ0U2kASKLqXnx/9Qz+ocOhP9u1wDHXnT3PRWcequ3ygljXllcG+0EAYxAfiIykpUsrYmkzg1lV9eqiXpDVGKfEX3oD0+1OZHNv5QlbWpDIV7LvnnvOJzWKmGxUiyiw/nfjz6u+TNaPKYwp4M+TwpHaD2WeR5bjcVRHuAy7/kDmI0Ura3WnmRuzwaBXPiddPu9+6z8flRVONO9NjWT+gXLPhPDUkVjzSVn8cCaDLrfcUZXIWvl6KKtlT4S28TLI/I7Z1BUW5nxuCLB4uPbZj+s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5192.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6506007)(4326008)(66946007)(54906003)(2906002)(6512007)(44832011)(66476007)(66556008)(36756003)(316002)(36916002)(8936002)(508600001)(186003)(6486002)(4744005)(86362001)(2616005)(8676002)(107886003)(6666004)(38100700002)(31686004)(6916009)(26005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1p3L1JnTkNGZ21LcjB4Q2V3UnVWc05RNU1wTDc1eW00VDZLUWxZcXlSck1P?=
 =?utf-8?B?K1JEWlNGMm1VTDVFK1RiY2Y1ei9McS9kWSsxQ094d2VlT0tmSjlES1NLaFVE?=
 =?utf-8?B?VktoMXRzdTlub2lWVzRtL3JOYVJHZXFDN2s0cHkyenc0NGRqMXdKUjBpRjVm?=
 =?utf-8?B?bUdYOTAyVVI4UWkwV0NnemxiNThjZ011bmRBWUd6aUI1bnhib0MwMng0aXBt?=
 =?utf-8?B?K05iUEo5VStOZEdQMkJYSm80SjdXbjdPc3IzdlFYaGdOZWpJZy80TWNpSWMr?=
 =?utf-8?B?Rko4VzYxK0J4WVNxSFc5dElxQXRRcUVSbEpGdjVQa3prbW5RQWN4NjVVRUdo?=
 =?utf-8?B?bTFmOExsbHdKUktNVDlGVGhhRTJzQWFQZDVCMkd4eWZWcVcxSk4zQ1BEbFg5?=
 =?utf-8?B?TXpMRVYyczU4K1JvZ2pLVlIvbERKNXZ2ZDdUMUlxRGVKSWNUNkdEZEdrT0ts?=
 =?utf-8?B?MlhhL3RGZUZjQ1RNbDR2bWp0SUQyZzdibWIwOHpFWHhwS1ZEcGVBK3B4THJG?=
 =?utf-8?B?WWdKSTlCWEl5cEFUN1Y1QzlzWTUyTnVhQ2pwYUF6eFJISnVCVTVwenFQL3Mx?=
 =?utf-8?B?SlNONUVzaVNJZ3pwZHdvUXFQQUZKaVN3YjFvR2E4VEdwdlFjYkVncFRJVHNz?=
 =?utf-8?B?dmtlVlR1WkY1Rk5jdzJHeDRGNEZQQ0hxcVZjbjJQYzBucVh0V2U3ZlROZXcz?=
 =?utf-8?B?RlV3cElLeDJKcUI0dkJRVjJYU1gyYktXV2xOU1doUDRyTG9xK0JwSHBpbThZ?=
 =?utf-8?B?UzZhTTYyYVY5djVwOGNDUnJaV2I2bmRrK1NmcHA0SkVtUERadUNqTXBqTDdh?=
 =?utf-8?B?ZDJMSHE0QnZWcWZsZi9QSVF2WjRaenpuRUM0azBFYXJJczBIckJFV0hDU2NH?=
 =?utf-8?B?bEl3MDg5OUVzNEJmL1ppQU9BSXRCbG1ySHZSRGpVWkFaWmt4L3NoYTR6UGtl?=
 =?utf-8?B?UHJyV2tpaHgyK0ZzSkRvc01GUllld1BnZXp0R2MvTVlPZjZieFl1cloxTi94?=
 =?utf-8?B?U0VFU2duNjUwVldMVkkxRkZFd3NXcnpod0RsS0dLZFNoTS9YRmxiaGpsUElv?=
 =?utf-8?B?QVBJb2xOVDd6NXRiL0JjRjJ4eWhiMkxuT0VySWNPK2VHSUZXMVhZNTY2MWVP?=
 =?utf-8?B?NDIvTEEvSFYyWTY1bjF4R0Y5QmJLQVRoTFRhZzkxeSswTkFySzRNcUY1b2Jz?=
 =?utf-8?B?S0RST0hMTjUrbkNCaGNtSi9VcVJ0Mjk3bWpmdTc3UnZCZjFPVGh0S1RWdVl3?=
 =?utf-8?B?OGF3YmtOSWU5Y2pDRDNGYUptM0xuU0xUZHpiTjVKTGdORndkM1pSNmo3ZGZY?=
 =?utf-8?B?aGVKVVN4TnQ5Y2FKR0xHRm5WMTlaaVN2Yk5jMW1BckdYODgwdm5tRGwzcjNL?=
 =?utf-8?B?cloyV3ZsbC84V3lQL1RVVWMzd1VVUjV4c1JDRzJtQ04vZ0ZEZ2xyZTBaRGFL?=
 =?utf-8?B?VG4zOE9LSzgxclYrSEhXR2xrZDR0c2VGaEhIeUtoTDE4RjhCenhWaUVWWG5S?=
 =?utf-8?B?bUtqMjNQOHVKaHlKRE9HY0x4TnNRYjJnUGg3SFVwR3JweDFKZXQ1dFl0MWw2?=
 =?utf-8?B?OHR2cWVRMEFzbkd5aC9SNDdhVEpCZTFBdU9XZWVHUjdhS0QrQ1Jtamx2QWNz?=
 =?utf-8?B?elZnRlFLV1Ixa0JJRXcwMXBsNm0xdVhpbDhLcUNVM0FFc2VFZ0M4Nk9YWHQ0?=
 =?utf-8?B?L25TaDR3MGxUenp3VlNlaDFhSTk4R1pQL0FhemJHY2dmYTVDeWxncEtITDRX?=
 =?utf-8?B?dDRHSXgvVGMvN2o1MkFnMnpmeGp1b1kzVHFMQ29wQkM4SU52N1lxN1pKa0NR?=
 =?utf-8?B?NXZxTS93d1prVmdFUlViUWJ3eDJ1WVEzZUd1bGltU3I5cytmVy95aW9JQm5w?=
 =?utf-8?B?WGE3V0RraVZ3RE5Bd0dRYjIyKy9WVk9kdVBVcFVVNzMvK3dzNTFQOHBHeHI2?=
 =?utf-8?B?djBKYVloUVpzc2Q1VVdRYUlDdGV0R3NyTHlITHd3MktOenRCcTRkZzl0VzVJ?=
 =?utf-8?B?WUhRS0QrZzlwbmxUM3ZWQVZEa0VUMXNhdVBvN2o3bUkzb1c3N1lkeHdyZ2dG?=
 =?utf-8?B?Z3NqZkJMQlJ0bFRtaS84amQzbDFKTHJybmxEcS80Z0RuR0Via2FHRHhXOUph?=
 =?utf-8?B?cWc4QUlBdFdwQ2JaR2xwVm1xTDRCOU5xdUg1dWpxaE00ZFZTbi9XN1k2RFBl?=
 =?utf-8?B?dnlvQldrVU96eDBkemZLME1TTTlDYm9KUi9pMDZpZXhFWjFqNlZKM0xocFc5?=
 =?utf-8?B?R3dEQU5EeXJ6SEFaRDVBS1dkRU9BPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1552b29-2353-4743-03e2-08d9be4df99e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5192.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 15:33:56.0995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAABRD5zvUcex+j8bTj0tk5/oINOk5Qq7hfw/qM0PfqjXLMuX7QC8qWlwnonAFrmENBzE6STgMbImUvadQhHFRB7UhZskHOZr2GNfeOEX9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2561
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10196 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112130099
X-Proofpoint-GUID: CLpq3mzThK8_qUoLdebsjkUlQw5G-f4S
X-Proofpoint-ORIG-GUID: CLpq3mzThK8_qUoLdebsjkUlQw5G-f4S
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid data corruption by rejecting pass-through commands where
T_LENGTH is zero (No data is transferred) and the dma direction
is not DMA_NONE.

Cc:<stable@vger.kernel.org>  # 5.4.y
Reported-by: syzkaller<syzkaller@googlegroups.com>
Signed-off-by: George Kennedy<george.kennedy@oracle.com>
---
  drivers/ata/libata-scsi.c | 6 ++++++
  1 file changed, 6 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 1b84d55..d428392 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2859,6 +2859,12 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
  		goto invalid_fld;
  	}
  
+	/* if T_LENGTH is zero (No data is transferred), then dir should be DMA_NONE */
+	if ((cdb[2 + cdb_offset] & 3) == 0 && scmd->sc_data_direction != DMA_NONE) {
+		fp = 2 + cdb_offset;
+		goto invalid_fld;
+	}
+
  	if (ata_is_ncq(tf->protocol) && (cdb[2 + cdb_offset] & 0x3) == 0)
  		tf->protocol = ATA_PROT_NCQ_NODATA;
  
-- 1.8.3.1

