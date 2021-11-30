Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6A9463192
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbhK3Kzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:55:40 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61194 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236641AbhK3KzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:55:09 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AU9kXrN009101;
        Tue, 30 Nov 2021 10:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=1JoTE+3ROxRUvArCkJI/e3MNxKHTFKuX4w9+SosTD5Q=;
 b=hH1gpxviJqnOrTGNm31r/vDu8/0SJyq/+SV50/bKO3zyyNDLa6lB5le+2gQXGOufCv+Z
 eUPBku8QrshFeZDgJd6ArJpfSra21VxjWTviR7KB85GVKACCE7Yu/GoljfSBrkV0jpOu
 aCGBrBEdzGsAsesYRJPCzOgrtKr2VvHVyW2WrYum6sZh5lEkCjNS+Y8dMK+371qctrlO
 zGl80jzYa6ejKMWYsg6xbVOOeK1Ttbue1i8qFdGBLz2keuMj+p8oRrBDjuNvk8ZK7piB
 QH+N5LbDy7RkqYf25IEhL15yprbdogOWtXYMSIX6w2EuEMUNxoQ9gzu6BUjI8atebxo+ OQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmuc9r65r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 10:51:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AUAjkZK101392;
        Tue, 30 Nov 2021 10:51:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by userp3030.oracle.com with ESMTP id 3ck9sy9dj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 10:51:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCBE9ctE6J8+f7dTcZLuJEViEUhcZqWvUFnPfNpPXEvB1r1NmKgGTIn/TpgLSkXUxYvc4rt0eSjvqtPdt0HBLXPsPnIQ60uK1eDG8wi9rzJhIO6BeFdMfc91eAeuqVA+GiqmapRv2MtW9NIx6Ugy0Vlq4WsCdfKFd1SoZBnGAXcNek3NkLYlxhkvAq2plwzRpRiwGVoNayAPYhnYF4jxl1azu6CXZfXor2MtjQEjp9mRO04QM++XGSYqhZjejT8wnB35P48jfAA6m2cGGpiCY0sVC8tip5Tj4XCv9eYy7/zdKL3wjYmSOBtO7gsEpp0aG2gjNGnEOAWzz2O3H0x+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JoTE+3ROxRUvArCkJI/e3MNxKHTFKuX4w9+SosTD5Q=;
 b=M9KNbKETF2LyY9ylocuwLK63a0Sdq5lkjk3jXGOfeX4D3oKa0N3gwIa5GAeb7gJbKeJncAwHnqgtg6riRb2s36x1xHL2wGnCgTwZs7CkXfAqo3urp97E973fvCaAWBcV2JXXrX+/47xsbigGcxbqwtZdOLihwxxFFYzDcBPG2M1Usxy9ejXLCoMXThrq2Cy9tdh/7yJ0Bs0U7aPiho3yOpkhxSsp4O0jgyvnFXXLOsbCloA12LK1GcG0V9GhO3ubN174xWLF+gXXwheuJrc8IMoHcISMjS/7WgTKm7sNkzcuyE9SUGCfeYY2gWow1l7u/vs4GSA9E7h+FCtsqsK62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JoTE+3ROxRUvArCkJI/e3MNxKHTFKuX4w9+SosTD5Q=;
 b=heR8ziXDwQTDuhaj1DNOFP91JToOSGkrmde3RgNkVHRRpDcOm2vST6VqGrdscaUgW55+EdhNUr06r3+PZ9JDtr8oqt3u2B3EZSYvLccU+Gnu7DDmxx4mu8zdWAjmOs6A4m8ZfAHRKmR1z9CG9I2XrEo6vLfOgRJlUFW85SWC7so=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4724.namprd10.prod.outlook.com
 (2603:10b6:303:96::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 10:51:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 10:51:29 +0000
Date:   Tue, 30 Nov 2021 13:51:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ed Brindley <kernel@maidavale.org>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] hwmon: (asus_wmi_sensors) fix an array overflow
Message-ID: <20211130105117.GH5827@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130105034.GG5827@kili>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: AS9PR04CA0054.eurprd04.prod.outlook.com
 (2603:10a6:20b:46a::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by AS9PR04CA0054.eurprd04.prod.outlook.com (2603:10a6:20b:46a::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 10:51:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b053a81a-79c9-4a2b-f02f-08d9b3ef5d6b
X-MS-TrafficTypeDiagnostic: CO1PR10MB4724:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4724D8382EA5D83F823FE77D8E679@CO1PR10MB4724.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LU1Rrp9oHoeQ14AZ0/zCtRirjSjqsXikKqQmAtOdrz5vB3y2EN2Q55rZdZuCuz8GMfl2Xs0cxtPN/peo9BeO2VhawHZu24zHdoLYApqx1G0NNlSsrc5jpxzoDCZrCdSSVOnYayr13hKP4NVMvaAwCpBYVmeD6NtV7E4cd2D+PqV5samzo8FNEoQGhgWt7VyTFuSZsMFXXXcnLqI+w/OfxnTZpgh9AYaqkGQBJ2kCw6HAJduxkIHKmIW2KkbalaD2l3dFvc4na7hH9X8damCWhHukuTr0cUAjmRLLFmqC9EPjg8mUdZKshawuYrcqQLbEJCLyUO5pulF70Lyo7Pcjat+2A9L2rw4jsURtPi1MXoPTCs2nPT/lRx7Jin3nsZzTLfHAvWVQNuRJx2ikol7a49eg9dlDqw7BcEULxvhiQZHHCbiaGOvmgurtg7zGnQaJSbaO8ZSSWrpL1JRvhQnjt43yT2WD5IL56qgT5vcYIXwaZTFgLiHWPm96hkpTHhbh4wf2hdJMuxp5scMNah4psCLBBiUqpTXXTBNa2JzOv8ayeqS7J2faw336B16cVSTqHrCKSQGhfT7WiV50VKY1R+4/29nKhHwHc8yXYvGdJ6Q3048jBLnMjQBRWpEi3vuDGG2TRHLzJh7UQdaCU8oePNsdwqZZc/Nm3fXrYx2dGvH1To9sgjDoyrEtyIbhEgdZDVA5BTv9rJ2u0tLlVufGAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(33656002)(4744005)(1076003)(9686003)(8676002)(38350700002)(33716001)(83380400001)(86362001)(5660300002)(6916009)(316002)(6666004)(9576002)(54906003)(186003)(26005)(44832011)(66556008)(956004)(4326008)(52116002)(508600001)(55016003)(6496006)(38100700002)(8936002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yDaWzk9bf9K/XUav0vcgQ8wehq1qzTSoJzhj/l2wzkmp8jh+4DsmKEnEkS+I?=
 =?us-ascii?Q?FO64ZoiTNouMiXfFxGqFezFHyAfc0AYLnBWJm3L3yUKMMXYQQdL3ZoLS3y2a?=
 =?us-ascii?Q?RoVjGKLs6q5IZZEjW4kPgKZD3ISj68xx0LFxj/Cf7aSagDsu8BbzFcxR+IDb?=
 =?us-ascii?Q?BxxWVPXPBKRD7lkjkcXuuT0Rcmkb7Sfmx92gBgKXbYDMcq1B6sFkRQZqGfNy?=
 =?us-ascii?Q?rEFJEBntRFLTWfFsZVAZYHXAsi5Dy+nO21KvvkRMYKKbRf7sAcDo0CzQU90Y?=
 =?us-ascii?Q?u8nHJMvh1DF/HKCmUlqxps2yM2osfGgesGOAYFP3j1UQLcTrAlTOC8j6c70g?=
 =?us-ascii?Q?wwk82TH5UEtzp4pW+1ID46CXy9iM4ZWQhYyc2pQBtFB+zrbBQd6QdB3kOSK0?=
 =?us-ascii?Q?G668SRuT36b+LK2+mXMlTH10lSMCZ3ddtq4RVZU+Sbdxy0vs2IQo0Nu/h2N9?=
 =?us-ascii?Q?OSzyAiEeEplryNy87+wABkMOwsKKMYeDoLFXpiX8tTFWn20W+R5mMK1cTMB1?=
 =?us-ascii?Q?jq7NXV204ANjdNX4HUPvvUgEfLzroa8Ks/Gn3dldxptKetzEc2A7su2uls9u?=
 =?us-ascii?Q?cpJCCifBeqntnA7gS1eYFLl1zJRYFh/OO9B99uc4SAK2JoePU5IRSPLArjBN?=
 =?us-ascii?Q?Q2QgW5t+ACd4ukQsirA5J6/V88fjKbIFUhBWG/kgivKQjJfGQxhnWdDycgTO?=
 =?us-ascii?Q?AzP4UWM8gzSiPtDcppmV2KScuQ1WcGchcEDojIL89gNNkuDVZtAXqwNqpPcc?=
 =?us-ascii?Q?J74l/0PdHGnCNZZx2iziZ7/ofxPOQgfVNC44RxvwYZ4d0M5Fqzm6rQLrxREv?=
 =?us-ascii?Q?UOMQFZWDdTarpCrs0StacIIpyi25pHOS9IHgCBmgWD3Ifi6opsoXvA3VvM2J?=
 =?us-ascii?Q?P5Yx1H+uHuErq9qDv92lU41ta8Jy1YC0FYIVw3STebZvPp9yWszfKP0csbno?=
 =?us-ascii?Q?c/qG2OgMA1/VZV0zSawc92ZgdsXPWgj3k0msNYc79gBVcxE01JRJZUi3eVsc?=
 =?us-ascii?Q?nkJELW6CFd/bOgN5FnmKKApSb2qXkwekDoie2QgoaRLGVBIH30LUNzHCS8Cy?=
 =?us-ascii?Q?laEzQ2MRC7IRWALaVhnxBFh7etuIdd+m7sbfbt37DfuRdd4523PjkmczGPZ9?=
 =?us-ascii?Q?s8SsIcfqVTAen0/qV+2eV6x/xB/yg9pcEEjBBjfatHjNls0Kcr/7xAK5B6of?=
 =?us-ascii?Q?jWxy2y6A3Za73+e3cN5EyYF4bp1+UUtI4BaYi8xWlT1rm9hYT3WeYOtKiafD?=
 =?us-ascii?Q?dGiuSA/VN7L9/xLc8LEYGvEq6x7Jtb+Io1/tuCLJ6GgdqVOz9q4saBr6/D8i?=
 =?us-ascii?Q?ESYfepvGD3NOO3r/H104mx0Gw0O8NjThOn3lLvoaSdarMz2ynfvpYaFkh4fU?=
 =?us-ascii?Q?/BIs5CEnBJ6prlyc9evlxBDgkRzKAkAQzw33TYI2zhfbGOWUhu2090ux/ctR?=
 =?us-ascii?Q?Ea/8QtB+TqMuZPXWcMec59cugPK73p9ud5oKvSiWNQkuP0tibRoAFJrshd3q?=
 =?us-ascii?Q?z+WWNFf9JStIezptenQ6uJTUsDWQ4AkbJpAQ+Qt9Mlmd4GxCXIT2YSAPTMNt?=
 =?us-ascii?Q?bM2/qXr4I1e25P0G5sYcP0Nj+lccTtRRZ0Vo8i1sMgsAhfueCWzbzF1YXZgi?=
 =?us-ascii?Q?VaB7w1iE91a5zWCI97zoYlfhjHFxlu94jPXhRfwNOxhwfaZ+O3RLvUSa361g?=
 =?us-ascii?Q?LgWhGy3PkMb69DPm5dL6xaoeiec=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b053a81a-79c9-4a2b-f02f-08d9b3ef5d6b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 10:51:29.8474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSED5MJO9SoeUENtEMW+u3SKH6BBjNoGkNFjrH7R7ZBqJ7dBg953BRHmN0/6+IaEVWZ36SAgxQlM8f1Y/x/0RNW2aCTJCL7yiCjS+gK/R6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4724
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111300061
X-Proofpoint-GUID: O4vmH9sDFEInEVSwk7nJQrqbFbFm807j
X-Proofpoint-ORIG-GUID: O4vmH9sDFEInEVSwk7nJQrqbFbFm807j
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch detects this array overflow:

    drivers/hwmon/asus_wmi_sensors.c:569 asus_wmi_configure_sensor_setup()
    error: buffer overflow 'hwmon_attributes' 8 <= 9

The hwmon_attributes[] array should have "hwmon_max" so that it gets
larger when more attributes are added.

Fixes: 9d07e54a25b8 ("hwmon: (asus_wmi_sensors) Support X370 Asus WMI.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/hwmon/asus_wmi_sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/asus_wmi_sensors.c b/drivers/hwmon/asus_wmi_sensors.c
index 67af15d99396..c80eee874b6c 100644
--- a/drivers/hwmon/asus_wmi_sensors.c
+++ b/drivers/hwmon/asus_wmi_sensors.c
@@ -125,7 +125,7 @@ static enum hwmon_sensor_types asus_data_types[] = {
 	[WATER_FLOW]	= hwmon_fan,
 };
 
-static u32 hwmon_attributes[] = {
+static u32 hwmon_attributes[hwmon_max] = {
 	[hwmon_chip]	= HWMON_C_REGISTER_TZ,
 	[hwmon_temp]	= HWMON_T_INPUT | HWMON_T_LABEL,
 	[hwmon_in]	= HWMON_I_INPUT | HWMON_I_LABEL,
-- 
2.20.1

