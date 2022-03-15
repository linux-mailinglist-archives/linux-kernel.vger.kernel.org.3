Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515E34DA1FD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350963AbiCOSG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350935AbiCOSGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:06:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1913B329B7;
        Tue, 15 Mar 2022 11:05:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FHvGJA019501;
        Tue, 15 Mar 2022 18:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=7A7VC/D7ytQwW5IrUMYrkzNJZz2hS/6Sme9/m+vOkyc=;
 b=esPwd9KkJSdRPs1Zdwv6WsjEXvF34Js0zHwwslI66GlwI1cEGpM9VEM2k8hlP7lY+yfd
 86dpnCCE6NTI3eM/EVmYUB2hjy0Bh0evjRgDw8eAC+V6hWIuIOF/9yxXD1ORjhmd0JLm
 9DmwkFb/J4BexjSNZhM8+izi/TZftS2raaNx9waJCgQkmCx6feNbLvnBvu8XjwAJTPou
 upPRgqHkghjCrD2i2VHmvYFrAXaKHcJqO3E2yunTHKnYNBHI25vOxOIEvkQm7zwnZW2/
 g0jqY7LD0b0zU2f/+AEnMcy2wX8tFcxCRhV9nlJgFcPLi7H1OGX1Qz6ExkmvE1JDE9gD vA== 
Received: from userp3030.oracle.com ([156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5s6m16t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 18:05:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FI4Zme047087;
        Tue, 15 Mar 2022 18:05:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3030.oracle.com with ESMTP id 3et65ppb5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 18:05:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAB3HM3VcrUEGtCPZ/WBkSunZKW6nN39tVL6mqaIybbynIVCUI7/bbVnnZMK7Q5pKTqu6f1RSaIqIMgHzu+EL/QXp2Jkvgs43rrGrASJ+XtbXwzTfFCWnh2XUo9FgtnMvyaQaddjXUraMaQQyxnoMmQ8A+NSKVfJ8xw0VrFcARx+w5AUj6Im/Q2HR3jdFqFV4kpCemmtJ8BHykHGaSS9+uGlIs88jI6JCGXbbKXZUs2uyOW+ANXginEZB8KvNtg6Gpv9C/tY2Y8SHa8zjEdVrigMhxivbyYIJLD8U8DTkqqlDWI6SmGf1ceX7J8zQNHs5tyxfn4p2YGD4qYKUNTXQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7A7VC/D7ytQwW5IrUMYrkzNJZz2hS/6Sme9/m+vOkyc=;
 b=novlBmxVQypDCJ8YkYLjT9CLxzAXhUAHZO3H/aAlSKtCAqA8epBg/6bWZjQyubBx9YkUsrmVLr67ou/XM6wWpG1+Feg+OV/yNjipwI6kKlL/DVJU/iAnODQ91bJPOFeYKL3Vpj1M/UtZ95E3xbhC0hJwsv6GbuHdVgYaCjojlDZ1EzHDB8UwSRy5MB6tjRZDqlFsFtDMiSncG6QWQrF76dxi33QroIUYotFye4nPkqS8W70DwcapWW0EcC7ZHCGRJ0toI0nazYEyWI5bnjXXiRca9IyQakq8oV8VY8mUnn0x7egjnTvGB6SgTlU5b0JuH6C+jaBg8SiUHtDVxMU4zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7A7VC/D7ytQwW5IrUMYrkzNJZz2hS/6Sme9/m+vOkyc=;
 b=k0gWR92eAqazu/B1v3Hj0RcOCzc8ViOg6mBTyVgkXFIHmhVx6q8xVxAAzEBpjhjHM4UYUZG7Ad9nXJk6UDdjcHJ+y8hkcyYPBFq7YLQGAT7Ez/C7uUe3SsqNbvB+pmjyncpWUZTOxkknjHzX9r2GZoY8bEd4RmU1hpdo26gyfjw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY4PR10MB1813.namprd10.prod.outlook.com (2603:10b6:903:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 18:05:16 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 18:05:16 +0000
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: bsg: drop needless assignment in scsi_bsg_sg_io_fn()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ilsfay7h.fsf@ca-mkp.ca.oracle.com>
References: <20220315055325.14974-1-lukas.bulwahn@gmail.com>
Date:   Tue, 15 Mar 2022 14:05:14 -0400
In-Reply-To: <20220315055325.14974-1-lukas.bulwahn@gmail.com> (Lukas Bulwahn's
        message of "Tue, 15 Mar 2022 06:53:25 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0097.namprd12.prod.outlook.com
 (2603:10b6:802:21::32) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97aea9f0-a469-4cf7-7a37-08da06ae5c17
X-MS-TrafficTypeDiagnostic: CY4PR10MB1813:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB181394F91ABA6C2EC97117A88E109@CY4PR10MB1813.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IronEnoywFRYJ1X5i/Hx6FKvt2lmj8bw/YuYhYaTxYLqTT0zQ+IEoKVe8eQEBpi7SuJoT36ACPjVEOr2iqMOuKMfO46BJFIFlCK5fLJiqUK5fxC6k5Alm2MHqPuEW6dSU0SoLOGvcMrtKHY3BsepuVUiBLw2hlVeqn5liAA9AYlbHA6rfFezrPWHFF80SQDjI+o2JOe9EKpGRk62QyNC/eBi+6JUA+Zti84InfYO/bAgY29xpos2MkONYPUYFuoITiKJ8K/535LPMG+HwaYzHzC5pMVINODjaVQJn2SfbTWEh1vem4M+TjQ3pcvS0tY+616VIYo0selSyIeH0cYPnM0bjwrfdFD0YNLpL/tjbsm8tDR6pEqWhShgbmvKiAkfWxnsIsEI+s4VAatJ31i+XZyzDK5+bY1e5Jz3Rd6iDqcoIwNyyhdOVIFSGhMPzD3ZroLi/ZANeEBubx5j7Kniy3aVqODQHfkiScbo2l41yklZtcxHafourTJzhTgXTEKBCAPtb8Ug57/fpvO4CtjfJN7JfilFB9ErCamx7lrnticIuDLxeNtzVVSdN1cBxCvimjFshdDu4tF1UaSdDi1JyXAY5x+XWp++S8kBqWBixYfLdpABbgOHLMx0hJGvRWN1ApP5HigFjew3xpCnhzCFpmDyMwhAc96mT3ZEcv0K1ovbQ7mTrs0ZJRor9rGTXvNcmSK11VIe90++MxcGMIDXfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(66946007)(66476007)(8676002)(4326008)(66556008)(186003)(26005)(86362001)(5660300002)(38100700002)(36916002)(52116002)(6506007)(6486002)(8936002)(6916009)(6512007)(4744005)(2906002)(316002)(83380400001)(38350700002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mRDHluPNlBfGJ5GGEFEGJwj6XwPEuDDwWxR7n+m5OGm1ZiJ6vZFY464f+bvw?=
 =?us-ascii?Q?WnJrUsjnHNX8KBQtqTxZNv6Y+vn33hCk0SOymrghJOGxuT0MP8BS63Yu/BX5?=
 =?us-ascii?Q?QpkDoA55hvPTxM5aJa4YS+A8lojigmOQlb4ENZKHg9twxRWtSrrFUjpwPoMj?=
 =?us-ascii?Q?0vmo5/bgi0njaq6ke+MvcOG4EDUFHuJW4oav+kdKAUgEGn0QRoEP0TABDmZV?=
 =?us-ascii?Q?WJCXLxmTI7cEsnM+CP+C4dATXbynP4Ban3YhffIFspplttm3DEyPMOEt3wrM?=
 =?us-ascii?Q?31KuKpgrZ4dQDsQQTc50Sq7MaRChjYnJ5+GJjhG3mE4i33AxCAEj3ob6Nwf7?=
 =?us-ascii?Q?bCYD0qw1VzOREVGsWTWfKQLNruCBS98Dd7tOZTKc7RMpf4Fomn79JvTZXWLf?=
 =?us-ascii?Q?OqRke1Bn4F4OUBfcaSRzFGFdyGPYNmVezSME3u2iEWKRoKscsBLDus3YJ81L?=
 =?us-ascii?Q?GIxax1zavjFxYyNK3uiMEUb/S/aV8o8eiOV/PlrpValn3P8Lv6rdg5f5qu2T?=
 =?us-ascii?Q?1xKln4yehIBimdzazDnnDnfodZJammPieA3cIDp7lC96u0PY8uOCbdS7xEBp?=
 =?us-ascii?Q?iRCjqwBQRghG/v6lEP9Fpj6WGBILDxpJmWz8mLjr+evNRCZHeRccqg1UXIMW?=
 =?us-ascii?Q?yDJ7OhgPPWfoCOtrt99gXJm/z/1vn4v2PkqEt5WMN0HTNDv1DBjMjR3257Hi?=
 =?us-ascii?Q?/kA0iyGU2DzlZqsAsZemhjXtl3bB1ApPElQhxI0O5aXJx8LhJo1mqXeg9nio?=
 =?us-ascii?Q?ee/ISGf8Vt8EIR7qkiH3iYabx6H//M/Xh6zUwwTpXFPNAAD7UVW0uZeoZnAK?=
 =?us-ascii?Q?CNoGMigCBixoMLJ1W1ogkt+Yx1l4BpXdLrbaoen+Yx4boB2uw/juuwyxlWeO?=
 =?us-ascii?Q?FkgUOEiozRqnuXv+WTpd8pdpesUCvbcHRaSOSCsiGnB6/3TrNzvlg/8Ocalu?=
 =?us-ascii?Q?99XLoiPLKApwAFFKI1AV88rjXowqxzjCxfW3fLCN/FZtAEPk3sri5+17SJd9?=
 =?us-ascii?Q?o5xd0cJh7RJCmiL5hHB2ZpePhqvsdh5AAtJeMqpQFfSOWsY9MeK/BRFR35l4?=
 =?us-ascii?Q?c2xoFlfdUqp8SnUdRQz5ddG6v6DsbDuSnSAkEmrUTWaP5VBqnQ2IQBcqyTeu?=
 =?us-ascii?Q?Dz717biYVvAt46jt8CwFHLpHzBro8G62VnG9TjfwgLKAAJJVFz6O39epaB0u?=
 =?us-ascii?Q?D1IxDaoWxOM2JvhgFsCgPWiMOQ8pHTQivpaIDcIpXrov240Zt/mGgglZi9rE?=
 =?us-ascii?Q?kzbYNvEI6H1CcmKlOGrsvv1hHwM3Oax02S+9KWoCpL7B9wrh/S6ZiOy08+D+?=
 =?us-ascii?Q?dqCZV6Y3/tvlcWo8wSbeXr5AXsilV6I18Mhk+pKUjg90t3xTUGVJkNVKqDwm?=
 =?us-ascii?Q?D/QAv55O3WUVOtgGztMst8bQ7watD2hEpF8FpHhMYhTFFeKkgQfdGqJQF/2F?=
 =?us-ascii?Q?HCkvLSBHHjDIUeC1eBpxyzmBChLzI7k0v6Vj7rIwMXtJh5Bd++e1iA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97aea9f0-a469-4cf7-7a37-08da06ae5c17
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 18:05:16.6714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKORC9fvXNhT4hnTXdCp+MoYXga/a4pcHBbLsTf1/1KQvp+uN7uoB8ko9JfnkcKmelVWqXy00pKqR+0ri1gAatrsQvLXPmzYLx4Exh9njDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1813
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150107
X-Proofpoint-GUID: ojWyNsRsx-WWt7f_f1QR4Ih62YTxvc4i
X-Proofpoint-ORIG-GUID: ojWyNsRsx-WWt7f_f1QR4Ih62YTxvc4i
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lukas,

> Commit ce70fd9a551a ("scsi: core: Remove the cmd field from struct
> scsi_request") refactored scsi_bsg_sg_io_fn(), so that it does not
> allocate directly and hence does not return -ENOMEM in its error case.
> That makes a remaining assignment of -ENOMEM to the return variable
> needless.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
