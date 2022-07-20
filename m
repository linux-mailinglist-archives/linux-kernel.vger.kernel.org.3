Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A91057BD6D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiGTSJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiGTSJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:09:33 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4325664E0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:09:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlqUgNY+DGMVt0S4DQJGdU5Wt+7o+Vwj5wxrZJFu38AnjnJnT/LAXBkaF2ZYm/YB+/t2vrhGVHyMp3EbaGP8TYwD8vFlJtxvSHVxw1Ttm5NYGdmW6ps3tSTFIKucqjXvNJwXvQkbyFfQz8G7wIjSbDTL7AwVLA+2Qf5LlfQVi/wOZqUjrd8XsqaW0qpVxJNikPTcUShDR5AAid2Q0HHVrSXVBYzvVRrhPrKph27q+1MjbWsEiecDx8tZmxL5xydiuP1Qwan/ct3tnXwD6MFupKo1i541NTZhtUbUyqPDglam/o5gsBuM/NKrOBzIQYDhAzKDGh5kGrCmPma+YzvN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEFh2agHj/T/w10nT0819kV2d3G+AZHaJE7hfYX0/9M=;
 b=hTaWEFH6BqDQYJlHS9nt2NQxWFjOfpgQVUP19zanK6wkCyuCjFlxCuYhwjiGgn4Yee11lKFIKsjH1uHxP4S+L+pzf6tyIpEHLqLueneqDfJkfmIu2lzQaIoHiUhXsQ1GJImJtkYDRK5lUh3GRMaBuZ7pC2JRB0VNAxKYo0i1h4C+3RSEDgbaGtRmjfChTeYE4hAZHMEMoC8/Tah4wCM7rrR7RjlOJcnoMqsON/6HjWvHIhsafTki/Mb6c7H+BZpNKYP+YFH2FD+v6FGGOhDpsdfOFOCBgxOAz20MFreJ9ocPcROVNK0YOtFPJLFTbgu8sg8H2uQt99ne6ueXoZtLBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEFh2agHj/T/w10nT0819kV2d3G+AZHaJE7hfYX0/9M=;
 b=BtLlTbh1fr0M2WmzNs4D7TqIYN4tfz8vSTZOqJsR+cwvbtie1bybHmQda4JCoHxJ1EmZBYpUPCT3bDABl9bDhE8MxTJaPRRGmWfEvYOdru7rXnFECaNEb3Zl7xUZ36tzMR2MDKh3JQe+Nrl9toKGp7MNIbiXnnGKHm7KTj++6qU=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by PH0PR05MB8010.namprd05.prod.outlook.com (2603:10b6:510:79::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.10; Wed, 20 Jul
 2022 18:09:26 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0%7]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 18:09:26 +0000
From:   Nadav Amit <namit@vmware.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 01/14] userfaultfd: set dirty and young on
 writeprotect
Thread-Topic: [RFC PATCH 01/14] userfaultfd: set dirty and young on
 writeprotect
Thread-Index: AQHYmt3UDYXRE1Mixk6cAVqRRHRrrq2HBGsAgACEQICAAAa+gIAAAowA
Date:   Wed, 20 Jul 2022 18:09:26 +0000
Message-ID: <18EDDBB1-255A-475F-812A-8CA947493EC8@vmware.com>
References: <20220718120212.3180-1-namit@vmware.com>
 <20220718120212.3180-2-namit@vmware.com>
 <09d84297-65d5-a3df-fdc0-a7168cdb0798@redhat.com>
 <99AFB0A0-B2F8-420A-8164-1705EC14B255@vmware.com>
 <97e82e31-2411-501e-d401-d175eb24642f@redhat.com>
In-Reply-To: <97e82e31-2411-501e-d401-d175eb24642f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77d4f1c8-df7c-455c-0652-08da6a7afb8a
x-ms-traffictypediagnostic: PH0PR05MB8010:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I8QatM06LrsAyCe/jhlIKik28afAZ/yN1ViJMrzzsux2HxP327S/J2ILp0qyxlBPQEn6bE1HAdWRjlOd2ECrbITFu2vdJeZopTsTbHuduGAzk2rkEtUAmk3UnV8dAxWcq1EBC7Mqb1OaIje9jIxEwMDouINz9WnwodLEpbLTAsBxm0OxOSaYy6xCTOl4lyDkBFj/EBAVAJtFAbLUe0eAOUBXOaHPTlZeQXmXXKICrO7FLG/pZf1u4AH3BpxjzUfrEV7NAeufeoRdBurmgQJ+vM04mibsuf64ktS33sQ5Fy9ab5eT3LVSu9jqyodmLCxqORHSZI2MJlGSbduKEIGqxcbJ3fMFKYa5+4O2X8vW0v/Tzb1Fn0XQOaRjFKxYEx18e7e+ROsi3IGx/Z/vQ6KMBhlVhM5T9Y/xuX2JHdaw4BPJ1EYRmIKeLJKCIziX/2Ly2gVnWWXVL68Rdp4b2mmE+05TmfdX8gDvq22oaPJ8ntP4y7kZ9NPZUnNfVMO14GBI3MGwQvs+kSH7fRDg0R2TWrhsTAw4vUCxbCd3wMoWQ6cy8CQqIKauX9rBQpkJFr2w/szmf0y4yZ6OEAK7ZyDtby6ga6W5byBn3n3ZVeAV10OQFZDISAiMyz+zdgw+B7AeZdvCk0rc2ZB7UQmxMa1PjsicKn/1q3fXGDhVjAatZGyNZXP/6QpRxaCCxmqLXVzySwgTfvxcxJqoo2VBXRWBPV+ARSInKNjW+hHMlswvNlkwk5U8AnzSnm/witl6wyT0BDYv1VAOHDzkBkmpeAmsAJCc+U3tLzxDQiau84e+vZU27ykK+27GVN1VvPFJCu6MpmlTjxULT0BGYC3nSZcPEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(53546011)(2906002)(71200400001)(41300700001)(6506007)(26005)(6486002)(83380400001)(478600001)(186003)(5660300002)(6512007)(2616005)(7416002)(8676002)(66946007)(316002)(76116006)(4326008)(64756008)(66446008)(66556008)(38070700005)(33656002)(8936002)(66476007)(122000001)(54906003)(36756003)(38100700002)(6916009)(86362001)(14143004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TYgFy+JAbu4YKTda/Gr5t5do341af7z2t1MclOY5OwuATHWa2pu1GHsu11Yr?=
 =?us-ascii?Q?K0kzirpmZy4Q6UAHgkKY5hnEo++ziei1fjb2vhwn0a5EDh2ZdoxQGIujVqIO?=
 =?us-ascii?Q?vFQSI/sVENAG8uNyZrqIgV5SCFY24htqZf0XzAV2D7Jh60xLJWuWlALdRFJw?=
 =?us-ascii?Q?lsqbgUtUVYmFYUKsS9ZqvNmWomH1+mBghfkdjeQpOXiEzuzyxZLyqKU8q6iV?=
 =?us-ascii?Q?WcAryqz0nBcdiYLCTf2oG/O6h14xlecARc2kRRFkJzkEQHgb/EQOZrvkGjSt?=
 =?us-ascii?Q?7dwyvr35dgclhzOsy4WQJnpkVG5sF6CrwJSUTIuiS7sjYU+YesIwk/vqaOeB?=
 =?us-ascii?Q?K16dv0Gdc247oipkPV7slUpZF7ws1oDPsQuYQx0Av5C+KQfSsGsiLuh8B/w4?=
 =?us-ascii?Q?kKrM6HKIcEKSrp/m6cs+TdBZCMWaEXfGXbFJbcnb6c/TZcFdAAg/Be8/X6xG?=
 =?us-ascii?Q?vyiuWNO7ZeYaBW6xoYe0XlA7c2Xvo8xYKcENy5xVUf64fePKfoxkpv8JCdOm?=
 =?us-ascii?Q?6wGSRJH4jPKikdM3eQ1XKEYmcprQ6NxOR2130vp1R4iq/LsLb5wzL6fOpGSZ?=
 =?us-ascii?Q?qc1ZOCoP8mituqpDXRc5f77xeflFzH3qjPa91vpwsByURZgwanZuwEWnaB7G?=
 =?us-ascii?Q?emIiH7/JRsatU9IukbYUQfaDAccDQwXy7amy1hwZzfmAYn9SOzgVMzDl6LHW?=
 =?us-ascii?Q?0Lc4EX5W+nN20dZi24t8gqo8K9VJAF7Allu656w/ECiKB8c5o8ktAaiVJPNV?=
 =?us-ascii?Q?6X9rRbS9y1igkyiGZvOn0uAxoCmNvT0bQg9WR58yJJVoT51UX9cOFUEWpLBL?=
 =?us-ascii?Q?Ap8HqEYPA9Le3VPyamEHtinMNn9vAQpd+aeSyRgmYfa1yuF5ZNxZTA7EEQnq?=
 =?us-ascii?Q?QR2XnXir+tjjKBf97xhjjY5tXt19vUMCUM3biSrMsF2WNBffTjCBCqgBbc7W?=
 =?us-ascii?Q?PJOWODL0HDQriso8MyCzx97Bst6MF1DgwcVrJR1Q/t7eqP4euoAY1ZbBSvJ0?=
 =?us-ascii?Q?yZJRFbf60frhkPAu08zKaFGTHVxJu0zC2ogxrvGw9STSwnepAbsdPFQkxBh8?=
 =?us-ascii?Q?t64ZuzuzFWFHiGouJdLyQWttSck+iYCmLNqeP//Jy2gorDZpeGuamWINrZh2?=
 =?us-ascii?Q?fPtI3SzgB0uxgD3+y0RqLzZ9nPyQLgiXLehA0GdSmkRxf2ewvUbqeX7vVIIS?=
 =?us-ascii?Q?w4KqdKhL1+O1gYk1WcpT359edPrQvCWHBiuZBYrg9TDGswWy9RQ89HiQ20Nb?=
 =?us-ascii?Q?IMNwJ7XiI+9buZC/aKuLZC3yjqrGB9EhGh/g9RFgT+PT8Dp5fiWj/JMDEbY2?=
 =?us-ascii?Q?1k7pKsQLmYqvi5NMEqw4U5AP6Tmkr67gv5ftAND3I1fm2fcp9wzivdvyjHCN?=
 =?us-ascii?Q?+NLUpFvM15PULol5A6m+lowLO0j+4szGakgsPNArAHDrEHfU/sFouAQBQLZF?=
 =?us-ascii?Q?0WTHFMohjZk+qXdXOoCaJnqVoKzwzJajrPk09nKu5IDIQwIy5dLvqSt7xIuK?=
 =?us-ascii?Q?37zPi3SOPsP1HT9tYHd98NDSSZAV3fRpYbqo9CjT9SJJyRMGKYZ69HvKvuc4?=
 =?us-ascii?Q?vZfg5zeWV6qatAfBSV+46GbWBTI3JlNctKdeRNEY?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ACD1188BAAF3784F9876F7A3C02260CF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d4f1c8-df7c-455c-0652-08da6a7afb8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 18:09:26.4715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GqqXRgAA+zeJjiynNo+Ce8f+BEqGJDLfXe/nSjUEVI3GAs+O0ZO/DhT9rpDHw+YSj8LrNuMd8YcU0awatBP+zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8010
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 20, 2022, at 11:00 AM, David Hildenbrand <david@redhat.com> wrote:

> My patch review skills have seen better days. I thought you'd be
> removing the pte_write() check ... :( Tired eyes ...
>=20
>> Having said that, I do notice now that pte_mkdirty() should not be done
>> only this condition is fulfilled. Instead we should just have
>> something like:
>>=20
>> if (will_need) {
>> ptent =3D pte_mkyoung(ptent);
>> if (pte_write(ptent))
>> ptent =3D pte_mkdirty(ptent);
>> }
>=20
> As can_change_pte_writable() will fail if it stumbles over a !pte_dirty
> page in current code ... so I assume you would have that code before the
> actual pte_mkwrite() logic, correct?

No, I thought this should go after for 2 reasons:

1. You want to allow the PTE to be made writable following the
can_change_pte_writable().

2. You do not want to set a non-writable PTE as dirty, especially since it
might then be used to determine that the PTE can become writable. Doing so
would circumvent cases in which set_page_dirty() needs to be called and
break things down.

