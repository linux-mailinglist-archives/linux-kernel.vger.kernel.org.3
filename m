Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E141F48A479
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 01:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345846AbiAKAjR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jan 2022 19:39:17 -0500
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:55314 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242925AbiAKAjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 19:39:16 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 20B0cYlr010679; Tue, 11 Jan 2022 09:38:34 +0900
X-Iguazu-Qid: 2wHHuLLro5QHItghXv
X-Iguazu-QSIG: v=2; s=0; t=1641861513; q=2wHHuLLro5QHItghXv; m=kk9PjMuJYwSzBJHZeWOkVjnfSZBkFIW+JUaF3tSPePU=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1112) id 20B0cVfc026424
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 Jan 2022 09:38:33 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 99DAF1000DB;
        Tue, 11 Jan 2022 09:38:31 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 20B0cVgv024067;
        Tue, 11 Jan 2022 09:38:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4LCPQRnQSsLsTTqJn1bUDLG13hyy5BgU1TDp7Mm3KUbNCABc70HnNwhPplT+PZABe+LwHEl2g4FexPdm5Ak8a0uYUvLjIgW+1imGbWMJ7qoKD5HmAA8Jd87fYoPrPCJOG/krMubNikZWJ6EjCiUBEviHSJD7ng1Gbh17f4t4A4w6hXBZoFcdevpWu9lN9umhGigk4ApWovkGkKkt2DQYSCVJ/Cr/Pp6Ni9WueWUUd6gE5CdpTaSXU4fHXG0KoWOLLCNVBlE+8WGsakb9h7A7qDkMJo4s9hg75JgxgpEklKjgeD3SSqsX5hinf7M2Kq3LFzttCsLXoAVSRwAbjyf6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjZcViRFaCBCjB9mfrfBqO5O2lvpCFsoSs07ZoOQnaY=;
 b=TRuLrpIF2HCDHYmLKHlL7eK2wYmhgdrMyb8MaoPsvujbf/8AropnYuM8c0hnD++Ox6NBlguoHtTDYgtWcjxAnbwiCddvBB1k+WfwIOMUGkk4ngQTaaMa0Tx1/CjI2G9BtH8yITrqj7UaU2Wwzxx+BijnD3tTzPtJnSPmHW7ZnSyS9HZp/C1If1M9GOqQn8HzOCyQxx71T9O1i2nxTc49PpUMtTGfhkXG3VSZi4hxATEp4mYB2TPhFeF2FoiYhSH9uZg6XejBmj6qkBVqKwF8msk1gOqGK2nydkg1Fl5AQCQCCMYB4Ku2KB19sJBDbNTmzYNpN5ANJHX+uDV6C23/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <nathan@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <ndesaulniers@google.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        <lkp@intel.com>
Subject: RE: [PATCH] clk: visconti: Remove pointless NULL check in
 visconti_pll_add_lookup()
Thread-Topic: [PATCH] clk: visconti: Remove pointless NULL check in
 visconti_pll_add_lookup()
Thread-Index: AQHYA/UaNwDsjYuXGUKN4WQKUOMmI6xc/r1g
Date:   Tue, 11 Jan 2022 00:38:29 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB6252818ED275BCE2035C52E292519@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20220107183303.2337676-1-nathan@kernel.org>
In-Reply-To: <20220107183303.2337676-1-nathan@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f81d673c-6a4e-46f2-466b-08d9d49aaff6
x-ms-traffictypediagnostic: TY2PR01MB3065:EE_
x-microsoft-antispam-prvs: <TY2PR01MB3065DF6ED43BE1E263CB88BD92519@TY2PR01MB3065.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JVw//j2EK8Q4mAzWFDKw8eD1IMMApRvYa0v3dfAorayfoMZ5hBxLl1K/EomFi9jQ5EvSWySXcfWkB3U6RXtyPlFkj4xNVix/YK0dmyU7iqnBwZ9WdcW/zpPPqJ+8OmQSHVthNAXse86ynI/bi7IJAP+yJh2aLd54wHo7VZ24Qa2wVZ0SiD59FOfKau1p42uK0KCGoIw0YhRu4zbKCNmlQpKZYYwQy8SAGS8GueCvgwihsIvxUpIdM/FGeX+xIF8xouB4ep31m9ADwdegQt8il76Y4HrYVwd3YWeACCx3R+lhrwAQJYbVJNwoAjBjQvDEyJ7hI9KMcOks+qo6XI1f4cePrYMLNSbF6+R+DyP2DL/X4dqCJGBmq5CklIe3ghGkKw8qeAfhat43TUz6ltkCXF0WMq1nuWbBpGuZlYEd2hfsOWt+aosQQMaz4JF+L6gIxo8orsakxkvyBNhe5rYW48twETJZPzwE/3uauDmhAJr0INrh/zH25UQWkTB23F+ivxbQySEV4MQVz7vhfWt1nETAPJxo8wRdawqUm/ZwuOpua3Q8aMGprzmKQBQZVWylfa/Fk4pSi5+pgAfaw7MwVNvS77iBWZB1xtLdoSULWXASysjj+9wBTMxVAiQQOSt0hmt56/qjNMr1VpRU5diDdEdMgsK2oEjbpmNEaDXJEV+evVKnTvxB5AVvI0eCA2tmnt4pMzaob8QSIO7Tx1QH0X4/bUGlsfuibAautkgws9XrOE5az31Ef55CBHVW5a2Rg67etzQFQL3i45xWGt2QUXcBtXys0rt7BuiFXMyZ7+E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(9686003)(64756008)(66446008)(66556008)(2906002)(54906003)(6506007)(86362001)(26005)(5660300002)(508600001)(83380400001)(76116006)(53546011)(110136005)(966005)(7696005)(71200400001)(55016003)(186003)(38070700005)(38100700002)(33656002)(122000001)(8676002)(4326008)(52536014)(8936002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?WnYyOXNqdFJJVFNtQ2dSeFBmNmhLSVZrSlpOZi9NdXp3c1ZZaVVtNEpI?=
 =?iso-2022-jp?B?d2tYb1ZaTTVpTFpFajY3MnpZQW1VazhXSHJDeE9udXJxM1p4Q3gwcVFp?=
 =?iso-2022-jp?B?alk2QTdiM3pycnBmRmwrK0VrOXpTV1YxWUdnc1kyOWpCbHFidjlQMnJ0?=
 =?iso-2022-jp?B?OWIreWRQM0JoMDhWc1l1Z1lhVzdEL2Yra0dCMWxFMXFDSWpwdkh0Kzc5?=
 =?iso-2022-jp?B?bXhvSHFvWmpkM1B0VnRITU9xeGh4SWI2d00rK0FnQjBrRlRDaURIY1ZW?=
 =?iso-2022-jp?B?M1JlcW5HOHNPeFlLclVWQU9ZaHNDaHYwNjdnSThLMkR3OGNTQ0wzRy8v?=
 =?iso-2022-jp?B?N1hmUGhaVTZiclZhbk9lL3JuMjJoVmY5MzlPYitRZVk3MC9ELzY5cUpE?=
 =?iso-2022-jp?B?YWRjcFFmYU8xTU1YK21sckc2eWY4OUgwTGV2Sm4wRXQyQ1Q1VFRMazNF?=
 =?iso-2022-jp?B?TzJqTWFqK3l1aEx3SzVGRDRMRFhwU0hPVlV2bU95R0d4YUQ0bE4xV0k0?=
 =?iso-2022-jp?B?M2NjZnoraTJ2QUVIN2xOeG8xdjVBMkVXdWcyb0ZydG4zOUYxMHA2SXgy?=
 =?iso-2022-jp?B?MThPSlhHcHlJengrUXVWSmFzamJOKzFMMGtCUWpWTzdSSmcyQnQ4RDR5?=
 =?iso-2022-jp?B?U0dLRndSQXlnV1d5clN4Y2xLamVGT3ZqdHRKSWpkZlFrZmVrNnRJVFhs?=
 =?iso-2022-jp?B?NlNITW00WTFtd1l6L2xCZEhtYStranZqVlZKYzV5M3g2NmJ1MUhSZW9o?=
 =?iso-2022-jp?B?RDRzc2JYTWttSm1TeDVlMlhXblo0NHlQUVFkanFZK3AwSzhXTndKVzRX?=
 =?iso-2022-jp?B?N29DcnZlUFo0Tkcwc3JGUkFjRUUrUENXenZVbHI1Ui92U29aNE1XTFpu?=
 =?iso-2022-jp?B?RWEwMXR0T0pweFhqeXgwT3dGUUsyZHpycnNKWGJnaFBVd0lHd0VRbzRR?=
 =?iso-2022-jp?B?ZTN6UFdWaUN5ckdURGNuK29QeVFvem5uVCtjVTltMTYvRmp2NnQvd01E?=
 =?iso-2022-jp?B?Q2JJTFFQNGFiU29OWWxHbSs1b0t6d1Y4aVhKNitMVGNHek9yYlJpL2tK?=
 =?iso-2022-jp?B?aXVzNWJHcHduSW9McGhNeDE4R0Q0bTlPaW5FczdwOWFweituNlNXdmYw?=
 =?iso-2022-jp?B?QzNSZFliblYvdHpMS3RqaEpkbDVjUTRKT3NpSzBiSVhKWVlSZGtIeW93?=
 =?iso-2022-jp?B?RzZHNlBBRkdSd1NVWFJTUmVvc0RzemluK0dXQlZjNUdTencrUmNiNUk2?=
 =?iso-2022-jp?B?UjFKdXkzRW9wMmFCZUUvU291emU4SXd0UFEzaGpHZDdYbXBhSWdDc1Jz?=
 =?iso-2022-jp?B?aE1ZSC8vakNzZHNSQlNhWHM1ODJhN3hpU3k2Q1JKWjYyVHJBRG9TbWRM?=
 =?iso-2022-jp?B?WktXU0xJUkZzZ0UxNVlRdzcwRFdFZisxZkZkckFGM0grWk5DMGF3dmxI?=
 =?iso-2022-jp?B?K0RlYjNVMGxEbWJGWTNoMisxWms2Tk9vRVNJcmZEa3d4N2tFR3hCMHVs?=
 =?iso-2022-jp?B?MDF4d3JVK1pqMFJPN2ZBTzJ4YWdQNmtVdlNXRzZGanFXMHcyejhQSGtB?=
 =?iso-2022-jp?B?bHZ4VHk3WlFVVDZCQWxDU1VVLzJRSVphblNKWmFwY01sRm0wZDNaN0ln?=
 =?iso-2022-jp?B?REt2TXJjbW1rT1JjNXVNS3MrWms0QWdDUzQvbFlrakcyaFkvSXg5ZG5t?=
 =?iso-2022-jp?B?RHFjQWFtTklEZG1ZT0l0aHlRY0FBcnBDSXhrWGVLRVhNdnp1c2hBeW5h?=
 =?iso-2022-jp?B?RWg2LzViODYvNVhCK01sT0FpdzFETlFRNjJOQVB0alN1VWpJcGtobWpX?=
 =?iso-2022-jp?B?S0tPdWlJWVEvWEVObFhaM0c4NFpGSmJvdGpnYnZnQTVqTjE0OUo3cnRx?=
 =?iso-2022-jp?B?RVlJbEtHRXlXSm16ZHpiYVBHYUtCU2I4U0psbmQ2NWdmakVxTjY1U2Vt?=
 =?iso-2022-jp?B?dmF6TEJFQ2w4RVE1d21Cay9pZjRhOE1BRjk5cytEbnUxSEVIT3hGNU0w?=
 =?iso-2022-jp?B?NEdrNEV3YVMwbWNWK3BLVVVST3dnSDVnTDhrdHE2YVJ3ZWc3V05WREZH?=
 =?iso-2022-jp?B?ZmIzOVo0L1JsZXFhUXJya3B4VVdZVlNkc0ZNN0t5S0UrZTVxT01LZVdH?=
 =?iso-2022-jp?B?QnU4NGpaTmY1bFE0SHhOdEN1aHo5dnhmcysvNVVYeFE2TjRyQkFFRUtv?=
 =?iso-2022-jp?B?TFlzNXc4UUlTTVdZUGYxNnZ4SXBvSnhBZmY2dVFCL2pjdkVTMEtNZFN1?=
 =?iso-2022-jp?B?c0pSNEszTldIM3lRUWlIOG42TElYN2w2MzE1VXJJWjhmTGl5NnphWHZE?=
 =?iso-2022-jp?B?eVFlOTk1Y1Q0SlZ5QlpPa2pXZFh0bFZ3eGU3RjEyMUROVmZHbVpBL01D?=
 =?iso-2022-jp?B?M3lBZHNLbUFQV0o3OEREdzRQdEZORldTV0J2Nm5HSmNwMmpTZkNXWEFi?=
 =?iso-2022-jp?B?QW5OVmpDYUtlMXRJWGtpSjY4aTN1R3VqTUpFZG04bXlDUTFGbmhGWVoz?=
 =?iso-2022-jp?B?dFRpNzlvZmt6VjBRQ3pGMnU0c0lLODNvdEx4QT09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81d673c-6a4e-46f2-466b-08d9d49aaff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 00:38:29.1059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OKgjctWsH6467ZPqloDK6PdIRsJ14lhtlx+iFNsuhNRUxT+yZCVpebQ4l1y/iAaZOtTNt/dOeJvwqBUPfbDEPZmtntga75q8U2ikr6+ebjqnQdRv3NGb5ZGiughZ05At
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3065
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

Thanks for your patch.

> -----Original Message-----
> From: Nathan Chancellor <nathan@kernel.org>
> Sent: Saturday, January 8, 2022 3:33 AM
> To: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@kernel.org>; iwamatsu nobuhiro(岩松 信洋 □ＳＷＣ◯ＡＣＴ)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: Nick Desaulniers <ndesaulniers@google.com>; linux-clk@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> llvm@lists.linux.dev; Nathan Chancellor <nathan@kernel.org>; kernel test
> robot <lkp@intel.com>
> Subject: [PATCH] clk: visconti: Remove pointless NULL check in
> visconti_pll_add_lookup()
> 
> Clang warns:
> 
> drivers/clk/visconti/pll.c:292:20: warning: address of array 'ctx->clk_data.hws'
> will always evaluate to 'true' [-Wpointer-bool-conversion]
>         if (ctx->clk_data.hws && id)
>             ~~~~~~~~~~~~~~^~~ ~~
> 1 warning generated.
> 
> This array cannot be NULL if ctx is not NULL, which is allocated in
> visconti_init_pll(), so just remove the check, which matches other clk drivers.
> 
> Fixes: b4cbe606dc36 ("clk: visconti: Add support common clock driver and
> reset driver")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1564
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/clk/visconti/pll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


