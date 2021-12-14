Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B18F47436D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhLNNZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:25:59 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10270 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234406AbhLNNZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:25:56 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BEB9fkE005519;
        Tue, 14 Dec 2021 13:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=LuGb2WlFAbjslzabGV7MY13E/YoBKoDWKEuNWvEj3/Q=;
 b=fnMoUAWnciuakX1+CX2US5k+wP/cq9CDIUwCaPVXP5NpaWh2nFiFNOYOOecvAVYIKKjh
 Wjbi8mGIgpAxN3JmLwgw6MVYmXVrZu1tvIzKewrzsSPTYYsg1fZXes/00+qZZGZTmupl
 2x5U2GKWBVeB+gWYzOts8Mh+1XaDS4lcK5RDvZwqDc1Gx3makemlWI9LMjTq77y447Du
 QXy5BzzMWtJycUf9xM9yuLz3UEsdoqwtLi8zg7YeRZmsefTw0W0s2oFj4nnsoLhJ1NCY
 I4ftD5eHw1AVI0fhZ+Smrkui7EDVXQ8QVeIP81BZNFQQ0aB7CJstqveOdDjX8pDi0YFD MQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx56u3e4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 13:25:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BEDFax0017260;
        Tue, 14 Dec 2021 13:25:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3030.oracle.com with ESMTP id 3cvh3xahks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 13:25:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ab8FVhk+mXdbAPwdlVNAoJZbAvjMlH8FHsMqm0dUS0KiJeS4+Epki6g+fv73CFwHaw7IByCRB74VDL+6C10KnqisEsiMmYGoPavomHlQgJcYAo9SLLfVWJgDJzopyokaap+kvoxxaHLf9Fk9Jx7xlmKk7wH6EiFoBej0ljAPgY+ehmvSJ40rCykvPV1mkRduD9trEHKAIO0+eyaojAa7y416pjtMslUySxMiWqhdISRtC67/xogBw0VfwBY84/Oh8vixzPLNBggPTqE/yyal/APS0TsYXM3pHDfeJBMEltZDcdsOdgQ2QYQ6Qm5XQsfLOkG3/6jJIKDik7OPv/vn1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuGb2WlFAbjslzabGV7MY13E/YoBKoDWKEuNWvEj3/Q=;
 b=SMncaI70cCzNFan1macqI3jf2Lqz9RFAHDcfwUZQvHHBcXRutFwfKT1NobO7IHXonuPjipJuIAJW9wtE1UzOjNsL34T+XjRgvnLhlnjXWlnAXwVOjFFA3P5eyMExjkjFyxDdia87xO0KrVybL2pfttNx0SSvjQi14yNYKBsw8R46hOQOpoEJxNHC5KjyeCOh0Tc09lRKHki5C/u4ihnP8QP4tmvudfIewAZuUF4nrnF50LJsVMDFXtp0pvHt96+UDzfZvBKtaE3KrAM3X78H4Xen97+aIiKd8N9EDRcvDUBiqshqgsj9t5VpDSh0Z0F0m/kPO20WGNkMfUhm5PY/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuGb2WlFAbjslzabGV7MY13E/YoBKoDWKEuNWvEj3/Q=;
 b=EV/Rq4fzOwYky3RXXE3d6ZnqNJWeYECKccT8RVn3voi3/5DqSGda0TZE5QD2uFqznjUPa/FxB9SEz8BXjiv6Wer0H9jW7ikeBivOx+AozaJq/DdwPW1oy6nSG/Lo1GBOCoypUSYv7qUTNXFBzBGL3TPJaZFwKL7ZJ3kdYtuXC2o=
Received: from BN0PR10MB5192.namprd10.prod.outlook.com (2603:10b6:408:115::8)
 by BN0PR10MB4965.namprd10.prod.outlook.com (2603:10b6:408:126::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 13:25:51 +0000
Received: from BN0PR10MB5192.namprd10.prod.outlook.com
 ([fe80::4440:4f39:6d92:a14c]) by BN0PR10MB5192.namprd10.prod.outlook.com
 ([fe80::4440:4f39:6d92:a14c%8]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 13:25:51 +0000
Message-ID: <a8cd9195-ab57-4067-d814-c9926eb36412@oracle.com>
Date:   Tue, 14 Dec 2021 08:25:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-CA
To:     damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        George Kennedy <george.kennedy@oracle.com>
From:   George Kennedy <george.kennedy@oracle.com>
Subject: [PATCH RESEND 3] libata: if T_LENGTH is zero, dma direction should be
 DMA_NONE
Organization: Oracle Corporation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::30) To BN0PR10MB5192.namprd10.prod.outlook.com
 (2603:10b6:408:115::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 692af399-475f-4d20-47e1-08d9bf053fbe
X-MS-TrafficTypeDiagnostic: BN0PR10MB4965:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB4965A50B326ABDB662283A65E6759@BN0PR10MB4965.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DN62ebBYFl1BlmHmKbW489a82H1gfEICIg4BJ+ip2ZmvCBWGvdTStVN8qPLIvjxuXkH4F28MzG5oppwd+uWNvZvYaiaJJYOj9fcokrjY+le0YG0ET+ZbXpzmlD0qYoJ9X5EzBrMRyjUOjuNqElO0uTXs9lsP+0Nl6vh3qc0sPBBA63v3dMiVwqJ8Qt7QbwS3MbvHGUFFZN6gqovZv/2UOAvx+xdHAZzlAAaabyGf7EZMrev5F2nxML9doncLkEtw0os3HA5UUGs1CCHPzZpMnDVcMzYTKr/hSgLuO4Ry1vr4FUH6p13a9n/VyVDaMQFB+21R6ipPW0+Ju3DtQl9AP+M9Js7BIeWlzfkKnvEWbHuER7v39HpO/fvymUAw1u2C8uhO7hc3ZiiFROKYiU173AUfUKXNSRfdUjRjd8U8E7G/7voDOFFBy0tdVAqN+H+hOX3gJAqSOjimz30d0FNzxu8ry//7gBUmC5d5cMS0ctUexkQruiIywRY/hBu8TfvO3Lhb0a11nEg+9/4H2C2yzM2UY6Ml+Dwt9eH/G7+mMgYmDyruoXKaOiiI7VbOpF5qR88EOJpkut4PNa4YUHFqnDW1dcpxVko+S0tMlNz++mX1W/DKd4RC4sNlavkgk24DPR0Me5B1i9/hShkuLXEul2/g1/jBRkuNajtjCNpIZWp3ZUgajKy/0fQNFTu95PooDWieTD3EQDwfLmSmFM/jwo4a1CaagGlaaPQ2zjFPy/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5192.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(36756003)(31686004)(38100700002)(508600001)(6916009)(31696002)(8676002)(5660300002)(86362001)(107886003)(66946007)(66476007)(66556008)(44832011)(6666004)(2906002)(6512007)(4326008)(36916002)(2616005)(186003)(26005)(4744005)(54906003)(6486002)(8936002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2pZSElKTjRrV2RwcFRpSllXRlBMWGVtbFFKcndiK1ZxSHpNTEtISTJ5S1V3?=
 =?utf-8?B?RVRCMmxhZHlHV3ZRbTlLVVFHMnRoVk1TR25rUGZueHVteHRxSUVrWTBabXZi?=
 =?utf-8?B?M3o2Z0hBTFlla2ZBY3pWL0JNbysyOWoyOFFTeFR4dkJVbzRsWHpVL0pGTjdO?=
 =?utf-8?B?YXMrRk1WNklQQ29FVlZrNDhWWUphOEJDSzRhaEhTNm9wVEs5c05vaUtnZUNy?=
 =?utf-8?B?WC9Obmx5dkN0R3hqSWRYbmJ5QkM2bW51MmhxUTl5VHBTZS9QN0NoZUJNMnZj?=
 =?utf-8?B?ZTJ4a3pINi9rUWl5YTZidk1CQWcyc3g2NVRSbms5d24zOWVWeGhFeFYzbUJX?=
 =?utf-8?B?T1BHMzJtb0w2WitDWlFWZVZwVE5DOUVGa0FvMWoxam96ekllN3lKZ2dDVkRO?=
 =?utf-8?B?d21zU1pzaEd1WFNpL3VZdE1GUDJ4RzdWSytRN2ZRaFh6OTgrcGRUbWZ2a294?=
 =?utf-8?B?M2s5SVdxRThJOStIcGxOMkZoTUJEYkpQOHFlNGxzTXRZYzZoOVF2aFhmcm5W?=
 =?utf-8?B?N08xUDAzVWZST2pXOEtiVE1lRUpJN1BhYy9jc1h4bjNobE43dy9wWWNOU0Ix?=
 =?utf-8?B?NHhZQXFDN1N0NmpWNHZYcjI2ZXNpaFpJZzVYUzlyUGNST0Y0ZmJ4UTFPYStS?=
 =?utf-8?B?bHp5UDZNdU5vaXJPcitwOXhqWWlCcXk4TEJCTituZTI4aE9xUklTRWY0WXZs?=
 =?utf-8?B?UGN3Z0dvZ1lEVDU0eGF2YUd4b0N2Tk1CQlV4SGVKdXo4MWJ3M2FtNWNZL09T?=
 =?utf-8?B?WTBlUlFzWHRIN2lrSUhrd2F4ejlZdG9kdkw0ODJoa3U1NEhDOVVGdWtCN3Mr?=
 =?utf-8?B?SFM5QWJ5NzN5cVZIT1ZITnZWVTJqRWlUYjdTd0hBOGVUa2M1Rm9BNjkvVStq?=
 =?utf-8?B?ZW1EOGI5QVNRMVVLR0JGeGs2bitIRHZBMW40OSs3MGdsM1l1TmkxK0V4Vm5L?=
 =?utf-8?B?WHZuSlM1U0ZZZXNvVE44OUdNcFMwWFhadWhuc3FhY0V2VVZEODZVcktGT2tu?=
 =?utf-8?B?SG1OWEZ1OVFyZUtLSXE5TTI4dEVBQ1BYVXNpZWl6ZjlibE5RcGJsRTFRMjUx?=
 =?utf-8?B?TDZPRURES3YwRmZrZmNhRndMVmI2eEZIcEFGUGZxdld4dldEdmJKWk50Qjdm?=
 =?utf-8?B?OHk4QWtFK2hoOVZ3VEdYQ1JwRGxBQlo5Q2pYejlJbVBybGFFNU1ybk5GS21F?=
 =?utf-8?B?cldiNitFS0NEcm0yYUJJTG91a3E4M1huOGlkZmxvaVRqTVhiSktyTHFFb24r?=
 =?utf-8?B?dDdTT0VwaU5XMDlhZDRWd0RZWnhRTEpCTkJXN2lwNVA4WFNLOW1Va0VIeXRL?=
 =?utf-8?B?QTVmWjBUV3dyOVZBd2EyUVRyd3lnR3NZQUZNQmdNUVBaOTVRWDluc2FkdkpB?=
 =?utf-8?B?WmYwdElCNkhrSnFyeDJGRytFYjdHM1NkVmwxRTdNTlY4UVJuWm1OY0crSisy?=
 =?utf-8?B?WlBualNtL2NUKzZsQk1mc09vWkRLQU1ZTmVMdnFsRVVLZjBWZktWMS9lYXpk?=
 =?utf-8?B?S1B2aEpHZW5oSVdRbjVhM3JvVVZZYWQyR0RCdFZLQStmUkdUMUxyYVlPSXVw?=
 =?utf-8?B?MnVCbzYwaHVTeFY0Vm10NmNmdDBmMVNyMUNHaHQwUlVNMmNVM0JnS2ljNG5h?=
 =?utf-8?B?eVZzc3Y1Lzd6RXlzUEQrWVpMbFlENXZLK2ZNSWE0b3RoWFYzM1Bmb1JKSzBT?=
 =?utf-8?B?MkxnNW1aMDR6cTQybHFWZVFIUWx6YWYxTkhrWXNpb0h2Sk1CTTU1UDIvU3FV?=
 =?utf-8?B?ODIzQ3BtUlhvYzlDZnlJN2Q4VlpDaEg1U2h5UitGcWhtNDIzdkVRS0lKSGdU?=
 =?utf-8?B?cUxQTjd5WWFWUmN1L0xSZ3ZJRVl5c1ExVm41c2Y0dVVoQ2NQcVpyeGZ0NTEx?=
 =?utf-8?B?Y2JHd1VBN0FPS3Y2ejZ1dHhmUVJCbE9ucGRvS05rTmdjakQ5VEpoRW1aaEpQ?=
 =?utf-8?B?N3BOOXR3SHR3M0NnbXRhd0xpRE9BRThKcXd3VWFsdm5uSTQrWnM0cVpTVmhE?=
 =?utf-8?B?RWVMS2JYdnJycjBNcWpLUXFJMndhY1owUTJSSDNHRDdRcnB2MktXTjhPOXlz?=
 =?utf-8?B?TlJDMnVWbEhzSTJsOE9QRXlHM0ZYZnY2Vzk3d1VQQnFRa0FCSk83dFN4YWxl?=
 =?utf-8?B?UlRFbWFKbDB5TjRiTjhVUGV3aXgxSVVYUnFJL3cxWE41UU1SOWhia29tZmRC?=
 =?utf-8?B?LzNQckI1dE56T1pRNzY0TVNOdUQ4Vm1zamdPOXNvZWxxa1N3ck9NTmlVdEph?=
 =?utf-8?B?RkdCdGQ3RnVwY0I0dStHMEY2MTlnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692af399-475f-4d20-47e1-08d9bf053fbe
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5192.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 13:25:51.8249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1khdaEOb2EAnl8G174eGRU25hUV2bCZQH4wQSbm8nwnlLA6QQnQlpey+OYdIBWUXYGKzAcLJYv/c/nXz8KTUsafrHK/aheJokg50RYvHxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4965
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112140077
X-Proofpoint-ORIG-GUID: 5K8AkagngwwXeWDv-GqvrNvzgC-JHLl1
X-Proofpoint-GUID: 5K8AkagngwwXeWDv-GqvrNvzgC-JHLl1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid data corruption by rejecting pass-through commands where
T_LENGTH is zero (No data is transferred) and the dma direction
is not DMA_NONE.

Cc:<stable@vger.kernel.org>
Reported-by: syzkaller<syzkaller@googlegroups.com>
Signed-off-by: George Kennedy<george.kennedy@oracle.com>
---
  drivers/ata/libata-scsi.c | 6 ++++++
  1 file changed, 6 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 1b84d55..d428392 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2859,6 +2859,12 @@ static unsigned int ata_scsi_pass_thru(struct 
ata_queued_cmd *qc)
          goto invalid_fld;
      }

+    /* if T_LENGTH is zero (No data is transferred), then dir should be 
DMA_NONE */
+    if ((cdb[2 + cdb_offset] & 3) == 0 && scmd->sc_data_direction != 
DMA_NONE) {
+        fp = 2 + cdb_offset;
+        goto invalid_fld;
+    }
+
      if (ata_is_ncq(tf->protocol) && (cdb[2 + cdb_offset] & 0x3) == 0)
          tf->protocol = ATA_PROT_NCQ_NODATA;

-- 1.8.3.1

