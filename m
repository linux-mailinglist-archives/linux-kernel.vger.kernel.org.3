Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498024E389B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 06:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbiCVFtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 01:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236967AbiCVFtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 01:49:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDB5DF00
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 22:48:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22M1ECDY019205;
        Tue, 22 Mar 2022 05:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=4g46Ix1Jyy/t2cDy9BdfgO1Fro4EXiH9svAq9VXmqSE=;
 b=neZN9J6pJmGSdG4Ge5hkZnFYjwzCeokGCKrATZ7SUSRJhIbko6r/rfHnuWQUHkB8yafX
 XXAYMrNfAUHESfmn81A01qJOmX76sRO0HywXS1kTVbIKot2y0hKA1tqZVSvZTlds/Ev5
 UX5DzDfdy248UU6WGvsvHu3agiHTKWLRV6Ew5xjA8UZ5mPW2qk50V2sJhNUsqU/OpZ8b
 hlBBTLnLptzGhdRVUaG2Jdtkq9QG6BU1K0bVsiO0W7diUEXJTDuSeoEErEk/qOh3xVUE
 Mse8XJoz5E07h002rNEWrVlU4ljG8PwCQ8Yop8MpzWygVV9FMv/eMrLAcAjULiJHwDbx HA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew7qt59pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 05:47:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22M5l7qv166387;
        Tue, 22 Mar 2022 05:47:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3020.oracle.com with ESMTP id 3exawh8b0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 05:47:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZE4qT2P/jNbvwOkPZnPvVQ7iQ3aZD14qR1CScsjAkHVeF2U2J9tradZIpa+XmqNizods8Qt1exor1FkHAlwEcD/nuhgzAM20xu93IsjrtpkowPRemr1+fNX5w8EnBCKuypIigoStdcLoj2wAqnXXcbB7MZto5ftGEj1qQYr3bC48VCoKM5Wl/WWzRJq7269vw3GDUN30V2MkPGgqWKY0buVHMJO6PKKI5F08Cj1UevQeHNq8OfDBTcKKnn1bM/1/vVpyEaW2GdbheN7xmyP0xsom/dXRRar6BLWcY2LdFjcJD+fxTGjRqNslbLE/ZWacnf5FIx5JYhYDDdA3a8h0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4g46Ix1Jyy/t2cDy9BdfgO1Fro4EXiH9svAq9VXmqSE=;
 b=j1HWCXv95KeZA8aaB2xoHDTvFbrl4vOk7ofuc0HqYse3mvGSkpTI6773sufNnZ+dlX7JbFiivU+pWjS5ltKOT2SuviP6hgxGi9TocT6AiDWx5zUgrWPORZ0VU3SFUr3H8EOmLjMk8tMtlzwedE8zeXROU8Xzc+2bicqP9iRNyfrj2MfEvNbtcNLyqRLXw5C6rFjXUC8/OEvvwPu0c43XOJ2ly69d+PJg1domjNeoBTCP06V3hW4Ha6dhdVvmjeas5osRULUWDCb5UcqTpI+hbLXjmplJIcaMUO8CAnGhZXKMLt8c4JWs9WMjS7QU8eT3pLFNDGSEcTfoqWmeL6+2LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4g46Ix1Jyy/t2cDy9BdfgO1Fro4EXiH9svAq9VXmqSE=;
 b=lz6BMNdrmB9iiA27vqBkfLsUF7i5ktI0iB0k6x4e4r2Zd+eZ5RkMad5H1pNJ6AXu4+ZYXJcBswqQgZLlKdlwTMDM2jptYCHFi7UJgS/JdNKFN6OcwgJi544gm+ao0b8wmux9HTByvuaSEWd6Uwl9aVobdaa4MhWx/LRPzH/2w78=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5486.namprd10.prod.outlook.com
 (2603:10b6:a03:301::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 05:47:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 05:47:50 +0000
Date:   Tue, 22 Mar 2022 08:47:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild] [djwong-xfs:djwong-wtf 349/351]
 fs/xfs/xfs_bmap_util.c:1372 xfs_map_free_extent() warn: missing error code
 'error'
Message-ID: <20220322054726.GR336@kadam>
References: <202203190831.AYu7l0vX-lkp@intel.com>
 <20220321215908.GL8241@magnolia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321215908.GL8241@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 878e72fa-0b10-4bed-0af8-08da0bc7803f
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5486:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5486573F2EFE523B96DDD34A8E179@SJ0PR10MB5486.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJvHfA2MDT+GinZRPfmqjB+t8fKlb63kQ/DJaVSktZQEiwMvEEoK4GimeGyJJSmSnfToYB3GfGKKbFx5LBRwEYpYxQbj71xQZztvvLfnPj3FZSsEOvJ9B9rhFbDpzafpEmuYV+rdwH1x6Wm/Li/yzfLi4shKB26EuaNS01bEG/bHTjKB2Bt3VzM8uooaGufdLkkWfw68lH6aT/HtbUcbM8q7KjkraZ65wxo7HCinr/ok0MXqbET10ROfCS+TdtZeJjG9ckYzC6T3B/41iw/1dz3cVmKhFWVpXhaB+klRsKRFOmqP+NVTQQpYOnftuIw49lxsOtm2dmCpBK4iKnxj1tmPpRP4ImQbCpiSzwORgWiD2ckMsIJDuxdByoWoUiT268w4LXETuNB/zGl6FxzoVOYM1ABstnyxUXc+Q81bC/29s8ZMmgwmzzsl3UVbjZapJgNxz47Tv1kb1Naia3jVUIomTNUzUycbRmu2dXhpCwQ3/8+rUp+JOZJZS5bsvs4sr9M/zU6mCTCcRyHIU23NuIzHjNOA8k/+UmRBgUdmJxP1BIdaFnNnrrSV3caai4u0AgKARBYkPLAjPXLGgsfI2jC+JO/WzY0JGOMe0AJ5qb4NzcuN9U5XYB4ZPCvgpkdGvyx5/AUU+whbUUq2Jm2rbx+iy1bgrgWnTlet9BdG+GrG0VZew7vGrvAimYFpHaKv6MmAWhIr5R6Xlk9/a4EQVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(52116002)(33656002)(508600001)(6506007)(6486002)(8936002)(5660300002)(8676002)(4326008)(6666004)(66946007)(66556008)(66476007)(38100700002)(2906002)(1076003)(316002)(6916009)(186003)(26005)(6512007)(9686003)(44832011)(83380400001)(86362001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hBXDZDSONNYP0G0gvlPYT8cjZbPJIKbPUXSFtPoI8gzaSI2eQgOBQACuCs6d?=
 =?us-ascii?Q?UMnAutNcOlKKsOQdL6Up60l6nxhQjneB6mT8bcZNYhdzEHI6MvhbDd7B9WfO?=
 =?us-ascii?Q?wB0jtKZm5K4JYIwINkrFU/RdflCH8aCzUt1c32MV5RXkdy890G3dpVqsTmE1?=
 =?us-ascii?Q?garFnEvvMluK3BzQrZDC8+NuJrH1u6Yp1OW9uTYuSXpi/fy+gn0HP81ws5tc?=
 =?us-ascii?Q?T4hdJ1J0LutkizUrtldeuyuGZ2cOXqOhk9HcSQOwDeaqHHxcnXBrZnOPXMr3?=
 =?us-ascii?Q?9Dz5EEyaT6hq68UE3CED2krmx4ncx4C8BvQ1se4mdjhBbzo6nknpa0OPYRPY?=
 =?us-ascii?Q?y9INvxqfA1YmQ9sDAoNLB3rY4jM/fm3oa+fBhAh0R4nJrD1cREWdXPimOAhB?=
 =?us-ascii?Q?qXsCIRGBKlQeVwoA6CEVWY5Q38GlWTM92hfcn9HeDAgzunsCqYlLgsLtqOsQ?=
 =?us-ascii?Q?04cf0VbXBKyKMZ0WlsRY3eDL82WC9v6QtaEjCfzdnP/WxhezkQXFv3LyUks7?=
 =?us-ascii?Q?vtAegpSqPpSo50bPN2dAnG/d0AFB71iaP0DeUPvuXn1HOpACNQftDiavuABq?=
 =?us-ascii?Q?zsd4VjAQkmbetOYPY91SGnsCzndoobMW7efsJ/an5w+cZtbHZb+tUzzMnCWE?=
 =?us-ascii?Q?hFPHmT2ho5SLRgCBLgbqKEyJdwMZKioh+buWgRIq49bPckWX1iGhUZAupOUo?=
 =?us-ascii?Q?yNg5N1sy1dVuRwUinLBjEOCvVBtnxUnMukD0s2ibvGaCzJtCU6DG7nVVyS/S?=
 =?us-ascii?Q?eRW9kr19PatwH0lOepL7gS3gxLpx0almSkJjcekPNRrFNaNVFOZN9OYdtrIQ?=
 =?us-ascii?Q?wi2T8PJfZGZnb240HW4ykYQqaBJY87Uo/j/hRciydSkvT/xusZe41Ihrp5kM?=
 =?us-ascii?Q?XlsSmLYOpbjd0zrDBPsqdmqwAreVPtrQnGpf/DFBzckWnXfYDo1zcFecPKVc?=
 =?us-ascii?Q?T655t8aNLmEBxcdsicCGdB8n1ZEObLVbVyvwC1QTSJNxPqO0jduP7P6dAN9M?=
 =?us-ascii?Q?LxvEYA7C4hqFysIPi4xSgeSkbU6GSdUxUXEN07Pt+4yb+vTCHS7TDvfRkTvm?=
 =?us-ascii?Q?dWonG4pG43mQ+XCQ+l4e/gaDP9WA2PTnWiKguJTeQa6aSJ4QQSt1sUliflkd?=
 =?us-ascii?Q?d8GeI8ocuT+I674abUYUYwG7vP1AzX2rwN8vl3sQmUyhO4QGy9RLiKDbOEun?=
 =?us-ascii?Q?6RnupJxYE5z5DyJvX9QSXIplI6YblKWlZsTL2/hyCl0+f3hZSAiBbF/vWyXn?=
 =?us-ascii?Q?rVU5xjq89hfqHC1OoYmGt3ZDIjJFliF1nMvsERkgE9KeIZGd+iTuOJ2RQzwY?=
 =?us-ascii?Q?egqpb4e0uOBcEZKURfLrab+e/QofYzl3mMs9lQCAsY2Kz3MNRXIcQ60C+eem?=
 =?us-ascii?Q?w3BUCvmg9nCaShXZpy9hLln60Thnr+d6nfcA61psIfH0Y9rBEu2tgnV/89xw?=
 =?us-ascii?Q?pU7K8W8d0sdsvaAdh7i8BoIQ2bDHu6ZfeAzpwl6iY5OuTdjqcU/DDw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878e72fa-0b10-4bed-0af8-08da0bc7803f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 05:47:50.6546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VD8/IPm8GBtUOiirHUmzXSzfLpNFDFxT+iKzPONcX5N7rk9YKqoHdPHx6MR4EL79F9/GLWSI2r3AMwloqXEeWctroxU6teppYSy7+8+n4yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5486
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10293 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=780 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203220034
X-Proofpoint-GUID: p0haV05CKpK5Dm8uvsQ9uvMBIoNwV2rY
X-Proofpoint-ORIG-GUID: p0haV05CKpK5Dm8uvsQ9uvMBIoNwV2rY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 02:59:08PM -0700, Darrick J. Wong wrote:
> On Mon, Mar 21, 2022 at 10:33:02AM +0300, Dan Carpenter wrote:
> > b82670045aab66 Darrick J. Wong 2022-01-06  1365  
> > b82670045aab66 Darrick J. Wong 2022-01-06  1366  	error = xfs_alloc_find_freesp(tp, pag, cursor, end_agbno, &len);
> > b82670045aab66 Darrick J. Wong 2022-01-06  1367  	if (error)
> > b82670045aab66 Darrick J. Wong 2022-01-06  1368  		goto out_cancel;
> > b82670045aab66 Darrick J. Wong 2022-01-06  1369  
> > b82670045aab66 Darrick J. Wong 2022-01-06  1370  	/* Bail out if the cursor is beyond what we asked for. */
> > b82670045aab66 Darrick J. Wong 2022-01-06  1371  	if (*cursor >= end_agbno)
> > b82670045aab66 Darrick J. Wong 2022-01-06 @1372  		goto out_cancel;
> > 
> > This looks like it should have an error = -EINVAL;
> 
> Nope.  If xfs_alloc_find_freesp moves @cursor goes beyond end_agbno, we
> want to exit early so that the xfs_map_free_extent caller will return to
> userspace.
> 
> --D

I'm generally pretty happy with this static checker rule.  Returning
success on a failure path almost always results if something bad like a
NULL deref or a use after free.  But false positives are a real risk
because it's tempting to add an error code to this and introduce a bug.

Smatch will not print the warning if error is set within 4 lines of the
goto.
	error = 0;
	if (*cursor >= end_agbno)
		goto out_cancel;

Another option is that people have started adding comments to these
blocks in response to the checker warning.

Or if you had a different idea about how to silence the checker warning
I can also probably implement that.

regards,
dan carpenter


