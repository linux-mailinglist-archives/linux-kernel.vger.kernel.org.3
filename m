Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337E051DC3B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442974AbiEFPhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443040AbiEFPgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:36:53 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFED56410
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:33:00 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246ETMPa016952;
        Fri, 6 May 2022 15:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=PPS06212021;
 bh=st7x3qi3Vxye/dbiBiFSx9Yq0Q16dDtSMHPqweaawO8=;
 b=BXVwKiojWpDswcXTPd6B1BE+lw9Jy6ly8Px/KosdB21SAIwM4kxs9m7/Qe7du6K5jn54
 RLgN/FcvDEKs8EFD5IGxPX3c0qT4YulocbLfQGz+NnUn96mVaWKtvdyvvJuQhOfV3jee
 Lmi2BRFXNaQ8zJkeSfKNScsSwOVeKhWL4VOiVmkf5hQKQa6eT49wZ0uMk9I+NhiSGDnA
 uDaZOOag7yGjt7X+JXCPD5ei3uWH/g6Jkd5WVOT+1EO+7m1QBAV8kV6A7wIdHN1HWXIr
 2q2sAJQte98gC63bmO1cuYQljoyrdNm757XNg2sB53ndM80tsQbULNGp3ADylF5nBSSK hQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3frv38vs1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 15:32:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoEkb+PT71VbZW4Zd2adAJmm61JPB0i4G+WHa5W02GgxK7kE6564KfsBKJylMIrDKNkBFdZkH/Ma/9LHJ/Y/quE8997iDDhEXo1mvUCF2tEj5rKOVI5c0/I3o3BNqKxWdFAsaa5CN8MQilZ3nNn7nR0bZegjp4YlzEf9VIuKEp8tFLwvKBcn5/uJ9DmasbEJPSzCppZsks/EcNtfFhau0y61B79BWX2Ip3gso+oKpSpnVVK+V0//CysR87qLweUyvOyXPtqdM6swjoHuzRjtsFh5sHKUXj/hnJwTjb4tl4+5+JI6lmJ8eJlyQ1NzVpr61RgeTMyI4np+cWQD4FFlDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=st7x3qi3Vxye/dbiBiFSx9Yq0Q16dDtSMHPqweaawO8=;
 b=i11H4jNf4uuxkiiWEgLBOFbBY0atz8IEEHrAZ9MuhKtiHOoZ7SMZynI1tT9DTtoER+8XrYbGD1X5ssSnB1S6TboqB6uEMG63W0obvBvHePdCnk2zCIyK2Y8VwDGM8rKO7GNa+hVsHa5jzko5JTsvKUuTxrOssNVOZO+5rF4Vxl7GUv0TnNcf/C7qQAZgZ+zyjN/w6mRlQJNjr4hajxnVLNYSywWR5/tYn4hCO9SLcjgPz5bFRcwTS+W/yeGXOcymqd/DxAX+duS8RrLtpU5ffmL2Fbe3Ynjz/vjA2jVHZpXavbZjyDBRMwxRXhPntAQKMuBFAJd7QZLStwB9fEcu1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by CY4PR11MB1253.namprd11.prod.outlook.com (2603:10b6:903:2d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Fri, 6 May
 2022 15:32:45 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f%6]) with mapi id 15.20.5227.020; Fri, 6 May 2022
 15:32:45 +0000
Date:   Fri, 6 May 2022 11:32:41 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 3/3] block: remove last remaining traces of IDE
 documentation
Message-ID: <20220506153241.GH12977@windriver.com>
References: <20220427132436.12795-1-paul.gortmaker@windriver.com>
 <20220427132436.12795-4-paul.gortmaker@windriver.com>
 <87wnfaa8ce.fsf@meer.lwn.net>
 <20220427165917.GE12977@windriver.com>
 <YmsmnGb3JNjH54Xb@equinox>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmsmnGb3JNjH54Xb@equinox>
X-ClientProxiedBy: YT3PR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::34) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd98fc21-1454-4a68-2899-08da2f75aab2
X-MS-TrafficTypeDiagnostic: CY4PR11MB1253:EE_
X-Microsoft-Antispam-PRVS: <CY4PR11MB12531DA5733D35E3A1BB375883C59@CY4PR11MB1253.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArCUpo3Cr6LnwCEBj4juM9R+ZCX6mTRAluA7ELhgM05eF5VyPEXlk37CwAU9Aqe8U8Bo8Qk/J3918eYQ1YLsvFsln4pmYarvWfYAfiK4xdU+4mmV0uqK8Q+ro1FVX7rIOzai1LXZ2mCHFbvkp4ozghZT23yRbfhuac0MfCHiB3jzcCwgKUjf19uDjo8TaIyYSVI9XcSxZNffF7PBapsEJgaTn9kjRSoCeO7KZKD48GGkau+qBVfKceejGbbrfpa96jXQGpDoD4+2jkqNRawJX+CaFKCoc+iL/LOZnWhRdRbOii5INTzflKFMVI1qdy+0Mq7qaQJLia8MHju55GhhZHCieFQMG9YUhRcer6dUPCqqN1Hz+Kyvpn7EXU6B7aWrKDeYEnpqmXCvCeXKZoBAchz4ioEGZiCY2LOylR31nQh5h7uZPBUe0mhDTaZ2eXmsbLmthl+KAsoR+b3qThgFci8e7Pru9lq13fJ5ExA9TBenFeBj5SNolLXX9KZj1cPlKyWPpqgIKcFUvwE6MrP3L4dWKO5RoidcZ621TSbzrqXawGtyu86nYKYBJRuBPGjmiWK7zoRocTKBMC5koVinL6h8H4NQx52HlXhmurPa8n3kVB1DiarvPtDN6y+FIa9tBBIKvP+fStTMsG6xqVfUrr7ZT4yk5feMWS6JUtbJwVup68A+l2hJ2MI8QZxmvehL9ujiWf1xtQHDdbDFHkOYCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(316002)(2616005)(2906002)(86362001)(54906003)(66476007)(66556008)(66946007)(8936002)(8676002)(44832011)(6666004)(52116002)(4326008)(186003)(36756003)(53546011)(6506007)(1076003)(38350700002)(38100700002)(5660300002)(6512007)(508600001)(33656002)(26005)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kl6i4X+XjfgKCVg+z6Txch+gwzwUXNDlMirzfcu19Lr6Bhan8p/Mi/p/xLG/?=
 =?us-ascii?Q?eUwzHemraJC6D4mO7VzppANHoxOj5RisrNvbGDORoC9E2q5kXhoUcuGcPPNb?=
 =?us-ascii?Q?4vwOG6uFl2rxWESf7oWBBP3bo2Z6qHE6pMNEkid1fsvfy/dQX72uii7IkwlI?=
 =?us-ascii?Q?3MmSt+Iz9NphiHS2o1D++FMwt91a9KuE8Py2EErN9+rYOBpA8fya+NsQ+sPp?=
 =?us-ascii?Q?+MYYM+NmOSYC7EeiY/OFrdzNDmsqzTNuSD6EyLC5XBUOhwLqggAWsQtk4oRC?=
 =?us-ascii?Q?CK1KxSSXYRKaC3j7eZRrKAJ28ciE5rb48jYik/crcW69hS4EAdrnWPTUEvDF?=
 =?us-ascii?Q?CaDk7cVX2L9Uf99zjlWaNNsXuz7ypmQDyh+5JaZNf2HaZ+z9DYpJ4BpWsaxM?=
 =?us-ascii?Q?4PzF1sTYt6ku9HD0psd7RNKfDJC5GHFJ00mGqiXqS4fTURN6qGiVrKEZgYNT?=
 =?us-ascii?Q?7cQvhYZ+TC7qP+vQrQ1zHq834avI9utOD8kVvKx6OlvvuRCZ7z4pfNCuMN30?=
 =?us-ascii?Q?yydjKAVZqkFBKMf1Lb7pI2CWZ7Zm6yFaZCs1PDTbZ7wuAC5mex2H+ohRWHaf?=
 =?us-ascii?Q?CAMWX1WicwvalDqIVNB10CJeHRu4eq9Gssqjtsw1CoK8E1FiGJnX+6PoMrJR?=
 =?us-ascii?Q?v6venTCgDFYdJIgPbHmDSmrLGXeePRjkDK6I30IB/vzrNp3vPlSROkf+2cIR?=
 =?us-ascii?Q?n9G63cmcKXTn+JnD6wL++UhTBhVNc/ZDMyxzh/NCHNVUeUOiOkJHpLfN9Uva?=
 =?us-ascii?Q?TbJ4gqJXwdXurj2R1xJniFkXun+1CPUuuVawKSlVoSv6BrQseWerBZ4/WUtt?=
 =?us-ascii?Q?GKzNsc6Ymooi2d+eomGzBgEqc/ObzHfR3s0oeCy4kulFOPanuDEg/ya5GLSy?=
 =?us-ascii?Q?8K7SLHo14QyC1/1WdoMwIHjZ13d/JTj98+aRP4+Ge1QL4L4IKP+czhymkQRB?=
 =?us-ascii?Q?JauHaBmlt7+g7lsx/vH8Rz+8PKWFf68NVoPldUPNDAKBrte3SZUE2uBR6czL?=
 =?us-ascii?Q?7TyXDDZwSfbCqmPkER9tm1iCWInlHPKxE6I+7h7Y+8J9iLp9by+pCxFg622O?=
 =?us-ascii?Q?vtgJeKp3F4vXwfqql64qOo3hxm2tDMc2R2cOhECVUw4yo6ppC0ehIyS6gOaq?=
 =?us-ascii?Q?vr/2nwfkFr5umoZMD4m7VXQGeGzzRzRdYPz+sWqtbshC0hswrrLK9JHxp5Ks?=
 =?us-ascii?Q?/j62AdUdinJU+2KyqDnQ62Hzaq4X42Fa5G317PZticLUaMSP63T+Cpm9ZqbW?=
 =?us-ascii?Q?h/4wfEvNmQz1kGoJV6ETHXR39Sb2RFvRdPudvcZqp+ft2BMbWIoTCYMoUh1L?=
 =?us-ascii?Q?BcQeczVGnp4W8peSsTg6i80g126SPJ+srBAF/1KqvaJzphYqF0OvI4zJWuQP?=
 =?us-ascii?Q?kQoI6FqEiD9dUyAoll8/rJkHZS/IIZ6tPPYadq7j+v3xsKvni83wlMr754hF?=
 =?us-ascii?Q?ucNw5Kk9yF2MBKOeXdfI9u82a6tlQ5sz7G6YE++BWhlFVPcsmJrMz7a6nkvL?=
 =?us-ascii?Q?7x/eOrqp1HNonLUBmyXwMXLS8bcIFYdc1iSfNhf28dUk878jnIR2kP5p0bFx?=
 =?us-ascii?Q?4He7aqvSMZgOxrZeL0CfESFKsc41CNX66ivyBbbcJzJNJg5O2w619T4GSGq+?=
 =?us-ascii?Q?O3T3XxJtf1TtQVW9zT7Dd0m2PlqMzAsz28cLrbtkv/vCWr4U58XbbLLC/jJf?=
 =?us-ascii?Q?3rt8l6dmcwTfGZZHidQwKU8JnK8YlmrmAKuYm4XDIVWoVK8eO2K6n9zSYeNx?=
 =?us-ascii?Q?YqlS9/zeCPhBgEOFVhhaWAD9vvEKSPI=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd98fc21-1454-4a68-2899-08da2f75aab2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 15:32:45.2358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPilZJg0WdlP8BikdaVtzoiIaUkqS50LkLFkoK3CMuM03uIzoowwRkfug6gTS4NBFZ8o0GntKy+geg3QmIoWR55cN6qGI4pk2qF2iDqmxN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1253
X-Proofpoint-ORIG-GUID: JS21V6nn9Nq8xd7rHrEd5sC3XemsXTSl
X-Proofpoint-GUID: JS21V6nn9Nq8xd7rHrEd5sC3XemsXTSl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-06_04,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 phishscore=0 mlxlogscore=838 spamscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060082
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 3/3] block: remove last remaining traces of IDE documentation] On 29/04/2022 (Fri 00:43) Phillip Potter wrote:

> On Wed, Apr 27, 2022 at 12:59:17PM -0400, Paul Gortmaker wrote:
> > [Re: [PATCH 3/3] block: remove last remaining traces of IDE documentation] On 27/04/2022 (Wed 08:50) Jonathan Corbet wrote:
> > 
> > > The Documentation/ide part of this is already dealt with in docs-next;
> > > obviously there was more to do, though :)
> > 
> > Ah, I'd checked mainline master of today but not sfr's next.
> > 
> > Here is a delta diff against today's linux-next
> > 
> > Thanks,
> > Paul.
> > --
> > 
> > From ecb86eb357e5151ba5f7e7d172c65d07d88c4c39 Mon Sep 17 00:00:00 2001
> > From: Paul Gortmaker <paul.gortmaker@windriver.com>
> > Date: Wed, 27 Apr 2022 12:45:50 -0400
> > Subject: [PATCH -next] Documentation: remove last remaining traces of IDE
> >  information
> > 
> > The last traces of the IDE driver went away in commit b7fb14d3ac63
> > ("ide: remove the legacy ide driver") but it left behind some traces
> > of old documentation.
> > 
> > As luck would have it Randy and I would submit similar changes within
> > a week of each other to address this.  As Randy's commit is in the doc
> > tree already - this delta is just the stuff my removal contained that
> > was not in Randy's IDE doc removal.

[...]

> 
> Hi Paul,
> 
> Apologies if I'm missing something, but this updated diff still seems to
> conflict with Randy's earlier one. As cdrom doesn't get a lot of churn,
> I agreed with Jens that I would usually just send on all accepted
> patches at once to him and he would take them via his tree (I currently
> have four accepted patches, including your two others and Randy's patch,
> plus one other).
> 
> Anyhow, please could this be corrected? Or me shown the error of my ways
> (always possible I'm making a mistake) :-) Many thanks.

Are you working off linux-next?  If not, what is your baseline and what
are you running and what do you see?  For example, the commands below:

The ecb86 that I sent in this e-mail still applies on linux-next of
today which contains Jens next as you can seed:

$git show next-20220506~84^2~5
commit 9c83ebdb74780b2bf2f0cdf4964b33fab696cc44
Merge: 6694d6faf1e5 49c3b9266a71
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu May 5 17:18:31 2022 -0600

    Merge branch 'for-5.19/drivers' into for-next
        
$git checkout -b ide-next next/master
Branch 'ide-next' set up to track remote branch 'master' from 'next'.
Switched to a new branch 'ide-next'

$git cherry-pick ecb86eb357e5151ba5f7e7d172c65d07d88c4c39
Auto-merging Documentation/index.rst
Removing Documentation/cdrom/ide-cd.rst   
Auto-merging Documentation/admin-guide/kernel-parameters.txt
[ide-next 458628cda8fe] Documentation: remove last remaining traces of
IDE information
 Date: Wed Apr 27 12:45:50 2022 -0400
  6 files changed, 9 insertions(+), 646 deletions(-)
   delete mode 100644 Documentation/cdrom/ide-cd.rst

Paul.
--

> 
> Regards,
> Phil
