Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE094D4DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238572AbiCJP46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiCJP4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:56:53 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E291162BE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:55:51 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22AFd38f010862;
        Thu, 10 Mar 2022 15:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HaZmNCusoJ09s5g5I+crYEgsqA4/ISewJWlh3RTchYg=;
 b=IoB7yXmrLzkooAWxATsYrFYQlv9ROa2/ZRn0DV5gsK/v8eXotmW4ZVIGvja3oZ7HK5Cd
 6cXuVSPij9iSAOduuySfkSG3ubn48wZHN1Ln24Pw+1ULPwrONbnWOFArVehZA7lQXYQr
 uKDTT2Be1BDAjlBEy6aU6maY7bi4YUgTTqDnhNdhOXmVYBlHA+Rwp5NdABIg1UV+rl1S
 nlbvIA1uv24exv6aRJuQ1qAm/XDcDCw4rpQDSD5KOW0mY9+fMyqFUnHkvTjc8R5OSNUt
 YqBdGis4mvBh5CSqJNznDBVBfi4X0+OrneXOhtltrwbt6CTWK3iYmuZGmWV9O81Rwrpm EA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2nv2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 15:55:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22AFdMgA029133;
        Thu, 10 Mar 2022 15:55:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by aserp3020.oracle.com with ESMTP id 3ekyp3ngjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 15:55:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0TPzl+BVl/el+jZTJNNdmDsWrattG1/5aO570KlUqCiElJ2X3PBxQm3ktqKzkaoOKTot1D7fK9SUfgW6JQW64C4dYmFnjEcbjaFOjGcrO/R3pQXipOAvSS/at6eEsTdSIV2tul2EMyBqDrQdHkj2tPqtIlHhV9qPYrnT7UU9bz1IfCtU5uRDFoaMin/2UNGGyXG3VBl1snRia3hBVFrrENkjVZdxvub7CRmdMUf1hZFshTFe6sPXw/bGS9Yl7pz3CLhlpChz+LAuZNcq5LIrfwHC+ykU9Qr53ZQV/ev3+QR2avGj3FFvY5RYSu9BxdYyPEmXupWbP1guC33DU9Qew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaZmNCusoJ09s5g5I+crYEgsqA4/ISewJWlh3RTchYg=;
 b=XUJnGkFGVRaIcEh4QdaXZxjly6uul5q/kP4bVve5ddc9g8rSBsoDcYUuFHxChnJRCQJxSA5U7Wxenqp5YSEfp9GZoTB1ReAsZcU25jREKn6UC86wOtTP5mSek2xs0fKyjAbLxlsSr049ivVh5XbSrYxrt7kufIQgjn1Uwj0KKcW3dZ99Qyr+vDDwA/nN6GCzhxH5j+6Yro+16x8ibrav1kFXX/DRPIiRk0U6KWZ9FhFm3WQ7R+JjE85dMomkFTI0cnFa8IR3PNxleK5JIds6Ehrbq8U5kaAXAk6H0KtQV2Xvw4jMybBHpBV2WEnr+H2Qv38umlKtyztXRSTMC0zvAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaZmNCusoJ09s5g5I+crYEgsqA4/ISewJWlh3RTchYg=;
 b=E7blpkxxve4TZ1hIfiKuUhegzWJdN3RTcjPKGBwkZrzqROCdYJHK+ETYJ6iH/f/pKkrRVD4AtAtIoNYNfnjllA1qMVglGEJQIPS1Wqds7NPgQ85m5APTwZcTAVenSTqfdYw6oufTbMiWMrhkitTkCx/S+lvZ2Andma73ozAcBYg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BYAPR10MB3271.namprd10.prod.outlook.com (2603:10b6:a03:152::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Thu, 10 Mar
 2022 15:55:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 15:55:02 +0000
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
Thread-Index: AQHYIqlYsobTZLgdX0GF48T/8G2rKqyjuEyAgAABMACAABh/AIAVFxAA
Date:   Thu, 10 Mar 2022 15:55:02 +0000
Message-ID: <20220310155454.g6lt54yxel3ixnp3@revolver>
References: <20220215201922.1908156-1-surenb@google.com>
 <20220224201859.a38299b6c9d52cb51e6738ea@linux-foundation.org>
 <YhhZsv+czqQPKvvN@casper.infradead.org>
 <CAJuCfpEUro2jxmx-AB2A-mVcNxz6s3oAyow1sEXY5RyPP+83dA@mail.gmail.com>
In-Reply-To: <CAJuCfpEUro2jxmx-AB2A-mVcNxz6s3oAyow1sEXY5RyPP+83dA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac56b894-20b3-4da4-4179-08da02ae5681
x-ms-traffictypediagnostic: BYAPR10MB3271:EE_
x-microsoft-antispam-prvs: <BYAPR10MB32713DE2BDA6483276353E2BFD0B9@BYAPR10MB3271.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bkql6CxdyzTdK3vDDTxqz1Wg6yr25Muu7joUk5JLn4/Y7hvdBpIq5gbR6XDeiYllQOfPG0DZNi4ywRyfmkUUS5ZPNqmqU9cJX4rGpuzC6kqNbGlmRFWyIpwGq60mNmWxZe8AsCtCuMTE5f3WuWH6U5k+SY4h1w/XY8pda1X+qJ5W6UmVtwH4u89F8lSgomhpYcmQE7nalswX+QTJxSduw60mQFtPZqKr2oJO3zexxT0rEhaPflSG94aOeB+sAii0Ui4MRLnGzZIMCNSJbjj4WAIoQyeFCLd5XD3FIWkysEmWE7kHab0HtvShOkvr1Yo5x8f07YqKuKRS0mnkctEpz1Jc8JKK+CIFoSa3cye/Stg3DsoLlrEDP+Z0tikMuxuXhfl+ARQfR4zxexD7E5jBAE+21qAZ/XUBgFW3zocIhPXONDKwDyeiZrEcHed22z8QTq1PO8W38/o0NJWzBG8k/G/breLmncA92IY5ztOW//4W35M/P2hPEgyGoXVuFWL5kXHqI3XGuXTgZbNOihujoseTDFgYBGMCqW+EpDZQBUMOR5dHqRANVc0D5Fi8k942SFmk0jN8VZsYOr/XIvd4kCR/gs0/A/wxm7GuiDdIOcq6eRJN9crfipg15TynQ3/yMz05wM8U1CjaWRfu5lrgIrZ+H5IWy/clwDIDoG32PxjrN+Rg8fFzDumx+3P3dK/7lL7MOEilyL26JfFYHolx3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(122000001)(7416002)(5660300002)(6486002)(44832011)(8936002)(508600001)(66446008)(66476007)(76116006)(66946007)(66556008)(64756008)(91956017)(54906003)(8676002)(6916009)(316002)(1076003)(9686003)(83380400001)(4326008)(6506007)(6512007)(53546011)(26005)(71200400001)(186003)(2906002)(86362001)(38070700005)(33716001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fh9iPe9H1JBdRJc6QEPCnLIcDsaC+nVT2gZXkr/e20U/YZDYTBgyZnsx9RV1?=
 =?us-ascii?Q?YvanLz5l3vnlEEX+4riMpDFrHTCWwIc6rmlVCAnSDaL3U+1StDPujj+EhwK6?=
 =?us-ascii?Q?iJihKkMcZfWFV11W84Cbd3Z6VXh2loNiQ5qqfhoL+61qPcZ34x38dWJjPq6G?=
 =?us-ascii?Q?bZfEd0sr3alB1+79l+SV/jBet5mC+3vkpap9smfGymYrlvza/p8HyGN2yYpI?=
 =?us-ascii?Q?Fmx+dz+k4xCbe4EpbGmUU6GL7e7RfyYQ1mHls5a67Ix6ghMw6xY/xeOj1nI6?=
 =?us-ascii?Q?EI4ljB2hwJwVc6jTIqmfoyxlu3ystSK5+b+UMUJsbj+nPfW2C9dh8143mTxf?=
 =?us-ascii?Q?+9UgGYUElKVccVjNlpDZ1s6pQEo++iikQry24yZ6pijz9tVFaY7jWM+85R4F?=
 =?us-ascii?Q?reviSi17BwqzN7JOGDotfeOak1ALyzFnipa9e/GG9hVdMWCqjgUUyxJwOSE8?=
 =?us-ascii?Q?m4h61Mb7Zs+BEq51Wgq5imlLnjQaxIzoxRGup2ubEV2U87l/mBOR1l6ryZrI?=
 =?us-ascii?Q?/FWbjZNPOanHTKaFyUDIeVTnZTdx567eKD9hPO47VCPhYrxxDWi3akC+6Szw?=
 =?us-ascii?Q?/aC+giJI/V92rM1GdqvBJrrLPKZ9K5ViTMtNT7/l2RVt48dPcc+KBQa/fr0V?=
 =?us-ascii?Q?dNWnHOzGLZK2TLEuqJNRjUwEHhI85GndSYRnH3JtcT/CbNIOJS2EHFuvey7A?=
 =?us-ascii?Q?vcR0WujhL5CIjFIBQ0TH1HjCTcGQZh7tQ/3Mw1ES8T1OlNlLL/YlVVXDvaXY?=
 =?us-ascii?Q?UQQQQVu6ixL79Wk3YKGcJUx3QeuJsaDplYpXth+/juuTehzTcXiRYEaTUIBg?=
 =?us-ascii?Q?0v2E8o40/rQMg/UtT5Ux8ktQaixmvYERBFIgGc7pLVybp+0yHl2thoSeXARf?=
 =?us-ascii?Q?NHgyv8TTPHY6AeTJYSizMBBJw6Gulo1dCz4pOMKScl782AdyRHvKe5nQ86k6?=
 =?us-ascii?Q?5mBBN8bCXnOHiOM01JjZ6uqOAj7p8NUJNHne0tgBXVvM3UJO5OMEPigaeoY+?=
 =?us-ascii?Q?NAL1jtHibH08ZH04cLcGpX93NXAH0pZrFlx7368w7nU0nCcbIB0bap19aFBX?=
 =?us-ascii?Q?BVvUpEGhaYcsg8RhG3+Mbqp+hFWESVWPVcObabLuO9mbSNe1oEP9RUIHbIRe?=
 =?us-ascii?Q?p66xALArcffpeq+8Ai668LlvvCQsnyDyL/kkoNPUtIHWrfYRKhWTYWokG7uD?=
 =?us-ascii?Q?h/NKJUsEPJi1z+JPnX992smt3DbLEIcOr55ql+41CfcCKdvkCpO5Jj18ex0K?=
 =?us-ascii?Q?ROoVhdbPgpUwakp1AMs5s1IsKmanIp/96WnrEUVDhTSGI6WFcm2DPTpF5D2y?=
 =?us-ascii?Q?VLLwF+Wopk8Rff+lkh5AVt9HyeJmnRf3v/geWMezIHgPY4iWCuWO8X/D6IU5?=
 =?us-ascii?Q?LqX3SK17TziZ7dqw9Bt0MKeJBKVMs+Hv0bWLTbc7kbgxkefPhKcXLxSdRIEE?=
 =?us-ascii?Q?gUnf6pT8TidCnNtPSOtH5RhQcRWnNglHI2UqAm7UNg5U4AIaZoCCcFnI448x?=
 =?us-ascii?Q?hXY5Wost8IDoLYbY07TkrjdCvjN0MoIJzZwStHYOv5R7e7xAhzu9H9UrU1+J?=
 =?us-ascii?Q?DpezaHF2TzYocK4wuDuUxKWDwnsOvvsiZHUcKoa3ufB9/VkqqMNkJIIVoyD6?=
 =?us-ascii?Q?Asvu0675Bkrmrfnb0WTTzpE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D870917785EC994DAE37F6D7017DB07B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac56b894-20b3-4da4-4179-08da02ae5681
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 15:55:02.3973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4GLc0K94LsvCs9Z5wDxXcWAw/lpCp8tIQ1mqedHwJElPD6IbehiSP9TZyuB8Kx6Gys9oqh3dS8KbTPnvbZCnrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3271
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10282 signatures=692556
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203100084
X-Proofpoint-ORIG-GUID: k7OV6HDuVHpqHdieCZZDmzBuA6nPa_Lo
X-Proofpoint-GUID: k7OV6HDuVHpqHdieCZZDmzBuA6nPa_Lo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [220225 00:51]:
> On Thu, Feb 24, 2022 at 8:23 PM Matthew Wilcox <willy@infradead.org> wrot=
e:
> >
> > On Thu, Feb 24, 2022 at 08:18:59PM -0800, Andrew Morton wrote:
> > > On Tue, 15 Feb 2022 12:19:22 -0800 Suren Baghdasaryan <surenb@google.=
com> wrote:
> > >
> > > > After exit_mmap frees all vmas in the mm, mm->mmap needs to be rese=
t,
> > > > otherwise it points to a vma that was freed and when reused leads t=
o
> > > > a use-after-free bug.
> > > >
> > > > ...
> > > >
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -3186,6 +3186,7 @@ void exit_mmap(struct mm_struct *mm)
> > > >             vma =3D remove_vma(vma);
> > > >             cond_resched();
> > > >     }
> > > > +   mm->mmap =3D NULL;
> > > >     mmap_write_unlock(mm);
> > > >     vm_unacct_memory(nr_accounted);
> > > >  }
> > >
> > > After the Maple tree patches, mm_struct.mmap doesn't exist.  So I'll
> > > revert this fix as part of merging the maple-tree parts of linux-next=
.
> > > I'll be sending this fix to Linus this week.
> > >
> > > All of which means that the thusly-resolved Maple tree patches might
> > > reintroduce this use-after-free bug.
> >
> > I don't think so?  The problem is that VMAs are (currently) part of
> > two data structures -- the rbtree and the linked list.  remove_vma()
> > only removes VMAs from the rbtree; it doesn't set mm->mmap to NULL.
> >
> > With maple tree, the linked list goes away.  remove_vma() removes VMAs
> > from the maple tree.  So anyone looking to iterate over all VMAs has to
> > go and look in the maple tree for them ... and there's nothing there.
>=20
> Yes, I think you are right. With maple trees we don't need this fix.


Yes, this is correct.  The maple tree removes the entire linked list...
but since the mm is unstable in the exit_mmap(), I had added the
destruction of the maple tree there.  Maybe this is the wrong place to
be destroying the tree tracking the VMAs (althought this patch partially
destroys the VMA tracking linked list), but it brought my attention to
the race that this patch solves and the process_mrelease() function.
Couldn't this be avoided by using mmget_not_zero() instead of mmgrab()
in process_mrelease()?  That would ensure we aren't stepping on an
exit_mmap() and potentially the locking change in exit_mmap() wouldn't
be needed either?  Logically, I view this as process_mrelease() having
issue with the fact that the mmaps are no longer stable in tear down
regardless of the data structure that is used.

Thanks,
Liam=
