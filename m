Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162CD5618B9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbiF3LIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbiF3LIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:08:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB3C19020;
        Thu, 30 Jun 2022 04:08:15 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25U83dHk001367;
        Thu, 30 Jun 2022 11:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=TY+Ts4WtpkY06p+1OGJZYnqw4Gk82Qc9iFVduikqiIo=;
 b=jrCF3S7T+woia3WA4yG5vc1ALrADsith57BN4l1VHfEwhzWpmEGk99ratC5BGRNtvE39
 r26wpirgRb9IIR64Puav9NaPMfPesxNp6xnR2Zqqs9EbHCKib70axgIzJndMUb24fZM1
 0bMohXT3va3mLQdwi4JOoKu8R1Hi4FqJnU6O3nsisa3pFQxRrRNdhpSvdYsjntFdxUB+
 LgVgqZmszoqSKtbRd2vejvru7/+uznV6DZ1eTAFUC78sD2erPJVAHEZfQdGf6yhuJc/F
 7a5cbfIAisruzLSCFzAKv9+0henVx/gwUpOhzyv8oeFAiLzkjnlWj0YnusjfPfZgwsrz Uw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwrsckn9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 11:08:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25UB0Rfo037961;
        Thu, 30 Jun 2022 11:08:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt3x224-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 11:08:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2hheeaFb7t1E5+XAfFe+XcnCGEFuHqKd/ISpFbenuDOEcSDGCYFQpS7GKduo4vTeWTXjjQ7k6HUXvrpjwCZY4T4JCD2tupauuTpB5B00ZTkUcC7BT3IxWqhmd0SvyxZZgggcJ9bK8ujIAk31W/V9uVWq398jhWiG2i80VTfecCz8Ehi77pNHN5DFfXLJUNJRHs8FKfNrcaS0j6b1pkR5EKCPJiRnKKKGf9/iAYqodUlVfo9+iscsrxqsQWtPbfnDlO7/oN7mcIerhIvrLq/dysQJ/soCFhiXZKeC8VnsvCFr5KhtX4bmd3YmNlihfV6XBsLOLAq/WuvojrBXxoaag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TY+Ts4WtpkY06p+1OGJZYnqw4Gk82Qc9iFVduikqiIo=;
 b=eHt9w7BXG77+jLnXP4tkGZJC7Tx9lry2chY1VHZ847+/zAMhxlUJihatQRBosDEIGGMfzvzaOnSSWMlLYX/Z3n7M9Hx2JndJIv7QFLj5GvwRnuotEx3FqVz3Rl7j/o0ZQ9JbXs8hpsXl/wjmeNwuc2Sg5kmehEYbAt7XFGZr/9VmKMQorxygSa9PCFajxO6t3Wt7W5MvsWlJQkMZhUKRwXoR/gEyGDq28iB3TSAIxGoXE18fLY7+uHXQqPbNn5EMkVBr6876uTn9LKDPAcauFO5S0JqprH8wdPz5DW7ONkp9R9YYy65ERsi4oQa+SveRstWFmPZ5zTljo6bAjl055Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TY+Ts4WtpkY06p+1OGJZYnqw4Gk82Qc9iFVduikqiIo=;
 b=dD/isFtUQms2jjF500R93Nauo6uglw//MTi5OQU0Hr+hbNgE6Dyx954qy6X0Q0qWrL/6hjOv+X6F5M18G14QgYOTk7HLX5KxTUKF2kfpz49406SxDjPM/VzXDVDEoOjLqnN61pAo8pUO5RDYpj48ZSWsOR14Qq/iydMFiXqxBcg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1701.namprd10.prod.outlook.com
 (2603:10b6:910:3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 11:08:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 11:08:00 +0000
Date:   Thu, 30 Jun 2022 14:07:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Ricardo Ribalda <ribalda@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, tfiga@chromium.org,
        senozhatsky@chromium.org, yunkec@google.com
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-media@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH v7 2/8] media: uvcvideo: Add support for per-device
 control mapping overrides
Message-ID: <202206301144.r7yv0yk2-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617103645.71560-3-ribalda@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b1c7e63-2232-474a-8b16-08da5a88caf0
X-MS-TrafficTypeDiagnostic: CY4PR10MB1701:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7xfA+z2liTeLRBDNzt/GCgFBlISQvLRsph5DeV2PxcUfFppXrYjDzrZCiEyEIBKUPrYbWegWgdjodHl+a66dzPLBTCwgYbGy8kzPVLiDeXtx2lYkZc5O36eKoyUM1l8jogkRXeH5Gal8N6XAW9oMq3A7N0jJiw5eIdX1ymwAGB8fY7zrRlsODDI0sqbwi/8n3XkzLioYh/z89Vun7j7VbjxABh4WVzThGsaOpaniOKylxPf/XcoUcb6/blaZwF2rM4dcY9kLTj57hvz3gSIB/4ktOtl4rd0YjnLLwf+v8iqjmDnfZqhPH4yjHmMUET+lZg2SRI7AAdf3IVtOLsoopM7L1P9nQ5EradcLnLt4T5UrSLS+cjymF6acRvrSAZjvO0U3htiu65SPpHXT4Q0bxokwXWpTP9WhfpTUnhZF8T8gt0TFB3cRukYzm0AhZ4AhKG5NrR9pw0WCJq0Yw/KJNKbROL9p0aXstPatBIiF+b0nqXfj0vFNaMUErrx/6dCTvoZ7GPVo0HtUnAufmoCgjphrvdMEOPsMcuLmFGy2ij6SaqJ5P7iL+Lu7oqEcYXNKHXm63xmFVZGu7I5mh8RGVVJAhBsoqt1bXxNrUkU4LFrkuD5A15Iq4dpbHnlQQTMBgLCRddVT30m9w7po5kLuQbYlmFUaPVgKHNymYEt+wKDlDWDKGf/ozgLXlOH0MPeg5DobWkd+uPFUtTAHWWdaFYoe1l67qEwNn3f15UQvMnMMA44VJ9q1+Vo4S1/DIlor1UbkXpOLp/WgKVywGr5njQ0b61NYtCk2hf7NYb6JxELl8LBVmTnV/JzuLzXl175YAGUX4NBMjD/xyIab9MQOrD9Q0+HVVkyAI/fJglznIotiJJawYzyqc0hg97FiJbG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(346002)(396003)(376002)(6666004)(26005)(6506007)(9686003)(6512007)(41300700001)(36756003)(52116002)(966005)(7416002)(6486002)(86362001)(110136005)(478600001)(2906002)(44832011)(316002)(66476007)(66946007)(66556008)(8676002)(83380400001)(4326008)(186003)(1076003)(38100700002)(38350700002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dmahp1Bws3Yiv1AWjb9f2sB68gwyW+sQ7SlQKiJGpU7gto97r9T5OVd56+mu?=
 =?us-ascii?Q?fLYHnLfR97UjiYtOWAyPWs+3UBtG4P6JB8Ox5p1HR0JhqDjz/DclLESRRn3K?=
 =?us-ascii?Q?m1RbB5GURi8leqgxhTUgF1ZekepO3AembN5veHvCm16nQSWKKrqEWUBAKrLE?=
 =?us-ascii?Q?aYImp+Pd6D5t7dkHPrmlgJjJUI+utxuyt23uMebKwCvv3CJFY++nsi7J7FVW?=
 =?us-ascii?Q?F10GmHpHmZi4nO+AY+xJt/RxDqepEwW6WXJEwHqWguH3g7nITnCjKKcXtpTW?=
 =?us-ascii?Q?teiEBP7BNKQevtyfhjkkbhAfI6GD28otbfCRKJAj2JHbOoLXk3MErEQfgNFL?=
 =?us-ascii?Q?1eLpnrNBN53qdOGI5KzBLvAdeQKZV5zObMaL3FIHbGD5eD6mHzN4isaKwpJV?=
 =?us-ascii?Q?W1nGoLB0hlIu6JRtg4Zv2FK1aNKVtP4pDegzXFObb+gu0/N/abq9VIp9lVxO?=
 =?us-ascii?Q?uqcHmeFWrcnByVy1k/q+pKGJ9WERhTprWK6Od949NrsQR1lEcRdOl2Il2PtD?=
 =?us-ascii?Q?mGV3z+XxTJbsWIgRa+Y0+O15tz7LXGW7gOZQ+RRkwkjiNoKf85BX/31VR09+?=
 =?us-ascii?Q?XhsJqsmjTJfMZsGp+CsxRKVf92ugUbnuJD5+Ue4cOEKZWrgDDTMkdLABCNwX?=
 =?us-ascii?Q?OwK4cRYSWIlhygKuT81Ur+8+6+SsmYxAP3grsss3oBIjp0CZq8i5uheeLV5V?=
 =?us-ascii?Q?ST0dMpGvUN4EfQRevyNnijDGqCW4idiBAareEyMUNqSAN6vchEmZLtcyOB84?=
 =?us-ascii?Q?Wvg7cYMVt4W1yuFdk3v3lJ0EOut0CqMjC8pY/QuA3XqOfBRdGV4JAUYG1xtW?=
 =?us-ascii?Q?NbfmN/5UqYy7wNFBQ645dQjoF8+SmzRSSUPuUhA9Jv2gU81/h6oJhMMkdFzn?=
 =?us-ascii?Q?beiBfzx5oaUwDJG8evVRyY1BJM/VI3yGRlN3PLtAdUF4SE3d2zXIoKL6XtLC?=
 =?us-ascii?Q?qA3MCSRluwdFngC3697J8JJAnuqeIj45yxeUFE+gHPO8mJ2sBcXFpB9z3f4P?=
 =?us-ascii?Q?1VmxWxoPqyBlAIbLa/vespTEGVrdQCQiNzqFXOud5WKsZQvsvJz7frALkncx?=
 =?us-ascii?Q?yV3FkP+rMtCYdnYZFQAH1mocMInm12OlOQeVVM9UpzKE+eoJWRXPK4rEfFDS?=
 =?us-ascii?Q?HfnAN8xjOkpo8ysL9Es2plVbeZWIxsmRBLROMb0JGleu3cDHDCn6khYlYzI5?=
 =?us-ascii?Q?c/MCilIQRQ4icfyytVUxjTXixCJuKzB6cjGwsXJgghm4fpn2617y4BgXjIue?=
 =?us-ascii?Q?CQRtQlHgtCl41I8AaMMYM+qJ60eqBWi3zr7aeTLZz7gW9Z15HP0HXmvTR5nu?=
 =?us-ascii?Q?dfEnPW6x6c1bTy1U1D7wytWiRW3Nz+Uu8mY6X8L6qPBdrvbZN2r9dbN8gixS?=
 =?us-ascii?Q?8/cJq+KHB2ZUSQcBtEJYKvCPb6oXaUR0l+WV6dPGnGQ3pUvCIozbuezgClfH?=
 =?us-ascii?Q?FjfKg7PhublsjdLx9QrAYFWAAMjAKb4W+eWoP163n74qFW7Y2sx+aVesizM8?=
 =?us-ascii?Q?P/y3Z3rDFu69Cys1LTDYN7a5NoCQLPLNVqF9dmW8+yHkqY4HxAi16rHD3OGI?=
 =?us-ascii?Q?el3aDa8snA37fubo52SBOeuBfp2HH+oOcUuzzF70OAPviCiSyDtILR995g8w?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1c7e63-2232-474a-8b16-08da5a88caf0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 11:08:00.2847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3Uq6tJZuIHzRqsHppd91m4Un0VjIEB45/Z0RAkBJ71+HXtX/KxBoQkSxQ6/GEdiLSzr77EJG7TWX3+QjM3tAFhA2nPT8VC6Z2nvcuzfg8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1701
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-30_07:2022-06-28,2022-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206300043
X-Proofpoint-ORIG-GUID: lPIHa_uL-ycvhmZjmj_0VSCzBfmYpoS4
X-Proofpoint-GUID: lPIHa_uL-ycvhmZjmj_0VSCzBfmYpoS4
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

url:    https://github.com/intel-lab-lkp/linux/commits/Ricardo-Ribalda/uvcvideo-Fix-handling-of-power_line_frequency/20220617-185644
base:   git://linuxtv.org/media_tree.git master
config: microblaze-randconfig-m031-20220629 (https://download.01.org/0day-ci/archive/20220630/202206301144.r7yv0yk2-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/media/usb/uvc/uvc_ctrl.c:2459 uvc_ctrl_init_ctrl() error: uninitialized symbol 'mapping'.

vim +/mapping +2459 drivers/media/usb/uvc/uvc_ctrl.c

866c6bdd5663d4 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2021-06-18  2401  static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
866c6bdd5663d4 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2021-06-18  2402  			       struct uvc_control *ctrl)
ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2403  {
ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2404  	const struct uvc_control_info *info = uvc_ctrls;
ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2405  	const struct uvc_control_info *iend = info + ARRAY_SIZE(uvc_ctrls);
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2406  	const struct uvc_control_mapping *mapping;
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2407  	const struct uvc_control_mapping *mend;
ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2408  
52c58ad6f95ff6 drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-29  2409  	/* XU controls initialization requires querying the device for control
52c58ad6f95ff6 drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-29  2410  	 * information. As some buggy UVC devices will crash when queried
52c58ad6f95ff6 drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-29  2411  	 * repeatedly in a tight loop, delay XU controls initialization until
52c58ad6f95ff6 drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-29  2412  	 * first use.
52c58ad6f95ff6 drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-29  2413  	 */
52c58ad6f95ff6 drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-29  2414  	if (UVC_ENTITY_TYPE(ctrl->entity) == UVC_VC_EXTENSION_UNIT)
ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2415  		return;
ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2416  
ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2417  	for (; info < iend; ++info) {
ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2418  		if (uvc_entity_match_guid(ctrl->entity, info->entity) &&
ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2419  		    ctrl->index == info->index) {
866c6bdd5663d4 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2021-06-18  2420  			uvc_ctrl_add_info(chain->dev, ctrl, info);
93df48d37c3f03 drivers/media/usb/uvc/uvc_ctrl.c   Hans de Goede    2020-07-28  2421  			/*
93df48d37c3f03 drivers/media/usb/uvc/uvc_ctrl.c   Hans de Goede    2020-07-28  2422  			 * Retrieve control flags from the device. Ignore errors
93df48d37c3f03 drivers/media/usb/uvc/uvc_ctrl.c   Hans de Goede    2020-07-28  2423  			 * and work with default flag values from the uvc_ctrl
93df48d37c3f03 drivers/media/usb/uvc/uvc_ctrl.c   Hans de Goede    2020-07-28  2424  			 * array when the device doesn't properly implement
93df48d37c3f03 drivers/media/usb/uvc/uvc_ctrl.c   Hans de Goede    2020-07-28  2425  			 * GET_INFO on standard controls.
93df48d37c3f03 drivers/media/usb/uvc/uvc_ctrl.c   Hans de Goede    2020-07-28  2426  			 */
866c6bdd5663d4 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2021-06-18  2427  			uvc_ctrl_get_flags(chain->dev, ctrl, &ctrl->info);
ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2428  			break;
ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2429  		 }
ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2430  	}
ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2431  
071c8bb827c80a drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-29  2432  	if (!ctrl->initialized)
ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2433  		return;
ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2434  
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2435  	/*
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2436  	 * First check if the device provides a custom mapping for this control,
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2437  	 * used to override standard mappings for non-conformant devices. Don't
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2438  	 * process standard mappings if a custom mapping is found. This
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2439  	 * mechanism doesn't support combining standard and custom mappings for
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2440  	 * a single control.
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2441  	 */
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2442  	if (chain->dev->info->mappings) {
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2443  		bool custom = false;
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2444  		unsigned int i;
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2445  
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2446  		for (i = 0; (mapping = chain->dev->info->mappings[i]); ++i) {
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2447  			if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2448  			    ctrl->info.selector == mapping->selector) {
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2449  				__uvc_ctrl_add_mapping(chain, ctrl, mapping);
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2450  				custom = true;
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2451  			}
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2452  		}
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2453  
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2454  		if (custom)
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2455  			return;
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2456  	}

"mapping" uninitialized if chain->dev->info->mappings is NULL.

10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2457  
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2458  	/* Process common mappings next. */
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17 @2459  	mend = mapping + ARRAY_SIZE(uvc_ctrl_mappings);
                                                                                               ^^^^^^^

10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2460  	for (mapping = uvc_ctrl_mappings; mapping < mend; ++mapping) {

I'm surprised this made it through testing...  Anyway, the easier way to
to iterate through an array of structs is just say:

	for (i = 0; i < ARRAY_SIZE(uvc_ctrl_mappings); i++) {
		mapping = &uvc_ctrl_mappings[i];

87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2461  		if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2462  		    ctrl->info.selector == mapping->selector)
87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2463  			__uvc_ctrl_add_mapping(chain, ctrl, mapping);
87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2464  	}
87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2465  
10bdca4191d7a8 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2466  	/* Finally process version-specific mappings. */
87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2467  	if (chain->dev->uvc_version < 0x0150) {
87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2468  		mapping = uvc_ctrl_mappings_uvc11;
87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2469  		mend = mapping + ARRAY_SIZE(uvc_ctrl_mappings_uvc11);
87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2470  	} else {
87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2471  		mapping = uvc_ctrl_mappings_uvc15;
87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2472  		mend = mapping + ARRAY_SIZE(uvc_ctrl_mappings_uvc15);
87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2473  	}
87c205087585a0 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2022-06-17  2474  
ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2475  	for (; mapping < mend; ++mapping) {
ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2476  		if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
071c8bb827c80a drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-29  2477  		    ctrl->info.selector == mapping->selector)
866c6bdd5663d4 drivers/media/usb/uvc/uvc_ctrl.c   Ricardo Ribalda  2021-06-18  2478  			__uvc_ctrl_add_mapping(chain, ctrl, mapping);
ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2479  	}
ba2fa99668bb9b drivers/media/video/uvc/uvc_ctrl.c Laurent Pinchart 2010-09-20  2480  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

