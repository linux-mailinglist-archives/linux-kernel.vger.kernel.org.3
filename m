Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E51D55293D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 04:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241851AbiFUCI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 22:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiFUCIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 22:08:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AF9BCB4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 19:08:51 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25L0nOKq023656;
        Tue, 21 Jun 2022 02:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=MEdpzhGx0Y/rfINjf2tSc17l8oUcniiDsnYnkEHrDL0=;
 b=tzjS6dEd7GrI8li8lx3sFmXIXsSrEJgsx+pmqBhCpQns/SzgzCJ45Cb6Hy8xKu7+s2dc
 7QA34frbywsedTO5OJp75uUPEWx1YLiErnOXiOjWKbZrNkm+AcDBWcsBCopaJmXaoX/F
 9CsjSxDw5EJLhNUTTASu8ZnyZuTLUas55NnfDjCiPR0Begfi7MxAewGIpNXg76Ze6b9q
 /moItcL6tDX93uN6gsYOXpklT2pDcGfg5NFcOLZmpRexQ9rB6kyyw8BWsG1SggULC7OC
 nAyGWu/ZL55n+Ws7oYuBV49sdAdeiUDEB4jD2izVVJrx17+1jTPsfDKt3JQsYqhjR/VG vQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cmc7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 02:08:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25L20TGK016880;
        Tue, 21 Jun 2022 02:08:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8vu9ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 02:08:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Agj/x4JMHpCq+gSQ4Jp21NLkeD6sBoV1s8WPJx+DCfAOBp5lbXzUX/3ljS1hzGPEhFdepwUxveGaRy3MzDXydkxr7d8490bQXn+xGiwjd7rsFNwcEXSPFehCnPhwr86oQCNaR68OE4GI7m0O3L1QxppQGT19P/l+A+d0+UMEG7ELOT6p0MGPJ7ZEWmJMl7wflgkiSCaoMBjYZXSKxHrof6BXzCgJYzFyFM9AOFg/oDq4a1UfnPMHpLDi4iogUh+QSYnZXycACDGqwA24cB0+QL77xTQiw/tR1eY8fkAr/o4X+tQjf6owW+97E4Lr5QhSS6Cer1HSloQW0DRZzk86ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEdpzhGx0Y/rfINjf2tSc17l8oUcniiDsnYnkEHrDL0=;
 b=X+nYs2B3QaGLISoexS4EDehmjE3jGsmNNhVueOvr4VP/1jsBmc5yem+Q3CKClFCQ6mq6xE525h20Fta93C/R+RzyU8bCUhP3rGbIGXvi95NP2TIS3zS/yySiTftHm4bkgYaDFuAEANr9Bh4PZLggTQUBbuL+JCUM7YV8oDNB3ompLJfCOjccYwvDc7snm9TnOLyZ2cAo1mFgsFtOq2N7F2Rb2LY2zzljpA3L1ZXTUBwnq+1jwicL4HrLCWFzH3RteWpsog87lKs/4LIevvr0yf/ZVVVf9GfjAmp1CPLpgqif6oxlUvbEGQpy1AuzoXfF/mW4b5hbRGKXhk/GhWPXrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEdpzhGx0Y/rfINjf2tSc17l8oUcniiDsnYnkEHrDL0=;
 b=mlfJIcLjTBuCwgwvkv3QnGa8c70xmo98RtQhBOWZoReBAHivOiDcCKYLRc1kHe6iM1QafFJUkotQwwCgU+W2bkcxHv4nlbOX5kph054mZtkaLFTyduTFqYsjAdrwFL8TojTulFSpdEBVw7eQx9F3WZUjtQ7yWhzVNJnzCdSNKVA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR1001MB2233.namprd10.prod.outlook.com (2603:10b6:4:2e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.19; Tue, 21 Jun
 2022 02:08:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 02:08:22 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     syzbot <syzbot+58b51ac2b04e388ab7b0@syzkaller.appspotmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arve@android.com" <arve@android.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hridya@google.com" <hridya@google.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maco@android.com" <maco@android.com>,
        "surenb@google.com" <surenb@google.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tkjos@android.com" <tkjos@android.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "minchan@kernel.org" <minchan@kernel.org>
Subject: Re: [syzbot] kernel BUG in binder_alloc_deferred_release
Thread-Topic: [syzbot] kernel BUG in binder_alloc_deferred_release
Thread-Index: AQHYhEe0LSNSuMCxHE6kNIxqPIukD61ZHvcA
Date:   Tue, 21 Jun 2022 02:08:22 +0000
Message-ID: <20220621020814.sjszxp3uz43rka62@revolver>
References: <0000000000004a0dbe05e1d749e0@google.com>
In-Reply-To: <0000000000004a0dbe05e1d749e0@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10a5eb16-0157-435f-ff5b-08da532aeb47
x-ms-traffictypediagnostic: DM5PR1001MB2233:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB22333953D9BD4EE0FC991F7FFDB39@DM5PR1001MB2233.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ptVcKU7/sA1rzSRlRK7SgXayoGD6gqBRhaTqtVw+TMIAmkSPca112s3eWVG4uqJfBOaGsmwU3V468G5lvcvVb8+tdeHlqOl6G7i6sEtBoff2hxJbVlBzT0YbWJCem4yMm++5WU/Au8pyJgaQJm+Uz/M9K5C6g+MRZGT1OlRFWSESZpBDlbaQpg8XTr05nddq1HdswdR0Ktymc3HwPcJAkROYG5oXBNqjImyXYuCjodKD+ykqUGcQIxNKDABpinjfX3Tjtqv5FaX9MF6T56t7kkNBbIBXSZEmRj8J6tUP5YmZSk9D3x4UqAxXCz6ePjOc+YNIJQ8I05YvHUiiapxqAt2roT2Qog2u3dlwhuN2MGph7V1XFrlK2dSRGlI3B8RsSpNgeGf8G5M4RF7b7BraAduyIz64cN2xmOVWeL6Eywnf4MNeIA3aRnFfwoWJoNMWHty2lFFUi+ZnuJjPCdZEytuuxVpwnD8KirPMMHu7fiS6/GSJw8LW2kM/+EQKVTCcWDECe/rCIc4WfJLZUkaY20TaxnVcUyGmIvBbsx2AjEwW5Yj/2HPEpH1Ib5CWuxddCBvzsprcTRfUGWCU/Qrk0+4dfoQn9Lh2vEhOF7HS/TTOKxnJGsUM5SXF7nuMescP7SokLzdKH//bo8ia1IoGWHqo2ooxN/ydiMzPTJeAssmbmhp6o6gK0Zte+0y7VhLdu1eyUKfnWu4KpQ2V3df17wiQn0X41HH1SazAFZYBGcOgA9sWJXPKYHn7MlA1He+xIX8BHOdWktxLnN9BgKYypV8X82jUkF606c7IvyYDc4bnyZDG8N05i0YtKCmxSiYrl7RfOl15B/UAAeUbdwnEU3cnm/kI8J1B6LvKjV9KkV0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(376002)(136003)(39860400002)(396003)(366004)(8936002)(38070700005)(86362001)(5660300002)(38100700002)(7416002)(122000001)(2906002)(99936003)(44832011)(26005)(9686003)(54906003)(6512007)(83380400001)(186003)(478600001)(1076003)(316002)(6486002)(966005)(41300700001)(6506007)(33716001)(71200400001)(66946007)(66556008)(64756008)(66476007)(76116006)(8676002)(4326008)(91956017)(66446008)(99710200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?efhD43v0YTTby2PKPJcXbNH9mPFcPFd3riPCrtPJ+JadtF79BnMmaxPlFlQG?=
 =?us-ascii?Q?QtiVRUSSdkPG68I/cuMHuz55f4i/Bai30J0pz7pyaiSkERUqA1OJAq3iLr05?=
 =?us-ascii?Q?dr3C2b2gN71aFbpTX6HFNuH9/eyQVhnDtFYQHZQuG+J/a8k0B1yYLw78hT++?=
 =?us-ascii?Q?OfGQgy2GYXLc2Ug1dnb+ht74hZd9d5wsdwClWz4PA2ZJVvqVbmNjgndeUvqK?=
 =?us-ascii?Q?WdJ9j5r4P52/3npY7yeBvVqgdPl/xIsQIWtIpD0MXnwJ84SGn/0Z0S5pkz8w?=
 =?us-ascii?Q?OyAVnRf/4vpQrdgAKGboeacZvS6MCa2m775YbbRW4U7/es38FRZedcvqaCy3?=
 =?us-ascii?Q?8K16CsD2Ec090IB1bD/LlcPb8QUtn+S+Yc17lUAIeiDAe2de03jLHbgSBPRN?=
 =?us-ascii?Q?pJZLiAjk3+ykIzRn3gU6Gn838fuUO3ZBH9xawmh9hm72exlwekvszyIkUEJK?=
 =?us-ascii?Q?oWMf4HONOPIXJ6IXyRKUlWzkcYkQdJEbnJ8ye0EyV47AE1lisncu5r0iexNM?=
 =?us-ascii?Q?l5V8qJGVBt8oabZmtzyAnfObEcuWwirr4x/6W6hwPHCzEWXtJi9TWmLz9fVx?=
 =?us-ascii?Q?x5Z9hQEHv2f1yci+SnPKNMhqf5sXbk4CLWy9ohrl/Xlmj4Q7xwUkLf9f7Emb?=
 =?us-ascii?Q?GftatRv4SqXzOvmzoHOUlf8jTv9zBMrTdgxwJG2LJzKChOYX9OEXV0d4seZL?=
 =?us-ascii?Q?rpsHsyJbfJccsVJeRf+1nK2eDRzfrq6b3AoaHT8oYteO8p8RwQduhck0xkg5?=
 =?us-ascii?Q?TjSHJMXeDglZM0CDMStSqDYBaZxXakRZVrv1Mfa2JxBnu128VX2FgUkjgnr7?=
 =?us-ascii?Q?h+cBjcfrp3jW2la1ydQ9RLbYuNFn7omtNk8fOtF/Q3iq+0Vvwd+RoMnYBBQN?=
 =?us-ascii?Q?rSrJ5tx9vAHPmLvC/AdiiX+/pSdJ4mmG+c56+ndjrKtxfq3K0GSqEFbFPqLL?=
 =?us-ascii?Q?EAgyeQVPS6C+m1FNscdwgQiY/eQwiPt4IE7UYQ9W83qQmadAMW4knnj1lHDn?=
 =?us-ascii?Q?AO86mMEZWU0uTtqq3xfkAmBkay4/Hr33ZkymGJPIdSivF96jCgmql+pH4NSn?=
 =?us-ascii?Q?5L3Yd3tOxifJLaQSy0SzXplJz+D+k6VVPeyiVnuXZhh6kCX0xXw0TiECcgvl?=
 =?us-ascii?Q?KYMtVN7uR9p4CoxVr/Vy5e0LNdfPwiu4fMbkRm+SncsJkno++w4cxZW8iW4/?=
 =?us-ascii?Q?UFBFr4hvkkOEK2VsIFJ8i6p/oTwD6POM4/z3+Ucff2eRCokIXgtnuor5/SVs?=
 =?us-ascii?Q?syonVNMLrZWX7zycK3gQWWKgoSD8846XHNX6eyI/H66tWRFVQWe3hHCGjNB3?=
 =?us-ascii?Q?Nk0epKQY0RFr2n5+iVMltDDKIgx59LWPPt21PZ8IsyxLIh2HUPV444k9AAgl?=
 =?us-ascii?Q?1IRx1OjAF6Jh0KzDp5KZ0RJ+bIkYaBbpl7PbzS49zUXK0qazwKLncQO2dsL3?=
 =?us-ascii?Q?UdrfTI/CMNt7V7W5G/TjuMSeanDzVaNpKc9v2kOkBbnztEuWCtUrLl6Y7M88?=
 =?us-ascii?Q?NzrhKkP7JUXa0b9LnkKMJMdEaW2GuWbcofeBeB6J6vtVHKO5ilUcGkPy4+Rv?=
 =?us-ascii?Q?L0rDmmGCunYzmoYlUj2xkDhqcpp5Ha18r+Uxiv/4NNEXzv8JyZsWZ8Yv0WKh?=
 =?us-ascii?Q?0anuPMWxWApgLueY+QaFl3RnLu0g5ONq6cu0/GVY/+EmlYMhEok36eoVuZAF?=
 =?us-ascii?Q?6AgOFQf9lMxrm4AEzaqyW7ash2ywSh3dcRVmFkwJ84W6oKj1DUcq4OGcT2wy?=
 =?us-ascii?Q?R+UGV3SlztMrvLErRQJvsTr/Q2O/wrA=3D?=
Content-Type: multipart/mixed;
        boundary="_002_20220621020814sjszxp3uz43rka62revolver_"
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a5eb16-0157-435f-ff5b-08da532aeb47
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 02:08:22.6817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRDW0WXaA3k2VuBYNOQJ3Qbh8ciFBA9k3w5M4+JbtXe9+qkVxzgoSPfwgGrJJvoIV/x/Yb/LIyu+WHvrYIwt2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2233
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_01:2022-06-17,2022-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210007
X-Proofpoint-GUID: utZqB6kYWVhYhUUhFs5V9j7Q9c7hWbTn
X-Proofpoint-ORIG-GUID: utZqB6kYWVhYhUUhFs5V9j7Q9c7hWbTn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_20220621020814sjszxp3uz43rka62revolver_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <58FF055E9DB3484FBD8EA166DD9F3A8E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

* syzbot <syzbot+58b51ac2b04e388ab7b0@syzkaller.appspotmail.com> [220619 21=
:47]:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    6012273897fe Add linux-next specific files for 20220615
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D16596feff0000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db4154677977b1=
776
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D58b51ac2b04e388=
ab7b0
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1024e510080=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D113e407ff0000=
0
>=20
> The issue was bisected to:
>=20
> commit 42086abba43463fbf495cb80173600284b4c4e8c
> Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Date:   Tue Jun 14 19:00:27 2022 +0000
>=20
>     mm: start tracking VMAs with maple tree
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D10ef827ff0=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D12ef827ff0=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14ef827ff0000=
0
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+58b51ac2b04e388ab7b0@syzkaller.appspotmail.com
> Fixes: 42086abba434 ("mm: start tracking VMAs with maple tree")
>=20
> ------------[ cut here ]------------
> kernel BUG at drivers/android/binder_alloc.c:820!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 2934 Comm: kworker/0:3 Not tainted 5.19.0-rc2-next-20220615-s=
yzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/01/2011
> Workqueue: events binder_deferred_func
> RIP: 0010:binder_alloc_deferred_release+0x602/0x780 drivers/android/binde=
r_alloc.c:820
> Code: c6 80 16 c7 8a 48 c7 c7 80 b6 48 8d e8 57 86 05 fd 31 ff 89 c5 89 c=
6 e8 fc ba 5b fa 85 ed 74 c6 e9 78 57 55 02 e8 9e be 5b fa <0f> 0b c7 44 24=
 20 00 00 00 00 e9 27 ff ff ff e8 8a be 5b fa 48 89
> RSP: 0018:ffffc9000de07bc8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff8880519971e0 RCX: 0000000000000000
> RDX: ffff888026b0d7c0 RSI: ffffffff871f04b2 RDI: ffff888051997270
> RBP: ffff888051997000 R08: 0000000000000000 R09: ffffffff8dbcac17
> R10: fffffbfff1b79582 R11: 0000000000000000 R12: ffff888147653c60
> R13: ffff8880519972d8 R14: ffff888147653d10 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f99ddec19c1 CR3: 0000000077a01000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  binder_free_proc drivers/android/binder.c:4766 [inline]

...


This task has alloc->vma set to a freed VMA.  What is happening is that
I've added an allocation later in the mmap_region() code which is being
failed by the fuzzer.  This failure means that the vma recorded in the
binder code via the call_mmap() is going to be freed in the
mmap_region() failure path, but the binder code does not know of the
failure.

I was going to move my preallocation above the call_mmap() to avoid this
failure, but that will basically mask the issue(s) in binder.  There are
two other possibilities that could cause the same binder failure.  The
first being a rather unlikely arch_validate_flags() returning false.
The second is a successful merge of the allocated VMA
- also rare, but still possible.

The code records a VMA to be used later and drops the mmap_lock.
Shouldn't it record the *address* and look up the VMA when it is needed
to avoid using a freed pointer?  There has been at least one other issue
with recording the VMA [1].

Anyways, the attached patch fixes the issue I've exposed by saving the
start address and looking it up.  I've added lockdep checks for good
measures.  It fixes the reproduces from this email, but may need more
oversight.


1. https://lore.kernel.org/lkml/20190301230606.8302-1-tkjos@google.com/

Thanks,
Liam


--_002_20220621020814sjszxp3uz43rka62revolver_
Content-Type: text/x-diff;
	name="0001-android-binder-Stop-saving-a-pointer-to-the-VMA.patch"
Content-Description: 
 0001-android-binder-Stop-saving-a-pointer-to-the-VMA.patch
Content-Disposition: attachment;
	filename="0001-android-binder-Stop-saving-a-pointer-to-the-VMA.patch";
	size=3734; creation-date="Tue, 21 Jun 2022 02:08:22 GMT";
	modification-date="Tue, 21 Jun 2022 02:08:22 GMT"
Content-ID: <D23FAAF60772014F9FA1FA01158E5019@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSAxMzY5OGRmZTcxNzliMWZhNjAxMzZkMDlhMDI4MTllNzg0ZDA4OTY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogIkxpYW0gUi4gSG93bGV0dCIgPExpYW0uSG93bGV0dEBvcmFj
bGUuY29tPg0KRGF0ZTogTW9uLCAyMCBKdW4gMjAyMiAyMTowOTowOSAtMDQwMA0KU3ViamVjdDog
W1BBVENIXSBhbmRyb2lkOiBiaW5kZXI6IFN0b3Agc2F2aW5nIGEgcG9pbnRlciB0byB0aGUgVk1B
DQoNCkRvIG5vdCByZWNvcmQgYSBwb2ludGVyIHRvIGEgVk1BIG91dHNpZGUgb2YgdGhlIG1tYXBf
bG9jayBmb3IgbGF0ZXIgdXNlLg0KVGhpcyBpcyB1bnNhZmUgYW5kIHRoZXJlIGFyZSBhIG51bWJl
ciBvZiBmYWlsdXJlIHBhdGhzICphZnRlciogdGhlDQpyZWNvcmRlZCBWTUEgcG9pbnRlciBtYXkg
YmUgZnJlZWQgZHVyaW5nIHNldHVwLiAgVGhlcmUgaXMgbm8gY2FsbGJhY2sgdG8NCnRoZSBkcml2
ZXIgdG8gY2xlYXIgdGhlIHNhdmVkIHBvaW50ZXIgZnJvbSBnZW5lcmljIG1tIGNvZGUuDQpGdXJ0
aGVybW9yZSwgdGhlIFZNQSBwb2ludGVyIG1heSBiZWNvbWUgc3RhbGUgaWYgYW55IG51bWJlciBv
ZiBWTUENCm9wZXJhdGlvbnMgZW5kIHVwIGZyZWVpbmcgdGhlIFZNQSBzbyBzYXZpbmcgaXQgd2Fz
IGZyYWdpbGUgdG8gYmVpbmcNCndpdGguDQoNCkluc3RlYWQsIGNoYW5nZSB0aGUgYmluZGVyX2Fs
bG9jIHN0cnVjdCB0byByZWNvcmQgdGhlIHN0YXJ0IGFkZHJlc3Mgb2YNCnRoZSBWTUEgYW5kIHVz
ZSB2bWFfbG9va3VwKCkgdG8gZ2V0IHRoZSB2bWEgd2hlbiBuZWVkZWQuICBBZGQgbG9ja2RlcA0K
bW1hcF9sb2NrIGNoZWNrcyBvbiB1cGRhdGVzIHRvIHRoZSB2bWEgcG9pbnRlciB0byBlbnN1cmUg
dGhlIGxvY2sgaXMNCmhlbGQgYW5kIGRlcGVuZCBvbiB0aGF0IGxvY2sgZm9yIHN5bmNocm9uaXph
dGlvbiBvZiByZWFkZXJzIGFuZCB3cml0ZXJzDQotIHdoaWNoIHdhcyBhbHJlYWR5IHRoZSBjYXNl
IGFueXdheXMsIHNvIHRoZSBzbXBfd21iKCkvc21wX3JtYigpIHdhcyBub3QNCm5lY2Vzc2FyeS4N
Cg0KRml4ZXM6IGRhMWI5NTY0ZTg1YiAoYW5kcm9pZDogYmluZGVyOiBmaXggdGhlIHJhY2UgbW1h
cCBhbmQgYWxsb2NfbmV3X2J1Zl9sb2NrZWQpDQpTaWduZWQtb2ZmLWJ5OiBMaWFtIFIuIEhvd2xl
dHQgPExpYW0uSG93bGV0dEBvcmFjbGUuY29tPg0KQ2M6IE1pbmNoYW4gS2ltIDxtaW5jaGFuQGtl
cm5lbC5vcmc+DQotLS0NCiBkcml2ZXJzL2FuZHJvaWQvYmluZGVyX2FsbG9jLmMgfCAzMCArKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCiBkcml2ZXJzL2FuZHJvaWQvYmluZGVyX2FsbG9j
LmggfCAgMiArLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2FuZHJvaWQvYmluZGVyX2FsbG9jLmMgYi9k
cml2ZXJzL2FuZHJvaWQvYmluZGVyX2FsbG9jLmMNCmluZGV4IDUxYjUwMjIxN2QwMC4uZjU1NWVl
YmNlZWY2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9hbmRyb2lkL2JpbmRlcl9hbGxvYy5jDQorKysg
Yi9kcml2ZXJzL2FuZHJvaWQvYmluZGVyX2FsbG9jLmMNCkBAIC0yMTMsNyArMjEzLDcgQEAgc3Rh
dGljIGludCBiaW5kZXJfdXBkYXRlX3BhZ2VfcmFuZ2Uoc3RydWN0IGJpbmRlcl9hbGxvYyAqYWxs
b2MsIGludCBhbGxvY2F0ZSwNCiANCiAJaWYgKG1tKSB7DQogCQltbWFwX3JlYWRfbG9jayhtbSk7
DQotCQl2bWEgPSBhbGxvYy0+dm1hOw0KKwkJdm1hID0gdm1hX2xvb2t1cChtbSwgYWxsb2MtPnZt
YV9hZGRyKTsNCiAJfQ0KIA0KIAlpZiAoIXZtYSAmJiBuZWVkX21tKSB7DQpAQCAtMzEzLDE2ICsz
MTMsMTUgQEAgc3RhdGljIGludCBiaW5kZXJfdXBkYXRlX3BhZ2VfcmFuZ2Uoc3RydWN0IGJpbmRl
cl9hbGxvYyAqYWxsb2MsIGludCBhbGxvY2F0ZSwNCiBzdGF0aWMgaW5saW5lIHZvaWQgYmluZGVy
X2FsbG9jX3NldF92bWEoc3RydWN0IGJpbmRlcl9hbGxvYyAqYWxsb2MsDQogCQlzdHJ1Y3Qgdm1f
YXJlYV9zdHJ1Y3QgKnZtYSkNCiB7DQotCWlmICh2bWEpDQorCXVuc2lnbmVkIGxvbmcgdm1fc3Rh
cnQgPSAwOw0KKw0KKwlpZiAodm1hKSB7DQorCQl2bV9zdGFydCA9IHZtYS0+dm1fc3RhcnQ7DQog
CQlhbGxvYy0+dm1hX3ZtX21tID0gdm1hLT52bV9tbTsNCi0JLyoNCi0JICogSWYgd2Ugc2VlIGFs
bG9jLT52bWEgaXMgbm90IE5VTEwsIGJ1ZmZlciBkYXRhIHN0cnVjdHVyZXMgc2V0IHVwDQotCSAq
IGNvbXBsZXRlbHkuIExvb2sgYXQgc21wX3JtYiBzaWRlIGJpbmRlcl9hbGxvY19nZXRfdm1hLg0K
LQkgKiBXZSBhbHNvIHdhbnQgdG8gZ3VhcmFudGVlIG5ldyBhbGxvYy0+dm1hX3ZtX21tIGlzIGFs
d2F5cyB2aXNpYmxlDQotCSAqIGlmIGFsbG9jLT52bWEgaXMgc2V0Lg0KLQkgKi8NCi0Jc21wX3dt
YigpOw0KLQlhbGxvYy0+dm1hID0gdm1hOw0KKwl9DQorDQorCW1tYXBfYXNzZXJ0X3dyaXRlX2xv
Y2tlZChhbGxvYy0+dm1hX3ZtX21tKTsNCisJYWxsb2MtPnZtYV9hZGRyID0gdm1fc3RhcnQ7DQog
fQ0KIA0KIHN0YXRpYyBpbmxpbmUgc3RydWN0IHZtX2FyZWFfc3RydWN0ICpiaW5kZXJfYWxsb2Nf
Z2V0X3ZtYSgNCkBAIC0zMzAsMTEgKzMyOSw5IEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IHZtX2Fy
ZWFfc3RydWN0ICpiaW5kZXJfYWxsb2NfZ2V0X3ZtYSgNCiB7DQogCXN0cnVjdCB2bV9hcmVhX3N0
cnVjdCAqdm1hID0gTlVMTDsNCiANCi0JaWYgKGFsbG9jLT52bWEpIHsNCi0JCS8qIExvb2sgYXQg
ZGVzY3JpcHRpb24gaW4gYmluZGVyX2FsbG9jX3NldF92bWEgKi8NCi0JCXNtcF9ybWIoKTsNCi0J
CXZtYSA9IGFsbG9jLT52bWE7DQotCX0NCisJaWYgKGFsbG9jLT52bWFfYWRkcikNCisJCXZtYSA9
IHZtYV9sb29rdXAoYWxsb2MtPnZtYV92bV9tbSwgYWxsb2MtPnZtYV9hZGRyKTsNCisNCiAJcmV0
dXJuIHZtYTsNCiB9DQogDQpAQCAtODE3LDcgKzgxNCw4IEBAIHZvaWQgYmluZGVyX2FsbG9jX2Rl
ZmVycmVkX3JlbGVhc2Uoc3RydWN0IGJpbmRlcl9hbGxvYyAqYWxsb2MpDQogDQogCWJ1ZmZlcnMg
PSAwOw0KIAltdXRleF9sb2NrKCZhbGxvYy0+bXV0ZXgpOw0KLQlCVUdfT04oYWxsb2MtPnZtYSk7
DQorCUJVR19PTihhbGxvYy0+dm1hX2FkZHIgJiYNCisJICAgICAgIHZtYV9sb29rdXAoYWxsb2Mt
PnZtYV92bV9tbSwgYWxsb2MtPnZtYV9hZGRyKSk7DQogDQogCXdoaWxlICgobiA9IHJiX2ZpcnN0
KCZhbGxvYy0+YWxsb2NhdGVkX2J1ZmZlcnMpKSkgew0KIAkJYnVmZmVyID0gcmJfZW50cnkobiwg
c3RydWN0IGJpbmRlcl9idWZmZXIsIHJiX25vZGUpOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvYW5k
cm9pZC9iaW5kZXJfYWxsb2MuaCBiL2RyaXZlcnMvYW5kcm9pZC9iaW5kZXJfYWxsb2MuaA0KaW5k
ZXggN2RlYTU3YTg0Yzc5Li4xZTRmZDM3YWY1ZTAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2FuZHJv
aWQvYmluZGVyX2FsbG9jLmgNCisrKyBiL2RyaXZlcnMvYW5kcm9pZC9iaW5kZXJfYWxsb2MuaA0K
QEAgLTEwMCw3ICsxMDAsNyBAQCBzdHJ1Y3QgYmluZGVyX2xydV9wYWdlIHsNCiAgKi8NCiBzdHJ1
Y3QgYmluZGVyX2FsbG9jIHsNCiAJc3RydWN0IG11dGV4IG11dGV4Ow0KLQlzdHJ1Y3Qgdm1fYXJl
YV9zdHJ1Y3QgKnZtYTsNCisJdW5zaWduZWQgbG9uZyB2bWFfYWRkcjsNCiAJc3RydWN0IG1tX3N0
cnVjdCAqdm1hX3ZtX21tOw0KIAl2b2lkIF9fdXNlciAqYnVmZmVyOw0KIAlzdHJ1Y3QgbGlzdF9o
ZWFkIGJ1ZmZlcnM7DQotLSANCjIuMzUuMQ0KDQo=

--_002_20220621020814sjszxp3uz43rka62revolver_--
