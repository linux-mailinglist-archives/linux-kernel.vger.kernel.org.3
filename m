Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A8546EA83
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbhLIPGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:06:00 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20692 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238885AbhLIPF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:05:58 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9DuNtf016333;
        Thu, 9 Dec 2021 15:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=oxuGCzhwfUy1ort52vvi5r6K65iym64aSzWRlG1u610=;
 b=uv8fjBHXVILUA7g1XNwX/u2mr1wTf32AXnIFnSMf/ZeyAoqbqCtEO3/a6kBh6qTTUnGC
 QjuJh2ymljwgmO74fLjOKxYC4soVQ5Gc+ssqFrModjWkskNUfFiV9GH0ejPNtmJTA1ir
 p5SDJlV5ShFIoShuX0pid25GVdvkTAtcfIxuvTj7o8A+erDQIGHNRGmjYzatar7teJo+
 xg5iGMVSB2RhqT3kEwQDn1gGVGGnn6NbTX5QKg9IlJ3FdpQ6SkGuCa2BB78Mib84sZ7D
 YpI6iAHNRrpmai9YO+ohlC4iSotnJuIVoXtdCn7KHuKIhODkV1XRoU7EId5yVtS93Gjn pA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctse1kjvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Dec 2021 15:02:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B9Eulem062998;
        Thu, 9 Dec 2021 15:02:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3020.oracle.com with ESMTP id 3cr1ssn4bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Dec 2021 15:02:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXqNrYuctjNXHrxc44MGPo1wW7j/bEGL9Pw9Ktd5rD0L+Jg7MfVFH4cENixpwtf6JfXVNkivE4Yo36oDUNq6ejJHUPVf82k8lKaYsIz2YgpvBZLSqZwJy15V3IHIj9kbaC7f/CXwkBceO4pwfn19QbJ/Ypa0GJ4iYoDEr1nHfyOEjsNSQCGIqEPCyCHECNhqL+Q+AVNrLzey3vNwSr6GwWmjIZxU/U7ZB/9bRXIizI4U5IA4xq9FUbtXirE5v15CBM7eSGPpIdqMhfeEtvCrcXdecMcvQ3KgHiV9eVc61R2FZIKP5eCKAuZeiogU4c0KTP86A3NAQ3s/C7H8Q9wX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxuGCzhwfUy1ort52vvi5r6K65iym64aSzWRlG1u610=;
 b=lyqs04EBNWQzEXNCluU5FMgp72ANC/9A8nvRpc7QUKqLkSw/zh3hy22t4r7T/UV+07kcHKJ1vGNKMhYWkmgUd4b4RkJgV5XZTQiiP15ANJrFfYIvATjjvHraWBbPEljTQslHb+tCrtbUyp/b7YTiEdDu+Xy/w8XEb8YdeJmstZxeF9JSKUD3bA0PPmVIhbULTPKstKRyCerAyPMCEalAIlwAEl77kwd+ndz/zrnf8xTbu6MUk55VYfYQ39cBQei0Ukj7lkeKTwSpyuF8j3ehE/tpajLEE2Zs0J894LhmV9og+GgKNQqL3lRiFf5Rwm+aM80jZkuJNfB4H/3seR6Paw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxuGCzhwfUy1ort52vvi5r6K65iym64aSzWRlG1u610=;
 b=BHkMVEivlDeoN+/Ie2XoUA0djE43II/dZQ9kWJit4/d01cCBhs3vxPH0+phZm9Ve65ZhdQ22khc8xYK1ues8u3gN3csKAKGwxsRnbegWTLLG1fiPNFTTDkWzcnacrLfmlHPuDY0vvHryyTw6ijHtifmr54r4iZxkDgwdcByKWvg=
Received: from BN0PR10MB5192.namprd10.prod.outlook.com (2603:10b6:408:115::8)
 by BN8PR10MB3282.namprd10.prod.outlook.com (2603:10b6:408:d2::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Thu, 9 Dec
 2021 15:02:18 +0000
Received: from BN0PR10MB5192.namprd10.prod.outlook.com
 ([fe80::4440:4f39:6d92:a14c]) by BN0PR10MB5192.namprd10.prod.outlook.com
 ([fe80::4440:4f39:6d92:a14c%6]) with mapi id 15.20.4755.022; Thu, 9 Dec 2021
 15:02:18 +0000
From:   George Kennedy <george.kennedy@oracle.com>
To:     gregkh@linuxfoundation.org, damien.lemoal@opensource.wdc.com
Cc:     george.kennedy@oracle.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] libata: if T_LENGTH is zero, dma direction should be DMA_NONE
Date:   Thu,  9 Dec 2021 10:00:20 -0500
Message-Id: <1639062020-5621-1-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0041.namprd05.prod.outlook.com
 (2603:10b6:803:41::18) To BN0PR10MB5192.namprd10.prod.outlook.com
 (2603:10b6:408:115::8)
MIME-Version: 1.0
Received: from dhcp-10-152-13-169.usdhcp.oraclecorp.com.com (209.17.40.47) by SN4PR0501CA0041.namprd05.prod.outlook.com (2603:10b6:803:41::18) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 9 Dec 2021 15:02:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ba193f3-9331-4e0b-267e-08d9bb24e511
X-MS-TrafficTypeDiagnostic: BN8PR10MB3282:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB328289EA4B2FCE115E4FD8B0E6709@BN8PR10MB3282.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IqYqmM1iPODAxQMuGDfbV6Yxtx74KLuz+7/T9x1KJjr7Iy4JHqLQYPiWVmzSVS84O3rSIqDx6oiSKS5TlqjMWkTAxQP9Wqh02iIKkiS2jJob5xOOzYnd9wkMHzDlgTRDOVx5MmJmEQWn5fxcZUhYROzjXgT1k4WEwr353V6sMazBFgrXty3qibiEnPyoKy8kIL6CrOZjpUHh2n40lTw1B7LE1X4NPt5s7XwklmBb+2+oeE0oQrHXPblT/3kjTez8CHM/MjwXAIXCHMZbrodcqZt5c8faTxR2QZlXTeBctOP1h58bCsIVQ5TgXcKah0L8NJXNqj2uQPHY57Q4kh9me++DDwipJ6SNyJM90r9WBwdImY5Ovqi9Vq68iaHvRImqb/MK70ZNHG4aKOAW2A0mHO6Y20Yt3tZ8fCQ6DBCwhVkWHVYjKl+uDrhQ2r4WzymcmwbTwPa60De8/W7/LqARZB5KcDqhUR80l6zu5xrxylW9SdRsgD01p+TBSJH3yWzc/SgWTOGbEgEll8pkO+Ij1fdOyupmKrFhWiF6MaKr5FdjBx80p5+2VuzNcPOSoYCL4uz9UuiXg997VWVfs8EE6S17DZVdJQu7580QW/2tGXM4VOmkZrFRPuchmkHvIdOISQZqeU637uXeK7GeXSVHKwZUCx9gLnIya8w4WpIe3VpzUg1ZI5iZDjV/aaMHaU7vhV3hpa+j61G7XoEd4WL6+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5192.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(8676002)(52116002)(2906002)(26005)(38100700002)(6486002)(186003)(316002)(956004)(2616005)(6666004)(5660300002)(38350700002)(66946007)(4326008)(508600001)(6512007)(4744005)(86362001)(44832011)(66476007)(36756003)(6506007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?id969QtZdnLyF0DJuwoW2oGuthR7E03mJ2gGDVi/0VZARao8JrfQx7AlUieV?=
 =?us-ascii?Q?4G5qvjwIYF5/qV8x/5q5C+eM4H3Qx8hp+96cedGVK82w20xgYqk87NhUjRTB?=
 =?us-ascii?Q?rSKHPIMhk/sy5Y2jOreNTBBpdEdSnvBQBZtcOkMFn/p4jcWR+dqQoAYFH7UE?=
 =?us-ascii?Q?A6AZtM+YXmk14jZ+v7lj580XhaeVihsuqn7bGv2MLXKAVCIBMU7QJmeFWI6N?=
 =?us-ascii?Q?QrSPsazp5xKQFCjtv8Gf0K2bmCjWjuczszM2dP+U3Uo072Csq/F3Cts1o3Hy?=
 =?us-ascii?Q?6I9KobEiKS8uz9QDHDDI2AFIpt9F9OiYUQQyDU/h8HLJX7RywVv8hoDqA817?=
 =?us-ascii?Q?Igmxf1g79phGIo5Rh+lzM3GepJJqopuaNxI6FRmywc+T6nesr+fX6Yancr6j?=
 =?us-ascii?Q?o36sqsX02UUMgNDTRC+TWU83/PO9mU8nOweUQb/xzwThrvomdtKstFdhykDB?=
 =?us-ascii?Q?kE2Swhe+3g9ynyrNfDj1Yt0/S3Iph2WQ7ZWly3DJowAXQE+1CADo1S38yUd+?=
 =?us-ascii?Q?bMYERDiRZ+njM0jjXvThs95lC9xGtFgiegkX3p8DPbyu2hIRk8CghcasWe03?=
 =?us-ascii?Q?vpnqJss2/kkJ9BE8DBP1M1n9jGXOH36zWFUH6LSnHxZjuHU1JBgLxJh2RpW2?=
 =?us-ascii?Q?/DkduVhjOLAy127nXT2nn47yqRuzcEzidJ+TjBaxqGaTgx+qha9Z+xbxBxYX?=
 =?us-ascii?Q?1Te22H18OAXw6edeJeljsFI+8fucNJpHTWUhgFdLJl8Do4k4N1Jdx1YW5Nk5?=
 =?us-ascii?Q?tQBkrVnrk4CE5fT3J98pWAPImQZJKlkqpA5phWo7svV+TkZWgouaGtL9+DK+?=
 =?us-ascii?Q?TK4p92ZWVYf0vezSEsagR7AOim4NC6Ad5b0bBU5/bc8oX4m+7Vqpm3cDocSg?=
 =?us-ascii?Q?V9a/eq5+eCm/+4UtnbqKKy6pB31CY/rDgYhrGr9Bj5ZSM4DVMpMff1mWCUAI?=
 =?us-ascii?Q?N93uDxh4Xbd911GbwljIVVfeh8t0coJfmooYPNJ2QT3ciXZXNbbaXQ8LQ7Wl?=
 =?us-ascii?Q?J0U4LnIU45bEIOpPWPVuCv5PBzc4FWxJmDbnZXrYwvHk989l2ZV06M1ryRQ8?=
 =?us-ascii?Q?b42BW13XMYTw0HHeRThU31YBPcvtqRGWTnKsVWIxSDoTgH614y7VbVy557Lp?=
 =?us-ascii?Q?AwFVsc4gMGUyfQjU90LmVWHdfYNVvGz24XPuNO7BUda1BiZ0wEbkU8Lm0ZdT?=
 =?us-ascii?Q?VccKARmMMD/Y4cdbG9t9YT2OhknZqE8wc2y+b9vDo3fwkUCIgLozq0eNnAQ9?=
 =?us-ascii?Q?OqOrDBDF0DV6LtZMWM1nnZbBrhVkJwprx97L9+2dxHMBhgYsC0PwyBav96Xe?=
 =?us-ascii?Q?M7MozIw0w0/t2aOHfWEazeQDUPiJNMtmcG0Rf2xE3PzwthAC75DNaea8MpDY?=
 =?us-ascii?Q?E/jjpeS7+Ca4FlTDw9IgCgLs/q83K4ovrBQmkIFQ/VaNI6nb4A1MkB2vOEaW?=
 =?us-ascii?Q?d4vA7zJh6XKAMjbqweFVs2I9W7FCvBtPDWKdvNHtEbvlyG5AY1Pv6iYToBjY?=
 =?us-ascii?Q?fryjOo8TUvJ0+iG+IpvKHsuAVrRvh0OpMAhQucs9iNZKpDhadxOeeaYIvphi?=
 =?us-ascii?Q?XM5RKyioYg4jpvhAeYfdta8RNEm4lm3fSz8ef+LN00GcCwdSvthZPzBZ49Ts?=
 =?us-ascii?Q?RUGS/mopw14nCksFgqmTldmlT1S/Gbkt2lEH0R4nlFxHk/A6H2StWgscAYY+?=
 =?us-ascii?Q?/vHmwg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba193f3-9331-4e0b-267e-08d9bb24e511
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5192.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 15:02:18.8783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8R5PcskPSLpfxEq3m/mZcMzc4cOCs7VDhX95osvEfLCcxLYtKvRLvFQmq6Ei2FZjzFxUAh5xkgOtb/foqpNE/E7jo8noL0Zra3wv9fRR5TM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3282
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10192 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=985 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112090081
X-Proofpoint-GUID: 99cPqNwqlPQdBoyBxe9FrmgDZI9nMQaP
X-Proofpoint-ORIG-GUID: 99cPqNwqlPQdBoyBxe9FrmgDZI9nMQaP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid data corruption by rejecting pass-through commands where
T_LENGTH is zero (No data is transferred) and the dma direction
is not DMA_NONE.

Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
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
 
-- 
1.8.3.1

