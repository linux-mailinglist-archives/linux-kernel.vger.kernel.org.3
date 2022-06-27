Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CAD55C79B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbiF0PvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbiF0PvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:51:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E6018E03
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:51:11 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RDdI52012938;
        Mon, 27 Jun 2022 15:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6EScZzWEkxoL55gUWiHtp6L6r1l0Ga5NI+JzAfsv7pI=;
 b=IDbIM+57P7emSvTDhc0KePI3FsIIJaN9zLUFiO+8bgauGGXSkSsGG/hR98SsOyPEo8gz
 ktHtPFqMceq7I5w3O6lUiopBzb49AJ2EVdcIDvnV5ntwvcpymMRrbj6lEYqw+E8kVhA0
 DkiCSS8oaaOcC6BOgZPW6VzbHS95JrfdtnNIlf9vtCjtfLx1gEcyKPxLrUK7Ub0Pfyve
 kZQ8/14Zln9c/uyXL03gbDxtmfuWqYPW0ma22oP1HtpcWwi/88x3DYqy2URObieqJeKg
 Xolfnv4IjjgxKTJCJURKhCIFAGLv5vnEuyF7z4SEOrjq1thMPYaAE0a58sbWP5U1Yz1h wA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwtwu3n5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 15:51:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25RFUn7D026053;
        Mon, 27 Jun 2022 15:51:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt1jgvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 15:51:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEi02aLR+IEE1h2w0RTtPfQyNwa9UQ5JnAMTX4BzlOP0e+40wfIW+cXkN2vuogcuexPu5qNHqTUtvHfDQfLLVzmq/tcIupugmmH63ezwdEg12/fm3PhenPCgssTnAaI6ed6ktR9RIyUUrqRMKPqWRI42K8F/A1VfdmEp6KYxKA/LGDcArn/561rGvnXgiusEHAXL9eK7OKJQk+V3TCp8Hcb9H2fpjaVN5g0RTlGERSW8rW9OWfIzmw7mCdMyjxSSxN1PkzFQNe1+jezcqwnCVPqcZlYVhTLidB4xNafVEkbkkNzwYFIazt3N5Zk9kA72iIhKTPB8NIYrsLQdb7ukfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EScZzWEkxoL55gUWiHtp6L6r1l0Ga5NI+JzAfsv7pI=;
 b=itfLkgOQ0Kpj6B//pkgaVwJBccHw/TMNZQnpgBc2T8lE1Ah7EHd2DyVK/uO1qQaqdmLHTDyZ1F/Eh+ZxbMt9Kvqf9yvROIVNSr48cYh2vgWh/UosrndYnRJXc4fdCUXEASZ2rRvZZPV9g8fCK4ZBqFQIc18qC+qT5UiTNnUrY8LNmKdPciWCWDhnXHuTZqu4rBBdnDAlMgDOvTUB9XKNjFyX6dZ16NFM1eXP6ZAXPfw81qUyIDUXq+RFvjbW67UNNR4DRt/2uFa6ouqP7swrEP3dUM6UNsw8IEFRfqA/PfkqzG2wG2q4RRmavJxrFPTj1LGjxgZWrQ57FLQEhUfBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EScZzWEkxoL55gUWiHtp6L6r1l0Ga5NI+JzAfsv7pI=;
 b=htqyhsDbFj/dYlJknVKxABsEmm57HEgUi3x5o7GHBb6zSunjJPEgXs4zcaUmhyDARMemi7zvYTVLjpxqEKWrAAVg3PT6Tpp+qSCWHErE4F1kZRFlnBuh92Td4r+B4NY2pipBV6PDhsZMWepoxxg2uPokDBBSB5bZqr1hI4UEsfs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4971.namprd10.prod.outlook.com (2603:10b6:610:c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 15:51:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 15:51:04 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        John 'Warthog9' Hawley <warthog9@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: possible trace_printk() bug in v5.19-rc1
Thread-Topic: possible trace_printk() bug in v5.19-rc1
Thread-Index: AQHYgZTiaV2APa8LiECz6bYrBgXq161SKdYAgAAAwoCAAdkwgIAAXpIAgAMb4QCAB70xgIABL6QAgAAImQCAABIPAIAARgOAgAEwG4CAAXpYAIAAAhIA
Date:   Mon, 27 Jun 2022 15:51:04 +0000
Message-ID: <0FA59723-8784-4D28-AB5B-049D605095B4@oracle.com>
References: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
 <20220616113400.15335d91@gandalf.local.home>
 <E309A098-DA06-490D-A75C-E6295C2987B9@oracle.com>
 <20220617155019.373adda7@gandalf.local.home>
 <3BAD2CD9-3A34-4140-A28C-0FE798B83C41@oracle.com>
 <355D2478-33D3-4046-8422-E512F42C51BC@oracle.com>
 <20220624190819.59df11d3@rorschach.local.home>
 <3EB14A14-767B-4B66-9B28-97DDE7EECFD2@oracle.com>
 <20220625134552.08c1a23a@rorschach.local.home>
 <AD7B3406-C1A3-4AC0-BFD5-C7DF7E449478@oracle.com>
 <20220625190105.750bbb0a@rorschach.local.home>
 <B902ACBA-9318-418D-A14A-1411E7A8B47D@oracle.com>
 <20220627114340.4d89842b@gandalf.local.home>
In-Reply-To: <20220627114340.4d89842b@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e436ba77-b1b2-4d31-90d1-08da5854d7d2
x-ms-traffictypediagnostic: CH0PR10MB4971:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GrjAgF6fomTRWfzDnqzl2mJq+YL1GP59pARrSk/jk+X1f45wPwq+OFDlTMhxwZ7FG9YCLP38x+TInja8uwgjrDmmsK6k7kSA2wraBt0U5TpydmjDnQ/gAlo4x/3kWgHCOgwwQZS3fTbimDhIcWhlQYZ/FqXFhmEZC7lLQnbj15EUoHXSH4DESM8QJUHLxvjJZ/bKqqVpcZZICD1fE7vvXz3iXqJTwMDFJMz2VbITzisjTCTA7w5E3kaR2oac57yTnlTGyZP6Y8P+cfwa4746Ai8BrQo3h4d1aN+lS3cCz+VwYhUHWVfoy3i05p/wDWfS4F3dahbvJcVePEzscc/TMVdCRf2jPfYFFb+aKNh0cidqLIq2jOX25yCqJNZqQd1Cn2yxABQwKXC3fVjJdsOyt4e7V4p+3ZWY8B0ZpAzD5SxZhk3OZD/3leXtFBxUwO5tQtujj5n12kjaDMfuZt/WZUzgAhey0p2uz1nURnNhJw90Zj3Oex2bdtPZV6HApfoOX8cj9gAQaqnKuomGqbeGqAMiTGWNmGjCVRfiNoCAMU0Xs77R2EbGkxzgfLg2iBmIZytdzsCETxHommuS1qg25UYshKHZr24UmLBPVMWjvqFazOXLYUP5VFBqDIpItj7cVLFmPEnGjnUPgBP6V3VwHfREeW/qfgYRGltFli88GGKt3ygzGmenvkKWqjQ+Vz3eT/Si2bp7E4l6ZfhDcJU1qDmEyhwXDVwj3dUZAB+Emb90hR0lj6dNPcl138qo6ZOw8bi9EWlacErJQhHAhNXpEDHxboq/a7GwapZ+6hyluoklWk6hMUB7x2txA//ba8WWX4aP7iK0xBJYxV4KBgk/gUhQIEov9ccM+GeoGPVR8CU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(136003)(366004)(396003)(376002)(91956017)(86362001)(4326008)(26005)(53546011)(8676002)(66556008)(6506007)(71200400001)(76116006)(6512007)(38070700005)(66946007)(64756008)(66446008)(6486002)(478600001)(122000001)(66476007)(4744005)(8936002)(5660300002)(38100700002)(36756003)(41300700001)(33656002)(966005)(2616005)(110136005)(2906002)(316002)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OsLpW/jVPm070Ca13Z7sAGm5sD3zI4FA9QaWEUXDd2f2H7v2SXS1WapPUfbg?=
 =?us-ascii?Q?da5BzMq2HH9PIKFf93hv+NpOhBEknODQGsaPBnpPtV7JJLHwCEu+xLFm9MEM?=
 =?us-ascii?Q?qjAy29LciVruzyeu9JbhO4F//HU8D0D25GL3UO9mLG0ObJMy0C7rCE1cYiYk?=
 =?us-ascii?Q?K+HRdgy+2Eu4jt1D2Ow8YEwpzOt63cTL9PSMGWO1razSr/12tuC71VHNcpqs?=
 =?us-ascii?Q?Hv3OK3cgtFYEMq+IC3NJEIZ7rB4+Lw3bSuGTHZ/0bKJKYPHHsaURAISb7cpf?=
 =?us-ascii?Q?gCr9AGpba9czEtveH7sFifu+J4mscihVNreCZ3Q1CCUZQbwnjyeXAE61I//3?=
 =?us-ascii?Q?e0MjUS8O8SElBuxuDSi1ZBTA8tjHXI3ldHpkXqXFY1SelcC+zZ6F6mj2g/a+?=
 =?us-ascii?Q?wu+nycXbvhuarGc9zr/6SSOoT+HFmrsnIbREMTEl0uW/HvSoNStbOOZUTE6s?=
 =?us-ascii?Q?noLOlRxg7FWmO4V90aZzAu7vSQpYP5UHoGbPR4uSymaJyaOM7SjE+5i7jf1e?=
 =?us-ascii?Q?OPrmCbbFy0vdTIQbpk2+ahMW1IAGQo464+bR6g2NJJWmB29NxLF6aZEFtvRj?=
 =?us-ascii?Q?C8+QMFFOFWK/+4uqW1X5gFnOlyIYxO02Nk6Nb+dn2sNHIV/v/G8+V5zb8dtI?=
 =?us-ascii?Q?DIMlHrkNdNq6DP2xZUW82iQ5bS6W/rgI+rhahBeIQ6SOoLcRhX0YqYd5F3EE?=
 =?us-ascii?Q?mNSJIwbpX3ra0BbNgNjzLhybvaNuj3sPhZsx3c/MadVU3GYuT/7+auOYF9pR?=
 =?us-ascii?Q?MljlHu5tGw8UfP/ho+WuoEj2rXeJdvZP8juSxj9wXskQDyNQxVoHU6AKsatf?=
 =?us-ascii?Q?NHNEqzM8E27FZQK5YaYgQB7eo2kaFndxyqc609kaJLK27ErvBPl0vQ3U6+G2?=
 =?us-ascii?Q?sqfCBqvPp/3QbJL/5vI+nV48dMgQWRFmUdvXmW/1PMwcweQMZl2ugV96Jbzk?=
 =?us-ascii?Q?D9XY2R5hGFjm+ewkD9/zMorOGgYkFMOF27FkUy0MSt8K8X+8kM5lx/YxoYtp?=
 =?us-ascii?Q?LcbRYA0t+V/gxIBRnqYv505Ep+gYVRUuEXCBNjwSphCsZX+yeWYUy9nD4/4R?=
 =?us-ascii?Q?MGvKnvYgUwpsEBBLzdD6xBv7Om39QzGUF8aijzlobaQAnB5UHOeBg2r2bmR7?=
 =?us-ascii?Q?JRw1NSC9WNhA0S0Q5niLE5hzKWqTKFutGzGI5m/LOw3leJqRtF7lzl+1gT2c?=
 =?us-ascii?Q?2KRQxx7Rv3NUtP9fXIqG7Y/Qm2D85Wjc2qzmMyGdU3RTow5bz3NSnde+2qLh?=
 =?us-ascii?Q?eads8yGbLTloph6i6tqUa649lSC5Lh4ElLJ0znLzNSVTU9GRkimhGSK8t0DE?=
 =?us-ascii?Q?cD5G/mIsQE1gRl4zWRfIMt4YW0U4mheRsy7p64eaCAPlKEu+ge/qOYSq2JyI?=
 =?us-ascii?Q?WeljJEyrTb88px275DFFc3Lr/Fy2P1HGkkCwkY6Grw1UZBNGmZAFg+B9MEj9?=
 =?us-ascii?Q?K+ZJzqScWm77kPIe5Lc0pu/J+/SUmfTWW4RWsm5Ai0N/c5m+zLJSSc9Yyz4G?=
 =?us-ascii?Q?Ugt7fVW5L4U90AdM7+/Y+EQAkcYomjXUjklMBdjVl1Si0r9n3NMUdcCEmcOm?=
 =?us-ascii?Q?koRulcb0/6cqmpaTalcNhOqhWnjxq8R+u8qXpiGZ5lU80R6ZlCM84aAW/u5y?=
 =?us-ascii?Q?xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D2BB7684AF0AD418A03C6A06882478E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e436ba77-b1b2-4d31-90d1-08da5854d7d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 15:51:04.7588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MtwhUyGHYFTwAeNL4/Ybh/0R1gZdTT9735pS88Ui6ELv5aIlwNN36o4JRHiMqv47sqylVr4jD67/ZMLiYGs7Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4971
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-27_06:2022-06-24,2022-06-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206270067
X-Proofpoint-ORIG-GUID: hvF2qCooLOkXBvAiS5KkKSsDeOhkjGym
X-Proofpoint-GUID: hvF2qCooLOkXBvAiS5KkKSsDeOhkjGym
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 27, 2022, at 11:43 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Sun, 26 Jun 2022 17:09:31 +0000
> Chuck Lever III <chuck.lever@oracle.com> wrote:
>=20
>> [cel@manet lib]$ cd /usr/lib64/
>> [cel@manet lib64]$ ls libtrace*
>> libtracecmd.so.1  libtracecmd.so.1.0.0  libtraceevent.so.1  libtraceeven=
t.so.1.2.1  libtracefs.so.1  libtracefs.so.1.1.1
>> [cel@manet lib64]$
>=20
> According to https://trace-cmd.org
>=20
> The latest libraries are:
>=20
> libtraceevent 1.6.1
> libtracefs 1.4.1
>=20
> I'm guessing you may have a buggy version.

I checked with dnf. I have the latest versions provided in
Fedora 35, which is still supported.

I'd like to avoid having to maintain the latest version of
the tool and its libraries by hand on all of my development
systems.

--
Chuck Lever



