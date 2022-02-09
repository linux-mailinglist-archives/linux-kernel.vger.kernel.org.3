Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6C34AEAD0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbiBIHMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiBIHMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:12:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1088C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:12:45 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2196asYN020241;
        Wed, 9 Feb 2022 07:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=zKQPJ0vtKCEb6Xrm92IWhv2ffWr5yvl97mSxKTXVh6A=;
 b=nhizSiP1tLE9CfNBw6K4di77w+qNw/pkl/K/CmueUCY2mXx6CcVJoNoRQjF2vy/KSutO
 B2JNluEkUGgr6EMVQ1jg5+vMz1gqSiBaLV7CZ0S6ug2maF9seKkByUZCoDMo1ob/ZzRV
 UfUe0grYOJNNHOvw8izcBbUBJt7JL3qH+/nbgeOpHllDRZOIyZk0mpBJX4Uj/I9DC1gc
 D0FD7QOwvPDK6fln/ii3r6UQVGVKpFBjUiIDAmxEHfGVwNdSfAURMJAkOiWsAbtWB6PP
 TkkfFwlKTx0O+mm1IDPUn+CgtnJ0vc9K2XD4gyKptF7Qh9ofgwlZ39Vzs8Wwzv17rUAD 6w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366ww675-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 07:12:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21975nbL051032;
        Wed, 9 Feb 2022 07:12:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by userp3030.oracle.com with ESMTP id 3e1ec1vhbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 07:12:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gz3v2Mxamze8v+XF92TQCcu3CeEpndmCTvmtxW4l76FySaGbdEkibZG3oV5D57XxmyqeE3543xkDWIJdQFjohtVwwgfuRpkexI0M5Ox4e4y3zeKPmSfXZTFVtXgBl2OLVp6kOUA1wbtH/XECYxiBcJlK6HNCKOMPSdoq+VlJmYLhsQKkxneUnanTxlTK2zD6lvtahe5W9ChNLAw6LzI7u6l/sRUJF9JboUcYxR1bd1rBEL6+YGuaZHqFfk/rs6xs4C5WuO8wzLYZRG/EmPLPlPMlPSdceLqWpty7RGHPsCzgm7VvNiqbdh7+j2JSVGq8WYtj0jh9Sq912q3BC9eXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKQPJ0vtKCEb6Xrm92IWhv2ffWr5yvl97mSxKTXVh6A=;
 b=bWQTbteOXWJfHl3B6LRoHZaecuTvKwR0Cf0o96cNhAOrTj39QXN9/i7if8uBNOv9xuRqh+79KeNpHMN9A0H/hiq8pg31HVjxgCgN78KpOqUZ01B68SC2idL3IkGhv7Qys8ckcPCWB0tI6D1who7N/mrHD982kbOlO2pqA+uilULWU1xd0mP8gkQdoPkDrCO8hUlmLyGPujvybzHXkqX0p7CCMOgpMxBI1qDQPrGmGnlcA+esxGza29joZ7f4RO7c7EfFzdyxpoyOsoN1VFgzGNfYcZdoGB5/0EiQh784/Q+TX9o4eICsEV+pMVPej6+79vFP+9aYa05Mi+II/CNp+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKQPJ0vtKCEb6Xrm92IWhv2ffWr5yvl97mSxKTXVh6A=;
 b=AzSmpNRTTk2XARWa5Q8nj0cAU1XAcop8QTKt7G8MLdukzPprIeHWZuv0oDvR46y4TStASJxTM+KXpfZy3IdJGW2+0rLos5EEUFwLBVpfFJcMo2KY6XXa4QpQHEpWPZ9qY3haPxqaoxxMBVxH9nKmaKK8IvtAUsH9kJDUtoLx3rc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1920.namprd10.prod.outlook.com
 (2603:10b6:300:10d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 07:12:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Wed, 9 Feb 2022
 07:12:32 +0000
Date:   Wed, 9 Feb 2022 10:12:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Mihail Chindris <mihail.chindris@analog.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/iio/dac/ad3552r.c:688 ad3552r_reset() warn: impossible
 condition '(val < 0) => (0-u16max < 0)'
Message-ID: <202202090003.x20dx6O1-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::35)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0ca5cb6-3cb0-4020-d370-08d9eb9b8a02
X-MS-TrafficTypeDiagnostic: MWHPR10MB1920:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1920C74C4A392B2CC277771B8E2E9@MWHPR10MB1920.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:63;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 284EXdGXR1ynOwiqXt8vsKUG5B8glUo1tmsuY/jHR9+/Iib9nLEo6CjzImdkQCF0d+h/mUjmi1I3eApkY7/KMMFs8un5pCDjgHbvJ0ah5zmIH9P2hQbup4Z6Q7MGqD2jAGjmk+B5nRMRte66wc9zffSf33oRts8ok3OAdVofrhB/cjy1+vIhqrAM1YU3oXZWyMK8IzjprMR0qHoaUgJtqyhVsFmEE56dLfq244LU6MjE/+9CqA2TqJKXeBIYHbmVwqfAaNPm7kt7gtC3uYdDXgn1SjeWi0fvR94ncGYzXAVfu3gavjSPXJ0AzbXU/kO7IKDxuIO/7NtvyX10XUYBkx1fO2tEMZ42NY72mAgIHmXtM0mXXnGupHrAqF4LZYutl7mgojBWLs8C1Wl8vkqaGdShxKigkn/0GDO9YUrtI+1wFOxbKVsHTIWQIMySaK8LGVTx6tUl2wfIfGNHX/UhNg2j9WnwIwG1znq3iOOYinPEPr6iuPVJPdXg2aTGm7lVhjqlioC3d04MQEivdxHAeYCIlkmJli05ot8TIwkrSYGNtd1t4i8lwyBw7hp2zY2ChDRKh/2F5NVO5U/yLj1OO1aU1j1/dWcaDm49ujJKw/MTzRmS9yFVkxdMh/T2nO7HM6mEaTpcV+/if8/uGq9ShfrS/cGOZ/yE4sA8FoKi86naI/5oNTsJBWi/o48+amVpg15PmHpZG2QoMrzeyFTgdV5gVaVXBGPcZaEWKgKzl+2EukSWYyf42mNvi8dJBJOrJyt67P5EZo4+c+MYiySHFDd0uENd1v9/5/Qtpr/O57YlaRKRgOhQb0D4KBFncXbQ4XUYyV7yDVw/rKakr+TCeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:ro;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(5660300002)(26005)(1076003)(4001150100001)(2906002)(6666004)(508600001)(36756003)(38350700002)(38100700002)(6486002)(4326008)(52116002)(44832011)(316002)(6512007)(66946007)(86362001)(9686003)(8676002)(966005)(8936002)(66476007)(66556008)(6916009)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y8jMIaYU7r4RFn53yvDmUEcNsqfFOhXLYmGgQseHflvLRy4Zk5T21jQuER+D?=
 =?us-ascii?Q?vEVpWdP1C2vxo7++OzoDBk2fKK0xnYAjjBm5P0jxD2kc5vhByPKtvjDN+It1?=
 =?us-ascii?Q?p4ZiHS8BBdhPjiJT8XNiQpBRs+jotvIAf0vp7XyApEgIfV3S09zSpim6WxQq?=
 =?us-ascii?Q?cO7/WFEFCIkeX5Rp9t7zEgtEQU6aLhER8046j50UcGPQeVQ8cRPmYMw4y4jk?=
 =?us-ascii?Q?wOLCCt4nfzqotg1PPWW0FCJqswS6wn+yx0BZGOYPGCWijRXorqK/yK40iQvf?=
 =?us-ascii?Q?XEHUlGbQupfv5p6n3nDvtaH5+no/irMaDb91ljQtiXmRfSInwssmX/ctVNfJ?=
 =?us-ascii?Q?c0scvfG4RHuT2aM/Z2tWM28zozieJmd5UoHo9HyW79Z4BmDo+m+vuzo0Wh8s?=
 =?us-ascii?Q?7Od57x2nXcRlMJdLjTpeZ789ESKrPvpg6wsS5qQdMz5w79888bNEMMwzE7Gr?=
 =?us-ascii?Q?way8hxu6Bit8tU9+zuTLx+W2Zrj7G43Ii6Mw1QCU6TvU9AxAHULDsocC650N?=
 =?us-ascii?Q?eB146Uf7Cpv/g9EItVMGJUPyXVL+vJRup2a3FT39QipHjchVGN/+nfgiEyZ4?=
 =?us-ascii?Q?FJ2Ed+BVmfmY8meLO9Qc25emODmfrDLcLOAWzrcxAdx1mS7Xy8ZpYXfqWkj2?=
 =?us-ascii?Q?LpnAtgUSBzijoBctCMlnDwmDeLzO56NzLOBA0f61ul+G0j77/TS4FBMqLZLl?=
 =?us-ascii?Q?ch8YDRSDqIkp78SF+5KwV89Ugq3Jl6f83RRbJOZQ9UYP0rXcBz/+F3LGBee3?=
 =?us-ascii?Q?sbuvDIkoTgRULpCQiG+rwCwEMFXa5H2FqcB9P5I5f2XFzSjke/O8c9ehpV2l?=
 =?us-ascii?Q?jeYhbbZWmceqNM5GOYSEHyWUfNxCMOx4dVIWzzruC4ELNCSJuGyp4Zyi5iW+?=
 =?us-ascii?Q?mTEkdwuAA2M6SpIAm8mmGlacS1YeNLkOgtq6vLj2fX01sYJ9DiydEnKSWg15?=
 =?us-ascii?Q?dgsWWo5cFxASZw4lYSRAvC5VTpsWhwuXpK1Jyly6jjlurU9F4Q870tmgeSuE?=
 =?us-ascii?Q?o83ot6c8CJ585sgmwu8wuxzh9oEKupvoN6N+qBjc0iMQQAoXFjzGBnIepPuj?=
 =?us-ascii?Q?G4NdhNdyhegiP3T3C1ZM1fMV73iUAQWnqvfSRbSHztefHyiOJ6Sda5Ii644k?=
 =?us-ascii?Q?N8nqlHBdNmr7oRZkirTUEsW2wdbzDv/V+Lcdn/CF9JA8FRXYtEkT/TSMTfP/?=
 =?us-ascii?Q?fnn6Ms/4slDsMY8JI0egdo/9dSso281hCbBJjUqsuMlgZIjmVmLn80QXFFOY?=
 =?us-ascii?Q?ePpyzBt6CNhyyGGeTjs4jrKJdgdb7X8hhaDWhrQi2j1CqrgclmTi4ZO3Ia8T?=
 =?us-ascii?Q?HCJ9CIE7s1y6GD7rAHZ600tywkAU+oZtoMhRSTnLWJnKJbokfRtmZjj+KXh6?=
 =?us-ascii?Q?2EbdW1BLplQl8XvOao/v1x0MyJ7hyZVQNCuGokhQy3b7L0BfHgcq0j0WDHNB?=
 =?us-ascii?Q?f6RfLWRdjyosuPl5LI4UgX78hRZmjmOFXL/iG1v9zvRYMP/LWMYk7Ur2mHMe?=
 =?us-ascii?Q?mM+hhMUUZnHYa1D0oXYzSmgVRVtkjCXjY/niJGt9cMxXe/pFog8fro7TZFUE?=
 =?us-ascii?Q?6TpXugpss1Ba0nc/lO/TenEkgckijUM+0idGMCbqn7oWfQMt93796010rvx0?=
 =?us-ascii?Q?sJ9TF/S4tQGgyJ9hjm/VXhmhr8VNk214ELGNYoLA+Elepz5+CMg+47QM+4gZ?=
 =?us-ascii?Q?+Nofqw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ca5cb6-3cb0-4020-d370-08d9eb9b8a02
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 07:12:32.0659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JpRKsqBPs+Gew5wVxLgEGXcZghInviEg5v/frepy1Hl/IVZw0xJKX3p7YeGUt1DYL1oImPKLqnpcuK8V/3W/GwQrzoSN2DzeY80sN8XUzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1920
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10252 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090049
X-Proofpoint-GUID: q4i8JcWBVBaVBdaSPSRKH0djR_q81RGo
X-Proofpoint-ORIG-GUID: q4i8JcWBVBaVBdaSPSRKH0djR_q81RGo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   555f3d7be91a873114c9656069f1a9fa476ec41a
commit: 8f2b54824b28ba8317c60947b5941d686e3df70d drivers:iio:dac: Add AD3552R driver support
config: x86_64-randconfig-m001-20220207 (https://download.01.org/0day-ci/archive/20220209/202202090003.x20dx6O1-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/iio/dac/ad3552r.c:688 ad3552r_reset() warn: impossible condition '(val < 0) => (0-u16max < 0)'

Old smatch warnings:
drivers/iio/dac/ad3552r.c:699 ad3552r_reset() warn: impossible condition '(val < 0) => (0-u16max < 0)'

vim +688 drivers/iio/dac/ad3552r.c

8f2b54824b28ba Mihail Chindris 2021-12-13  655  static int ad3552r_reset(struct ad3552r_desc *dac)
8f2b54824b28ba Mihail Chindris 2021-12-13  656  {
8f2b54824b28ba Mihail Chindris 2021-12-13  657  	struct reg_addr_pool addr;
8f2b54824b28ba Mihail Chindris 2021-12-13  658  	int ret;
8f2b54824b28ba Mihail Chindris 2021-12-13  659  	u16 val;
                                                        ^^^^^^^

8f2b54824b28ba Mihail Chindris 2021-12-13  660  
8f2b54824b28ba Mihail Chindris 2021-12-13  661  	dac->gpio_reset = devm_gpiod_get_optional(&dac->spi->dev, "reset",
8f2b54824b28ba Mihail Chindris 2021-12-13  662  						  GPIOD_OUT_LOW);
8f2b54824b28ba Mihail Chindris 2021-12-13  663  	if (IS_ERR(dac->gpio_reset))
8f2b54824b28ba Mihail Chindris 2021-12-13  664  		return dev_err_probe(&dac->spi->dev, PTR_ERR(dac->gpio_reset),
8f2b54824b28ba Mihail Chindris 2021-12-13  665  				     "Error while getting gpio reset");
8f2b54824b28ba Mihail Chindris 2021-12-13  666  
8f2b54824b28ba Mihail Chindris 2021-12-13  667  	if (dac->gpio_reset) {
8f2b54824b28ba Mihail Chindris 2021-12-13  668  		/* Perform hardware reset */
8f2b54824b28ba Mihail Chindris 2021-12-13  669  		usleep_range(10, 20);
8f2b54824b28ba Mihail Chindris 2021-12-13  670  		gpiod_set_value_cansleep(dac->gpio_reset, 1);
8f2b54824b28ba Mihail Chindris 2021-12-13  671  	} else {
8f2b54824b28ba Mihail Chindris 2021-12-13  672  		/* Perform software reset if no GPIO provided */
8f2b54824b28ba Mihail Chindris 2021-12-13  673  		ret = ad3552r_update_reg_field(dac,
8f2b54824b28ba Mihail Chindris 2021-12-13  674  					       AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
8f2b54824b28ba Mihail Chindris 2021-12-13  675  					       AD3552R_MASK_SOFTWARE_RESET,
8f2b54824b28ba Mihail Chindris 2021-12-13  676  					       AD3552R_MASK_SOFTWARE_RESET);
8f2b54824b28ba Mihail Chindris 2021-12-13  677  		if (ret < 0)
8f2b54824b28ba Mihail Chindris 2021-12-13  678  			return ret;
8f2b54824b28ba Mihail Chindris 2021-12-13  679  
8f2b54824b28ba Mihail Chindris 2021-12-13  680  	}
8f2b54824b28ba Mihail Chindris 2021-12-13  681  
8f2b54824b28ba Mihail Chindris 2021-12-13  682  	addr.dac = dac;
8f2b54824b28ba Mihail Chindris 2021-12-13  683  	addr.addr = AD3552R_REG_ADDR_INTERFACE_CONFIG_B;
8f2b54824b28ba Mihail Chindris 2021-12-13  684  	ret = readx_poll_timeout(ad3552r_read_reg_wrapper, &addr, val,
8f2b54824b28ba Mihail Chindris 2021-12-13  685  				 val == AD3552R_DEFAULT_CONFIG_B_VALUE ||
8f2b54824b28ba Mihail Chindris 2021-12-13  686  				 val < 0,
                                                                                 ^^^^^^^
8f2b54824b28ba Mihail Chindris 2021-12-13  687  				 5000, 50000);
8f2b54824b28ba Mihail Chindris 2021-12-13 @688  	if (val < 0)
                                                            ^^^^^^^
8f2b54824b28ba Mihail Chindris 2021-12-13  689  		ret = val;
8f2b54824b28ba Mihail Chindris 2021-12-13  690  	if (ret) {
8f2b54824b28ba Mihail Chindris 2021-12-13  691  		dev_err(&dac->spi->dev, "Error while resetting");
8f2b54824b28ba Mihail Chindris 2021-12-13  692  		return ret;
8f2b54824b28ba Mihail Chindris 2021-12-13  693  	}
8f2b54824b28ba Mihail Chindris 2021-12-13  694  
8f2b54824b28ba Mihail Chindris 2021-12-13  695  	ret = readx_poll_timeout(ad3552r_read_reg_wrapper, &addr, val,
8f2b54824b28ba Mihail Chindris 2021-12-13  696  				 !(val & AD3552R_MASK_INTERFACE_NOT_READY) ||
8f2b54824b28ba Mihail Chindris 2021-12-13  697  				 val < 0,
8f2b54824b28ba Mihail Chindris 2021-12-13  698  				 5000, 50000);
8f2b54824b28ba Mihail Chindris 2021-12-13  699  	if (val < 0)
8f2b54824b28ba Mihail Chindris 2021-12-13  700  		ret = val;
8f2b54824b28ba Mihail Chindris 2021-12-13  701  	if (ret) {
8f2b54824b28ba Mihail Chindris 2021-12-13  702  		dev_err(&dac->spi->dev, "Error while resetting");
8f2b54824b28ba Mihail Chindris 2021-12-13  703  		return ret;
8f2b54824b28ba Mihail Chindris 2021-12-13  704  	}
8f2b54824b28ba Mihail Chindris 2021-12-13  705  
8f2b54824b28ba Mihail Chindris 2021-12-13  706  	return ad3552r_update_reg_field(dac,
8f2b54824b28ba Mihail Chindris 2021-12-13  707  					addr_mask_map[AD3552R_ADDR_ASCENSION][0],
8f2b54824b28ba Mihail Chindris 2021-12-13  708  					addr_mask_map[AD3552R_ADDR_ASCENSION][1],
8f2b54824b28ba Mihail Chindris 2021-12-13  709  					val);
8f2b54824b28ba Mihail Chindris 2021-12-13  710  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

