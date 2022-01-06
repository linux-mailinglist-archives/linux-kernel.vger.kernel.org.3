Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE8F48649B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 13:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbiAFMvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 07:51:47 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2546 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239058AbiAFMvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 07:51:46 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206AjbA3012787;
        Thu, 6 Jan 2022 12:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Rn8AUEieP4nC1TGo4C5+WRqdJGeyeI/CcYYzTV6/5X4=;
 b=zH+gI/nDpadyjGSDyf9wjcXEeei+IE131UY1dTNzb5lt6WufrI6GvWpfIpLU9kU0sa6V
 j5fkSkDgvFX348VF97FmBCN+Gpvpw87q51bzQLMPf6AK18sr+7FLbasmNlzFPguh5I1n
 N/aOHGF/fQqbzVlhKCsyydqpTCUHBMTd8q1ub7vcjbWfvoFMNOv111727e97gpZYan9/
 2hvO1zws+mzGVJH8US+Vs0FXFj16x3XeAErWudHFF2lSHoYRzCHZfpKlFzDyrObCH0jr
 XTOIPK6RXhpyA/8Jo0CZh/xrNqpqD2wO0ph2cDReui+AEnwmo2A3CWC3VcnbMT/rCI7u CQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpjsgnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 12:51:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206CjiEL064007;
        Thu, 6 Jan 2022 12:51:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3020.oracle.com with ESMTP id 3ddmqasmnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 12:51:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLMvk/l+izJWvwpcm1kcGQ0UOUwwkEzwlncJw5ZR8BFANOjpiVcBFq7uf5bmZkLdQ0bxzGSJWSPVOQ5nbv1h0b8KjB42gJTfHVEwmF8iUHA1I0z23HGMnc0I3VNnN+F53VitEoUYEbbjrge2ty9wNQUgvOK2/QDKDPPyxHfcGdFkJol7XPEKu/bE0Oii87p09zPGbzRqc3eQ9P/mJxTEj8DFOP9fEokcc3W4oTrfnf3r+qHDuncU2CTl4kx6/HS5+9bIPDaSB03ubQsa72cPHu+35szo2XHO+cZcGxHkY/N35o4P/JVBZMa89oJshWo9cGnBzUbe+4Fx6hX7nPjsng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rn8AUEieP4nC1TGo4C5+WRqdJGeyeI/CcYYzTV6/5X4=;
 b=h1Hkck0fpXVg54xN9me7iSFtdTCAOWUxLLvfpFzW/ovp5JDNaEGASeeZx8h+rGuOgW9SlNRmvWf6nJaQ0+0hKHKno3F2OV1LUv3qk7/nfw8PGblplTvwm8RUR6ub4hucu4jHNxgD+CzpWJjJAmjaXUabWCpgiLiKRcq2Khl0BvTlLg/PQn9xeun4Vx0pzJPaMSkpY39MTPNY+hFOnDkfQRYUp8HEDA4o67jvzs6vKREskt46jI7JjXnnWYMqXCBCAb9wMplCLJxnKEiot6cLkdhz0ebd/xlVGHn7ukDiZsoKFIv6XD2te/ONpkE1ugVIxzEm+CkgKj64ObOMJCsCYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rn8AUEieP4nC1TGo4C5+WRqdJGeyeI/CcYYzTV6/5X4=;
 b=z1yovC/X95gYj7P8zN6gwvE+dVXWAyWMEBGBi2F5rzgTpL6VaJo1pNgf6/xedkGr8ObJvJkYP4vIrYmJHG3VH0IJdZmt4mRv2uAPoEX3GEqoiMZo61P7AJ0eAYKxZDddfRs3vByTlF3I6KFSdOvlNmnhJDQGr+sOfx+xxtKF1/k=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1288.namprd10.prod.outlook.com
 (2603:10b6:903:27::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 12:51:27 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e%4]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 12:51:27 +0000
Date:   Thu, 6 Jan 2022 15:51:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gaston Gonzalez <gascoar@gmail.com>
Cc:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        nsaenz@kernel.org, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] staging: vc04_services: update TODO file
Message-ID: <20220106125103.GM7674@kadam>
References: <cover.1640776340.git.gascoar@gmail.com>
 <3f560a75063a0bb744bb34c410e49f792d2c3d21.1640776340.git.gascoar@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f560a75063a0bb744bb34c410e49f792d2c3d21.1640776340.git.gascoar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0047.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::35)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33029b1a-486a-4028-4b80-08d9d11340f1
X-MS-TrafficTypeDiagnostic: CY4PR10MB1288:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB12886DC603F42D8890895AFE8E4C9@CY4PR10MB1288.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRTlHDF4y8umOHQwnFSeYpKOcZFaXZDcMCKcJzoHCKF7EP6xRPWdJvc0F/rNarDqmNR+10Sn/6zGvAvc5PYTqXGdfpWKxippuAW3+UeNDdRXXPXzx5jMNfrQCm4GBiQHYphCibKW5JARmWiSiQp/Ljltj1pB50FJO2Jjsyo5KGIhuXWeTfygTf422YzR8ohJXBYxBMFfq5Uz/3nLxWKqHCjZKufZjMpMwQ9p6beDA7CMX7OvJG4QZ/kPSWKaMz/5/0r6tH0SMb1eC9iqylDoEfgb6I2nx8OH2QMTxYehJw9x7n6cuVyldmisATdIkDKkAh7kfqX7ykVn74pW9HaVQUMo0MiUcLDGzFYYPB6XdkXb+R79lbMrG/lqVSqcQCmumYtu9DY9KxsBKCbslPlddW9f8qWOs9FqJG9le0MLCG477KT+kla1X6IqvkmahisrCHKhGJa3FTW4YuoaDXNhSSfgu64id3PEzf2v45KWqYpGmX+7RxOU6RtabzeLixe2u4U+steZ+g+XAQTqEc/dti2abAvDzqKZuRiX8hgsz8/FYDTK6XjyBbLYK0PahZf8zWbr5M6CtzrME5gELOAJnD9i4R3VSk8lCob+753j350ZMhuaJviC0Wa17k713Vn7mP9U381GrKcfA+4cv5Y1YavNggOwA71j3Tr3cO85Jde3e2I3LcNkp/3ICNsT+L3s/QRcwrBeRbCkU4Rac1ONjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(52116002)(6512007)(9686003)(86362001)(7416002)(508600001)(5660300002)(4326008)(186003)(8676002)(44832011)(1076003)(6506007)(38100700002)(8936002)(26005)(4744005)(38350700002)(83380400001)(66946007)(316002)(66476007)(6916009)(66556008)(2906002)(33656002)(6486002)(33716001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vGxEFO+H7vr8ZznaMTfuc4rswdkX4BEHAKm9D5blv4T3omkdVgb5NmY6h7dl?=
 =?us-ascii?Q?35dQlgHhw0Sdso1EddKfloIvHsiTEjZ1olzozCtKrxy1nRhycDUdsDHqdPkc?=
 =?us-ascii?Q?sql7EFhxjwdWdf6DlkLIcWVR9QjpYJ3aWzjZrGtd+BcM/DA+BqQMZLNm5aDk?=
 =?us-ascii?Q?En0F+8jtySGbMy/JG6p5u+k3WYM8kLAIWpqxfdiEwzTz2mlCITy0S6vcc2xY?=
 =?us-ascii?Q?icEWFqf1b5q3j/9EnFpa3bF17KECneGoxgfLn1QbeMRZL2SIYgD8Ypc9yL9r?=
 =?us-ascii?Q?Jq+21W2DEGqIzMAzbcGWMiCx9Xrx4aAMnbO3DAZfUk1F9kxg2JwVduJuudCr?=
 =?us-ascii?Q?mI60o5bpsShH2/ihLTwq7aVvNSzqUvv+ZQkshTAaFti4vnfVFPHzMmeepXZh?=
 =?us-ascii?Q?DLhoGAp8o4YgecnmXyPs3XMf5mWQUyBHPAOP6FeWoQMcKPC7V5c86NgJalLt?=
 =?us-ascii?Q?zjwhm2amk5BjChbJyGq1P4D77Pu+zPkWUe9y/xo8YbyLmsNDAgzW+H9F7kFf?=
 =?us-ascii?Q?95mtaMzAWZs9g998SWBA882rBeaWg7sIjdiaK8TvfFYzsKEDqJfPdw47wMe+?=
 =?us-ascii?Q?84/ys0Z6ityPeU9ABVvFCOxA89tZgpCXghg5q6iI1klwJoWznmzGuPMSPVW8?=
 =?us-ascii?Q?IYS/F+SVB90pVILWA7N/J0hTmlDUIeUlroAcVf+WXDorEC//jweX1wooTh7n?=
 =?us-ascii?Q?b/HC2/jzqm6opaM4BpBsmXuI2w7HyrnibjH7p2JZl7ymugCiFeY8z/RnbOTy?=
 =?us-ascii?Q?+s6CsSwJ7K4RzkQZV8OyN2/mSc8/Co3Pf+LyAlOf35YeadEgYUr4b1NFtyAg?=
 =?us-ascii?Q?h2HY8goFZvrNTvgdxbI9voC9lbHdTCKLNMs/0LRf+tmn+pl8UhaXInZ0uveh?=
 =?us-ascii?Q?hdlfBwI1/j0iSFGtpo9UUEFLteucMCVwBC7hX2jw2tsezL7ZiKMTrRjyTChT?=
 =?us-ascii?Q?blfUtW7rcW+RmhRRo5DepT4TTkMGfaPRJZJ5w/DMYuwW5quHfIkiyYKjKCdc?=
 =?us-ascii?Q?2Y1BZoTNGuudgzrlZHS0FJghYcUlzWY+PUbtGNBYnRgbhWA1aSBpH1Rt6afl?=
 =?us-ascii?Q?M0M9d7QUHu6Lr1EpolbZRldBd7usL3mUKBHAxWJfUniPelQE6n4jYcX6njlu?=
 =?us-ascii?Q?LHNrJigjRGAlqW3xUnblkeV2tkFC064Ag3H3G+EHV5tVfyJ2pVHuvy4bF7U2?=
 =?us-ascii?Q?jbfZ46CK4Z452fsO81d3U8F9GhamThd/XHP8NXNzrb8WtUKmyfdhJjk02khb?=
 =?us-ascii?Q?OQSAcW0QhoQU1rxfhWjCx6sUgQ/q6HmVFVbbzJ2r/69ORyh6CkoDUUaMwQqK?=
 =?us-ascii?Q?krzQ8P4q493mvuhEbaGYREJmlGJ7ODSJWh6bTHtpdA9zDjluykHa3QeXPU1h?=
 =?us-ascii?Q?dwh/7kjyr5QiAUuGaYH2UkN0Pkrq4GVVmuuWmR0+aqnfL7l+Mnl3OgEokFgx?=
 =?us-ascii?Q?Qbl142btX065GttHGQ13RmJ9Kat0EjFku2IVMD2k+yuPrbmV7gLmLA0Provn?=
 =?us-ascii?Q?jU51xiF/hk1NmpII3oZVwJgy4NRmGliXV8df3ckwJesbZYKX73eUiqo23Vln?=
 =?us-ascii?Q?OYVZQob+biAOcyhKEUwUUQiYV4boeBGKNDR1zL9GOq/SiV5dY5CVU0KfFbFT?=
 =?us-ascii?Q?Ddm5O9VxU7HfLAkSue2oqra2VVYtIYn2quoh9mqmmXEWQiDGRV531io5CXAg?=
 =?us-ascii?Q?rmXIg528A7MPwgknsGToibHb5t0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33029b1a-486a-4028-4b80-08d9d11340f1
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 12:51:27.5806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJOdw6sReWUVkOnfH0mSU8B6Yd6NQgwF5mvDxkuygiwj388QZ++vsaufZBS+nys822NVgz4VLZk1soR8i04owzkw1ipxtr1v5XNcruT3kKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1288
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060090
X-Proofpoint-ORIG-GUID: TKaSahFbJMIsSn8CfWawkPGzLp2g7EmO
X-Proofpoint-GUID: TKaSahFbJMIsSn8CfWawkPGzLp2g7EmO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 08:31:29AM -0300, Gaston Gonzalez wrote:
> There are no struct typedef remaining inside vc04_services/. Hence, remove the
> task from the TODO file.
> 
> While at it, fix the items sequential numbering.

The previous developers who let the numbers bitrot did the right thing.
There is a kind of ethereal beauty to misnumbered TODO lists.  #Hyperart

Or just replace the numbers with asterisks.

regards,
dan carpenter

