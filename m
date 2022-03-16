Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0C64DB1D9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353788AbiCPNuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241553AbiCPNuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:50:08 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C51764BD9;
        Wed, 16 Mar 2022 06:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9CJyCbIq4O5PcKBUl/eCHOylIH6Zmjo8T603B0kS+4JsPKSsK/zfMAxYgsTKk7+8ouEUWeGvnxjdCoYZ7AadbsNV2MFy4pwG4+k5iCyJ7bl/RoV10zyonXkiEBwwnktMeALZozdyvyT2CP1OInQc2+gFNOt9lQtcuUAK5eXTMwpO7Kr8kgrDCO/EX8Uo6LpXHXY30mlLO7Bt4X886MbgEdaQvPgobte0qtMiD34sJycIwPqjLEG0l+5APi2msDAgDGMFnPz196Q0id/hv8oe2qropABir/+KLScIwpk6TAXGBYfQoAKommEBU9hYmQ2XjBNWga2wIkj3+sgpUBADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJP9okQGk6+7N/4+n+4y+I8X0ycltiM7u20zGHuoCzY=;
 b=ckXnYmFJN+VTY037anzqcTdZvWRfZHhTQH9FmbBS0UpMDeUEbZMGvDuUXFn51JZlnj6uqx8bhvG4lGBkO6cORvDW3RCzVYjn9FxRUo/LAWhP/3miRdyiMkioFznT2pG27fQOArDct4lD/RbpOkyrWyT1yEwNvmWtspXW1i9WKuSnjKRD2yOigZtHSq8/JbvJ/iIjCA22F/bYbSDg0xQbHW0h3WBSxQhSe2GmdZyj2N5IqnRUWGQf9iefwZ0Xza6kfGREnu1iQoPmZNq1iWHmq2YtEdQvg31RcOFmnUk/dS2s/HzQDRmpaZM8R3CTtvP5WRh9vklnHDB6ZQczM5JZzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJP9okQGk6+7N/4+n+4y+I8X0ycltiM7u20zGHuoCzY=;
 b=u5PSBC2THRkuxE/1c0zyr+3wQgnDCP5YJ05wgd2CyqWg7hqr5hdccXUFU66BMhCEiTw1DPOo8WjRtVogKySZa7ODHkmV6jXJ9cDAslFq4ROzmn7NhwZDx8CUtxIpFiMsftSIBNJR39wCbo2h43MsfhxZslsnj1ow06G8qDhzYlA=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by CY4PR12MB1462.namprd12.prod.outlook.com (2603:10b6:910:8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Wed, 16 Mar
 2022 13:48:49 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 13:48:49 +0000
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
Thread-Index: AQHYOLPjSg5nd+aU5Ue+Y6z60pVXs6zBjSMAgABuJbCAAAqaAIAAAHtw
Date:   Wed, 16 Mar 2022 13:48:49 +0000
Message-ID: <BL1PR12MB5157719E9A5C0EEBB652141BE2119@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220315213008.5357-1-mario.limonciello@amd.com>
 <YjGD7N++F+ioISHb@lahna>
 <BL1PR12MB5157349C626E3818B813D9A0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjHpNloXEvPpv1In@lahna>
In-Reply-To: <YjHpNloXEvPpv1In@lahna>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-16T13:44:02Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=3ebea438-4fd4-47b1-bdc3-59a07f186f95;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-16T13:48:48Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 640775f1-eb78-450f-b8d5-3e5db2933141
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23b6d510-3f68-4465-1b1a-08da0753b33d
x-ms-traffictypediagnostic: CY4PR12MB1462:EE_
x-microsoft-antispam-prvs: <CY4PR12MB14626E5900B0B725D152DBE5E2119@CY4PR12MB1462.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ts/qVHs5VUNhZtnRvAISdlByF78xr1QlUAB5RQxrXubaEnkZsIa4OowmWXJFm3Kza7C9rwY+j12+76awLpYlzRlS+gG9TOxXQwGrZjWbTdWlW/3vP4p27SPfQgOho1B082TfDEV5IA7UtBosBcnOMHp7etIBamgUxmkz7QOx+gADDKwOMFfk+4H52FHRoA2UTB0rw0231fR5cMRbc8fnb5kv7tKd9Q5lbwcjKKUwGULPsPy9dElc0xCILp7Ugk3oFL3ZmVCDKYpKhEglfChR0k3iYTCQnuTB53HPgyZIpqgG/IRJBQydhjM8tgiSGfKwaYU6CATsWaO/o1bGs+CVBUKxEmvjKwVz30vqO8gnPwYP/gOCKyyAYQN43x9wpweceNxVbnMCNJ3cbn1Vf9SuZJhyaxOJ6FLWjhoPio5DyO0uJm79ZEf/Ma1QzXPaSSBo0FQA7h++EvFleJkVjZqYoRIyCsR96AuvpVJ6ihwF5W+s+H/FPiVbSs2fO+80iT9xXyyVgWXbKOroE0kg2fdkuv8I+k/TTFsojRBQ9mzV8RA+NqizoEoXgMY8nVBrsNkb9pcAKU251mBclvGIAOQs1fF0go6IIgJsayUkPxH7ddw9P3eHQMguu0TDLjOv94IGFqhNR5caei85cucubTE+lD7KCJ2x4eg2lYOFrkB/9HVnDqH947A+ypqJrTsP7wA7fIvFKKBmtmsRfnQAzaJ/NA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(186003)(122000001)(38070700005)(2906002)(7696005)(86362001)(6506007)(38100700002)(9686003)(508600001)(316002)(8676002)(5660300002)(64756008)(66946007)(76116006)(66556008)(4326008)(66476007)(66446008)(8936002)(52536014)(55016003)(83380400001)(54906003)(33656002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OdIEpzi3KtCcs3+rOHAyxmIgpVUYy941O0Wws/LgN0Ryg+TKvqqTfZxoGN59?=
 =?us-ascii?Q?V8Y6NNhKducegN/pWaGt71khiZ8/kQiYyzbbXyWthqa1sx5bOtReOCl8cnIl?=
 =?us-ascii?Q?Gg6ch1FrTM8DOXr+PKYbSjo2a6fcOVkgux9qkduG2xni25QPiyYUAMYDiIQW?=
 =?us-ascii?Q?WZboXaW7tLQOKCiwGzaiVYp/upUx7Kwx3qTdcWglqX0LposSkOvtC3uCQgz7?=
 =?us-ascii?Q?pWDbHb/Lifd2SHyV6gd9fHS4GSHl/HKjjUMjiUAY1cE15rby5w6SqgSHfTJ9?=
 =?us-ascii?Q?3Ca55kkRHnxv++2IZOZ3vmrDSlI/AouLIouvnyU0R/vQl8p1uleko2jZxkUZ?=
 =?us-ascii?Q?kgdBoArcAB+izhVilIdfChZyCPIc2psJzDhR7gKfjkFQNVF4pbo9/sor8Nq4?=
 =?us-ascii?Q?O/yecIGNiO2aSL0RIjV4yy5C8i7InhEUU52caEpHDQ8/HU8mcTmKSxY8auOs?=
 =?us-ascii?Q?ar0apL27nxzdwl80MqivnwW4bnb6LmUnQYamBF4p4ZqckRAKPmSed9eQ2w1u?=
 =?us-ascii?Q?ouohfC9ukAy65EihW+yD8VvMCjmNgfCgcWO6KZ5F8WCYCnCdb80wdnuKmvSt?=
 =?us-ascii?Q?GrpR6dUMDo18wDpFbbPmMQ2XG+fk8w2LjM7xXPuFilR0tpxlbkBMNxL9+cTo?=
 =?us-ascii?Q?c6EmjwgT+n1678WpawaSg0uyDoFU93wIoqjypmYDZgKiBtgHYneCe7sK+D9T?=
 =?us-ascii?Q?Z5Yf6X3vIeluLi5jcQhcBDHMDOzMlObbTfwzirasJkpxkTGilJCJob1HOaTH?=
 =?us-ascii?Q?Dnqo0VNYizZseNVbjH2yhw0FHfDI9SQ9jMvoCX3ty7ICqEsqE3L+K9L7nyrq?=
 =?us-ascii?Q?kdVjROYHazScUjTLqgSA3bvze8J7vcLGUVX1niBUobaWfD9d4u+5qGH0BCMP?=
 =?us-ascii?Q?gx6OIEJY9G05NotgAbu23JK9nhApqfLyZLFM7vNxijkSequR3xN+lg08h9pX?=
 =?us-ascii?Q?O7s9OCXtLG17M8nMr3hRZGfDEx1D72/k0c39Ef3oGCbSLrvWGhQl0k/ocQAS?=
 =?us-ascii?Q?LQQZeF3frfptWkwb3UXlZHWyalV3hHTGHJ6WXtbaWAdNc8RYTjflp/oWFR4U?=
 =?us-ascii?Q?K7juemXt7j+K2C+phbczQ1DRArLZ0Y2FsrKRmFY5co5tX8QpVo7DM+E+axFA?=
 =?us-ascii?Q?DWNg97wDJkdtDqC92s3HwX+HntcMqC0zb+Y89ivWULmGY0OyFX0hpjQQuQ0o?=
 =?us-ascii?Q?Gjr6vF7obKbdaqZ/6ok+vhu65iSTx3oqm05tmHAv6XghTi+SYua7xy6Cnvuy?=
 =?us-ascii?Q?vkx6tAgvfbdlfXldETrFxaaIRGyzCWycS+R8uIl/g58q9CJ59ZMtPLN8LKDB?=
 =?us-ascii?Q?82EIavC5nfwhIcSZwMtIF0heIYj3W5SWcPB39QhAp1YY/1EVJ1AZIChjrGQG?=
 =?us-ascii?Q?Z/2lDYRk8/Bm5LfClf6ZymoIK+K8kes59rCziR1i4GVNP5KspCjqyoV5TmBS?=
 =?us-ascii?Q?tqVhVt2O6hUNkSdGVUNuuJKESCitAj3N1nuXhVF+GNMXtgqsSh/A1MP6CSgU?=
 =?us-ascii?Q?eU7XviE5ZjFEpe/8L/f3OfHlEX6pRZdgX53p?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b6d510-3f68-4465-1b1a-08da0753b33d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 13:48:49.6215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RikOKgN7c6EPTv+MNhyBf5gykfxV/MjGZn158x4/kSB6CYTlCRR1KD3j7H6MH8OPvWLPs5RIdD1eungeQzo6Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1462
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

> > > IOMMU is active
> > >
> > > Hi Mario,
> > >
> > > On Tue, Mar 15, 2022 at 04:30:08PM -0500, Mario Limonciello wrote:
> > > > Historically TBT3 in Linux used "Thunderbolt security levels" as a =
primary
> > > > means of "security" against DMA attacks. This mean that users would
> need
> > > to
> > > > ack any device plugged in via userspace.  In ~2018 machines started=
 to
> use
> > > > the IOMMU for protection, but instead of dropping security levels a
> > > > convoluted flow was introduced:
> > > > * User hotplugs device
> > > > * Driver discovers supported tunnels
> > > > * Driver emits a uevent to userspace that a PCIe tunnel is present
> > > > * Userspace reads 'iommu_dma_protection' attribute (which currently
> > > >   indicates an Intel IOMMU is present and was enabled pre-boot not
> that
> > > >   it's active "now")
> > > > * Based on that value userspace then authorizes automatically or
> prompts
> > > >   the user like how security level based support worked.
> > >
> > > There are legitimate reasons to disable PCIe tunneling even if the
> IOMMU
> > > bits are in place. The ACPI _OSC allows the boot firmware to do so an=
d
> > > our "security levels" allows the userspace policy to do the same. I
> > > would not like to change that unless absolutely necessary.
> >
> > Actually I intentionally left that in the RFC patch, to only do this ba=
sed off
> > of tb_acpi_may_tunnel_pcie, so I think that should still work as you
> described
> > if boot firmware turned off PCIe tunneling.
>=20
> Right but if the user still wants to disable it, like say you are
> travelling and you want to be sure that no PCIe devices get attached
> while your laptop is charging from a public "charging station" (whatever
> is the right term).

So wouldn't you flip the default in BIOS setup to disable PCIe tunnels then=
 for
this use case?

Otherwise with how it is today you end up with the PCIe tunnel created in t=
he
boot FW and then coming into the OS if it's the same path the tunnel stays
in place with no opportunity for userspace to authorize it, no?
