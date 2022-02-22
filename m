Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1B04BFC63
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiBVPXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiBVPXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:23:21 -0500
X-Greylist: delayed 5314 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Feb 2022 07:22:55 PST
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79D3113DAC;
        Tue, 22 Feb 2022 07:22:55 -0800 (PST)
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21MDhK8A008539;
        Tue, 22 Feb 2022 13:54:11 GMT
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3ecyaj8ey7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 13:54:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVmCMyc6MjKtjPTT7Zkp7qTBPimpJr55WrKXAEglwFWYnEW9feKRqOQcOUxsyLe2eBFDCazaM0vkWIkZfGns+jP/5X3ncdx88hcbW71GadC1RtG9ixkAhw5Ozf6b0DvIijOOy16QYpEBqwWjFa7KGxIQ5PR6Wamn8YEkKWRZcDPh4jNhIa0PhYAgk7dju9/7dpY4R47XZ0joRgwraR5gvZTkJGBWLNL4Om+OqhyzNw9xgI9UbJYI0PmjtRAW3EFrKfn/xJd1goyhva9tdQeUPiXXOzzAaieK/Yq/XUOiiIiyyBTLo5XMLcNXfXxZeWn7pYxxWScEdNG3msC0N5/BAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSkmrWNfSUoaf/GnKVlojWjIOcvuwLmzJitFpFNL6Vg=;
 b=M9m8IXOOLuQKczLing78Haz6Lt1HnW15aj4CT4ZOVgSXq+f7BfazhKabSjCp0rtLtfPkSJx6zrB0GdlWwVubHDfrtllNbcQVF7jxMXuRhWk70iUCvHTXAtZO1JyqP7eEr7QKVlGnutqTGuEY/CTuCTLAuE0CLa+QS2Wq7sK0pq5JzZgcynfvv+2dViJ8KynYDQ5Lwcnz7uYRz2YcaaFHYSDP88ag7FXneKEPZMAL6Q7h6HRok5bChnjqI+Ue0z07kGxKzJ0Sg3DaDGKH/HpDyFkU+mBvVFDDY3P/KCRdcuIetiCa9ll6G97oJ2VVS8Opwn4urKYmT6fUHUmGJL6ZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSkmrWNfSUoaf/GnKVlojWjIOcvuwLmzJitFpFNL6Vg=;
 b=DlAt8CLxa5RLuYNtVSLe9I1ty1ItgLZ5N3DsCNf9zt5d/MX5Pl8mBVLok2WZNX894ulJvXpOmDwJe0U9PODfh552tyyXMMtI32nH/xxfstMrIEMDa4s6/4rB25fHYUEd9wAzdXe4KnoY/25HBASvO7xdOr3qy/uTUPkrCXz8a/ngkDyW57iRrgNA2U2oZjnuxYRNYGKyIesi/CUmiZItwqmNhb8RWJ8Qdaha7oFxJJScpbpaUn+0p4n1ajPYZSSDccXnfsz6DDdf2QWReOMvbeOiLRy2bU8k/ZqtDLx0b3sAI9mZrYX5fA6M0bof/wvNibiWsDQ2ydANdLghozOdSw==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DBBPR03MB6715.eurprd03.prod.outlook.com (2603:10a6:10:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 13:54:08 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 13:54:08 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Thread-Topic: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Thread-Index: AQHYJ0gzI98NnKSQaEaZikv/1tAERayefeSAgAAKkQCAAK8mgIAADbkAgAAI1wCAABGoAIAADPAAgAAr/wA=
Date:   Tue, 22 Feb 2022 13:54:08 +0000
Message-ID: <20220222135408.GA1765529@EPUAKYIW015D>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
 <2546477f-4190-e838-3095-f47b31802445@kernel.org>
 <20220221213932.GA164964@EPUAKYIW015D>
 <7f17ab8f-429f-d2e0-8f5f-bfa2dd19cc49@kernel.org>
 <20220222085532.GA439897@EPUAKYIW015D>
 <e9ef5936-63dc-f959-13f3-6ab3e9bf140b@kernel.org>
 <20220222103022.GA496631@EPUAKYIW015D>
 <e2cc06e9-df8b-696f-50c5-bea28fe53e42@kernel.org>
In-Reply-To: <e2cc06e9-df8b-696f-50c5-bea28fe53e42@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5889d63-be23-4a64-85e9-08d9f60acc55
x-ms-traffictypediagnostic: DBBPR03MB6715:EE_
x-microsoft-antispam-prvs: <DBBPR03MB6715A8C260512EFDC727AFDEE33B9@DBBPR03MB6715.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b1z+dkTt46Q8eRuhFxAGhSLPwAUsn8nFcuX5DwRV3bCSvo+sQnozkffAZTPrIV9idWLisF0A0HiyVSGZqmtmsdkCgxzb+lc13AIyBc56n8gCi8q/Miag6KqdtaNR7Ci4BtxIuzydq21djhQSoVw4gIllCtMg3tL+3pqcbtLIMuWaqNCaFWDaz00D/5i5YsWgG6fzC4wSMNYnu3bVpgaW8By/oQ9eN2AlYZZ5y3Lq4u+/OpbFfsxoPz27UzPY92OP9BKpl7N/fwwsyO/2MJRhtv6ip4t/eUS9ZYchX+21yuiJ9/Vbz437iIzouryjzoFvBUJ3n9zumpLhmPjHMa6QhlORYSqZ+eovwRQJHtuOeUfmz5jKD2lkAMNS66fLRjgXY2ZDkbqW64C4WyWWYk5sL2c5b4408sB7wP4sh4DKKBaNFzlb9Th94wkBUIwhduzmpTiW2kLMj1dfoYzM/Vi9TnGX5ZE0UOZJAv2F+d7VYjmbBxJqTuGF2tcsddIQ9BA0uWI58UES6ADUeKGFkipPChPCVtUzfxJhXyGnskZ8/hbr6Z0L5PK0MObYTjOtuKorUMfO64yakYp4ARW3szTLmIbK0Dt0GrVf2vbZ8HXxhlzryuvIlJ1wBfd48FstSimTp49eTJGSijICMojS5rBQRlQlzfv3qwiXRQchekJ6tXkJIsbmoCMWZ6oEelZJoT9aLteMuINWJyKN+7lIxUds6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(66556008)(66476007)(66446008)(64756008)(91956017)(4326008)(8676002)(76116006)(66946007)(2906002)(83380400001)(71200400001)(38070700005)(5660300002)(186003)(26005)(1076003)(53546011)(6512007)(6506007)(33656002)(8936002)(4744005)(86362001)(9686003)(33716001)(122000001)(38100700002)(508600001)(54906003)(6486002)(6916009)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tWbRB2qaVL+h+hiGIcQ6i6Fg261Q5aO9RBXMtTP9vaIIk1i+4uD7HELYLR3J?=
 =?us-ascii?Q?I8JFfSJGPx483wVEUWE0XJRViv5GiLp1JuXnoLF7Zo1TN1tJ9PUB37DmJd3d?=
 =?us-ascii?Q?/7ZS9fj/P2RFKbJzUbFcFW9Bq1DNkvQ6ghAub81cu5+EC6PD4BETBWvReRwF?=
 =?us-ascii?Q?mbttACkGtC8ntsHs70XSB0S4kzyddit3Y+XEfc7U4v+VO1HvkvLHZAXuTMal?=
 =?us-ascii?Q?/tdtPX5Lja8VAOMjFOlCMJHG20Wks4F4sCBffORpiB8N0qlNug3rmcUL4sIO?=
 =?us-ascii?Q?DN/57BazHFcSYcsNe4uGcbecy7W4KG5SXRDu7dQIxHt5+uu6Hkg+HAqWMQF6?=
 =?us-ascii?Q?nzmoTnTKflfoMse8+f9geW4BOmy6FqXziC0jKTYbd3e6hZNTvkb0c7SM38SQ?=
 =?us-ascii?Q?rZrlkfeGju1D7I78WYCEObRa3dEHqDXlAlOZiXLbhWtN3WwqVFCzFBm1Z3ce?=
 =?us-ascii?Q?Jycb9OiESu4a4NYoO7IgDOMrG0L4WfH185kAaRaqq3fZDFFvDB74xBisFgrT?=
 =?us-ascii?Q?J1gSUpqmvdAHemh1H3ocURWtU7ckc58dUxTB5d+XaD5mIWxN/30cc0QssoVO?=
 =?us-ascii?Q?xndK+PuhUrYZIKUpRajdYeoob5NaYWBsm8sqy6bqF+E+rP0uh+rFqLLZPb/k?=
 =?us-ascii?Q?brwX7VJu9ou7BOJ1R9HplQspRAZ5p//ABYMpIXFmcI78y4hH1qas+rEEXDjY?=
 =?us-ascii?Q?Gn+4drulwE1UJcdD27KFOQxLxtNap0o258kxxOouv4AI1OHAYTgKn/+DDUGw?=
 =?us-ascii?Q?bMATZX0SW4iJCfZRHtEEzvPtx8EZ0T3MALtEX3+HX0Hf/LJn7Ip4luSmMOXX?=
 =?us-ascii?Q?3U6T1negvUsAMDTcBr1Z+ZpH6qUDsNjtV0bbfpfZCusLqlw5LJP/0QJkgPOA?=
 =?us-ascii?Q?xwZ/ySgnfljBF/oU+nElBFaEbM9dRpK29rWIWOPcGzM7gcZoPPIPe1FOjHib?=
 =?us-ascii?Q?B4iBVEX/ZoMv2J5riau5jZP6610pfIFptvTO3f5P6FxW9mWhUJdEYX0dZopo?=
 =?us-ascii?Q?U89+1b3ayDSOdUO245DyR8MFPP06ZQa62IymWMO0CfXyPjCI46yFD70UbvQ3?=
 =?us-ascii?Q?kX0PIMkwbZfw0m7z00u4ogne79qpRHCZQITuSO86ZvGCrSwdGEfBlVxysP18?=
 =?us-ascii?Q?Hn3yih4H5+qHn+7ZQ4Iz8kgc4OsyM7w4B75/0ovFCnT93I/RA0Q2KnIZ3BrM?=
 =?us-ascii?Q?5woxPuj6u3PrjlzJFnt2EOmIQIRhol1AFiBV2grLrNj/6LkJxQquxlAfYPGh?=
 =?us-ascii?Q?g/+N4SjTDmEA7ENY4XIT4oD8vB6ipUc6hi4CwZGGF+vtnpIiv2ZxT1ARGyD2?=
 =?us-ascii?Q?UGkdPjnJEkC/NUTxVTkWcum3t8OIp8m69gJGTnuREQmcbNR76N/9f70+in5+?=
 =?us-ascii?Q?vTMoBsCd5Qr632zVJ3Rpj1Rrv0JmpodpwGqZu4PdKy/P+2CsZGCRqtLoHfvp?=
 =?us-ascii?Q?GriCQBQ1mPcTkl3OwKSI6RwAa9oqZtKww63rgMhSfuWW+sAA8hA1PiRID5J+?=
 =?us-ascii?Q?yASMjJapgDq+B/igas1G2kwZu8bntR1iduncu+XQe9bjNJUvikdubFOaBhfH?=
 =?us-ascii?Q?tRlRlmMfXDa0D1gmjVc6DNdj2DcnoKwcNG43gXv4s8QMLOGnMpbQaDYwP0wV?=
 =?us-ascii?Q?N0fEdtkFYztC+lkSDm/7x+o275VvKagigDhDiBa7V66+87B9nesgq2w9MjNt?=
 =?us-ascii?Q?y7mqlAm1YDN40JoJ3utml8c4d+g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A132C60ED361A142AD4285D78B25964B@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5889d63-be23-4a64-85e9-08d9f60acc55
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 13:54:08.6805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4fpAH0C0B9PnLl0dEmVMcu+J2u0b1ruvzYKUVSqsYZ2PRuShxJPjqyUZ/9wz/1KJLKGkjXgU8r/Kn/6183DNNZAq50Q43qco7tQpb35NAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6715
X-Proofpoint-GUID: WZyrbY0KD7igBVsBlYfLj01kO4NObm6Y
X-Proofpoint-ORIG-GUID: WZyrbY0KD7igBVsBlYfLj01kO4NObm6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_03,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=613 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202220085
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, Feb 22, 2022 at 12:16:40PM +0100, Krzysztof Kozlowski wrote:
> On 22/02/2022 11:30, Oleksii Moisieiev wrote:
> > Hi Krzysztof,
> >=20
> >>>
> >>> Also what do you think about maintainers: field? Is it correct? I'm n=
ot
> >>> sure if I used it correctly.
> >>
> >>
> >> I think you should add arm,scmi maintainer next to you.
> >>
> >=20
> > Should I update MAINTAINERS file as well?
>=20
> Yes, the bindings file should be added to the SCPI/SCMI entry. You can
> just add a wildcard * to cover all files.
>=20

Thank you for the tip, I will add this to the MAINTAINERS.
I think I would wait some time before making v2 because I don't want to
interrupt or split the discussion with Cristian.

Best regards,
Oleksii=
