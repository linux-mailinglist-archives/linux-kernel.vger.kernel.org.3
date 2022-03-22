Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A964E3B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiCVI6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiCVI5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:57:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F074C413
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:56:21 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22M7GN40009088;
        Tue, 22 Mar 2022 08:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=9GjCHZMifJlMTcoghmmEOwrwJklebbIeS+64rODUeWM=;
 b=1IzrlV+68vIEeLL52BfP9gWi2ADIif+Y8MwWK85XkvrugzN8nPwSo/MJssrfu7DIj9rF
 Bayu4ApsuikYbKGKszW/Tzmh9ZIKCwasHjOsGvgHva656MyM0TV2zDglG3bkrkBbjP+R
 ustB4StNG47MvOzMqvfDJ+7A67vnDLjpiiiVQEdBeUoMv08RNZyBwMpA7mfhAXYl0NyY
 dn0OiNW5KkuN4SHFOJMBQorE1ULNFtN44fxCFhl2DguvfGZ9ddNGfud1SgINfD/qcwee
 5bL8uHxyhtVQxNTssEPhHBirTR4B5VTYPr5A9bTDUcK9h/Ok28F7Lkrs8Wdv0wX+xkaB xQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew72adk38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 08:56:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22M8lBEl180561;
        Tue, 22 Mar 2022 08:56:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3030.oracle.com with ESMTP id 3ew49r5xuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 08:56:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8xj8zecZEWX70NvizdlRQBLWfvlcw3xKHDqiyrqofLIOIRaSrWEYDNeTuDw3dUAziffbT2Ac8KR+vPdrJsqh/hXc7ALFSJwG7Rw0QlmObwUKbgxFnTM8cqAvSNTH5WUDZh/yXN6cl9cK24jw20DM2Qk/wBRbw6o7WeDwIPauEM/G0ziCx1joi4T5OUUuq2s+6zv1mt8inYPzBSU57bXk6UwQSxtJSyQyFuckT2Xb7QRGBwIgWH1+kVd+g15SiVuMV7r62ZMbPzF6hAAxXWwL/dWYvp8+SctJp+Y2yjuMpC23VyQyQJfr+YBowpt5CMMCguTmYHywLpcmBWKnEv//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GjCHZMifJlMTcoghmmEOwrwJklebbIeS+64rODUeWM=;
 b=YzJLReQjX+BewBkUhRhetGtF3AGt7/GGFC3QMMGvfNQ0d6iA4uJlp+oDQvgGjIFWVyqtQV+0Yf81Mqv7mDyZgnihsLMxP5dRTBBzlNwEKvFFuW4zUzH29q7gYyPVB+x0Wmi+z44RIY14XvYjVwLcKFGsM8DSPdKE/cOFbnJl/q0tm/gxhu0VoVVcw0T6LCr/oO8R7iKN90v1nvNcjsKuUDiT8hHs5HLelrdq2qVh7AKNorrVs6xwsxZ1eBcCIRybCPgRdpVLWZSgLZoGa6nHbhEyBuCHE5b2+iBfD4S4tzqaPQLsvQlBNvBBF9hnQxIix1xImFo8banVrIwbGWd7XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GjCHZMifJlMTcoghmmEOwrwJklebbIeS+64rODUeWM=;
 b=a405/eJcGQXiR7IRSS6kd+LcZ/+XzTvIe07XPgV74l2R3ZFD5KUHwgICHQoV272zgQbgA33g0FS3jYSkriwurRkJVVNoe7YY4PdqNj9VZSL5l6+GNfQG9N4MDddrn6DRtFoGnlpbgMD7JcFjTUYiF2JDUN0Oct27fmGpyCKWhtk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Tue, 22 Mar
 2022 08:56:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 08:56:11 +0000
Date:   Tue, 22 Mar 2022 11:55:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: unisys: Properly test debugfs_create_dir()
 return values
Message-ID: <20220322085558.GN3293@kadam>
References: <20220322083858.16887-1-fmdefrancesco@gmail.com>
 <20220322084928.GM3293@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322084928.GM3293@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0189.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 646f2449-fa4b-4b3e-7206-08da0be1d002
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB54338B7666E10E4A4BB3D54A8E179@PH0PR10MB5433.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oi4dEJZf9PsNredZvmFDD+xVGsQMhbsotpbqMyPPvI4iPZUMoQAAZeDvHluDLG7+ejxhhlzvs2yHMCrUxNPM/JkvW6FXWFu4gmDmgcwD0etVr/M1/MeXjCC1shbvDQh8XAvgYylqx78fmRWjJbyESwZstgON//6UDixmk0Lthz3OfOQ7bFKO/PvS/j2yB2vwzNqwuuj22jhAEKcuZ9ZfB2D/zzuTnUM04JTUKRi93CeYXs2oZhgm+/MDfFlz1rugCmvtdVbVQfd9usV1UfcHZqq83ANntIcDDiO/0XnuWPqbocyK+pRLoIuKpe5oDc4ZPASRwLmaCoGGmPMF34+Mx116RlWfg3uL3HkvPuTBuxbJAz2FVDMk1OxIOl0BbYNa9YD/yb+UrJrO22Yd5BOJUn0Vy4lHgdZr8AlAs7gchljtaU6RdwJeghofSrjuFnvoCKTKeo00msEybznJxkyIZ123YeHyhXMf3Corwo65OLnKVaKPTWVeqjaQbLAHzsRA4MB2sWqqRnzOmDL2KYhl6kyVAUcnAfWyySlPdvZFuVP90ImHab7Yn7bGqXl/vzOijdGoJ3KbNbreTkFjQAYGl7+FVPhbgBW1nBpPh7hVLa1e1QKy8WTTSOxj5iCgh4iwNz6PDzPLKyGqL3BR111/6LvjNGwBXVlxqPdZoeDcKUpTCqMH56Ty675xjhDM5sUaZ+RB7/XfOA3BWtg1HphMZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6666004)(38350700002)(38100700002)(33716001)(6916009)(54906003)(316002)(8936002)(508600001)(44832011)(5660300002)(6486002)(33656002)(26005)(186003)(86362001)(83380400001)(2906002)(66946007)(9686003)(6512007)(52116002)(8676002)(4326008)(1076003)(66556008)(6506007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/LKksA21NheImts1f1YDlAJytfTKagb686p6MWFe4rHyHpcaKaUrUbDqapPV?=
 =?us-ascii?Q?MzZNhaRSt9unnybJr9KMzlLcIr9IHLdOc4M7sLqTufqssR1PnjJyp+xsiyZP?=
 =?us-ascii?Q?2EPT01I8trg1VqYR1GdLXSTSGtxGbqftHi6HbI0EkQ4u0PLUC5ErswxPQV4r?=
 =?us-ascii?Q?2od+cAlCq3Ze3AOZg9+607gGlFsMs3hRFw/K/0cfmlf8tlXjYfIFwD2IKaVW?=
 =?us-ascii?Q?6KnU5Bah7qoxSUdxEgEZQ7d/b9V95aimhd+1MRr6UIzx7ax60vGLysMbaK7J?=
 =?us-ascii?Q?ylfQNRKy+GkEmtX7U1AzfhGruplQE5sqkcq61L+X6t2WiPrvoaFwqLfDtARa?=
 =?us-ascii?Q?eaWiEDEL8CnqkSDxdFchOjTTICEY9Tmzsy2HNHHQgBgUnZQqv4hPhbshAAM6?=
 =?us-ascii?Q?9H+DUtRNPnFp9dsFmWAGR7f0Lcyzd0qYPs9b89uQs+NgVOTEc0BqFdFrUdSU?=
 =?us-ascii?Q?a2tOA6ZLymP9dT/XMXFN+6+JLZfEBoqSNV7lqXvsTLpEKnBs6Cu3fC4bnmK/?=
 =?us-ascii?Q?icoASRCtJBYdWca00Gp9dZHLxutxfnDHViKbihz6uzk3RCLt7VMo1ehMtQq6?=
 =?us-ascii?Q?uJNNH3w0fN/hdYjMXNobjvvIRAOl2g3JuDWv5aVnSU29GocvQBEVYgVDkzSH?=
 =?us-ascii?Q?UD8+k6eyFamevKVWw2YbNnjatxsnMjdeShlNOqZI1o6Ib466e3fEWL2iBsCj?=
 =?us-ascii?Q?SI6S6XpxRlSQNh1e8riYVBIsfFYHFGItfVbkPqqnAyBfc7Lqa8UCmpg+biZE?=
 =?us-ascii?Q?ZBeIHF6I2KCSEff3CF+z3S7XBfy1E74iDvfQHclXaHP74qzFHqLf7vIEpNH8?=
 =?us-ascii?Q?vQZ6f8Ko+n1TdYkAnGhJxdPtk2B0CkSBub3KfalNTQzbksTXriA6SWEvGZFb?=
 =?us-ascii?Q?bRgnsHDpLTPQzpjhMlHmk6oZIz7aX9d87m9peVD+vxpMDxCyfOTwYItRiBKp?=
 =?us-ascii?Q?4BJWr8t0Uge6iYPeDxLiRG3mpFuyfZpylEOTtxanVyjcCADolPoE9dE2+BHK?=
 =?us-ascii?Q?WzPyxLS3AA2Gj2EG7WBo/ljaf6sc7cmKGP+oXmrreIiXPc+sfqR0/TMJqrQy?=
 =?us-ascii?Q?hjLqbN6e5bZGuAsHvEVZqziy0oXGKE/9UBeFFT1iE9l6siHTG/x80GjY+o4w?=
 =?us-ascii?Q?bxtw60B6quF5lzS0XgO+rBFnvr3r+Lr0NwYS2YsaMliUZB88V+eaHVPhd1mQ?=
 =?us-ascii?Q?SnoznrcLHGjbPsdcucwpqSdBvgE9X36gWl5BPemii96BsYkG5/U4jrmXvnR+?=
 =?us-ascii?Q?wprSRS/hP0hzhtaGla75qyYNr1IaVBOubTf6RhiP2MPxVy+44iiArJ/xpw4c?=
 =?us-ascii?Q?nT74A2Tbt34BYz4QCihTTkRcmCp1LG/Hu2O6dxXfGvokVLsUa3jQlN4OtkW8?=
 =?us-ascii?Q?vnVAFGDJMLfDHRgb8o1UE+HEt48O8BGvtDzWZU1pK4cohspxNASTyZ1hYvOU?=
 =?us-ascii?Q?wysxl51nmTxRwbpC8zuKLlDE9aoHIC7XMmzB+qNJCmHE24jhZFWnzg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646f2449-fa4b-4b3e-7206-08da0be1d002
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 08:56:11.4839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xut2z2ErB3GWK3GUNzGAwMwgpm10AYXateat45N42493P6ycIPf9im6quUG83BP6Bjrhggsen1nnDdoWcq5hoHKRGGX9JzkOldKuVPhxoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5433
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10293 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203220053
X-Proofpoint-GUID: CsbYC8dGMIpmTll02qc13Zd-gpQ0QDFW
X-Proofpoint-ORIG-GUID: CsbYC8dGMIpmTll02qc13Zd-gpQ0QDFW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 11:49:28AM +0300, Dan Carpenter wrote:
> On Tue, Mar 22, 2022 at 09:38:58AM +0100, Fabio M. De Francesco wrote:
> > debugfs_create_dir() returns a pointers to a dentry objects. On failures
> > it returns errors. Currently the values returned to visornic_probe()
> > seem to be tested for being equal to NULL in case of failures.
> > 
> > Properly test with "if (IS_ERR())" and then assign the correct error 
> > value to the "err" variable.
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  drivers/staging/unisys/visornic/visornic_main.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/unisys/visornic/visornic_main.c b/drivers/staging/unisys/visornic/visornic_main.c
> > index 643432458105..58d03f3d3173 100644
> > --- a/drivers/staging/unisys/visornic/visornic_main.c
> > +++ b/drivers/staging/unisys/visornic/visornic_main.c
> > @@ -1922,11 +1922,11 @@ static int visornic_probe(struct visor_device *dev)
> >  	/* create debug/sysfs directories */
> >  	devdata->eth_debugfs_dir = debugfs_create_dir(netdev->name,
> >  						      visornic_debugfs_dir);
> > -	if (!devdata->eth_debugfs_dir) {
> > +	if (IS_ERR(devdata->eth_debugfs_dir)) {
> 
> Normally I would say to just delete the error handling.

In the normal case checking debugfs functions for errors is not
required.  The users all have checks built in.  The exception is when
the driver dereferences devdata->eth_debugfs_dir itself.  So when you
make these kinds of changes do a grep for eth_debugfs_dir to make sure
it's not dereferenced, but normally it is not.

But again, here, delete everything.

regards,
dan carpenter

