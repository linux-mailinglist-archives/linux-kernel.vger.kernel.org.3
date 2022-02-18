Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35CE4C572B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 18:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiBZRyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 12:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiBZRyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 12:54:10 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AF4A418C
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 09:53:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRxJhaTt2SwaTQsxse4E8NequBoCD6ys45QgPdNeiqW0uWvfWlnypLfegV/5Zpfi8Ac6BhI122lDdJZH5NOLfwNtUlBmnhDvZEurDaTb1rFiJ3sFtuksu/DwGrxLHPt75sh+jwBUJQXUj5DOy+WIo9uw9470h3aSkpFwy0l8I34WfXIoW8nEA594erykZNbPwexjQFg46+0yf/lRoYtsgq2by+jpj5MzwCVdbPJx9Wq1Q3TjSBVjv8C7V6PUkNi+HTRnkbfehXbq/TeZrDxMeJL28oNb76xwCJU3rah0d0cNSUQ6JkQPGHCyj0u9VedefXSy2T153rrl8n4BriRMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUdFrwh/rud9irOje8p2dGcwE2EaH0Kr4cb5NcynRIk=;
 b=ZI4t2J9SAKpw3JzTkruY0oTq2tmcFkaOuZGXNUrZgmHCRxJ3uz6Ejl76OJ2iiXB4g3kfrHAyVkPu/64a8LrrKRUX1qYbKue7HK91FhRGfxmaCVWCq7vYP4nsBXTNehvHf2hxrdF9kZOYyP7gVPbR6OmimKH/vwJ3FAFTSGQNvDSjURnX9iSRwBlz+PfJGpTLS0qCGjxVZRM/uaRzgaUg/RVzgGTaZdup5cYXxJNxLJr3ZTSHpakaK2O95wvlBRKOLluBmR7YLlnRpRbh1vzlpHP+WjyoWZ01EYHqWk7u5EHDZ83cPvBVTYib+9BR2v6YcaDRRHHpG9R7Iw9njdO7sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUdFrwh/rud9irOje8p2dGcwE2EaH0Kr4cb5NcynRIk=;
 b=lchslBsVg/4YAkt61pITpBgzX7g/ge9/jZ70CoPA1KbLY+u7ewSc2MgjwCGT5eFq+Rtk9rTj9rXm5K3Sw143xxRCXqY6UAccsN58t5AS5legpwSocdWGAb0r/irqd5LggcjGtYU/SyGA3PzvLPkT2yI6yNVf/Ra91WBDEoDU6pg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by MWHPR11MB1869.namprd11.prod.outlook.com (2603:10b6:300:108::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Sat, 26 Feb
 2022 17:53:33 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::dd2e:8a4e:fc77:1e66]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::dd2e:8a4e:fc77:1e66%5]) with mapi id 15.20.5017.026; Sat, 26 Feb 2022
 17:53:32 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        xkernel.wang@foxmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: Re: [PATCH v2 2/2] staging: wfx: check the return value of devm_kmalloc()
Date:   Fri, 18 Feb 2022 15:12:56 +0100
Message-ID: <2337500.Vxl4yIHFln@pc-42>
Organization: Silicon Labs
In-Reply-To: <tencent_3CB9DC1C721449E14B4AD3FF65201CCC4C08@qq.com>
References: <tencent_24A24A3EFF61206ECCC4B94B1C5C1454E108@qq.com> <tencent_3CB9DC1C721449E14B4AD3FF65201CCC4C08@qq.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PR3PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::23) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 186bbfe7-4101-411a-32b5-08d9f950e72d
X-MS-TrafficTypeDiagnostic: MWHPR11MB1869:EE_
X-Microsoft-Antispam-PRVS: <MWHPR11MB1869C92A291B35DC736824CC933F9@MWHPR11MB1869.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jTtkFjPY6KZkKw0cqUoIy23IuBuzY5ctzzuoruF60Z/WvafA7SqC7wcrWZ2wxBTpdlnEvXH//d8pxWlPtQ9Uhz+ylY9olr7uTYshIUnBYbB0RBLWQinsr6uRi5zB2XrMNdkITzyFfQ31yzH2qAjhENhNjT4d9NunDyClKfVhCAzRMbxxX1l/xP1ojgNar0D3fOy0FHAFFJPcUZKU8+6ccAPFBqWIXy2qcPAXHliSeOOYNOkjTB8Y0z6qFzB10tynTR0DUc5M/KRj6PuJLJqpvUoKqp+Dg9+od9ljMVSOBY92mBzBsuoxUv2QNU+8VfX/xBndcd7fUqfrW9klYjpK2g8JxOf1vF5xlYNLjQOYcINzuCcEyxdK47DkJemtrm1vOiXTG3syJBZd6r0R9+DTH0+ic0hsNnIlky//YQ6HHW+Ern989NDw/oWeg86cgxndw1SpCZ2uCkXMx+yPIqhg8MwaCEO+ugZeyy5W2uWO0xmIA5MKDTv/HCg7mm9ZeQybKj8O0juHfSYzBIrF3g3p5/UFQR2Q0mvW3cszjHDDSZRUlo3259DftwnEyQfCAvKDvEzUCH0U+AZyreolgLUVRnhPph4o2nfhRA3PZwLNQ0u4w6qz0DIjv2NyO/bQd6iSxUXUj5Ss4vmx8XytAF2f+51hj4LviFU3vOO1AV87P6d8LRTtPSuB+oSqHzOJTgfzsrFvCfI+y960sEznjWAkFUWageGB7yh/bdqX0w3/sZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(66574015)(38100700002)(66556008)(8676002)(66476007)(66946007)(5660300002)(4326008)(316002)(33716001)(8936002)(186003)(2906002)(52116002)(83380400001)(508600001)(6486002)(6506007)(36916002)(6666004)(9686003)(6512007)(39026012)(48020200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?cTXVBZ9Z7leOG59VCnkAP/MkRwABdzu93PA0MuigzyEvRcJZZ/AU89aQv7?=
 =?iso-8859-1?Q?yadt35ZFf793dbN3k6Z64sMSDg8pptWH/EsiVkiqELUPmvbiCbppBW89KV?=
 =?iso-8859-1?Q?GQk8q0hZYEWaMZFwTzdc8IA8ZrZYWSA14UICLo3gRqEtvDUtVnGOuUVdFE?=
 =?iso-8859-1?Q?ogM3Vv50oGu06yj2m7FDoIdjoqCd0/0P229IbqyJU6O0u7mGECSo5CEYbZ?=
 =?iso-8859-1?Q?MsvUdenM+4JOX4lpUc0RjphY29Dhb7iQgy7EgVFjprmKG0DWiqiuhWE1kf?=
 =?iso-8859-1?Q?4hNgl15r1bgVEk44MWEWfqUkatIWq1VoxEDCzeYhJME9BlKLQIiDb/Sh8I?=
 =?iso-8859-1?Q?NTjRdGN6utwBuhd2aV8CQIWbAA69jLwm1/tOEJbp/F+qk4f04V/gsZtHmK?=
 =?iso-8859-1?Q?NdGVWO/tXpi0WVdxs4wRFAxLMn63PrNIkUkf9+x8ss5+cc00ebaE2SZdia?=
 =?iso-8859-1?Q?LWU/t7BvJk0JZAxPmIVEhQyoff17okw3vx3D7CErjGE8Uxfy9BbHuD9hb8?=
 =?iso-8859-1?Q?E1ajOszf/bvyN8a+g19xbNrFDEYHIuc4a/TsrvpjB+JBda2gQlCyL3FPTe?=
 =?iso-8859-1?Q?DXkOe+v7kJvzalQoXhv82dK5pjOLD+V1jJaNbQoikXo6xPa/KIKvJtKk0j?=
 =?iso-8859-1?Q?CEMdVQs5ON50TgBU+/lXz/f0Oj/jmZXyKs7LeeQNJywEBfWfP9G87mM2v/?=
 =?iso-8859-1?Q?4mmtpaLXBrJJPOFPV0Wwq3XzshhtFryjcNS+lDZMRLlZhy4Xko1hF2eEpN?=
 =?iso-8859-1?Q?yiSLjs4ZB90lCI1o+3VTwC9A2OU4vZnrBNZdIfRgW09kuGTKq2E47kTL2K?=
 =?iso-8859-1?Q?39dYa6tnhbcahMbwdkBc8sy6DiaQLwwOncTy2ZiLkZjScSBMmu0OQtPykO?=
 =?iso-8859-1?Q?6H5aj6P0N5NTUrlOud3iasY9vASxCgt/PTMcILUBNc/8AxL6bE+zjYdJLH?=
 =?iso-8859-1?Q?k6e7j4xPYjdGv4B3YfFvRGpPoCaIus7KBGwM4Xp1fv85HTFADptPHYCoMu?=
 =?iso-8859-1?Q?5wNTZJu9d1n8pqJIEtxC8oDyGgcwsKkninl5D/z/keXh7HSUphJcmBLctN?=
 =?iso-8859-1?Q?PuynyRY9zyDSgtSmSTBdZoUU9HFZNyVBzgLN0p1ccJK3PfGXuNb2eVtj+q?=
 =?iso-8859-1?Q?INaL7OksZjKusrVPWsgWp57Bujlr3p/ybPjy2bfC7vQ44+REpqBf2XBM1H?=
 =?iso-8859-1?Q?ugYXtI+1sajX3hTisJK9XK0SIa73zzPAYcLAtO/DBwKAXarBMxYCZd+aYH?=
 =?iso-8859-1?Q?AW+pVWuJTpQS/PKhATg58+p3K7bKLjivcBPsjJd8ltvkvkl11wdXeGNEDz?=
 =?iso-8859-1?Q?nsOL8O4i8dzEs0fDyLEalsd+hj77bp+IqcOghEU5kCd1QoGXtB350trnjp?=
 =?iso-8859-1?Q?4kSc4/cRfdjfRjLn6O2MPxcrvfilT1VxSl8xuZExYfq9GnkLrJaEGRw//B?=
 =?iso-8859-1?Q?pT9NLrw6BIiVPanBZIu+kp929hp1qEdkw3CLoPcLxUk6yVOA8cztYGbjke?=
 =?iso-8859-1?Q?BTmAduBv/4kvPNTaOea++4jW9ETL8Y4Hqs74QVeykbgvNcA+FnxAxPWsII?=
 =?iso-8859-1?Q?uZLMqhXDqKoNaIVIOmKy13A9WhVDtgX/eSB7xL13+Mi7MFM0p5f4RSqvDA?=
 =?iso-8859-1?Q?SlzqhcaqmjyMjzuMYUPss5LsL4lCBCjv9mKlZQWUTq0jIo6C0iUFUV0e/G?=
 =?iso-8859-1?Q?PwLALA7wtFCC6xgAmh9ye0oAfhSNi2w1LwME23AV9QWdEk3NJekkiCkXU5?=
 =?iso-8859-1?Q?zllk1sCTvDqcUP2RUlsGRwD94=3D?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186bbfe7-4101-411a-32b5-08d9f950e72d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2022 17:53:32.3348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwx78NVgvBCTQAjab+O/R1+8v7jXW4YaQZLiVdOueixqrNJBsC819u5e/TsKEQ66L6GjIExPdgG6I8XsiPhUvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1869
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 February 2022 15:04:02 CET xkernel.wang@foxmail.com wrote:
>=20
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
>=20
> devm_kmalloc() returns a pointer to allocated memory on success, NULL
> on failure. While there is a memory allocation of devm_kmalloc()
> without proper check. It is better to check the return value of it to
> prevent wrong memory access.
> And I use the err label which is introduced by the previous patch to
> handle the error.
This last sentence is not very useful, but it is not a big deal.

Reviewed-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>


>=20
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
> Changelog
> v1->v2 update the description.
>  drivers/staging/wfx/main.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
> index 9ff69c5..85fcdc3 100644
> --- a/drivers/staging/wfx/main.c
> +++ b/drivers/staging/wfx/main.c
> @@ -294,6 +294,9 @@ struct wfx_dev *wfx_init_common(struct device *dev,
>         hw->wiphy->n_iface_combinations =3D ARRAY_SIZE(wfx_iface_combinat=
ions);
>         hw->wiphy->iface_combinations =3D wfx_iface_combinations;
>         hw->wiphy->bands[NL80211_BAND_2GHZ] =3D devm_kmalloc(dev, sizeof(=
wfx_band_2ghz), GFP_KERNEL);
> +       if (!hw->wiphy->bands[NL80211_BAND_2GHZ])
> +               goto err;
> +
>         // FIXME: also copy wfx_rates and wfx_2ghz_chantable
>         memcpy(hw->wiphy->bands[NL80211_BAND_2GHZ], &wfx_band_2ghz,
>                sizeof(wfx_band_2ghz));
> --
>=20

--=20
J=E9r=F4me Pouiller


