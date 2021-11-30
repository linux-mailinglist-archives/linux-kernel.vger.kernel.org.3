Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E374631B5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbhK3LCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:02:03 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21112 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235667AbhK3LCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:02:02 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AU9h2jB009060;
        Tue, 30 Nov 2021 10:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=a24LZ43XePGskJlKmU8wvd5BO6GAMnOghsIDUjd3R0Y=;
 b=wbl/LhJXUovzS4q08sPhAWH0vEq2MarWSpcGUZGNYzhsnkCrdS38L2CJ9LY0NAKAQqlt
 +q3RIZP6ug7twd7wFBGxrjfnrvFHK6jprDvW0cKUCuxkjdJuhKRZWupAfQOfxbrcKDBR
 r6LTjihPg/SqTgxDrj1X1zZoRzTfhAH/x1RSBDeQdn8vFkIBPabe1386UDGyYOivO/AS
 ia5eF2Ahqx+c5RRGiMlQTCvVVSPh31RCzNj6JRnKEqafJI3VtfEXCuZTKENkyx0z8Jk9
 /75eD3Rec/zjD7QUrae+ZeC+MQG4kOhPnJD32a63NyoIYGvUc826/W3vKFK7K7C7Mras xA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmuc9r73x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 10:58:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AUAoKQc024687;
        Tue, 30 Nov 2021 10:50:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by userp3020.oracle.com with ESMTP id 3cke4pajwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 10:50:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lN0p9cssAvruLZRsybOo5xYi4BO3EL9DUvppOP/WIRBrDJ9gIuhYqo8uX4Y9JTLempTC/xiQfhUIZKLLz1VWGbJjgjL6QbLAW7fQ5zd3H+mZAHxHHrQdl+Sk2+tGQm14FZEwOVgsWPDqFyHP3+XBAyBVpCcmLt/whM1RceLmDlU6RgJH3+TpVI/YEnnOV1zPzFSCLf1RemyNctaXdRCDMNMxlUXckcLMmBPeBqLS8Z1qChNSe8yrbTLcjkAL6Ckcz+DuT4g2oKRV2h66tvIc3MeSgz1SXbe6GihSLwBVBbn9gBpKR+HfUs3TwY/YMulCPUUb6xDZAEoyViixYAeOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a24LZ43XePGskJlKmU8wvd5BO6GAMnOghsIDUjd3R0Y=;
 b=M8c8wwWLlID/DjUKDPgH04MbwsXFJ6EbhR0vbiecU6/k0eVZlQEn1a9rzFmNqzKsOGKvfi0lkb/4gZm7stAG1RuDyTleWdpwlSsVOD7MR4afjbkt95baM7RGvYPILb49dz6+3Bol36znFOFBgthIxe/7Bn8SBv4ffzOoxl1uobCyTRW6Os4kHBZelt61QLGl1SESsopPu74udV6J6L1Aagfbh742B3zOi0pwDQFn7o3VpE3UMcc8dxlC0MC7M0BSpW3NECTCMqGf397FmZqoFm97h2KCb2kDleMcCL3VBCJabFTdigx79ryN5eBeu9/YJQmlPWzeLRNhOMNvOrov0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a24LZ43XePGskJlKmU8wvd5BO6GAMnOghsIDUjd3R0Y=;
 b=xOmZUgpWOZ3r7NCLV5K0SK4WnbmRaTDX44JpaCWPmWdFRdHNiZMzUZWIf1cyPJEN/eZXWCw3WhENCU45488jfTx+u5ueQOkP9usl/JqR0b318q2JrCLTUaj4jn955JGjLgl0Z+aOL+jmFqy67wo6UxjfVNgxjKijvw/tDIzemLM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4724.namprd10.prod.outlook.com
 (2603:10b6:303:96::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 10:50:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 10:50:46 +0000
Date:   Tue, 30 Nov 2021 13:50:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] hwmon: (asus_wmi_ec_sensors) fix array overflow
Message-ID: <20211130105034.GG5827@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0101.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0101.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:23::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 10:50:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36f906a3-1c72-4b58-e709-08d9b3ef4395
X-MS-TrafficTypeDiagnostic: CO1PR10MB4724:
X-Microsoft-Antispam-PRVS: <CO1PR10MB47248DC9001CF3649C8EAF2D8E679@CO1PR10MB4724.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TkskLGFCrHv8yyiNRddF4h4lUubaz1SBbz4VRzxUsF3RmxvniWGiyi6rpSxqioCwKipL28rCnTCYFg6Zm2tMLbVlKzzselm0sfQMcolRXejlpgJjaa3IKzLK0ZX3i+9cHJAPQScPV90AAe2dWIvSkLl7renv0lTgi2j9bSQWeGoLWUeoFBiP5uBMb1Spet6yG5l8XMq4BK7htV5/HPgVHbcP+HVX+aUdNy3B+/1eiEoPK0S5kKmPbrg1hNjUx46LXK8OnlzDg/B9VTq9+w4Z2WnjepJbwQ+WdzaxB5bxmtgtjsQ4Xg49ay1P3esNEcq+e+bP6nGt34ifJNRNFZ/t6LsGC66U9zI3TzbrxNKvTMTYez7SAXwZBi+2rtVkh6bYSCc0mJTUnQZn/wcrhxZrWmjQRgdApw/p0g8wf+U0Z6KngRBV8XVe3L7u/VnBVl2EJjtZLNmn+YkKJY+prjsDsNRnJNt7h4RB+WHaYx80loEcWuNsWWo1dR4QgAXk5Cd7n9Ke1jf/BNgE+RR3B1Yfq8QAQ48k+YLGYQJAf4bqLVjq8iFLxNcllJH3qAW/GcoIU/CHzBHFimunXTPWsDkWki8T+5DlRmCigJxCYnL4jmJUdkNFvqS64CNmuK/V8CVYUOF6IXe0rRbwHzdCfM/mymDqPIcBkLc58bDkEN0E0JP5j9vw27CLQx9rds941dcn7w9AwkFbOecjob6u601Qdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(33656002)(4744005)(1076003)(9686003)(8676002)(38350700002)(33716001)(83380400001)(86362001)(5660300002)(6916009)(316002)(6666004)(9576002)(54906003)(186003)(26005)(44832011)(66556008)(956004)(4326008)(52116002)(508600001)(55016003)(6496006)(38100700002)(8936002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RYCJPQhyQuDAPjmtICN8J42b1wJfeL5EzwwExrHsMQUpvsTVGGnlIzShVr7L?=
 =?us-ascii?Q?mBKHJQ1ba3LdGtfrdxqsYEUOlbtI7oXOqxRH9Ev5MLsPer3ZJ++Zv2Mzt+15?=
 =?us-ascii?Q?K3Ul0xeyKXaP9PeTgU3S6Dtrl2ivzaoO6arE9jI4vfa/Emmd7w2oS4LMyhDj?=
 =?us-ascii?Q?scUp5glpoP+/EcD2VYlsehGzVJdEdswQyGdaYKvD85M6RQbMHTXNRZwbgrcu?=
 =?us-ascii?Q?aeymRz0UMR5xUCa9VYFW3xZTCp+xr/8t0lx0pg+P2Bpn+ic6L8bb+1wC9ym5?=
 =?us-ascii?Q?xNQduVN7c/GVIY9Hly4tBEnJM1YMMuvMNsJf2F1kvxrMRrCx0zTksh1tXzdk?=
 =?us-ascii?Q?hdU3VxXoQMSXSWk7HnrG3A1YqcdxUr2wIAlDtf3l4kGu0DADrfCMVpVDu8Ip?=
 =?us-ascii?Q?Q4vMHAeHDLdmVEXKrQartaqaDoDA6miSaA2Zx0pvYPIV6EkkHqnu9EwiJw3i?=
 =?us-ascii?Q?QwrSybBsrPBBDIql/h4mJu/STEtd4kXrlWgySg+e4SIVPLiQ+AyEUj/NvDxM?=
 =?us-ascii?Q?RNUpOptgWQp4/yXce/HztwL21QulGM0SiOGo5SgChaqPZXGQE+Xw4jV8RSi0?=
 =?us-ascii?Q?/GMV+Me/dtwwQfXT2O0yXghutA2XLMbHsXUT00/O8B8YAr5Vy+v8EkGLIdmY?=
 =?us-ascii?Q?VIZBpUw+O94jxnYLIvDLaQeiA/aDQupVRMtW5GWoE3/2350UVGmX2EI0fYqG?=
 =?us-ascii?Q?+Hd6m7tOxunJUW66xcdalEQlTUbyTwdYzCyVCIqXWwcMHOGK2yni6heh0BrK?=
 =?us-ascii?Q?j2SJ3P+t0vkB5UmhFQ20XExzFk65aTJVl9zVVbDFh2h6J0XnwhdxzZ3gWLoQ?=
 =?us-ascii?Q?/0WVkh7Z9ILonsYkHfLRwEypcaHTb1iiiNpzs1WAeSBOr25lEr1wWcuGfQKb?=
 =?us-ascii?Q?OQg4ZaDHui69AUnesmoyrru/CXDSOyRgFEp277LbEQyvUYOUoB5Hwqo+KAQA?=
 =?us-ascii?Q?4G8bw9UyaelPyfQINABQNSaaWOCuMKe7Z1q9C8cWJAgeq6V+2hSI945+cMDX?=
 =?us-ascii?Q?mLnJWEOl2PgP3rr1KR4O3LSnbCrRqTU+5w4Bd9UwYE5avZ/2muFyHG9T/Q/m?=
 =?us-ascii?Q?9xWawPe4tg59S/e20gtAfJEslaVz3LKU9XXLFVbKu299Gedab5x2RjYZml6b?=
 =?us-ascii?Q?mEcOIxw7DpLghuLLHmn9JQ47ddcJcaulQnaPOfXLa5T9FJPQnuOQjkq6+xhv?=
 =?us-ascii?Q?GtS1iBJ7I3zQhzVBBV7OQgU9YK/8rKSpED1dVgbqDg2VNcKS/Bzx+mBkQoNi?=
 =?us-ascii?Q?GGKDv0SepDTp0TVRH2/rR5/r9Ae+RWTk4q9LIJNGMor0VNs6dJkL75PhK9ho?=
 =?us-ascii?Q?OX1RPTSJxEwHQnNQT2Cst5Q+t+N6jTiYGTdtwGR0ehXRrzLuWpoEy+ljpaft?=
 =?us-ascii?Q?Z6sOejvA+rLRKLSZdn8hUU6K/yKHvFKYjmoL6+94giu2elF38GnQsGQXeHK7?=
 =?us-ascii?Q?5luFX7l43R4YqXZ3q9G+K6DLl09kSXUQ7qd4kADDhjCF0KnWro23aveLe5KG?=
 =?us-ascii?Q?khwUky8gVKZeWggc7EI5uUmwRx0Is7vX5AzEIu+hxsrO4/vReWDlHhzKuCdy?=
 =?us-ascii?Q?Q7C5Z9P3vig8oxJC6o4weqccoDIL92wg+2M/Jowa7ZizhrEFYYcskaTNF8Fj?=
 =?us-ascii?Q?o0/tjFas/6HzYlbS/wx4UGkl7EyYi9yoIrgml9GWJWtSO8eIezF/9w+1faD6?=
 =?us-ascii?Q?yHU+c/CMFvDOhcGthWFkrsZg8uA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f906a3-1c72-4b58-e709-08d9b3ef4395
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 10:50:46.3418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbMX0wbfMtxp0fL5B+X5Qb7e8E+jTDcm1Pho726sD1F/jl5HmZjpZcFZthYOWrj2yQPYFaK8ndnQFfN+CVqcpbcQ5yf/Pg3scukMSAkeg2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4724
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300062
X-Proofpoint-GUID: Kr_HNvQeCEI-0WmJ9xcIujdJ6EJUZ7nS
X-Proofpoint-ORIG-GUID: Kr_HNvQeCEI-0WmJ9xcIujdJ6EJUZ7nS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch detected an array out of bounds error:

    drivers/hwmon/asus_wmi_ec_sensors.c:562 asus_wmi_ec_configure_sensor_setup()
    error: buffer overflow 'hwmon_attributes' 8 <= 9

The hwmon_attributes[] array needs to be declared with "hwmon_max"
elements.

Fixes: c04c7f7bfcbe ("hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/hwmon/asus_wmi_ec_sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/asus_wmi_ec_sensors.c b/drivers/hwmon/asus_wmi_ec_sensors.c
index f612abc66c89..22a1459305a7 100644
--- a/drivers/hwmon/asus_wmi_ec_sensors.c
+++ b/drivers/hwmon/asus_wmi_ec_sensors.c
@@ -41,7 +41,7 @@
 #define ASUSWMI_MAX_BUF_LEN		128
 #define SENSOR_LABEL_LEN		16
 
-static u32 hwmon_attributes[] = {
+static u32 hwmon_attributes[hwmon_max] = {
 	[hwmon_chip]	= HWMON_C_REGISTER_TZ,
 	[hwmon_temp]	= HWMON_T_INPUT | HWMON_T_LABEL,
 	[hwmon_in]	= HWMON_I_INPUT | HWMON_I_LABEL,
-- 
2.20.1

