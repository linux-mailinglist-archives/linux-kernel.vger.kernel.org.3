Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC2A4E61C3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349523AbiCXKcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349511AbiCXKcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:32:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4349AE62
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 03:31:09 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22O8qK3t023865;
        Thu, 24 Mar 2022 10:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=o/5IH/kEGlWj/c1lGj9oxwujrpszhxdzNHQSrCTdUV8=;
 b=oPOgtu3O73pci+srnO9jQaNa4NktGlVnj6gYWFSr1CE3oLdFehQJLBtufH49CuC8l7Vt
 0dRALN/iSYYAkhPhbpHwzYlFtmDgdBZyI95G7Hbb+tnNlmecRg5urxWbg+GGUmrjw/bL
 uk57tXpnIaCs+8tSogCz1iuSCVrPLwrQLdU8t19yImORXyB/h+uDPEAt8cB5qAP0aOpB
 dTSymnMURM3WeA7F35vnlGjgCi+yMw8cq2ruRFcMOSGzpw78yUQdsjN7C2rOQMq2+gvt
 VHenf1af/jPiv9UK1RRzsRFtTSb/081AaPg3goxxvWp1lE75QWCUKApTpLvizOoldJ33 yQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5kcurph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 10:30:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22OAUvOk178201;
        Thu, 24 Mar 2022 10:30:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by aserp3020.oracle.com with ESMTP id 3ew701r594-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 10:30:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFSUto/yszlOdDZzrYV8sW/0FZp2ssStPNfaOz10T/xMhdrPOZ0Ohc9yuYALJ3QjzXYcZuB/8FD7rlgsR1+gkEPfrvCsNceFqe8tMaDp0bBJm99+dfScpjrs6aXqKvK9GCSTGn+7vyUKM70x8uk/HrOCQbCtfYPd9M7Rpk0HAACptBFwLO0GGFLim2ZPHJaAhnxywBJIwvoLgbQZKVd79WhselgMdfD061cx5CJUAKFTXV3LuE54aUpCqwugDXM1VUGjFQR1PlvXQmr7HQpItkcr/zTB+8k1+elmm6SNftis8isKLa30wL+7ny5WQoOTQ5tBlKvenJ3AsTwrMEE2tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/5IH/kEGlWj/c1lGj9oxwujrpszhxdzNHQSrCTdUV8=;
 b=OOTJi1GU6aQqFKGgifhYfjs30Hh3JCFPh7Mp0G4I9Hm1jAI7UnrWng5AL1PbO2iNeTlTyM3un8E8qBpJ1z82XAqU49QQGxM70E66Umn49IhxcJ1aF6pNo2kox1T0njQ713OwP6ELu8PcGR50AGlhs12UEAnDpFMiPp4iexcSVbxPD0wQ2UXg1EHu+NXtcBLtWw4G79k+21eX01h+n0jz3c6UXnZchVL+xlt92yqPotMfKkvmz2M4KgIoKQ6VgFhaT8Iou9fRCtFzKGqC7GxaD3CH1beUFse9qZzmuzSxRwLyVoA4lm4VeaeFpWUgY6Y0pzc44ZvsFEPThQC3WWdhLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/5IH/kEGlWj/c1lGj9oxwujrpszhxdzNHQSrCTdUV8=;
 b=FYrHzgIYVmlBlhuO3DOuT4ExJKs7mjiB5GtnP4ersejczPOVZBYT+2cIEucjZdUlVTG2UNtgdzlu5CIUGUwYW5cwv13GA5VKovugvtpMfFWsdlFlLJIFBNN3FMO2rvjYUdUsnJJOCJVdTWw2UhJlRvNnVTdyWXUjtwUJ9of7XC8=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MN2PR10MB3981.namprd10.prod.outlook.com (2603:10b6:208:183::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 24 Mar
 2022 10:30:54 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 10:30:54 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     viro@zeniv.linux.org.uk, tj@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] kernfs: Remove reference counting for kernfs_open_node.
Date:   Thu, 24 Mar 2022 21:30:38 +1100
Message-Id: <20220324103040.584491-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0002.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::7) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 315fd258-6aac-437e-6235-08da0d815fee
X-MS-TrafficTypeDiagnostic: MN2PR10MB3981:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB398182E01448544C8F62C714B0199@MN2PR10MB3981.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AT1QDlH28FUu69dx+SyEOCFQpj311o611/tmlHK6jqAizQeRrp5VkmdCh1vQgcXoUMXRdZEm6LogsHPkpbK/pTplFEJCDC5j7IweOBfGIoILm6HDV6Y7xnfoODk8uQi2mtE1LIXvSLPPIBe6QpQi/vp35nMrQxz83RfZcusT5gY5hudSrCLvNXhIrHbxFp3ASa+1NN73p5ddtm1cAQYxx7arNtpF6vs3ev1lmH+dZH0rGrnhZ396ygkZfQ1+M1SBo0MtbgkUnm+v4bGcJNTL70fg9MNkYE1ia+bpMLTmiUGMq8invHyqRM0sxOt2G8ekXck+hKdso+GXQMitBS42ukx9zAw4HsJvRkSddg+nWXiXROJW+GcEb0rc3QFjxJ/gJpNQhuZSA6CFU5fjMGE9Xh2oQScKkuVxThGB+CB+06C1h8lQIuV/MtHpzErQNkC2YLckKpnz1dApzLleZ1nbyTFhy15B9cKEAFu5mDBF9vvePJkIDWdFNt9cjtGDCBW+rwl+UXHIzYc7vWMVVU5Kl/zOEBWJtR87JYol97e+Sy2gfdTu9npzn1lfucE/CzH1DID0yPJkMp5L1FzPsyzLfIVdx2TooWdpIu8I0o7Mx7F2rYvJWjZmEgNAho6W6kdEZ6zSIcGU6XpsI8PrIQ0eCWdSAqAEMOSuhDXzeDZl3Sg2yNArGurATQGZLuII55AOqoCxHepJKu2RQTo5mBdJpHKU0beXYIYdqE5LSq4AO9dxzY6ZhnqY0B/vkYcT5Of0vIl6Q7Dnn91p30eUQBkrfYMqT7d2op2cb52n97738Ns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(1076003)(83380400001)(86362001)(38350700002)(508600001)(2616005)(186003)(2906002)(26005)(38100700002)(4744005)(6666004)(5660300002)(6506007)(6512007)(8936002)(52116002)(4326008)(66946007)(66556008)(316002)(66476007)(103116003)(8676002)(6486002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b3tX1l6XE+lzhLvaXYuVjguOU41ebGgE+oTgL9u9TA43jYQoqOMpLluONuas?=
 =?us-ascii?Q?m8v4ZLSp1OPvg9llyiscqx5q+vbGI+xHp3t3ovCJTOyZdQbfuCe1V+qDO3Y/?=
 =?us-ascii?Q?1yAJMCcX9raRW+HOVDI8uz5F7LwpgtosO7rVjeQGRdCk0YOxwhLgyPcjIG8e?=
 =?us-ascii?Q?XUSU3CpLa8eCLW0sphEyHlj9CwYRtjAPEbA4aZXAv635bbnSxxN4CHcB9EDz?=
 =?us-ascii?Q?nU7b7GYKjmsVpIpCp/W9D3YkXKRxxFY+O8w1HNTMBaA/HPEdVbe9wXe2zmFR?=
 =?us-ascii?Q?fgyKWykYUuiVhHaMrBEnZfCNjUCnnoZ7KEttfltpJf6iNi2nebYR7KFgCO6E?=
 =?us-ascii?Q?tqfxjGzHRsm65Et3LJ3jFUV/YPrHwEFQqw/1aKQG0sgPi6/mT0R35vLODfrL?=
 =?us-ascii?Q?lSJAHIXY6HzoePp4K7YY7byFzxzaHZrGwHVJUaegxj+EE7tjed1gvJup+D2l?=
 =?us-ascii?Q?F3oPkeR8YhVUHuheBneKvFlUAizZjjS0gpztcNE+DaIDAMLWGGRzYW/1blcW?=
 =?us-ascii?Q?WNT/cCtYAsYTgciP6VvGTqjKA38d/vftgcxoQi80VS9QY/lULQc1K7ezS79W?=
 =?us-ascii?Q?XkBlGQR8/qWcXq6ZZRZKGMW/Jtq/PdZQQ7po05sXVpxR/f2iLnnt3caWW/w5?=
 =?us-ascii?Q?VMEFjXqu7R1qZx/TYgs0rVo9EA/dv43L0Iaum9szOBn8voenGa1HO7at2dcP?=
 =?us-ascii?Q?r+PnZ49OYB4z0deEZyzPjY2J79Dmj+H8jctF4TSzIPs98siKyobhtjtHCraI?=
 =?us-ascii?Q?0o9hrYS79b5xdiJ8aYhd5ES0RMq6v3b0CVhflCnz+KwQJbyMqclO/exV7TYY?=
 =?us-ascii?Q?a4C5B8T6I2znpijn5COmGa5veBNMiakZWYLAQYNyqXRORUpKQsj3yliTMEcf?=
 =?us-ascii?Q?s9L8NWjovdr7orLSWWhTkfo5AJabG2Ko2P8HCYP+RoSOLGObayzjVbQ3Xqzw?=
 =?us-ascii?Q?XaHvO2p4bBJni5uzMMn493SrOnWqQw0MSqz3Q252vWWuICJgJuf1jx0RXtow?=
 =?us-ascii?Q?Tzy1Bx6mk9rED3VpMNqmhtfQaH/A58YlBCIN3Cu5ytmg9DiYP2PU4RjDkq5D?=
 =?us-ascii?Q?RMxNX3J6zdtH+H98YsUyjD83LwpKUeeK9IJlgCnmumqSkukBtT1h4csqS5DC?=
 =?us-ascii?Q?P6vQI8KSgUKVnou6Ep4FIuTYBXED3OFGOvhLNWV282Xn1f0eLAyHcKLLZI5p?=
 =?us-ascii?Q?qjqpXxUlIQNSendtXNsNWtIlkELP/aRNwQ0Lo118dfqpnYtA8XNQBSmIE2DI?=
 =?us-ascii?Q?PW2cglNmLAxw8X5cZL7TnmfV+O8bZ234DrIB/1xZz39A5pZMIucamZb9+ifA?=
 =?us-ascii?Q?8lY5LHoUA4ZEGS3+o1+sxGLdC+vrFsFmHgdqulxgraf0nqugQwufFqxYnYEf?=
 =?us-ascii?Q?Ns52azEnFta6ojTtVOxYDN/1GrQJ+lpkmlEKtAnFbCRQbzyxZGcL7EOkhAqA?=
 =?us-ascii?Q?m0jAcVXi1PBnzZLAnIePtvpH/kUINMo9ABdQ3bBMcSrsvR6TqyJ2Jw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315fd258-6aac-437e-6235-08da0d815fee
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 10:30:54.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVIcTeLaiTHlyqr7lnNGmRXh6ppQyBNiI8eywK/ZHz9RkVP0gZQtEIuuyPUDU223MZiezkejIXfphXAYqSBm+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3981
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10295 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=871 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203240061
X-Proofpoint-GUID: Z089giJrN81_z2Xkgbs6llRjoz4O7KrB
X-Proofpoint-ORIG-GUID: Z089giJrN81_z2Xkgbs6llRjoz4O7KrB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains changes that were suggested as part of review of [1].
I am sending these changes as a separate patchset because [1] focusses on
replacing some global locks with hashed ones while these changes are applicable
irrespective of whether we stick with global locks or endup using hashed locks
eventually and hence these changes can be reviewed independent of [1].

[1] https://lore.kernel.org/lkml/YjOpedPDj+3KCJjk@zeniv-ca.linux.org.uk/

Imran Khan (2):
  kernfs: Remove reference counting for kernfs_open_node.
  kernfs: make ->attr.open RCU protected.

 fs/kernfs/file.c       | 92 +++++++++++++++++-------------------------
 include/linux/kernfs.h |  2 +-
 2 files changed, 39 insertions(+), 55 deletions(-)


base-commit: dd315b5800612e6913343524aa9b993f9a8bb0cf
-- 
2.30.2

