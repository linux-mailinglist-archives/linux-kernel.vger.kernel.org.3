Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDC54BF17E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiBVFlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:41:16 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiBVFlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:41:03 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642569D0ED
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:40:38 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21M2ZoeW006502;
        Tue, 22 Feb 2022 05:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=hwF5ePGSkMcboOK5Dlqv6ifyGMvo1IuadecpAsX4puM=;
 b=c48Ca6q0DNgqNI/HWt9iEzKlBw2FBFOOGXc/04L5uw8erHk3xuRLWKuOsjPYH19RPatt
 Y8O4OMPS9mtrFxcAhbre3vzAENWh4q1UCTS5C/UWjvwlrbHX3KfF1eJhbQQ++j3X1nGy
 9ps0pvxT+dTyp+0RfMBzpct0+YvsZldAlpJidXXQcxddHFSSA2i8PVo1b+99EHNGtIeN
 9UEWv90fSbDjIZt1zRMaK+GuY75nxUQBWMrV88JuKuohGCBiBvOCtW+bfOPHFoMQQd3B
 G5gqQKZcWAZqMaz/oiOBCG4MxzymERPYFhogUuAncV8o8+sfRY6TUSF1x800K6g68VaG ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eapye5y9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 05:40:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21M5ZX2c193544;
        Tue, 22 Feb 2022 05:40:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3030.oracle.com with ESMTP id 3eannty9yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 05:40:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1Pspq2fp3nhYE7mGrD1NW/MbIgboPUQsqrsyA95/Fvhyo/GBtSiP1yxo34JVcixsp5rOrrmNJ0Ot6prTeCDYbK1dGMFmUOZ2tTx7/Fo37P95Gj2tLWP7u/6lSYwafuoUGEyNVoV1FIQu9ylLnDyf74oEwzjfXug1n1B8+nxTHuRf7NOaXsKH8Cvn0DE8Qu8IOSjkeKM5EaEoxWuVPG0nQrdhbfrXqeD1SzMARNpiTYvQjPf3rTw15Swc5+ekiU5/3Y+H20RvkaxO4YEULWEWS2kVEi61tzptKxoJ/fUm/DDJeIi+A8RUDPZiOMDo6YoDLo3qXIzZvaedPgN+5DDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwF5ePGSkMcboOK5Dlqv6ifyGMvo1IuadecpAsX4puM=;
 b=hasz0U3j8znQMo36MAUaPqLmZsOEZ4xvbA3Gng5Zgh2sZBYsY/5V5D/50wFgn20i7z8o5BUU3cG96keA/oIiV8684P/vtm2zyCHe/m7UAZQX2gRUicUqc7UXogC11tvioNZDVMtLg1g/ytOZuNfnm+TSpjxb6nKF6OnD1qp77NdLJya+yH8EewHdg+bY8CLrTD8ADfZe3QpoNY+uqxV8TM+phIh2K1wFNIi3qUmCRgY8QMp9gsF6we3/Cvr9jnymdwnN0GJkihOfCZtd9z7BJl3hcM4q3ARk105Klg9NcSVG9wIFH6OYjDcqbjkW5njkZgGeBKLIiiPHxzDnEsX23A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwF5ePGSkMcboOK5Dlqv6ifyGMvo1IuadecpAsX4puM=;
 b=ARHFdCz1hJJO1ZZXl9egGOJTVnDClypboJq7NEzxhuGGrg6CCCuBwJUDBM+ju+ZG9VPZbS2E6IkNjSSIMM1mzIFTd+slMI0uO34xq0h3LhdlH5hbGr+KJDFIbHTZ7VwzQeh197hcB4FNBviB92qmt9bR/vjnQHAg46AcmhQTVAo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1986.namprd10.prod.outlook.com
 (2603:10b6:404:100::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 22 Feb
 2022 05:40:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 05:40:30 +0000
Date:   Tue, 22 Feb 2022 08:40:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: r8188eu: refactor rtw_ch2freq()
Message-ID: <20220222054018.GD3943@kadam>
References: <20220220154847.7521-1-straube.linux@gmail.com>
 <20220220154847.7521-3-straube.linux@gmail.com>
 <cb7db1ac-8e7e-d549-a5c0-fcd072ae815e@gmail.com>
 <94160654-ec16-cad2-3cc2-46628caaa17e@gmail.com>
 <20220221122250.GE3965@kadam>
 <32a2b74b-f541-ddf6-d8c9-6bd6ca0ad07b@gmail.com>
 <8d5cf235-27f0-9c7a-3659-d2b1fe7a02dd@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d5cf235-27f0-9c7a-3659-d2b1fe7a02dd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0052.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::27) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f471045-ae09-4c6d-2464-08d9f5c5d5fd
X-MS-TrafficTypeDiagnostic: BN6PR10MB1986:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1986F0282736EFA0EB9DDA468E3B9@BN6PR10MB1986.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ccpWiQSMm18QIW3u1WcDnuJ8kZqyjVMj60v6d6S2KV75PkcIUTJxGak6sMHsXoJwMU6exVReKMop/pOOCcLI0RXEZnia8js5ToIn9vN0h121TXM6rUeBppOb5tiwXNq0squ9KzxxY/UzTgMDoj+Q0NwHIj4Zp9CinknVygw6KHhlqOaZ3/MqffyQzTxpiKj1iojIV4TE6WnpgHf8MI5PwWy8RRYyy7FCS4avNhtvNacbGNS0humcNwjHUeXnpelPbgyMq+anZJpCNst+MKLwIjtvEweXBOP9Ey8THF7Eo3ezis30plZ7AZ9vdFqmqoTiwcPsGNjANIx9fPg18ADhbWi4WB9HK2FfcR7Rp6WeZiwtVjw8p4bto7Dyuabb3cRUnuo3Pz3hdjR4liWqgbcFlMPqyDHhNlrMgDr/tJswkTN9ILyd2RjUrOtP+CDS8nVQuo4aEgVn4/v5mmlcfnY0DGX50Fb/c3MYo8E+ynhgjFPKxOqb+Fvx+eUCcrfXNSrVAQgBjVoovPgTqGWJk5gP3HtAgtU2qnPY7BY2jnF9B2im9z5kbhqEpUrz5tnUFJX8kBV0/q21+HhEkmXPFW4AO1TPLg3yv/C/+OjJkiRLykRjsJBruDTbcb9exZOuqY2oIaU/zjeJxJqrWWAIlsCWgkTFdjy6XAGud9m6J5OGk7JOQ54HCh8XpUa9RilxZojwy/61ijTbZl1/0obZiM8NMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(33716001)(38100700002)(38350700002)(86362001)(52116002)(53546011)(6666004)(6506007)(6512007)(66946007)(66476007)(508600001)(6486002)(33656002)(9686003)(4326008)(66556008)(5660300002)(6916009)(1076003)(8676002)(44832011)(8936002)(83380400001)(316002)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yj8s2RuG3JZsPuUJHubUCBzVOaFpHajcpAHhrN5Fgf5ubqb9Mc/CmpwRP194?=
 =?us-ascii?Q?wNifH/STrDhQy9tHljXDrWEHggKu7XVlvQ0J/fZJvsSUAD7Rx6Araw+RkVoQ?=
 =?us-ascii?Q?BnP0dbMDHjpBhQIZU6qsjE+vqxqoneDNuqlYrHDQHmbtJHdjQxcM+zrFjNiQ?=
 =?us-ascii?Q?su4K9E28SaVnpu9s3eB7CD4NdRx4FAa/p4a5jCpVzFlYFLlr73athTYmvQUK?=
 =?us-ascii?Q?VlOBTFntezAhjSJOoQcxHpGbbwUvvso+fCSIql1kcFeUWki6TDrsrmy8TSde?=
 =?us-ascii?Q?NPqpz8olf2VQdlUXVkYfJb1awO998s9XbSJ7Cae0T1jVmOS6ERnZUM8fbyzg?=
 =?us-ascii?Q?chP6FSYAbjZ7JUilp3pca/2jKE4CLPBe5ZrTUNK6OrOWtPzxzN/4WKkb0Ae+?=
 =?us-ascii?Q?GFusbOj4KHs0vrjmQnrt4Udbo4YCJtW36ofzlNFl5gBCbstWOEr0rn0EDOcz?=
 =?us-ascii?Q?n0Ih+su+blPLbBF92LMZQdZPZlTC5zQRAp8ddODzaRyY3KrXvpBQeKAxiysS?=
 =?us-ascii?Q?3OHEXElfFSfUboHH9/BEmpwNx1bnL35TOwrXgYeBPuCjLiAxIeK+tYfxo6UY?=
 =?us-ascii?Q?To86h5ujLHIR1TO3Jj14Rt1n92n0e3rFDNG3NpBG0+K5ngyZTGPINF6f9BCx?=
 =?us-ascii?Q?+M5j8puZf+BlTkvInReUTaV1sqs3lj4OoCFcW5Pr2wFuipbsXirQ1fuzjgfj?=
 =?us-ascii?Q?xQdm45v63geGVGfQb/bjz44qNkkaZni7D+dgTR/Bto9wintgUNSTWyICd+P4?=
 =?us-ascii?Q?mVnG+UxS5LpfVVmlkOp/OCCQBhhjbxtkmZ34epClovxzdM9qkoYUUm6NoHd3?=
 =?us-ascii?Q?uUjX3Wjowe3kd8eGVAF5lVCiTAV1FQDYZd70VS/YULx/lZhEdphrZIFzO+GH?=
 =?us-ascii?Q?WrMHemfIxeaa0/G9+I1qXHIpzpp5rnkBKIYXCo2AtzgMCOXHAPAg4QiCLXaf?=
 =?us-ascii?Q?2sg1dbCftiIY94GSSZdlDjEE+HHpGsLNIFf7Uo38xZ51E4GOYGvNe1dvn5Q1?=
 =?us-ascii?Q?WZ30g5AZZ/O8JkupN1wjzE5bqCEh6OXZYSNyxywhUbldJiRNvb6YYk+vypcb?=
 =?us-ascii?Q?CdA8E3UPTI2RWzFh+UzTPvPM/V1W1l3rqGrdXVeqLIINyHEuBJggUgGneKI6?=
 =?us-ascii?Q?jD1iVVi2E3xhiLSgg6jgevjqPi+MTFKWZz0gvA2EZnjgNBZDZxmSgtHrVmBb?=
 =?us-ascii?Q?U3mwuUwMS3+KenQXNGtPkcFn7Hbm258voQbZDlwvBTij1ZRpbC0ARzsSx/tB?=
 =?us-ascii?Q?jyAew+F9sIAYzKjRyRYtSo1tb/woHr1XYZcxmPvzPAMKyfWGgUtUINgnMfwK?=
 =?us-ascii?Q?mu+fRr+6TplE/0mYDdmHzynYnGaiS2ydIU7Ye/Qn4PmvbJAqeOrQzkKRh29M?=
 =?us-ascii?Q?4ntDlqdAQNzF7pGXp0Gw0cOtZLLYwNMvbUV9bHN1U24tCLl/Zl78snvjqySB?=
 =?us-ascii?Q?GsIrTmwqdotX9bGNoeyfPKOxJLfOTLWCgu3ndbADe6pXf43HVXgyJY8YJ1kP?=
 =?us-ascii?Q?rTBXyhvSMk/T7n7QGi4KzB+TzrO6syTTTbUi1yy9hjyTyxZkrzq3183Lr4Vo?=
 =?us-ascii?Q?H+Clr9i0hV3yvmxbdDgfVPBLvDnxxW40vIrwUP5d+5gUxMOoAiaZK4vk/nmq?=
 =?us-ascii?Q?J0LWNSZ1MRkfHKduLnLIQSdgTISCjGokt+PqB16ySOAEXorl1sYFWkAx9y9O?=
 =?us-ascii?Q?LBezyg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f471045-ae09-4c6d-2464-08d9f5c5d5fd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 05:40:29.9947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0x6LpJ+jaAJB6aVtD2Ma7Yjvou2tW/gXgrcnNb4CCcBBT1ZqqPwf7faBjgh70NP7wNcM9ZGTBZoOnLU1/5hrJxyPPUpqmZMuDJ4vy+ydLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1986
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10265 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202220033
X-Proofpoint-ORIG-GUID: CT0lcKAq5fozFMKYUjzIBHRkL83f7U9K
X-Proofpoint-GUID: CT0lcKAq5fozFMKYUjzIBHRkL83f7U9K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 11:54:50PM +0300, Pavel Skripkin wrote:
> Hi Michael,
> 
> On 2/21/22 22:20, Michael Straube wrote:
> > > I'm glad that Pavel noticed this change.  This is a risky thing and
> > > should have been noted in the commit message.
> > > 
> > > Just from a review stand point it would be best to leave the original
> > > behavior.
> > > 
> > 
> > Do you mean to leave the whole original code including the 5 GHz
> > frequencies? Or returning a default value if we have a channel value < 1
> > or > 14?
> > 
> 
> IMO, your version is much cleaner than previous one. This table walk seems
> really unreasonable, since 5 GHz support is really redundant (I saw it in
> other thread)
> 
> I'd put just sanity check and return the default value from previous
> version. Maybe even wrapped with unlikely() if we sure, that in normal state
> we won't hit it ;)

Adding likely()/unlikely() annotations hurt readability.  Do not do that
unless you have benchmark data to prove that it is worth it.  (Hint: it
is not worth it here).

regards,
dan carpenter

