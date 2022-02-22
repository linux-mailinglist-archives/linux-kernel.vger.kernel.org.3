Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4A84BFFED
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiBVRQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiBVRQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:16:26 -0500
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B7E10874C;
        Tue, 22 Feb 2022 09:15:59 -0800 (PST)
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21MGdHkv016399;
        Tue, 22 Feb 2022 17:15:54 GMT
Received: from eur04-vi1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3ed3hmg455-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 17:15:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4QARsOxt75iIMEWLuChYRozNN46b9Zruj8DSapt9jlELCAPBGu1rTIIxrzY/lhrLsO1wh3HWdJP0Ysdn2C2QAMp50IJXYFWtvjQ/+2ohFmOtIIOUVb+59h0Jk8qixTyjlhFpTAoRi6r53Na7IOojPM/wq6HopMxPAduVlEA1YTqehV7Hdd4DQypEva10ITdjGz3L9mEOs/h1TBI+PWfd88qeqwhcfM5U/7i+7+N8xcwhUAlpu+AJRFM3kwbaf2neQJI7+T9b09DdOxFKX3bm1C4h6DJaoysKd5ZSybTqdoPTl4+6F8iVcxcHZfsjnD2v8s3t1sUP7Q//iLR5I3lqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unFCmEUDIo4auc8K3GBMcy94FFIhO1izgA13pQHiBrY=;
 b=kYF3dWiJLqTSxDdAz+FMQ3tMDB0uwZbLX2gXXjrD3OIpQi5uRM348gaUCO2gQ6yI0WyNpEe4CZBF4npygeZ00X2GmLJKKw/+vqR3Jyw/VG0220JoHvJUgtwVBSFN2PZitfqEvk+3Z8P3z6wObmhbmJnGK4++kiOpuqMXOPxTKrcJ/Qi+KsdqVdjf+nYi1BSv2dZQQBvCofvuZwXd+2iQK3VwI3jEEdcsShS79chKFJjYI0a3iBL8ujt2DHaMOShi1Zk++VqyMHWQBlk1zJXRWbdl+nGA0pj1I/m1cVcvzKplQpS+VCnl/RQAKgUFBRIS4dpjarA6RzPMyCP+3Sq3cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unFCmEUDIo4auc8K3GBMcy94FFIhO1izgA13pQHiBrY=;
 b=MoDJQmuuwCTD0ADqOl7FInzf5kthMyxgib24eyu7h+bZVBrYzyYCqEPJ2VTMTqStaHy4vXTNgwP1Cwy4melu4jFi/uyscXvkHXr95K1M/RleXcMI1tCAsUa+xY6pKTv7A1izfIp1cxDNdXYcQoC3/eJcfS1ot1x8em5h/7dZijdy/ykGy9FlKyIliEujlxs9HzNkufG12YRcpW/NHkkdWtF30DjjeFQL+8GftfoibKadBlvYLdm1osrw0JXTgtmv9effxt/P4lUZ/fbc2XtApa6DHr9xn4MX4QJADuIGVpmFKHFLUO/0sRQKMf7PkE23IYJx0Z7lYMURLy/wau5Egw==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DB8PR03MB6203.eurprd03.prod.outlook.com (2603:10a6:10:140::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 17:15:49 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 17:15:49 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Cristian Marussi <cristian.marussi@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Thread-Topic: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Thread-Index: AQHYJ0gzI98NnKSQaEaZikv/1tAERayfaB6AgABVqICAABNVgA==
Date:   Tue, 22 Feb 2022 17:15:49 +0000
Message-ID: <20220222171549.GA2194063@EPUAKYIW015D>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
 <20220222110003.GC21915@e120937-lin> <20220222160637.yn6pru4nfgwih23j@bogus>
In-Reply-To: <20220222160637.yn6pru4nfgwih23j@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 335ef721-cce6-48d3-55be-08d9f626f90f
x-ms-traffictypediagnostic: DB8PR03MB6203:EE_
x-microsoft-antispam-prvs: <DB8PR03MB620398D98F484D9DC590D4E4E33B9@DB8PR03MB6203.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tbR6wgTCGDqY0RU2ui018v+rfBgvyol/vBIAirC9mLS6yvAUPW4uZdWAsr0oWn0Pk3bOQlE6X1ulfyMxeEKiFxNtKEEALDc/l2FZ4HYOjzyJRBsz5nP6XbFN3IS8a31YSijYaPQYpKyta5wA+2MQ8FFoprg3Ko15zQDXniNjcyoe15RL/w/vl1sQCvRWgWxy0Abcbn7q1RXlLwl1tBM7gHixiT5tcuo0XUdib9ZIKdnhY3c5hHxAOtgm1k1dMlMr4q0Zuzt3CeZ5yKd50wWyftaATFnXLhdHUvSPh91KHDQIcCtv3uSDpfwkYwSB8rc6MPUxLkeUSBS06fyCZlY4GCq8APgYrRhRJ/XLPeqDjzbi6gnMBu/4p8+VedA6GP1Vzvq51ntG4htZRyUJvhNPfBbgb/5NPNXmTDJ5+WExYNgWcYwz5259nY1YDYtX4SeKlAvlHueF7NJ/FfEyahHFteJ+q4BXcH1FfNjp14YKj6z33PIO/q26X6UiXY8Jgze3tp4ZlFGV2/NhJIAAK4xh+cm1KBxANm3+ZAUJ00BnOLsQy+gyXLwcVeJuPCQOqlcqSz1XMvYYLlSv9BuQnC3iVyrjc3mIXunbDmNwtX8SLlfcjShwKEY1ZqXlmsCzF+3Bb8WRzYIIDhFSGdHpCGgIm4KJKOoYb0KCqgMZ62ZTvCa/k0s4JL0jqeJ85j0jb2rklDh2/C9eg66iwiKA7Ih0zy0EoQqcQw4McQQIPtdqu/7eQBw9hMElilpaJo0Sd0oPJnY5G3dnoh+wqse8+AzjjIU5KAs2ZNfg44ZvVBkSWvc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6512007)(9686003)(6506007)(508600001)(5660300002)(38070700005)(38100700002)(8936002)(30864003)(2906002)(66476007)(66556008)(54906003)(26005)(4326008)(8676002)(6486002)(186003)(966005)(71200400001)(66446008)(83380400001)(91956017)(86362001)(33716001)(122000001)(6916009)(316002)(33656002)(1076003)(66946007)(64756008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zci2sA1J1hTtEtStxBEQKjXlROg6Ty47dG6nusNQPaN6FMDwtGwyO0amB0u1?=
 =?us-ascii?Q?PGRuOzO4vtQtI+ycAXt0XLduLLErigS5vNC6ugWl3XT5KOTsqcDm212fB6M0?=
 =?us-ascii?Q?yU1IB2eleIrvac/uC5HJcTS1D6NZTlSnHNnzC+Wyc+jTCNhU11hsIOBPnjef?=
 =?us-ascii?Q?GEVu8iw9MIIzmY17JnYYpP3rAgKHYsb/Zi7/rO7SuKZLZUHs22Yiyas2eWzT?=
 =?us-ascii?Q?hcqAskUpqDbNvjSyZt0vNOqa+uothvX4kTyj0+lwoR95CNeJXs9G8OnPDm1b?=
 =?us-ascii?Q?NC0GnMGHr25HYLaF6vjwrxM/zYI5COn9LD9Sf7zavnsh9ntAsj1i+YTbxq5b?=
 =?us-ascii?Q?VDEqqOownZ1MmTOcdHjAWIyH8byAh4Hl1WRba2L8m7ywvpiZ7Kd0oU7pKXvh?=
 =?us-ascii?Q?QHkDglpbGcbCPqUoKUM4u2jWRRfZnhbWRSZr8SXyDsBjxhKrdwLU3wUVE0Xm?=
 =?us-ascii?Q?qyP0iv1kUG4Ajh9TIuXudnlYz5DjNXujH44UoVxEq7w0viSg4krNt2LgjDNd?=
 =?us-ascii?Q?zzaD3YSQn1URb5Q7R7Qmcaa0GCw/p6kuaxWtSFXzthOXEGRjLCd5bU424Hlh?=
 =?us-ascii?Q?ayTFAD7RJF8Gzq9tnsPGx+zZySKs5HOJRSndnpxl9tpo3H/2yXPpIyhoQdD2?=
 =?us-ascii?Q?F83TrbT9lTIEyRWvHu+vX7Y19zAm4N+jGhokbfrVnMAywqzNlzp1+0Lo63bo?=
 =?us-ascii?Q?d5gCwThQaDGRxfn0fuOA/nMV8JD0yO5EflndTQtMqajywzi47zEizIBvM0Nb?=
 =?us-ascii?Q?hTbScIjarnK62yn/oGMgHQBtxY2JfFoKDCaYsfHw8b9WZdqPt7LODXV7rIaM?=
 =?us-ascii?Q?Dy3UlTv7WqXKKHZ3pteNVSkPYPXnyUqvBGA8IJFaOFW43jzgBUzVFIpN9aIO?=
 =?us-ascii?Q?aKCp398mKN3HWUi0bzFC5d0adwtoFoiuE4T6eaGZ7FHVmI4tzQuLmcmDKOjb?=
 =?us-ascii?Q?OwWXunaUILQT/u0wYG1PaOKMDNnRtRAnrphdkvtO6DXbtxMl1t/ErOjhW6N9?=
 =?us-ascii?Q?1QJK1HEalX/eFMnjFFPaKRyXAbH1LEf15PyQe24+FWRljainte/ht0Dn/dXn?=
 =?us-ascii?Q?CfX3V99b8ZKFAA2Cs5uDme8G6Pmyd8Zm/YLPtSSVDYIXqcAUk0X1b7VMgfG4?=
 =?us-ascii?Q?2730L07uun6n90gJaf3+pU907iP0cG2BCS2AMC1gT9v5oa2ngf0rD5vqRYWH?=
 =?us-ascii?Q?MvZ1X329ABjE9dqnD0UamQM7WlckEqOeSwEgW7CL1ZrBMDzNpMhVGR7JTU9f?=
 =?us-ascii?Q?BCtJE9Cu4mWzwiFwUW0kRZr60YHgtJj5A3ne7jZMyGJK9E0W1qE5f8stan/d?=
 =?us-ascii?Q?tMiInImdcKYkuDkl+gYtq1pPYMt//Su/QRkoe8+cXVedtrRIVPcPZmqO+Ytt?=
 =?us-ascii?Q?FCLveT8pon5BoOaxO6NbKGs+0cNYu0deW+EYJ57xh/+s87B1cdCLU55QqppM?=
 =?us-ascii?Q?ge3iCgoUiGCn8ljsJbxKLmLiKS8XFV968exn32Jc8EJ3seWvbWW2PJX2chjP?=
 =?us-ascii?Q?vtiCJSGh2dXK4/PLBfNegyZKG3ZLu45oQXqRJhtMS/C2/NLpszjBvLOy3//i?=
 =?us-ascii?Q?oGeiJ0MIzI3D/3W864csvtOMu+E833lgqCn27yX/cGmdt/pJ4TyskECeKEF/?=
 =?us-ascii?Q?NYQo65r5No1P0gy++OcoVuGoM7GtV7Kp1TTMHTOsxCEJy2VQv5E6TAF9kbjX?=
 =?us-ascii?Q?wlGIPSqIGYV0g0kItZsRpSp48Vo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BBB9DB133DB5F54CB3AB51CA367C2037@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335ef721-cce6-48d3-55be-08d9f626f90f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 17:15:49.6588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UzuJHNDoQ8Eycx6pF87B4662P8o0Nal+s+o6anvjFKZyCQu0/PP7n/I3hCwSi9bETpXGqRlCE985gLqy05vSKxsxrjAjoJSEX+hCQ/NYLco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6203
X-Proofpoint-ORIG-GUID: 6VkzA6m_8s92ABPJ56Ir5DSi3Mnzz2Tt
X-Proofpoint-GUID: 6VkzA6m_8s92ABPJ56Ir5DSi3Mnzz2Tt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_05,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220106
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Tue, Feb 22, 2022 at 04:06:37PM +0000, Sudeep Holla wrote:
> Hi Oleksii,
>=20
> My initial feedback on this. And thanks Cristian for making it so easy as
> you have covered most of the things in depth(which I might have not done
> myself that well)
>=20
> On Tue, Feb 22, 2022 at 11:00:03AM +0000, Cristian Marussi wrote:
> > On Mon, Feb 21, 2022 at 05:26:46PM +0000, Oleksii Moisieiev wrote:
> > > Introducing new parameter called scmi_devid to the device-tree bindin=
gs.
> > > This parameter should be set for the device nodes, which has
> > > clocks/power-domains/resets working through SCMI.
>=20
> I prefer you had given more details on your usage model here instead of
> pointing to the other Xen thread as it helps for someone without much
> background on Xen or your use-case to review this.
>=20
Let me describe the process in few words:
We implemented a new feature, called SCI-mediator in Xen.
The proposed implementation allows Guests to communicate with the Firmware =
using SCMI
protocol with SMC as a transport. Other implementation are also
possible, such as SCMI-Mailbox, SCPI-mailbox etc.

In this feature Xen is the Trusted Agent, which receives the following
information in Xen device-tree:
1) All channels should be described, each channel defined as
arm,scmi-shmem node;
2) Scmi node arm,scmi-smc with protocols description;
3) scmi-devid should be set in nodes, which works through SCMI.

On start Xen inits itself as trusted agent and requests agent
configuration by using BASE_DISCOVER_AGENT message. This message is sent
to each configured channel to get agent_id

On Domain creation stage Xen will do the following steps:
1) Assign channel to the Guest and map channel address to the Domain
address. For the Domain this address should be the same;
2) Generate arm,scmi-shmem and arm,scmi-smc nodes if needed for Guest
device-tree (the device-tree which should be passed to the Guest);
3) Process devices, which are passed through to this Guest and set
BASE_SET_DEVICE_PERMISSIONS for the scmi-devid, received from the
device-node;

Guest OS will receive non-trusted channel and ignore scmi-devid fields
in the device-nodes.

IMPORTANT: Guest OS is non-trusted Agent. Xen is the only trusted agent
in the system. Guest OS uses standart scmi drivers without any xen
related changes. So Guest OS doesn't know it works through mediator.

The main question is - how Firmware will know what agent sent SMC
message and what channel_id should be used? I couldn't find clear
explanation in spec.
That's why I end up with the following approaches:
1) Current implemenation: Guest OS send SMC request, Xen intercept this
request and set channel ID to SMC Client_ID field (reg7), then resend
SMC message to Firmware. Firmware parses SMC Client ID to get channel_id
to work with.
2) Another approach is to generate unique FuncID for each GuestOS. In
this case no interception from Xen is needed - Guest OS can work
directly with Firmware.

I hope you'll be able to help me with that.

> > > Given parameter should set the device_id, needed to set device
> > > permissions in the Firmware. This feature will be extremely useful fo=
r
> > > the virtualized systems, which has more that one Guests running on th=
e
> > > system at the same time or for the syestems, which require several
> > > agents with different permissions. Trusted agent will use scmi_devid =
to
> > > set the Device permissions for the Firmware (See Section 4.2.2.10 [0]
> > > for details).
>=20
> I am bit confused here, so you expecting a non-secure/non-trusted entity
> to supply this device-id to the Trusted agent ? Is that not the breach of
> trust as any non-trusted entity can supply any agent-id and get the permi=
ssion
> to access the associated resource in this way ? Or am I missing something
> totally here.
>=20

No, Device-id will be used only by trusted agents, which is Xen in our
case. Please see above.

> > > Agents concept is described in Section 4.2.1 [0].
> > >
> >
> > Hi Oleksii,
> >
> > I had a look at this patch and the related XEN series and I'd have a fe=
w
> > questions/doubts. (adding to the loop in CC Souvik from ATG and Vincent
> > from Linaro since he's working on similar SCMI virtualization stuff)
> >
> > > scmi_devid in Device-tree node example:
> > > usb@e6590000
> > > {
> > >     scmi_devid =3D <19>;
> > >     clocks =3D <&scmi_clock 3>, <&scmi_clock 2>;
> > >     resets =3D <&scmi_reset 10>, <&scmi_reset 9>;
> > >     power-domains =3D <&scmi_power 0>;
> > > };
> > >
> >
> > So this SCMI device ID is meant to identify an SCMI device, viewed as a
> > grouping of SCMI resources (clock/power/...etc) so that a Trusted Agent
> > can issue a BASE_SET_DEVICE_PERMISSIONS telling to the SCMI Server
> > platform backend (SCP sw sitting somewhere) which SCMI agents on the
> > system can access which (SCMI) devices (in the Normal nonSecure world):
> > basically, if I got it right from the Xen series, your hypervisor actin=
g
> > as Trusted Agent (and recognized as trusted agent by by the SCP) tells
> > the SCMI platform server SCP (via SMC in your case) how to configure th=
e
> > access to the devices for all the other (non trusted) agents in the sys=
tem
> > (other Guest OS/Domains instances).
> >
>=20
> To add to the above, getting the device-id from GuestOS/DomX(X!=3D0) is m=
ain
> issue.
>=20

please see above. We will not either use not provice scmi-devid from
non-trusted agent.

> > The SCMI spec does not indeed cover the discovery of such devices and
> > the related associated resources: it indeed delegates such description
> > to FDT/ACPI as of now.
> >
> > AFAIU in this scenario I imagine:
> >
> > - SCMI Server platform (SCP) knows via its own methods (builtin_config
> >   FDT...etc) the list of defined SCMI devices and related associated
> >   resources like:
> >
> >   deviceNNN -->> clock_X / power_Q
> >   deviceYYY ---> clock_Z / power_W
> >   ..etc
> >
> >
> > - Trusted Agent (XEN hypervisor) in turn:
> >
> >   + is configured/recognized by the SCMI Server as a Trusted Agent (bas=
ed
> >     on the channel it uses to talk to the server) and as such it is all=
owed
> >     to issue BASE_SET_DEVICE_PERMISSIONS (by the SCMI server)
> >
> >   + has knowledge of the same set of devices/resources allocations (via
> >     its own FDT) as the SCMI server
> >
> >   + can issue a proper set of BASE_SET_DEVICE_PERMISSIONS telling the
> >     SCMI server backend which devices can be used by which non-trusted
> >     agents (GuestOS) ... even dynamically I suppose when guests come an=
d
> >     go.
> >
> >     Xen:
> > 	    BASE_SET_DEVICE_PERMISSIONS(dev_NNN, agent_3)
> > 	    BASE_SET_DEVICE_PERMISSIONS(dev_YYY, agent_2)
> > 	    BASE_SET_DEVICE_PERMISSIONS(dev_NNN, agent_4)
> >
> >     and in this scenario the same dev_NNN could be made accessible to
> >     two different agents, it will be anyway up to the SCMI Server
> >     backend to armonize or reject such requests from 2 different
> >     agents around the same shared resources
> >
>=20
> Agreed with all the details above.
>=20
> >
> > - Other non-trusted agents on the system (GuestOSes or other non
> >   virtualized subsystems...e.g. WiFi/Modem...etc), described in their
> >   DTs (for Linux GuestOS) as using SCMI resources as usual (without SCM=
I
> >   device id) just issue SCMI request on the basic resource and those ar=
e
> >   routed to the SCMI Server backend by the Hypervisor UNMODIFIED:
> >
>=20
> +1(specifically mentioning it to emphasize how much I agree on no need
> for device-id in guest OS(VMs)

I agree with this too.
>=20
> >   example for a shared resource:
> >
> >    - Agent_2 set power_Q ON --->>> SCMI Server - OK - powerQ TURNED ON
> >     				  (allowed as configured by Trusted Agent,
> > 				   powerQ hw was OFF turn it ON)
> >
> >    - Agent_3 set power_Q OFF --->>> SCMI Server - DENIED
> >     				  (disallowed as configured by Trusted Agent)
> >
> >    - Agent_4 set power_Q ON --->>> SCMI Server - OK - powerQ ALREADY ON
> >     				  (allowed as configured by Trusted Agent,
> > 				   powerQ hw was ON nothing to be done)
> >
> >    - Agent_2 set power_Q OFF --->>> SCMI Server - OK - powerQ UNCHANGED=
 (SHARED with Agent_2)
> >     				  (allowed as configured by Trusted Agent but shared with
> > 				   another agent)
> >
> >    - Agent_4 set power_Q OFF --->>> SCMI Server - OK - powerQ OFF
> >     				  (allowed as configured by Trusted Agent but shared with
> > 				   another agent
> >
> > So in all of this, I don't get why you need this DT definition aggregat=
ing SCMI
> > resources to SCMI device IDs in the Guest OS, which is an SCMI agent th=
at does not
> > need to now anything about SCMI device IDs (at least with the current s=
pec): this
> > would make sense only if the Linux Kernel was the TrustedAgent in charg=
e of
> > configuring the devices permissions via BASE_SET_DEVICE_PERMISSIONS.
> > (in fact you said you won't provide any code to manage this scmi_devid
> > in the kernel since those guests are not trusted agents and the won't b=
e
> > allowed to set device permissions...)
> >
>=20
> +1 (again)
>=20
> > The only tricky part I can see in all of the above is agent identificat=
ion, since
> > the agents are assigned an ID by the SCMI platform (which can be querie=
d) and they
> > have a set of dedicated channels to use, so basically the platform real=
ly identifies
> > the Agents looking at the channel from which a request is coming from a=
nd AgentID is
> > not carried inside the message as a source and cannot be spoofed.
> >
>=20
> IIUC, the physical/virtual transport and associated transport chosen
> identifies the agent for the SCMI platform.

Could you please clarify what do you mean under "physical/virtual
transport"?
For now yes - Firmware should get information for the channel from
transport.
>=20
> > > Given example shows the configuration of the hsusb node, which is usi=
ng
> > > scmi to contol clocks, resets and power-domains. scmi_devid is set
> > > equals to 19, which should match defined id for usb in the Firmware.
> > >
> > > Trusted agent will use scmi_devid to set the device permissions for
> > > the Agents. Guest OS should not have an access to the permissions
> > > settings, so no code to process scmi_devid was presented in Linux
> > > kernel.
> > >
> > > We are currently contributing changes to Xen, which are intended to
> > > mediate SCMI access from Guests to the Firmware. Xen uses scmi_devid =
to set
> > > the permissions for the devices. See [1] thread for details.
> > >
> > > [0] https://urldefense.com/v3/__https://developer.arm.com/documentati=
on/den0056/latest__;!!GF_29dbcQIUBPA!mGggDzmp0B8cSdGJdH4utz6sx7g5PMXq05mXf9=
1dU8XgkJaCuEpHdARZCdl-g1BnrduL$ [developer[.]arm[.]com]
> > > [1] https://urldefense.com/v3/__https://xen.markmail.org/message/mmi4=
fpb4qr6e3kad__;!!GF_29dbcQIUBPA!mGggDzmp0B8cSdGJdH4utz6sx7g5PMXq05mXf91dU8X=
gkJaCuEpHdARZCdl-g-bWzzb5$ [xen[.]markmail[.]org]
> >
> > IMHO, but I could be wrong, looking at the current SCMI spec you cannot=
 just
> > gather messages from a set of GuestOs talking via different SCMI channe=
ls and
> > then pipe/route them through a single channel to the backend server,
> > attaching/spoofing some sort of Agent source ID to each message like yo=
u seem to
> > be doing in the Xen series
> >
>=20
> I haven't looked at the other series, but it is hard to say the spec proh=
ibits
> this. I don't understand that spoofing part, but Xen hyp can arbitrate th=
e
> requests across guests I believe. But the devil is in details so I can't
> comment on what is done. What I can say is this Agent ID is in each messa=
ge is
> not compliant to spec.
>=20

In our implementation XEN do not copy any data from shared memory. The
only thing it does is letting Firmware know which channel it should use.

Best regards,
Oleksii.=
