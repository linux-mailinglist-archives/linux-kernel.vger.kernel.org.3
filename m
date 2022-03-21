Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAE54E21F2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345156AbiCUISn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345396AbiCUISI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:18:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EA612B773
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:16:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22L6iSJM008859;
        Mon, 21 Mar 2022 08:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=JRs23WzKBiYoHU20PncMGW9D+RHAC718jJ4x04IVEnw=;
 b=UwABRn87TtaycR0rzjQTRP4A4/RJ+MgMfgtAuYe333OMLdsANh3+tajUG0TrsxnUnrZC
 JuqdaDEBeTTUhNR4wp0L4wjWRW4Pgz6pB7h2r7TTpESVCe4RQRYrXeOKsBblypeerus+
 bRLMVaXnLJe7H1uzAHAQuT+KEsyub9iYbPNTTJBguGV3hbHzt4GzlhjHJuUKQQ7Onz18
 5Clg+Q4qcOPN7vjGeR8cBXmgNGoYEc1Xvw0Ip6HVyp/a5TWdkS1M1+AuBvPbCZXSsXCG
 XrLUAHa2FvKpIAk4ebHdjddMuoWzfc9SzVEe+YibrNam8P4T67tVueKHX7jfI2XfzhRg Gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew7qt2dyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 08:16:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22L8CIg1035035;
        Mon, 21 Mar 2022 08:16:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3020.oracle.com with ESMTP id 3ew700b731-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 08:16:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJLGgTGBY1ORrufeHKmmkG/5Ta0v/hpkXX9tU/EMH1YsLgQEc1llH5jl4akVbS4j2+UZ4boM5gxTAy5R5RA4P0MIeACeetMXDdGxHwiCCRTANvipY4WDWuekMuaOobPUmTh/QGFZKgqgU1rbGrwNfcFkxZ7QF4QzjofPiqGXzOZM585TZtc4qAqC9XXvF3hSrHZvd1ENOsGx0WCwjebOUgkptdxNplXpZ0twW74HYFbnIKaf/569CBqx80ucLtnkYWFriIA2qpa6GY8WgNul28eS4Zb4kWlgv1IT1JsDavZGbu1g9UV3yw44CPMv2W7PH6qv/102yi2h/iiB04yZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRs23WzKBiYoHU20PncMGW9D+RHAC718jJ4x04IVEnw=;
 b=KwgldQG/IMNK01qHub74PuMDr/X1339XY1xbR8lyq/hrK8jWc9SoN2lx5G8bg/7RemFilupQeLGTrE66mclF+NLmfZG4Y+XriGw59jyTyOkOOAuOQ5Kh5DaCB3ICTB1KSdbsVEXn+TVdohnRZ359VmwzhQxB6qSN7G3Wi9SSW48YxbH0GDstcDVcntA8Oh+KEm70WvL6ZpWfvQWcnpENO/Imu29O3ohPE/6LYwkyIox9byed4woL0UtfF2cl2oFKPzrKGGOe5+cI1Fiw/z8dP+KhPn30SDEF504IqEAOn9WdNkiG7rcQjoos3UY9QtwYaMYBlpcFSbPj3Hw9h7thUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRs23WzKBiYoHU20PncMGW9D+RHAC718jJ4x04IVEnw=;
 b=ZRr5RLcCAdh00mdj/u1dInRkGiTe/jLL3PmjV78Tz2q+cBBcz6KJQN38bYPe6+/kmEmd/mcIkwDeO1FKpfFL6CZFwgA/zXu9pLNACtL0mmDMePVLZ2y0MrjiPHXFa0aAJ7kGThBDyMBiCARCb4Xzpkmcrxjv+pmF4kztxdNF5KM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB4886.namprd10.prod.outlook.com
 (2603:10b6:408:114::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.16; Mon, 21 Mar
 2022 08:16:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 08:16:10 +0000
Date:   Mon, 21 Mar 2022 11:15:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove local BIT macro
Message-ID: <20220321081559.GF3293@kadam>
References: <20220319180342.3143734-1-martin@kaiser.cx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319180342.3143734-1-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0031.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a0faabc-cad6-47e0-9898-08da0b130e82
X-MS-TrafficTypeDiagnostic: BN0PR10MB4886:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB4886B3631B8E479EC51E75318E169@BN0PR10MB4886.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: joZ4SGqhUvvmLuMMQ/2IEdAC74nW8LoNWBxCv1oYr8U5qxuoOmm5hPE5tOadXOKTEXvl7ZXw/RJNb6614W/vcLdfKS5pkUAWUiurmJHEpX6MQZudKeryJgkkXSK1tO11ZceKg7CB8FYqRYWwoQGlo8lLHLcaEiiGvNlUXYyHsr4YMlHC7SG60WglgBHHMyZSQ5kwMbXQLdS9H5C/a6DdgvqB+iVDmnXT3QiQwYHkP3+T7ySVrbdo7EAZZmIKvvva9bg6TAF5FNyX+O1FbmFp1lY+xOC3u62gFpafvAcPoiIRZ0nw7byQ7hfp6pelieD/0VgXPUg/JyyAGTJkGJT6SATQztVAE/lNK+VsAAl9NUifsM3axUaAkyXrgsdwefYxvtfMQcoylzbGnnRe5CjSzG4s/41paCc/smPXA/eTeHPwVOe26dHYSE40t0WMi4AesREXuPrj21pdhn9SKHlZvUfzz/7tTdwnB+I75KuZMUiVH2FeI0+v2zrw2xOswdS9r+VX7Qez8kTT8Pq8AfwZIujCN000jG+K0CDMl08cJOvEPGToauFJpfLEXj9yiOUzJu83e0naAJhPAWlVi9zjekVjv29kgQX9fv8EXb0bQwgqb30lDNxaf1RkEq0usCnXxE5R5VDIVlXX43ikWwqJYMoykniBDcAp4gXj5rzTBY91zHrBuouv+cKECL5jYel26d/ap4OkVwVg9/aFg6Evww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8676002)(508600001)(2906002)(4326008)(38100700002)(38350700002)(6486002)(54906003)(86362001)(316002)(6916009)(66556008)(66946007)(66476007)(33656002)(5660300002)(9686003)(6506007)(6512007)(6666004)(4744005)(52116002)(186003)(33716001)(26005)(1076003)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tmfG5XdSKz4hmmUyAm6rnvJ6ZKhxA2Edw/KQMJ3UKI1JZoWjOWK2GoubG7lD?=
 =?us-ascii?Q?74RHfck3fIYxnLZ/I9u9/2V9y2K5MevfQnYSSGdue9254JHHojkr7tmM97CC?=
 =?us-ascii?Q?V6tQF1pOEeoGcFzw8DoHd7YkR7fIQz9avVIecHN2jJoJSVvR50HOsHi9qV1n?=
 =?us-ascii?Q?PRC0QalGoWJxLWbBGm3xTyk4EzFSgGrd8wlylUDl3HiHSvl5rEnCKsudrAIk?=
 =?us-ascii?Q?RwN3SvWxqQUBxyInIePYzyNfSs/xu9pfJH27vUoraEFIHc4ZHEJG50E52GQj?=
 =?us-ascii?Q?XkP4Dg+njYDKO52G8HC0uezu1fCl7YUBzxs9ptMyetivtJXEUONrXAShHlAL?=
 =?us-ascii?Q?GAjeomC6XTR1QDNxL1zI0ktgqR57L2IuUiMpNcWOvRZN0GS8c3AkQ2qbkUeb?=
 =?us-ascii?Q?msI4yEmXAdlSBMJT6zDuljWqC94RX6qC4k51pXNmbb8atEbkxjRIe/bRT3rE?=
 =?us-ascii?Q?4Zkw8gcQIbQ0oCRSgif9Wk82tHZRX1dAil7AGBWlFB7yeCjItoIcgHDMPYco?=
 =?us-ascii?Q?vQhG9CKXgUX9fZOBEwQdPhsKgxpXqLfcXXR1daXrBUCHhXbbCZKmi/rwBwPJ?=
 =?us-ascii?Q?7MUdVmkCdrKLKroWAtoNsGFPRNqrG86Bl4aT/slhNuyoB6TtDyMxUrLEgv1d?=
 =?us-ascii?Q?3mvlsHKe/v6bheD7uH7+NJcp4qNbAu0/ZB7rC1yo52uuRTAqyPELLud7zUUK?=
 =?us-ascii?Q?+LzPTrXpH0ILWUpU46LDL60BqSCXEZJFMF0Y/wF2YxQ9bwJhqIiled4rS6Px?=
 =?us-ascii?Q?2oLIy/M9Is3KU/ySxYC1nkqH+c6xzWXnq7Jy84bm/UK0RmoeYTn2Tv2RTXD+?=
 =?us-ascii?Q?stY+WC8GsXkk39wMORbp/yR3L79/WcExxdGfdDDm2YoYPeaNnlGarok8NUgo?=
 =?us-ascii?Q?Jraza1+uXnFYo5UqDyhVm7Nnd12/lopcfRp9/ZSQPJgerTz1aufoTW2JFX94?=
 =?us-ascii?Q?/I1YuWHJT5WCX5NLJZd/qkFkfKQzwve12zCkrqubfowNIYNzFDR6bOu3PP1m?=
 =?us-ascii?Q?da/sNhXah98cNOyUghOhZ30SsDn4rLE4vGzbylPwq3/hHQY/Ggk3wARCNxTQ?=
 =?us-ascii?Q?ClK7Ir//NH7///tT9i8LG88qeRDaU2YZo6r5npDHQJG14wF6emlcQn72yKaE?=
 =?us-ascii?Q?qfzZJ5hmGphfr4GbSczDdGKi6VncZ+rUJwdGvCd5UynCXAo6pZSlDYk/MCXV?=
 =?us-ascii?Q?uAWkzRxQxL5dc1q1cY4CVGHXCpo0JSJDsv4YBiBjL/EwBbCgZhhEiuzMiDcF?=
 =?us-ascii?Q?6J0v9DG6gFtYjOuvX49e56qVNQ2sI06q+UBgNodANBvFw6zDA977GF5KIMKl?=
 =?us-ascii?Q?ZWbl7UOhmnQQQBOuw8ysxm/ejM5oh/xxmmZGcmItb4Q+zlWJNNYlAD3U7sYn?=
 =?us-ascii?Q?mp+gz2UowoSEvhhn5xXjam6JB2Ng6OYOegx7Vdy9u2dOZxa4hHCjT4HVxA9I?=
 =?us-ascii?Q?8t0gqHGiBEf0pQj08wcw/29bVWRGzDnJZsdLHjEKg2m5sofz7OGwlw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0faabc-cad6-47e0-9898-08da0b130e82
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 08:16:10.7694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dgsy5yHukRpHDHWa9KlgP9toJphOwAEoO1BtIRQWtAgqrc94HiXcEwIALvtBN0JlckHOuY8vyaFH13iLK82IwZe6cBeUKFrG6TTGurdwD/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4886
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10292 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203210054
X-Proofpoint-GUID: 2Nqb1OAh_nq-jZQoOI6My2AAwQuifrzM
X-Proofpoint-ORIG-GUID: 2Nqb1OAh_nq-jZQoOI6My2AAwQuifrzM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version is better, thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

What the GCC devs should have done is run their checker on real code and
silence the common false positives.  There are a few ways to do this.
You could make ~ a special case.  They already ignore truncated sign
extension so they could equally well ignore truncation when all it's a
32 bits which are all set to 1.  Probably the best answer is to do both.

Sure, you might miss some bugs that way, but anyone relying on GCC to
find *all* their bugs is a moron.

regards,
dan carpenter

