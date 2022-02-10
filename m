Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D8A4B0370
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiBJCfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:35:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiBJCfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:35:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26FB237D3;
        Wed,  9 Feb 2022 18:35:36 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21A0AQ7Z017462;
        Thu, 10 Feb 2022 00:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=lU5ixG5Icbbe63D1lJvUoWI96o5esydDCBJlUeIuLmw=;
 b=MmuO8Zp13ICbQezk1Bto/XLg4ydqgOBVrGEw0Rg4ZhvLBbnldKbOkilBcEwcS+f4dSwV
 qRC2wRSHiTpTC13VQzB7gmejor9ekmgTpPaucEYk3TgyI1kFgv1jAPalzKjUXrVHa5Y+
 D8uQYJ0dR9+LEkvo5wvdXimpShyMXjOLtY1kvOuziFh0YqJTHvVhaU3okCOjvLzbXrn3
 S+ysruCXPl+//PUhHAtV+gg28c2cq18wTlxUFEkpGtSsvdrxXrGmzRjeD+edDiOz7BXY
 RuytvI5shsKEVC0IMA0QrFre4mUUQex9Tb++3GorxsSk7nzAUReSC2hoXOzfDw2hCMsN Dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3h28p5qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 00:30:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21A0G9VB153756;
        Thu, 10 Feb 2022 00:30:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3030.oracle.com with ESMTP id 3e1f9j9rbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 00:30:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxLGD1VHe4tudCz32Iyt3NYkBxDMsDz1Dvq8e0ZwaYuS48X7XW3x3aMfAQor9GkO4R5kbRgA8e70mPk3iznmc6F1xyt14AFAMwR+zi60BW+Pu1rH8hJnrEE7cstN/a7xeN7SBMobZkURGFE0LDMK2IoJE/KkQKMnFVTMZ/2Y5xnkjBH/uiN1zAtZHQeDD9YIxqDIUyYrfLVjCCC9NMCXI6xVvFU8quD/kG/+9CeqXwb4byknkGW6tvTWqsjd33vgTaIKnbmkhMf83HkGPMmZlRUw5fysd+fVPkw6hr5Tw1yuBj+Twdrd/+EFHVBeEKy+htSCm61fXcnKBP/FI24+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lU5ixG5Icbbe63D1lJvUoWI96o5esydDCBJlUeIuLmw=;
 b=aw8Kxh8l0Q6PuO7kTFNyIO9t8IEn1d9RL7CI6whF9L8PZIYPAu/XWkHqBW8WGP5ltUiFulpjr6YJFY6khehfqWYF9jtTmrwQec79PvZ0VekU/3AfW6G3atRDlScmbldi6w+d/IbtBmUAmwW7rbFwKWD6IPQmfk0oEtF21o7vkRd04BhMjsfAe1JCZNx8OhaczaF6WQu6/g7NYecC6kiES/Bzj5ZHY/LavFItWW25DHP2VpydWoRyTQ8lFhgHkAkPmGLZDIuFvgjP+SmJL5NZbUaikAy9kVliR1alrMYRuvfojFr5bn1Ir+y6zQaLSPDi1rkwiQymFPDuvpDr9qqrYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU5ixG5Icbbe63D1lJvUoWI96o5esydDCBJlUeIuLmw=;
 b=QveRU759UqXLG3xiaN8X6Zv2lxpmt6bS4hGWczgnLJCeQuJLDlYS3Y7fhFgmY6zANysZkLoWfL4Z3tmXQUnqT3xko2gWZCcYA2f0ysZAWnwqTaxAMUKyJviolkLfjypcSbK658z0FtcjAtk93L9iaiJOV5ZJTLVgqNk/9RkH/MY=
Received: from PH0PR10MB4472.namprd10.prod.outlook.com (2603:10b6:510:30::13)
 by SN6PR10MB2701.namprd10.prod.outlook.com (2603:10b6:805:45::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 00:30:34 +0000
Received: from PH0PR10MB4472.namprd10.prod.outlook.com
 ([fe80::94eb:56d8:7cd8:ca76]) by PH0PR10MB4472.namprd10.prod.outlook.com
 ([fe80::94eb:56d8:7cd8:ca76%5]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 00:30:34 +0000
From:   Victor Erminpour <victor.erminpour@oracle.com>
To:     a.zummo@towertech.it
Cc:     alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org,
        victor.erminpour@oracle.com
Subject: [PATCH] rtc: pcf8523: Fix GCC 12 warning
Date:   Wed,  9 Feb 2022 16:30:27 -0800
Message-Id: <1644453027-886-1-git-send-email-victor.erminpour@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0058.namprd05.prod.outlook.com
 (2603:10b6:803:41::35) To PH0PR10MB4472.namprd10.prod.outlook.com
 (2603:10b6:510:30::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91f7a4a7-5d32-40e0-c64f-08d9ec2c8d6c
X-MS-TrafficTypeDiagnostic: SN6PR10MB2701:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB27012F1D0AA1B3E8B7E3C9C0FD2F9@SN6PR10MB2701.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VotnsYCnondm1YZd7TVqiMVOPzJnzMvvIaJtLKXeT9Nakx0yYG1/7vWw/tERc/vLroALEekSbvUtNzKmRArkOUVeKJPHPkj5UVLmmwYH7i7utyU27SJbXetoFwKf7WDAERum0mzls5RNiuTHQkCosnCnOONhdEQLcsVnnHqqVUna8Qd+JYc4Fvhfk2HYfzRwNx/D9W/iHyGBtLJ1+24zPbduTuvh8Qpx2VGEh38xw0TDYuEaP/OmBwpGGvebc9hRMzhLpM+Z2C07RKA+gFovNMnKYY/7n6bRMdVSI9iuu7nQZopG3+R+H50CCDwHRoYjR4RPFYlkV23U0alwcOmvgXI6zsRr1T8LZR8XRb6Pm8Gd1qarb333KJsLeG/TBymdcVKQ8dSX/ozbKNue2s43/gV/1aIw7pBnPp0uPZ/lrxLW3NRYtP8Z/R8Z/4uYexfIBvgP47m+1XLBPxIhZtUUkN52Tvke4eCiQLq7z3rda7VEo0SparMwsQ06ch+9h7HdFTF0cBUttzg7dnxSKOc6TqZcaaJZ3DgcIaye+phy7pqIobTNlTU/LfBoNROVZ1S0q2nPwB75QcNzfVa0KIzENKJWGt5yKiKz26e/1mFAc6OTd85I4P6oOe11se4Di7CZV8LcjURmfgqtLCtlR3wLS4JFBXE7/fFUB8OYqk0WsKD/KImnPCoIPSFGt3kjIzNTlHYUcMr9wKSRmf3i7xEc0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4472.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(8676002)(38350700002)(186003)(4326008)(8936002)(107886003)(26005)(316002)(5660300002)(6916009)(66476007)(66556008)(66946007)(36756003)(6666004)(6486002)(6512007)(52116002)(6506007)(44832011)(2616005)(508600001)(38100700002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D7a96bNUJqWI/3xaZ+0QvtcoHjp6N1DjX/plQ75ts4yq1bdcAFOEBBdNcR7U?=
 =?us-ascii?Q?6E3wvX7ndtQyGiaQXbdl5HTtXv9gyMGzd0OMZbdiKnZncLcyR8z+5Ey0PSR/?=
 =?us-ascii?Q?jfOjo5fvQT/3fKHcWFQGpxVYubey0MHMZs84ZCXkbnEC77rQDWKsKMVoig6+?=
 =?us-ascii?Q?ULVFySuq3F88gHVgqBLmHZI67/vYpDwULBOKhDKctbndCyLtEuHpOiV801/4?=
 =?us-ascii?Q?sVdeyePQBYMXRI+z8FYOnyE6fT27oXElTnloDT3dnUnHQpdM7ek3Z50fxMsK?=
 =?us-ascii?Q?iiyZoqeOe2DDVkn/R0cVe/C/0ppz5taCAVmScC4l6NBX23cM8zDcv3KnUDmV?=
 =?us-ascii?Q?i1bnl/7WrkUVW9RoVG/FloH3oifCMqDKlKJ40nM4XiU7q2HcgtTK1Jla9Dm/?=
 =?us-ascii?Q?0kkNt4dk+EMjzDSPskajvzUfFk3/w2O/EaWi9mZr2CWB2vH9wDPfJVa3bkj6?=
 =?us-ascii?Q?eNUz9nhmREr21vgzsGuBlrbnciwHm+sJc/u4EY22JybgWjoRAqvZaPS3eKLp?=
 =?us-ascii?Q?1c/r9j9SFvzw8zSpVzPeXYpX3N061oa3R6WrACTM9Kp/r2tN6iveOvJqinrX?=
 =?us-ascii?Q?nZZJRbAVazR+cE7+46PYR0U+Aeh+OnKUlcpqiQz9HPA1rIZ3a6StsmyG03Yn?=
 =?us-ascii?Q?tsaeDCzNJKwrIY1j8LEDHB1TrCkuSkBA9LxNwQqhN8vaANLU8bB2G+1Ho51U?=
 =?us-ascii?Q?ONVXfZWQFl/EMnolGC1G9mfaRVwB1F+nXyw3goAMc4w4ucY5l2c7qcvSRpdo?=
 =?us-ascii?Q?BrZcmrT6wo22ywmJEtAbU8lNalM8S8300adE2GPBPrgjMuKA7oxkB/1qEIPw?=
 =?us-ascii?Q?5aoqmFF+YLCaug8kNpcX2l6MZPUzPdDzv76kh8P7w41O/MwN0pvxdWaCfjIl?=
 =?us-ascii?Q?YrUlkiWxG5xPRl/DHj+myyl+0/3VtjDOHA26CXoNkcsKnpg/W4QqqvOvKiSL?=
 =?us-ascii?Q?CtwyBfsDEY5FjnKmQ6iPA3vMWjL8EwLu8qu2aJ7nm6hwMETM1WdKIwFP0g/v?=
 =?us-ascii?Q?/KdVa6AnKOIOP9id7mp6EbIU6J3j5tBXekXvActnYwmD7Zb27KQ9MqS/yIuA?=
 =?us-ascii?Q?rpLbRjT0g6wsHPCa8j1w0cPRrtQuPb795m3VhTLWNSVt0OXVBqzfo25kGrAc?=
 =?us-ascii?Q?qqJXYMm0ZWOI90Ct7wNRMT0YFG6n0Kd+oD4pk0XT9TsSRtaQPPL18jWdJr5d?=
 =?us-ascii?Q?8zmov6pmgxxTVMRrcCMKqneoIlKIXTeYG8+BKKpa8/42K/ivQU2Onf3HfBlr?=
 =?us-ascii?Q?jH6MFgS/nrRXgDBdw0NmMxRS0NpnUXeiCtM79hta9JaNOwO8kVVwNUoSunu+?=
 =?us-ascii?Q?aFxkPSRbcJ0hvxrCsPM12wFxwrjW2M6PrnzcvEZyNNBZEfqUDBMUSEVOCER2?=
 =?us-ascii?Q?0OmlUF1AsIvgaCBJPntMddJ52NR84Q5yBWXqCdCRwsYvf34o7YVlBfv4vZdp?=
 =?us-ascii?Q?Hckk9/5iUS1M7gqTBQ6vIxKlueN78+rFjUKA+wOYvQ2Cu4k4NxzEhxTB8L4/?=
 =?us-ascii?Q?5D4g+EZ4uwDhatB1lN56I1JhbJN6JlCTcXMFooKAMfgCn9Qg32jXpQ21uX2b?=
 =?us-ascii?Q?+mfGPa9c1n8cm+kXWJJME8j9kum2A9LBhGR06M7khAY1oNp53SbtIb6xqjiH?=
 =?us-ascii?Q?HF5RqE4jvFKAzuVomIsNy+cO6XxMnKVHyUV3anZvxAPijYeAk1YqLcRPzkPr?=
 =?us-ascii?Q?v9LQTg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f7a4a7-5d32-40e0-c64f-08d9ec2c8d6c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4472.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 00:30:34.6786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpPnCD/PelbhxzPKNXyKPJ1IsL/g3XZyJsy4XrLiJU4anP/sYlhcm8iVeVRVhngKzVAg/gsHmca+cb0yMd9V893JXfnkknIysYSPQL+d2/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2701
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100000
X-Proofpoint-ORIG-GUID: s5pTDQbunDLUe0lM7RbVSrJIwElIpOWP
X-Proofpoint-GUID: s5pTDQbunDLUe0lM7RbVSrJIwElIpOWP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with automatic stack variable initialization, GCC 12
complains about variables defined outside of switch case statements.
Move variables outside the switch, which silences warnings:

./drivers/rtc/rtc-pcf8523.c:284:20: error: statement will never be executed [-Werror=switch-unreachable]
  284 |                 u8 mode;
      |

./drivers/rtc/rtc-pcf8523.c:245:21: error: statement will never be executed [-Werror=switch-unreachable]
  245 |                 u32 value;
      |                     ^~~~~

Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
---
 drivers/rtc/rtc-pcf8523.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
index c93acade7205..baa89f431ebd 100644
--- a/drivers/rtc/rtc-pcf8523.c
+++ b/drivers/rtc/rtc-pcf8523.c
@@ -240,9 +240,9 @@ static int pcf8523_param_get(struct device *dev, struct rtc_param *param)
 {
 	struct pcf8523 *pcf8523 = dev_get_drvdata(dev);
 	int ret;
+	u32 value;
 
 	switch(param->param) {
-		u32 value;
 
 	case RTC_PARAM_BACKUP_SWITCH_MODE:
 		ret = regmap_read(pcf8523->regmap, PCF8523_REG_CONTROL3, &value);
@@ -279,9 +279,9 @@ static int pcf8523_param_get(struct device *dev, struct rtc_param *param)
 static int pcf8523_param_set(struct device *dev, struct rtc_param *param)
 {
 	struct pcf8523 *pcf8523 = dev_get_drvdata(dev);
+	u8 mode;
 
 	switch(param->param) {
-		u8 mode;
 	case RTC_PARAM_BACKUP_SWITCH_MODE:
 		switch (param->uvalue) {
 		case RTC_BSM_DISABLED:
