Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A2F4E9089
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbiC1IyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiC1IyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:54:03 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49DE53B6E;
        Mon, 28 Mar 2022 01:52:20 -0700 (PDT)
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22S6NiEQ022885;
        Mon, 28 Mar 2022 08:52:08 GMT
Received: from eur02-ve1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2054.outbound.protection.outlook.com [104.47.6.54])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3f37q3rhqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Mar 2022 08:52:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZX8yANHERGVMaSEXDCmiAeMKeU9RTuk+zwsik0K454MpjuvBPQ9bwNEKqgmQc5v1U1StZdqg8Bwt68dxQXjXZxNnOXyGE82lAvvLUQTGBxehl6L6xZIDC0Od848HPnfU5g4aWk1NWU1Y2xiX2BxnBSmqECehowDw+WuP67TRJY8kRqGVPZWI1bgVx6RCPeVAFaZ9frr3VBcvyZPAR+Y96TpwoYEQ8IYCdBqN3LYkSNLtKFO3ZC9dysOYVMtgatud15Oz8U01oZj1RhFT2lp25mn3rGqmbrQOcs0c52tnnFnkOPUs1aO7/34g/V9oMFz/YLy9sQ1m1LUcVvMLCiLO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhBX2Tmihkm538Dn6ysHnHVm3EPsNO7aQdJZ8Ep2tvY=;
 b=ndBG096LgfXkZybDn9obZVSNI8Bw2c6/uqj+YBG546/Kjnwh/opH/5tY7FgeVFKNhCKrgtHdVfTYV6y1gajwEP8erAqIIDKbeaSUMJtxe6i8pu0xODa4jz+yH+G9/46DApYrj+mOR78vrh4sTo1RYNjIMC4NDvx39hxL7739Qtg1704gP6lvS6uGSFXc/tmTZYVcCC3lV/O9+0mjTeuKL9HClEU/dICUoVbpTsQ6k5DJKkJQinXgCG0BeDpwetY1njaI3ekxdewWFP4RBQAAzGEwKTuI+ungn7p6xWUhVqDJMzd08edmw7WF4KBmO+h8+5IuXTZOsFKINCXn6Lk6Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhBX2Tmihkm538Dn6ysHnHVm3EPsNO7aQdJZ8Ep2tvY=;
 b=r5CZfnSMqQ9Oc5ctSaikYQlO+GEWIU0QBat0fg6n/AttZRRte2cQCiWw/QSUwY6lor/0u97Cr0jByRJ08vh+fiuh5LtCswpKLrAp9QtGS8wnWIUKZGbJexU1I2ViGcS8VfNgyiFb1rMxjGgM3b1O2VvkuFhjMK589drjbjv7uNgjvKSvcnAYW8YF7SwlhlLev5GWT7iQ6Szs6k1wKG1cA65F+JALL5cwf2UjiX2rKxjg51PLC0sFxn06yx7ea8R5t4AjztAa8v5okpL3OqzmO1k4ayFBgyEDuQXg45PeixtQSstXjm6uUfQ8J9BlQOoYMlWkw03c7JH498KW0XsYRg==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by VE1PR03MB5374.eurprd03.prod.outlook.com (2603:10a6:802:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 08:52:04 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::b12a:5b52:7c19:fbc]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::b12a:5b52:7c19:fbc%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 08:52:04 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Rob Herring <robh@kernel.org>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: xen: Add xen,scmi-devid property
 description for SCMI
Thread-Topic: [PATCH v2 2/2] dt-bindings: xen: Add xen,scmi-devid property
 description for SCMI
Thread-Index: AQHYMfvS+PrMFPR+OUmb9ZzOrE/y56y17gCAgAxYwICAACUbgIADdt4AgAV0tYCAAIi+AIABBJEAgAe5egA=
Date:   Mon, 28 Mar 2022 08:52:04 +0000
Message-ID: <20220328085202.GA1192834@EPUAKYIW015D>
References: <cover.1646639462.git.oleksii_moisieiev@epam.com>
 <5859bb58c8caf87985deb84d7f6bfc8182bd6a59.1646639462.git.oleksii_moisieiev@epam.com>
 <Yie47a4lqXjVzgxI@robh.at.kernel.org> <20220316164619.GA3489934@EPUAKYIW015D>
 <YjIzeyNoWhVAY5HK@bogus>
 <alpine.DEB.2.22.394.2203181644560.2910984@ubuntu-linux-20-04-desktop>
 <YjmvFZOqAcnoBcR+@bogus> <20220322192146.GA145617@EPUAKYIW015D>
 <20220323105422.2t726d5wbr5h2ksl@bogus>
In-Reply-To: <20220323105422.2t726d5wbr5h2ksl@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17e8cc98-303e-4d07-aac2-08da10983b64
x-ms-traffictypediagnostic: VE1PR03MB5374:EE_
x-microsoft-antispam-prvs: <VE1PR03MB537402BF5851861B662FE9F2E31D9@VE1PR03MB5374.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8nGB9GqyVhlpDDoKqlpeMaeS8MC+tNj764aaT8hWXIr4mUEeKKlj4CjgNrTpFJ902UAg4DazCROx6ihg7jo4s4VMgApKy+XOAYsdyficMxeACujzAFenYF9JczaCymyDatD7vrmBiaLQFe+ymwiphOek3Xv/6d19/yDyncrr6IzzEM1YeGfvcWGkPYeEiGLLYK47aAyO3I0U8U86SPmCJHKuLMPPC5HOcKkDxsSGu0cf92Es6TuQHf7stWRohftvHRsJnU4d6fr6jv5yx9bdo7VKBeAVouzfMSEW9uuRO/eGkydJsM52w8wjQMQib3mJsNxTrc5V0/Igodctdq1L2QyTMROszar4YMYtQUYkSE6YGHAYcjXwM8xHEyeS1CudwkCGvFo9cFkV2PNRUMOuHA6LnnI7VxjkwbrW12Q/0dZlVh2EadIN5Lf5f+WmZ5NAQ8YSN+/aijUdjCV3RhXwIJ1fp+lqteLOVvuuMzMFw8hC0zfr+8aSJ59sM22HRCS569wE0BjP8+WTPAQ1BuL5piTeoDNO5KSSRFriWANvVxgGTNTMY9eGrKmmlw+1Z0NW09hHmN4Is2xwAizOF51ere0pdXcnNPJEjlrNofmPD8Jza38zttOKqOfe2HdzQRxfRM0Cr6MtE0bcX6fZIcqHvCsvIJ+AaDZJTtJoxtnsiMu1auvz39Iq2Bt3wjvwnokPw1a739hYC8tqLbcXyUd39Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6486002)(54906003)(6916009)(316002)(508600001)(4326008)(33716001)(55236004)(71200400001)(8936002)(66556008)(91956017)(38070700005)(2906002)(64756008)(8676002)(38100700002)(122000001)(66446008)(66476007)(26005)(83380400001)(86362001)(76116006)(6506007)(9686003)(66946007)(186003)(33656002)(6512007)(1076003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5BcXDP3lsrGqzl6QTK9TkbrIM9xgKXgWcphiWBgU8DdYZ3Lx7WzET9NiDAAz?=
 =?us-ascii?Q?FZn2iLIjwGHM3QTFVFKkjWyynRG4BoSARSaqFHckO7qbPukLuGerSuUKeXwr?=
 =?us-ascii?Q?npttC8DZmdB+hg+OzlUAevMxp/3UamEvULkrKfpCrth6J+0M8a0mYTTIeWRa?=
 =?us-ascii?Q?CTOWEO/oKGeY3xRG3Jq8dcX6K4TH0MyKk3hmGgRL9mvKLpFfcIciSzUlBSfc?=
 =?us-ascii?Q?Y7DaJlfoKrQjIQqfblr2Kw8DKLNcFskvrtC4ZhY0YxGtKcFPJF3J6IzVsJeV?=
 =?us-ascii?Q?hVbgV0YIHy9XzVrVHSyBfA0NyXRbg1nk6R2ue7QZt4hz5SvRyZ26/UsvqEJg?=
 =?us-ascii?Q?Lmo0QEvfzq/vETHd6lYd79GT3QYMG4DTwvIhOVEeslxbUMO3gJ8i1YDc1Q7q?=
 =?us-ascii?Q?i26jYZmMvFXCERI7K+sQVeW24vuHM6EgvmViDsKjEdI6WnKGLgR2P6mHzzWE?=
 =?us-ascii?Q?0klDUsG3SvyC4FNqpZm0afJqXtzUADcvpq3FZWJ7gGfhCeBR21bggVNygsdY?=
 =?us-ascii?Q?T6LoEEmPqHPSZAs/WaajWzS06W+mwwUrvsiItIqPLSITfpDBs8ieoYt/8IDD?=
 =?us-ascii?Q?g4KK7xQngxd+PbaFlFPe6awtrVXFOIg+Dy3QHV7msuTHkakyyt3HDDVO8jyn?=
 =?us-ascii?Q?gbMMT9FShuubqCG/t1fJdfIRM+x1xdyofkjUs9m3NaBiXSGiessVEvCpa025?=
 =?us-ascii?Q?WtiDbpeJPeWoz0GoEFkti1QBBjSPur4/RZfOm2aig3XRSTGonMGX83RUqaJV?=
 =?us-ascii?Q?nmR65lTs9RLsZi7sKC8riFqcIHj6SrbJIiVFryAR+5Zb6U4zXILJFyjSESlN?=
 =?us-ascii?Q?SjoCjTgCOMC2PaX9LArWY/P3kA3AMj5o/3ZsWfL1pZRXAUperRqBZAJ834Wb?=
 =?us-ascii?Q?TuQY5iRFka8b4mx663nDLTxx5Q7l7s71l5mSNDqmHttKR5p+YJknwCAD8gSR?=
 =?us-ascii?Q?8ynaugxjhABcJB99QxGqrTzR2d76U6k3RdIGSeBaYqiXKr7+JJgyereVn7r+?=
 =?us-ascii?Q?X+flEG9XjwIwyyboDbFPDBm1IHeDeoCyH7tEdNh4XHj5np7Stzf9Y7xNxbUQ?=
 =?us-ascii?Q?sRgELzSvTR27UWjI6ZZrBmU1lnBbScYF44Uel3JOv5rptmIsR0g9TSz4p0dD?=
 =?us-ascii?Q?sxJ4dLxtnK7NcO/XJ4rmTM3stH6k+RDwUFtVyu82cVToVJKIMOOef5sPIspa?=
 =?us-ascii?Q?p2uLbDuSX0ChqpvM5x3Sl2Vs7SAKVU7H6GnAk8ck5KLAzqxF6ka6D/OxMmHl?=
 =?us-ascii?Q?bd6aDqZ919hadO9xESZ80L0JU5F1S0Zqp1tA4ueMFNMATv9inrdqQ4SJOkMp?=
 =?us-ascii?Q?Ir4eil4HWzbjDSkGOwkEReYYsGnEKrIkpReDmatHEsaxSp0zsZe7YWieIaox?=
 =?us-ascii?Q?HgAH05dyN42ucl9GN8h6kNN6JKMpbgcSyQLnILh5hPnfpzKDHkoLZFCEnyIh?=
 =?us-ascii?Q?hBjJ6m/oY2+Mn9jQU8tC8O8DbDqZDAWo8SxeqJ8aY5b5dz0kFQlshHSZIwmF?=
 =?us-ascii?Q?wTEjZs1js7GTLdsaD320zzKhiiPJchOWt2BVF1+/oOhBs1Q1i2QeIrPIJRPm?=
 =?us-ascii?Q?3o85IZPFi53RxF901QIgo9L+Gxm9dFTjG3MY1VZuOQ3diz5yB8KUkETSfrI0?=
 =?us-ascii?Q?7V3fS3MBGSXqD7WmEJnvHyg1klNjy1QUwa42lLJisWqgIPBBUFR9nwWv0cp8?=
 =?us-ascii?Q?G2K1shuQhrRTZtP0gBHlLmmYvPq4i3zCG8pJ738S437sNXZ68tLeLHD+iC1U?=
 =?us-ascii?Q?YpSMvAuMwjKal9Oyij6oxsfegGhzlTzyUCVzR7WqiokUDyRzNP9E?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9BA6B04B2855674596157F9DA0B7C9E1@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e8cc98-303e-4d07-aac2-08da10983b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 08:52:04.3091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: awGgeV+z/xsODEigU4weBNIIxz3rIVLyvH7IFtEDkEsIVvsr3aUV0EUtcb+/g3ymTVLWrHfLTCGmr+5L8m9qpZXKQ3uCJb2H9CQubNKqfSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB5374
X-Proofpoint-ORIG-GUID: YEsOMzPDxZmMAz4xE365Pezsf6fAytjM
X-Proofpoint-GUID: YEsOMzPDxZmMAz4xE365Pezsf6fAytjM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-28_02,2022-03-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203280051
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 10:54:22AM +0000, Sudeep Holla wrote:
> On Tue, Mar 22, 2022 at 07:21:47PM +0000, Oleksii Moisieiev wrote:
> > Hi Sudeep,
> >=20
> > On Tue, Mar 22, 2022 at 11:12:21AM +0000, Sudeep Holla wrote:
> > > On Fri, Mar 18, 2022 at 04:53:20PM -0700, Stefano Stabellini wrote:
> > > > On Wed, 16 Mar 2022, Sudeep Holla wrote:
> > > > > On Wed, Mar 16, 2022 at 04:46:20PM +0000, Oleksii Moisieiev wrote=
:
> > > > > >=20
> > > > > > > + The reason I want to keep it xen specific at the moment as =
we had some
> > > > > > > plan to extended the device-id usage in the spec which hasn't=
 progressed
> > > > > > > a bit(I must admit that before you ask), and this addition sh=
ould not be
> > > > > > > obstruct that future development. If we align with what we de=
fine xen
> > > > > > > specific as part of $subject work, we can always define gener=
ic binding
> > > > > > > in the future and slowly make the other obsolete over the tim=
e.
> > > > > >=20
> > > > > > IIUC you have some plans to provide device_id support to the de=
vice-tree
> > > > > > bindings from your side. Maybe we can discuss some of your plan=
s here
> > > > > > and we can come up with the generic device-id binding?
> > > > > > So I will have something to base on in Xen.
> > > > > >=20
> > > > >=20
> > > > > Sorry if I wasn't clear in earlier emails. What I mentioned was t=
hat I would
> > > > > like to reserve the generic namespace(i.e. just device-id) for ge=
neric SCMI
> > > > > usage. Since we haven't defined it clearly in the spec, I don't w=
ant to
> > > > > introduce the generic definition and binding now.
> > > > >=20
> > > > > As mentioned earlier, though Xen definition and generic once may =
be exactly
> > > > > same, but we won't know until then. So keep the xen usage and nam=
espace
> > > > > separate for now to avoid any future conflicts.
> > > >=20
> > > >=20
> > > > Hi Sudeep,
> > > >=20
> > > > I thought the specification already covered this device id, it simp=
ly
> > > > delegated the description of it to Device Tree or ACPI, which is co=
mmon
> > > > behavior in ARM specs. What is missing in the SCMI spec from your p=
oint
> > > > of view?
> > > >
> > >=20
> > > While you can say so, but for me it isn't to an extent that we can su=
pport
> > > software around it. I did share my feedback with spec author but as y=
ou
> > > know it was needed for virtualisation use-case like Xen and was rushe=
d
> > > into the spec. All it states is "Device identifier" identifies the de=
vice
> > > and the enumeration is not part of the spec. It defers to DT/ACPI.
> > >=20
> > > Since I didn't have to use that in OSPM, I hadn't given much thought/=
review
> > > on that.
> > >=20
> > > >
> > > > Or would you like this scmi-devid Device Tree property (or similar)=
 to
> > > > be described in the SCMI specification itself?
> > > >
> > >=20
> > > Spec doesn't cover that in general but do carry some recommendations
> > > sometimes.
> > >=20
> > > > Typically Device Tree and ACPI descriptions are delegated to Device=
 Tree
> > > > and ACPI respectively. Also specification updates are typically slo=
w
> > > > (for good reason.) We might be waiting for a long time. It is usual=
ly
> > > > not a matter of days.
> > >=20
> > > I agree.
> > >=20
> > > As I said, there were thoughts about adding device protocol to make
> > > all the other protocols centered around the device. The idea is as be=
low:
> > >=20
> > > Today a device A is associated with clock domain X, reset domain Y,
> > > voltage domain Z, perf domain P, power domain Q, ...and so on.
> > > Especially this would get complex with lots of devices and for virtua=
l
> > > machines.
> > >=20
> > > Instead let all these different operations use the device identifier =
A
> > > in the above case to drive clock, reset, perf, power, voltage,...etc.
> >=20
> > So, IIUC - the idea is to provide new device based protocol
> > which will allow agents to control different domains by using ony devic=
e
> > id? Does it mean that scmi drivers for agents should be also changed an=
d there will
> > be no back compatibility with previous versions of SCMI protocol?
>=20
> The idea is it is discoverable and if the platform advertises new protoco=
l,
> then only it will be used. Otherwise we must continue to use the existing
> and advertised protocols. Anyways I realised that we need not even consid=
er
> these new changes for the discussion here.
>=20
> > If yes - we probably can add scmi-devid property for current SCMI
> > version, such as scmi-v3,device-id (because current DEN0056D document
> > has version 3.1) and say that this property should be
> > used for SCMI versions, which doesn't support device protocol.
> > What do you think about this idea?
>=20
> The main idea we had is to re-use the generic definition of device ID
> Linux might need for other purposes like device assignments. We would
> like to avoid a mapping from the generic device ID Linux might need and
> define to the one in scmi context. So as Rob mentioned, it is better to
> define one in a generic Linux/OS context and see how we can make use of
> that in SCMI context. We could get some recommendations added to the spec
> if needed based on what gets added/supported in the kernel.
>=20
> So better to start addressing or responding to Rob's comments(not sure
> if it was this version or the previous) if you want a generic device
> ID definition. We are not adding anything SCMI specific as that might
> end up conflicting with the one that Linux kernel might add.
>
Hi Rob,

Based on what Sudeep have suggested, I think we may think about the approac=
h
of the Generic Linux device-id, which can be used for SCMI needs as the
device id.

I have some ideas, how the generic device_id can be implemented.
From my understanding - the Generic Device Id is the unique identifier, whi=
ch
can be set for the Device node in the Device-tree. This identifier is
already set for each node by DTC and called phandle.

I've tried setting phandle for the device-nodes, such as:

&usb0 {
    /* .... */
	phandle =3D <0x10>;
}

DTC seems to work properly with this constant phandle. All links works
for usb0 and all nodes, which doesn't have constant phandle receives
calculated phandle during device-tree compilation.

Also DTC will fail if I set 2 same phandle values in different
device nodes. So we can rely on phandle as on the unique device id.

What do you think about using phandle to set the device_id?

The alternative way I see for now is to itroduce additional property to SCM=
I
node, which includes list of the device-ids, such as:

scmi {
	compatible =3D "arm,scmi-smc";
	/* ... */
	device-ids =3D <&usb0 17,
				  &usb1 42,
				  ....
				>;
}

Looking forward for your opinion.
Maybe you can share some ideas about how the device-id can be
implemented?

Best regards,
Oleksii.=
