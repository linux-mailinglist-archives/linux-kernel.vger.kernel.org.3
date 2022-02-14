Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6CF4B559B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356095AbiBNQII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:08:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbiBNQID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:08:03 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7899488B6;
        Mon, 14 Feb 2022 08:07:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aE1qIP3XwBfZqZBfhwTAniSXHsfM/gMiKfej0gUSsaMikkuz5THb+hNLQu1eKY5/mLJZiMyGJi4BnUdL0oqmXii4TzPDOhjDkx6lbwOeHa7XclkitE4p0e3sAGLzrqB9I83/+ELeSUx7jNg0otBKzJBshgzsaKjnb56hbL+ryuLJ6sq/oKo2OxcLGpGRnXhCDY+F36u1Z9u6DNmj2bDSBQClzY3yc5cP/h3R/uRSzz6RglSgPmpUoabXLiliCgYuly9MEwSfHYPZkuuuc4OlVYeFHCFJsIWRjlj6fGyZXGYLijqT1CLIFvm1z8+GRBMnzkwaJhjtxeKPJIB1QLFFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIInaxX2kQFH5ciJTCWxLqeU9U6GgwaGiuNSDKJRm+A=;
 b=ObK+qbZVy8bmTDppo1ugF2ZrgJYHZpPQm9KmzvPzYiK8YS75IgGYgBE7Mc3ryUVC7FreryUqjObpLrKraj+VtHkI6J3B3vQw4CSd0bRP6YhyutzL5/dXRhU3m1JwFIBQ5TrvjkFzrcbiSl15Yhd+GpP4UrW8EPBXOLp++pmHLdPUMZPJF8as25FWZbY5FSxR5KeShEUgKNVMxZyqoM2NqSUhoK2o2V12aehNOJL+XWF5iEsKkikwt3Hn4n96VTowcoT6fu/JnhZY3Xm8Jcj8qtFb3pYituVA/OmviEVELsW8jk6k2QzjqGY/oe9ulJdBkmlX3DaOfyLB05ZxpuxbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIInaxX2kQFH5ciJTCWxLqeU9U6GgwaGiuNSDKJRm+A=;
 b=XqkE4gZyZLF2uWwRMTht4TDfDEaHSMDcbRRqDhCj+1G5Lkme8K5IRDF1azp6Yg0JvS0B+RklfsNTRf40DrlLdMu5F/8daLuNRV/6QkCPdaOqCpX4XUkpEDXAm52nHS2ZopffVfpFRdlOGG+gClgY2S8KuU5FGsq41xxPpeIAvpU=
Received: from DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) by
 DM5PR12MB1788.namprd12.prod.outlook.com (2603:10b6:3:109::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.19; Mon, 14 Feb 2022 16:07:51 +0000
Received: from DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::4427:2fab:1991:72ad]) by DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::4427:2fab:1991:72ad%6]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 16:07:51 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Hans de Goede <hdegoede@redhat.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Subject: RE: [PATCH 1/2] ahci: Add Green Sardine vendor ID as
 board_ahci_mobile
Thread-Topic: [PATCH 1/2] ahci: Add Green Sardine vendor ID as
 board_ahci_mobile
Thread-Index: AQHX2AIWUB8sRdXHGUKGY59jB++EwayTQ9mAgACC60A=
Date:   Mon, 14 Feb 2022 16:07:51 +0000
Message-ID: <DM4PR12MB516853204C9D7E7EAAFBC91FE2339@DM4PR12MB5168.namprd12.prod.outlook.com>
References: <20211112201539.17377-1-mario.limonciello@amd.com>
 <960946b8-8f73-9f81-735a-64e5cc555a9c@molgen.mpg.de>
In-Reply-To: <960946b8-8f73-9f81-735a-64e5cc555a9c@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-14T16:07:49Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=413463d3-5274-45ee-9e6c-5259627e0424;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-14T16:07:50Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 16f62534-6f9e-46a3-ab06-da6fe8a857ee
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc452fc7-e056-4fa2-7a46-08d9efd4272c
x-ms-traffictypediagnostic: DM5PR12MB1788:EE_
x-microsoft-antispam-prvs: <DM5PR12MB17888760A1BF463BC9A3E512E2339@DM5PR12MB1788.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yEUfX/nOxoipy9DoyLCAKs90iV8ti5oNpX/9LY39XfiRW8bzGvh6IkGc8mx9kyYHzUYn2aHZWFXuulqbhOFGsODsXYoLRfgBoiaTpC5Otu6etYiaV/4hcDwA+w8fl+q07JXMrBRu/F9i5+R9DeQBFXKByuuJ3jWciA3IzzXaym2CyOwleIPH3IMV6aJaUQwdSPsNYGqTMtPXfhv/vUDPENeEWIckUPobZTGUS4bp7y97kLtJD9B9rz+hToU71IwqbQ5st0iOBmMjAeKB1hKKgjIxoMglNm9u/IBK8pxbWX7394L1S7gjlfilKMGNSwmBOWVcbQlLO3frYlVkgmI2oGklmneP7CW9Yk3fTOY4M2yRIEkq1sk1yZHjuPamFGBSne6o+v7gbyIuVYlxm/vlct9XCCPAprSgNIFohewdYO8e9bwKAZO7jpuEWO3gvraEoOmbtmF7PnaQns0hTQthmUALvneJnToxZCW5BEK3nY5c24529BRC9kBz9ctXDlDcbJ5FEE6LWC71+LyYJlBbt++YPQRbOmm9PIDM/SVoIufRzjhzH3P/bwzqjEfGmwvBnp0V5nKf4Pky4ClVDOVam/ODg5sERNQynSKKB9WnDyXQaLcGWZdEH6Ki3KQlG4FS64MnUuVVFLVY550nVhaVAf9b01/i6Vwevk10twp/en+ku3oLU7seekuJnCbH5/tHInl2uocDnkfLoluA6uY8jr5IvpID0RWwH8Iy4C/WIwpCsHAwNDL+NDNXzprdeSbxT/9eM8vW1xogjL/kjwUOmAMEZtV6NQ6AGlOyeeIQ+bHcQMJTG4p/N8YIcN2R8aU+42osEq+5Y2nM95vH8jylnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5168.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38070700005)(122000001)(38100700002)(966005)(45080400002)(52536014)(508600001)(5660300002)(8676002)(4326008)(76116006)(66946007)(66446008)(66556008)(66476007)(64756008)(54906003)(110136005)(316002)(83380400001)(9686003)(7696005)(6506007)(186003)(71200400001)(86362001)(55016003)(8936002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fCQTKxqHDcWgivMQzYihjf+r6aF7RNvlw5ENt7mqNTAbyzoX/kZ4cCdnrOfk?=
 =?us-ascii?Q?WENxz6jgDvrrwWgjY9gB8jmZU6GKBG+G5M+TGw7soFonG+HE3lyAhV8a2rJ9?=
 =?us-ascii?Q?BqLPUUW+R3D1WeJp5daeTDNARqPUlJSs7vbE5oB9DXnboSZ5+E9vC/AqVFul?=
 =?us-ascii?Q?4Q8xd/OqHt5BBjDPivVKE2PziZuzXNnQp8OjC5JUL1h44ng0sSaQQrk17I43?=
 =?us-ascii?Q?kA7cq/ud93qBPu0xZ7e3HaF/WNG4wY2Z+2Mg2+qaE4+4VNBrZjNr+CNOl42l?=
 =?us-ascii?Q?4xFbSaXGdtEUCx2DXrGlkes7J6sb0GEnMCY1EbINI2vAkI2WUxx9qU3XDuLE?=
 =?us-ascii?Q?cnlM/RVP+i8M993Og+G2gqEQA3gBs99sKpoIMF6+8FGAV/uiGETV9zTD/bnV?=
 =?us-ascii?Q?vAd998VaKkQ+sr7/U4mH9IZAY+J0iAirDT8AtM1CBiuNYIN87X1T0R2o80bc?=
 =?us-ascii?Q?HuL6D0j29lpz8DEcinyVXO9lqsCthsnTfdBAIphYSGSxamq9p7aCivg7fSYs?=
 =?us-ascii?Q?nZjuRDn9syoh5/p2lfGeL+tAqOBQkvA+9LdcL60ou5PU4dH90sb0HCVVw/FE?=
 =?us-ascii?Q?A6H1vbL+mW/DPFdTlxS7IJKdhV3ilLeIcxyabVwzCKbRoYd7ATN1YRm62PRz?=
 =?us-ascii?Q?TeuPuB3kHbwBN5vhjGGJGPo05WCkkHL1OLDNThcT2q7Uy+dZEv6/v0ymJawg?=
 =?us-ascii?Q?ZIiPLr5bluL0tjvtD/THTZDIMThMTKH/6VcS1i1V7n0I43hwcREE3lov66xq?=
 =?us-ascii?Q?Mdv4yVu5czHqEGx1bltX+F78KcU0YLE1DpUzh0godhD/Zz2jkU/yPYO6JWfK?=
 =?us-ascii?Q?CD7GWIUWAe82hijvJQx/DHYn24oy1npx01Nssv6RUc7CQygQIkwROkMVAi7C?=
 =?us-ascii?Q?AkO/+K41BwlljVdIvitoUdj1hLuz0o7/8cC8zLXl/aIU2XCvuxobVXbO4SIY?=
 =?us-ascii?Q?JrU6Q0umhCP4DML6HmnfJlcPUYM1TnTZ03+BB6KETVKXlXahve/ER0mT0Ec6?=
 =?us-ascii?Q?VX/FaV0V+F3A2XMCpxewUKK/yEnPrkSalw1xlJylB144LodRODSDRZA0QL6i?=
 =?us-ascii?Q?GeH3+xApVurge3avLTS0k44ENUg6Z4Gy9h9w0ejtxf4htVcWq/TH4KJ6DyWC?=
 =?us-ascii?Q?KnMADHM5LnCCUSNyzbicyMtZUR8lyYZCZ2aA/7EVGqsBPZ0EwS1fNYSN3V3J?=
 =?us-ascii?Q?luGE0KvM9+dZclAdmke2+oHkpHb9JjXnH5BRmV24tFtoL82WooFCEnGLkwov?=
 =?us-ascii?Q?iVz/XV5WV+IeONK0JvaJvBnGNTJSQVDzTUfA3GaYrxo2yIvYMJ0kK1okp9Py?=
 =?us-ascii?Q?BRUWXlBHJs6cNuTngIoolZCbdG9jScUY6DV8rb0vU8DjTGWq2TwB2HY9/YBD?=
 =?us-ascii?Q?j8dzl+2AuaY3f2N+wW5VOAN6P4faO2nH4FwtblCvsdUb7CJSGCncFKen5MO+?=
 =?us-ascii?Q?/zwSSQWWZJe3U7ya9sEoIJxq16CqLwsHFzm/rKkqLCpFAfI5Z9o5ek8yjei5?=
 =?us-ascii?Q?Z+UecuAnVzdeM/kOzOP0XkoBLYfyjND2uIpKlWWdJb4WDzjuykv04QxEYZvS?=
 =?us-ascii?Q?Ma58V1X26cL3LfNtLNgVgoLdrPRXXMVulYjHJDBDrDHVr+GTkebz19qAALzu?=
 =?us-ascii?Q?sI8bnR3Wda6plo6P7eG41RPq2qcL+K+22/iqaxbvrr93aFh3m8Qo7HSzBUsC?=
 =?us-ascii?Q?P1vf8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5168.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc452fc7-e056-4fa2-7a46-08d9efd4272c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 16:07:51.7861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /aCdjuDOYatTKjEWIL7mJb28Q9ut89uvVIstC1V8X/aItLCy6+NzMqgBvPXV0uCiu/UjG+FHsery3tB/oWHFIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1788
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

+Hans

> (For the records, is part of Linux since 5.16-rc2 (commit 1527f69204fe).)
>=20
> Am 12.11.21 um 21:15 schrieb Mario Limonciello:
> > AMD requires that the SATA controller be configured for devsleep in ord=
er
> > for S0i3 entry to work properly.
> >
> > commit b1a9585cc396 ("ata: ahci: Enable DEVSLP by default on x86 with
> > SLP_S0") sets up a kernel policy to enable devsleep on Intel mobile
> > platforms that are using s0ix.  Add the PCI ID for the SATA controller =
in
> > Green Sardine platforms to extend this policy by default for AMD based
> > systems using s0i3 as well.
> >
> > Cc: Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
> > BugLink:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D214091&amp;data=3D04%7C01%7Cm
> ario.limonciello%40amd.com%7Ca32a202d437544cd2cbb08d9ef9112c0%7C3d
> d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637804228648002522%7CU
> nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DCbfImBnwc8uV1L5QRBuV
> PLkP72wpS9yif1UbUwykhNI%3D&amp;reserved=3D0
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >   drivers/ata/ahci.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > index d60f34718b5d..1e1167e725a4 100644
> > --- a/drivers/ata/ahci.c
> > +++ b/drivers/ata/ahci.c
> > @@ -438,6 +438,7 @@ static const struct pci_device_id ahci_pci_tbl[] =
=3D {
> >   	/* AMD */
> >   	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
> >   	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
> > +	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green
> Sardine */
>=20
> Aren't 0x7900 and 0x7901 the same device only in different modes? I
> wonder, why different boards and different comments are used.

No they aren't the same device in different modes.

Reference:
https://www.amd.com/en/support/tech-docs/processor-programming-reference-pp=
r-for-amd-family-19h-model-51h-revision-a1
Page 33 has a table.

>=20
> Additionally, the device 0x7901 is also present in desktop systems like
> Dell OptiPlex 5055 and MSI B350 MORTAR. Is `board_ahci_mobile` the right
> board then? Or should the flag `AHCI_HFLAG_IS_MOBILE` be renamed to
> avoid confusion?

Are you having a problem or just want clarity in the enum definition?

This was introduced by Hans in commit ebb82e3c79d2a to set LPM policy prope=
rly
for a number of mobile devices.

My opinion here is that the policy being for "mobile" devices only is short=
 sighted as power
consumption policy on desktops is also relevant as OEMs ship desktops that =
need to meet
various power regulations for those too.

So I would be in the camp for renaming the flags.

>=20
> >   	/* AMD is using RAID class only for ahci controllers */
> >   	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> >   	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
>=20
>=20
> Kind regards,
>=20
> Paul
