Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2AF5A7260
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiHaAZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiHaAZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:25:24 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E64C22535
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661905523; x=1693441523;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/YX059SSZAvTpWB5xK80qTuXYAtVAacu3j9sElhzphY=;
  b=oUaCxb9JuA9cMm2MgNv0cKStA86yKvaP7qe66e+/AfaJ4e+Ri72g7Dq5
   8LjsQgEtymyMAXwgbdsCDj4Osr+opK+Z9/IZ+jLDVm0KSI78q4wEAlRQB
   UqhIo0qEEhsg5GwRX76xYiTXlWXgqEgcJZaiM1lsT4GBvpnnsO7lbBUsE
   Q4q+g2upqiRHTb1RIbASL+q599aL2Wx5vZ7FVQjACMIgjEzibY4DBxzzy
   +NezA7vRwXjB5sdB7NaqTKkv8rwQ5HDdo4OLDz6Iro7Sh+ZZjwDy3rI7Y
   dZp8t1GKBWv7x5Q+7j8VMEILF/Xxazsu//K5jtcw0ng0MQhAtAdOOdchJ
   A==;
X-IronPort-AV: E=Sophos;i="5.93,276,1654531200"; 
   d="scan'208";a="215241318"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2022 08:25:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2e6g+wX61WitBd/gBnsUIvxqIy8Ksoi7RgpyiWbcdS2iQ4wCbWU4AaizOZ6XBfWKZ1tlbtGStU1ic9JdsYMXtLqHrbZTf1iUyNth2fTUxmthAZQLc8WLtW3clGWUhOrqKMWJr7mVYz3P+mlY9YggN88jrmUZLBQxYp5r83BD4W2msgSmunnjlb6Yq3AHi/R2rvVPfB3+/l3n4lsipfqjt2qEANkub5vWOkp9pMmGh3gbIfp8QjzoUJLpWDBpMPSjBHmm00W/N6fcu0L0BINmGf1W0/tn26n+Q1/DjZXxDlU6jHDDKQxXwo+2tKOPpn4VlOhYtTDLlqF+v2VKBtcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOc/dxT+GjOWsOiciBjTfvFJ0/thmvuE6erV5ZAVuss=;
 b=LDSiBjLv16ElLm2RS+KYRd7C+mHNkPV4ly2qyPFJVHj98upEK3BYUtKhlRf192P9Ifegw36AzqjweIFXi/9buP5jI6vkvAbVLKtr2PB1RIjveeCJOZiFvOKYFiY2ON+JavsjPFnYtQpQjE2XuGn+BrtbxSTOAjWOb8ydD/fjlI/x899VHjLme9mi7Yw6q6X/fBOpVsXQpN8rdIDMncoNleMlzb5j7UE5Mjs/uwO5RMEmgFvVzX/2GnwmS+BtHVTyMgGzADrvRBAMWPJyjU//78MSZkD+h22FwEnILjty+dICS9GDDo3kd4cD5qUU6g0tfd+owiE3yvf4FIUJ8cgMRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOc/dxT+GjOWsOiciBjTfvFJ0/thmvuE6erV5ZAVuss=;
 b=wlZGtu3ptIqyxIzEZrkxHMiY5KbZw7GBKThewnVM+j/eAUDYgVEpV2k0aREvueiJQnqqBWZ3H+3NLOSmChlYFniaxt9wK2LR5OjMyrpF4BCW/V0kBTiR7ZYuZCzGR4h0cSh181Q1xmoXQtA43UcAwkOJxidyBxW0AxQUV5DQz5g=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BY5PR04MB6486.namprd04.prod.outlook.com (2603:10b6:a03:1d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 00:25:21 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7412:af67:635c:c0a9]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7412:af67:635c:c0a9%5]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 00:25:20 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] x86/mm: disable instrumentations of mm/pgprot.c
Thread-Topic: [PATCH] x86/mm: disable instrumentations of mm/pgprot.c
Thread-Index: AQHYt5Z2kef1viI8JUehS9q9jOvbzq3IMSAA
Date:   Wed, 31 Aug 2022 00:25:20 +0000
Message-ID: <20220831002520.czdegytklq7xudnr@naota-xeon>
References: <20220824084726.2174758-1-naohiro.aota@wdc.com>
In-Reply-To: <20220824084726.2174758-1-naohiro.aota@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e43a5717-0961-46f2-4133-08da8ae749f9
x-ms-traffictypediagnostic: BY5PR04MB6486:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wbmD6eJetq5TS5HzOmWh/7Y9hPwQYCPnGFIOIusHbouNfemZGd/NyX/XTZszxUUUU/aETcRZjm3bh4NDb9tMsejc3+YnaC3G0XM7yfu2cw1GILdugXLt4qx0gN0OPq0SZoNFu+eJQxyhK871zDo/IollB5huexl8NaXEK3snEmCsPOyjujzPM30/LSclQKmRzzRG7auVADcDLYZmYuqVtIMB8I8UqN1erL2ms3l1091QBqzehPIPQ/DyWCji8YeQWCX2yQEjgFeMDwcMELwUHPNlAb5ltH5hAxHDzMwF7htyhsb7WiJzlc1gSX1dyKFT+SL7xcR0Q0Tcmeh9RnWU/+mu8DKybZ6ppy55je/3Icm7kUv8ZUsGw5DEaKkzAfH4rSm/WGiQg8aMBDc/yNraYHaaJZwEhsFg6Yl558eWHeMM5kqdSaaTBByL+zbWk4d+ybYTT9ss32ipds5VvlgAD2CFqq5HT984EtA96KG7x99P7rO2KY0s1uvgeSvF4I13iRtGUayRm/JJymUX1fPM/RBsWWU0uHv4Z9oDKMBWzfgm8m35+Y9WmZoQZWx4mLGL+cTsWt24nePMxpbhY7bDFvq7dQLVl3hsuLXu6BjRWY0iVVlGrF3ReD2bV8Imyhj3jrjLUPBJP1fu2TByUM3rJCowOakJmn+bx6BcjiSfvGQRiGvCF5kEVVLjWdeiYbfrP6g1FoLxkLCkY3tNc/QCeY8nWvw++8Dr8sXB1LFseANaW+8HYI4ljwEkR6HjSw+YjtCIAI6VJFNYHdGP0FZyEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(376002)(136003)(346002)(396003)(366004)(6506007)(6512007)(478600001)(41300700001)(71200400001)(6486002)(26005)(83380400001)(1076003)(9686003)(186003)(8936002)(2906002)(5660300002)(54906003)(33716001)(7416002)(110136005)(76116006)(316002)(66446008)(66946007)(66556008)(4326008)(66476007)(8676002)(64756008)(122000001)(82960400001)(86362001)(38070700005)(38100700002)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SfaU/LIxG2BXc6jMJcltcdKJMyysvwzzGe1Rc4Ju/DfwI8fLLLmwGfHB15V0?=
 =?us-ascii?Q?eVPQLeAx5zdA/HPiGkne/N/h9/ZVW1ntwriJEP2HArm58FPjvgmp5TSvJrFy?=
 =?us-ascii?Q?Hj4T+iDz/ufIlzXlakQedLvESYuWPCEMs+ThYdSmQ9BC10TtAbBj9hWKoHTa?=
 =?us-ascii?Q?i2dGTTu3HFtDmi7jbBxsbhIsfVB6P9Yio3vX8Bju4tp8SJBsMdFLQ9Vue7+J?=
 =?us-ascii?Q?eTundpdWMXh4DASOScKdlTlwpaFPIXOGitcuZ5O2SnARo8HmZ1pEJ4dNPQKT?=
 =?us-ascii?Q?NNJSC/O879bhZyhzrq0QnOIQrPNTzkNc8U3TMw8rWzGwgaR1Ahc3/myCA3oB?=
 =?us-ascii?Q?LGJPYx3KZvml7aFcfgvcMfe4yqHslVT+zk8EsLI6eo3/rj6PbeFoP6i/bT36?=
 =?us-ascii?Q?qVc7bi5PqomMxoVgh/EHrMkbl+vsA2XZgsnJCov+hNWcvrsuDg6XZrZ7YNYu?=
 =?us-ascii?Q?L3v+/2UtBA403P4vJnYqvzgJGApKKXiaP72ahHhrfW93F3xwAJhJo0D/J3KC?=
 =?us-ascii?Q?d8xx4JWU8Nd0eTXe+uLlLJt8bt2XnPBVcjw0/JIAjgsTwuaf8xasyRjP4aFu?=
 =?us-ascii?Q?3eHujNeO1uKx9U8Owa2jz2FMkLqecB8Dzt+cK6+cT7zc9elw4cmZGbT+4+ps?=
 =?us-ascii?Q?qNy9ynCG1oAp1EztsKGmMeXZdsGSUbxrF3zav1cFWE3OUpNU9ojT6UFRnr8t?=
 =?us-ascii?Q?W/fGlhfFmK86f4SJlw7ZRPFNt2imXyV2A5dJhQrypQqN2KNgrCUY8r1NcZLm?=
 =?us-ascii?Q?3S5JqT6jzubmf/8TbByb2awGoiLm6X2tlGkSzE5ViEOMR71wghJVlWmKVBAS?=
 =?us-ascii?Q?VGR8IvLIjvOL7BOq4ubQEsfJA8ebnCC0/G3dE9GVp97QxuIkZEnl39ZEAVNY?=
 =?us-ascii?Q?vDZ1SrvSjnu9OdRZFzRIvAIcJOJC1jqqf2ko7jIpUkwpKa8v7tMC/lnWFnvd?=
 =?us-ascii?Q?KEDmCgEPkPPYJ6u6/e47HtZQ0l7eRVuFtsRHsd7CaLvEhj/sNY5Ykzk94d28?=
 =?us-ascii?Q?K3U52ArhdGgcLpKu6DspbgjCrsYvoWccUw/w5pp3G8HtbtKhHHpkMHUq3BHP?=
 =?us-ascii?Q?6w1z4xWI2rHdI4T7WFUcHvWKyFdD8UQ9v2ZpifwQfx0z6adVIFOm4ffvqvdT?=
 =?us-ascii?Q?ugpJBGUGGFfommrNrsY3rVYZexZOo48Tk60Emcz23DoZE0vZOxhr/nl99RF5?=
 =?us-ascii?Q?E75v/A0jcmcR+DRWizHSfJyc/d86zPzjiQ0pgBAMgnjrJNtUgA5hH7sre16k?=
 =?us-ascii?Q?RYkSDAzFsvBEFqIgrzfrHYSbQSG4S+iuIC0HDKdJdmyeEZYxUjv8Mq5n/CkU?=
 =?us-ascii?Q?U2BKw/LVUayZer9+mHzm830eZ2fm5Cy9B70FwMmALIyKgIGuY6viyLgpeDjM?=
 =?us-ascii?Q?84kPLoY+jS3s3ZUC1CMvq3ONL4r/34OOD/0ceRbDfrxH/6hc4ANbF6MkQQJV?=
 =?us-ascii?Q?fRe7y1/mSgSjGMuNFRtGworMwGPxejHF4iwvAiQDwfmThDnajA9//vGxaO6d?=
 =?us-ascii?Q?6Nm+bUO8IwCcArQ7ZCFzKvcBKgN2ilDkqDHePpVhXR7FnN7/btMW3Dh7KvYb?=
 =?us-ascii?Q?QdbRR3l2/JfeJbl8znjZO76aWCRwZFEJC3BIdaMQnJxUF0xMd/IR3all5GgR?=
 =?us-ascii?Q?Xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F60745089FD96B458216DD4613928436@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43a5717-0961-46f2-4133-08da8ae749f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 00:25:20.9183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0qi1Q19vVS05bT7VWbC5dRLojdI+SeSv70bGNVW6OFLFTN66vjrmjslFGveh5TR6b1kQThwCz4lsKRVtgk9y6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6486
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 05:47:26PM +0900, Naohiro Aota wrote:
> The commit 4867fbbdd6b3 ("x86/mm: move protection_map[] inside the
> platform") moved accesses to protection_map[] from mem_encrypt_amd.c to
> pgprot.c. As a result, the accesses are now targets of KASAN (and other
> instrumentations), leading to the crash during the boot process.
>=20
> Disable the instrumentations for pgprot.c like commit 67bb8e999e0a
> ("x86/mm: Disable various instrumentations of mm/mem_encrypt.c and
> mm/tlb.c").
>=20
> Before this patch, my AMD machine cannot boot since v6.0-rc1 with KASAN
> enabled, without anything printed. After the change, it successfully boot=
s
> up.
>=20
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  arch/x86/mm/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
> index f8220fd2c169..829c1409ffbd 100644
> --- a/arch/x86/mm/Makefile
> +++ b/arch/x86/mm/Makefile
> @@ -4,10 +4,12 @@ KCOV_INSTRUMENT_tlb.o			:=3D n
>  KCOV_INSTRUMENT_mem_encrypt.o		:=3D n
>  KCOV_INSTRUMENT_mem_encrypt_amd.o	:=3D n
>  KCOV_INSTRUMENT_mem_encrypt_identity.o	:=3D n
> +KCOV_INSTRUMENT_pgprot.o		:=3D n
> =20
>  KASAN_SANITIZE_mem_encrypt.o		:=3D n
>  KASAN_SANITIZE_mem_encrypt_amd.o	:=3D n
>  KASAN_SANITIZE_mem_encrypt_identity.o	:=3D n
> +KASAN_SANITIZE_pgprot.o		:=3D n
> =20
>  # Disable KCSAN entirely, because otherwise we get warnings that some fu=
nctions
>  # reference __initdata sections.
> @@ -17,6 +19,7 @@ ifdef CONFIG_FUNCTION_TRACER
>  CFLAGS_REMOVE_mem_encrypt.o		=3D -pg
>  CFLAGS_REMOVE_mem_encrypt_amd.o		=3D -pg
>  CFLAGS_REMOVE_mem_encrypt_identity.o	=3D -pg
> +CFLAGS_REMOVE_pgprot.o			=3D -pg
>  endif
> =20
>  obj-y				:=3D  init.o init_$(BITS).o fault.o ioremap.o extable.o mmap.o =
\
> --=20
> 2.37.2
>=20

Hello, maintainers.

Gentle ping on this patch. I need this patch to boot up my AMD machine with
KASAN enabled.=
