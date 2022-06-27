Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2284D55C9E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbiF0R0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbiF0R0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:26:07 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B2112AB7;
        Mon, 27 Jun 2022 10:26:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7btgqAWSNK4/CRy6Kribejo+QGW3stniVPHDawLlxKJc3BEZQuzV5HCWK3zKcsZ5ytMKEYg9N1f4UUySkfA21BLUq6nbrM7H0iZCudKJTgsLjz+xLEQOn0uZzbzDWhiBrVytJRtAzB0E497kJjjvQlvDaIVy+46aHOorQrJgPSpU3ZjAQ3tLAt/d++RjROH1jdgS6TNAA1f+adDZmEM39kF919gHyTUWt8LVA4Tyuj9injwzeRC1jbbVc8nTofehslENIFISTeAh5BDDXUsiOqZzsTweCSSrzEOVaK8AGmiNH7qZuV4dGu7mabHz5Lh5WRLhfYkId4HcuMdTuSHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56Pe/4kZ3SDtU7CW/dA378Fw5byCVUv5HUncBtXzODI=;
 b=B3zeINwVfAF4KC/oUJ2q0Kx36o82gwb/h6SO7LMRuYVrn64G5zT9rXJuZrkjfbny/7EKFs5QfX8+nTZtLtJuZoz0XbmiVTMT/WoCMfwklUDzdrEA4xDf0S/Pel1/eN4JEajjjHpcD/C5MkBlVm2oHoZd8HWCl7ZGKe7cVYTYpU6oVy5/41hD8O2pY0y+2kp7aFsV4hOBDXjSPJ2T828h/JodRqjqAC9EEPxkQAunDMjb5rNuBYOz+CYUDS2Zs65nvp4RpfsC5LiDAgCq1jsUcqdTiZs6a42RLkJgPcJsF/4hiYFk47/ko7AuWNsrrZ1iNEZ7BcvQaf+wwlnrC5pHUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56Pe/4kZ3SDtU7CW/dA378Fw5byCVUv5HUncBtXzODI=;
 b=0oB4WA1kSUVPsA/pgEPwkE3bjklNvd/nVgbMPbb2kTStd9afXd/kMGks/G4mkJngu+A3OQCBqyY31xdauhBZ3Hlw3+fPCN4Wjrm7ghJeeSwlXgnzUWiCIeLsU9TKksBsZf3LocN2L5DPpXuFhVPkH1QU/G1W+6AQE2w2AmBI2NQ=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.17; Mon, 27 Jun 2022 17:26:00 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a%9]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 17:26:00 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is
 supported
Thread-Topic: [PATCH] ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is
 supported
Thread-Index: AQHYikckRQ4hNZM7+UeBROIIx6ccca1jgAow
Date:   Mon, 27 Jun 2022 17:26:00 +0000
Message-ID: <DM4PR12MB52786707F51B48C7559115799CB99@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20220627165832.10246-1-mario.limonciello@amd.com>
In-Reply-To: <20220627165832.10246-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-27T17:25:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=43e9afc6-0581-4aa8-a03c-b625b1263a07;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-27T17:25:57Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 29afbf4d-40e6-4a8f-8917-6517e88beea8
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79096230-9066-43a5-f2c4-08da58621a74
x-ms-traffictypediagnostic: DM4PR12MB6232:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SRpf5z8/nUXDx0hX8KrmurMFGsLS+V6hGoMxCaD9ksV8FWSPWm3m1xdoYN+3UH+Pwl+W8UN+FhxuZw8dT/1xPdAVV6Up2ZSaN/IaPQfs1vBpZDBlCjkcU7LmOycPksUs/k+BpN1ze7YxK2JZnYtfuI0vdjcDsPe/t0lSjhn8bQ1BZQ47d3TlZUdb+b1xLlTylsjNQOH6cI+vuL3UW/HVRV9DVOZk6X/DnpbtQAMbjDfXS93fU7XMbX6Pt+2IJQInPTYRMePobxnJM+PJngmVWFuZiT/quaQWKy3nUrexMIrymLgDXdXf7UbKfB0hjQQ8ctD0ttC+a/w++f1XM4jtUrhHHLhNM4JVh2885taDXN96qrASaw7tj3TQvOs7nfsx2gz/LciWZunVk7fCRlEZVuWUJhgW0t17ZKM4avE8VM+ArWzxPbWdglCo9P74xS05tWudjgIXkK96XdR+KNt1mFOyK71j05HJuFLoZisOsTcNvOjlwfT0y7vI+6ij6fRmqbHjTZOKsLoSfuAvEqMhrqU9x5x3DQAXC+sZNElN8Q/1/uFWgXb+IOPBRCP2/3ZnLjAFeoIiA+St5f08p83/x5arvWXt8ucQQUJnBgrt9SpbsVCtQxeSk2CUBHhzknmi74kQuMu/TGgt4giWReswwsAsXRcvDwyAbNbjs+6vVd11/p2yxOC768idPTmY3DJzn9nTGSUbEzKxp9pV3Y9iythpHNYSLoLHgCFX5JlmJPoGXGSvO7qELGYEz7knR1rLvVpcThsK7YDRWsLYUObD+i4boG5ROwjRzGn7dnuK72w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(478600001)(71200400001)(186003)(55016003)(33656002)(41300700001)(53546011)(86362001)(8936002)(122000001)(64756008)(66446008)(52536014)(8676002)(66556008)(54906003)(316002)(38100700002)(66946007)(66476007)(2906002)(83380400001)(9686003)(26005)(38070700005)(7696005)(6506007)(110136005)(76116006)(5660300002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ezyY2L1zUyL0gNrbSkFBkQHscy0PPDzbeHlVFoQh1EIMsHcvqflrOdhj+M65?=
 =?us-ascii?Q?tWwv/C/aHJUrK3jtx3nzvShgwQa3QZfreEvxremQrTYG1l3GpNNrK9x96CXO?=
 =?us-ascii?Q?Od2tPAUbkar4NE6FT7fUihGiGjLfusKt7y8MVWZT9RP6Y9E79E7XDln92ehu?=
 =?us-ascii?Q?VD1mBo9UhNAU32cRPnJz+5N1ahs6ndQKlFphHsyV93x2GOkYPZVCDT32QpvF?=
 =?us-ascii?Q?vx/xH1z6vB9iXzFBcMwZhp9Vogv8h5RxZoh7gG1EO/BDgTvw6cv0V7VfnnVs?=
 =?us-ascii?Q?SjgmMfTVUGtWTV51sKgX7QKK2ioAv8eko0NsMolO7uyjBPWDZIabEefU4taS?=
 =?us-ascii?Q?aK44XWr0hmJwung7WQpGP6zh8LRsdqBk40l8NUh3jGfQj/RStaENhKG8crE+?=
 =?us-ascii?Q?2+r7uweEGFgwSyerz8P7rlL+4LVpgLDNSfqvKRaID41YAxkLPb8YMa7w5MH1?=
 =?us-ascii?Q?Vp4hD5WT+bG3fsFttvTSgDQVdmK6thIdKVZWAl4W8llX1ir1s6OfO3PsYvR7?=
 =?us-ascii?Q?GlLy6TPCN0QOBOKAnbUIyFhRvgY1U76bBR//0sqE3QQGyPOeltxjOUhjyv1j?=
 =?us-ascii?Q?wVIkLEBG8D11E6ss2yXma9qgUXbO3zmdz1EwecuBuuOW5NttRMRan/1zbEBS?=
 =?us-ascii?Q?xQwkqFa775iwyt5ALq0keYGFpaFcbpNiWIJjiviCO8dpcVS2WqUjOzkih5KT?=
 =?us-ascii?Q?yDpWpb0Iz8MY8HmfB1azgutcepFRFbRfCefJJQ9+xG7Xwbc6BzxJtXkUxk5J?=
 =?us-ascii?Q?oj11L6cS576f52or+GfFShbSpZ5ISr2A03vlircIBBsg+SD6x333GcHnyCBf?=
 =?us-ascii?Q?uCBdEA9feXFeSPRkAlvJ70YLHKYwDqtM0AACLYtUoOoKWX1UH0p7Hp1+euZe?=
 =?us-ascii?Q?GXJ1WbYDlUYyjVe0eG8URzQHof5pKlU6g197DiM55lmhgauob8e5QJqTMBAq?=
 =?us-ascii?Q?krGiZs/YXZ8GdN/OIwUKoOlRbaSLcnGI13o7daTpsmoXD4Kadz57e3nKK3Dt?=
 =?us-ascii?Q?x3Va95veNyuiO7crXA2LpUaoOuoPJL9pyrcQ/R4KdEF4B1PPqXv8b96x716J?=
 =?us-ascii?Q?15QukiWQTTcEU22lknXx0fmInwXR+KrAtPXimLhvEWXUIxwJ0gcAydObz4NM?=
 =?us-ascii?Q?ZV2A7acP71gsx0JKWWLhjixHnmTXQV3n/H0RXD8p3L51tf82pqJL8mk7O2MD?=
 =?us-ascii?Q?Pvqm5uDzPoStwaODeAmlJecCODzbwYbD7fKlsVu8CIScEHd6bLV9NEOymn+9?=
 =?us-ascii?Q?O7gldxUEhsofsV2WVTzFsBireafvlVlH7FUf1QTyNOXHxWRNZ7TwfqKPeXvb?=
 =?us-ascii?Q?Qd0PV+82135lhyLXk0+VVav39VbH4Kjd6vNwkQHZnOF5O9ZLY1xGHiH/lAAf?=
 =?us-ascii?Q?CWAlbXIOVvW3RCSZfvyLx+peJcv3f5lJ+5MyODtJqc4K7+OxqNYjzRW3KQ9i?=
 =?us-ascii?Q?uXAVgY0fOM9exZrI5Ai4YT8Vw0dfbeDyLWR6g0DBTYdnC/lOIv2D57OgvM1G?=
 =?us-ascii?Q?haGegEQZzFG74nsCr7KYrQwpDXC3NExfhkgqETaJVgvPVCgL8urbzp3qyH3R?=
 =?us-ascii?Q?qcxIpfJIFwu24qIo5YY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79096230-9066-43a5-f2c4-08da58621a74
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 17:26:00.0100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6e/Qd5QSeBxcfG4OszoINy1fqPpD08lxrSzmTZI1s8luVtujFyDZikSzAsdI4fWg3Jo2h0GgmZ4bsha5WEXXoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232
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

Hi Rafael:

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Tuesday, June 28, 2022 12:59 AM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Rafael J. Wysocki
> <rafael@kernel.org>; Len Brown <lenb@kernel.org>; Pierre Gondois
> <pierre.gondois@arm.com>; Sudeep Holla <sudeep.holla@arm.com>
> Cc: Yuan, Perry <Perry.Yuan@amd.com>; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is
> supported
>=20
> commit 72f2ecb7ece7 ("ACPI: bus: Set CPPC _OSC bits for all and when
> CPPC_LIB is supported") added support for claiming to support CPPC in _OS=
C
> on non-Intel platforms.
>=20
> This unfortunately caused a regression on a vartiety of AMD platforms in =
the
> field because a number of AMD platforms don't set the `_OSC` bit 5 or 6 t=
o
> indicate CPPC or CPPC v2 support.
>=20
> As these AMD platforms already claim CPPC support via
> `X86_FEATURE_CPPC`, use this enable this feature rather than requiring th=
e
> `_OSC`.
>=20
> Fixes: 72f2ecb7ece7 ("Set CPPC _OSC bits for all and when CPPC_LIB is
> supported")
> Reported-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/cppc_acpi.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c index
> 903528f7e187..5463e6309b9a 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -629,6 +629,15 @@ static bool is_cppc_supported(int revision, int
> num_ent)
>  		return false;
>  	}
>=20
> +	if (osc_sb_cppc_not_supported) {
> +		pr_debug("Firmware missing _OSC support\n"); #ifdef
> CONFIG_X86
> +		return boot_cpu_has(X86_FEATURE_CPPC); #else
> +		return false;
> +#endif
> +	}
> +
>  	return true;
>  }
>=20

I align with Mario to use his patch to fix the amd pstate driver loading fa=
ilure issue.
AMD CPUID include the cppc flag to mark the CPPC valid  if the _OSC dose no=
t have the CPPC support info added.

Tested-by: Perry Yuan <perry.yuan@amd.com>


> @@ -684,9 +693,6 @@ int acpi_cppc_processor_probe(struct
> acpi_processor *pr)
>  	acpi_status status;
>  	int ret =3D -ENODATA;
>=20
> -	if (osc_sb_cppc_not_supported)
> -		return -ENODEV;
> -
>  	/* Parse the ACPI _CPC table for this CPU. */
>  	status =3D acpi_evaluate_object_typed(handle, "_CPC", NULL, &output,
>  			ACPI_TYPE_PACKAGE);
> --
> 2.34.1
