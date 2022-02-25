Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C627B4C3EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbiBYHDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiBYHC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:02:58 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AD9B3E40;
        Thu, 24 Feb 2022 23:02:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AprKn7yZekfQ/kx/KdtiKNx2dUV1dTizlMTASNFu2Q9EPxVKGZ5qzdpmFTtWWSXB1gki97k6IDS2VBLSLm5FCEM80Yaj2BiDHSuiQQg/JjO93HZ1vFDtwW8S/aCmGhO9SOT3Aq3lnwptXra5rVnyfrLOIQBuiJ1eCWBPy0O39y3pBFj7c7inH543deJ4a4ikp3jPXR5u+Wxz6y6vMN/LYxHkh4hg8RS7xa97nbqWI78c1ndt+49eLdijsma4eAn0sHLDHDp87WH7h0cXBf/C2D+tgZdgvee8JJnTBzmTzq8P9fDbATSpD5V7hnb/yyDccpZ4JgL02Cda5NcXQF5Mgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9wr2ZD0wa4iYVYepEsxFczqboHXVd+BimK5TpHRStQ=;
 b=JHNm9C0bd5jyT+Wpm1Cfo6wHDOeNjM8Ib+GC76xy35D0aO+qJF3hZW43B4y2vtWU+JwbWGq2J2w+/pZ/QDHmDuMWpJNOYEXJrH41aEDhE3UQMckP/0zsHlO2/X/5dcJKy+gzxa8wHDtxy/2aHuwK0WFkDNtNm1uoS0LOaUAFKWlFIm9uoUsCSQQHrF/u5OCAUNsa2UCW+XAjhwc9Bz55KhEXyvQgx+PMF7uqG9bQiGk9vNDOA4hdLD5rOo00wuQS3uoYdCKvA5KLXo4ocl948ez2lahd8zvLO3y5/x0Cr6Iel8HFp2EbzxOfPUVbWEEXnhtptMj0Th1DmZCudYDaJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9wr2ZD0wa4iYVYepEsxFczqboHXVd+BimK5TpHRStQ=;
 b=Mz4wgsG1ohFh9Gepl1g9WubWZaWPgIOoSBwbN7s9T+QV9rGvo4XrPNjD3/IXCHmqNDXLgp6vP28oekeBrxBeepdy2UP8WDY1L7e99gG3PwSxGaCYLTGwogi1AsxEo1/z7pnFZ9pdduFHE20LjuMfvmgwa5ykIz+0l2roG43IEDVuhDNpWSC8xZfLRwEqlfZuEhQDbYkywxDA2ldN0I9hNbRk3eJq61szGQlTpuqYTkbTG/8q+pLTi1l5DRqV+/XJCNqujXxZivtBZRQEufU4bXfOQAjfmo6jyBI4vsgFB9JgC0A5O0/I9f7l+2pbC59Dktrp/CG1SK8cnIWtN3KvAA==
Received: from CH0PR12MB5089.namprd12.prod.outlook.com (2603:10b6:610:bc::8)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 07:02:24 +0000
Received: from CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::2158:bc32:112a:2860]) by CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::2158:bc32:112a:2860%2]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 07:02:24 +0000
From:   Henry Lin <henryl@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xhci: fix runtime PM imbalance in USB2 resume
Thread-Topic: [PATCH] xhci: fix runtime PM imbalance in USB2 resume
Thread-Index: AQHYKgwFCgHVyOvH4ESDy/u/4+LZrKyjzGkAgAADKIWAAAPnAIAAAxWk
Date:   Fri, 25 Feb 2022 07:02:24 +0000
Message-ID: <CH0PR12MB5089F5EF1D1AFE54476E5E49AC3E9@CH0PR12MB5089.namprd12.prod.outlook.com>
References: <20220225055311.92447-1-henryl@nvidia.com>
 <Yhh19qsTsGRhsLWT@kroah.com>
 <CH0PR12MB5089EB28FAA6DF61F57F6D09AC3E9@CH0PR12MB5089.namprd12.prod.outlook.com>
 <Yhh74nrKH5XuRZ/U@kroah.com>
In-Reply-To: <Yhh74nrKH5XuRZ/U@kroah.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 8b1bde43-52d4-12e2-38fd-a22d93c02113
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd990e28-8f76-41a9-6164-08d9f82cc697
x-ms-traffictypediagnostic: DM6PR12MB4500:EE_
x-microsoft-antispam-prvs: <DM6PR12MB450074A18EE1C735130AB839AC3E9@DM6PR12MB4500.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K/TI1CZljbYZ6njW+WW7cj7LpQrXBpgYq39tADTJy0utLx/Ay9s1EiR4lDvSS1HxkvZIp2sYXSLsQWfTZoiEhwuchNigOAhAUnYrn4DOHv6tYG8cxRagZt9/BSoZg7D/7bYXfAmLMTdvCmP8bFVk0U+oP+2LLQWCCBFTiKxGM0Vb8mmILkMw8i8ipCsTMzMh5RilDfboByYhuETNjghRvMAH6NrA+MoxVHpYGfEyd2Fz1zK7dr4FF1jwKKon6BHGUMOA9cYZyAtSXR671Fyzbx00maD9jzKCemxpL4fCaXqYF1R4AYfIBC/ea3UKtgYfj0bCFCiTZrhV13rIKieZwOchwNI33jNOeTl7WEUcEtg/gc3dg0fwwO4yzdEATWy365MfrM3EiRiKRGZV63K5dgkAzPlPTYIjsnQCX6ZpkgQH7phimS0gtzfJnev+U4XGbH796iGaFyweedTHiro3UaI2h0Synd6YLm6fNzrqyLHbtHHsXy5/93k2lBKLptTXhDxvveKa2hpUokUZpsolhzvQUB4RqOwEg7Qxd51EQEbsCt5XCIVtnS6toQ5WPh3wBOSlVwU4N4c9igNkCesq6lECYW5c10s3cCR8cediqO0SgM+OtcDlWKA2EYbWT7GtkCPPfIAaWa+ux1zmkQIxkiBHFilOQQiTmb7+yHcUd0SQm+U8eHqoYO5hnVPYDP25So+KH4hNoJYWp+ntafheRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5089.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(86362001)(9686003)(26005)(7696005)(2906002)(8936002)(6506007)(186003)(5660300002)(8676002)(6916009)(33656002)(4326008)(122000001)(54906003)(38070700005)(64756008)(508600001)(38100700002)(91956017)(66446008)(558084003)(66476007)(66556008)(55016003)(316002)(52536014)(66946007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fmKKysyajGVKXnnTOkfAVF/vToOa0Sp9bG9g8FuDWDSW4SrqBBXOU67lvE?=
 =?iso-8859-1?Q?boPkYTTeXiK1wl+4hoVavCqDii5lgdiNkVB9iOxDMn8a68p+wp+b5fs+py?=
 =?iso-8859-1?Q?MxCgfBFFhGZsOL5ilhlsXgK1yV7glZNQ2/WM1yq4fWMHETx1/yG19iohm/?=
 =?iso-8859-1?Q?Kv434VoXs529DAGTfFj7Zhq6kOzAp9JF2HhuW66ZjLm98DzZbspy4cQ2a7?=
 =?iso-8859-1?Q?d5KP0Nu9LUZftJKxVvq1qmtk2n+6ZFTQYLLW+yTmqGaP9xlXMEpFkVJvwR?=
 =?iso-8859-1?Q?hsQhh2OxBcrpFFPQgR+Zgu440AdJ6II9ee/dAZysZ+EMCbWyp0VJr80qTv?=
 =?iso-8859-1?Q?RS0R6xkBTNS/q2lkJtJGSiMA9pMyf7UAZDctmhXDCJ2sQlvEe6XmEwUwcy?=
 =?iso-8859-1?Q?aY6d7OW/YPk+Q5WLN0gtOT7yyL6HgftJzRdQbS8IpH89te56P40FcMnN5z?=
 =?iso-8859-1?Q?zyfGh20ciW85RsjS1yJpxNbA671AsCJyGy+CdL50S0Lg184FKIAZKArHgY?=
 =?iso-8859-1?Q?jrpdLXxXK1tf9efZHTsE/3GBdg6AA5cvVhoGlS8KbXWY9mnnKzv2nIev5U?=
 =?iso-8859-1?Q?TfRuMKfHMMT19tmlLM7z0Ot0SAYzn+cImNhufrj6qeQut8r13RmdaPr7tc?=
 =?iso-8859-1?Q?XQGmWMBxUW5CFRv1ciQ5ljcBocCjmm8vr7qeZt0wgvtPTq9HEvWqyZ8SJ2?=
 =?iso-8859-1?Q?ozQ9ODLbAa+MYXaCbn0x0P2+aoNmusglkzs8F7rRDcFzzk7vVTR4cGJXk3?=
 =?iso-8859-1?Q?nhOlQHa4S6QhJ+jG6d2JfIfo9EjkNZP9lE7GsP4icdcqDEZPdk+XVIoCZq?=
 =?iso-8859-1?Q?VaFF1C9OAdFbo8ofk8Co8Ecszn/Kgtn7t9jizMVZSj+I7ROBrbwqgUltGV?=
 =?iso-8859-1?Q?OiSNgi7ZlVYDASueO6w5nEdQ+VUwKqc+u+biCnXAcay+vN4I9g17dqm1Qm?=
 =?iso-8859-1?Q?3wKpcSLXjKEn+jj5ZUfs234ye0Ao2Xo8e3eGY5bIgEjfgZfLiNcGKNpCR4?=
 =?iso-8859-1?Q?4FomTwPwgL06nRS67lAEY4QBZillVagfJesv433ELkHVWKX/1wrQih2mgs?=
 =?iso-8859-1?Q?O90o3xlp/MySZ88eGDuk0MAo+RjRm5Jt4ci9905OhFu+eVKpjFOgDj5zRu?=
 =?iso-8859-1?Q?Y7LdmGJajK0whBrVuFXaBid05Y+adR2IC7HQRGA3ZRkEdPRey5vQ2aLsPG?=
 =?iso-8859-1?Q?hIGTu9IsS9lUdko47fZgwqNoFNL7u3i8kZSvllpyfyJCzVcuP8R8PojVyd?=
 =?iso-8859-1?Q?xsudgJjQm+vwu6o/dn5B8b/B4/92CzA0DVoCWjKyfwqRByUPimA2AHYi6I?=
 =?iso-8859-1?Q?6ky5B5ysQ/6RwUXFMjBP25Mw4G+i40Uz4a0LR65cyLT4oAYN+w/goJjDeC?=
 =?iso-8859-1?Q?2aDao0ZwGcwBLT78ZSYOVmI1AbQLNXZudZ/Gf1rzspQsO4f1QCBvLpZR9y?=
 =?iso-8859-1?Q?FJrIfp0IN7tOX9MRkYtHOZMHaFVwMCkjh5k+3aXYiTfvTO0k4Ljj5YuH7G?=
 =?iso-8859-1?Q?PMZrCdwm5uJmX20Zuk0EEw7S+Js+wQnNTnbk/NLK/88+dDO5ZD3JUrCz2p?=
 =?iso-8859-1?Q?hunuPZm+iRi4vXT4YhALZSczo/gxdO7G4p+K62B4UhaBnvN/iRoZVnp5VO?=
 =?iso-8859-1?Q?e/anl9nVyqDgeYVDr65+zvrCzVP+kG26jFL/vQwD4d/CScR7kY96h6Wg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5089.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd990e28-8f76-41a9-6164-08d9f82cc697
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 07:02:24.2746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +03TgGNLvn3sK95g/BNfxLlbapKjqR+eWwVGLZCG41eu3RiEOYkh8zdPkaUzUZyAY356mHbrXXppkJ1imeFD2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Great, please add a "Fixes:" tag to the patch when resubmitting it.=0A=
I will resubmit soon.=0A=
=0A=
> And the "no functional changes" seems not to have been true, right?=0A=
Yes.=0A=
> Does this need to go into the stable kernels?=0A=
Yes, this need to go into stable kernels. =0A=
=0A=
Thanks,=0A=
Henry=0A=
