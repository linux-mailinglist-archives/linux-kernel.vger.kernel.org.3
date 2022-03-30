Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305B84EBB1B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240574AbiC3GuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243384AbiC3Gtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:49:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870FE8A32E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcQuCVVtYg2sURDuJ4aESjmWZUixYGe0/EDzF54oowyGKT0JXc1RHXYlaQBABABFqh9daxyKTJbMB5psB01qsJ4SjGCHqdjihJd+Dy9tKcyvKtdd1EiyTaPlonV2gbsLNVqdN2yZok+xo4AuRfM7qV5VKBOehlC/fZ9gIXYfggNlFzEpJ+JmgRApZJYj5ZKPwWoQedzlaO7KRtIf65L099fodAoTKFtWM44uphSPpqHFeeCrQLwQrhWpKVWKJRGVtFbdNxwojnApj6V7AOnd4N9AyJA7aNU51fATRO4qVksLztRNgHiKvYQs9VuM9qQos+Mh6sBVA7ucGGYdRTxkaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ND2P4mXCBnL2QUEBqnSUBL/vbh3EFAWCfIHV0Kl9Qpc=;
 b=HFTcNib+98RA5g6YWGJrzNEibHtgnIAx6rkI+ugr5EdUkfwiItP5ydTsSuBLOFKmuJ1p9aMAx4EXbcC6V5aAR3z6GUn3hbONnd52X1O4+0vfaKEyKHNIZtNZtVumzDpKnrEh5uHzaTb8y8i9SGpKXNeCyzUqW8Ejd4oFj1EGhJZlHbqVz8ti2oQ45+PqQFolVwQ7TjbEYeigH6/gPbAKUFA45hxT06y2mYxW/+NDOS8oZ7W6q8ZPwxvrli/HVXYQxOe7fDddJ/XNwhFM0DPFs/E6/a/2jGWsG0klmGqTCRyfZEJCSIjBCTXtb+6vmbRllMKA1kEVBLnE6DfJVOxPNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND2P4mXCBnL2QUEBqnSUBL/vbh3EFAWCfIHV0Kl9Qpc=;
 b=WM2ainMO+saZTyqkBKJ1VjNSd56xcQuboOXUSGi9M92jmvNgUzwVu9qVRc58m0uSYeF1Jfq+3dc5baqzJYohogqnfRHwkTr+WuruGwo0KRuhp4hyU4ffjs4Heu69BbFBBPvh5AmUkhgWmpDmusTNcUeht7S+Bex+cjbPpzmY7Ps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by MWHPR11MB1631.namprd11.prod.outlook.com (2603:10b6:301:10::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Wed, 30 Mar
 2022 06:47:58 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::dd2e:8a4e:fc77:1e66]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::dd2e:8a4e:fc77:1e66%7]) with mapi id 15.20.5123.020; Wed, 30 Mar 2022
 06:47:58 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, Jaehee Park <jhpark1013@gmail.com>
Subject: Re: [PATCH] staging: wfx: remove space at the start of the line
Date:   Wed, 30 Mar 2022 08:47:52 +0200
Message-ID: <3062786.mvXUDI8C0e@pc-42>
Organization: Silicon Labs
In-Reply-To: <20220329222534.GA1002253@jaehee-ThinkPad-X1-Extreme>
References: <20220329222534.GA1002253@jaehee-ThinkPad-X1-Extreme>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: DM5PR12CA0015.namprd12.prod.outlook.com (2603:10b6:4:1::25)
 To PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c23cd652-4a99-48e5-3326-08da121939e7
X-MS-TrafficTypeDiagnostic: MWHPR11MB1631:EE_
X-Microsoft-Antispam-PRVS: <MWHPR11MB16315969A446AD479731C161931F9@MWHPR11MB1631.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kMl+9o17SO9TFhwinJ5J0+uI3n7DY377GPG+0axDO5+Qq2GzU0dbXlAqKg4OYpSfCt0Oa20ST8IjPfbAitUw48lSfgjVpG57bl/lon1D0YkffbZddTcg15uw73wOyPXNT543WiO+MSYjrQruLAw0ALssefn0nCW06bAldOul7mydZ1tU635Jsao7/wFGKJmM9JB0iSt9QhHYUf3DdOK88mzx0O11+k52SJGtsgumvVLqQCV/AAdlOnMtNOMUKboa/6fkzYnlfXwkeFwZCtwXxUGqvSZkZRHiintCZz3afEhMyOzt07UfQHYTlaEvXZloQerBEVFfr70RnenuMz43TZRC63Ws2DddDLxDLXgNWqLrr9QJk5z1R6q49NEO/8xjsItZ0JZxOytM/X0e2/GSKt+e+y2eZO3PGhJIpSXW0czbv/NRlmryKwUyKEhlYJR7h7R4mYLqRF8mi3//4qJi7iQ3LLh63Iefh2YZuAx1c6G31EIDlkPEadeXv0u7BvVlpIh13VEguP0PQIkf9jZbVBMK3Miy95T+9T75M3GkIQBzIBNbEH+t34bM309jMrn/+UU0F1BiDTEc8hOMWXisyVAFIKF/LFStAXxpy/v4jZP/LwIilqqXrJQ59T1x4k7kQndky7ZPR2g0i3JU0yNCB4qkZ4K1ElYjEboM0P4VSYGe5FVKUE4swZdeHFQCPbeB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(9686003)(6666004)(6512007)(33716001)(36916002)(6506007)(52116002)(110136005)(316002)(6486002)(508600001)(86362001)(38100700002)(83380400001)(186003)(66556008)(66574015)(8936002)(2906002)(4744005)(66946007)(66476007)(8676002)(5660300002)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+e+Lln9oXOdmELKFlYGYIJ4VSEXDjFJXJu8i1P4d8OunZiSsvUVGl1jAVh?=
 =?iso-8859-1?Q?s+RwhMMalIOKRh8f+0ieootFkzBvdHCpAE9MTtd+krMan2O5ehDD+0loQz?=
 =?iso-8859-1?Q?xBRHLw9WMQ++aTTICECajTUMzTsaIV2RIiGJcHfojkw8y4MF/h63M5l9zY?=
 =?iso-8859-1?Q?xOhUFDs3CtNO5LtK5ZEgvLUZh/S0ps9wC9fOpICf3Y55XdSMMO+UdLrLov?=
 =?iso-8859-1?Q?rJGVzvt6JNS19lgubSS89C36TgJ2gO4QF22MP4vuI3GlgpZ0CtjxeDWEyq?=
 =?iso-8859-1?Q?ke8DGEWZL0Vhsaa3pTd0vZ5WdqmYL07p2lEGy49fUoqi/gninFB7U7k6Et?=
 =?iso-8859-1?Q?bNUjJRvXnVkWxNqyg6tMuDZvfptKIhIRJ3mybsdolUqqajnZsBa9puQIoo?=
 =?iso-8859-1?Q?72w4c+wDS5jEc+zLcIje6gQTR22oM9BCBSMCmAim+E8HtF3/MKFkHShkh3?=
 =?iso-8859-1?Q?k9xEqh4sgYz3aTncOJRoADDql43Dm7X5+qMcV6j9NCYBaQ9olj5puhuk9+?=
 =?iso-8859-1?Q?XBC55HxpMRS7ysvBSxGB0rR00ZuUnNilFCrxgGb/57c9W20NlGc0LeDUmi?=
 =?iso-8859-1?Q?GNJvpf1LDyFFYVkkuLKYqjzT8g0omvCOl2C5CmQrvWOthV+mecSxotfb3/?=
 =?iso-8859-1?Q?7u0myN05fnSIixH5HSuOVCpMpSt5x55t2/gXP9Ggb57pA7XnuMKysGy6f0?=
 =?iso-8859-1?Q?A4N37trraY9nxRStoTuOnwOIOSSPsbxgltNF3RDfbCaCgwsYjk9DJ87X/F?=
 =?iso-8859-1?Q?YjxbzjVOthQIbvSaE6N9u1Bv0pKip7ljhwfvyltAungUB0sEX74/ulbtTm?=
 =?iso-8859-1?Q?NNm/dxuFsRZ9i5ksUyX3+g7pq0Yt/FlLYb73Pe5vh1uZaTPFTB6C94u5uX?=
 =?iso-8859-1?Q?WD98ipxvhV1y4K58ei68lMzfZH7HYJTM6uUjbyVrGv5qV9wY8ciYGtZxrm?=
 =?iso-8859-1?Q?pvkKugFN00e2PKLt/cNMjniQkyiuKV8Czmb3ugyaS+gBXsY3657OLNSab7?=
 =?iso-8859-1?Q?UQY9I+QtxYK70kBIpouZJ2Iml4ajCZZoQNoMWVfFIlwk3XxYtU5qbr/o03?=
 =?iso-8859-1?Q?6sOTp+2sTM5y9rFV4BBv86WQkObRO9jcJXTxobiDC1JtDIJPwOyJvd3rMG?=
 =?iso-8859-1?Q?vY9Wmclc8ktyGY/hManLutdMDuzdFBfWoqVAveVlQcYP/EEvinU5bfqFWz?=
 =?iso-8859-1?Q?VK6DtarR5UdZwCXw6vxIVNQuknM4JJj7vHuhP8gSP3DXIINvNMFK3uT8DV?=
 =?iso-8859-1?Q?IKSfzZSPTFOXHd6LAEv13PMUwE4E8kTAEqj7JhesqORg1oJnEvpestkBPJ?=
 =?iso-8859-1?Q?M5VDR7ECU32qlIlqmzC4R6CNfPU0ESMFS2KIYsG7DU1dVSxiQJEaRiGakn?=
 =?iso-8859-1?Q?tsLWL/C/nHjZN58Hn0nc2HhZEsaO3/DTN6UWp/vm57BGcZNizX948tYVsn?=
 =?iso-8859-1?Q?zDH+0Whux609MOhs7QaMWWoxhLhNlujAG50KOj4kh8xiTkpusbYONrjfQq?=
 =?iso-8859-1?Q?baKsxw+aTwGPvYMW9XgHWQALXWEMCZd3VZgL8xQ+eQQHOhXhhsJY/ZNtVQ?=
 =?iso-8859-1?Q?ZE63MJt/Hy5E62MI2hjUckYV4dCRiqCP+Y1NmybV/8aSgiynqx8lQiJIR2?=
 =?iso-8859-1?Q?+ATUE68T9CRVSWAPo5XV2WSPO3hSYXxcS9XoQ+0MYC3b4lHtEIStVCbcV6?=
 =?iso-8859-1?Q?wZzzYt0BnbVUKCFOZTXWliTJYauZyVYUhx53O9Wk4yUf4SHKIGJdvQPOn5?=
 =?iso-8859-1?Q?tggPFUd8Z3x6/e2FnjVwkWFbSrZD7Kxadn9gJKPYiGCWPKKYCITkBTQ0De?=
 =?iso-8859-1?Q?Zn1/aAxlTw+p/bmcJZxFmgzbXxxHCR0+MI0SOV7A0gvV0znzZ174pOGpXj?=
 =?iso-8859-1?Q?Hq?=
X-MS-Exchange-AntiSpam-MessageData-1: xNnC7gd42QhCkw==
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23cd652-4a99-48e5-3326-08da121939e7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 06:47:58.3469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCCG6wc9VVCf6fLT2apQELLhZ15xPDLWiSSVpmtzoco0en+T5mGj1p74tsC44vX0OCmkOeWuMaaeet3duPTPfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1631
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 March 2022 00:25:34 CEST Jaehee Park wrote:
> Remove spaces at the start of the line to follow the linux kernel
> coding style. Issue found by checkpatch:
> WARNING: please, no spaces at the start of a line.
>=20
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>

Signed-off-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>

> ---
>  drivers/staging/wfx/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
> index b93b16b900c8..e575a81ca2ca 100644
> --- a/drivers/staging/wfx/main.c
> +++ b/drivers/staging/wfx/main.c
> @@ -170,7 +170,7 @@ bool wfx_api_older_than(struct wfx_dev *wdev, int maj=
or, int minor)
>   *
>   * The PDS file is an array of Time-Length-Value structs.
>   */
> - int wfx_send_pds(struct wfx_dev *wdev, u8 *buf, size_t len)
> +int wfx_send_pds(struct wfx_dev *wdev, u8 *buf, size_t len)
>  {
>         int ret, chunk_type, chunk_len, chunk_num =3D 0;
>=20
> --
> 2.25.1
>=20
>=20


--=20
J=E9r=F4me Pouiller


