Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564EE4EAC23
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbiC2LX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiC2LXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:23:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D28813CA3D;
        Tue, 29 Mar 2022 04:22:13 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22T8oV9p017301;
        Tue, 29 Mar 2022 11:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=pIQF0atBJk3ldLL9JrEjPGv/r+jD2npHziUAM/zDrJM=;
 b=zPvs/vTh4mxS4TBZUinPHDFg3Ste1Qjk572L0DPW2ej7Qvwy08QbRjsepT/dDeQVgEnh
 l/6LFE114B1Y4oUE9rH6vX4uEaqksNUZeywA1cDywC3thKhKe1vU5XIDN3DvRLCrB1rL
 U2wPL67SlL3czkyM4YMYEN48C+YsNUIb8ZB9m8Dsvp1SfhKDMF1HiP8Hh4x2ibcTgQhf
 TLZk74FCvKgddpoJSY/7KOGvNjZ5pqqf8su/JpIHmY1lYOY8UZ9S62yUhCWKpmFM/X2b
 m5c12Wb8sibtCjKsbdJqJL+wtuXOXxjDzt2YDXruO4+LKZYBwCaBg/QXfKbXdIp6KVZj RA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cp6cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 11:21:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22TBE9qk158034;
        Tue, 29 Mar 2022 11:21:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3020.oracle.com with ESMTP id 3f1v9ffx38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 11:21:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8goq9z+E+1+epN98LSbgRs8uaYLmDUY+3JnQHouNEZ2guf9+y1vFPH9GeeMLTzwG4I6G5QKY1Ty07Klao3YfmZEUWTvsiupCHkzY7c//NyLcqhbMP1Zlgc21gSAQGVIyil0QyXaFlVhoy11jF7Vc4hsc4m+FCcByLxT8dNEnVrf9RBXhKwdMHPGBm4Y4baC3x3c0SJonlLJC1cPYu9ZfVVvIAtYs/bYnKk5BzJt6EkuWZruXfjGfWSoaGxP2Z9qQk+B90qc2UIrcoMh1mK629CUC5fW+Z+v7qBCU4zEs4aGjOE+S6kbAkGkOr9CIagVNRDUtoWMseTdYPusus0PMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIQF0atBJk3ldLL9JrEjPGv/r+jD2npHziUAM/zDrJM=;
 b=gA/Y4oUuNJPDtpRx/EwYiH0h+RObKZP433BmWBt91DpE7L/yNw0BiJVtZmZwlYbOmazw3+jnqei1eWGGfzrnvz3inc3vpO1OWrEHOzCnZvp+LZ+VxX2+ZWx6ricpZuZNlXHwRnMhdJMZnOfq+3WOo1fKrUBJuavjExQ+i3EmjmmHoDvWKiopJituW602POP5LSXas1A1HwL9MUkZH9NoZAnabfVQMuHWiFOBCz2iVkAEl/PDmBhlktiVYYPwL3Qv68LUq84Mo7+9KReS1lz9PsPBAvzHtiw0MdvTPr+FuOgZWR//BupQtdg4Ysnz73INET/DvXlEcgYgH39qurl3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIQF0atBJk3ldLL9JrEjPGv/r+jD2npHziUAM/zDrJM=;
 b=nHx5MCFIVg3plmmCASQvdMj8WWToBSrNaKZ5PzYhqH1VGqOkY6Z8o6pw4mkes9ZGrua/WUUJXvpbXKd0VYR4iqyvmfLJX+zfvysmvUMA9y8U8YoYuzdQIejD6drOP6XPS7v3u0JaxyEowOGF89ht3x2fQbd5+Fw+Sr00JHXC2mM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5120.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Tue, 29 Mar
 2022 11:21:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Tue, 29 Mar 2022
 11:21:55 +0000
Date:   Tue, 29 Mar 2022 14:21:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     yuzhe <yuzhe@nfschina.com>
Cc:     Marc Zyngier <maz@kernel.org>, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: vgic-debug: remove unnecessary type castings
Message-ID: <20220329112141.GZ3293@kadam>
References: <20220328103836.2829-1-yuzhe@nfschina.com>
 <87h77ifbbd.wl-maz@kernel.org>
 <0f4cf955-ca2b-626f-867e-5a0ecfe68ca1@nfschina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f4cf955-ca2b-626f-867e-5a0ecfe68ca1@nfschina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0114.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::30) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 485a5d5a-2b6d-40c1-7a9d-08da117654de
X-MS-TrafficTypeDiagnostic: DS7PR10MB5120:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB512031ABBF2E72586A12FA078E1E9@DS7PR10MB5120.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OXfM/oH64y/oXZ0QwK51wH8DB+P/kgVKtW+uCcHRaeKz6B+7w2m4n4/O4jJJ/tF37viKZNfsCbO3APzn0sIgy1PQ372nqo+DAjjFKh3TNDvoNDF4SDmLACPR+tm5h3Q+kJ1sco9HTVsYl2WtnIV4y97RMOCrmf5byqbfpdR+ODRVrfAV3aVxW42LGK3RYv7uLYNacSPTGHfeTQMAtcUwBGDdbnE3F+vOaYtyMBWW+Poq9MIV9dJPn7HnS7UYXIebcf8p2BLSQgtdvagGUjDkiQglChsk6fCcfNnkosGxblib+9YB/lalIYnBwyJtn4XqF/AfMsA1tR/ybhJKchwyeAWFqs6BxQZlXrK07OVzrk62spg4nysz9HqKAEgVHLDpJUNiP2/jRkrOGRDwaEGJBWpsbMw2fEn4NBNveRFuWvMvAHarna1D7/bZOZuEPn38Mfu5gqJ1sbqZpM4DjBKH5YpdzxIJ3VvrYQ0EvYVYXJS1Gx1dbPpVPeaq22j7hxiLiySHNicHtVxLIKbxLxhcgQuGNTpedcpSowAE8EYoNQeG8zhTERCAZEjuEGOb/q1hi8CYrpkFjbM7iy57JLjAY8z93Rva50E3AtJBwPv7fwxHKKSu3//aUGSgOniWYmTqZuAlq2UAr13cXmnbA7fknF7iofxf65euezKhaM4NX2tlRHgk/sERvTHYAf5NiThqOXYeYp30kxhziayB1hMVdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8676002)(4326008)(66556008)(66476007)(66946007)(4744005)(6916009)(316002)(38100700002)(38350700002)(44832011)(2906002)(86362001)(7416002)(5660300002)(8936002)(9686003)(6512007)(26005)(186003)(6486002)(508600001)(1076003)(6506007)(52116002)(33716001)(6666004)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ipE0Tm3KumJvOtMIKitKHT2LtshzBHQ5BicgLn0m94lCYR72u+q5N0285Jfx?=
 =?us-ascii?Q?6aTaPpqg+VFW5W+chP9E639Gcp5Xwdjx7+FUSlaKP9tlxN1IZKeJoABU6ZyE?=
 =?us-ascii?Q?/sZ/arv0J5LA8Df8mi9nEMuxy7v+u17VyuNWSV7cANZdrLvfS6nulnSokFvJ?=
 =?us-ascii?Q?x+31fbvgL8yYpjpOOnPBlXFSsjICCr39NPQ64fuVJPerUZtVcDv40R+vn6E5?=
 =?us-ascii?Q?MB2Fkc4pml+drsqdQjq/i0ZC05qjFdktrevHdmaLhtC5np6mBk9vqPHCFafY?=
 =?us-ascii?Q?G/NgRXFQL8OzrmZnReinq90mJ4LVQcB3C4d7xr51eV7raMNxWJOfe8bBsloH?=
 =?us-ascii?Q?4sdypb0eUfxgI4I944UKTaBybsAdCO7eTzI0secD1ZEZh78RnAeMw0yl9O/3?=
 =?us-ascii?Q?XHTY2950wtmZKpWu0cCxUxVYZY35hWAAnHtNYtF2IBweBqrax22hi3dMyAqB?=
 =?us-ascii?Q?ftP9HUPDXgT2ipcAbhVR/JtLxUNTyNk08rDlMotS6xUOG3A5ACdWQ5In+0VB?=
 =?us-ascii?Q?ATdzNvzVQrZDsbmMzSpkDR1LIwlEhZzM7f368Xeg7UUsJM4BAtzRtoXU/ZQg?=
 =?us-ascii?Q?HA1X3KRQb4CDya3iGfoyD6KY5YPF0HlZiF75Em2p2glvie6DGWKsABCwPz9D?=
 =?us-ascii?Q?F8qa6NVMEYvHPJjdiYq2Kt7z4jpg+l8dgBIqqDIG0jVsOanUYPTEngmu+5Nk?=
 =?us-ascii?Q?mLw/M6aVio+oXyRCqc+rJH4LpsTzldR4ycIfz2PC6A4/L6H7u8dbdY21WA5J?=
 =?us-ascii?Q?JSn6G5cvbWs/D/5gvh51SXhvWCXMvcIMcmdu2xcnfupwFR4dHW2O1POOUPCv?=
 =?us-ascii?Q?1aLxR8a7MI0h6TDtvl/BDDHJSB/HJOIVDVd+RRrE2be0UZnK9VU2Fwqg87+/?=
 =?us-ascii?Q?MpIHhRWgxXK/+105BnRc4ECg6uBKIi2lvzH2X/Jkp1ogWjSXi1c6roVKOcGa?=
 =?us-ascii?Q?4hteTjjzj1KxpwXFIgmiUgZd7ZJAqjnLkoz+ulYtBmdt8k4wtiwm+FCpD3+6?=
 =?us-ascii?Q?wVXk7thdiuatefXRPhGbIrZeGOGlI21A/mkeUE6WZJapByotHCieyVTmTLHN?=
 =?us-ascii?Q?lotFHvWN+oSZkv8Jqpppk0X0GOLioGC1nXuewX1qxZavMCa+PRtSgIT6r+4f?=
 =?us-ascii?Q?pMC1FxZBV5F3DaGNS6YCGCZm8TBBL/rJIp2QfNmD/BYUSWMFeN1vrLuUcXzU?=
 =?us-ascii?Q?+KzNb/mKNkpYDOWNORZ3xwX3SzwveBQuDxTe6IFVx/XhA9hb9qEkpRensiwA?=
 =?us-ascii?Q?mmXZqWssVNqkEB4IPUJXMpPnhTmMMD3k3D6tDDAlq6ypH/ymmOBjKuGOVzUW?=
 =?us-ascii?Q?R6OIDLpZyE9n+PJwUIBUPnWyEl7KY4610TRrwJyfbk7UfxTyje9BC64YCamD?=
 =?us-ascii?Q?1gUMVhpPOCeEIA2Nir8HEsD7WgwijuQvsfSYRXOmVxIw3SAsWvMfNtkTaYZI?=
 =?us-ascii?Q?f3OtYvNAS/S8wLgYjl09rOgefpnnvmkY/dSo/OZeZS9AgQxVfS/wcnfxMFZs?=
 =?us-ascii?Q?JeEQ4YSZXg2idrC1q+0L4sEYEgUA3v275IMs3C2PGlEHaCVCu46QQVV+Sf0V?=
 =?us-ascii?Q?jkcnjvD+gX6cErIKNlVUtRyEmkXqIumF7Jx+71e85EaWkfnwtAjix6T0NPa0?=
 =?us-ascii?Q?WLDeIEHkEA6p4TPzrn5Ecyw/M4M4CLt2duLXqFLI0kBvYuss1YQud5bQ9cfH?=
 =?us-ascii?Q?i3dMXFnCR4exePYEmWmuOZasHe7IeqNLwn6hA/i3OJQsEIMRVMGLZdixdaw1?=
 =?us-ascii?Q?uOIHgkjBHtVJ8ET+0DbLN0nNRZ9zTFI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485a5d5a-2b6d-40c1-7a9d-08da117654de
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 11:21:55.6369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3I2lb4o0tYM6D41PmmD0TY59HxwV1w5sLe0Ns+8NhSMH9UIpqT/tn0nB/eeGcOxt4Ptq2H7yxNThVqm0+3n4WBAw/IeimBJ3ug6K7GKBito=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5120
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10300 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290068
X-Proofpoint-GUID: fHJDs-FibyebYre15nAmQFr-NI6guaUa
X-Proofpoint-ORIG-GUID: fHJDs-FibyebYre15nAmQFr-NI6guaUa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 02:14:16PM +0800, yuzhe wrote:
> > > @@ -229,7 +229,7 @@ static void print_irq_state(struct seq_file *s, struct vgic_irq *irq,
> > >   static int vgic_debug_show(struct seq_file *s, void *v)
> > >   {
> > > -	struct kvm *kvm = (struct kvm *)s->private;
> > > +	struct kvm *kvm = s->private;
> > >   	struct vgic_state_iter *iter = (struct vgic_state_iter *)v;
                                               ^^^^^^^^^^^^^^^^^^^^^^^^^^
This cast is unnecessary.  Look for others as well.

regards,
dan carpenter

