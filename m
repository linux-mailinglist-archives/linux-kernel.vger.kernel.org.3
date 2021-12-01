Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA8F464B2C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348455AbhLAKJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:09:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50742 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229950AbhLAKJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:09:14 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B19p1iD007274;
        Wed, 1 Dec 2021 10:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=h9yb3kuXvoDHAkcOjgxrL72VzWR6uIYI3PBv84YjsTU=;
 b=zf+m6EwG4xGXT3iEQrri5Tkt+yr2geT6tCt4xo+m/UDADNgiW3C076J0pOVvWZyapilD
 OfPtXJbKkIPB/qYgeX0t+ZOH0OJZPQKMVZJ3t7fou40y+XstKit9mgfGC9QTtckGg+Pi
 BtRrKIm5kD5rD1pQVsK4CEbJEhj3Y9QHxPXHF5FkPfUUCRb5JvstqY7piglYaBTw1G/C
 PE4ZUhvF9wt+Xto/2oP6ssGjkAkrD0We8zKWTYf9hLAx0t36+gkXkD0ceGRvIGRBuzmK
 JmjvYYlfqmkLlIVcIPRoa92dOMQn+XuaUePB/HruTam6ebb/qYWdSEHBjx0Js1ZyeMJz Yg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmuc9ywja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 10:05:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1A0MHJ072145;
        Wed, 1 Dec 2021 10:05:48 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2046.outbound.protection.outlook.com [104.47.56.46])
        by userp3020.oracle.com with ESMTP id 3cke4rgyct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 10:05:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6XVXCkIqaK5/T7+uFT9X6N0WXVGUf9N11+ucwNgZtMkZRpRz64lHaCySGEbNbTe5AjrbSBpxfbGZkt6rGZYjpQ5KvunxwyoFBpcqAhIA2XeU3+AzcCLed3zEjHOaGoip3RIp9L13oKQwptUgS7DxInqdAI9O/cUY9s8mpf/MdPVbAIrt3V3/hjnxxCB48AaE341tub8lxxRb+G279RkEl5CQ2u5cIUMMBnVOeJ/2A2EQ8KVL+QGBJxoq+Qu9UA9rB1mauqr79Hm9QsTGvGJqwonCrD3cUActI+kFIFiPHQxTBAPOxcanPrU8z4aFhQM59symV5S+L9qMl3/AY5GUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9yb3kuXvoDHAkcOjgxrL72VzWR6uIYI3PBv84YjsTU=;
 b=Yl8o9raHVyza340yqDUlUwvwPbi9uICiy3GmrfHra0qOZxsljzR51xbBsMh/TnKg4gIHTO3FBxDkOYVDePdXxaoDDhfiE/gNZ0q415TItbaH55Ww+bZxRNKq6LSNgYWvgmK2bBlfQ050UUb+VredlqmUTeleZeVWaHD3GRVYXWSadPomW3QNteSt7055j4ejAdPNGX7yJ0M0+8BAOarIS5eOH/m4fY4QbHgC/LTi1IPcxJgauSY+U+d5/i/uJnzQffkgnRjaHS8kihMHpg7SwKVcbJglKd/rMkiHIo2HhkLhbPsWGdERP9MI5DzQL2FIoljPXKR0TzN4nbwZjXQTxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9yb3kuXvoDHAkcOjgxrL72VzWR6uIYI3PBv84YjsTU=;
 b=EUnIkGK7xNDJv9rorPsv+pIcgbwVMivI7bw75JgdFh8As58MQhyHcPVW5StbvqyCtK9O0y/BsP16bddZPDyLOiOJXVNW4tNYkHJMOt97NXr6X51mhvOMCtZmjEAn6jeqalWj5euud2Ym3swcFVN90Z529eJXwI2QswhAC58dkL4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2160.namprd10.prod.outlook.com
 (2603:10b6:301:36::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 10:05:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 10:05:44 +0000
Date:   Wed, 1 Dec 2021 13:05:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Arnd Bergmann <arnd@arndb.de>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [arnd-playground:randconfig-5.16-min 169/191]
 drivers/char/tpm/st33zp24/i2c.c:123 st33zp24_i2c_acpi_request_resources()
 error: uninitialized symbol 'gpiod_lpcpd'.
Message-ID: <202112010127.gh8qvdja-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Wed, 1 Dec 2021 10:05:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5b2ac49-9da1-4ac0-92ba-08d9b4b22374
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2160:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB216022708B88D515575C5FFA8E689@MWHPR1001MB2160.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:105;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYoRSgtVNCOHcgHyIEp0puyqp8Q5kd8GuHERwzq/sbHjMwvEXbLBXGNZgSFFA+aPiATDBbMvlVndN3Zkx5imw4G0cuFtdCYLakU8tXFUV/wSXij2cLRiTntwsPq0t05nK4Kyc6S5l7eBNOeAW68BMvXgR/QLOZCIgo8dz97tVOOrW19ngWLmug7/5OEWyBNTJHkJ9S5kE0BbBbaHj6M6DWNDp71ZRGtZfOCkh1yEPRBCIFsBrPZ4aiZ1dj+u18RXa80xpwqNqZzqCWbhSAnx+2Wtt+93arXnP9m4cmIdHj0cPdTkzhs2JSiIiM20vv7oj6XURHseoepNs61FYuuBA01Q0d5izBBV1M3gFx+Q5zUvAy/brGr395vVshHz8bzS1UGxaEi+dQcFHjcBN6TpQ+Td4kpWrd94C/01fHQn/hBL+WBxT5QpUqVUIa5Cr2j18uFHD1UukcLRD3diwS10FoMuIUfIAXNWbt8KS6j0rE0fBOzjN1HMC3v2Jq5LLnIFtzGPyq4QlyjfRKcAYUfLbpw6IIEK1RIGKmwo92Ix73FMAPapNuikSPoE7rF1PYfxkkg2VoBCoaMeOzg5xel7KuwhXCqR18fDkhY40mDXqKkPj7vyTZ278c5uYp2ZwNChFGKKPiF5BInXvav8Z31ZqIBHk3PqNz6iPIf67ncaxD6xLmJia9NOpM/J0krKKroq+fc/xJqJoXbBL9sd1h6pFLCWmU8Tc0/PUjwiAu146cdjMco3hGO5q0mobecOlsFaI5FARpQVKwSLZJ86m/eBMAorPn8X6UaZn/In7W25kj2wQjguXLdvvrI0mitD5rxy86A1XK2bH7mP1m0IyQlX/ov4K5df5f3BadKioo/D5kg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(956004)(83380400001)(4326008)(316002)(8676002)(44832011)(38100700002)(9686003)(186003)(6486002)(4001150100001)(86362001)(966005)(26005)(66946007)(66556008)(66476007)(36756003)(6496006)(508600001)(1076003)(6666004)(52116002)(5660300002)(6916009)(2906002)(8936002)(70780200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ph6Z7+hkqWOWtfl35LsvdH/nyw7Z+raf8JmlYu5dynao1BqV+JctDAY3RUcT?=
 =?us-ascii?Q?QCsADWolw6/qAfqJvY2jUFRg2lkwy4bjP+ykkagQqDGIyFb1yaJMVXLz2Znu?=
 =?us-ascii?Q?yL3XnViKOztKedUF8svR/Dq7yYlTrTSgpXpU6e05VF6MscufPsW71wYOU5Db?=
 =?us-ascii?Q?ABe5HNg1Ec1zjNiQvkWjRaAYM/LLwhWybswTmzM06Ml1Tx1Pn06s2Yf5EDNw?=
 =?us-ascii?Q?zfl9AHYDXDeFlieE7raS5H/i65XK3nc512YT9g70Isl6GqEVPT9uZupGfKLF?=
 =?us-ascii?Q?MhP8hrlVRQLqqAXPu4cmoLcTFzu/rTTj3NbnEynuueIgiWh2oH3nQzmhz4FZ?=
 =?us-ascii?Q?UsQ+nd+590fTocsG6xxlbJAKMh8hgILZd2RvHerE1+ne62eiSXkxJgU/yDIJ?=
 =?us-ascii?Q?A0SzZKo15ZdJo/ELZICSQ2BprXVsukiC241h9SGw9wCSLcE25J/7h71WR6nB?=
 =?us-ascii?Q?c6qKTE+0eoY7PKnqnn7OSV13pbHC0GZXSPQJgV/A/q+QmsH6VXYaCe8AiaTv?=
 =?us-ascii?Q?AhumTFIguIFiDOBObePH68eXRYpIVTwJ8pdIAbPGBmXdkV9u7jeueL0kMRmq?=
 =?us-ascii?Q?/FbBE5/BX/oCWnLZqsDGaIY8dxmdh8xJk4SlDjA9fSLw5NnywICY/k/hSGjb?=
 =?us-ascii?Q?bhlfv6xp/GU3pLK/uPUiMvIt4Vd2BWPU8lILDsdbVkhZ/VQyqHrzgI2sSE0N?=
 =?us-ascii?Q?6ljk2PWtuqx2Va3RXkLl5O/lbx9V1cqv1qqtZFsB3+rM3gj3AvnOxunrGqM+?=
 =?us-ascii?Q?auNIze0H7KiuAe0QsvYF3DRfy67c7u5h54Ce5c3koaGDw1flvLs/2Pblm6Gn?=
 =?us-ascii?Q?zg44NtaNKJDDRfUx45SKcp0ZEMmMi9Tlq8k4sMy47d4Fvw4VrmtO9Wv9REYh?=
 =?us-ascii?Q?hprpIE+nwGK04aIVw3fnfjoXHwCNAS2UkjnpV+fz088gaMIgI29B9uEuvjzi?=
 =?us-ascii?Q?0CjeHcng+/nl1fUGBZGHEFj6MB0Tj5X++CaT68Ybd881PqbmU6t3/YX8/0vM?=
 =?us-ascii?Q?5vUZ17We8aapLRreSo/u/MnV9OmwdgMhuAC85mEfcsrTQEsdQS/9/vBO4HD2?=
 =?us-ascii?Q?dmM/NNdH7T2cMvdKdXklewWD6DsJU7DeC44KAlF9cgvPvFDydCtCajFRHlqq?=
 =?us-ascii?Q?svo5+qZpq34Fabz1NESKmBdVH7yq5fz8ilczpaZY+HXMH3Jx4Va6JjLBpXkS?=
 =?us-ascii?Q?3n2drQOM5FV/5WCza8pgqPWRvaWv36FstM09sTId3ZszmAFnPHQRQNPEmXsV?=
 =?us-ascii?Q?S2eYRD6Hz9C3BXYU6mypDVjCOgGqNnbyyQqHu5iXvJebqVJg3yzo9JB/1LUZ?=
 =?us-ascii?Q?Yow+Bn5T/aa0qjLiv5eYgG0wxZJ70Ln0ymTl3oev+2naacU9WGmaYY4sLnUJ?=
 =?us-ascii?Q?s/H7v0mlFeYfoYTIJ84nkBYZvsRoXR+jKZUhEPGvQWGV1GHl18ue+0uTs/5e?=
 =?us-ascii?Q?PdGyNGjK6Ae6MzsDK1pz1PrxUebfubafhmk25wac3NNAZn7WUMwSrNP+/xjC?=
 =?us-ascii?Q?v17ZjwJmCzS63GTAR/7prWSG4OGz8zfWSquCa04D6t4gzAW0rX4OefyKqqPB?=
 =?us-ascii?Q?jlFXn9QTIu0iGApCRIWoQ0V0RN6Cm3RbjCkeU7V+DhIDfNpzptUqKmhBRE0T?=
 =?us-ascii?Q?pMP9LQ9cue/Z8pf/wRuH/FNqj4cX2d5gqqr/bLAQxWdZJfF1UZCiB6QwspNO?=
 =?us-ascii?Q?0/ZnuiefsMw5qebsgr92coqd8E8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b2ac49-9da1-4ac0-92ba-08d9b4b22374
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 10:05:44.5184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: of5Q0slGsqscFDEMzWG2L+trh1GHarPzDqpBJhdba/C+QdX+HXNXKPLkmvQ2uD9E/ExA7FZeX9XHAHDiRB9+vmkOpndW8i1KpaIWOoxS/ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2160
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010058
X-Proofpoint-GUID: RXMXU3KV49Shsf4SoJvoW3ZAOAz8nkx1
X-Proofpoint-ORIG-GUID: RXMXU3KV49Shsf4SoJvoW3ZAOAz8nkx1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git randconfig-5.16-min
head:   7a16665b8fd19f170c0c15f1432c90e4750183f2
commit: 19074a13cd9fb8cd329d4f09ac0c28a6323abc9a [169/191] tpm: st33zp24: convert to gpio descriptors
config: x86_64-randconfig-m001-20211128 (https://download.01.org/0day-ci/archive/20211201/202112010127.gh8qvdja-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/char/tpm/st33zp24/i2c.c:123 st33zp24_i2c_acpi_request_resources() error: uninitialized symbol 'gpiod_lpcpd'.

vim +/gpiod_lpcpd +123 drivers/char/tpm/st33zp24/i2c.c

740ec346f32b34 Christophe Ricard 2016-02-23  108  static int st33zp24_i2c_acpi_request_resources(struct i2c_client *client)
22eb90db936755 Christophe Ricard 2016-02-13  109  {
9e0d39d8a6a0a8 Christophe Ricard 2016-03-31  110  	struct tpm_chip *chip = i2c_get_clientdata(client);
9e0d39d8a6a0a8 Christophe Ricard 2016-03-31  111  	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
9e0d39d8a6a0a8 Christophe Ricard 2016-03-31  112  	struct st33zp24_i2c_phy *phy = tpm_dev->phy_id;
22eb90db936755 Christophe Ricard 2016-02-13  113  	struct gpio_desc *gpiod_lpcpd;
32da5633dcb911 Christophe Ricard 2016-03-23  114  	struct device *dev = &client->dev;
2d2e376f05f23f Andy Shevchenko   2017-03-15  115  	int ret;
2d2e376f05f23f Andy Shevchenko   2017-03-15  116  
23c3beae581f7c Andy Shevchenko   2017-06-12  117  	ret = devm_acpi_dev_add_driver_gpios(dev, acpi_st33zp24_gpios);
2d2e376f05f23f Andy Shevchenko   2017-03-15  118  	if (ret)
2d2e376f05f23f Andy Shevchenko   2017-03-15  119  		return ret;
22eb90db936755 Christophe Ricard 2016-02-13  120  
22eb90db936755 Christophe Ricard 2016-02-13  121  	/* Get LPCPD GPIO from ACPI */
19074a13cd9fb8 Arnd Bergmann     2021-11-11  122  	phy->io_lpcpd = devm_gpiod_get_optional(dev, "lpcpd", GPIOD_OUT_HIGH);
22eb90db936755 Christophe Ricard 2016-02-13 @123  	if (IS_ERR(gpiod_lpcpd)) {

This is checking the wrong variable.

22eb90db936755 Christophe Ricard 2016-02-13  124  		dev_err(&client->dev,
22eb90db936755 Christophe Ricard 2016-02-13  125  			"Failed to retrieve lpcpd-gpios from acpi.\n");
19074a13cd9fb8 Arnd Bergmann     2021-11-11  126  		phy->io_lpcpd = NULL;
22eb90db936755 Christophe Ricard 2016-02-13  127  		/*
22eb90db936755 Christophe Ricard 2016-02-13  128  		 * lpcpd pin is not specified. This is not an issue as
22eb90db936755 Christophe Ricard 2016-02-13  129  		 * power management can be also managed by TPM specific
22eb90db936755 Christophe Ricard 2016-02-13  130  		 * commands. So leave with a success status code.
22eb90db936755 Christophe Ricard 2016-02-13  131  		 */
22eb90db936755 Christophe Ricard 2016-02-13  132  		return 0;
22eb90db936755 Christophe Ricard 2016-02-13  133  	}
22eb90db936755 Christophe Ricard 2016-02-13  134  
22eb90db936755 Christophe Ricard 2016-02-13  135  	return 0;
22eb90db936755 Christophe Ricard 2016-02-13  136  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

