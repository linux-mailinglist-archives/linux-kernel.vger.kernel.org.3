Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB524D548E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241107AbiCJWYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiCJWXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:23:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0E86368
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 14:22:43 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22ALxMDA015696;
        Thu, 10 Mar 2022 22:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rq8K7Z1/7SjL7D58mdQqlt7jC9EL4hp9zrQyIIc/Ydo=;
 b=qf/ZUYjvMQY0dwcG/h4ANfy/WsyOkl0f3/PTjm1WpawpopbQCem2h/szlTIWNNmOnQ3r
 WEOvU6S1bkbnHE44Qw3XcFsZBATx3v2CQNnDp6dl24ShiqjwDRjW2MK1pKSaNFRXwnlk
 uButoEP4A+asc4mYR73A7ez+ypXH7xUetkmu3+aZGUf1jUSt7cRE3D425guLW3Nxj5tb
 w9nuaIfBESwMHx/w8CdqYFlN+esTQteNNI7VF/YBqVDbiSkEIHgEKMo8XkHHpD+piZnq
 VFcGD5CWqkjBrLy0VE+ZoMcXkFMyqPiahBkksBWOHEaLjWPKFrYaMXrlMCM7Ubo0h3Su dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2pwh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 22:22:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22AMJvV1137123;
        Thu, 10 Mar 2022 22:22:15 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by aserp3030.oracle.com with ESMTP id 3ekwwdphf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 22:22:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FA2ifS5PZw5ldw5R1DmdwzlGJI9yiTc5l3DjGOZw4Uds2r9NogfKoz3ed9anYxonnDxvpAgbI2uV+qpdPcOk+ig9W2pbOpN5bgmMkicv8dOpqDzamXofCZ7TwT/cZiFJzlkxGZPKjE+BB0BhFwI3FKcZow1irrwzH89z9lz0xbnoZTdt4FCM/5ZXlNpcF36kk0sGKqZSxXCub9PEgywdGvlhAKd3EQgzrha5FkIqOlFIGIzKss75W3hbXaHWdZnOaPPUnfIIAXOd/DSge+oSgtpbCGNXf9YAjHIHMz48VOzoDLKdcYESQr3Aqp2R3isUG7Pi+8lJcnGEe/I+BhzNjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rq8K7Z1/7SjL7D58mdQqlt7jC9EL4hp9zrQyIIc/Ydo=;
 b=hw+MtqpOkZeBGSDPfyFXlBCD7y+9vp5AjvZKuATByblXIFtxw4AbfpPVnJIxG+3Q0cFt85mqE+Zck1mHy6XjOL1dYYDyAQAlI6JdfMFlx2fYGqoPK8T4MPzkEgAufJou53itRdnEublq0rOrwbXc7JXEDFKiq5roWP6IOpSPwHD5hJYn9WL3dqVsrwSxDfsNcg414eiD+ZjDILiX/yeYDIewWewth0gCj9EjPq6sl/85aiGp44l3vO3kZdnS5BSCjEctuNljCv/PoFgpMDcAWpPY6qBX2kxv77vHwC3+JjBQasfGjGxxgQMEEbHTTxlPHE0R0HCT9uCl+5moPeztOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rq8K7Z1/7SjL7D58mdQqlt7jC9EL4hp9zrQyIIc/Ydo=;
 b=K3zxFS1b0x6jHC7K29vbElbGSA0/7vcHWb+mFkkJKV2EEnyHUYe8lU10G31l0mrT1FJdv7xxs4FsZxHGiTrlCxcIk+C/XNTIPXmhHPkvJkHDX1iRRboLSlrHM5g09qtCWfNnCVPOJk0YwjV2o6Jl9BL2MMjD9KPwG1/2Bpx/ASo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR1001MB2079.namprd10.prod.outlook.com (2603:10b6:301:2b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 22:22:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 22:22:12 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "guro@fb.com" <guro@fb.com>, "riel@surriel.com" <riel@surriel.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "christian@brauner.io" <christian@brauner.io>,
        "hch@infradead.org" <hch@infradead.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "jengelh@inai.de" <jengelh@inai.de>,
        "timmurray@google.com" <timmurray@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com" 
        <syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com>
Subject: Re: [PATCH 1/1] mm: fix use-after-free bug when mm->mmap is reused
 after being freed
Thread-Topic: [PATCH 1/1] mm: fix use-after-free bug when mm->mmap is reused
 after being freed
Thread-Index: AQHYIqlYsobTZLgdX0GF48T/8G2rKqyjuEyAgAABMACAABh/AIAVFxAAgAAJZ4CAAGLHAA==
Date:   Thu, 10 Mar 2022 22:22:12 +0000
Message-ID: <20220310222206.dttvvlgfqysrcl2s@revolver>
References: <20220215201922.1908156-1-surenb@google.com>
 <20220224201859.a38299b6c9d52cb51e6738ea@linux-foundation.org>
 <YhhZsv+czqQPKvvN@casper.infradead.org>
 <CAJuCfpEUro2jxmx-AB2A-mVcNxz6s3oAyow1sEXY5RyPP+83dA@mail.gmail.com>
 <20220310155454.g6lt54yxel3ixnp3@revolver>
 <CAJuCfpHk+1snrPx-_qvj=kjSOS+o=L90evAQ1gD5hj6XxB=a3g@mail.gmail.com>
In-Reply-To: <CAJuCfpHk+1snrPx-_qvj=kjSOS+o=L90evAQ1gD5hj6XxB=a3g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72924642-e35c-4b84-c863-08da02e46c83
x-ms-traffictypediagnostic: MWHPR1001MB2079:EE_
x-microsoft-antispam-prvs: <MWHPR1001MB2079EE416A94FDE5E224EA16FD0B9@MWHPR1001MB2079.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K3JP8dEzqo4VLT2IlruZgNuxSf6NEU/1XsyUVUIYsy6y3zbH0YLgtiNXLwS2cyO6uE7F+zMSEtBlx2865HBLcTpO/GsSmtW9TFDkAYrgBEpjn3SFPQiE8h1Xfubg2dItf9f765cR6iDMhHikjLf1tRiz8b3tEr1XQ2zWene9yvtgI/04Kw+xrwtWerGTatNZK8P36QTXzJ7V53/oGdrsE/R9k7G74/eHn4rytPsvgogiHZ1AsK+4GKE/raERAU60X/zmZxOkXZdoLJAlX3m/CLR/ijppCnJ8CrQutvLcP8Tgl8K9yMF8Bzyw0sWuQmhEeLMSPANJyuznul7Hc/Gh8/+NjslyNtUGoQze5wnpKMjMlPH4Ci9WP/8KElnpjGFt2wpNdffTh0yrrePxbaX9Gy1di3Z/JBM6WlLKAjiLg3Mjk1bWGUh8mj0WYXZvL8VdigZSSE6nLYXszH9mMaKQ7Mtm3BvKCNRUKEeMJMr4Q9ytOJ8aICZcX8Df/WAmJBGs5HoDpvNFsyE3fs7T/m2kN/8pFDQNhSxJsVFwKHI4LhYxEew1Vn3HhplbM9eN6h6JX5oMncmj/k6DoEhvIaE0fhUgZ4Wxkvre/qfFqp7wT0HIW4fZXEAU9HNV6zI6wqRc4vGePcSvZIHMpm0bccvVqhRbDP4B5mv1v3QyiKf4vqijDyRP3kjC9OVJ6G1zJuj+0hs3EqFQ4H/ODDEbf0EX4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(186003)(6506007)(6512007)(8936002)(9686003)(53546011)(26005)(91956017)(66476007)(6916009)(316002)(66946007)(2906002)(54906003)(64756008)(38100700002)(76116006)(66556008)(66446008)(508600001)(6486002)(38070700005)(71200400001)(8676002)(122000001)(4326008)(33716001)(86362001)(7416002)(44832011)(83380400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zJwOF5kzpp6tg2HlZZT8WQGRs52JXp+DCZx1cR3m91UQwNREkbVzF0A4tEY4?=
 =?us-ascii?Q?APYErvV1t4cmNRJ4Ykoj5ljN5VPMiHCokt3ih5O+dEpqz/oPmZCx1JN1R7MJ?=
 =?us-ascii?Q?7l93AuWlaXAOPVYlGnqds59py3e0tKVsh/PHKZraoa2pKl4mrNNIoE7fBDKA?=
 =?us-ascii?Q?ubAyG1VTOYIhhjm1pwVhTfwEZVsI7xEb6CkR3XYPqmrVn9CaFjaTMyX1oaFy?=
 =?us-ascii?Q?1fL+fNRw33A11Ueclg2+zsTrKwT086s5er1kFYkjAC7A8mdz/mHkmiIlj+Qo?=
 =?us-ascii?Q?BGiQXRRq+ATlnAcvo1Y+KGagGtMm8whPefBrg61c1p3E2JlOPWhPJnJw4GNj?=
 =?us-ascii?Q?ewUknDqgX1QOi26aWQ+Sg8PSHIdNwPsX099ZNsDsBN9kzaDVWSaWhINUlstC?=
 =?us-ascii?Q?K3iWtesgBT9jql/TroopOU11j1B3cx3AOUoDn4SoW9FYKoqDyxjbezAm04HM?=
 =?us-ascii?Q?DW/PtqF0gWq/T52b/CzNG+9ryqdBCTJpBmQ96b7I6zdDxZEyx6jFi3RaN0Jl?=
 =?us-ascii?Q?8OnK6pxUl7ORUiIc+FMHDg37W6skh8GeiFHQVPkkpO773L8RmKdLvqT8sxC4?=
 =?us-ascii?Q?0hK7P2UFWLkXY/wIpGoxbubXc+Mu6Z5p7iCZbDPihS3lCRNMilRXsN26RKJt?=
 =?us-ascii?Q?DdIXfGDI0b5X8v8Ho5aviJmuY0RGgOePxGmMQPy42cjQE3PpdSPnWXqjoPC3?=
 =?us-ascii?Q?jylMZDx8VfVQ0okrrmLMp5BC3laM7ix61nsSKtjdZv38q8ui5edCK6izLM/C?=
 =?us-ascii?Q?O9Qzl647s2KvB/VNDVatME8i9cZTab8g5Lzf4flFrhLVGJYA9LNm7G1MF6EH?=
 =?us-ascii?Q?XiuXN9QU53kqfMGh9+oWtoJGgRC0F9kPkJTfEL/SmTCb+/ixXLmDxM/IOlN1?=
 =?us-ascii?Q?S9YmWIaZV1atlbdo8jXWnBkpKEnCmPYtP84wDGAflsCQECSmjeKRMBX8SxF8?=
 =?us-ascii?Q?Yis/Exx69vJON13eSvzOqiZMS6t/TZ0FWtXhnjYge2+q3xFrbct2OKrjVafK?=
 =?us-ascii?Q?T2M5DbmRSezJDaifCp2fgZC+bnWulOMTw0ooNqEhW+stUDjpTe7Bc/7oWM6A?=
 =?us-ascii?Q?9g6q7VmRbNQ5BqEwSpfCzO/eR7ySA1x3s17GAxXnO4Xrexl0VAh/Ry12nFMn?=
 =?us-ascii?Q?IpE9voqIfUsaEE0kvQfRdYTB6bM3C4EETeE36ThvNIkmD6DH7oz+QlCP2uF8?=
 =?us-ascii?Q?tf3fyu+Np6bPf4djXFnYkET+xwHmGt0c9tDl1SAFLp4EQFFfCY9+Yu70Om17?=
 =?us-ascii?Q?BWH8B2pih8FENX87deyrpcDWT/ezt/Enka3SYwPbH/aDqQrc1dOF0RvIxgLk?=
 =?us-ascii?Q?UBXCddCJEWpxgen3acbB+T8mx874vEOlsusw+u9O8t7aA1sKLX95AUybEquW?=
 =?us-ascii?Q?YrAlkc9YFSCZiW3X59GnEZTTs9AM42HDCbS//I0Rz95Yh1o97dpI8GGfGRlc?=
 =?us-ascii?Q?/xG+XHRA2WM8ecxhuf64g9Zrl51rfpafKrIMx6tKpWZt8gIpC6TyKLDk/p7u?=
 =?us-ascii?Q?zvamyPknC0Iujt0WSWGJJo5lvYurtIWiLs4NFJYXQpWkaSIbpDW7AhC+sCPp?=
 =?us-ascii?Q?BAcd1FuwazLVtcx0URe02l+eH6Bdhx8p/KtD1dIORImkEvnCFcNoqeBGOTMU?=
 =?us-ascii?Q?iNQXf1rhZ4tyWgxiiArmLq8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17F08AC8CCD0134995A1E9C9EE9A4FBF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72924642-e35c-4b84-c863-08da02e46c83
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 22:22:12.1940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pJqOixGQ5ImW8cwDpRMOZJUZ2PTonMiM+N7i+n3aPmb9coepPpAxMf1KC40gD5giAuIJxM0iBfN2k7IrZS25sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2079
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10282 signatures=692556
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100111
X-Proofpoint-ORIG-GUID: zb1Du8HXOByisbhEUUWiqJrzggE-aPZG
X-Proofpoint-GUID: zb1Du8HXOByisbhEUUWiqJrzggE-aPZG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [220310 11:28]:
> On Thu, Mar 10, 2022 at 7:55 AM Liam Howlett <liam.howlett@oracle.com> wr=
ote:
> >
> > * Suren Baghdasaryan <surenb@google.com> [220225 00:51]:
> > > On Thu, Feb 24, 2022 at 8:23 PM Matthew Wilcox <willy@infradead.org> =
wrote:
> > > >
> > > > On Thu, Feb 24, 2022 at 08:18:59PM -0800, Andrew Morton wrote:
> > > > > On Tue, 15 Feb 2022 12:19:22 -0800 Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > > > >
> > > > > > After exit_mmap frees all vmas in the mm, mm->mmap needs to be =
reset,
> > > > > > otherwise it points to a vma that was freed and when reused lea=
ds to
> > > > > > a use-after-free bug.
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > --- a/mm/mmap.c
> > > > > > +++ b/mm/mmap.c
> > > > > > @@ -3186,6 +3186,7 @@ void exit_mmap(struct mm_struct *mm)
> > > > > >             vma =3D remove_vma(vma);
> > > > > >             cond_resched();
> > > > > >     }
> > > > > > +   mm->mmap =3D NULL;
> > > > > >     mmap_write_unlock(mm);
> > > > > >     vm_unacct_memory(nr_accounted);
> > > > > >  }
> > > > >
> > > > > After the Maple tree patches, mm_struct.mmap doesn't exist.  So I=
'll
> > > > > revert this fix as part of merging the maple-tree parts of linux-=
next.
> > > > > I'll be sending this fix to Linus this week.
> > > > >
> > > > > All of which means that the thusly-resolved Maple tree patches mi=
ght
> > > > > reintroduce this use-after-free bug.
> > > >
> > > > I don't think so?  The problem is that VMAs are (currently) part of
> > > > two data structures -- the rbtree and the linked list.  remove_vma(=
)
> > > > only removes VMAs from the rbtree; it doesn't set mm->mmap to NULL.
> > > >
> > > > With maple tree, the linked list goes away.  remove_vma() removes V=
MAs
> > > > from the maple tree.  So anyone looking to iterate over all VMAs ha=
s to
> > > > go and look in the maple tree for them ... and there's nothing ther=
e.
> > >
> > > Yes, I think you are right. With maple trees we don't need this fix.
> >
> >
> > Yes, this is correct.  The maple tree removes the entire linked list...
> > but since the mm is unstable in the exit_mmap(), I had added the
> > destruction of the maple tree there.  Maybe this is the wrong place to
> > be destroying the tree tracking the VMAs (althought this patch partiall=
y
> > destroys the VMA tracking linked list), but it brought my attention to
> > the race that this patch solves and the process_mrelease() function.
> > Couldn't this be avoided by using mmget_not_zero() instead of mmgrab()
> > in process_mrelease()?
>=20
> That's what we were doing before [1]. That unfortunately has a problem
> of process_mrelease possibly calling the last mmput and being blocked
> on IO completion in exit_aio.

Oh, I see. Thanks.


> The race between exit_mmap and
> process_mrelease is solved by using mmap_lock.

I think an important part of the race fix isn't just the lock holding
but the setting of the start of the linked list to NULL above.  That
means the code in __oom_reap_task_mm() via process_mrelease() will
continue to execute but iterate for zero VMAs.

> I think by destroying the maple tree in exit_mmap before the
> mmap_write_unlock call, you keep things working and functionality
> intact. Is there any reason this can't be done?

Yes, unfortunately.  If MMF_OOM_SKIP is not set, then process_mrelease()
will call __oom_reap_task_mm() which will get a null pointer dereference
or a use after free in the vma iterator as it tries to iterate the maple
tree.  I think the best plan is to set MMF_OOM_SKIP unconditionally
when the mmap_write_lock() is acquired.  Doing so will ensure nothing
will try to gain memory by reaping a task that no longer has memory to
yield - or at least won't shortly.  If we do use MMF_OOM_SKIP in such a
way, then I think it is safe to quickly drop the lock?

Also, should process_mrelease() be setting MMF_OOM_VICTIM on this mm?
It would enable the fast path on a race with exit_mmap() - thought that
may not be desirable?

>=20
> [1] ba535c1caf3ee78a ("mm/oom_kill: allow process_mrelease to run
> under mmap_lock protection")
>=20
> > That would ensure we aren't stepping on an
> > exit_mmap() and potentially the locking change in exit_mmap() wouldn't
> > be needed either?  Logically, I view this as process_mrelease() having
> > issue with the fact that the mmaps are no longer stable in tear down
> > regardless of the data structure that is used.
> >
> > Thanks,
> > Liam
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kernel-team+unsubscribe@android.com.
> >=
