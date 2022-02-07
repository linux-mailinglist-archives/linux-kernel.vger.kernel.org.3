Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723514AB66D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245242AbiBGIQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240723AbiBGIKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:10:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFB0C043184
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:10:12 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21752We4009011;
        Mon, 7 Feb 2022 08:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=2TsJZTdqrqTqcMOECkElkIdfihSej+G5S/nIIsleJ+s=;
 b=XE9wM439U2YKuv3fnMs4mA/eoi9jSG8GGhUPV3xKnvKoYdx8qg5enfiSkWA25HBUCbtD
 1cPapKDEZYL1aBXKK+LvRjCvn9H8GMNqteIBiwZ1MRgpZuzTzEfqfBLYty41FUf1ncf4
 Fw5wrSYVTtpeciscuZmcm84PumnZuaFFneCYmE/5fmO7KHOhhtnrcJrQkJiLtuX7nVx0
 dFprofmnfwIPuQouVKItXP3OLajC+zdTBvKJNJf0s6zuxeC0fhRgaLgWlyNzl9yY1enV
 /OdUFSPXtiWGdvBkadFFwYETpCfiTqyRUnH3K8eJ9arFHNfF+504ef4CtzrkXPg4OyOU Rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1fu2nbu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 08:09:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21785TMx033658;
        Mon, 7 Feb 2022 08:09:57 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by aserp3020.oracle.com with ESMTP id 3e1h23xwqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 08:09:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEW7qwvGkhsWL/hBSA7TLnpce+7oysPogTTi5yHzw3JprcWAsc1J+WHxtucszbyOAwQbN8K/9w1LrWnUN0kKRP23GcPubpYjcrZg9STM4zBRlWgwYaaGCvIXkn9HqoOGra09+Hae/GuG6vs9N9m9qeN0trEzI+1YkkjpzehP3zNetcV3nxYZOVjMSHV4jQR59HYARZ5RRemAZ+g+/2zVnlGIWg5fqS1GCjNYpY7ldYy1CDsBKxMWKvDgz60CgraoQ+cC7Mn0RDXirEoWgfMHWJWitEaDkz2MtYspyataHOLNnG3fBi8DUx1qHa70DremsXYKbuyf1BB3SRRAyQ48IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TsJZTdqrqTqcMOECkElkIdfihSej+G5S/nIIsleJ+s=;
 b=DRevHey7xZ63qahCNeqVnTUySWlPd5sKdDTuynfaj0xDC+XN8KWM6eys+sTa7RYGQi4XEVH33epU788cUHPPVekDaRVfRe0KMm9ftZ3wMPAbat8NPVJPOj0KaCz+LJNuuDYn6b97r+TD3ZOF3btUlqlJKh4xpGiAq4ML9X13acddM/Ij9FAz8fk/nPTfzgim0CpAkNe4DReBWekd7EMQc204mVL45Rnud1UPi03sgNz1tPajhREyJb0btstk9++WrcjmfqiKi3mljmk2luDfc5FXTUllOS1zdE016AlozfeJO5gZKP3DfIT9e5q2ZZx0dQZ8RbIVxdr54zqdnczs6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TsJZTdqrqTqcMOECkElkIdfihSej+G5S/nIIsleJ+s=;
 b=DjF6WpcQ7G6Cl/HCxrn+xkKoFAi2dVtkRuKUzf+AcssPvXx6qSjdt+x2djjtw7P3lBc4B2Gbf6b7WS8lwx76PtvSHGWdgDXjf0w1fOMshgDrdV0AnyGD8HVHO6bTw4xuuQanmV8qXS1oz5yF9QqQLDAW1Fe5Gc6ARiv0DxYmVck=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5378.namprd10.prod.outlook.com
 (2603:10b6:208:328::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Mon, 7 Feb
 2022 08:09:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 08:09:55 +0000
Date:   Mon, 7 Feb 2022 11:09:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joel Chang <joelcchangg@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        David Laight <David.Laight@aculab.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.com" <gregkh@linuxfoundation.com>
Subject: Re: [PATCH] staging: octeon-usb: Fix 'should not end with '(''
Message-ID: <20220207080935.GC1951@kadam>
References: <20220206074615.3527-1-joelcchangg@gmail.com>
 <c0b504dd1f254f19b6ff60948684303b@AcuMS.aculab.com>
 <8536ca17c2945cb77c506d99eff5ccc42e71f2f3.camel@perches.com>
 <CAJ-=yTE7mZr_DtCE3HA4ruqexo1gH+LPCWzHAeSmivzj5H76Gg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ-=yTE7mZr_DtCE3HA4ruqexo1gH+LPCWzHAeSmivzj5H76Gg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f51a2f9-9ffc-43b2-212d-08d9ea11393e
X-MS-TrafficTypeDiagnostic: BLAPR10MB5378:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5378F0FF6EC9EC684A297D918E2C9@BLAPR10MB5378.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tc1QiTHMVaiJByUzZI4BNfMDZCqtIRKfL58OrqMyWFgXa8cQHBV8gyXX7uA3kHAVEuEID19YD+fnWwMjxYem/8It6WQxXZ8NakT+LzUoSoSwhlUEa7DytqnJDXM+u6qdzdhDNywj79LLyI727NrAaOxnQwFgMrxV3qJ/ECpeQXsCOSz4lK4EULHwR2q5hdvvgjMae6z1pto112N7vdcFqy7pWEjCqVv5m0TQlmtMXMy2tNfhxk2QQkxhLkDYyYRIVWfgK6QZN2oGObLpvv4XGIV6GXZISX4iw/ooQva8yAeDSl6m5XkPLNV8y7VoJOYFyxnqLsKvTlmqggKBJMh0BdTolcT0gTYFj1FC9VppFkCP66W1nAA8vxr4NdP3uM+m1EJ6BtKHHWmlDPW6G0Bybcqqif9JOGuAfdZrvrDtLCsJsxpOI8/z6pnd1sCldRGeJAHSL/fFbfhyL35IA13CjRt1ZCabT2/TEJ6LcE0U0Dnh9HjehBRizA3y8uCgVPY9JEaefupATV9D15Mz4SnKSfHIjJsUODHhgKCDAb2E/o9iNAT2qfZ9F/O7WQWt8u8g/l76y8J/HsEZADLU1NdGkCOv/BjQjYE/mfopucUJlQeXjHxXOjrUpKvE7WhVhsdB7Dp9+Nu2EkPKq5CzpmxMdyPfe+q9bXrMdDhiQHX6/uouAzBiNgtNp7fUtX0O5S+NhJKAxCszkaqtUH6HaMv3SQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(316002)(6916009)(38100700002)(38350700002)(44832011)(66556008)(66946007)(8936002)(66476007)(8676002)(4326008)(2906002)(54906003)(4744005)(5660300002)(52116002)(508600001)(6666004)(33656002)(6506007)(6512007)(9686003)(186003)(33716001)(26005)(1076003)(6486002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J0a/LiH5DCHD+O00Rk5nhcIu8ECL7Jp65Ukzk5qSnc2QYNMHNyi4zF3aMJnn?=
 =?us-ascii?Q?SyIMctCk+JXopsrwbs5c568nvfiw0Ioo/vWmhVeuE8Vm+l3HgrlaYfOcB7D9?=
 =?us-ascii?Q?cNsygE6ego7Jww7F8CsZ15InZLW7n1ZaMnh8+ixVpbrBZb7ZlmbH2AAX1MoL?=
 =?us-ascii?Q?IvRdBngE/GivVFVQSJNJJz0vv7i7BUemI0tQPDLJUjNFFbIrf/AAdJpFAwzU?=
 =?us-ascii?Q?PKLEDkYRusakmCHKmxByN4bVB5XKx4R1gSTBZq9CwUQOyBu3waee9Oqn6HKx?=
 =?us-ascii?Q?DUxGfV6jrf4dHmhk9Cyci5zy0RF0ILEPGwwY2nLp628uRWRnBpVV+T/2EyaF?=
 =?us-ascii?Q?djjCAKhas+4MJb6TFSF9AzJhecxkIIZBRxUyszYEud5i6pWEGcONIl24o++L?=
 =?us-ascii?Q?VovfdcoOh+lCTg5GtbULrL7XEB/M1fCTcGc6KUxuCXC0QbkqOrQb3Its+V2a?=
 =?us-ascii?Q?YD0B5+scLQ91L0PHbxrP3DvLJEGjZi8u6RTSWnKoGS4Q6YmGJc+JA66a6gZY?=
 =?us-ascii?Q?TpJFogvYFn9+mBTbTXrTDE3426jaYnJtCSoGTgQu7ZYRAJjQ14dwf4Ep2+Bk?=
 =?us-ascii?Q?KkogwOcbg8My7YybH6sBu0dkqobo3p8RbhUOEUKGcYrPNpNDYTrEVClYQmZL?=
 =?us-ascii?Q?lqaYy4Y/1Jf9h1HDqdhhUqD2e1de49kAJvV5TrhEGKP6v+PJNG49CqTgZtc1?=
 =?us-ascii?Q?ruhx1PtbObW3qfvrAxYxe7XGUlHn+DS6LRQK4YjKaN7W73EGNWYWprv7f6S4?=
 =?us-ascii?Q?4QF7V5FcEizgDVKkFWLCXbm+JbPnV7ga5L7V0gEEyuDYKz16KZFh2+R0X6h3?=
 =?us-ascii?Q?g1KybK9KvIEp0oWhezdYYsgVrGwfScWbSXXS0xHk24fpwdtXPNIhZvak3fHD?=
 =?us-ascii?Q?roPnh2LAq8U3ve9B65IE9cpwKhK3lDbRjADy31GsMgF02cLXRLfyOFT9/22G?=
 =?us-ascii?Q?vINDew/Y8qBF91LPIs7e6U7nfT5PUxdTY/fsgqkFLbXNP+SgVdqNKNoJzP6Z?=
 =?us-ascii?Q?nWtPMcB5vajFXY0TJWBTpDdDg+LF/UtD22QgG6LwPA6EfTWCE0/7W3nm5hjb?=
 =?us-ascii?Q?IlXoaNLjg9vTBL/YjX2dsjpvHoIIEgnas3hcjzKS2CwEyzbhRRaqf8NrCVlt?=
 =?us-ascii?Q?uKdFUW4zHqhMTxuyMDkDgbzp7DXJhh8ger9q87Wun6ms6WkthpGkYOosqzXW?=
 =?us-ascii?Q?7GeqoJlslcNvpeVZT6BhZg04efoOtScKwPvQGK58p2NL2c3KuZwsuBh+HPmk?=
 =?us-ascii?Q?5o8Cv7bFmVTkEEn9JlbOctAdav7vr/TfOr3itQc9gx5qEO9KmW2X4bZ1nBX2?=
 =?us-ascii?Q?XMG4UH5NNEnTdVjhoMWiWixC6DM9BR5Kqb9RMTS/+zVDfosOTeMfEniFlur6?=
 =?us-ascii?Q?K+cUCQ5ezHF4KE/EnkQ8KNQxylfQCqPiM1wYwi1avzrfI3wOZrCccftzpIXL?=
 =?us-ascii?Q?wLYXY9OQ3W4yH8hByoZgDodXyOk5ZAcSdR9F2xEq3lZ1MyNRIBAFPdlw71C+?=
 =?us-ascii?Q?KP9IKL2VZ2zhtVQC3vQUsKhemLLaIQjBcNpQL2WuAcpk/PN75eV+Sg7fu3OD?=
 =?us-ascii?Q?sRzDc5h9KZOMBp/JGqpS6OwrbNti4UyhJpMLfqsRckXAkWI6xV+4u9C+wwZI?=
 =?us-ascii?Q?4QLidkmKgPVU2tvXdBWhJdDttiPpgxXXiJmfIzx7Tq/u3DAHD+RjWTmqQN2/?=
 =?us-ascii?Q?6TdYCw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f51a2f9-9ffc-43b2-212d-08d9ea11393e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 08:09:54.8945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /izRRIbNDixgN+v2Wud735d1n2n/3EHtjNjbVSKC9hPf/8zTmQocnpRILcP978wHzovy1xO/14I0NVP0v+jNGwUossHsHDYbtoY6dtOv4mA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5378
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10250 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=735 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070053
X-Proofpoint-ORIG-GUID: g1B24FbwirzUUCK0YQBtMG6gZpCCvKpQ
X-Proofpoint-GUID: g1B24FbwirzUUCK0YQBtMG6gZpCCvKpQ
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 09:57:34AM +0800, Joel Chang wrote:
> The hunk has two lines that end with '('. The hunk was rewritten but I
> believe the logic remains the same.
> 
> I agree they are longer than is 'nice', but they are still under 100 chars.

Just ignore checkpatch when it tempts you to make the code worse.

regards,
dan carpenter

