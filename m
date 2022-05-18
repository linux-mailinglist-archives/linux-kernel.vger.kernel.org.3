Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBE652B55F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbiERIkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbiERIk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:40:29 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2105.outbound.protection.outlook.com [40.107.114.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747D6C8BE0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njMY7aD6N3VPxymwdLoUMg14jXe4+9ckLaycZqgohsS9+tEv/wNuudNp5rlyxFv8+u9HmTV4mODGfhuumlHhPwlVrhy0i14l4H2Hxb4ZrUSnlIXGVi99QLPAMTckqmFqd211t+oxVaPhKo/NiAU7hqmK4iyPnDC2yOw3gwSQ5ziGb1co3Bk84mbn3NqvuomTrvTng4H6+FZ/E+8DpkVXZ+1AKSQ8Sr33tKoQpX5SImpkV3X+WRQ73QrB8ZYdaUeGajzIQbw2g/BYvJILPbOvNPwdf4O3Jp2Agci/Vsp6WfsYV/hzNBK5Q9dYkWzmxg1KycNw1x3LbdHC6JGoG3DRBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaUb0LsSSwOoItD5rJVExel1EZtkuHyfbC/INv6F6BU=;
 b=BymsKR2f8LeVwkraf+hiEdmySUlmmnjb5O3hxTErpd2VaBmsMVyCk9cWXH1AdSo7NjstfJCIQlwOhh8QILa56wpNbuc+aPAQZszCr/PD9QZx/vDn0wJ1LOnfkVDSJOi143Nc5ZHa6sNJjD2IrI5HFLTFoo+p7ODrlyMcqqaXdQhD3wIDYh0j3r1/ImQVDhPiFGngMUIk9MMq8SZu1K6H9iT3MfaBEhtP+pZuHMGMmgtcWy49B3OvKSGOjAYDGprnZrt5LrmEiDYGclkwX3PSNiqu0NuiZ/BfqoQLNDk8L1HeSjRX0xaSU0Fk0sROMy4cUgwqM53ojA/ilX7cH5Sorg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaUb0LsSSwOoItD5rJVExel1EZtkuHyfbC/INv6F6BU=;
 b=dTsqz1aOoNfoVi7/fVJJ7Av2cOzBhsUpa/+GpXCjQ5uoIkcpuWpowaB9a4BSs18S92Br7B2xg4d5wG9ioHDoR6MoyQZcoHNmobsWGkhR8MHTSMBnknQEUjEPVAfnoalZKpJ7WKpW82og0xzRdNODE+w/fiT7Kekmv73e5DaNEPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 TY3P286MB2724.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:257::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Wed, 18 May 2022 08:40:26 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7%7]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 08:40:26 +0000
Date:   Wed, 18 May 2022 16:40:18 +0800
From:   "Hongren (Zenithal) Zheng" <i@zenithal.me>
To:     Atish Patra <atishp@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: cpu.c: remove nonexistent ext from cpuinfo
Message-ID: <YoSw8lNHJqRDy6lg@Sun>
References: <YmcbwYcSzwLSepWZ@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmcbwYcSzwLSepWZ@Sun>
X-Operating-System: Linux Sun 5.15.26
X-Mailer: Mutt 2.2.1 (2022-02-19)
X-ClientProxiedBy: BYAPR01CA0039.prod.exchangelabs.com (2603:10b6:a03:94::16)
 To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7db261b2-dc49-4be5-69cc-08da38aa0e23
X-MS-TrafficTypeDiagnostic: TY3P286MB2724:EE_
X-Microsoft-Antispam-PRVS: <TY3P286MB2724CD30A0516AE2B8CD04D2BCD19@TY3P286MB2724.JPNP286.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mTAmViYwNL+onDud42F+oCEc1N0vvWu5GMdUp3jYs1XO7vJkSm3roBdOD+gJUADRSS/UUcdY3P/U1vWwJG9U80uq0iDHqR/ndci+G5hlM6J34qU9Mr+8wFDNLClymPbOQmgj911cy05beON9hHnWnvuawfoYlx4OoN5XhigilSXWQKRqk5Mzad6MriztRoW4klweEPde0X71533cEwq7iKBafsBaRRR4HkoTRsZdR3yOBgiNzMoXvfI69mnI3Igq/M/GK8vLVozpcBx1zX6Sku4UxyfAKXS9+4mIvI3deqUZfA8G+eYzwVCYKo8PBUI/MeRWVQ2yBU8+ZNW4dQBLx/mb1QQoV8/gd4s3m8nGm3jbXoDQf6gXdqJxtmHa03l2WIuufIYH+RLRR4+OzO3rfnKaoeAxpIyYSUy4vPz6gFoTdXJHW0Oo7ABAeoEdpE9PQLAiH9rLR1q/IOAfqgTT3bTLymjPGQ73u6/mnB+yDYN/XVZ+IBC5jy6NCBSxiuvVZA4A0ozOkKbTXKqnKZw5/5EBvBQmLbix5rNfFoiXzT56rGS6BMFwGPRvzVn5yI+yW4cw5W2ssBGLvBdQ/PZz82ewGkS+hULuS99gJmdVcDltHRJfl0WdA70U+dYPZoon35aWHhxv8QBEOzrnAnaFszRRkDyGn4tQycSxA8kv/xa3OW1URD2EJF8uFxprbrG9P6YKv51a+PScGYH2x2G1Nlf9vJAdqUbmYupnGJGxeG/C0JT2wY8+tCVL5UAr4uzUm4f7FJ4gDL2M3sEbLLkAhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(7916004)(136003)(366004)(376002)(39830400003)(346002)(396003)(4326008)(8676002)(508600001)(66476007)(66556008)(5660300002)(86362001)(66946007)(966005)(2906002)(6486002)(38100700002)(6506007)(8936002)(41320700001)(41300700001)(316002)(786003)(33716001)(110136005)(6666004)(52116002)(6512007)(9686003)(186003)(83380400001)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nroIL3bWtF3I37JuL4A+4H5zYb24dImWaqFMp0jASsI+s9ur7ZWP0QvXPMyz?=
 =?us-ascii?Q?7sI6bWQfSKB9Ako/aRFj8rWZ3RjeovgG6EkoWRUV3wzNfo0sS6gb2wy8+L6K?=
 =?us-ascii?Q?y8zceCCRd0W9sY62ufdUI0n818Xh1WOxQWjiymhPrfEKI7Sfeffh78lUd5hQ?=
 =?us-ascii?Q?7qX0Hjw7iBmbnaVh3yIMzw9L+cQuL2r3h7nXcykDnqUfiRpP3flC/w4Lkip/?=
 =?us-ascii?Q?tdityWFem6fpJTwpe5M3NYtHy/q9Ksj51Iq2qx9jD0KWOpHKy4ylbWULv1bU?=
 =?us-ascii?Q?WRCXCJ3s0lrwb8zWHQZ1+zTkK31ouuwUM1lAi+OMoABlGgmAwYRPhRttsULN?=
 =?us-ascii?Q?/vnRXgeTEGBCsLG2U9jJpYw3KmlpbzZKWADKzGAUcozojT4cDytgFB+A5XAH?=
 =?us-ascii?Q?V5odGdzI/7xoHPy2JOgNMowtLL9o6Cmq5OrbiqlXamV1S4RFjl7pdIX1QEyQ?=
 =?us-ascii?Q?q5HX+zKVYg/ScDxgSv/BU38Ydjwo6jR4va/Vkq5jmSjldJdpjSSXQfQXvm/A?=
 =?us-ascii?Q?sPc5gaK5U7AoQev6agTB3+8eTZ0vRQU0pfq8d5RQ5ichRDFtGWv6WtQr5pMT?=
 =?us-ascii?Q?Pr3enSESwZijCwdGGOc08QZl4cjICiASIuxshHeqhypkqagK40uLk+DV/cHZ?=
 =?us-ascii?Q?pLBiVqanT7ov6awr4Izm2Dg6rInPGDNkIaLEYKJpZoojp7abFz3yjjPmjxvP?=
 =?us-ascii?Q?pNSdjjzadGEUVS1x5/gC6WhS/Gk9orj4Bz1Bh3QrY3DHzXP0l5RgUV9sHDgR?=
 =?us-ascii?Q?PJT3Hl8yhjm/qDw5eRKR5JQjZeEPMf53bDJXzQiqGx0e8p4ZwzwAt+oXgL1N?=
 =?us-ascii?Q?/oO3bdEC+G9BB0rctJqTsCupaMBM/2PoVeUWutTywWY3jYhJSbzvOURjyPsW?=
 =?us-ascii?Q?gxy0hjzBz0lF6xRcfAO2EAp8q6Q+PzfjEaLtaUQcG9CiLeQQm81w8IkOTDO3?=
 =?us-ascii?Q?PHDV5CD62+/2b+GSihu6ogm05X5FsW1bUML8gvpSKjFxRji2f7wcqdKmxsDN?=
 =?us-ascii?Q?vdfkJT5Qa2sBKC2Ajx8kZTZ0o5a3RrFB0QLG+MO6Z9O6iY8uT7R8kgxNMNKw?=
 =?us-ascii?Q?TY1d/AF+/CJyyGSDVOSx1SVOkE9Oj/tbRcj/UQe8M6JM/Ri0kBEV9WKwvpqJ?=
 =?us-ascii?Q?T8IROlWJpBV8WwpjhNRpjEuuku9aSjolYK9FzKW20RaTBHpwUMq1cp2QGkDF?=
 =?us-ascii?Q?VbSRMMW7Te04R+MCtuio0U80ilA6vG1UBKnv7fcYhCvrMov49qCgQtDzmRNW?=
 =?us-ascii?Q?MCLrY54UcA/hO1rdoFseudvHsG/OAuzjaT/0rqs9whQDZh+nqrtMrw43v4n+?=
 =?us-ascii?Q?H6y89/iP63agWC9Zn/eb8n8YQsZBBxGvNJkIrpaKjpWmYDChhnHPUv6kt4Iu?=
 =?us-ascii?Q?/yJ2dB44tahAGngDPJkHp9bfUgJKY23V4y00//Cu3Lxc6L45gXiBhdCguFqp?=
 =?us-ascii?Q?xUMuD37KiipYmcpEgJ4X9nKronrXo4y77+Id7xiOYIw+EujWY9q/rZsXtQXV?=
 =?us-ascii?Q?7HVZ2ZS2DugCPMiymEMzQDXoH5PYhNlfdwaKgQqZph33ZJYCQDoK8MKcJ3zJ?=
 =?us-ascii?Q?FJy99EikJ7PjMv7aT9zQYn2dM1SZy7BaLwUkMCxpGrBIzWtn64LfL6KTApBk?=
 =?us-ascii?Q?L2SxZZW+b1vyMs8UmDqWJUy0mIFaotNDU1gxtS51KehZXhpeQvjuMJKHp8D3?=
 =?us-ascii?Q?eGmlmjYjy2fXV98hA3810CxmuiNoryANLLKTHJMNF+ChDfuHewyrp2Pg7wao?=
 =?us-ascii?Q?ZY4Bb12cXw=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db261b2-dc49-4be5-69cc-08da38aa0e23
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 08:40:26.3205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0+Gaiox22H+SrH8qqmdi6rvwnxfnU1DJeBJamRQgyQN74r333acecuDxWRArlT7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2724
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 06:08:01AM +0800, Hongren (Zenithal) Zheng wrote:
> There are no single-letter B/K/J extentions,
> as they are never ratified. For P, it is still in
> progress and not ratified.
> 
> The ordering constraint of these placerholders is now removed
> from the spec. By commit ("Delete more nonexistent
> extensions from the naming constraints") of riscv/riscv-isa-manual

Hi, is there any further update on this patch?

> 
> Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
> ---
>  arch/riscv/kernel/cpu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index ccb617791e56..53a061ab0743 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -113,10 +113,8 @@ static void print_isa_ext(struct seq_file *f)
>  /*
>   * These are the only valid base (single letter) ISA extensions as per the spec.
>   * It also specifies the canonical order in which it appears in the spec.
> - * Some of the extension may just be a place holder for now (B, K, P, J).
> - * This should be updated once corresponding extensions are ratified.
>   */
> -static const char base_riscv_exts[13] = "imafdqcbkjpvh";
> +static const char base_riscv_exts[9] = "imafdqcvh";

The base_riscv_exts "imafdqcvh" is exactly the spec now, as
https://github.com/riscv/riscv-isa-manual/commit/db7a4a0dad0e99d1ec1fc67b582624fc0aeae98e
(Add single-letter "H" extension to the table)
has shown

>  
>  static void print_isa(struct seq_file *f, const char *isa)
>  {
> -- 
> 2.35.1
> 
