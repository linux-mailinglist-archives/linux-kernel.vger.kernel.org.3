Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0AF572A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 02:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiGMAdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 20:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGMAdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 20:33:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BDC8CC91
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 17:33:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXHaelqa9WpHLcqrOTlZAr60dRr+RK+FqLOG616U3LFyOOJeqUFOFPPhzgyUOMQVdg+D9wKoqa6VqB4IgU7oPWTC+hcXTQljZL9kPH/ho+6QOQlF/vVrDL+37rBx9W/lj31wCdrBuSsvqR49SwWCP0q83/6uBlHL2kpExlliIE8mXRbmkInzMe/Hpa/bXG0N1FSiqtLs4JqeGc9qEU4VNe/K3MQ4IFuODEDzvGC7AxSOb6kZeinFOFIs1YaOq1A6fbOOjSdnfOXP/m5jeGMrI1Cxfd0s9tYG8QxqTSrh55Iz/voGiPwGN14/0OQgL/PwW0Yd8gTNDSN+i6m0mNKnyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTQbxnIZS/XtJOJX2eHa4KPNjg2AOQBDwiSZpUzG4vI=;
 b=Andgm+FC5bZn5J2XdeCoiSxbswUSNGkD9NkU6+cPId6gHDXmdwo8hla5USoMh4ZUdY1jWboPVw+LEs9wPOB56uGBx9Jr76YtB9fxJAv7XPojSpikqAPyrzpRxhg3ouWhFKflp7jYtl++tEwSXsoW/PPe/RkRpmw7+hg9OLYWhY5RFpPnZdW4DsWdJcFGDQ4UAmLveeVjv7ojVcxpEjupsMNzR1cWB+KKOD53tx/bU511fAIKtSWx7GbIpcOnnbi6rjt/ZQ6J4pLcriNrQ2sSPAovXiwPgg24+znteBvFVkWEEQfb6eegK2Mz3JKnKO96RhU0iBR5VUnIZyu924wz4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTQbxnIZS/XtJOJX2eHa4KPNjg2AOQBDwiSZpUzG4vI=;
 b=b2h/8YJGZSwgI3nTDVmgdcyfWjM/2LkaB5uU89OO1c5KX/aO4YbSsH0PJvRjB2PGQZuaGDPCu7wpmV5V0z5K3dcI8K//67zySyBjIS+UWhRnAqnNIuAW/66pJCJ4d6vJsop0ayb3327X92bg5MKVy06MHwjC+U3XKVEXh3zG0WQ=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DM6PR05MB7145.namprd05.prod.outlook.com (2603:10b6:5:200::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.11; Wed, 13 Jul
 2022 00:33:20 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%5]) with mapi id 15.20.5438.012; Wed, 13 Jul 2022
 00:33:20 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] x86/mm/tlb: ignore f->new_tlb_gen when zero
Thread-Topic: [PATCH v2] x86/mm/tlb: ignore f->new_tlb_gen when zero
Thread-Index: AQHYlPRIBVYGglwRp0y21cAEvAmJeq15cHiAgAIF64A=
Date:   Wed, 13 Jul 2022 00:33:19 +0000
Message-ID: <3DC1239B-FBE4-4EE0-B0D1-641B64697712@vmware.com>
References: <20220710232837.3618-1-namit@vmware.com>
 <7672923F-D439-4867-9418-B1F44EE5CC44@vmware.com>
In-Reply-To: <7672923F-D439-4867-9418-B1F44EE5CC44@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcc0a909-dfa4-4f25-6ea1-08da64674941
x-ms-traffictypediagnostic: DM6PR05MB7145:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KkIcQoHqq8oTYyVscH7HZcUcsBlbBm69OKP7J7AaXzNAwWEGt62v8KV9qVLc+MpaVLG+Hs6132GL0+G71fzp99mk+Sg/45IuzLUGLkaSrEXv33ksb9aOnMTcN2V5hJHgyXLcTtzOPoyHIutWePpAnQYSuWYkv+9lM7D6seWfEOzzK5Z6OC8B7b/9L24HaDR+wyQ3kYsgB6OXWR8lq+GHHoSGYXJvqQt19RdtFoccj3IlcKfEW+n7iZu54VeTUbapwd1pCV7rviLJ57X40AhYJmtikMqYVvIgLFUKiIIN7C1KH45N8DZdV3uKSPuFsXO043xz8MtlDjujUP7fsgVfmEc8YkbQi8EZ10wqkvd662E0bLO/+R34BSiX8O0tJhuHxFevVXFX0qi8od45WDI5CERHYJbyQPV8YqamJ73Lo9fXJD7YpDGe96ZXsk0z1AdfD5J3dcwb0Oe4Qw9k9P2dyuS2Yt3ESVOrAhaD7PcMOb2X57NthBC3jht7ftfURm++T1KSZCuUzxtnHm2jRrD9z2/dTog72kDRtFQgGg8fh/lnZhizZFM4iK5v4gDxDwjRkISiiV/Lh4yG7iRRF0zO/UmVXJXYgMWh2Ig3dipSGTH9/JYV0Khe7We5wPxe148s/rqJy2Lcb89D7HRiUiLJeEluzQ9k5LAaMf66TSessRDcgEhbThe/9uFInrbJ23SCXuew7VyVJqx5SMzDLeTO0OqZaWatAFCinpi3revZqtPBM6czfyuDRXSlGzVzN/mU4glXByJenHicVVeOkagNeNkvlHR2tWYc5+hqjVkUE+0CfmP8bTdXPhiQpUvsv894976DRuZACUUBS6Jr92LdgJDDxk7ESGUT8Qhu92V+VXs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(186003)(26005)(6506007)(2616005)(122000001)(6486002)(478600001)(53546011)(4744005)(6512007)(71200400001)(54906003)(110136005)(2906002)(86362001)(4326008)(5660300002)(64756008)(8676002)(66556008)(66446008)(38100700002)(33656002)(76116006)(66946007)(66476007)(41300700001)(316002)(8936002)(38070700005)(36756003)(7416002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?POabjnJ+coLpf/rOyZAotS6NLWIjCmsTxJ0cf6KTBsaLTFPI8AmJkVcZt/u4?=
 =?us-ascii?Q?MkU62X88XT9XiFFOljQiBYlHvovFykY1DorXUhezSdFQW87QUcNviGMsbrJr?=
 =?us-ascii?Q?rQ0ythCNE5SdSDjbhX/Ikq63T5OZ3AzIN8Vc43FkuRyQEXOwltEFwLvtNqkJ?=
 =?us-ascii?Q?87FjbuZsJLx5ZogMu7go4qyfLjXR6NRR4Yn+Ds94Ueb3ZCtIH5DDmojbSr0X?=
 =?us-ascii?Q?4jlktvsutKOPXSoO5BMaMOMW+xXU6tqPALZ4dXlCqOyNnwEpj9Bu1wyAR540?=
 =?us-ascii?Q?EuR6ePE1u5xz7hSFNzssNzYBOQPKH8sxcaK1CrESJlO79W9ge2fCFzPP9vcv?=
 =?us-ascii?Q?p2r99HHqVTu/PB0sxRHc3MXSHI/lJHe4oZvCXDkdGJ/WrtVY9rkPGLqF/h3a?=
 =?us-ascii?Q?lD8KqSbTq/YijSGq5fOPv3oAJCXQGS3JDZIeGPK+0aqmOiLMwK4I/R/IeN1J?=
 =?us-ascii?Q?d3U0vOk7ipRKF+xpPaWHL0wegomlJrKbCFni0NgMaaCMfijKooDHFfGqTfrA?=
 =?us-ascii?Q?1GrvGHIOFPVR0z7udN4X2qgLPfEOoJ0XHhYZk9UixP6ukWfpncJwfP3YVLTa?=
 =?us-ascii?Q?qdIc+Hhyc7J7N1/QuuV5P/96yD6Nv2i1ZExK+c/eyvSFh0Aa0Z2hpIn2jBZD?=
 =?us-ascii?Q?RG6STWalOKoRFNcwpW7WBzl8ovLGkyXgB3jalkl+cCn16ypsFvXHaLuWtVQt?=
 =?us-ascii?Q?ydfoFfvXl5T4xbh3rn/Q/dPG9zY4UTJPLfTBnHLkAyuGILh+OAeYlbZpW33e?=
 =?us-ascii?Q?n+6AS641rbWUi9FS+u67zv2OcwXDpAnJehSplJFawVqCrKdXEObQsROfGKUf?=
 =?us-ascii?Q?ECNGtDaqUzVyA9Bp9NEvCPX4MmSDBrtaWFcY6RzgUB+YGeOLnmDXATnYWsfI?=
 =?us-ascii?Q?sTLOgreQaft8idIj/Vds1MyKT1Xi6K/k3kG0+FEuzYrmUnN//anZaGRUicse?=
 =?us-ascii?Q?AWRrEpNmYWatOw0pSlvV1S97XfRIxDbrO+qAjBfGXM3GiLz7blppKDelD2zN?=
 =?us-ascii?Q?3VoaQtW4wePuVdhAjx4BwfbLHrXd0IRhAKVf7EROk+8QFnJr/5aJg6sTafWt?=
 =?us-ascii?Q?ch74J9+jycmaVTC4GXaebRxsjZbbT7ghmzs7Zk/4CaU1CrP9qpNYBOueldAb?=
 =?us-ascii?Q?cKjiKI3Na3ExgJ7kLjp8UkTWzOqWcY0uyrxOWlHTdjIi4KWHqDYeU10QSuBE?=
 =?us-ascii?Q?OP/6UAZVfPGLlj5f/IdfcJvmkjRrUfkxyvXCRaxUyqW204H4fPapLg3GwtsP?=
 =?us-ascii?Q?3SzR0WkI06JePZCFQsHl+LCWFEjV7R1LYeGfLLfb692oA5pKofMnECi74Koh?=
 =?us-ascii?Q?uOi7oU2x/Pm6e95qGCg+kq/+QnJA6IpbM9vSBA4sFM1XzfabyMdZ5We5yP8b?=
 =?us-ascii?Q?D6G1mXWdieJGkrEQAwOCc0WcMz9Rwu0m4CPe+U4YpmcUPOf/NtkOCbX2l/RY?=
 =?us-ascii?Q?GGWGrinB6wmeaNGoE4x1Vh6XLJImOznnIdIJzwmUFbrT1cIu6i3jD+HWRMyq?=
 =?us-ascii?Q?xV520krXLs5PZvV74NxavfPKMAehOjxLW00/aLIHZnaBWsOhbg3+vw3o8ZyB?=
 =?us-ascii?Q?6nE/CMGsrJq4H6Ln5IDg+FD1lH24pPD14swMdru8?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E75D2D5A27B67F45B73BB2D7D29E73B4@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc0a909-dfa4-4f25-6ea1-08da64674941
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 00:33:19.9468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +w59IHpDXi6uVolpTAGnS6nrEZiiyk461opJMqpsTmPRu9pRDZx3xaSWbSjZWt+asP8S9vyRRzDypPz2aYG1CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB7145
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 11, 2022, at 10:39 AM, Nadav Amit <namit@vmware.com> wrote:

> On Jul 10, 2022, at 4:28 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
>=20
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> Commit aa44284960d5 ("x86/mm/tlb: Avoid reading mm_tlb_gen when
>> possible") introduced an optimization of skipping the flush if the TLB
>> generation that is flushed (as provided in flush_tlb_info) was already
>> flushed.
>=20
> Dave,
>=20
> Can you please review this patch today?
>=20
> I feel bad (for a good reason) for breaking swap/migration.
>=20
> Thanks,
> Nadav

Ping?

As you know, this really must go into 5.19 or otherwise aa44284960d5
reverted.
