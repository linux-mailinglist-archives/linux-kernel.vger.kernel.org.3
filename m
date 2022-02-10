Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA834B07B8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbiBJIGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:06:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiBJIGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:06:40 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734791089
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:06:41 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21A7n4oH020151;
        Thu, 10 Feb 2022 08:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=I/Aw9/jbhpn0UaHLKYjNjTh3PrljViVOyoqAEjhUQ0M=;
 b=nHfWvtRDSZ1rqy/EjbcnaTdIIM3M3VuyGcba2g7c3ULKSCCOkb1v1cWvdQKb9Qw8nkIa
 TpX9VbqUFdATZ+1Gn3a2lSPqDk4KrFSP3Y/nMCf1qHK7BXf4hNneG/fDaWZgpSt0j++8
 d48WE1pfOOmHNif7Bw6K2mpDZobSWCEg+IEKEIr60PKWVhH6M4SWmGL3okZqJppbSYoE
 DvUV/DHYXw/Xx9v3rC8vIvkC07t+Poox8/ubvco52woPa/E30v3DOhj3hmvZopcZGfHo
 u4L1EfAC/bG9lnOIhDxDZs1+lynY1QplxCiFyZC0RWJs547az76ynTAGZjChA4G4HbJY eQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366x0g1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 08:06:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21A80kpK117033;
        Thu, 10 Feb 2022 08:06:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3020.oracle.com with ESMTP id 3e1jpunxw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 08:06:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dosizQ30n5gmb4N5ARhBTTpLqegBQ9EzX9j0J7MPQz9sw92QjMDH1Aj35TctGlhj+cn/dBVKfNizCaG5N2FoHgZQn3Du6HVZdoo1BLZK5YnPOBojoe4JYLhFl05tXNY/LPEK5svLbh5K3hafrQ1LUAl/IFV0LOhVpUL7iPBy7gwdRHH5rd52X7XnpHjczvsyDS3wDcXYGeZlXDF4WEOFCFCOeeL0+rcv6DS964Lrpx07Hi7MvYmcqZW1F6lZmXPXfzFMjwmZHY9DIFksLaB9qyNW9nfcI0nXqxEqIo8Vrn6PZg17FzONHYZtvRgfGwUeGrzPbBTWw7Cf1sFu9xVUoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMbs4I12WxQ5+h1CO4d4N0eQqMm/bUS8PISH3QdkHRk=;
 b=lyHnrJGhEX08mjbUwD4Hwt5nzqKczSqXRJ0AwS8UDaxPcyRCia4w9CqAw7nBTKNwsgqhjytlO5fiKY7ZOaAM2vTdL8FE9wZ0C/xMSQMftfzefNBdyhBucnq5LEmKHD7z01x9PIPReat9IN7FQyjknySa1T5n93A+jrW4mcefvgabkguo3tG5smmYQg3coFjFnEJpw4jzKQapN0+L1mTafDcgaAJkhwsTXpJ1teSpxtlaLrblqC/y4GXl9u5rOT4YW3vgnWHs68RAZGliVgTJHn74IBzGr1gedz+Qnycb4I41OeaDqRCSrJ7a/8avzE3qzA7fWHLjg8vKuLrldZABQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMbs4I12WxQ5+h1CO4d4N0eQqMm/bUS8PISH3QdkHRk=;
 b=wxuczik59CqQfdxOZ6ERvVPZbMWpnkLqXGxOoZaTZ2COMU/Y0AV+T/MrxbYLmetBggyPjcJ1por/XF1foPF2vJyEGgbXPK9opRgsg+556p8gyliPgobgqQkNwecUyDyYQf2Q9BHT9LWu0pYsXNV2Pl0XEyqSuWdeMKeUVMhkg/I=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA2PR10MB4425.namprd10.prod.outlook.com
 (2603:10b6:806:11b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 08:06:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 08:06:28 +0000
Date:   Thu, 10 Feb 2022 11:06:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        'Jiapeng Chong' <jiapeng.chong@linux.alibaba.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] staging: pi433: using div64_u64() instead of do_div()
Message-ID: <20220210080603.GJ1951@kadam>
References: <20220121114955.96979-1-jiapeng.chong@linux.alibaba.com>
 <03591933cc384d7e91ede82f0cdd76a8@AcuMS.aculab.com>
 <9c563d78-f883-65ee-9e7b-cf44e3b238e8@wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c563d78-f883-65ee-9e7b-cf44e3b238e8@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0069.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44c37fd3-660f-435e-794a-08d9ec6c3d4a
X-MS-TrafficTypeDiagnostic: SA2PR10MB4425:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB44251B36D348400DCD27F5518E2F9@SA2PR10MB4425.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JRs5jUnNoSEa/6vfKYzmxSkOpYnUAD69T/OiR6oW+QnV5Bqnq+u3OJE/mJAWfDIz1mSx9pohZyFaIVeZMtJAhp8t2XkmmNc0bsjAEatVhQVdfGWiFxjyKoczk2ULRmtJA6VKpcOb0w2m6jVi2wUdg7mwv5ABqNrxMaNyJJilV7cuDf7jGPU1rXqd9Y97jmIZAm77HP6VxZqLlHCwU7lfsqetTvfzg8CxUf+2IrmmiFDNOFFZqlUKysmi/zJp7VMvj6qWGhBID72nmOBbrE/krK8jA3gZgmxsz2yBUuMqjsoNFS66J3oJ7bP84wDNo3/V11xh2dnQ82xClJU8e5LpIt7HLl5tXQOa9OKCfaBzRKpmz1BklqspNQUUQxKZgI+VHON9tkF9TJJ7as8Hxl3CFO6qUvf7fmUVkd6SWFHwvwhyWeT7zC3/opX6r3rtxUUHndlbD/CgKXAKu6dVejwOOevVnmn8Xh5jbB2aRTkOuCOmPusYjF747lhV6Xwf/JtuCmdvwjZxFBqh+YMt3oVjil3GNjuXX3OQ3ZddIW7A2m8ff71eAuzNrzgLtGVWQtwAV2T661n3L+hgRw47tTK1lxw0UUv4TxnIt6EGFmT10PQLVmBS7FD8+TJ/G9VoaEHRWf0/8Gle02SoHJiZIY8Rr4mP40xkcyYagM31X+FsU/6wQtRvD/rsJeGYhvLQ0krOh4l44pNIr3sF0IJq/eH04g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(6486002)(9686003)(2906002)(66476007)(66556008)(66946007)(4326008)(8676002)(8936002)(38100700002)(6512007)(186003)(26005)(1076003)(5660300002)(86362001)(66574015)(52116002)(6666004)(53546011)(38350700002)(6506007)(44832011)(33656002)(316002)(54906003)(6916009)(33716001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3wdkRkzspH8t2xL8Hx1O58lvw6zNosOWyymu8YJsqRnY5i6xwuqQH7eVYB?=
 =?iso-8859-1?Q?O6RuHWRiBZSkFliRLuTkKvyQ06cG9TIg5H2NAzJTJ5jvNhaWw1HYZNgVQG?=
 =?iso-8859-1?Q?1br+keImhCypmn+OELj5Pv5cDVtPyx30OMv+Gl9QOcXqSsxCbgsZdd9v7a?=
 =?iso-8859-1?Q?+Dl4YgCUC02tEqCQxrpJ39kNX8WdTHVBhmdKNQsojC5pTdq3U96t7MUWnS?=
 =?iso-8859-1?Q?VujnuDfIutP3Iz7GAEGHaIHBL8jzwJV1G0ODxY2l5KmP4+hqdtZLuz0Ehh?=
 =?iso-8859-1?Q?f2yBzlbPpRvEa6+JWvNbQhgrWT2TF6lxGlMEovBjo7Gpc3jj1JUiCL6lma?=
 =?iso-8859-1?Q?YsjwslpV49MEebfUX5g5VOxTnTTYCVALvdxZALxUlSz/zAA4j3SBsHkdIU?=
 =?iso-8859-1?Q?JwOVXJ6lMoWzLe6oAyd3N7hVhxbF+8W43fyLEsMIOM8awElJYNeVtKmfm9?=
 =?iso-8859-1?Q?NVF2P8cUrUw8viN6aQHLFRmDoBF1I2iXoO6Jlwacv/J/MEIifxLWavpd/O?=
 =?iso-8859-1?Q?e/I9y7L2c7v2Nw64zoSUarVKrDT3xFavNwYtarPDPr6r6b1MKk0EORbT7g?=
 =?iso-8859-1?Q?cPBXPRM0Wu1j3KfVnFg5nIZCy68FmfvMVGwv4PUpG64G3zZlktIVyWyuM+?=
 =?iso-8859-1?Q?cCwO4jKUu8cJlfNCac08AWv5vhm3dNFHI/rd3hb0atGIrtGRf9E6NmEKxT?=
 =?iso-8859-1?Q?5tYtxh2+/OlxUlON40t2qSSLIPvgIRCIOfBleMvBJPU4EGIbUH0sCnJFm/?=
 =?iso-8859-1?Q?RaU2dpTCtcjF1bOKWtwK2a38CI3MTg4rSNFmBB9KBLbu8vJKnJKcWHs1ap?=
 =?iso-8859-1?Q?a8i4cO3VbIAHs9C5M6v79sPAO1sGhq27Mci7c8OxCScZruAglrUeODY/2a?=
 =?iso-8859-1?Q?nwA1YfUh7mH9AM+4SbsmfvMkYusE8fMC+GdO3JYm2XH8LjkcusYzkQv6Tn?=
 =?iso-8859-1?Q?ADdj4gQ9F82lc2jRMJ/BMNOHK8o7HlE/0V8DCUWtSrv+KPEfF7l00xYDwK?=
 =?iso-8859-1?Q?pmkrCWEAneQwztsdUD22OPf0fefy4BS4NUN2VNnWOxkkjrh1BO/p6U3Oqt?=
 =?iso-8859-1?Q?Z69zXzljNtydmz78/+TDkHEt/+GX0AIRw80Ziae+GeLbGuWZJ/hWtc+6Go?=
 =?iso-8859-1?Q?QFqV2tsPBgpsqNdlzu/QzRUf0/nyfb2WbIR64bNAeSD9L9GTcMc3Wg6yz+?=
 =?iso-8859-1?Q?TsM4ZgPtOoH0LLozgt5YjTtCFB/uThUxq99E++koIDr3J3unKqWTkkSq2J?=
 =?iso-8859-1?Q?lAGZlinD9s2SgslvCU8f5U+/vtVme/GLgKKWq+NJpDjPrFF12Ffn8bV+8R?=
 =?iso-8859-1?Q?2xPkLp+Rlj0+8WhfTmP2xekRJrPiSDy83wP2hs+S/Bh1RBUEOiiHlqpCQ3?=
 =?iso-8859-1?Q?0GsShWzLLdT/8YJnk6XuEtjm6seVrmacXK/ZhYrON09z0as8Sk9ltShr8B?=
 =?iso-8859-1?Q?biWXV6CyZ5z4Ih7G7sCkFYhUuARangtGt8CGWC1svdsir/GErg0Xf0mH8d?=
 =?iso-8859-1?Q?VxkPfMRDkzcCrioYD/+d/QV8aprMXPGN/6Rb06jpgwXaOKw6XTtK5f+4Bt?=
 =?iso-8859-1?Q?Xe31Ooyy7gUvTOg2x2ML/PZsKQbUSzXVH5NTRrPRccsX884FgHqjh1kwYS?=
 =?iso-8859-1?Q?x80444PtQemEev1yvh53mzc/JThNwNxSGMmLG8gpKiJDnvSXnSS7ILVjCs?=
 =?iso-8859-1?Q?wpC2jPbg8BZGOgzxMAgdIMEd3EJRJLg66fkNvBUcc0N9PvHHnFQddjvQ1E?=
 =?iso-8859-1?Q?CQWg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c37fd3-660f-435e-794a-08d9ec6c3d4a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 08:06:28.3549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcpdD5z98zmLSie8T8gH8DhcfR4W8odhcNOVzI245Rk0KyywqnB7uW1Z/0ag36WFI8is+j1OUlnM6+IVY5aXhEtcWaFm8u1fyk3CkwisitE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4425
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100042
X-Proofpoint-GUID: 4cD6i82BcxZP1el39_kTxI5jBIjo9Ubs
X-Proofpoint-ORIG-GUID: 4cD6i82BcxZP1el39_kTxI5jBIjo9Ubs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 08:15:13PM +0100, Christophe JAILLET wrote:
> Le 21/01/2022 à 14:34, David Laight a écrit :
> > From: Jiapeng Chong
> > > Sent: 21 January 2022 11:50
> > > Subject: [PATCH] staging: pi433: using div64_u64() instead of do_div()
> > > 
> > > Clean the following coccicheck warning:
> > > 
> > > ./drivers/staging/pi433/rf69.c:286:1-7: WARNING: do_div() does a
> > > 64-by-32 division, please consider using div64_u64 instead.
> > 
> > That is one of patchcheck's worse warnings.
> > 
> > You need to check the domain of the divisor, not its type.
> > 
> > do_div() exists to avoid expensive 64bit divides when the
> > divisor is small.
> > 
> > 	David
> > 
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > Registration No: 1397386 (Wales)
> > 
> > 
> 
> Moreover, the patch is broken by itself.
> 
> See [1] were it was already reported that do_div() and div64_u64() don't
> have the same calling convention.
> 
> Looks that div64_u64() and div64_ul() works the same way.

We could mark those as __must_check functions.

regards,
dan carpenter

