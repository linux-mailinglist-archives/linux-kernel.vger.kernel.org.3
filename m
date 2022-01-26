Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A074449C5F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbiAZJOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:14:55 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2200 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238855AbiAZJOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:14:54 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20Q4hWmt006719;
        Wed, 26 Jan 2022 09:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=xCF+T+rK2nI+1di1wmwFv9Ycqg2CVTBhIq5c0fYg9oM=;
 b=x16YQU1aGI1rDahy5fwCPbFHib+qGk+d0u7aQ8TPfS1upHCo4JyHpoFmWegAS0RnOEpP
 eu0edPGXxDFW3O4a00UoulCi+hlJRUr/5EUKE4vkTUpVNgc2H+Ft20iz8HUvcPDkJ4XK
 QcgEG/RAbcuvAWThmVy+dcZELKSFbE2TuSS6uqB2xhzOBEQXS6waPiVL3kDQCE7ucvo6
 GgkvyQLsTl1SXAN7o5kVOhXvVYEJJP5sHzC0l2UEUK9BAhLpzRRHdaUxJleQdAF8797T
 8+00/LD1UB6frqMZPsk4ffeSobclokut0qHkPDyyntL++7nLlqTburv1BRiHaexReRmI Fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsvmje5ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 09:14:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20Q95JUC122123;
        Wed, 26 Jan 2022 09:14:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by aserp3030.oracle.com with ESMTP id 3dr7yhbkk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 09:14:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWGeg2UsqKoET5FTMxG5NK55KTb2wuvekzDjczT4omn/WS9vD6Eeh6nN0ygcq16UtxYLqrTbfwSC/qxX4eMpVUmx4lzXIeFx+/FEhF7z9OGYzVqWsQSRuXiREQFRuazwEWLgebVZsC0e/OcDKEgNybDKtSKPpJhMFnifLmdWES7O5uyHhXjlAHwbUkY3YGcbtpmpLVKIQHCu98trMsyy1vQLQGOmfi7pKFWxNUD7dvRvjZueHOSWFaQEPBycZFyM2nja9Mqw79xYVrLGYy2a/69/gB/8ZxNpIULIFqMFZxIrKU6BKcfOLQxBDLFTgxx69TAaVMaOenqLnQZ5KRThag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCF+T+rK2nI+1di1wmwFv9Ycqg2CVTBhIq5c0fYg9oM=;
 b=hoAENDiFYabMDVHEjwXwnrAWAH5yFENiw8lsTx0uultIHnmRDZqhMmq9SAyFHoTSDaUBw0iBC/94iBmmLweyyrgPi/FZVmukbFDbeUWfDk2YZmwpT/sDtv5//viWmfQsqV9iu8bRvFaJIyP2a7ogXVnrlJxDeYfyRATvT1ZqTiKjFAprDkdH+YIfifH8Ek19F3nWlPgMonKZLSxIpf9Qj0F1rVBdYtDXPb30U1s6twURmAT5MrtC/xBy3Jn0D/+qakedoAFgsEBZVBdEwXi0klLDJjAP+LWmS6Y5R6K6YtBaCuI+1EoZ9GGvanANufkfs8ADlmwzGk1zKP4OjNLb2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCF+T+rK2nI+1di1wmwFv9Ycqg2CVTBhIq5c0fYg9oM=;
 b=Fe1H9/Ep9M6j3IOaU/UIqJ5cb0X6h0N9r2IL/Av05dhZHbd6avsEQGavW0Yc6VOV748m35WIm8LbWX+HzDMBjM8O4U/3HdzN4kxmNk0a0uS9C4/Evo1yZyV65L8gi9Jra/F1tb435pBx++khTpzL8X66CvLWSdvSSF9orMW8QkY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB2928.namprd10.prod.outlook.com
 (2603:10b6:805:d2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 09:14:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 09:14:43 +0000
Date:   Wed, 26 Jan 2022 12:14:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Mihail Chindris <mihail.chindris@analog.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/iio/dac/ad3552r.c:688 ad3552r_reset() warn: impossible
 condition '(val < 0) => (0-u16max < 0)'
Message-ID: <202201242005.NNLuFLzZ-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::29)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fc9f68c-76a9-409c-d746-08d9e0ac4a00
X-MS-TrafficTypeDiagnostic: SN6PR10MB2928:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB29285C1D1323ABE1835046AC8E209@SN6PR10MB2928.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:63;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z9xnhNEbAYoh9ceQfXaVZi8/GEutz1p0wA/yArsczQRZE+/1p+AdEi5XJIaxu+echtGthpRES2fbkzM8Vq3zBaawwArbwU4/lBj0I7tIVBIzcua5ZO0rnsQZDvu6/S6fKFocLhBn93bQ1AK12bSlVn20mskwPbSEvo0VGRcgBWC/zTOx6nyRMDf4N9wZrAa+NOg3RphijzDbGSS/NI0lEH0737+asrEmYuQXp2LMaVuuzENcu0Ffvoj86z8tmWpH3KpOJ+/Tym88doLfbULCjAUulbDp6eLlWeH5iKq3L6rycI7r84nhgYnxZWQXjtqirC3dc+pniHOLTibTnz5oE/VpMekmNiCf4iZTS5TOwUNUijSjDEGZ1Mu1S5JGIM8SntEDWd0k0asKr2mpW0JZI3BepbJK/p6Ef55Q+WPJb+peVtBpCwsbNrZSvTQSYAFbyQ0zR3Q/vInS9AmMHUSCn6l0ouu+O3lyFxW4VYXbxLajHWwzjH6gYIDLPk7EMoXQHtkkgBIKJoDGsLgholmzcVSouCoDk5Wdb8JBH7LjO1mfwMw/fCO/oJOmYr8zqlSkDfevlMtCVcDT/j22E3jamfDb12ur1osUH91DF/AXn0qeozY5ja4C7Dy0nu2ff5rLqzMMVHQRXUDephpioL4gSizKaMfP/U7iAklWRRNzr6P0RuvSuuoCqtfKZwxqCCZFqbMI+k8P4OWk4Q760JJhMTwR7aNojMtlk952rv+r+6GQDz23KMeyfe1euZEfEd17VDfS+lDwb+B5+OgP3DaZZ6zoxsYrGvPr3WTpIOcAimwry28Yit0XpBfh85l83TZl4WAXMZk/hTxAjMt6BLkgiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:ro;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(86362001)(6512007)(8676002)(83380400001)(38100700002)(38350700002)(2906002)(1076003)(316002)(6486002)(508600001)(36756003)(26005)(4326008)(6506007)(4001150100001)(966005)(66946007)(52116002)(6666004)(44832011)(66556008)(66476007)(5660300002)(8936002)(6916009)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vWcgaZ/FcswgydnkLxofTp7T+LJq0T/vfpzDK1OBeao7ygPAoc31s6CHGrve?=
 =?us-ascii?Q?rBgyz7MFtS+/4jNd0G3IuCl5EqU6yKTFGbUAXq8CC2hVfI4ONfItx/sw9UGc?=
 =?us-ascii?Q?OEpjsfgR7u2jmaj9DApzNHnq5Sayx5Xd5/MUI0/8k9sTfzt4WN9QGZjT17Hd?=
 =?us-ascii?Q?ECAgEsFCOKlYDPKA1CyfaUsgT08kgExfsPDet0qq8/A9/OIQaXiyd41ZFS2M?=
 =?us-ascii?Q?XZFbU/u5QsyrqT1UpHoUErzCqG8oz/1OH7DJytZdYbWAthwzQWyY4bQc7q73?=
 =?us-ascii?Q?+D2LEJQfmLvx0Xp1aPnW3jrPVB8ILR7EOXDqPxrl7+Ueg9lQGcSNBLoPNrnF?=
 =?us-ascii?Q?a3cRiWzsBG9T4KDVFDaUjlFHPrqoCeZszFUEJMQ/ZNMqazk3UcI+4mrvzXOJ?=
 =?us-ascii?Q?85cFgEYlQppQt6N2Kux72gytANPMroUFLSFkqx84/n0C1fgb4ryIlnQunJQw?=
 =?us-ascii?Q?Vfmw7LD+8HCb+Ay3VXQh7FJ3pssZDV+X+bZLLGw+mvAbkYAs8vTKKOCtKgJu?=
 =?us-ascii?Q?z0cazILx25hEPqzcmKDZVqZVoDP/TGNadMKiY33ThSxrRaErWv9A3uX9me4I?=
 =?us-ascii?Q?0bU/fZsNbrCJ+U5P9BnaJMOkafpWQ5qR78oIJrd2ppjALxAU/E28FBOZoX9m?=
 =?us-ascii?Q?RG5ThBHizUb8f+eoyn796a26fDDzOPnaeuVRLIDPbcqB486ZCVpGayPJk2Na?=
 =?us-ascii?Q?6fks1SrljqJ2BHaYdikZ+hGmV1DUMBzqD9mGe2Jvk0bnrf9JNDXUyzdnPssa?=
 =?us-ascii?Q?1Ixsf7EkaKpLoldIJoVvaI1UkhcLuSiy+Qw5Jn+7iUhZohEEGxvt/o1cPGUr?=
 =?us-ascii?Q?rKgtrSR5lvyUGZmSBRkA3TxmJ0trEW0/8EysG7tOi+i/s/Ov6gVhLdb8/QQv?=
 =?us-ascii?Q?RO9PjIrJgprs5Dgqr0pGzW3VrjaXHvIpPk+RZHM0tHrrzh1kKI28l7+EG/xZ?=
 =?us-ascii?Q?7BIWlGTv3xnWhQ6anUn0r4isknbTfc+xmeA0DvFAmPnSbR2grU1In53/nnhs?=
 =?us-ascii?Q?eYaXQqiZD6QgjQgXDt7M1bylyPnFfDXe269Z6SBM9Q+rkLYxUyMx4NEafU8E?=
 =?us-ascii?Q?UtlxW0WDGOobeplisKYNI7L+4MEn4tm3ky+b4vITCD3GIGEzPpRDFmDBcECm?=
 =?us-ascii?Q?eUz7fjn9mQ3QTzui27t6o0Y3Kk7lOONTf/Rp8VRloKO6Gyg0amLMEF2DzZzQ?=
 =?us-ascii?Q?XnummT/sxRiy5uzNyA5AAE50joCBLWTQmbv5+wN28lNR2TyedIT7pG2lovCk?=
 =?us-ascii?Q?BYPpdC24tryhRYGpbGtndi7kG3cWXJMJ6qPIFmsvaqaia2xX+p4zHvHfozVD?=
 =?us-ascii?Q?VsrosgHKwucgfd3noJfrzzEYuzfq9l2RXmX8QEm0JTDM8/4Pk3DBa7pTUxSh?=
 =?us-ascii?Q?064HIT9vBcBJeh9Nd8rR8SrKhA3+fC+GMHQdLIBXI1L0Ck2eIwmTFCovxYxc?=
 =?us-ascii?Q?cqkb1reVdH4/DvYikGJWAQFyaYSk8wVK3fYcse/r4UC4FJEcSOcQ/t+xUSzM?=
 =?us-ascii?Q?9NwBDcYzkX4tnFsbRc7J1ZEzmwLInocNnMgMTiAw63JtYi5xEaIxpxSZpR8V?=
 =?us-ascii?Q?r7cyqMZfRGRgExG4ZtD9lxxhRISndDl7/W2IEp/5L61hV0NkkfYf8/btdaIB?=
 =?us-ascii?Q?f9jjGmIsP2GqvlRRR1VS1eujbrFvL77rhcAqdc17C5k8FZW7TxGtEPM2pO77?=
 =?us-ascii?Q?L+RC3ff92Z2LcWiIDDQhOXpuhzM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc9f68c-76a9-409c-d746-08d9e0ac4a00
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 09:14:43.1764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wuwZmLyZjNrykE3xiwoKpWyySVchlrNqyj6qlAWn4scCdTQdVlN1XSe4+UrS177QvvmNC+uK8pxS1dbH1G0OgvVa3ckNBXbLnTURrtoW2FQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2928
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260053
X-Proofpoint-GUID: Jg2OFCJUF-LI732gK19zIgwY5usZoGow
X-Proofpoint-ORIG-GUID: Jg2OFCJUF-LI732gK19zIgwY5usZoGow
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
commit: 8f2b54824b28ba8317c60947b5941d686e3df70d drivers:iio:dac: Add AD3552R driver support
config: nios2-randconfig-m031-20220124 (https://download.01.org/0day-ci/archive/20220124/202201242005.NNLuFLzZ-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0

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
                                                                                 ^^^^^^^
8f2b54824b28ba Mihail Chindris 2021-12-13  698  				 5000, 50000);
8f2b54824b28ba Mihail Chindris 2021-12-13  699  	if (val < 0)
                                                            ^^^^^^^

Impossible

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

