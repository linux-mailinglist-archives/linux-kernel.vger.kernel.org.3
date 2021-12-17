Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114044784E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 07:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhLQG3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 01:29:33 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23762 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232073AbhLQG3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 01:29:31 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BH2UZGd009316;
        Fri, 17 Dec 2021 06:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=aqYVg5LJdIaojloGrIMe1822llZVNHtWXsNWDMdi5bE=;
 b=DOMlfndW4MN37ZjF6rpB4fHukNVdhUdzXnhL5IcxPBLfzO/bGCh8eJ8v7kDFWYCcW94C
 OzJZV5Cg0r6LiGKM/7XKkD1GIb3/heE63T1XegPsQcIqZCx7q1FD6Sj0iI2OfFm9GXdY
 VRQJebFTvRHWzADIZvzplFjzmQK2f0CKn7yFodd4T1dGE2V8R/jdU4hfczi/ca6Amjw9
 8Btwqjk/BvwHZjcJZ601tZtaRQoP87EKce6s+ZJWlxd3WWjvO/LES16VB5p2navOM9rL
 ugSgIW5L+gC59IbGDlyT110MQGYv6pUr5ZJpZAi3lflMBsUa4zp0zdSsR2FxhdSL7KQj BQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknp4w31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 06:29:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BH6GcKL079527;
        Fri, 17 Dec 2021 06:29:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3020.oracle.com with ESMTP id 3cxmrejmgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 06:29:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFZBGv6Uroi6kkgUiW2ukLLICGwdyH43oEXOOzUz0wpfO5JXcTuGr8JL0wJtEVaRSYVYJzXhTKt3otBsJ0UYPhj8ZivBJ9enS5H7Tl5ouvL9hYiGf9wM588QE6rBRtfLA8QoGZZGg5/28bDIhVhrOXqsEwaaOuiJ14Vt+wagdZFvpm7k3yYl1CmUZGC/sH+VhZ04ClQrFRDlFJeUsONjhvJGUwp5/L7pTQuBfknPv8cGGPUXgHJJ70qR9W9QVE4FlnisfE5EqAV5wQQalPcvhZJJMzZGoUB6KVij6738tWARty8fESent75fxiSciFMJAC4zEYsoLPK4C8SoT0VHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqYVg5LJdIaojloGrIMe1822llZVNHtWXsNWDMdi5bE=;
 b=Jmi1I9qMlAN11ISNtY9DyfQoO0FOagerBL/5tOOrPXd6ivBcDa3rRQaKES/o4aZnwCJ+W3jAJ3gTC/Xgs0XnAvYIApaQkMcC8YXcICJOBk0u8s1umhcxMWSPLe9P2EP+n+mN4ZXNP3F3LZktaPSvhEcz8ZReXY288D3vIz7sNmmaxOkHk5POTs7e272MjiETrFukv80IsjTRyAe6gjmgasT9wtp2nLFfX+GgaIyM//WFGerGja1FWZRkRiw6Us4COp0+tNp2DxKQfZA7oxx65LFYuHpGa6Z1cpbdNPzyAdMA1qkTdZ6qYh1nA4IhwdZRVDRajmL9DWasRu3Ely9ggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqYVg5LJdIaojloGrIMe1822llZVNHtWXsNWDMdi5bE=;
 b=kB0wZHkIokngF1dqv32dUTZ59qZ/bjGQOYGqp7LtMyDzvq/kD5lOGd96aar3SbHhADM+au9jfJ3uYiVnOM2c3KbORDd6q20IuIGkXqmnCf3YwjzpMXPO8VIVJ8ezlAKgn4hMV4VuqDirR3soC8CAuD9S/jbILvhdqwR7KCdlCHc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1246.namprd10.prod.outlook.com
 (2603:10b6:301:5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Fri, 17 Dec
 2021 06:29:04 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4801.016; Fri, 17 Dec 2021
 06:29:04 +0000
Date:   Fri, 17 Dec 2021 09:28:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v3] extcon: fix extcon_get_extcon_dev() error handling
Message-ID: <20211217062846.GA26548@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4855a130-b16b-d8d6-ec9b-ab1ac024e4a7@redhat.com>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0156.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::6) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6cd5413-62be-41d1-9574-08d9c1268549
X-MS-TrafficTypeDiagnostic: MWHPR10MB1246:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1246E4B951FA13800482D0C88E789@MWHPR10MB1246.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z9Onsq+u+i8GctgZZemG9sxmRmiRUCQYSZJdehDadp0UJs9KAMq2Gl3B2ira7vSEHRdT7s7JkkSS0GktZ9uG1NJnTl15HeJqnsGRKthaQ4S6KSayAC/HcWx9Ly5V7LA6OfPe84kPMY4O3YN5YkxupWNyishXNluWwWTEWRzeE57UeDUbXZ28RWUeeriBsZIzU2B5VgG3YS6A0GJlmgCCmIjwnhmafOP1SJKtDu7wmu2vWo4Mqn9Abpdv4PZEWLDsJHlEau8I2hPQr2haNqcAXJNXVUc1YhpaSOGYY02Bb1R0NkogdzwlJ9kCxWKKEnSend/KBo2U/UQ7IN5Of42eyJqkhZt1IWcxaQfa7qtKT41V1bsfIRJ4RnYYGZu2igM8xb/AM/ywTtDHaVvQOKaVZaMWi5sysCrZ2DDwgPlMFdJRTXWv9vtTKc0A55JRflNJ+3pLE4WeEaBHY2lA3gPTytG1nXAj8is6UsoLDyuwztmcilt2qdZ9snnoU7N/ic02RJf4UVGaY7rITPcEhHUc59AIZoR4IPYpo4SnkpUfVUs05HQQk75wsBkWBm3suHcomsTbQebCXeoSf8XJf6g9p1OVbmOGGx/4Jzwxb14A3R764QNyFkDD77JRfupsT++r74Q/2CdEvEBhBiTYNnIaNtJpbKftQWn3elDh4KbnubB+GQ+uZTPel05DRMcSuZ5XWO5kBE9Nl4Yp4q5iL23l3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(66946007)(33716001)(52116002)(186003)(1076003)(66476007)(6666004)(26005)(6506007)(7416002)(66556008)(316002)(4326008)(9686003)(8676002)(8936002)(110136005)(6486002)(54906003)(2906002)(86362001)(38350700002)(44832011)(6512007)(38100700002)(508600001)(83380400001)(5660300002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4sYUnRCMspPD9/fCotIhymIbH88LdDXWjGRVLJLn2LDRf80tu+1OKbIPY1K4?=
 =?us-ascii?Q?bdPBoEg4o6AKyDTb2hOn0r/l23BThFoplcLE2JE7WfHoSp8V0RRkFmelbI+9?=
 =?us-ascii?Q?n/SA47uOyCEkrHSVGLLO4yDLzPnxle2Y5At4qTXEWGZXFCcPbDva0bferYRZ?=
 =?us-ascii?Q?Fgu2um3UhRAq9LfEd5Wext7ROZ8SmfBsJbM9sUQRfq2L1dVOg4JEZFq+lX84?=
 =?us-ascii?Q?BrugDxIw1ZBrJy5YJJD8XPPEsEuAzwmH/W5UJ164KkiHOJT9KILRIE5fNQUX?=
 =?us-ascii?Q?lyu1OfpWgkFUilwH6k8Nj6YgfUj1ZXcWH/0R0m96lqOUbnbFUKHeleWHdmBo?=
 =?us-ascii?Q?ec1f+qCjLxqoVcFD1QdpQCmI7zo+TI8Z6Lygi3GAcKi6yu7uEWNB0NZ626dQ?=
 =?us-ascii?Q?hRtqsuKzl2w+F1qx/JDhhSSfJq9TgoxELg8rFU4kFCVV+yEISEW7zA0089Ku?=
 =?us-ascii?Q?3C5qRUsbaF1y1eqvoGLcLE/ln/Cz7Mj4lDbAI9KTkGN+ypA0WN5JhG64vvg+?=
 =?us-ascii?Q?UE3jujtObvu+cOA4aytf6xfW78VlKx8YgtbJ3myE19ENjfro/R9kDtWm/6J0?=
 =?us-ascii?Q?T3pq86faAYQ2Ddf/MOxlgg/iVaZK40xtDuz2EudKlh+dzLut4U46C3m0yp1M?=
 =?us-ascii?Q?0Tp/mznybLz/M8W8MxxZArLIYcxCzEttp7SWKspekudemiOvFPI8f0/NzBYR?=
 =?us-ascii?Q?ooeKlfyxrFQRDWvNBIn4CL42ThPxzsGrx6t6SDdBseQcn+DyWG0maiajAvkI?=
 =?us-ascii?Q?RU2fsDxRY+vym/Jfx5Vmbm+3RnyZqTRVCMsq5s/VZ7MmuU/BNrS0u7wN/iKp?=
 =?us-ascii?Q?EHIdrKVEz3TQ5tcRH3+7bJOSQbZwhrJ/BKCxDk7KGgOife20FjwIwfvZEfGr?=
 =?us-ascii?Q?KTj8LlMp9RZPUtumQ2f1GM+5Vqd20PXZL+N5LKZudutKQWbnTzTPNLxF9ogY?=
 =?us-ascii?Q?qd76aBa0M1hLuLKNQFwkUW6kucDdjKN51x8ZLA8xBJfvYu+vZNBOKPdHc2ML?=
 =?us-ascii?Q?CDPttUfHStaKniIw55Q/nNx2pZNK4FpAFKdQlfvpKf2n2OsCsZMN25wNEC1C?=
 =?us-ascii?Q?te7BTh1C2oW5foHXKu1TOjsrtZHT1d8/s+u+svIEe3foOSWDOPcfz0Jppn/1?=
 =?us-ascii?Q?3eg4ITVkq5Pe5WwyZO9y8IKhqnD9CgJxvj96XA1bADd8fPXH2CXIf+F73C5F?=
 =?us-ascii?Q?FmFcm9wR9XOxiggUK3uSrEOKM+En8swTqDefOp4wMm23x5iIue73r5rYEP/9?=
 =?us-ascii?Q?eIJzbuiaWTWc7n9VL/27abtLPcCdWOD1Geh+9MRULnQKSc0LcBdyIMi5Ifyd?=
 =?us-ascii?Q?uF25I2ce2dYx0kmKM49MB72UjTzy++rs+4h6bAhUxm7eHYV9ci9nKY3Q78yo?=
 =?us-ascii?Q?V7LIBpUjOwPxLMN7dgu6b2n5OCohf4X1/y2mLg43XNxlgna4LjxrCZ7zMdPW?=
 =?us-ascii?Q?FNhS93z3dbO6yyLzR1PpVYI1lFJYQ55iFUwiwPEBDO9Hz22vPV8bzYrjp/LY?=
 =?us-ascii?Q?0JwRtwCBVLmvy7d+22lYJTQt01knfODYVPsZ54ZXAtlJZM4hGR6npDuxq0XT?=
 =?us-ascii?Q?RUZPp20Sk+GIDFsKC+oZY5bRLKnIcwOuvtuqrcWLFM2OcesacvCQkIsbudUT?=
 =?us-ascii?Q?Hcx/8a/aCCAQpdtBSRGsJGo5Q26dDghS85NZNZ9/D3NfCIQ9g4Aht7fGSOVJ?=
 =?us-ascii?Q?OEz10w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6cd5413-62be-41d1-9574-08d9c1268549
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 06:29:04.0804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOPjDz9Oy/1s15H6/EMCxYIeaJ1w23xrCBrLEenz3GIIzAEoAdHZKDHfrZMkVbY2pekn2GCxjhGDGQqS4GHg+BY2iyrH3SqU2J0dY9qmRYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1246
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112170036
X-Proofpoint-ORIG-GUID: YvdNwZKVkBxmmJ1ZV59z_l_kxTnf2j2H
X-Proofpoint-GUID: YvdNwZKVkBxmmJ1ZV59z_l_kxTnf2j2H
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The extcon_get_extcon_dev() function returns error pointers on error,
NULL when it's a -EPROBE_DEFER defer situation, and ERR_PTR(-ENODEV)
when the CONFIG_EXTCON option is disabled.  This is very complicated for
the callers to handle and a number of them had bugs that would lead to
an Oops.

In real life, there are two things which prevented crashes.  First,
error pointers would only be returned if there was bug in the caller
where they passed a NULL "extcon_name" and none of them do that.
Second, only two out of the eight drivers will build when CONFIG_EXTCON
is disabled.

The normal way to write this would be to return -EPROBE_DEFER directly
when appropriate and return NULL when CONFIG_EXTCON is disabled.  Then
the error handling is simple and just looks like:

	dev->edev = extcon_get_extcon_dev(acpi_dev_name(adev));
	if (IS_ERR(dev->edev))
		return PTR_ERR(dev->edev);

For the two drivers which can build with CONFIG_EXTCON disabled, then
extcon_get_extcon_dev() will now return NULL which is not treated as an
error and the probe will continue successfully.  Those two drivers are
"typec_fusb302" and "max8997-battery".  In the original code, the
typec_fusb302 driver had an 800ms hang in tcpm_get_current_limit() but
now that function is a no-op.  For the max8997-battery driver everything
should continue working as is.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: return NULL when CONFIG_EXTCON is disabled
v3: Add a note to extcon_get_extcon_dev() to say that it may only be
    called from probe().

 drivers/extcon/extcon.c                |  4 +++-
 include/linux/extcon.h                 |  2 +-
 drivers/extcon/extcon-axp288.c         |  4 ++--
 drivers/power/supply/axp288_charger.c  | 17 ++++++++++-------
 drivers/power/supply/charger-manager.c |  7 ++-----
 drivers/power/supply/max8997_charger.c | 10 +++++-----
 drivers/usb/dwc3/drd.c                 |  9 ++-------
 drivers/usb/phy/phy-omap-otg.c         |  4 ++--
 drivers/usb/typec/tcpm/fusb302.c       |  4 ++--
 9 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index e7a9561a826d..9eb92997f3ae 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -863,6 +863,8 @@ EXPORT_SYMBOL_GPL(extcon_set_property_capability);
  * @extcon_name:	the extcon name provided with extcon_dev_register()
  *
  * Return the pointer of extcon device if success or ERR_PTR(err) if fail.
+ * NOTE: This function returns -EPROBE_DEFER so it may only be called from
+ * probe() functions.
  */
 struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
 {
@@ -876,7 +878,7 @@ struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
 		if (!strcmp(sd->name, extcon_name))
 			goto out;
 	}
-	sd = NULL;
+	sd = ERR_PTR(-EPROBE_DEFER);
 out:
 	mutex_unlock(&extcon_dev_list_lock);
 	return sd;
diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index 0c19010da77f..685401d94d39 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -296,7 +296,7 @@ static inline void devm_extcon_unregister_notifier_all(struct device *dev,
 
 static inline struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
 {
-	return ERR_PTR(-ENODEV);
+	return NULL;
 }
 
 static inline struct extcon_dev *extcon_find_edev_by_node(struct device_node *node)
diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index 7c6d5857ff25..180be768c215 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -394,8 +394,8 @@ static int axp288_extcon_probe(struct platform_device *pdev)
 		if (adev) {
 			info->id_extcon = extcon_get_extcon_dev(acpi_dev_name(adev));
 			put_device(&adev->dev);
-			if (!info->id_extcon)
-				return -EPROBE_DEFER;
+			if (IS_ERR(info->id_extcon))
+				return PTR_ERR(info->id_extcon);
 
 			dev_info(dev, "controlling USB role\n");
 		} else {
diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index ec41f6cd3f93..4acfeb52a44e 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -848,17 +848,20 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	info->regmap_irqc = axp20x->regmap_irqc;
 
 	info->cable.edev = extcon_get_extcon_dev(AXP288_EXTCON_DEV_NAME);
-	if (info->cable.edev == NULL) {
-		dev_dbg(dev, "%s is not ready, probe deferred\n",
-			AXP288_EXTCON_DEV_NAME);
-		return -EPROBE_DEFER;
+	if (IS_ERR(info->cable.edev)) {
+		dev_err_probe(dev, PTR_ERR(info->cable.edev),
+			      "extcon_get_extcon_dev(%s) failed\n",
+			      AXP288_EXTCON_DEV_NAME);
+		return PTR_ERR(info->cable.edev);
 	}
 
 	if (acpi_dev_present(USB_HOST_EXTCON_HID, NULL, -1)) {
 		info->otg.cable = extcon_get_extcon_dev(USB_HOST_EXTCON_NAME);
-		if (info->otg.cable == NULL) {
-			dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
-			return -EPROBE_DEFER;
+		if (IS_ERR(info->otg.cable)) {
+			dev_err_probe(dev, PTR_ERR(info->otg.cable),
+				      "extcon_get_extcon_dev(%s) failed\n",
+				      USB_HOST_EXTCON_NAME);
+			return PTR_ERR(info->otg.cable);
 		}
 		dev_info(dev, "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
 	}
diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index d67edb760c94..92db79400a6a 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -985,13 +985,10 @@ static int charger_extcon_init(struct charger_manager *cm,
 	cable->nb.notifier_call = charger_extcon_notifier;
 
 	cable->extcon_dev = extcon_get_extcon_dev(cable->extcon_name);
-	if (IS_ERR_OR_NULL(cable->extcon_dev)) {
+	if (IS_ERR(cable->extcon_dev)) {
 		pr_err("Cannot find extcon_dev for %s (cable: %s)\n",
 			cable->extcon_name, cable->name);
-		if (cable->extcon_dev == NULL)
-			return -EPROBE_DEFER;
-		else
-			return PTR_ERR(cable->extcon_dev);
+		return PTR_ERR(cable->extcon_dev);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(extcon_mapping); i++) {
diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
index 25207fe2aa68..634658adf313 100644
--- a/drivers/power/supply/max8997_charger.c
+++ b/drivers/power/supply/max8997_charger.c
@@ -248,13 +248,13 @@ static int max8997_battery_probe(struct platform_device *pdev)
 		dev_info(&pdev->dev, "couldn't get charger regulator\n");
 	}
 	charger->edev = extcon_get_extcon_dev("max8997-muic");
-	if (IS_ERR_OR_NULL(charger->edev)) {
-		if (!charger->edev)
-			return -EPROBE_DEFER;
-		dev_info(charger->dev, "couldn't get extcon device\n");
+	if (IS_ERR(charger->edev)) {
+		dev_err_probe(charger->dev, PTR_ERR(charger->edev),
+			      "couldn't get extcon device: max8997-muic\n");
+		return PTR_ERR(charger->edev);
 	}
 
-	if (!IS_ERR(charger->reg) && !IS_ERR_OR_NULL(charger->edev)) {
+	if (!IS_ERR(charger->reg)) {
 		INIT_WORK(&charger->extcon_work, max8997_battery_extcon_evt_worker);
 		ret = devm_add_action(&pdev->dev, max8997_battery_extcon_evt_stop_work, charger);
 		if (ret) {
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index d7f76835137f..a490f79131c1 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -454,13 +454,8 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 	 * This device property is for kernel internal use only and
 	 * is expected to be set by the glue code.
 	 */
-	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
-		edev = extcon_get_extcon_dev(name);
-		if (!edev)
-			return ERR_PTR(-EPROBE_DEFER);
-
-		return edev;
-	}
+	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0)
+		return extcon_get_extcon_dev(name);
 
 	/*
 	 * Try to get an extcon device from the USB PHY controller's "port"
diff --git a/drivers/usb/phy/phy-omap-otg.c b/drivers/usb/phy/phy-omap-otg.c
index ee0863c6553e..6e6ef8c0bc7e 100644
--- a/drivers/usb/phy/phy-omap-otg.c
+++ b/drivers/usb/phy/phy-omap-otg.c
@@ -95,8 +95,8 @@ static int omap_otg_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	extcon = extcon_get_extcon_dev(config->extcon);
-	if (!extcon)
-		return -EPROBE_DEFER;
+	if (IS_ERR(extcon))
+		return PTR_ERR(extcon);
 
 	otg_dev = devm_kzalloc(&pdev->dev, sizeof(*otg_dev), GFP_KERNEL);
 	if (!otg_dev)
diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index 72f9001b0792..96c55eaf3f80 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -1708,8 +1708,8 @@ static int fusb302_probe(struct i2c_client *client,
 	 */
 	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
 		chip->extcon = extcon_get_extcon_dev(name);
-		if (!chip->extcon)
-			return -EPROBE_DEFER;
+		if (IS_ERR(chip->extcon))
+			return PTR_ERR(chip->extcon);
 	}
 
 	chip->vbus = devm_regulator_get(chip->dev, "vbus");
-- 
2.20.1

