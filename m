Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B744B2FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245147AbiBKVpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:45:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiBKVpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:45:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE7CC62;
        Fri, 11 Feb 2022 13:45:48 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21BL0nub006473;
        Fri, 11 Feb 2022 21:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=CsdUgANCX02mnlPuMoGl52TFOPxrcGVT2RPf7h/KDjw=;
 b=qmO++lc8QF+/6jGsw8vpw1poLRYFQLXQAI2gamJsDlNipmAYN1l6U5+FFyfgZaw54F3l
 qnRV3/EIcsM/AjnUM5g5aUnglTQ2izhWtPfNXTqZirTydcE1AO7xLgffHs8mTgXvI/+z
 ZnxRSqawgRnjKadrqgodAsmzza5xQOxYWmYKl40FtHhTPhj93SOeKaMrNY/FmwjTgzpJ
 slgDjKaN8TiWURrRDnmHYDsxhii+lvW2bji8u6oV+XTQFwFXs5x+KuspjTsvmeE8PeFu
 odG3w6QaHrjDh9ULZsOpQpMXQnwmPp54o7LH1uNxZKwTOIHNDjmcLbNPf9+2PQI8wwNI AQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e5t7kryxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 21:45:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21BLWHeM172248;
        Fri, 11 Feb 2022 21:45:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3030.oracle.com with ESMTP id 3e1ec83eyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 21:45:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzhMCLSgrpdus2ZUyu7SDAfXGl41SHTMNWu1ShrIjxke/MFBGJO6MMbB4bGwQjqel/4DJO/85PnV1M3NmsLWn87nHS8/CtAv07IcdusPnQtE/8T89D7tWJQwd4ybrcZ1Jq+8CJpvRAljO0qyAKHtp4TvVGoSfzHjOU+dcBfcKSE67cHqHYq+mmlr3J6/uPy91Jfy4xJgcc8p37IuJgFe7biLDyrOkp/Jr7s5VR/hEE20uP24LliHdwy4KV1QmDLXh+H3ufCsa8b+7CvQbMcTs/HCzBaPR2Ue+fb5iqpqq8W5S7jHeROSwjDz//qCpUbVCHNI7PjenANQYIIjripKeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsdUgANCX02mnlPuMoGl52TFOPxrcGVT2RPf7h/KDjw=;
 b=M8vBmSIY+Gz4bHAUuBcpYKx2K53EFPKGkSgS7SRcj+BPO4Jz1J+/+sL6+0jl+y3fXuQ7UxStgq1hx523Xj+X2WdJH2I3z5gYCMNANdUGZkOGO8+lF44aDCooXL3fPf3YWyWUmhDX0VzoFXm1MuPwFeG9gM+mOKC1BFXvci1kQucOhPRD4CBnqxc0FHPfQvnY2PiTIWWY6c6Jditmbf+28bpX9fQfXmR6GJhdmXnP4x9QVg6MMvb3XlOgCNiTe258ZjDmvyiLK/S7sCO2Ld9smJifMr8bNZyO/mzq0jFJTC/yqcI1dmy020ALFjoa1jbmXsvdrMDpAW07FVzIRnHXdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsdUgANCX02mnlPuMoGl52TFOPxrcGVT2RPf7h/KDjw=;
 b=P1PzTh0mh4ToRI7VSnU1Q0zYi/mKjuTVni/48tduyKRh1i+LA6NCmpQBXMDmStDwzj9mQTh6aj1K79Ik7nDacnZdu7s04s+VP5pQGZtczZk/4CzFgxJPSfI9gnFRmh0HUBJmTgnatgAzMFiu+Mi+bEMiqBVIYOGfEcJrjQVmunU=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by MWHPR1001MB2112.namprd10.prod.outlook.com (2603:10b6:301:2e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 21:45:38 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::40f6:dc10:6073:2090]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::40f6:dc10:6073:2090%5]) with mapi id 15.20.4975.014; Fri, 11 Feb 2022
 21:45:38 +0000
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     damien.lemoal@opensource.wdc.com, jejb@linux.ibm.com,
        jinpu.wang@cloud.ionos.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next v3] scsi: pm8001: clean up some inconsistent indentin
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17da1qdqe.fsf@ca-mkp.ca.oracle.com>
References: <20220208025500.29511-1-yang.lee@linux.alibaba.com>
Date:   Fri, 11 Feb 2022 16:45:35 -0500
In-Reply-To: <20220208025500.29511-1-yang.lee@linux.alibaba.com> (Yang Li's
        message of "Tue, 8 Feb 2022 10:55:00 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:806:a7::14) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5723ea8-79d0-4958-93f1-08d9eda7d768
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2112:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2112C9F36D234302D40925848E309@MWHPR1001MB2112.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1fS28T0d9xd+cR58hZjT+xVsAO/phjf1o0yyvh5zLpGOf5HV+r9wNrZ7f5+ADu/dWsWv1R+iw+lXPngOCiMtIoFXhNOQMT4+3Qo6lO7AKT9k8hlxHYciK8Dh4pDBfjNZ/DxGIckH3532lIhwWksUdH2W+oXX2D++Gb6iaJvjjSk9lG1blqyMEUZy5t/OqdPVEp3J2qHlGlGMoYEo58AwYBck6+EDzBsv0z3/3HAL8WZAJCbLsmbBH+Fea8H9N2Nk7MV0q97NWdwtZDCVZP5LKELHCFuY5Bmaqo7CS+Ygy6foAlAQs2SJudSQAK1eK5LUPrXSC52lqvlGTe6P+uQUKOLuyiaziFgHbxcvxC9+Hd3z7cMeBTvMMhtRUZwiwWpIFnX+BHJLuYUUS5HBR3ayN+EscG7aNzC6w7viJ+hnaVOPgmsay3m2m65TU774g2gnT3zKd/e08LBnnFnVUsKmbMQ44pdhXwPbLQgAwiCQ5KLC4MiHrR4WNR5kQWbcSqZfUy7rWZrXuwsbTjnd0XDSt4rpje/R10IUY7Z6RWrp3KTFAmqZovGvP0EpJOngsu0QAea3jOt/biDeSkvGLLnwupLMeZWIn8HKnXDlsfPIJM92kr8GYZF8iTAN00JT5+FnI3pJeTzlHZMmTJk9ejiSGzOLHsZYp1YU1XutqpoRLjOHIsHP/vxtEnyRo6MXFWLJHRJoTzS1Sbr6YMpPPNtFYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6666004)(4326008)(8676002)(66476007)(66556008)(6506007)(8936002)(66946007)(26005)(6512007)(36916002)(52116002)(558084003)(86362001)(316002)(38100700002)(6916009)(508600001)(38350700002)(83380400001)(6486002)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wtjrIQPo4YexjAmr9cXx87NtZlMRGGjie8fX2DZm5kQxEOumlUm1IjM6+21Q?=
 =?us-ascii?Q?AavLwHJ5KAcLC36wMwAlbGMPIpq5FXJe1c1miSb0iZ3UkWt0UCjkRGosK8yN?=
 =?us-ascii?Q?QfweymGA32GythfDden97kbmKqDP+eM94LLn565fUiV2434Tds+GuVYJtXnQ?=
 =?us-ascii?Q?O0RVvPpFiHh/FUS9DOp1YatBnHlpdwtuvJFo5J9lhdjdnKf1GCQsMr70UmEm?=
 =?us-ascii?Q?rfdzZnxyZC9AyW2PUEdJjb9b58AaD6tJqSD+klFARPJPMNx6GLuVZwxug2Fx?=
 =?us-ascii?Q?7IwpQ9Z4yIrAzu/NHE7QX7vi0gI7mHrzDBU3op7v1NedBoOljUPB8/PltoJr?=
 =?us-ascii?Q?lxiPlpKvVs2O4kfcKVnXg4hc8rOzkPoY6OGpB2iWYJm5QFQTRuAqEdJX4md6?=
 =?us-ascii?Q?UpZeWMhx1NUZxzfLVRljBI2HcEKU8uzvRQ++hH+8yvmz0pZ0jLPaZQ+f9Vsf?=
 =?us-ascii?Q?FYMQK907DahaLEbFEai8p84muzQdsmucA0Nsrwon69wbj3FrwChPZBcB6j9Y?=
 =?us-ascii?Q?QyDks8hRSQcg+ETasltfYBll0MojwI7+cZSbnMnWKBTtpf5caHIzjUQoQODB?=
 =?us-ascii?Q?IUKmY8QNMOdDzp3YdEOlZALwyLbMI23PsTTW2qlrRCU8u+0eFfbrBM7oOeaj?=
 =?us-ascii?Q?HiCUvVtwBabwTZCwj6qyAfiUGW8hH8YOfQ9oh34gCqlIQdLPian4PWXFzgaj?=
 =?us-ascii?Q?kaMzfrDgmXIOfaXeGnQBIwle/Ul2tX/mUoqTt3zfqoLFIwsipwsyLXxgshv7?=
 =?us-ascii?Q?fVMkPJ+16RVmSt0Xoj5+E8jQmZY6fBZHuJtPFSMEO3kqr7GRw1ZcEaQr29DU?=
 =?us-ascii?Q?d+0rJntOTZHRAgovIawlD/7x9TzIFXAu+2m7ULDIVVCnG1RNqNLMt2xdvuB+?=
 =?us-ascii?Q?hMCnjuuCAgoKhP7TiNXLBo0MefJGd+unJMgzjfKyVDA4+mCgbloQQVDUegyw?=
 =?us-ascii?Q?1cRy9is/EG4td27YNsO8c2Yt3XlAPdTvsrL3d8wv27OaPVH0nHqAWjUfXefA?=
 =?us-ascii?Q?FFpSc4wojFeJeMOwUxDd1glxipRP+zWc5+eHbua4jMpGJr0Tu+i1XZTZCWZJ?=
 =?us-ascii?Q?8hon+Un+hk/GeOH1vAZfgTitMFhxYyfZCUosQgLkK/TqQZKRq0PR1LbPQLIn?=
 =?us-ascii?Q?YMdjeLSi9A004sYZuj0QtIx3Ko55ZffR00bJaiX0TXhHx/f6asUkKfVWheTI?=
 =?us-ascii?Q?rSCZtx4fFYsv1OyoKLl7FvEpzTfhePy96+5QEqpmdZ8oJqxF62SiRsttC+l/?=
 =?us-ascii?Q?osP1ObsmG6vOJ2MTJO5lCMCLfRmb+WMv3FivyjojmktN5i57Lyc3EqSVKIaX?=
 =?us-ascii?Q?7uCxd8ZPB6OGbk6c2MhYNeaL7qnumfpehpClB93ZvC2aXpHCxlg/MhJPW7S9?=
 =?us-ascii?Q?vPnVfXF4fFSEf/bi8qPMQmLbOj/BFKCGOvW4sYKk9cCu6veczUxyI/WB3Kzo?=
 =?us-ascii?Q?8vjF3DBhvEMU5imvrrM5uEyQnC7NriAbpbwCa5e5bIe+dF6taBYAOffs4SK+?=
 =?us-ascii?Q?ZcD1qeNqizOAm12vB+yeO3RfdDkTaE3Ih83JtUjLxXNrn5GZcq5YXeRqC4xb?=
 =?us-ascii?Q?y56ILIHWBW5QzLlus/srK10MSvsbAOxGfR86yeqoJLPnYx/+ELaR5GA3KbOv?=
 =?us-ascii?Q?VMXxFuIYJt20tAMnm+aaleKa9l/RziAsfPWGYhIjjqbUtU02zOfM0P8R0Mys?=
 =?us-ascii?Q?DUg/iw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5723ea8-79d0-4958-93f1-08d9eda7d768
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:45:38.0162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DN9V47WOQMYSoNCu12HX8ZMJVB1i7fDJAL8XiV9D+jhYlShVBLTAZeuVkBnf1fSQCMPOfNDurVogpelK6HPpijU28VTq5mIgFq3jG9c4gUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2112
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10255 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=665 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202110108
X-Proofpoint-GUID: jueP-d554Hu83KMjA9AmIFK_h8RzsOhl
X-Proofpoint-ORIG-GUID: jueP-d554Hu83KMjA9AmIFK_h8RzsOhl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yang,

> Eliminate the follow smatch warning:
> drivers/scsi/pm8001/pm8001_ctl.c:760 pm8001_update_flash() warn:
> inconsistent indenting

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
