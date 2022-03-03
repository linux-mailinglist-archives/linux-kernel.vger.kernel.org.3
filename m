Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFE04CBDC0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbiCCM1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbiCCM1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:27:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C940C179270
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 04:26:19 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223C6UHo011437;
        Thu, 3 Mar 2022 12:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=VQGDgxpGbapzOdR8KeQZ/XcPITteiqXIQDpKy8IecYY=;
 b=AxinDINm4I4RCkMtCTjpNKtEoGgBypnK+djSsBzdUnCF8wknwfcx/TVz+NANKCi+E9r+
 5EObeN3x4EaARUp22IamnrEJWXddaKSlDvggeZvIJ5HNKCZquHhr+MiGTh6hdvTIlqLM
 O9Q4MUU3AQMX51F8akG1fjHQ4SGYrPDaD11Fn7E3TVzzURLXhDzQM+wViGWzHgfjEBS5
 a3OXozxzDoUdasmhwIzm7ZcN9JpmmRoTIhhxHZoTLDMWbHWZGbz5le1f3d5GLs5l/gXz
 QzpTJYBPpwz8woBeRGjjdMirmh6v9kd2MhChj8GSTEQERwfT/x5zGYj7JkW0ZpT4z68r 9Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehdayxye0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 12:26:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223C5Seo090573;
        Thu, 3 Mar 2022 12:26:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by userp3020.oracle.com with ESMTP id 3efdnsha3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 12:26:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eY440syv+7DrOReo6EEWduYFWDoH8J0Sqli/i/yzHxs0otBrNY8EaF0P4zNkmzrhjtcJhWX9w9ls91ZL1c9Gd+okv05ZfjBNsUDXTGum9UBQzYwIwjDYtydo1VoKvEzqGj0/v/sVdmQehF8cH73ja00IJa8xThV/Naw7f1nYF4+JmGA5XApi3l4d02gxlWV9wTmD5w2nCTHIrj5MQlzG9i9b1bKA4P3X1oZ0/7dkfACrJyU+E9UfM5a8KUgnFzKVGsezIryYs7o8GxCQ6EwFtmICm5KN7+inXMjQsSYEN5g+GJ+NUYowdExN3o5nTBmUitOgQpqupZ/3LPYXOviZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQGDgxpGbapzOdR8KeQZ/XcPITteiqXIQDpKy8IecYY=;
 b=jhBQhN1ZFnhdIIoQ2+InRSeoWabKeQlKFsPR3HWeEG+WcSfW+oCPGN3kl9wyipL3mXmfSQEQOnP0+vVPnRNg2WwRTz5C93f2/JBLSuwrUPT5qI2p3CSzNkbaIelxH/1LNMaDP9qFhPhzwqT6AflZhFvxkV3DWQphOC1hF21Q3Df03hnQ3c5/65hfjnUUOU8pQ8yOqUJkQ7BlMm3rqQd9lfT23SGl2pxHa7EiYIZXCr+8yBb/KxVHsnXLOLmPGSyako4MVPyQwqiO9V0PxxRO0pw0OwfSYy8M78+AlDCRLpsf80YQAUb/0tldlgW/EgLSW3WUVjNB4M5kJPA9sCU4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQGDgxpGbapzOdR8KeQZ/XcPITteiqXIQDpKy8IecYY=;
 b=oFjbZiYKmkG0m+2JN4XAqrj6ZBMMlhr4qdogoYYyOyJuauJ5UcbkEgDEdtgv8gEJ0Rfx36LmJZ41D5H40Wo1ferBBgRnG6vVY2XGkPbFjy0QYW51yIssN0NoRJXOCNROaq6XgvuceS8oVitkaoHTmaIUnGznAPLTu5OgaWr2V1M=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4595.namprd10.prod.outlook.com
 (2603:10b6:303:98::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 12:26:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 12:26:03 +0000
Date:   Thu, 3 Mar 2022 15:25:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gaston Gonzalez <gascoar@gmail.com>
Cc:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        nsaenz@kernel.org, stefan.wahren@i2se.com, ojaswin98@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: vchiq_arm: add prototype of function
 vchiq_platform_init()
Message-ID: <20220303122546.GH2794@kadam>
References: <cover.1646255044.git.gascoar@gmail.com>
 <b74ac90e869f71a98a04b834c4f3b5ab37bb38ea.1646255044.git.gascoar@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b74ac90e869f71a98a04b834c4f3b5ab37bb38ea.1646255044.git.gascoar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0043.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::31) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2468594c-13c2-47ea-1626-08d9fd10fb83
X-MS-TrafficTypeDiagnostic: CO1PR10MB4595:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4595FFC377206E4D862796F68E049@CO1PR10MB4595.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7WrDmMqdK06QE8Ys/kc+a9kl54E+xRM4HZZ+Us3RXyQA8EtJyfRs+4RXKnMn1iedRqRpX0PJvm+jGj+oJwfRNw++uV+eaArpke+mcrKntKNPJ9GEvZDNxMM7k9Dne4XCOVcMBwdeJHEt3kTMKHFYebt7KM2rxoy4fPyaaGDqyNycsJPIeSNVuSxomSObXf2WRamtKp68FZexE9mNMRTCgdtpJ8UW8LT43PN1/dwxJadt30RfYCfrK7st9ieUbg0L3iVzRAK/ykNOa7GYaizJtbE/6flQg19sYfkB2DQCpi/7E1qB5JnDPafjsszPJnyCZNMOfZJzmfyM3YchzQ4iiYC1UaV/BFzZbykrWCj5v3twtKnpFVdGh5Y41ch3fEoF5Pai/AzuCHZxz57H8GKQZ5pdIZmq6RVIOymxxk/M+6342mOKAngw3oG75i0xxSFzK/3tCvPqtfI4FfZURiuVY2LdQXAbPTbVWjI5fBdcC+t6qwuTdAMl7KdL+LTRfZqophUQO5V3/syz7Lh0eze2+/grJeg5efGpWQb2/PDlC2OxXkBqlh9eu5BbBpRvrXlv5FTM7BqOFpym+Y9NfSpcnC9dCbciQVv+Jfl9g82/gg/53nlx+RnS7eTxJ/zVmBvFseJDrW7+6KifimgV4PU9BJpHN6wQkCl/6MZig7+kKdGrJn0aE8jfSjjAdOVtfX9uFuDwO+JI/cEu8vXnB1Em1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38100700002)(33716001)(2906002)(26005)(38350700002)(5660300002)(508600001)(6916009)(6506007)(186003)(86362001)(52116002)(8676002)(44832011)(4326008)(6666004)(4744005)(83380400001)(66476007)(8936002)(66556008)(6512007)(9686003)(33656002)(7416002)(6486002)(1076003)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pERdCJPmT7pQn1atxQhn3IzqLbmYB6yilNCJjxjGZ0B9tjXXCcEjXDYqtuzL?=
 =?us-ascii?Q?nRJQ55VBGk0p50XjUrmcwCO/pe8sKV+j5FHA0Y3G3JDJuCt3HRh9j24jxdaH?=
 =?us-ascii?Q?9UVXIC/k2r5ZJliR9U2iIZnE2qvupokUg0h07jUwPXo/7geM2h0jSdU6g1y5?=
 =?us-ascii?Q?Y5FBzlVg05o0cGVDO9tNohYvMG5Tt1cmq6kaCx/Vz7dHlxoOVI1zaGlJoJ5C?=
 =?us-ascii?Q?9jgwdeqB+nO3RAZ4roEqnjff00lSBE5FL60uTbE08VioF8YDZVgWfCLrBo6B?=
 =?us-ascii?Q?O+hTYybdCO+M/YnRwmc9/GLFgSHp1o28p2PHj6ahgE8lEHvDCgm4EfdW3u6p?=
 =?us-ascii?Q?2HagI2Zu8hq2wQqxi1gPB+8cZrNabp6Vn1o7UCuXCX0hHrLLRumCf11SBXi6?=
 =?us-ascii?Q?VdH5Q4UA6gnI29NRogML84sWib/493oFHGb6SQk20wP+xRHk91cXviDgxeTR?=
 =?us-ascii?Q?Cun0zriMBAwxFwZXPlAz4qyuVoLzVUu3mAd1tphPfd3Wo+GnHFiedWpAf9+M?=
 =?us-ascii?Q?E8rMpearhsYO99ADktTZ70WtC4zDMTHTNiLcWrcZVja+RY4DUd2vj9uQRslV?=
 =?us-ascii?Q?+MPH5LtbUqizWdHPRi4QjOVsPOB5/z4o24f985JfGOMridugdLYk+3OkBXPU?=
 =?us-ascii?Q?94q2iWtwnktxeKXtK3yP4Jnn+1AtnSq4SlISc5+NUuuQ8BdRqRFg/R1vz7Cw?=
 =?us-ascii?Q?nA57m0UQtJ+umhYkMBlCGp1RN76x9+AGum9dzXzawBu8ShhEFoR19v1rf/xR?=
 =?us-ascii?Q?7X6nhE+EcP7hcnkbj1C4zo1j5xzNSOTWsmrLyacaLBvo9W3tv8XwhfMg8D3T?=
 =?us-ascii?Q?LQKVScpOenS591Pvzf/EiBJKcj1SRWZMqJ/maFPuRqcisgz+re7kzfy1Buae?=
 =?us-ascii?Q?HsB3keyWJRyO6S8WLweT/dANc3c6/0fun+2xx/jRfVyWfkPciXPLyYdKXnAj?=
 =?us-ascii?Q?TupNsTYkTWOQA/IYnpXAxEuIu6HYhn46aDNqxeFBi1JJm2kOnC4LRO+WZiL7?=
 =?us-ascii?Q?vgZFwyE8x9xYnt+Zsckj5DFMfCLyneCsX/Yh8NSIdnl+tc/0ay6ZeZ0IIBq9?=
 =?us-ascii?Q?bSEk0iDIzE3YrF2qnIuGnOXelQ+X58KeWG8Prp2Xm7rpTX0RdDiZa5voBYZ2?=
 =?us-ascii?Q?JFBcPPUlWRn11gUMoH7gIV0ec/qZkRn+t0wDslHt3Ty2D8AOgln9rrW3YZij?=
 =?us-ascii?Q?xbmQ4WLGaAhjq1wWYflR7sm/3jK2JLFza8tuNeyipays6Mp3EfdgKaX/y1B+?=
 =?us-ascii?Q?J5d8/SeXu7VNKWkvUTPViftIi926aEVco+zy18bkklDmo+AGnZFaTmV4UL6s?=
 =?us-ascii?Q?C14ZVOL3uAG9EsFAAUgNysCZBqmA5gmUzUJeaJG4fxmoCjGlq/x8c8+3nyCn?=
 =?us-ascii?Q?WTkyBFxQStUD7fgjileGg8hv8B4LjbR+cdz4fveRFsb1BlI7LZgRzRgRHP06?=
 =?us-ascii?Q?LxT11HmuzQ8bkXcaEwvJYrzo/nrIMdfELAkx+jFl4b/RUtdfNyzJ8X6V6spN?=
 =?us-ascii?Q?+4qgcrFn5hYU66sBDsgGwWo2rX0keJxcYiOwfd80JJJl/2yMgshPLl1e1T4U?=
 =?us-ascii?Q?syYvhMGCEWg42JOeBECY77J0D6T4ndTqelMj2kB7uwPBqiAMuui/H/WF7poL?=
 =?us-ascii?Q?WQ6bQfhatv3cWTOGkzfDROYUynMGJ1ZgQzShtifR5rcq6syPdaBpkkAhCmyX?=
 =?us-ascii?Q?U5LKag=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2468594c-13c2-47ea-1626-08d9fd10fb83
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 12:26:03.2174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mU46L2Q3we9vy92DivhdhYDnAPZ/I89AiJ3ZehHsViLZAs5a93hHssnZqz47zakC+dAzHvigzEb0EsvgUqCzVw3cQbGsa+wOTIHav469htM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10274 signatures=686787
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030059
X-Proofpoint-GUID: JwWbszR5tP2VRAPaXUgXYSw8zM5y5HOQ
X-Proofpoint-ORIG-GUID: JwWbszR5tP2VRAPaXUgXYSw8zM5y5HOQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 06:36:38PM -0300, Gaston Gonzalez wrote:
> Fix "no previous prototype" W=1 warning by adding the prototype of the
> function vchiq_platform_init().
> 
> Note: vchiq_platform_init() is only called once in vchiq_probe(), so
> presumably should be static function. However, making the function
> static breaks the build.
> 

That's weird.  I don't have an ARM cross compile set up.  How does the
build break?

regards,
dan carpenter

