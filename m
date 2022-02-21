Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B59A4BE089
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358494AbiBUNBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:01:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348732AbiBUNBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:01:10 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933CE1EADA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:00:47 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21LCx42i003646;
        Mon, 21 Feb 2022 13:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=92qe7qKAeo4HcfgbwBEf3aZ2flRUH4smLdABhEUH3cU=;
 b=azs9l+tDkoyIIK3Zuczsu7rSVf2prDuJ9yJ6vPEb/jZ+rWoPW8ebsSw06YFpg8YzQHrB
 uXdhunQUKbGC78K9wgwOlx0gZKp4+Dre+ji+ckK4q9v35kZv8Wy7URdDVI9Be/E/wDS4
 U56EGqliPLm8n0EA8fie6J1IDlMMP6+HZnwmyTXnNTUFCC+jEDD6jWePtGf8K1uLpB7A
 R3g5tUrho8LoIe+t7qQk7RQP9UPOcmnDIshS8bWMRvcCS80lZgw8aXh8lKKsTGkOgz1a
 n19RwBTJJDCFFlhC01wC9qe8sYsr/QXIZVaCk4uhuHeMFzqCVpDzw77cl73NHivtLhNp gQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3earebkx7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 13:00:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21LD0XbY071266;
        Mon, 21 Feb 2022 13:00:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3020.oracle.com with ESMTP id 3eat0kgppr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 13:00:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P971gZzUkjKSmEewwqK1Ij9/qnROOENv7eJYjmJqUzSCeBa4okBdNeTPlbPD27V0ZAHTMotVGTIoHlqLY6gShwK/TNiADWBN3AGl6dVpgJnxGTk+Yw2On2s+ZHdxCzRZYbPBp8yEP9DCNd8eS/NtpADjLMXO5pdKR0/yiOVHUynccljoGVo+/1yaY7H8KqCmXhZhHN+ZoeWltfa6z79nrUSoxuhj2YkiKPp80Dy+71R09sLh4WHMggLuGkGmk1qKQySc116n+ypizHvwi4HnBXHgZ+geFxRQckNjwUMcCiHM4BAjwu5hVDlr+vPZFCnbbw3hOszHXEASQNA+1Lg5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92qe7qKAeo4HcfgbwBEf3aZ2flRUH4smLdABhEUH3cU=;
 b=gPPCZ4gD5CaY4gP1s/61skOia1QRs4YaHT7a0qROMufPGhRRv585rhXRcxTq/CqUJ0dNh4HHApcUq24Wnv8M1pKAbmnLr05wZlJPFXJieT5tcJD8Fk5jZz/CFEwWNf2OE7XmjhQn/nQDlTIpu56zzL92n/V9l7ScT/d8dWGfcoepIcJjZR3zspv9efn+7wHf21L3CBqQ34370vWRx3Uktx0DRUNf8YpIPAeGVZbNPX/oLTTZZw96k5zmdD+E1Kd9sB4nBsf47vX1zKawATS+s29PtkTMtMMdILcyyJL1oyDmm0DtjSSth5S2Uf8A8GBX/rxbuNiFXrx/8jU3HYV17g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92qe7qKAeo4HcfgbwBEf3aZ2flRUH4smLdABhEUH3cU=;
 b=jyEJ0zPAbCHAZyQlUhppKHq2N9Hz2h7kYvocy7SxBK5McMyb+fQNyoYlfXlh7Z/XQ/oWpry1mKV68Be+lATQtfh10oJLGSX26YlsQck+1w3s9Jj7WC1eg/UuP3PVw2eETSMNAdzLfawyELk1R+2fjvMfiioQetjxdcVnGn5NX7w=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3095.namprd10.prod.outlook.com
 (2603:10b6:a03:157::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Mon, 21 Feb
 2022 13:00:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 13:00:26 +0000
Date:   Mon, 21 Feb 2022 16:00:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Colin Ian King <colin.i.king@googlemail.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        =?iso-8859-1?Q?Cl=E1udio?= Maia <clrrm@isep.ipp.pt>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: cleanup proc fs entries upon exit
Message-ID: <20220221130006.GJ3965@kadam>
References: <20220220231554.2510567-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220231554.2510567-1-ztong0001@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::24)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecd0730e-b244-4d35-f634-08d9f53a213e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3095:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3095ECE3B439353B074FF8A58E3A9@BYAPR10MB3095.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JtrA6PK6zikZyaqdSiYemv2nztfuKtIiVQS7TBvzru2wmMISwgFzCpwE3hf3pryg5lBEBxTIxP9TiWZ93TwZQNpE9/2OIkugkCvlOKI3Ae3iJs+cKUU1hzU/NzkWoivwcJVDvB2URKAuqjJBpf4Jh+pWzB/7mNgoVNzeW1Z7kmx1nuan1b8ZC+uhJ3UVjv+egc99W9BaE96LrwhF9uCC7I7Wx4c7C2xlPU8BeuWIL9CJfVncnbE2Fnc1ZLQ41cHKoDt1UB5LIZHdzeWu2ZE5qz7dq3n/lA2ewPFJ4Uty9xTNl5la1UOUSgBsvd3Duu4u3qt5J5Jo/t3qvjmOFUEi/c2YnoZo9VOpBlTgp/BR3UwSDFDgJH0OhXSVOmZxGVhZv3Uc7/EbW/kt7GBsE7skZepjeXGYEv2rWUJ24hTtm6jTqGsXBOASYXQZ8dQeKwmxXOvsPnOTqDQjuALMI6r+Yg6zq5eu8zlRYA9UWudokAGNk7OSlxW0JdU2vkqPPJj9fwa27WrPb7sQMD+0ZVKU/DveoHA4BWROtmFlo2yLq/nI6+kuTL3ciaEhvB7xym6b7qE1qjYUOlSVZLJtpLoVzPuChVg3ZJZ9WN/1D6m5/eLsx0uQtq3m/LrsyKQRBT6sh/Y2Bn5S/JC1fQ9nDFgv0HVAJ4tJ+pPMKlNyiP0OFMlW+26aycieI8Axu70Y/baOZzkj4T643wBzQ8pNjU+QSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(38350700002)(38100700002)(66476007)(66556008)(66946007)(6486002)(8676002)(4326008)(5660300002)(6916009)(316002)(54906003)(83380400001)(33716001)(7416002)(8936002)(44832011)(2906002)(33656002)(1076003)(186003)(26005)(508600001)(9686003)(6666004)(6512007)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y+zo1mcGdDw0DHW1tJBQqv60/vsKmNoUUjWjXcYYD/dEJptpGWd6XI4VkMfV?=
 =?us-ascii?Q?naF91zA5mlFKC5YD+rm8lOv+0cU4SSqJ4su+FvJdY8sr107FeiYx0ZAP+7bL?=
 =?us-ascii?Q?vfMBxjMBdjDIJoRHVPbUXND0xdxmp630NHXtNRPmpBRGbp5jL46zd6xWmE9F?=
 =?us-ascii?Q?d1UmQnMlEHre4vshk/JdhBXAegLjkdIBrsH/cWvOzR/hwlj8KYghIK2YL0on?=
 =?us-ascii?Q?4i+YcINk3ZScJEa/xNSWQCoK58p9WZ7wyoE5WSAX/0AntXFR7/mbDCD2sroH?=
 =?us-ascii?Q?MjU9GQM1iFJd0J1KUnCY5cP2IwlLz4UDgpjnncb+WxWX90ZSz25C6Zu5LiQs?=
 =?us-ascii?Q?si0e99Qd2+tXZ73thwwmsOr7bMlaNlahfyXRJWtD242YDqCS34Fz5U1VSQEh?=
 =?us-ascii?Q?XSmDju9Vr7O2oTwS7dn06tsMxrCi9fXJSl9sZeg6I0odMb7aO7gbXxSV92PS?=
 =?us-ascii?Q?NDBpnXqzCpDMR88WG6vQR2hmLfGJRdbJYhXwTau6gB4qLs+h7Dws1TMEJim4?=
 =?us-ascii?Q?jXoSu1YQncioB1Baq7yEOPEY+9Bje5/lxr6aNUcB0BDnJdU95DecavdedzxL?=
 =?us-ascii?Q?b72MR4crY9R/olkVd/iVzRkw+9CDviVXzc4hS7EYiQYOdCyK9dxpZ6LS4W6d?=
 =?us-ascii?Q?9FeEnzSZ8+gWmcL2RHcuMg80cFEUyIGdsym4mbkxRrKDOqWH+sANpkjoBWW9?=
 =?us-ascii?Q?KIvOsqV40PpZ9f7arCLrCRcHRe8c3wU5PG32TDnNPDgiahnIdNTvko11usz+?=
 =?us-ascii?Q?cLDPYC98ZlmcpO6J6cn756iRIXUdT9RXDChlY9ghSJ8HGXVEa8oXpR3jPqJl?=
 =?us-ascii?Q?9MWjtJrx7CS8t/UlQo5erZmu7+V0TIuRL5pHFhucXcTvp+JpcSsr99sUmtOY?=
 =?us-ascii?Q?y4o4XgFjbahP80Uw0PE8Z3GRQIWxDAzlL2oC8iQ8M5OCCdVIhcFjAkzjKriU?=
 =?us-ascii?Q?RYTpjV6MQUVivkN///U7ThDXv8VBzB85LEZtMXKE/p8/igv5CBytErhGkIsY?=
 =?us-ascii?Q?3ahBwQOxDaTxXg984kcE+HoEIdcoXkEjB6j7a0sHD6JDUgp7STFbvqYEWj1u?=
 =?us-ascii?Q?pt/Z4iH+88u/dr35mMvV8LsAxA+HjThmOTByU6UfOAvyLLbkXq6rWv7sPamI?=
 =?us-ascii?Q?5iTN747jbapN4wByVw/0vHMxqYeCVEMIbK5xLl07zji6UbDltlmSwwGeEFrU?=
 =?us-ascii?Q?0VNkypJPVomRRP72Uo9UzDVZLF+CnAFEwUABYPIOZ62yoHUV0x4ZS4E2rYNU?=
 =?us-ascii?Q?09SKdkzlP+chhlfKK/0DN14X7pZrvFeOuGrKJThhmlW1LANioZohkNuoAuWL?=
 =?us-ascii?Q?ziZAxnTiyAmv0r7gqH/y02/jLVPYNNUCWgG2nDsJGQimjDCtsAD34GdRb42s?=
 =?us-ascii?Q?OuHe4fzt2clLP6o7helpweGV6LaTe/QZGMba/CJmQlw/BtYcnUl93i4fZO7T?=
 =?us-ascii?Q?3E2c6uUp8roEROmUV5Wqvt4ZySNRwPCnVgoLKxe4xVa9msGb8u0pArODMwKh?=
 =?us-ascii?Q?NYZ2mKEKWLEr/tVLX2NQXqg1MOeBNDB1DnrL7/piU/1iBPZ/BXtzZNHEH3ej?=
 =?us-ascii?Q?zWkZ+usQfCHz7gfUbhCTOGJdC8qg51AmaLbR9nKVvcIrQ7iPrvKZYJUt6UW4?=
 =?us-ascii?Q?jL0zCgkp37cnumvmFHo8lNORIBpfkUfKEr/Yjdfy/qEqUZUd4B9cupEcdUPL?=
 =?us-ascii?Q?dXFmUQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd0730e-b244-4d35-f634-08d9f53a213e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 13:00:26.7287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxQloQvIahKXLXKiRjL2Lny0VaaGEdOnW7XeA0cKgNZpCbLe7KG7g/U8ROpaOjhHYZBgTfRIvWVVvjjLgNg512LtRobQst1vshFzLw8F5ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3095
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10264 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=957 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202210078
X-Proofpoint-ORIG-GUID: ubxQXIggvLE23npSL3jTglbAb3yV110v
X-Proofpoint-GUID: ubxQXIggvLE23npSL3jTglbAb3yV110v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 03:15:53PM -0800, Tong Zhang wrote:
> proc fs entries need to be removed when module is removed, otherwise
> when we try to insert the module again, kernel will complain
> 
> [  493.068012] proc_dir_entry 'net/ieee80211' already registered
> [  493.271973]  proc_mkdir+0x18/0x20
> [  493.272136]  ieee80211_debug_init+0x28/0xde8 [r8192u_usb]
> [  493.272404]  rtl8192_usb_module_init+0x10/0x161 [r8192u_usb]
> 
> [   13.910616] proc_dir_entry 'net/rtl819xU' already registered
> [   13.918931]  proc_mkdir+0x18/0x20
> [   13.919098]  rtl8192_usb_module_init+0x142/0x16d [r8192u_usb]
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---

This is a partial fix but there is a lot wrong with both the init() and
exit() function.  It's not hard to just fix everything and it saves
time.

Here is how to write Free the Last thing style error handling for init()
and when you finish writing the error handling code then the exit()
function is just a matter of cut and paste.

The rules are: 1) Free the last successful allocation.  2) Every
function must have a matching release function. 3) Every function must
clean up after itself.  No partial allocations.  4) Name your labels
with descriptive names to say what the goto does.

	ret = ieee80211_debug_init();
	if (ret) {

Here nothing has been allocated.  Nothing to clean up.  Just return an
error code.

		pr_err("ieee80211_debug_init() failed %d\n", ret);
		return ret;
	}

	ret = ieee80211_crypto_init();
	if (ret) {

The last successful allocation was ieee80211_debug_init().  So we need
to goto debug_exit;
		pr_err("ieee80211_crypto_init() failed %d\n", ret);
		goto debug_exit;
	}

	ret = ieee80211_crypto_tkip_init();
	if (ret) {
The last successful allocation was ieee80211_crypto_init() so we need to
goto crypto_exit;
		pr_err("ieee80211_crypto_tkip_init() failed %d\n", ret);
		goto crypto_exit;
	}

Etc.  At the end of the function it prints the pr_info() even though
usb_register(&rtl8192_usb_driver); can fail.  It needs to do:

	ret = usb_register(&rtl8192_usb_driver);
	if (ret)
		goto crypto_wep_exit;

	pr_info("\nLinux kernel driver for RTL8192 based WLAN cards\n");
	pr_info("Copyright (c) 2007-2008, Realsil Wlan\n");

	return 0;

crypto_wep_exit:
	ieee80211_crypto_wep_exit();
other_stuff:
	free_other_stuff();
crypto_exit:
	ieee80211_crypto_deinit();
debug_exit:
	ieee80211_debug_exit();

	return ret;
}

Now you copy and paste the cleanup block, delete the labels, and add a
usb_deregister() to create the rtl8192_usb_module_exit() function.

static void __exit rtl8192_usb_module_exit(void)
{
	usb_deregister(&rtl8192_usb_driver);
	ieee80211_crypto_wep_exit();
	free_other_stuff();
	ieee80211_crypto_deinit();
	ieee80211_debug_exit();
}

Remember to replace "free other stuff" with a the correct code.  ;)

regards,
dan carpenter

