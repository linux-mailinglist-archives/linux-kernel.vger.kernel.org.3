Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF944850C4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbiAEKL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:11:58 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20128 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233943AbiAEKL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:11:56 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2056b8Vk008809;
        Wed, 5 Jan 2022 10:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=YaSoaVXSQg087BY76EZ/GHg+TVyXx70o4Lxpd0ADXsg=;
 b=hpEobmkA0+P80IXf81pyBDb71o0rB7H2kZjs76DhmFZytH3zw2uZ29as/BRYtzb5tBFK
 em8deEZJkKtyY38/ao2u6eZn499eKzxUUpZoD1JTUNPvdUaWYgkNSVHyo+BISPuVzlB3
 o3S+adewWp8/mzgxB5Xynq3Q46Y8Oo874pRj1RZra7r9iY0HeiZKKQTvqhPpUiMK1NQv
 efiysEoOdhnZI+KHZYdUJMdRFWu9W5+9o1DDLlH5Ok4VaRTvLL9sT+nJUEjm0/FOFvza
 b3xf4HOOBrYPuy9Rwc4VfLpcYchrWwPl4eo9YvK7/n+R5cmwlb3N+/4NW6r8KQT80LaT lA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3v4mg66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 10:11:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205A67Ks051856;
        Wed, 5 Jan 2022 10:11:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by aserp3030.oracle.com with ESMTP id 3dad0es1pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 10:11:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fH06+2ZCXAp48tD1c9D9EWlkfFeuwt3JRqnNk63KyIHtOaVMgtPKyRUnDkzGx6fFwv7luwJo+r9qOxYxY5x2U2rzTfGWf4kBeivDLRm2ZbItSwLWDC1jrLyLfiQDQAlLd6/GWL9lotIna706FNz4KH5Pn5xsyeq4SvkCQBtn51+hGCMmPJWihHXo/XDbTNuBJiU6DAjiDYi2ZNkxdSQVnu0uRCoCswxZ24Ya+oRDyirnGKSPr6Yn5Xo7N5IKO+EIHYvaWzisZSUznuAqnd6LtSmXu5NINUcggFMPlNbUpg3RIdaL/uoyC96IHGYYsFy4lE37bcJ1yCKuqgIRnq2zlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaSoaVXSQg087BY76EZ/GHg+TVyXx70o4Lxpd0ADXsg=;
 b=EVUG5lP+DpCKRmoYLZFX04sIa7T9w/DOHWpZm6XdThzn/UoVHrmMoGzyhfkR8Zh4DuHAGxTCpVpRKgWH4oefEvOBX/upEv/hT7/qZsH1aerQjAyoQbtyHpwFCnffZEiiSbkVOZ9u4s9DyAfBSkKKDMuBr1nQ7Tj/6uyRZ1VQfiplTDL3reeHLTy4izvBPdVRd+t6EGc3AvD5Cq2hkLFtIYgXg4UyhYM7jf9E2dQk7VKD5fLKa1bqLX1zHo91iQgn5odzluMqv5wQSqIcmzldeYl+iLJ1qBwkcb3g6LFt4WY6OlJ77MtXaq+dqiueRUAIdY6ceN1/6yvzKtmkYYX4jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaSoaVXSQg087BY76EZ/GHg+TVyXx70o4Lxpd0ADXsg=;
 b=oLjKTYnp0YiM+jKpBAacIxVbLVwTXbWBYTTAG4EO+K6ASHK/ZnrS4s8XR/YkRFR7TXTDpcOhzvkDBbh6iJX57XTcWUDgCaquyDd5iI9unBBiHCtVrkcIg31pH+vuVYD66Wj9sIpdctBa/dKvUzTSk8y0rMvCEebUzya1A3vKqDE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2256.namprd10.prod.outlook.com
 (2603:10b6:301:31::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 10:11:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 10:11:45 +0000
Date:   Wed, 5 Jan 2022 13:11:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Chris Park <Chris.Park@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn303/dcn303_resource.c:533
 dcn303_stream_encoder_create() error: buffer overflow 'stream_enc_regs' 2 <=
 4
Message-ID: <202112190934.db7anVBT-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0067.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34be03cf-33fb-4095-7bdb-08d9d033c708
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2256:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2256924DA6C892ABE76836C08E4B9@MWHPR1001MB2256.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:374;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nny01JnsKTt6BH2Yp+ZyFb8njmMzf2RbsAHPB9Ss8BLckmcKTOEQ9jY2x+bGGzt4VuuySH3mw88NaAHhdJK2ORXKWNgreMM7YRIJnq3P8+UtjDHdzVwaWbOzTfQeUaenHMQkDT/606Dboeve0mhaUOeolncOsZmb3JmK60d1ZzAlirFpApYVEbjaRm6PZ3nMrnnDl3kxMjjBSBfOm4sUbq/kUsdaAxuuGBDzTtujtDIotx2cDrCPB9x3qutja/vdCXjGzMfB5Cv1xBAx051R59HNtjsUYVBvbYTsnFT6L9S25d067gxPUPsQS15voRLSxfFIjuYyflMXFvJy8NL1W3XoVZtn8QIeio8epzQVsFG5+9E1ydLhLWl1nKkPd/risQYPbB0Pox0BwyCP/i4CARolfL9x7fiFvOuQkmiHE3PICoVkE7lOKsu7vKaKdQrpGTcdE3TT+jMmKocMd5agviDpagJ5hfKMHEzgRu8eVg0Vz5aUegaohXIsuc0EBP8nE2n/etZrRf5vmnIjPPoNldWCx3JfUrbjluLBsYxeiakkNZOMdDLI0LeGKvYVgWvKp0uEOY4RMN1ZQ4MFv7jXWhpdFlx+dZXXcOKGohyevIn/WBaBZFEZSGCSNimLNEF/DTk/qMy85sKFmqgLlEKQMPmy6xJJZb1PcEmtkGWjly+mz5i+iAvNY+uGNoGNsFzWJhHOr77y6iTZqQ4xEh75O8TzEQDhwq2KyRopnY7udo+IsML3Vkj5PVip3f9FdgelZ1KCZOb1OYUd3TxlZ1+xUdqSt+z/pxNabqpEyRun5f2QnSPB4Mah2Ghee1pUiJwsT2k1frBQNJXYjtgmQHpTyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(52116002)(38350700002)(83380400001)(38100700002)(5660300002)(8676002)(86362001)(8936002)(316002)(6506007)(4326008)(44832011)(9686003)(1076003)(54906003)(186003)(508600001)(26005)(6916009)(966005)(66476007)(2906002)(6512007)(66946007)(66556008)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ulxANbFsFRx8otBVH50RV3BRuJycEBfhJPdYd3AXbPks92WXWNLp1lYWAIP?=
 =?us-ascii?Q?6aj6t+o5HqMbw2GOcEimRSbdtTz+sg62gl2ev2Ep84PVGiITrbJZg5rWeINK?=
 =?us-ascii?Q?NguvfwgCxCk4jYejyXOuSnItJL18RP3+ombhEXI8NrzCBPYAfJ0Dk4soGDH3?=
 =?us-ascii?Q?lnDzgYgLCS+HKS2pwdBAa913gLAATDy7jtkEUw7k0Jku1p9wBCZVILsRoxO9?=
 =?us-ascii?Q?Xr1MmCS/FVGDs8MVBomXXZR8XzuoshekqQsK044mJFx0zbZHPabsvNpYGg3p?=
 =?us-ascii?Q?nf1HI7n+k7r3GSATwLEVHpvJyKVKnvf8pwFpSvfO+fIzi+8/WNnmXskEDBiw?=
 =?us-ascii?Q?jIJY51tcwH2XbiNynq5q5sSV72PLK+obOh7YT/YUooOCxB4+fjKyF0bzdpq7?=
 =?us-ascii?Q?C22vJLyuOpIHkG2EC91laSIGLDtwWJAu6xwdt1KqwYcaxyKnOOttHYSJpT0A?=
 =?us-ascii?Q?l5/RQXtSFBDOkLbsD/Ue4+s2LgDHDmdyoVE7AVWGlBZobzUmRgGr9VV62U2m?=
 =?us-ascii?Q?t0pP2D8TIRWEdI9DJhe+sOLPBqSe2FK7EsM7Qvewa8dnZMCxFeOK//J3NY+4?=
 =?us-ascii?Q?pB22Bf3bBW/naoM7YtMDZBa22FiSSK+Yho7++pbmPZ0NAXbLVwAWxp17Aqn/?=
 =?us-ascii?Q?mF4tPexci/p0LuVrc5FtIiaXtWE5wmQVZabAmz1IICM4mSSZjO6maOTfwyip?=
 =?us-ascii?Q?Jty8tVu/gAz8P6pvAkhWNfl07YtYOr76qjdig3tHE3S0nJ2LuENzEcrXIff0?=
 =?us-ascii?Q?leGvqncFR2pgDWpr8NhXnQ0G9z35t1ZKJHkcJM+qoABvpm92cTMsJEXxzqwQ?=
 =?us-ascii?Q?PR49hw0H9oflol1O6WP/vZkAM637GnarCEU9nWIkVvldiNhsPqEGPZQnQS+b?=
 =?us-ascii?Q?ZeHwrfu3PHdEVNL1y9Ybel6jhrWb/akC2BElGTEbWN7F5t6XYmaXgeyE0Enl?=
 =?us-ascii?Q?EcEOPR1ABEchSHABD9HE5bNbjw0FL4Xqa7dzb6T84PEtd1Bwh4GsrV/4xb+w?=
 =?us-ascii?Q?/W0w/B17EjxnyE+/lruDZmO879SjDQKmA4PR4YbjHwxCky4Id+iIgSzkgSHL?=
 =?us-ascii?Q?CxmYJCafQog8JzNMzhGLNuBHWjOUfnhCwJ//nKxHQ7vsy3WqXGYTdiIxNYOw?=
 =?us-ascii?Q?vHoLOAos7r4Nug/xnpH90LWoU9gKV0xkNj1rPOnsBIIlbZP2SveylaIFfA6x?=
 =?us-ascii?Q?mG3beZONVvK7NorLzrOUq0zOcuu4tNlf9BO4LvStE++3huofJuVsyTlZOtAB?=
 =?us-ascii?Q?qrJE2r1oDIU5pL86B/qfwJNcD7r1QdxKVLLcOidlS/CX/+6TSZWqXhdEe0rP?=
 =?us-ascii?Q?V2E1utqnQOJEhIS3BlVMNLt9Nwx+rMVwhRzSI18fzN3Vgz3rWqR0JavLZ9lA?=
 =?us-ascii?Q?gJxEn9hbOASzjBlJwPhb/Kicq5DgAU+koitYc6hYV04l62RgBM6bLjmr1L5O?=
 =?us-ascii?Q?hht4TU1a2PPTRcpfMsioc51y/NIlIydv5GUAvp8uUz5iuACxthu38GiF10Oy?=
 =?us-ascii?Q?E0pm/ZxbW9m8ks6djxjjpFG8uszumMYWBvoW8MS9Bt1iFva9J8KI9hF2G3/3?=
 =?us-ascii?Q?Dh+l8J3pGnHgeunM2eiYxwk4ZIlftDLqcCR6qo+Out2RAV1QpllyEWILsgQy?=
 =?us-ascii?Q?K3WQgLLkvuSaaQrHScOwpKyS76MBYUWH2zONqn9u6uhd/ZQp2ydDu2o3DwJ1?=
 =?us-ascii?Q?W833MBZIAuikyTY48dxcL+eioik=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34be03cf-33fb-4095-7bdb-08d9d033c708
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 10:11:45.2329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbgq1OW0ULD7EjfglGopYQLiCLUIOTAbYQQb78H4qVvOOxXgOpctFJ5abZxLk558vttyD8/dk7uUbXfMYbplYQobsH31/dH55wpEj1Ajubs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2256
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050067
X-Proofpoint-GUID: sBfqcPs3C7X3HWYIqLewWpgFSabCqD9E
X-Proofpoint-ORIG-GUID: sBfqcPs3C7X3HWYIqLewWpgFSabCqD9E
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3f667b5d4053ad54aee13dab5c94f04ff75ddfdf
commit: cd6d421e3d1ad5926b74091254e345db730e7706 drm/amd/display: Initial DC support for Beige Goby
config: x86_64-randconfig-m001-20211207 (https://download.01.org/0day-ci/archive/20211219/202112190934.db7anVBT-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn303/dcn303_resource.c:533 dcn303_stream_encoder_create() error: buffer overflow 'stream_enc_regs' 2 <= 4

Old smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn303/dcn303_resource.c:531 dcn303_stream_encoder_create() warn: possible memory leak of 'enc1'

vim +/stream_enc_regs +533 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn303/dcn303_resource.c

cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  511  static struct stream_encoder *dcn303_stream_encoder_create(enum engine_id eng_id, struct dc_context *ctx)
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  512  {
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  513  	struct dcn10_stream_encoder *enc1;
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  514  	struct vpg *vpg;
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  515  	struct afmt *afmt;
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  516  	int vpg_inst;
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  517  	int afmt_inst;
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  518  
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  519  	/* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  520  	if (eng_id <= ENGINE_ID_DIGE) {
                                                            ^^^^^^^^^^^^^^^^^^^^^^^^
eng_id <= 4

cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  521  		vpg_inst = eng_id;
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  522  		afmt_inst = eng_id;
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  523  	} else
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  524  		return NULL;
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  525  
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  526  	enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  527  	vpg = dcn303_vpg_create(ctx, vpg_inst);
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  528  	afmt = dcn303_afmt_create(ctx, afmt_inst);
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  529  
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  530  	if (!enc1 || !vpg || !afmt)
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  531  		return NULL;
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  532  
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15 @533  	dcn30_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bios, eng_id, vpg, afmt, &stream_enc_regs[eng_id],
                                                                                                                                       ^^^^^^^^^^^^^^^^^^^^^^^^
Out of bounds.  (I have not reviewed the context but these warnings are
pretty reliable).

cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  534  			&se_shift, &se_mask);
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  535  
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  536  	return &enc1->base;
cd6d421e3d1ad5 Aurabindo Pillai 2021-03-15  537  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

