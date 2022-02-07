Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A4D4AC84F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345515AbiBGSIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344777AbiBGSAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:00:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F37BC0401E0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:00:18 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217G5Iq5004446;
        Mon, 7 Feb 2022 18:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=QuyuaoVpPrvI5G9NUmM3jwppHAdHFDNb5DQflSBdi+0=;
 b=NkzGgB83Gln/FVhivPF8sQ/os0soRJ8T+miPAvCJO86Xpg5iNBa8ICjZizBWdMqVAjnl
 KnDBSocg+9edLLwvJlbAQNBru9LLYkmz2eUZ/XKBMulTpkdiIr2NqkHmAyCffjfKgL78
 j5N1+BosYScTnEDh3pvk47oCC190uAkLUSLnrPtsmNec7Oei2YChvrf4uCi3G/93c/C7
 dxSK5lQCJNPo2jgNluOtaZssP4G2YoJsm198Tr56k8rx5Z5qIAnY5gnBZqk80ogWyCBG
 sOV1nt4aEpjqlGoqt1jc6bA+uBwB9sZNnPc7SsEkTnuRu94p9a6uGb2+nrJpzjJIUrft EA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1g13q446-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 18:00:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 217HpV5g082932;
        Mon, 7 Feb 2022 18:00:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3020.oracle.com with ESMTP id 3e1h24penn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 18:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqsjVIfzdIncppVVd+9HmpM2H6ON8vkG7l8y/uJ4i3Fmzj2vu0vfnXZwizsrCs51zC2u7ifcfpyqg4KndYlCwtTwk6WZmdcn1DFPZHT8DV42B/DYMINY5V5r/XpXYyarnwXxeBpoR5GxD/DbrCOJocJiq4mV4AQ5POlUihdLjcJAdy77HkkS/T2PhetZSFpA542hzRUSGXpsWb5Robni7Hn9XVxqkN9nBIEr8hk/vHuBAoDi9FJZp1sivc8fsxU2y5cltheAzOvM9simBbK/55BSTsoquXtMzjPcfSZEwA2ECcLccyC4dM3LiN5dUk+G/zBTx55wrRze3x/6Pvs7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuyuaoVpPrvI5G9NUmM3jwppHAdHFDNb5DQflSBdi+0=;
 b=hhu0Ya8ejYm8Y2CkIEC1kui+rWk+asOxi0LI1CdWsxLtQiS7bphtUw27R+qEJoTSzYFU56gW9TZVg4OBfeCuwoqaQdih1b8Y6Vp0XwrfGjL5ZzDPNAtv1arLWGHq6xrNYzeV4YzyXXpsEJEE8VGOYzDqjZHuO3iR+AOk3VDAbX9+jBBpu8yr7YOHFa/yh5yqjlQllNHzjhlooXqyrwJ/Rz4KeeI1iqn8Riwlp+/NbYDAOXG5bo5zzajAxjL+/eVqzcXr9YYrJE2HgxrGHH0vQdFmtlUw1V/j8wQDNQ0KTx7bShUUdq4ahG6vuFWStrYFjVBf5eIgz3bd+NkqjLwdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuyuaoVpPrvI5G9NUmM3jwppHAdHFDNb5DQflSBdi+0=;
 b=Cy4hkabUvPwLy0LTzB2fyR2uFxRSkbW/5sXaZRUQkry9uXZWM6+L9NMUmFaZin6SyhFUGXkFup88R+wLQGcS//xBNq+z1/hfoSrH8FH74NAT5g78VjIQOBNqcQUel1Z7KTRPVvh+aOSQjwW13AWAvXnvGqymwWWhWcT+ZbSOdmQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1310.namprd10.prod.outlook.com
 (2603:10b6:300:21::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 18:00:07 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 18:00:06 +0000
Date:   Mon, 7 Feb 2022 20:59:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Matthew Brost <matthew.brost@intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        John Harrison <John.C.Harrison@Intel.com>
Subject: [kbuild] drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:2376
 eb_pin_timeline() warn: inconsistent returns '&tl->mutex'.
Message-ID: <202202072340.xZpz7hAb-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: 7CCWGH6TWF2TI3DB6GEQVJVUXUH6ZX2L
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0af17058-17f6-4bb0-008f-08d9ea63ac6b
X-MS-TrafficTypeDiagnostic: MWHPR10MB1310:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1310488DD48210978309C4628E2C9@MWHPR10MB1310.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kIHW94uxqzOeqG6L+Mm+e2cSFBWZ4zeABLC27Bqp3UAklxqzyKkdM05JmyHlzN6AvSfK7ttGbfCQjeIK7Iu/asmensT0EWpAXSQA3G1wmQns6hHEypYxs4/p0Fq+n0+Rmf3TMTV3XJyZY89dHuuy658B1rLPmfFa23DfCfyA9cJnuR+e7/6FRNwq/f5CiH4U/qS0ihz1uJiXAQLMnWlaxMHZxkQ9kw8M9nJwAbrnfzZ/mR9kVqKqofdJn6ms3oOHkNeKHlzLnFVfWKTk33vecxZ2dIBJnjKAgDZsezPBaR1rS1Z7JQ/Jc7aQqpYC+pVl7MgEr+lSIbd44OHwprbDb7uhwYYWeR0+tYYglOZjywdzfyEhlN3IhZyQvkgtSzlegIr8VzPCA7h1/MaI3aWjacuOYcxNfjS/L2VftwiWmSlYKgck7kqI8+ZsO0zvsHtCOcz9kfDticQynIYAVk9w01AmibJ5JPoDfzzN53I+vwzu2QfeI2DGfo+2BYVnhVWVuTK5jJO8C5nLWA6luKsZ5TIAaEK5ifFqIwXmVeOWlkjbbYGzM9+IwnvZQZAl/b6yxFSjQLiSynx9U1P/aHrLdYTzsS6V4bkyD6KuIuZ8OsZBBEKp+IgeXvC1V80VpdRMmC3UArxfcd39DMzEgur0dYKVsTIAX5kSGgJhdSZbTkYXJ2s2U8bqXGR2UTFxMMKvAfiGVdBY3Hut2Ygw61DR7WGdghD4TjacsdybSYMLY9mimh47Oqkh/zh5ezn0uafRm6nJbaxUN1DM7jbl2HlNhMkvvb4MjGxJIgkYkRtSz1bgAXu6jsB2q7+xvzP1RM2BW8WFd/FJJgl04eKS0+MFbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(2906002)(36756003)(5660300002)(4001150100001)(26005)(186003)(1076003)(44832011)(8936002)(37006003)(6916009)(66556008)(66476007)(52116002)(4326008)(8676002)(6506007)(9686003)(6512007)(66946007)(86362001)(316002)(83380400001)(966005)(6486002)(38350700002)(508600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?akBh0KT0Z7kaWoBZQKB0d5jDfbBqvZANrSFro2fTyWKPwtyRI7RlDA3jpOpS?=
 =?us-ascii?Q?D9htiNY8K1SFhYEPdiJix7qcqO9SqJ/OGs5SyfDYTogoXNvwSaDw1+MzDrho?=
 =?us-ascii?Q?IQp/jZXy0LOubPsg2GdFaoS5hjxiU+hUw/jCl26DXvaNTmtP1NVkJa6lWq2x?=
 =?us-ascii?Q?6ArWweX/6UHWTJMaI9HPkV5ZceE6+mL3+HQQk9lonNqaDRv6jNu7qtV4rMXz?=
 =?us-ascii?Q?qNeLmci7otTKkgklWJwZU/4Tk7uXiRVoZv7cp6C8/8zs/gTItZXSejCogeyn?=
 =?us-ascii?Q?L1dKfk76YT10iWNjN7b6HROW+4HYUxp2CWuD7eYfqTYYiRayNKFJK+VyguP5?=
 =?us-ascii?Q?0RyQL33BS+jlVBBXuFPd0e6gk32faz/BUNRfcxX/JrjTHahQiHu7rNITnARN?=
 =?us-ascii?Q?uigfhE42gDPiT72ccg4hNgZIXLz2NHOLI4BNCCzslvQEMcgQUubtMNJP1ZQG?=
 =?us-ascii?Q?st+aEuMYV/6GJ9bN/PhLEp8Qy/XUYGlW/MCSB6ziAc9qHSgqI1Ht3GdEQZZc?=
 =?us-ascii?Q?ihrbu0B1zAfEvTtyOa5P/cGN/1dZXDZQnRoLN60w7UDWLxEz+R9IlYu+dVgs?=
 =?us-ascii?Q?4h061DD69j11vUoJiuVNO6u4Vc/QqFkw/37O9E2rCY6g+L3vsC4sN7zHBr6x?=
 =?us-ascii?Q?SSLPH//vlw1aT8xQ/AWJsrPt94rfo6L4645jwYGX/Ri5x54WOKloEw2aNCjr?=
 =?us-ascii?Q?uaCso397PCfwOJZomRVzriNVmLiVqx71hK5kmJmbscg3aGRDAZP/pf3bdf3G?=
 =?us-ascii?Q?0wWzFPSGnfxz7DhjJojFS2u+k8dGEK2QDA42IGKCY/Y6T5Zu/w4EnRIe67KD?=
 =?us-ascii?Q?W1fGin80py6AIbmTBcFoWIykyFnldLWYVGtRj3UfdjNnulN2Q3awB80KP22E?=
 =?us-ascii?Q?Qo05CNKoQOTYkUhYJLWGQFK0rXvnvtWYGV7Wu1B5hdU5YLuNazjSRLP24KXJ?=
 =?us-ascii?Q?8Flh/3wA2U8XV/v7raD2jKf+CFIT4A3CJx9p8WFg3mR8VUzsTj+wKXufxznE?=
 =?us-ascii?Q?ohdf2H3l3v7DX5nUH+EHURkEWCChOLNkcee+HcAUb7/nbld+3WRn8SjUxS29?=
 =?us-ascii?Q?gSSz+ol6xdKnj2ezwahqBBHnopjnXDPIvD/hBd5j0wc0vfBafcHA5Aj5FXMZ?=
 =?us-ascii?Q?01WFRz856MMBoU3rtmTfoJ8De+2/5/jaJtuaEssFOxQDIt2mWxcf3cWS3dUC?=
 =?us-ascii?Q?28RpAP7+qw3CNfzMeNduqYUDhJmMOkMFQbb18r2P6D2SHFXpTgV6RASipHgk?=
 =?us-ascii?Q?LKv34O/3Qgnzh11JCiNzxsAQOVjQ/YFZnCTqMP/9jIL2p65bZJsg2/FZVNvQ?=
 =?us-ascii?Q?Pcnkuw9fOBVKNmrBWLi9U/mmZyxdP+NTW9evHpa8hA/5ugtRqTTVOa4I13MD?=
 =?us-ascii?Q?jtM6zP5XVbv0BJCd3dMZHavrx967YX0oIPo/nsC1OpEvY4iTAKbD+zepBgMf?=
 =?us-ascii?Q?NYAHDErd7CZe+rxpNnod/B7BMdbKgrJER+sc0CJCOHhaXb6WrxS0WF5J4099?=
 =?us-ascii?Q?VVZPb2SlfVrJOJ7V9QUJb0gYYata7+XVe+HuY/2vhD4+6SsqHDr2eIQOPmoN?=
 =?us-ascii?Q?55p+mPrRPnjTl4nxT7FcvyYUNL7lzBi1c3C8d+MY03xaMd4R/bPuTSetcUrT?=
 =?us-ascii?Q?vehODeec7z94TueCixLo0GXvgWoDClb+FK5W1xtDvOTFuWlW2TMRtPOhlncu?=
 =?us-ascii?Q?Ffd95A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af17058-17f6-4bb0-008f-08d9ea63ac6b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 18:00:06.8116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ZdoPzvTw7a+6IXljZ8P6nFFhj74zxiRKUbR/4relT95IvOLFmpoN6sDamDrNaqCFss8EZHGI+ihjpFOn0VXcmBO++vUJd9SY5xBMuZnuRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1310
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10251 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070111
X-Proofpoint-GUID: tSlwfqhchF0cGF_3FeYZSEbf-hTE7pse
X-Proofpoint-ORIG-GUID: tSlwfqhchF0cGF_3FeYZSEbf-hTE7pse
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   dfd42facf1e4ada021b939b4e19c935dcdd55566
commit: 544460c33821b44c2f0c643121303c3dc3f66ef1 drm/i915: Multi-BB execbuf
config: i386-randconfig-m021-20220207 (https://download.01.org/0day-ci/archive/20220207/202202072340.xZpz7hAb-lkp@intel.com/config )
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:2376 eb_pin_timeline() warn: inconsistent returns '&tl->mutex'.

vim +2376 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c

544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2333  static int eb_pin_timeline(struct i915_execbuffer *eb, struct intel_context *ce,
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2334  			   bool throttle)
8f2a1057d6ec21 drivers/gpu/drm/i915/i915_gem_execbuffer.c     Chris Wilson      2019-04-25  2335  {
e5dadff4b09376 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-15  2336  	struct intel_timeline *tl;
2bf541ff6d06f4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Maarten Lankhorst 2020-08-19  2337  	struct i915_request *rq = NULL;
8f2a1057d6ec21 drivers/gpu/drm/i915/i915_gem_execbuffer.c     Chris Wilson      2019-04-25  2338  
a4e57f9031ccd5 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-04  2339  	/*
a4e57f9031ccd5 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-04  2340  	 * Take a local wakeref for preparing to dispatch the execbuf as
a4e57f9031ccd5 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-04  2341  	 * we expect to access the hardware fairly frequently in the
a4e57f9031ccd5 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-04  2342  	 * process, and require the engine to be kept awake between accesses.
a4e57f9031ccd5 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-04  2343  	 * Upon dispatch, we acquire another prolonged wakeref that we hold
a4e57f9031ccd5 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-04  2344  	 * until the timeline is idle, which in turn releases the wakeref
a4e57f9031ccd5 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-04  2345  	 * taken on the engine, and the parent device.
a4e57f9031ccd5 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-04  2346  	 */
e5dadff4b09376 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-15  2347  	tl = intel_context_timeline_lock(ce);
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2348  	if (IS_ERR(tl))
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2349  		return PTR_ERR(tl);
a4e57f9031ccd5 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-04  2350  
a4e57f9031ccd5 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-04  2351  	intel_context_enter(ce);
2bf541ff6d06f4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Maarten Lankhorst 2020-08-19  2352  	if (throttle)
2bf541ff6d06f4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Maarten Lankhorst 2020-08-19  2353  		rq = eb_throttle(eb, ce);
e5dadff4b09376 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-15  2354  	intel_context_timeline_unlock(tl);
e5dadff4b09376 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Chris Wilson      2019-08-15  2355  
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2356  	if (rq) {
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2357  		bool nonblock = eb->file->filp->f_flags & O_NONBLOCK;
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2358  		long timeout = nonblock ? 0 : MAX_SCHEDULE_TIMEOUT;
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2359  
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2360  		if (i915_request_wait(rq, I915_WAIT_INTERRUPTIBLE,
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2361  				      timeout) < 0) {
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2362  			i915_request_put(rq);
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2363  
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2364  			tl = intel_context_timeline_lock(ce);

This is mutex_lock_interruptible() so it can fail

544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2365  			intel_context_exit(ce);
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2366  			intel_context_timeline_unlock(tl);

Leading to an error pointer dereference.  Maybe that's why Smatch is
complaining?  Hard to say.  Why are we calling mutex_lock if it's
O_NONBLOCK code?

544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2367  
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2368  			if (nonblock)
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2369  				return -EWOULDBLOCK;
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2370  			else
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2371  				return -EINTR;
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2372  		}
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2373  		i915_request_put(rq);
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2374  	}
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2375  
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14 @2376  	return 0;
544460c33821b4 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c Matthew Brost     2021-10-14  2377  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

