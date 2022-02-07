Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADA54AB676
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243076AbiBGISJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244263AbiBGIQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:16:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DA3C043181;
        Mon,  7 Feb 2022 00:16:22 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2175jOVX007408;
        Mon, 7 Feb 2022 08:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ewRqSAhtxtVPBb/oQWoNedGECHJzBZRRq/TyozCvciA=;
 b=x8xEpAN1aeHFiE27f0P5NxL9nvV31azL0szI79prxMGZbvEMMGPk6eTFPrd2ttqbSUbz
 EcqZCC6SfubcFf44zyGugwCZajseG6eOEDfZ6QWbd1ujsH2Kgw15BcItKsqgMo8x3Eg2
 bN9627Ks+7OtsRZCluqaY6Zrrc49zqRJubEb1qUDRlJb2eQrEj2Bo29xjfSRGBEvPGPp
 44GhVniuBSt9IPmnT1EMhV0Uwmwu/fZqLtl4FRUxcrWOXIw8pTvoSv62ToT1hMSjXfbA
 BO6ARMupoIczlCbaZVckz1yh+49ftyGU0tf1cCtkS421QVdOZv3HnZzoL5fT/oBDsJlL BA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1gusw8t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 08:16:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2178G1K2132413;
        Mon, 7 Feb 2022 08:16:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by aserp3030.oracle.com with ESMTP id 3e1f9d1fnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 08:16:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvKUABL5z7ysJ0PMhEdoFWrfRByraLJSsuPyosfbyAlufzLa4xQxJdwEtjzX0rU9iodGHAY5mBxB9KnyemOB1WL8oIk4ewB6ygtrovwKlVjxlP9q5BLonapE5INxHfZ5p5TSinYhgSMLMcEemyBMnw9CLWsN63Y2WKPvI5SOzL1vs8iH2Iq4pRaRBaK1f6l69hoRmea+FgpJwQEThkWUa+1mvh2eYNaiK9nwCU5LADdGnbmOgYiKMwFwxzRiiepzsLe7zPrc1gfTg8OhGNQMmwEszqesEmnow4+8pPflMu/3TQokkxRnxZ6cu5l9LHZ/RW3G3U6G7d9VFsj/KOHHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewRqSAhtxtVPBb/oQWoNedGECHJzBZRRq/TyozCvciA=;
 b=U1CaSY7dEJpo0PsJqkHA2/ei3qudPjJOXP/RvhebVRmBZrfBN9kMJqeRlGkogK7uG4JKYppSQCVma45l1BZBTgFy74oWnZE48KV1SiVTg/OQk00CPVGCDWPUbKS63JSN+AyOfrrzE7z7gipcLwdzdV2qYb4UQrECMaAWhEBe1lCOY/tErmU2pfYb0HlAnZcKLPQXsHVABLrmywS7NztXLs/gaYktbQsh4Y2OUhJEjs+GoQ3qpGWR6L1l02RUHQRzdnHuEz3knD+pw58GsYdc8qox/yBc8eoOgjkB033FeLBYR+eOxwWYPycuOu94Ios4HImWJo3sAptP9VWUDaWK4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewRqSAhtxtVPBb/oQWoNedGECHJzBZRRq/TyozCvciA=;
 b=NgTI4WKXaC8lehw97Q0NVbTQ5n2tz+U8X8ZnB6J9MYiYE65DUGQ7j9lQvPaXA9hU64oVDrftsfcKQn/fsLxVN/hTD9q0SjC1yI3xJwhqZQjrqlOQR5ySB0Z32L6d8sWicmb3+ph37GTDRTtImiL0FQk5ZFf9J0UAmbHCu0pI8AY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4517.namprd10.prod.outlook.com
 (2603:10b6:510:36::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 08:16:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 08:16:10 +0000
Date:   Mon, 7 Feb 2022 11:15:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Dikshita Agarwal <dikshita@codeaurora.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: drivers/media/platform/qcom/venus/helpers.c:627
 venus_helper_get_bufreq() error: we previously assumed 'req' could be null
 (see line 623)
Message-ID: <202202062034.T1pUQtL9-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b05d10b-970e-4e4d-7a07-08d9ea12194f
X-MS-TrafficTypeDiagnostic: PH0PR10MB4517:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4517041F5AF8A79D698598808E2C9@PH0PR10MB4517.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7SoBVgTGEqw/0K9SLbzWdyAOUnOGf85CGM1Fz+f+1JcFlwkC90H65un5NDEqtQoxSjSpgc5VrhUgUaftuDjNkXLjp/KUj5y+jOZitTlVbRc/PM1klVOahzG7xuAku9JrtFd13JkqW8hN12pXgHGUGolVxlgBJUIhP+rfKIMR56bI4xRlaBYeiOEpxbxArhsA8UW5L0V6tBPpR4iliak4enlnDWaVYwkwRB1Key9IrxpxGZDwSyJtzSFFayiKRPocYFy/pmHSSLIbmXTH8Wa91GnW1t7cob2HM30PhZ9wl5UP5oE7zCzOPIxNtHygrOcsof8Nta5SIT5TBCpvX78O+yr6DaFuVVLGKjRAnQYud34k02MrMQs1qKDDPWdEaLXqwfpyM8rQUEyi5vHKI74JyeziH+R9+E0/1beWSENLE0rGTfRyKxMKk4PlZhovK9KO668UFRnNcE+n6BNbUtu0ganvMedg8AW/d5tohgZCW+DSQH5k++m5X+pBzvuWOgsUpQcHLmJDMerRaZXl5QphDzjj+MhzHzfPdLwGerK1yUwF0i+V/9CqHPBT29EYjjeZDq6a+p/iTPRQF3nQt2Fv0Cz5yrN9cemPgcD0qS0K2y1sVU4ko04JVRLZkZdYwus2FUITuwrPJrgINVpDzQdtQZhJyvH6PKbifrcSVAsR8hVihUjOYQ9fLgQZR92qgKkWrlTDBlqyAMqlwIjPtjXaf2yepLVseHwT8ltA0RlA+zc6YMfxX9bitj7yCFvummK6vnVYM0vGtfMHEVig9XruqadfuTTy+V4y1SbbtSzMPFWjIDm+IH6uJWrmeD09juno9cGiS0aQDenCJwWLkrpyow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(44832011)(2906002)(86362001)(66946007)(83380400001)(66556008)(316002)(6506007)(6666004)(4326008)(66476007)(8936002)(5660300002)(36756003)(8676002)(6486002)(1076003)(966005)(54906003)(186003)(52116002)(26005)(9686003)(38100700002)(38350700002)(6916009)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vm0Oub4xH+ugs1j7TfY/w9IA7eu/5ZqqsWzt9iPbpi/ORTq3tRfxk3wiD2a1?=
 =?us-ascii?Q?QwbGS0+HIX3Uy7toYg89lnrwLFKuMIuhx0yCe6srcH0Vr+UdMrN4+7yhKdO+?=
 =?us-ascii?Q?IknQTmME3cOdrElFkBUQ9qSXifcNgtRsDwIGXAhm6+D4aJmEmztZ7gVXh90I?=
 =?us-ascii?Q?xZTqIASLH97AAbDJkEfzOcqML0MfKCwjfGtTVdqQQTsBvzK4v8blLGRc3122?=
 =?us-ascii?Q?RCaOU1Zzd+dqpCPOWj1YasWYhC9o7/esQww8MVhOWH2OIv7XJ1f/SO63u4NJ?=
 =?us-ascii?Q?MCpffRxaq4csgdtsn0j18S91oEyYL8/NDk6ayxwRwdcngviMWKXjmWxpBQt+?=
 =?us-ascii?Q?7WdtFfvvcq6yCAiCGLoQbxBXbFE079M8M+UZYuNkzU1gQCfEuTcbmBHmPdU1?=
 =?us-ascii?Q?K+oZtwAmlK3AjJLPO2esviF93q2LRmWIjDetVcxA/oFoZtx/Ai7ERCPJ3f9r?=
 =?us-ascii?Q?1gVj9gYtoHegDikZKa4pT9s2XSULHvF23snGVxfe62sfaceF5ifPqpj30cli?=
 =?us-ascii?Q?GtekioVP9uxa/k2AndwsLL0hO268EYHY/tA2mOGudBbzS08SSePlSoNVUClm?=
 =?us-ascii?Q?SaEtyiiKDPt/mAI8qkCQKd9H0FTATT5aboVVUOqbjACzaRPDOJAIumg3ovaB?=
 =?us-ascii?Q?ixhT/AmU0XRxr0f8p+p77HCPCix/BpzEsWzf4d4eVqnuvPqLJ0A3lDO/MDPd?=
 =?us-ascii?Q?pjmdrA9bH2sK06CXTUCHZxTl4xQc2YQ0pUSYvgKVNO+qIk81RR5AFsHwoRsm?=
 =?us-ascii?Q?ph4CEqp0YZsULQ/Pdbwmt5MiKVeUSvan5xsflmX5eMdY1yOmbk4Yh+QLrBLy?=
 =?us-ascii?Q?uYAEp7iJgXRxMx2Hzzgkt28RAiVECdVSLoXaLjLfopTpuwyRvQsJkK7ydmlA?=
 =?us-ascii?Q?YcVr0c9r8FD7gZPW2OiwqZL8JcHloyFrK0yPBVLbLQIKi0dmn5s7DPrOli5m?=
 =?us-ascii?Q?5F1gUL7rHA3WWR9Kcd0rDvr2Ly9o9OCT/Xtz6vfkPnsPn7O0UEjQO1ckOFQC?=
 =?us-ascii?Q?KA6jpcXfII3QPr7V/7Bzdj5JBxSfd41BR5V3aXMJER5REpe/HHm2Hy95rIJ/?=
 =?us-ascii?Q?ETI11xN0izZd3HPm3Se1Uj015bSuRlWE2x/Q5RXlhERh+sjirAjQWpTIPut4?=
 =?us-ascii?Q?ylhMcgD8Ywv5Uotb47wzb3Sk89WTknqlB29GsL+gd3KZ6/QflRNGyW15L3Do?=
 =?us-ascii?Q?yuer/68HEqF1nn50vxkDI7iVbDsNGsyRN14NmHWT6uTCih8hSh2HMwJpKQOg?=
 =?us-ascii?Q?KBRZidHHYfX5nHsiQvIAgH33iacqapPi4EsHPIGB7I7oEnEvWy6WjAuHRHgm?=
 =?us-ascii?Q?nyqiceyifakwk8sCj739yJzXXa0cmQUSkDTRrTJF8PqKzCGoWKYLS6RLZdjE?=
 =?us-ascii?Q?k3jR/w/G+TSdgLL9kLbd0ex9Kk6B+Ag1Q2baflneuiHp56qKFKPM8VwX7BnL?=
 =?us-ascii?Q?85giVrNmuRUdVevGgGWIfKBP/FaRv/QnWj2YteNWUKnC35D4duSIImh5wGdk?=
 =?us-ascii?Q?GNh91VrSfJSVC1O5XgXujoa3Nh6cfME4Bp9KvoB4CH/+QF1mTDmUyht1Bhhw?=
 =?us-ascii?Q?VcINblJ5q7wncYOaUoMbYjPi01PyYJAVhDtHtKJSHpwxL6YnS/UP8uAm39gy?=
 =?us-ascii?Q?VCy0Yfs772cjceafoDBlObqJ3uHudsnhhLDTbnHGipzL32WSDG9ttlq7TfSz?=
 =?us-ascii?Q?tlH1DQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b05d10b-970e-4e4d-7a07-08d9ea12194f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 08:16:10.6304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OJIRhIYxH9g2qJVyHpwVbLvjHMum8y4Kfc3FR2l70bU7pddL9z2xn5qvJjCs//9fUllz3jdaKjfGdHNrnUdRdQGS42g+Z7kufCs/5BgQck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4517
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10250 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070054
X-Proofpoint-ORIG-GUID: b-SaDU2VY4iZLF6pVxbpy7OKSHZUlkz_
X-Proofpoint-GUID: b-SaDU2VY4iZLF6pVxbpy7OKSHZUlkz_
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   90c9e950c0def5c354b4a6154a2ddda3e5f214ac
commit: 16545aa3dee5a01f3f42aa566a051096c87f4b6f media: venus: Set buffer to FW based on FW min count requirement.
config: microblaze-randconfig-m031-20220206 (https://download.01.org/0day-ci/archive/20220206/202202062034.T1pUQtL9-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/media/platform/qcom/venus/helpers.c:627 venus_helper_get_bufreq() error: we previously assumed 'req' could be null (see line 623)

vim +/req +627 drivers/media/platform/qcom/venus/helpers.c

af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  615  int venus_helper_get_bufreq(struct venus_inst *inst, u32 type,
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  616  			    struct hfi_buffer_requirements *req)
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  617  {
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  618  	u32 ptype = HFI_PROPERTY_CONFIG_BUFFER_REQUIREMENTS;
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  619  	union hfi_get_property hprop;
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  620  	unsigned int i;
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  621  	int ret;
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  622  
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15 @623  	if (req)

Check for NULL

af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  624  		memset(req, 0, sizeof(*req));
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  625  
16545aa3dee5a01 Dikshita Agarwal  2021-08-10  626  	if (type == HFI_BUFFER_OUTPUT || type == HFI_BUFFER_OUTPUT2)
16545aa3dee5a01 Dikshita Agarwal  2021-08-10 @627  		req->count_min = inst->fw_min_cnt;

Unchecked dereference

16545aa3dee5a01 Dikshita Agarwal  2021-08-10  628  
7371093f983d35d Stanimir Varbanov 2020-08-26  629  	ret = platform_get_bufreq(inst, type, req);

I looked at this in linux-next from Friday and I don't think
platform_get_bufreq() can succeed with a NULL "req"...

16545aa3dee5a01 Dikshita Agarwal  2021-08-10  630  	if (!ret) {
16545aa3dee5a01 Dikshita Agarwal  2021-08-10  631  		if (type == HFI_BUFFER_OUTPUT || type == HFI_BUFFER_OUTPUT2)
16545aa3dee5a01 Dikshita Agarwal  2021-08-10  632  			inst->fw_min_cnt = req->count_min;

Unchecked

7371093f983d35d Stanimir Varbanov 2020-08-26  633  		return 0;
16545aa3dee5a01 Dikshita Agarwal  2021-08-10  634  	}
7371093f983d35d Stanimir Varbanov 2020-08-26  635  
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  636  	ret = hfi_session_get_property(inst, ptype, &hprop);
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  637  	if (ret)
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  638  		return ret;
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  639  
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  640  	ret = -EINVAL;
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  641  
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  642  	for (i = 0; i < HFI_BUFFER_TYPE_MAX; i++) {
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  643  		if (hprop.bufreq[i].type != type)
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  644  			continue;
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  645  
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  646  		if (req)
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  647  			memcpy(req, &hprop.bufreq[i], sizeof(*req));

Another NULL check

af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  648  		ret = 0;
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  649  		break;
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  650  	}
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  651  
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  652  	return ret;
af2c3834c8ca7cc Stanimir Varbanov 2017-06-15  653  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

