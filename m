Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5FE4C941E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbiCATTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiCATTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:19:22 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBBF52E03;
        Tue,  1 Mar 2022 11:18:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHUiifYaQLKvN8X1AqWJwTLtLrfBaooE9VhiF/0dFNa5SaMAmG+mbOpnITEcKLzbg+U8skaEINqlGDh6kJcNGrC+NqSkyDetz7Ttl6Gd43CsesOm+oyZJ24ojAOvEQw4LrFWCC+u2p4nJAj8Tcz88X88jcmKy7RRbyGTCGL3Zr4zSaN7DtcgSwkC9u2YnhxDv2rzRomFRoSAC2hBFGnsUtxUlLrXF8ME84M9RUMF7O4sXtGNuhx7jlDDmH4WpeOP1jw8+HQb1vYNRs2fzfSVcoNA7aqhka5520GB8yyongoSUDiWKXeK+HEPtxIoE8q8PtIWfeZeMIpitt+1bkGH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7C1SJVfHTrFVBjKCdmieAM6tIKgEap0FAI78nNvFTQ=;
 b=TUeARenseZFdu3fKyUFPS3X7Ikyk2fxkh8ByQAcDw1vKDCIGX/evLU5m+6DCte0Qn8WYXglKcJy1BrZO7TVILcx0195wb39Kr3Tg/PU8Ar+LL2ZqhRwRauO28uZjWVRJFhOn8Q1D9wF+0MJJ7+tZLXiz+rRSw6YT25atcj1d/oPp/Tv2U9zQWkHpq7sH6M+qhsY3aLhcg6WzoVRmioNtiYj60RQwKi1iR4D42rLfaVeVaKoJq8irFp7dSwfe4UKWuAwMSYcmniQMo0iJofx4A0DohPEdVlZ8d1DTcencBpFzgav+uSdFW5i4CieRj2B2QcaMwNI06k0NcSXN7t5mHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7C1SJVfHTrFVBjKCdmieAM6tIKgEap0FAI78nNvFTQ=;
 b=FCWY1MHMg/I72b5GSVnVSexyJw5I63Hm+KdAop142jdeJqYBiwxd7MESC7OKC2onxJQaSupm3zPrhWUneg+8DZ1uHejUvJAYOR3JHPte5qFHDMxFt5a1y7E0pyeAojGSuZG1l46AS6lFsPa/kK66GJuXz0sK0zgq6uJsFzdTNBEo4WcSuMGVjcte1zywtniSdTGyYSGVes8s3F80/jzmws95QZFsk4h45zLXnoxO68gZVBCQkqtiVXDuzOxQpFGr096QF8DQS6FkRaWPUbpfawPOQ8geNsXQzXbAvV5yZtHehEC62ugLh0rw4L1oOKW/4PGfZ1n47bYpgSAwuF6JBw==
Received: from CH0PR12MB5089.namprd12.prod.outlook.com (2603:10b6:610:bc::8)
 by CH2PR12MB4006.namprd12.prod.outlook.com (2603:10b6:610:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 19:18:38 +0000
Received: from CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::2158:bc32:112a:2860]) by CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::2158:bc32:112a:2860%2]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 19:18:38 +0000
From:   Henry Lin <henryl@nvidia.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] xhci: fix runtime PM imbalance in USB2 resume
Thread-Topic: [PATCH v2] xhci: fix runtime PM imbalance in USB2 resume
Thread-Index: AQHYKhd7AopZ8pn1EUiip/DzNcJli6yoz4qAgAF/L3WAAGTvgIAAOaxB
Date:   Tue, 1 Mar 2022 19:18:38 +0000
Message-ID: <CH0PR12MB508943FCE2B0A5D218E3B966AC029@CH0PR12MB5089.namprd12.prod.outlook.com>
References: <20220225055311.92447-1-henryl@nvidia.com>
 <20220225071506.22012-1-henryl@nvidia.com>
 <2ef7da52-d8ad-05ca-bcb6-06bd6bb6f9d3@linux.intel.com>
 <CH0PR12MB50892722DB1E7ECA5BAC629AAC029@CH0PR12MB5089.namprd12.prod.outlook.com>
 <2e5f4998-71bc-1fd5-8a82-b7392e4f7615@linux.intel.com>
In-Reply-To: <2e5f4998-71bc-1fd5-8a82-b7392e4f7615@linux.intel.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 4b7e920e-b0f9-c842-18af-8c164e81940a
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bfad673-c3c3-47c2-1e1e-08d9fbb84a01
x-ms-traffictypediagnostic: CH2PR12MB4006:EE_
x-microsoft-antispam-prvs: <CH2PR12MB4006C0B0E7E6AA4EAB3DAF2CAC029@CH2PR12MB4006.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LqU/+xOdCy2ijNtT4Ye1gT1R460PP9swb/avOLBBz4wzUCSrZssfvg2Q3Glz+lY0klOUxdiCizc6lnNaIBJBbfOstVXnd35h+gNinli/OsorcA7w3ZO+Owb1iS+P37pRU/3lX5wctL+GvSmG3CrT/GuvkQ/HrfcEOoPgpeaVmmqAqoJ1HehxCWIvJ7oM17rBS7O5NFY3/810LyekdShWHSD0JtDplxWgbmcIMdeYf/Uy4CjClxfVufhPHjG0J2nCxX2Pjtmuw1XnU4hxlkTNXCC2m5V0itjvxt26MIlfCOFc2RPged8aS/2aKDWyRBjUiSPFqCE7MHyD6CnJfclPwwIoEcMXX4MtaeCLer4nDR5Kz0wlC0bwcjkSj4KL8gI9CTwp6MJKVee8O3v1bSDMH/MC2tTQ9li+gTyfyFoaxnrlWkOKcuVdG1wy3sNznGLrNd9mMHtkn9faM7/h9ZGT+Ir/2xditNA6+Z4sVrMStGrgl5TOm5fp8YuxW6RQd7heTl7v8G6gxSb+RPLatPzb2Ax4nRKtBpxeF+V4icZOK2MpksPlEz3tNk+b38OKU7lVzpM6DtZ//XuEJprp1l7nUjqWcS7sfnK04I9nC3TKjqVnvYCg2ab8OFeF89tDoNzFCBn/Z1yS7QZ695xKT5wZcY3siraTQEu6WjKDZh/WFmffRbddTZiWQogIVPO9LmDCmPUJ7HiWaZpqVm9dUoAxdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5089.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(33656002)(8936002)(71200400001)(316002)(9686003)(6506007)(26005)(7696005)(186003)(110136005)(54906003)(83380400001)(66556008)(4326008)(66446008)(8676002)(66476007)(64756008)(122000001)(2906002)(91956017)(508600001)(52536014)(66946007)(76116006)(55016003)(5660300002)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VTNVICPuDKBGFZCI3nvPbhU0mgPQtdH+BbEFRHA9VdhRMfpKB15UhNAhf+?=
 =?iso-8859-1?Q?IWGyUEY69Je/oFCgX+k9il+4zrj8p1P0Wydxev2Xq2KJboZFp3QYKJha4y?=
 =?iso-8859-1?Q?rJkYHs6roDFWVuw8U33xQkGj6MOdfyKto09RjrhPSwt8ls9d3GovW86UYD?=
 =?iso-8859-1?Q?qZx8WCzlFgUHKTg6KZ7aO+mUB+YuNjiiSKpwKqMK0XQoQQjVKHNBtUOdov?=
 =?iso-8859-1?Q?V7lDW+fysqU6pNQLpH2l6huHB/3lfMGFe2uyuYy+aMcOnsS5lcNc81w3C+?=
 =?iso-8859-1?Q?dR/mt5TjPqM7BHor/1/Jl5uc5HrZZ5Iw9yQJoTXQRDnXxUgRuKjWIq+eHj?=
 =?iso-8859-1?Q?J71d+w3hMIZ1ir5JScCun5pSJqoT2c6v1ctCBkeb1VasoRXM90egvMo+v5?=
 =?iso-8859-1?Q?4eQB5jKBdA6eTE4u/hrE8niAHzJ7Wb3cUHluCtn993zy6Nn7oZH8Y5Fd96?=
 =?iso-8859-1?Q?TrtNhjCgaUXtmsgMynLdwBf56ZfEXKmXllA0T005u4XTNDix1ljAXl/ud/?=
 =?iso-8859-1?Q?pX8p1Hyf+YwGilWpjYCo8kEcqQGY7QcdfAfnd9TNyl69IaDlB/KK45bUsr?=
 =?iso-8859-1?Q?8OFcea3WH2GqSqdKdAM0eVPI21AlPxHgmZLM5mUqqu1ys0b9VrmZ8tPVJh?=
 =?iso-8859-1?Q?t54tOHBSGln0g2nbUcM9u57W5BIikBQ24tJ0gSfHo2VQma002DeDUUSQpx?=
 =?iso-8859-1?Q?gu6TnMoEB4EtLs5HjDLd/sVR17GoAT7S/insQTWvy/9Rw4Xj+iMFTRnVo6?=
 =?iso-8859-1?Q?EWkTjtvTnyL53h4hQd1mzgidy/fZMAWqDSHSzouKoIS46fj5yt2Zqkzqd6?=
 =?iso-8859-1?Q?BNZ9pJKbqTh1okxY/da9F5487aQ4LZ7RG+Ocs4ErWmTBni/3aKZyb370y0?=
 =?iso-8859-1?Q?mY7jkRJoeeQP03T2HKx9dSnbfrPv9j81e1f7+afPaR4gU0c0hPx/IK3HlB?=
 =?iso-8859-1?Q?0C69DjMWR6MuIA6lRlQbtmiQtLsYR5UWhS/Dpom9EWfNHiwMr21cGyarYs?=
 =?iso-8859-1?Q?OwFU5uBk1jYsH1Hc+wSpqQoAhbgO9F0O5Y34B6ryAf+njMritA0RnmJkIo?=
 =?iso-8859-1?Q?pV+lYeBGTjx+JFg7cxY3Oi+N3FhDpvMR1xjeT8K9aWlZnB8I+kfi0znxsF?=
 =?iso-8859-1?Q?P5+VaBzQqnkkeUkI7p9vX2RaLs5TjeYdN/i5ljj8N1u1M7gl53NQLt7YTE?=
 =?iso-8859-1?Q?gWkg+zA2w8dMMDfOUusqIbcfg/4dcjRsPJ3Bd7P5WTZ3scVGyvlLlcFs34?=
 =?iso-8859-1?Q?BMCBkQkN+g9wkRxxqiE8OcHVLkdPUevXesFX21RshSOiBHZPquU+q08ioI?=
 =?iso-8859-1?Q?N5wUUNWds7atZ6u5lKHRSoyYkwG64Klnuzi0hU07X+i5vcotNFCi1Ok9yV?=
 =?iso-8859-1?Q?Cz/UK6fFnRt4XUl1VLEcbgb5SeAEYRvhsROU5JKYJrHX8kiAZOTHIoKKbT?=
 =?iso-8859-1?Q?SAzagX4P/V5ict6QS3XWrt5B6YcAxZtmjYvyYx6+AiCZiMWUP+8DQicEpS?=
 =?iso-8859-1?Q?iqwRyb7d41ceMBk9nYYxcLbiSldxXKK7BDkGZ38UneaPohHPlO1zdbHWuU?=
 =?iso-8859-1?Q?i+1muMCI8oYyBfNyi/ZF0T4PjSHgS6mPZC/iOtP1NAkO2CD99tBm6IvrCU?=
 =?iso-8859-1?Q?C1K5vmDauwutEBLGtdqNPAYPgDRper7rWAMdTZjd4EPVOPm6iHBjeBmA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5089.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfad673-c3c3-47c2-1e1e-08d9fbb84a01
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 19:18:38.2527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FDSNUqslT7HhjMWPvpEKMn9FWMVwoAROYT8pmQ8pXLodCCXAHO4QH/IFD8+bsc8sJ9/SAkzSfTFjhBRnADwuQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4006
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe only call usb_hcd_end_port_resume() if xhci_irq() detected the devi=
ce-initiated=0A=
> resume. i.e. set a value to resume_done[portnum] and called usb_hcd_start=
_port_resume()=0A=
> something like:=0A=
>=0A=
> @@ -1088,6 +1088,8 @@ static void xhci_get_usb2_port_status(struct xhci_p=
ort *port, u32 *status,=0A=
>                 if (link_state =3D=3D XDEV_U2)=0A=
>                         *status |=3D USB_PORT_STAT_L1;=0A=
>                 if (link_state =3D=3D XDEV_U0) {=0A=
> +                       if (bus_state->resume_done[portnum])=0A=
> +                               usb_hcd_end_port_resume(&port->rhub->hcd-=
>self, portnum);=0A=
>                         bus_state->resume_done[portnum] =3D 0;=0A=
>                         clear_bit(portnum, &bus_state->resuming_ports);=
=0A=
This looks good. I can submit a new version based on this.=0A=
=0A=
> Also xhci_bus_resume() only resumes ports that were forcefully suspended =
to U3 in xhci_bus_suspend().=0A=
> Could be worth checking why that device wasn't already in U3 when suspend=
 reached xhci_bus_suspend().=0A=
It happens when we trigger USB device-initiated resume to bring system out =
of system suspend state.=0A=
For example, we can connect an USB2 external hub on root port and put syste=
m into suspend state. The USB2=0A=
external hub (the port it connects to) is in U3 after xhci_bus_suspend(). O=
nce we connect a USB device=0A=
to downstream port of the USB2 external hub, the hub will trigger device in=
itiated resume to wake up the=0A=
system. During system resume, XHCI controller will report the USB2 external=
 hub is in RESUME state.=0A=
=0A=
Thanks,=0A=
Henry=0A=
