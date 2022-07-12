Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB035721F2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbiGLRtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiGLRtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:49:50 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813FA3C171
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:49:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJVBMHn43VEj9yM8by4I1quQ3zF3+QzUtFot+nwRAxsvou4DjpOmmt27x/EWpYC8AkH1l5mmLGRs2Ng/2NJkBjdVoKa/JyJ30ht8Om5sVgPVChQlnS5onBkHYhjQTJq4rVQS8ravMQsa2JhOuQu1BISYCZfUx9oCbe/k5SFrKTf/7JFX+B3/acV8KYMDOTAm2IMsvIDA/Z54RXcLnL0ndD8DE+AmrAaqmeMDziZ4rvtAI4NOcUOSWHWfnp3ap4neZ/jIVkBgya6XKW8Hz6NUFXQv8k3dnwW4+ktuVEQLsYEu7XW0MumP34rEBXnDzrKuPjhSByyG3ZF4/tvzSVSQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5kRotsxn/HfVQq4MI9KH68764aBXuf/5acm8Dr9kIM=;
 b=hS57PX9hCJhufpY0/qgBhofT6jCw/8LOz6caKombUTDnp1wqx8umV5sgxAHQxXi0by6FEOMS0qKuFuT55+sApnlUSA+yB8QYmmIq1HwSXmC4hc13HT6bian9+CS8A36PdNO8c9OpBVB9WcN+ujomWvFw0BaP7f5xQcPW/GkYkxC6zUMT5GMRYDtDbpUoTGEATItmHOId/g+VvHQJnwT9ExcBNBOvJ2VDKxquwyHdTq/F7j5vOLVXeSu89SL064I+HJ2a+oB/jEcKkjLi3R65ZBWR2ovhJ6ciL9Iqhrkjex0FehyH3QoNulmW2j3UIyh/p7E7THgPCqfsilUSgoga1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5kRotsxn/HfVQq4MI9KH68764aBXuf/5acm8Dr9kIM=;
 b=tTmPsCKZjNxS92cG2Qb8Az1pgOy0hHlgBpmNvsfMWnRbkb1MCgnYIFs9JmuTYwgVGZOcuTdkhSrcWqr0xWO4cKmeqb8KsffD+UheMbytnOUW5UbrmhSUIL92vwCqnnNpPYaImzKaJv7EAjCUD1VhasExGI5/0QgsG7qDROMu+sE=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by DM5PR12MB1498.namprd12.prod.outlook.com (2603:10b6:4:f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.21; Tue, 12 Jul 2022 17:49:46 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a%9]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 17:49:46 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [REGRESSION] amd-pstate doesn't work since v5.18.11
Thread-Topic: [REGRESSION] amd-pstate doesn't work since v5.18.11
Thread-Index: AQHYlhZ+c9Aa2f/ahUWWW71UnOnBzK17AyTw
Date:   Tue, 12 Jul 2022 17:49:46 +0000
Message-ID: <DM4PR12MB527879122FE84DCD355C33B59C869@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <3559249.JlDtxWtqDm@natalenko.name>
In-Reply-To: <3559249.JlDtxWtqDm@natalenko.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-12T17:48:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0fbc798d-0dcf-4f29-a62a-600e025028ce;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-12T17:49:44Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 8e58bcc0-1bb6-4a6c-9fb5-3a4af6ecb8cf
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b141d56-3b4c-404d-3180-08da642ee8e7
x-ms-traffictypediagnostic: DM5PR12MB1498:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JznHg9h9pUsWQqjG5v2sLvCO8oRpOZyg6Xj2SxKq2qyxewf8TEMa/eRZVeiDdw/KDFyNXph/3Pi1FTl8Xmscsk3Wle9c1Cq70o73iAKy/me6rjtD9FhuHHPwXGy5Y/WW2VuJO5L//vx+KlbFsDDj3nLuK+MUx8ggekRGb5ApW+tkx98WVdRpxLigYbRtdenJD2R8dXchGXwUS/Xnv+kk9OLss4g0xFbWR7bYHfhowjn6Z5aNZlJhTt5VzvhvnPx+J/EKoWKMbaBJRdwQe3416bfYkkv4VL2eemIpp+QAHJcWN4aTl6dpqMs3WoRNFo0IP7YFkcBKhECwPs3VV74TFqG8eX0LtjuEV+g0gTppE1kRDinZDNp8zK2Xi6C3vSPDgIcv1UznK3CofDDx6RuxzANmSwXGS71Vff+7kSbJh8gXzAYl/MFlsdcrzsceKm/ThfVS+Z278989rsYoVbb+jwTOo1LkRHub4yWcZ92nWwymwJrXd+srxV4GW6MNrin8NQQd4O6UjZjjUzwAZkcd4Epvkgvrt5HzWn9S76HEPNgxNlktJmBTDSLtvLDwk/sa2vHqGb4Wi9IeOsGgmhAhdLJahXwNz2TnZlTl2RDDKoxL2SAwdlxUY4JJQoeKRfqBggWGGvCKRrQZxmyG8IhESjzOZrZbdvIVKUbBQgTDS1W3hTTwqkv9nbwMS6ftUghqgrcTnOu3YCKQlbtXXNlMua91/6GvyzrOOmESjLyw/LddnGT15oIgtJ6HjRQlWvKVickI04JVbVDyMGOwrEK/BZxACDqVRod8VRoxohZmIPvKA/V4F7OafF/7j0PJzKQF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(478600001)(71200400001)(54906003)(2906002)(83380400001)(66476007)(66946007)(110136005)(4326008)(41300700001)(66446008)(8936002)(76116006)(52536014)(5660300002)(64756008)(8676002)(66556008)(33656002)(9686003)(26005)(122000001)(186003)(316002)(53546011)(38070700005)(86362001)(7696005)(6506007)(38100700002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gcLEH0K8CdvYieWdwwyuWx4Kpbhkvmmsoxs0OL9MPUuE/8mcRvGX7KC3Cjhc?=
 =?us-ascii?Q?02R6mW7nNdB3XIobTzzu2o/KFYtM28i5bB+CIrMLpaskf7Ps0yxnfUty5zFD?=
 =?us-ascii?Q?72X2Ywfrd0fHcA8bHiVEPBIDNpVIQIptAbLb9CaLM3cMg9zODit+YDZZYLok?=
 =?us-ascii?Q?Ct1ivVVCCss2XNiRF6wCJnx4BKIEZDE5W7/p2te5GVRnyRJIcWKEXxrLSp+r?=
 =?us-ascii?Q?BnXjd/HqmYVUuHc3f9vovbcw5pw/iLAYz51wQXPXErr0nPwtRdU8FX0I+DPy?=
 =?us-ascii?Q?RQkzet32XTVzqkJ3zwljG5N+umtBPJI9/EM1TAl7j3TrFO7dVKNoyPsjPq0g?=
 =?us-ascii?Q?CFhHX3M3XB4fjawBwyGfUqGqeLrV3X9HAmiViLFNrYF7TfDMGYXjyBAm5CWc?=
 =?us-ascii?Q?v1wtU/s622uhD9tsbCJxKIf8wDUo3qc/fIVIrgmhDUZKUfdbe6pXpad+H7YJ?=
 =?us-ascii?Q?Vz2Nlp2LHuByF50ecTtM/V0VlBePVVvvE3PeSF8tIHRic5mcr/c6t/e9xsU+?=
 =?us-ascii?Q?kR1c3WSaGx9qGu0SU2XGXtlemQZJoYB0iytLgz+z7BNNKAsWz8mzL3puN9yb?=
 =?us-ascii?Q?NWAzzrhoG0fn/AvKgr7JN6W1U2vxiTeiQbGodjWHE2C0Uq/HG3rpqwDaqHVx?=
 =?us-ascii?Q?AiL6kPsM1MEaK6eKEP0vJBdxgKu93zB2qqncwbmIiilSEb29icqHERAzqq+D?=
 =?us-ascii?Q?qsoZdxw9zdOdd4l8i6d8gjZfDMG+feSluXKdGkP2tJY/HeinXQwkarTJ4jQs?=
 =?us-ascii?Q?82FFMpXcvLCAwbfuInc+jdo8VjGdMJFH6fdI03rZp4GiFuyR2l41/weMlHGx?=
 =?us-ascii?Q?n+GL0oRJ4S1g4bJpbtLIYRcm161/hc/zgrXRKpqNUPs2ynQKqdTnDVxYofST?=
 =?us-ascii?Q?9WVclz0rRCT8R8Tke1O8f0ryDN9zUv3FeQjZ7wT1vfy/57HL2H50edpkkNdZ?=
 =?us-ascii?Q?sDWkXz4I09k2SsHYHTzBQxFDUqN7KsPuGkbrFfHP8Ue7SpVF9AOeoBtUo7f/?=
 =?us-ascii?Q?DnR5GnQLSZ6ZG1L+TuIgqIBBVFs8UtZzHSt7/P3EL3wKr9HFDX6iYu0zpuK1?=
 =?us-ascii?Q?SvtnoE/XoN4lodgCpfsIeIvM/85zOjFx4G81hpAntulsVxMIMh2/51o0sglO?=
 =?us-ascii?Q?r+hReH+x1sKqeBV6KmVPBSoFfU0Up3eZ9H7MmIBmpSLVsNz1f8NhjG7nhZYf?=
 =?us-ascii?Q?huRbuN3k/tt4zHgPpuy2qdxtXvPAyrQiFbkX903L4me0+2tqlCzQjeVloGRm?=
 =?us-ascii?Q?FEezjGI/piWCSo/Rhr31nEqu4AMEtDroNrcYrtP9IBTIgBczlpWPON62+EfK?=
 =?us-ascii?Q?wFT//LYYRP2Hj708q/0lTjPfpgUkecgBEhZIOm3cgxdKcQcDd2QWK/YGRoou?=
 =?us-ascii?Q?3zTwUvI2pWHzge1QpU/5/jnekvVnizBlw3K1By45U3qKGJLrkCRels0E0p1I?=
 =?us-ascii?Q?gQRFIODikqvh/qyh9TVmbzQJ0QqaxkpudG4zdgWG686Zd0l1LfY0OJyQuIak?=
 =?us-ascii?Q?zcazIdJsLoqVmCaYS8OVHyxiCAzzD8KanvC7RPtkt7ideb7Mc/WFVyo0ssFC?=
 =?us-ascii?Q?Ku5EBDaFqhWvAopblkI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b141d56-3b4c-404d-3180-08da642ee8e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 17:49:46.4460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/2qDks67PIL6vy54xHPffsUADm7JvBPqEwhDz20hdBsZtm2w3YS9D3KrcdIgTlthXoN2Wfb/miGdF7xX8sKfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1498
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi Oleksandr:

> -----Original Message-----
> From: Oleksandr Natalenko <oleksandr@natalenko.name>
> Sent: Wednesday, July 13, 2022 1:40 AM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; linux-
> kernel@vger.kernel.org
> Cc: Yuan, Perry <Perry.Yuan@amd.com>; Rafael J. Wysocki
> <rafael.j.wysocki@intel.com>; Sasha Levin <sashal@kernel.org>;
> x86@kernel.org; H. Peter Anvin <hpa@zytor.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>
> Subject: [REGRESSION] amd-pstate doesn't work since v5.18.11
>=20
> [CAUTION: External Email]
>=20
> Hello Mario.
>=20
> The following commits were pulled into v5.18.11:
>=20
> ```
> $ git log --oneline --no-merges v5.18.10..v5.18.11 | grep ACPI
> 2783414e6ef7 ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is
> supported
> 3068cfeca3b5 ACPI: CPPC: Only probe for _CPC if CPPC v2 is acked
> 8beb71759cc8 ACPI: bus: Set CPPC _OSC bits for all and when CPPC_LIB is
> supported
> 13bb696dd2f3 ACPI: CPPC: Check _OSC for flexible address space ```
>=20
> and now this happens:
>=20
> ```
> $ sudo modprobe amd-pstate shared_mem=3D1
> modprobe: ERROR: could not insert 'amd_pstate': No such device ```
>=20
> With v5.18.10 this worked just fine.
>=20
> In your upstream commit 8b356e536e69f3a4d6778ae9f0858a1beadabb1f
> you write:
>=20
> ```
> If there is additional breakage on the shared memory designs also missing
> this _OSC, additional follow up changes may be needed.
> ```
>=20
> So the question is what else should be pulled into the stable tree to
> unbreak amd-pstate?
>=20
> Thanks.
>=20
> --
> Oleksandr Natalenko (post-factum)
>=20

Could you share the lscpu output ?

Perry.
