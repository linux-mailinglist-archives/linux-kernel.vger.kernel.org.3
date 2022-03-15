Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2FC4D9734
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346402AbiCOJLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbiCOJLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:11:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177AC2E087;
        Tue, 15 Mar 2022 02:10:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22F8X0ie015146;
        Tue, 15 Mar 2022 09:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=mfT5VlHjwgmVi8HOcTUz/BacrAdvoMCS+wm9RBy8QSk=;
 b=zw0Mtfg9V3N283B9va/z4Q8MYCM7HnI3rVDIMdeWGgDdJdpGwSe2ELaL09+laTz6e2R3
 cUwWMSgWk734kLLfqiNXr78PBLn7hgDwdO9NQe0TJJUVp/Xad5ysK00lJKnT7JiSApBZ
 cEJR2B+b9xPqisY/02qBIMW0MTNhcAsO3ILWY9wAgdxWvy6m2P241Ozih59sJORvxfjx
 WtTfZOqPgjNZZzugM/HP1+Jm8Fc7TWJ3QIgyVU5Wo5edsy97TVc4PKWCQ7feKDlzRspD
 dWUZ+ToL8UuoTE3L8VxjXyfuN4g1R5KviqHKlofIth5jOGvP+eY+K7zayJi0O2GbdzdR QA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rjjea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 09:09:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22F90vul109973;
        Tue, 15 Mar 2022 09:09:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3020.oracle.com with ESMTP id 3et657djj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 09:09:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfIY3rdhK/g80zbjeHbxlFu9wWmmRsJc8IKgyH8GvPRM/vTfifcZql8R/7FzS3FDEi7ktdr2NKeAxR/15539mP/WeMmV+PyxGlH9buo3Z5rX2K3rreVdU+AtQY+aDbdaITqldthZ9oG7SKi7/RVvjwXMzYvElzkT2DyZ7DsbomXXjsVj0P715mYc2BGV7C8Glh7v/bMZ1WQxb68DEeEo4hLqGHxGH2CImSve7mpcvZhVkGdkaHQkClYK5yRWpez98GFORfnWOtPdJP7c3prsGbos2yFX035ZFrQHFgUNvWZeUsrpi277W8dxo6v2+xoP3kR4Qu4gUyKZOgNKNiQX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfT5VlHjwgmVi8HOcTUz/BacrAdvoMCS+wm9RBy8QSk=;
 b=axe4y+OBryOquSIa1S5h4UKHjnRzxiSh+fXfXKeS7QnmpWZ6do2YuJMf2Xz7va8+Zxiy22vr4CBfaddNUA3gtbVccknvusru12b6bhU5BIP+ebEn1+DOU6RC86eKClCxlaDjazT3lKafTw3GkvWXxdxCCU3EiCtubetmdAvCRecojbjxjEDyN/R5JC5rpG/Xr2OaJumEUiRDaZjnmUo4fgq6TGOdx232DCUf7gFawf3ZevS+Su4B94NHH1XkHJGySEzT8rSsVopzj6nRyiHG9eENqhwQC7uIEdizJ+SRJCiorjfI79gH0plQ82H+OAcptN4iIP5lqZCsjvGhJ+E7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfT5VlHjwgmVi8HOcTUz/BacrAdvoMCS+wm9RBy8QSk=;
 b=S5e1KATc92T8TP8UxxUU6NeEWWNvL/06HtxQRAD9VZmOAea2KqEnwi4PVJX0FyeoCNdhcL7eIFcAfivrFkXnyde3+bFceAEkkiOYcwYkC1vAqLk/W/ZH+txb4sfRazI8RKEMHnkdZeos2KCBhdHJugzLGNdMjAIQo9mid/POACI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB2608.namprd10.prod.outlook.com
 (2603:10b6:805:45::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 09:09:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Tue, 15 Mar 2022
 09:09:53 +0000
Date:   Tue, 15 Mar 2022 12:09:05 +0300
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
Message-ID: <202203151010.lrgnt9Tm-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::29)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 835edbc1-f238-4bf1-94bf-08da06639117
X-MS-TrafficTypeDiagnostic: SN6PR10MB2608:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB260825B12B123044907FF98F8E109@SN6PR10MB2608.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltwYBNrEHkHqlV0qS1OGgQEh9TIsw03JCn8yECrpycs76P7hurE+xOk1HvzX6H6FrZhX5RT9Ld0TdGxvNsswlXpndhg3Ez7ogB5IBuSERq9QiN8Dnq/8/dTl3bLtD7q9cs85v26GlqE1F2lsUkGFewaOhKs0qRo87s3AE8IWY+BYqVK8sqJpR+fHVSFDyz+LAqhdkE6c4DVO2ZX7B/YPLgDPj24VH9YF6CYNceGpqUea0SAWCw0ai/qVaepPaGnfBgLvPeKnGrPQFkRf7NA/xDAxsbzE3nh1Oj9rMPYYumeIYH+BLc1urO6d3fh/ZkEfZ6ILG/2+FtgdcxPFj5TkqfFEmMjZeDbPIrCWd4zM7p7fBhDSeq9ae4y9OxUMSdLQvKlF2/oWYC3ryd/cUbHE8pegJm/5J1MJXrYGMJoRl8LncVE97smTcMuv+W1Y2vWz6NItsRrN8hiArKbUP8c++wLJByPGPho4YVMax1BbT6N3DSqZPfieNletY302QXDu1EQloMLZqcSEvuXJxIcqxLaoBnbQPFfVTr4KGUaPiDIiR5FuioFfMCkJrutQHKcIC92JqTDMp6EiZdOezTEPamJai/iodcUcEg02p6ts2KEDxxXy6BamvqijYo7mBvhiYKNOUENsqo1SQCNtwI7kpBANCsm+UxUlVyAg7FgGmtxnJDEufF9/bXWga51Gapq/DTQJq+jttUu6UCjEaJCZdSDBt7gRBU0YqctfGQbeKxTqYL3bc7VZpJrKFnegG4OFU1kTllHLhb98i9TLU1LZp/Z+WVAuzviQ0VzIuXiRaKF083JGsxtyXXYhzRhnZ4LgaQvwcA0ZGy+KbGrpiJ25tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(36756003)(966005)(44832011)(6486002)(5660300002)(86362001)(2906002)(83380400001)(8936002)(9686003)(6512007)(6916009)(6666004)(6506007)(54906003)(52116002)(186003)(8676002)(4326008)(66476007)(66556008)(26005)(66946007)(316002)(38100700002)(38350700002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5F7LQ+hhN1POdW8UZ6Bxj8rdroGqHJjJMJ7hxyYlqT5UNWsmiQH4FRdreMxH?=
 =?us-ascii?Q?r4REq7KNMizX7ilysJQgtnjPQcLkqrEEvYuKuMHjIqmV+KGX+Rc2KFLH20XF?=
 =?us-ascii?Q?A1GsmauZnC1mv5/WBF78MSuVa/OUsOQi7RjIdiLbnAr8pOTHwsb2yB7jLaxh?=
 =?us-ascii?Q?N3ln7Gx410W/Rv/RQQ6mC4i+xkJxavZFo4e1NZdjXwy5OXdkKuezITf6Sdso?=
 =?us-ascii?Q?zL0fU07wSToZ25cXo4kyzmJLPg/z4QExnoSG+iZOD1KdMkFYklw8Njo/Hro/?=
 =?us-ascii?Q?cIjQu6Mq7O8B7vkw+XWm071W/eOQpTXGdRbOxbeUj7+LEKe7dw8CWA+whO7q?=
 =?us-ascii?Q?Vgn8D7P/bqnjC3GteYDGSwFTMwUm82m+pJqQkt5br3mRPaz0pSbTbFp3GafY?=
 =?us-ascii?Q?rq0xpSzo5zpb30+Aj6b5s/IUvaG00MqS2QDXWFU4w7EXK6jv+EdW7pWdA9Ci?=
 =?us-ascii?Q?IsVuk/FjS4l4/X0lZUdBOn4ly2Gd6tqTIYj+P3T76JbjIswjjVrvsageH5qm?=
 =?us-ascii?Q?G6v0fCwFeRRxl+lN6j+t9hi35MCR6OBNhPZUzkYhHgv0zZFvF2yNOfm9+iyK?=
 =?us-ascii?Q?efQN7CG0psTcDQRPOM3SHcEmDV/05Fc+tBmblcPGeERURHXYs/aLhokp0LAc?=
 =?us-ascii?Q?DC/vCH53EbaWArVSA9yqLSrt7A4XwD0/k1l7KiseDeCv0UVyLFID9wdDe9gg?=
 =?us-ascii?Q?MECAaom+P9BCiFhbY+C5EtBkYbhFE4Yr6CMOqep1HOubriDFXALjo8M2p52H?=
 =?us-ascii?Q?QIysQIqP2bbM/53A5BRR8VQs0gWqnZJQQ6qPbRP5cKtIMn3hYKgYK6Yy68sL?=
 =?us-ascii?Q?7bf2B58970NSod7dYNOIJuLMqb51p1iD5MMzEYpKyL6R/eo3ixBnVS1uEtc4?=
 =?us-ascii?Q?BZWxUWfW5nmyxpK1dFDrQAg/lfK30BkzxirZhd0tL2schHsBjA6nj7rmH96J?=
 =?us-ascii?Q?bz//BKv5V2r63dVtF0iujPp+A3PtueKOaBjfBdJcUcotpvepWRoMQ/s2MqZa?=
 =?us-ascii?Q?EJ0P2OrCbFqLTXhucrhX84KHnsIvPAsrYhcPOp8Uq+62LWyastQy4vAKOCu/?=
 =?us-ascii?Q?WZ1iptADZ6R+ABh7WW9v7wl3UGIdMTiQu6hGze+WZkW7+wGgehRBMhNavFpB?=
 =?us-ascii?Q?7Wf+YuE/sbxztUQrON3tkk0AjiZ3KUz1TveLH6zBIVtNTRK2R31zu5DhsgPV?=
 =?us-ascii?Q?rFQAaDz/h7YBI4va2MTo8or5tEQc3swEg3WT32fs1ZnIwylr1pHn6rrWFrh4?=
 =?us-ascii?Q?6TN9p8fFaDQuhSrneN8iY8mWlnfSF5nrxKzYVpt+/tSaSy6NE9VT94SPb7BD?=
 =?us-ascii?Q?N6MGRvBxsinJTWNw4bLl6Qsf2E6NZeqwUJy9sdkgKhEOLMnU4j9bB1YKpyFG?=
 =?us-ascii?Q?qgkBeQhlgwyjF5kT1/UbUsu7BcSxItGxTAcXmgZXS04qVpnJwWShM5zFtPuu?=
 =?us-ascii?Q?yHKeD2/mJBPDdJuhGwpwxsJ12Jf8A1WrKDijzd9czufvceTBMhSX6w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835edbc1-f238-4bf1-94bf-08da06639117
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 09:09:53.3523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgFTlUzAe8RPUiX+2CuRVeZRtMCoYS3dSNCq6yLgBa8ZCtobpibxH58TdXCFzm24v1G//TUd0MKGJF58lPJTPeOwg4gyAZeMsSClUzKmSvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2608
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150059
X-Proofpoint-ORIG-GUID: hm-3uNdzMPHvU97ZMRKbakYoMgT8S6O8
X-Proofpoint-GUID: hm-3uNdzMPHvU97ZMRKbakYoMgT8S6O8
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
head:   09688c0166e76ce2fb85e86b9d99be8b0084cdf9
commit: 16545aa3dee5a01f3f42aa566a051096c87f4b6f media: venus: Set buffer to FW based on FW min count requirement.
config: microblaze-randconfig-m031-20220314 (https://download.01.org/0day-ci/archive/20220315/202203151010.lrgnt9Tm-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/media/platform/qcom/venus/helpers.c:627 venus_helper_get_bufreq() error: we previously assumed 'req' could be null (see line 623)

vim +/req +627 drivers/media/platform/qcom/venus/helpers.c

af2c3834c8ca7c Stanimir Varbanov 2017-06-15  615  int venus_helper_get_bufreq(struct venus_inst *inst, u32 type,
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  616  			    struct hfi_buffer_requirements *req)
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  617  {
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  618  	u32 ptype = HFI_PROPERTY_CONFIG_BUFFER_REQUIREMENTS;
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  619  	union hfi_get_property hprop;
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  620  	unsigned int i;
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  621  	int ret;
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  622  
af2c3834c8ca7c Stanimir Varbanov 2017-06-15 @623  	if (req)

Hopefully we can delete this check?

af2c3834c8ca7c Stanimir Varbanov 2017-06-15  624  		memset(req, 0, sizeof(*req));
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  625  
16545aa3dee5a0 Dikshita Agarwal  2021-08-10  626  	if (type == HFI_BUFFER_OUTPUT || type == HFI_BUFFER_OUTPUT2)
16545aa3dee5a0 Dikshita Agarwal  2021-08-10 @627  		req->count_min = inst->fw_min_cnt;
16545aa3dee5a0 Dikshita Agarwal  2021-08-10  628  
7371093f983d35 Stanimir Varbanov 2020-08-26  629  	ret = platform_get_bufreq(inst, type, req);

Because "req" will be dereferenced inside platform_get_bufreq()

16545aa3dee5a0 Dikshita Agarwal  2021-08-10  630  	if (!ret) {
16545aa3dee5a0 Dikshita Agarwal  2021-08-10  631  		if (type == HFI_BUFFER_OUTPUT || type == HFI_BUFFER_OUTPUT2)
16545aa3dee5a0 Dikshita Agarwal  2021-08-10  632  			inst->fw_min_cnt = req->count_min;
7371093f983d35 Stanimir Varbanov 2020-08-26  633  		return 0;
16545aa3dee5a0 Dikshita Agarwal  2021-08-10  634  	}
7371093f983d35 Stanimir Varbanov 2020-08-26  635  
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  636  	ret = hfi_session_get_property(inst, ptype, &hprop);
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  637  	if (ret)
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  638  		return ret;
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  639  
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  640  	ret = -EINVAL;
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  641  
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  642  	for (i = 0; i < HFI_BUFFER_TYPE_MAX; i++) {
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  643  		if (hprop.bufreq[i].type != type)
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  644  			continue;
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  645  
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  646  		if (req)

Delete this as well?

af2c3834c8ca7c Stanimir Varbanov 2017-06-15  647  			memcpy(req, &hprop.bufreq[i], sizeof(*req));
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  648  		ret = 0;
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  649  		break;
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  650  	}
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  651  
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  652  	return ret;
af2c3834c8ca7c Stanimir Varbanov 2017-06-15  653  }

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

