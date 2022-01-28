Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A867649F41F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346666AbiA1HKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:10:38 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62644 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346700AbiA1HKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:10:33 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20S1xXNl004415;
        Fri, 28 Jan 2022 07:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=0qBuC2h8QkZsVdwNSfiluC9wXAWWGY0wE0KVRAZOB/U=;
 b=tvcbtdEqKCGaUGBCFLctrfRGNy2InQj+ffD4g74iFW0wTbI4Hv15qwkSU9xwwmstY5ht
 zucQweLWDTilT1jTPtHO696qF2QqGvRtH3DSk2CCNibLPLafwpXjmbNiKUBzCrtx7VUR
 JWOuypPL3lI7Qo+VYO9jmC7cxcRTI1CKfNamI2xCg7mOMQC1g8OFXN/JbU/7dyxOW6Ew
 xVVdZQelicH2XdQoRe693sycYTuM+bJnzJTGf5cMYAZB4jz74a2Vx8eYZdxzfekS9u5W
 PrGwTPyr1kPJopdUAQGhv+Jswo1o7X647dPtbfRSYLDGtbSxOWuQj8oa0eshEbyN/tog YA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duxnp1y4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 07:10:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20S7171P068933;
        Fri, 28 Jan 2022 07:10:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3030.oracle.com with ESMTP id 3dr72525eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 07:10:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlpEMpnLW8UN/Lr5UzV7oMNysKzTKMnbF6QFUIshqRqgPFuIkp6utCO/Tq0A0Cbn2tMcOoIeu4nOEvnfVHYki/BrWeS6+ziTRCEc+CsUdQyjjZoXIXZWA9R8y1Qs5aibR+JI3eIFtD2eTdSP12vP/ssenIomZWHhgxby3tbGTCi0fgyyrPPy8DIAKds4n6X1zZmgwRyu26+upnZH4/A5awkV8NFubakSpUDEZwfLEFg1w889B5YyuOgZfvJiKwFrfSc9rRpdGH7iqOwpZUa0EJ0AAK6N3kQVLkpuhYV1DenuBw3TRyU4IH3c4somdbmsxDq+AcWOynlW1mMxKz2bjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qBuC2h8QkZsVdwNSfiluC9wXAWWGY0wE0KVRAZOB/U=;
 b=CL4pvroPyOYrBRJLGCnfl8vd2uY67pl0VDg8Ayugbzuq1AofyMScUmp0z6w8tsuT7M0+EUK7PV5oFoai9/ugiO62OS9Xxm1AXwrfVUKNdYDrFwnIVKZEk/jUxgTNjvSdP2YXO9Uw1Xwz1AFL9yiuZM2gQbeFBd/r+Zw94FvR5cK/BwX9XDViIyZ24oWKl2u7q7H/qL/YFzDkxJ1rlbmco1Ff03hmv3gFXF+sOZVv49YHbn3NbLfvwX2XkgVEG2WKLFiLhM9y41vYFvfW7qaswfPgzE7cSn1VCaahCIpaRdwP75OjQXiFusCH5Rzq8HDO6TzmwJxTuxy6KguBNCWewQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qBuC2h8QkZsVdwNSfiluC9wXAWWGY0wE0KVRAZOB/U=;
 b=nO9fTHDCy3XK133jEJMxLZe2LaqUSY/HqsBsXssMXZKe1vcpDuUZl3Xyt7neou8wF624AMJrLVwk7v8YEfRaQFDKoSUvS+sHnxhPSs0TusRphhuiMfpg3wwXa3c9CxBqUnLyRxqUSMRZYeSwg2Q4zfg/PTDD5XIDsev8CrP+7jc=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CH0PR10MB4955.namprd10.prod.outlook.com
 (2603:10b6:610:c2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 07:10:19 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::cdcc:584:3514:f052]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::cdcc:584:3514:f052%5]) with mapi id 15.20.4909.017; Fri, 28 Jan 2022
 07:10:19 +0000
Date:   Fri, 28 Jan 2022 10:09:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        ekangupt@qti.qualcomm.com, bkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, srini@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>
Subject: Re: [PATCH v3 11/12] misc: fastrpc: Add dma handle implementation
Message-ID: <202201272146.Ci8W6Th6-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126135304.16340-12-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0067.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::13)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d54b0780-e093-46dc-07a2-08d9e22d3dd7
X-MS-TrafficTypeDiagnostic: CH0PR10MB4955:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB49553FEAA0DFD2A9BDE815838E229@CH0PR10MB4955.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZA8UXuWQ1rYLFoMKMmh36EdvAriaSrm/Ej8pzhRgHjL/YHRj6EXy8eGXxQpqam/cEKX5Aqp4UZvrkotqh0rZKcr07TRJyWHTzfaJdQTJgo9gbjYaieOR3+MWthi45BF9fnF7Juvwb8dfnpMegCOYAeYMUa3WGe8R7GX9utILXpwTVTge0iaUdGGxnlL4biyH5Z/Yj5NICwc/YRt39ZjKqJBDrCJ/Q2NICbbAh+siGXPgzCfmYVb7ZXRucoVCJstB4XQLti3l+ygsRXyImgmVc2uSVuV39xw6JdXcTmBC2Ms8ifIoPOMO8IULM9uiH/1fqBTrV23+0d7Bgvhc3fOJeiEVOlEE1/PAYzjFtM5lLgMkoBHd1MfY8Up9gYSGpxoUw08kAvJDjTtpeMedaZZMRn9qIveC58GIvIPKTSCTOOkdjWOnMBlbT7ixnXqRNpiT6ieIDVdXOYtqxHFTqsTt8KhHNozAfYBJPatrIo3fBlEmCE8Ld8W8V28xVyiddsGpXUPmlkhf9G3kk4IqAK4GBYl2i6KET2qrfXeXuGZEOz/i7c60UAkkEpXBq7wVx/UePOpT91OrURYzD0WSv24g3nvYg0vXRee7fx1euXjvPX7OIJSP0aVgiKbsrXkNxzgYYrzDgeP2G1P4PU5ZvBLPRAL2EFrFcqM60U8bwAi3vd03uPDNWH6FSN3eRPOFKhbFae0malR1X3zNrHNl/M5JVs4HhLZW/rOpmc9TAyqx2kl7TFPwHxdh9ufT7eRgKX8iiwguj5e0guYqaCfqh4YG2hkhb5CDYDwLC/1k6TazcukMttDyswixufPYj+Bb5e9Uz6UZdIJhbP/uU5JbK4gF/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(38100700002)(6506007)(38350700002)(44832011)(5660300002)(52116002)(7416002)(36756003)(26005)(508600001)(2906002)(6666004)(186003)(6486002)(966005)(316002)(86362001)(8936002)(4326008)(8676002)(9686003)(6512007)(83380400001)(66556008)(66476007)(66946007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/v2ZOSql1pBpn7t6gZJ89jAfRQDPfWjIHKza6DBnE8N9UwNSbzMCw4l2+0Hr?=
 =?us-ascii?Q?GpZzTTAeWQS46T31tY8EIQBq2MAY+0tbXbz7dWENlV3eAxiB/eWRjKdBtHSk?=
 =?us-ascii?Q?vAtjvVY+sy1qtWyOL2b64yjIo3XPzjpx7smMHVtP9v865QrMclImBOhXsEz9?=
 =?us-ascii?Q?dLWwY966foAUnUbOnVO8Ehe4yxAsqLpasyBm6ERk4BrQUdNCAOQCZOMm9+FO?=
 =?us-ascii?Q?mLqcJ7Ahu111n7MnDkmw+lQ+b16N8uMZH57KCuy0cVKg1oqMcU6vSJaYpliI?=
 =?us-ascii?Q?0O9LstX2mUr4eSLt54R3ACUhEBcaqOrwiylBVI5klN+g7GMlxIODdu0hRcEC?=
 =?us-ascii?Q?oXP6ZJeMx2XQenVD1jcwwbUWC2Lef8w1EonsB+14NIXN0i1j4jIxJiUdGAC9?=
 =?us-ascii?Q?MR4Y9m/jM5/o1IQUXmF3b90nzT3Vzm5aCGNhUckhrHlaEynQi98hKH/zFz9n?=
 =?us-ascii?Q?h/ZBKZuBpNn1Hsdm0DrvQ3FTt/SkpRFdBFSq1tFGSvVhxX0LAZC2hB3rBxAx?=
 =?us-ascii?Q?jho+Swe5DPD1pvQ1SBb3NfUh3aS7Dlxau/r+Fk2FswS16A5tB2sFmJofCp7P?=
 =?us-ascii?Q?qPy4SBeWh7KX0zGhr2R7gq17Z83nU53yNlREUvgb3ZsdAp5qRUI2ng4f99xe?=
 =?us-ascii?Q?e7foEM4I0VpETm0uUcm1dEJdyhBiSf1R3hGD6UI+IsVsTmSnF6lkEVbMJGl9?=
 =?us-ascii?Q?r+vOM6qbCDepFsKGqPz0sIc7N3NoY6xqUjA59Lc2+D3GpguA6CeqT+EyHkf1?=
 =?us-ascii?Q?hlLZFqaUzbncMRlE73n8PLvCFNs0tuAs4Lgv/JmNZ6YY2xVLJBkJdHOWSjtX?=
 =?us-ascii?Q?Ibx5snEqFsMPYitd8xIIWETDi1Bfv7BF5F/aVFadl3BnNFHGXUucSfKr+FXJ?=
 =?us-ascii?Q?UpU3loEJEbg8nFPu1zx//D2YPfvN8KPRAvQtFcxqEk/1bzSui/IPh/vYvwqZ?=
 =?us-ascii?Q?/shXqpCd7vhF2XRMsQn1pJ9oZ06ImC05wqBcMBMGeFTYgHfcqVcHOSCQ/AO6?=
 =?us-ascii?Q?cAvqYbC4n3hZkQ4HEFrwzChjsAMn98nVNhWRNfZ9ChdSme/3w8tNhiNJeSon?=
 =?us-ascii?Q?oHSTXChUSbJZ/OXf3GcHAPMwaXP1eY15gqDkRFYzcmuaSE0UXq4yaxL//1Qf?=
 =?us-ascii?Q?6jHyVnhBl4vurxJ53MSxRwjriS11pmvxoaW3WzjBAcomXtT414uDMnTcmUjV?=
 =?us-ascii?Q?Pdwni35Q/sCeKBSz7BgYlVPqsfPFcuU9TKfP8TnfwrwV7I/OHHdjktbz0hp/?=
 =?us-ascii?Q?VoFUBY8wVVDM8z5v/bONWk3wkCrmY+PUVgY1Tlaiyh8yJ5kLCN31MQ/Vua8c?=
 =?us-ascii?Q?2m0x0xwVJRxCjMGoQ17QMGpTr1cjMjgmW8PJXZJAyO8/A8TA2G1qeYnMuiwH?=
 =?us-ascii?Q?WjnBf8sNJEbxFNJySBlxED5pVQYkG+NNR5PZXzcCd4UERBejO+K21hSB1wJT?=
 =?us-ascii?Q?JzczToWctzqZA8xk4hrA0z3TDbo6DBn3dThcUwVAc7lJEuroFZjiJjLN8zqO?=
 =?us-ascii?Q?quQ+Dl5e9FCNDTWtmul/B/Lk6a7IqJxO/VqnvskW/kHRyN53b2A0Nh3eTWPZ?=
 =?us-ascii?Q?Kjj+mlv0+XgbNI/drgeJsWzljgYGbZ1MOctq2Bc3Mzuqxkzpb3TEEJpglEhK?=
 =?us-ascii?Q?L9dfi80jY97lLS3VE6jYm4G78QHa9qlRcjwphwHFuPXof5aSM7hQlQVAb5fY?=
 =?us-ascii?Q?kqXSSb9gDxAbnVeR/ogFlg78Y+E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54b0780-e093-46dc-07a2-08d9e22d3dd7
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 07:10:19.0418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fI8GTo5FNVmc2u6H2lavUmH7p7nSU4SPcnie35/hH2M0YgTr/Wl77LDrHWSA1PhUmsOV4NZLslicCnn7Fd3dkvE8WVDgLW3XTqiq70OklSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4955
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10240 signatures=669575
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280043
X-Proofpoint-GUID: Xi8BfESQIr4UBVpis-EjsGlyoS15we4F
X-Proofpoint-ORIG-GUID: Xi8BfESQIr4UBVpis-EjsGlyoS15we4F
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

url:    https://github.com/0day-ci/linux/commits/Srinivas-Kandagatla/misc-fastrpc-Add-missing-DSP-FastRPC-features/20220126-215705
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 515a2f507491e7c3818e74ef4f4e088c1fecb190
config: openrisc-randconfig-m031-20220124 (https://download.01.org/0day-ci/archive/20220127/202201272146.Ci8W6Th6-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/misc/fastrpc.c:1856 fastrpc_req_mem_map() warn: variable dereferenced before check 'map' (see line 1834)

vim +/map +1856 drivers/misc/fastrpc.c

b1c0b7969aa491 Jeya R              2022-01-26  1784  static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
b1c0b7969aa491 Jeya R              2022-01-26  1785  {
b1c0b7969aa491 Jeya R              2022-01-26  1786  	struct fastrpc_invoke_args args[4] = { [0 ... 3] = { 0 } };
b1c0b7969aa491 Jeya R              2022-01-26  1787  	struct fastrpc_mem_map_req_msg req_msg = { 0 };
b1c0b7969aa491 Jeya R              2022-01-26  1788  	struct fastrpc_mmap_rsp_msg rsp_msg = { 0 };
b1c0b7969aa491 Jeya R              2022-01-26  1789  	struct fastrpc_mem_unmap req_unmap = { 0 };
b1c0b7969aa491 Jeya R              2022-01-26  1790  	struct fastrpc_phy_page pages = { 0 };
b1c0b7969aa491 Jeya R              2022-01-26  1791  	struct fastrpc_mem_map req;
b1c0b7969aa491 Jeya R              2022-01-26  1792  	struct device *dev = fl->sctx->dev;
b1c0b7969aa491 Jeya R              2022-01-26  1793  	struct fastrpc_map *map = NULL;
b1c0b7969aa491 Jeya R              2022-01-26  1794  	int err;
b1c0b7969aa491 Jeya R              2022-01-26  1795  	u32 sc;
b1c0b7969aa491 Jeya R              2022-01-26  1796  
b1c0b7969aa491 Jeya R              2022-01-26  1797  	if (copy_from_user(&req, argp, sizeof(req)))
b1c0b7969aa491 Jeya R              2022-01-26  1798  		return -EFAULT;
b1c0b7969aa491 Jeya R              2022-01-26  1799  
b1c0b7969aa491 Jeya R              2022-01-26  1800  	/* create SMMU mapping */
e52e7cb4a5a6f3 Srinivas Kandagatla 2022-01-26  1801  	err = fastrpc_map_create(fl, req.fd, req.length, 0, &map);
b1c0b7969aa491 Jeya R              2022-01-26  1802  	if (err) {
b1c0b7969aa491 Jeya R              2022-01-26  1803  		dev_err(dev, "failed to map buffer, fd = %d\n", req.fd);
b1c0b7969aa491 Jeya R              2022-01-26  1804  		return err;
b1c0b7969aa491 Jeya R              2022-01-26  1805  	}
b1c0b7969aa491 Jeya R              2022-01-26  1806  
b1c0b7969aa491 Jeya R              2022-01-26  1807  	req_msg.pgid = fl->tgid;
b1c0b7969aa491 Jeya R              2022-01-26  1808  	req_msg.fd = req.fd;
b1c0b7969aa491 Jeya R              2022-01-26  1809  	req_msg.offset = req.offset;
b1c0b7969aa491 Jeya R              2022-01-26  1810  	req_msg.vaddrin = req.vaddrin;
b1c0b7969aa491 Jeya R              2022-01-26  1811  	map->va = (void *) req.vaddrin;
b1c0b7969aa491 Jeya R              2022-01-26  1812  	req_msg.flags = req.flags;
b1c0b7969aa491 Jeya R              2022-01-26  1813  	req_msg.num = sizeof(pages);
b1c0b7969aa491 Jeya R              2022-01-26  1814  	req_msg.data_len = 0;
b1c0b7969aa491 Jeya R              2022-01-26  1815  
b1c0b7969aa491 Jeya R              2022-01-26  1816  	args[0].ptr = (u64) &req_msg;
b1c0b7969aa491 Jeya R              2022-01-26  1817  	args[0].length = sizeof(req_msg);
b1c0b7969aa491 Jeya R              2022-01-26  1818  
b1c0b7969aa491 Jeya R              2022-01-26  1819  	pages.addr = map->phys;
b1c0b7969aa491 Jeya R              2022-01-26  1820  	pages.size = map->size;
b1c0b7969aa491 Jeya R              2022-01-26  1821  
b1c0b7969aa491 Jeya R              2022-01-26  1822  	args[1].ptr = (u64) &pages;
b1c0b7969aa491 Jeya R              2022-01-26  1823  	args[1].length = sizeof(pages);
b1c0b7969aa491 Jeya R              2022-01-26  1824  
b1c0b7969aa491 Jeya R              2022-01-26  1825  	args[2].ptr = (u64) &pages;
b1c0b7969aa491 Jeya R              2022-01-26  1826  	args[2].length = 0;
b1c0b7969aa491 Jeya R              2022-01-26  1827  
b1c0b7969aa491 Jeya R              2022-01-26  1828  	args[3].ptr = (u64) &rsp_msg;
b1c0b7969aa491 Jeya R              2022-01-26  1829  	args[3].length = sizeof(rsp_msg);
b1c0b7969aa491 Jeya R              2022-01-26  1830  
b1c0b7969aa491 Jeya R              2022-01-26  1831  	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_MAP, 3, 1);
b1c0b7969aa491 Jeya R              2022-01-26  1832  	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc, &args[0]);
b1c0b7969aa491 Jeya R              2022-01-26  1833  	if (err) {
b1c0b7969aa491 Jeya R              2022-01-26 @1834  		dev_err(dev, "mem mmap error, fd %d, vaddr %llx, size %lld\n",
b1c0b7969aa491 Jeya R              2022-01-26  1835  			req.fd, req.vaddrin, map->size);
b1c0b7969aa491 Jeya R              2022-01-26  1836  		goto err_invoke;
b1c0b7969aa491 Jeya R              2022-01-26  1837  	}
b1c0b7969aa491 Jeya R              2022-01-26  1838  
b1c0b7969aa491 Jeya R              2022-01-26  1839  	/* update the buffer to be able to deallocate the memory on the DSP */
b1c0b7969aa491 Jeya R              2022-01-26  1840  	map->raddr = rsp_msg.vaddr;
b1c0b7969aa491 Jeya R              2022-01-26  1841  
b1c0b7969aa491 Jeya R              2022-01-26  1842  	/* let the client know the address to use */
b1c0b7969aa491 Jeya R              2022-01-26  1843  	req.vaddrout = rsp_msg.vaddr;
b1c0b7969aa491 Jeya R              2022-01-26  1844  
b1c0b7969aa491 Jeya R              2022-01-26  1845  	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
b1c0b7969aa491 Jeya R              2022-01-26  1846  		/* unmap the memory and release the buffer */
b1c0b7969aa491 Jeya R              2022-01-26  1847  		req_unmap.vaddr = (uintptr_t) rsp_msg.vaddr;
b1c0b7969aa491 Jeya R              2022-01-26  1848  		req_unmap.length = map->size;
b1c0b7969aa491 Jeya R              2022-01-26  1849  		fastrpc_req_mem_unmap_impl(fl, &req_unmap);
b1c0b7969aa491 Jeya R              2022-01-26  1850  		return -EFAULT;
b1c0b7969aa491 Jeya R              2022-01-26  1851  	}
b1c0b7969aa491 Jeya R              2022-01-26  1852  
b1c0b7969aa491 Jeya R              2022-01-26  1853  	return 0;
b1c0b7969aa491 Jeya R              2022-01-26  1854  
b1c0b7969aa491 Jeya R              2022-01-26  1855  err_invoke:
b1c0b7969aa491 Jeya R              2022-01-26 @1856  	if (map)
b1c0b7969aa491 Jeya R              2022-01-26  1857  		fastrpc_map_put(map);

"map" can't be NULL.

b1c0b7969aa491 Jeya R              2022-01-26  1858  
b1c0b7969aa491 Jeya R              2022-01-26  1859  	return err;
b1c0b7969aa491 Jeya R              2022-01-26  1860  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

