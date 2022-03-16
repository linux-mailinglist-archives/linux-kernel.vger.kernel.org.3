Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F094DB3C6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356901AbiCPO5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbiCPO5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:57:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0597966ACE;
        Wed, 16 Mar 2022 07:56:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHBpvqPCOUOgAis/TJaSyef0bL+zA2WfuAqKIDkbPZoKT1fuCgbc/gkg3fNmBrGdDVjuwS1k6ErbwKcxlFs+4+Sq1wiCfGQBVggIVGXA2/QgSfQU9ikbiKIE+RUCM3nLPGKf5QwDcUE6mz5/a6kWBmhrSg8aqtVW64WIc9oXuMA8m+H1Ng58C8jg+ejjlUjv2RifzGzMEobozrWB0JjJwh3SFkNrDx6GLSXfNlnvqhK+CzlAkmW/FFzymtKD7LvN4mbRPi+XahE121UcdZdTuxDGJNdN23O43M5nBgZYaN2HAOZJl6oZ9bqV4j8MjknVQznrMgPd0hgpSPYrLnzUNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aD2bXrvmqS29psDEYRQTV4HAqw7JlxM83LOMRVU6Ho=;
 b=a1p0RlvQJhGnDx8+1RJvOnx03WXfJp4Zx+7WsGr4pVq1O4MiaHfdvXCz+BxOsaespMAfh0htulFI0U21mNCRz8teDAkmLBfHLHaOG+nbsIR1VvKJI6c0R0s9UOY1rr9iwx/n7TEW/0oJFlE3A17qiE8YLePys/zSOodU93iq763uOcIcxnUdCsO6tW4W4cejn1UWJz/q+aJuWIlCHfdKbYeMVt56jFIptRDoal9hF3vijAy8PQFZ1i8Guiqa3hcOsQWgA2REzUKeTQujRZzncu96K3AcQzIW0mRh2wFLwR6FVRmx8iHc8fPLmTvxaqqK6TiSYuEZs+w3aScmP7kxTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aD2bXrvmqS29psDEYRQTV4HAqw7JlxM83LOMRVU6Ho=;
 b=3Au4YcvtN1qZc8djL4Aw6ysNgmAKyybTBK2IzAUODcx9RxpYpKiBXvsGGBoe7gVPyIyqebYpmE6C9B3Y6eO+ekgdmKaAYN3JJypXyoZPYVNZZ+c7R32OgKQwMBEdGDhsDgfo/s1zk7uQvjMRLFNAbyPvpgfq8DQltzi0Lkk8LDQ=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM6PR12MB4926.namprd12.prod.outlook.com (2603:10b6:5:1bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 14:56:04 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 14:56:04 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] thunderbolt: Automatically authorize PCIe tunnels when
 IOMMU is active
Thread-Topic: [RFC] thunderbolt: Automatically authorize PCIe tunnels when
 IOMMU is active
Thread-Index: AQHYOLPjSg5nd+aU5Ue+Y6z60pVXs6zBjSMAgABuJbCAAAqaAIAAAHtwgAAPhQCAAAQr8A==
Date:   Wed, 16 Mar 2022 14:56:04 +0000
Message-ID: <BL1PR12MB5157B030276D735F8C340609E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220315213008.5357-1-mario.limonciello@amd.com>
 <YjGD7N++F+ioISHb@lahna>
 <BL1PR12MB5157349C626E3818B813D9A0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjHpNloXEvPpv1In@lahna>
 <BL1PR12MB5157719E9A5C0EEBB652141BE2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjH2om/NSxLQQe2H@lahna>
In-Reply-To: <YjH2om/NSxLQQe2H@lahna>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-16T14:56:01Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8d6f626f-b690-424c-904d-3c641cfce971;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-16T14:56:02Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: e1ac9d93-5e6d-447d-be8a-1ed66830c653
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6f765ac-fcaf-4c8a-d4ec-08da075d181b
x-ms-traffictypediagnostic: DM6PR12MB4926:EE_
x-microsoft-antispam-prvs: <DM6PR12MB49262E51B33152C358B37824E2119@DM6PR12MB4926.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jJGwUlEZSCw6oeC9oL3lsg1Jdflv6gZ91IpNyJf3/iI/45JDhfw97uEj1XvXkAPD2RNmaWaay+Ne89rq9tun9Dd1bN1xIMQ5QgDbXXY6ljExXTXqYKkeMV0CYatVnDaPXbTnHfed9SC8UEwFJ39StXzi9KF2oxTUnvIfISYdAQzidt/mgnEdgzmAztyPpTFnWtPKMucyq+//yIt9Ko1B7jK8B9HOiJ83/Bn3hf1lOa5wO4yWK+jxQrdMsUoqwvHfJi79Cg15faHzb7AT7t7YbRTOIyX/qViGhxXEc/i+WmwjsFdLleFm3IpdfA+cd3zHDK2Rk/Yv1zQRhEdViffC92Ak/1MMUxQIiU3FhiajsdOaoFUew0a8/dfyec5ml5v74H9lOFucvUmiO/f1grQ6Xv1uvCyq3e5DliKUf0PyZ5k7CgamAjLn6hscihbD78hD2uUnXvp9Xx3m2gF6r6jrn+6zL8/BlGbtP/yCPnTQYl8cqBGii96vlGsEjHQ/i9grGxigMV783coJiphdRT2MDjODPCwsA2tadMNYjIQPgm2n4hdqRRTUc+a2+5U0w7Muuc7U35oUI0HIe01c9f9CvDZCGcGaAxM7ow7IWGW1MaffsH5nPu2zjuzFFlvd2Vx44jHfF4sosmTVdxn2RzAMlRLXBVm7SBdkEE8j2QLnjSgCgn982vB98rzzfLI6DoPHqWiI4DyQg0TP3rPPY+vJCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(7696005)(6506007)(71200400001)(508600001)(33656002)(38100700002)(5660300002)(2906002)(122000001)(316002)(38070700005)(86362001)(54906003)(6916009)(52536014)(8936002)(64756008)(66556008)(66476007)(66446008)(55016003)(4326008)(66946007)(8676002)(76116006)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JLw18QuLjIz8D9wxRRKKhQUE0HScXFdsLq/22gTA+SMSUT7AAT/QtGOy6jwy?=
 =?us-ascii?Q?fuXo7ATvT/csqR6O+H0hbnmlTLoZz76Ktilc0cN7ZyMhBvbz8EVUmo1OrudW?=
 =?us-ascii?Q?1qObXGwq6VQIGZxd8RotDlpPmNdBUGOg/mfeBaL58meAxugbfI8XoijV0/5f?=
 =?us-ascii?Q?D7st9Sq7T+U45xmgN/yhp36I3r13TJJuzHVQQEuR+WqnQc1mwsWNAkZZuJYo?=
 =?us-ascii?Q?da2fpf1kzVYUuYHX1Da3MRHKLSy4wwYhHkQcmvou3/vxnqyLRYcj9jyvlWZY?=
 =?us-ascii?Q?PF54qodbHPz7tJyt5oaO90DgP3pM3Fe2lsG+Q2nbNvRwAOU17y6AxRXHKkpR?=
 =?us-ascii?Q?zH266gr1Kyc3gvl2eha4g6wvKfLyQRzvmNCypIUWG4hImSO2axDg14izbxUr?=
 =?us-ascii?Q?uWmHvFIH5AOFqEivFbQ6b/r1FlOC3eb+P3JMLodPtpSuOoaO4UbF7BOqWGf2?=
 =?us-ascii?Q?EO7av/vWx0aoDsohtUSQU0+rP4oW7ndfS4n1r600puX25yLnLh1XQo7sL8rN?=
 =?us-ascii?Q?ImhixytqbI1w5g4IiV8FVs4vDqS0iG6rq7e/le8OZJStoPKUAdKjbiaSTypO?=
 =?us-ascii?Q?AwiyOMCl7d3YSnpi5Y2/mE/lqGdBxDC5iFj8E0QvrqaH44EG3hq2F4W+DnSW?=
 =?us-ascii?Q?hRgdzXYsc7NGcR9z9XozicI9iEOb2rczZMQenWrKpAL12gJJXqyYMYikmsTh?=
 =?us-ascii?Q?/HC8F0ijabudZQ4OAXhRBZFTr/gB/pAj/4qSCkE+caMKkqk4xxBxzGHRClW+?=
 =?us-ascii?Q?vLIAGTqkQuVreE+94ni/g1c70qHMJa451ctmvSG6bctLiETX9G8rofp//yxL?=
 =?us-ascii?Q?z49Kvlgh/jMnE2q9EeDWwlSerBLW6BqKd8Q7u+O/LOoFP44gI99NwjZVFvv2?=
 =?us-ascii?Q?c/0f3ttOZ62EWyAY08qZMW3sv/bT7lrx+2fsEOfhqQX8k/MsNnCmkamB6411?=
 =?us-ascii?Q?bfvznZBqIzMODimVP7GHr7jYcGYaux35BNRtILS+ECEw45vsbQAaMjSPa2vz?=
 =?us-ascii?Q?69ttd3BJz4iaMRRkYXArph2Ulfm8+S1bnGtCzFsMr2eUEnbcCrFlp1xGuqRi?=
 =?us-ascii?Q?93g1szjM0MLWjbtp5n6hfp3RIipXOy8rdjvhRi2HMVs5sr0umKUZ3O1sNwqn?=
 =?us-ascii?Q?Y7XPCpUOhLck3SJmLpqLacy9XlP6cKZWqWEVLxxNQQERrKnrVcCzIGFHoKh6?=
 =?us-ascii?Q?JyVKGauFMQyJiJ9TtVHtdeCGgo0rjeD1aLS1taMsVqDd9V0FaBjp8YTPwn4f?=
 =?us-ascii?Q?nAje0a6Wn3ni6J4WhXpifb4+NhPjNKoV/oAJcyxTB+38xBgmcgUIidwSdoug?=
 =?us-ascii?Q?+Kj8OWz6z65U5vaJSCzVz+ainX3Z/IG72iD/ITKrg+2R93aZ8r74Bj4EwduP?=
 =?us-ascii?Q?EdIBmt/U2jZ6ueFOoEsIdQYXzuk7kPxWZfb4cZgPkjduK6ptGv/ooLZ4SM0d?=
 =?us-ascii?Q?vVHcaTHRHGIilE1XLEdOkZPN74K3YK96u256wAL/kUx92+g30LfV1F7p/IsC?=
 =?us-ascii?Q?DDwwVbry+5uN2CpYyJjxw/vdPyjTLBCx+LKY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f765ac-fcaf-4c8a-d4ec-08da075d181b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 14:56:04.3083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PtCiCHAHoiNP7fhzWN8qDEMLwc1CiyKe0LyrzvsEON9t2oJ+hkNoIhBjQKt8y43GcseNYQjQ7YUdLcTxasXRaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4926
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

> > > > Actually I intentionally left that in the RFC patch, to only do thi=
s based
> off
> > > > of tb_acpi_may_tunnel_pcie, so I think that should still work as yo=
u
> > > described
> > > > if boot firmware turned off PCIe tunneling.
> > >
> > > Right but if the user still wants to disable it, like say you are
> > > travelling and you want to be sure that no PCIe devices get attached
> > > while your laptop is charging from a public "charging station" (whate=
ver
> > > is the right term).
> >
> > So wouldn't you flip the default in BIOS setup to disable PCIe tunnels =
then
> for
> > this use case?
>=20
> What if you are on Chromebook? Or something where this is not user
> configurable?
>=20
> > Otherwise with how it is today you end up with the PCIe tunnel created =
in
> the
> > boot FW and then coming into the OS if it's the same path the tunnel st=
ays
> > in place with no opportunity for userspace to authorize it, no?
>=20
> The boot FW does not need to support CM capabilites nor does it need to
> provide the ACPI _OSC.

Ah right - my thoughts were entirely UEFI firmware centric.  Chromebooks do=
n't
have BIOS setup, nor do they all have the USB4 _OSC.

Then yes I agree we do need to "keep" this authorization decision in usersp=
ace.
