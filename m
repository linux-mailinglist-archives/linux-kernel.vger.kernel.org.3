Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420A84C44DF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbiBYMs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240719AbiBYMss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:48:48 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4342B715F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:48:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsJ7FU3ACMRkDxJjcnmBkwiNoR8f5lfjDn7ZT/ibUHoZabh28EREzMnSqkoiW+P4ZFceaLA6l8cO1QEucuM+D/aa23MN+v0myWliZ1HuDC84abPDYHWot18lqQW0fZ1ZQwueUTz0ZqnXpTN8T+Oz1cWvDLLCGYdKTpZoAV6utG75KamvysfoIAPrI/MtOTUk7LbDwn0qGwshV8/z29d41M6Q88A+90y49gPtubLvOdIoivLzc32fkFUSX/l3klWb0ConUDFLGs5siXoUkxfLqqnLGrGjO60pXu6I7tBenFk5w/2XtBjfVLYLnCItnD1kLNxEXVO9gwGcWts2mOskZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oo/L6xyE4sNVTPHFs3/iV1h1+9WlSfFFgKQbQ6IVHRU=;
 b=ZtwgifSX3zRhFre4DZALciI0BGL6uouvY+KDif9cEvYlimTYgWZ7r3g8UCYIWN5ugA5rKm1UMLGZZJKBRApFDLlX+PcMfjUIQJQ8NYaNUgh/vyGhpVJOeNlrSBYBfb1AXr89RDtpnEIPWLFPTgEsQC5dHDDt0mVlANl7/GDB+nR8dlOKSmy/jm6E3pfsMwamC43mZwjAFzZMTNu2Wb9pfg50DsycCUm+ni1NuUzXxDBy9izZ8m2n0FuzoCscYP5iqIRiQosNBdFSm7qnWR1W8LATRR7LObWgImFpfl8kNDN1J1dVUIwax2FVOd/YdndzpctMuWzt/R793uLn1D/v0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oo/L6xyE4sNVTPHFs3/iV1h1+9WlSfFFgKQbQ6IVHRU=;
 b=fi3M9luOzfXJDq9vLJvNitOFmtSQ2EiTz/S+q7ZGVGBfKIjt+9g9Rg/7rxy9fDeVvzxh4B13B6BezDURBq8fLJiO5JiDU7DZuahWyyLobXPO0VSqOKmpxpiF8vgaZ6qPQC+MczcBGWRYBuwh71qL3jUKQzC0orzqcOqCoPb/bLo=
Received: from PH0PR05MB8448.namprd05.prod.outlook.com (2603:10b6:510:cb::13)
 by BN7PR05MB4241.namprd05.prod.outlook.com (2603:10b6:406:f9::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Fri, 25 Feb
 2022 12:48:12 +0000
Received: from PH0PR05MB8448.namprd05.prod.outlook.com
 ([fe80::c1a1:14a1:5e4a:eef9]) by PH0PR05MB8448.namprd05.prod.outlook.com
 ([fe80::c1a1:14a1:5e4a:eef9%7]) with mapi id 15.20.5038.010; Fri, 25 Feb 2022
 12:48:09 +0000
From:   Manikandan Jagatheesan <mjagatheesan@vmware.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "ziy@nvidia.com" <ziy@nvidia.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "brouer@redhat.com" <brouer@redhat.com>,
        Rajender M <manir@vmware.com>,
        Abdul Anshad Azeez <aazees@vmware.com>,
        Yiu Cho Lau <lauyiuch@vmware.com>
Subject: [Linux Kernel 5.14 GA] ESXi Performance degradation
Thread-Topic: [Linux Kernel 5.14 GA] ESXi Performance degradation
Thread-Index: AQHYKkS3N5R2MwJAXkCkEhtVXDbvAg==
Date:   Fri, 25 Feb 2022 12:48:09 +0000
Message-ID: <PH0PR05MB8448FF2F53343CAA8AF2DD09AF3E9@PH0PR05MB8448.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: cad46eef-e88d-48c5-6582-dfdaa6c04493
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 722c6036-fb50-4220-d85f-08d9f85d13b5
x-ms-traffictypediagnostic: BN7PR05MB4241:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BN7PR05MB4241F05979C8F4BFD090B325AF3E9@BN7PR05MB4241.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HSZvcbXnQGpsJh3yFcnOPZldRkXo2gdPYfrGeUFol7CIF3bDwm9mdM0w+iHSe1cmQ4Xsxt8Gzezobm/EAxYDeL24ilzPnXTwLfwa8Tc9F9eap6rAGYSs3H28CLqQfADzdPvYg2Tv0uVGfnaMc6tHJacJmDZ++56OS5JiwuKleauOzj0qqE6OjuG5CGzESa8gudKqM1fQtb3Xn4Y12vqvR7qaYoliUfBoNGACb/RPfk5YrYad8A1J9Kc6DIzjCttJqWvHo/wKLkL84sKbXGCYv06NhLlL6/z502dyRZdGn2H4LWWVcAe8YFXJFX3hXVN16Jnx9OOpf7ZngybhkV5yhjXEIuH8Kv6Mis8ktwXWYoIJAdD0CHvOZlEn6blaeTNI8EELWKrOXq6Q567leEs3dKB37OA2Ji6ZZ1aLlxOw/IvZ9oVanElmdwtfDG59hAYa6zW7T76T0hGOqi2w3Jr9Jys/Qk0Sqa+mrkmcdhd1JCa2wjy9ewPtlQGc8vE5HxmOpLKbNENcyNLJtNtChaJbP4Va8sdL4eKWOBe25bR0RF2D/9byxVN5asUhhM5WbWyWhU0BkqS9IQD3BUupdmldto48PYTL4OeJrm3KEu4qlOn/D8mSne08/4kkUwzVo+BdVyY/dY4CSJzVC4I0uAH/QrOjoGmZo1BsgglwrWJSMb5SgwYoIDdgmntwqvZt6Gruf0L6EO0IBK3Xwyrh9xCHrH8r9T/E/IAkwppcEvaSTlsJQK7Zq5FNfGMJvRNu6slefXkMtq/OS4/VqNLXVytzglCDz/M95mtyAlg069qEfcitvgzaatIgpLhHixb3mJ6Brm6RAPW24rZMBOw8TxyIAPjpKxw26upUv899Ar8qMoN5niqk+gYsAFw/laDvGmcKi4zJgzwy5bg2RTUvCt3eRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8448.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(66556008)(66476007)(66946007)(966005)(83380400001)(5660300002)(8676002)(8936002)(316002)(52536014)(508600001)(4326008)(38070700005)(71200400001)(55016003)(84970400001)(9686003)(26005)(91956017)(186003)(33656002)(76116006)(86362001)(38100700002)(122000001)(110136005)(107886003)(54906003)(64756008)(6506007)(7696005)(2906002)(334744004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?tyc04XRPO2AeokrgdJdb42TjL37kE3JsYVGiwQKYsCvt8YaS+r7HsuYV?=
 =?Windows-1252?Q?BZnvdrh8U9/6OXOnl1jUB53/GYhm4DHoZM2/1NSM2jIzADg+dvo8kucu?=
 =?Windows-1252?Q?si25Vm+0GP1VnvTOGJk+UvSzFZLxyfymyL+5pcRxgCzm2Uq1aXpPVVl6?=
 =?Windows-1252?Q?ayYLKU6c8OWbgmpE+ISQd6eEB0XhD9hIcNbUfmJ8EjoEKbLwWtecaLzB?=
 =?Windows-1252?Q?YMmEviinZDGgWJKInUXk+mViPEdb7WVVGeQgoDAg0rTIL6B13Lzm9Gej?=
 =?Windows-1252?Q?z+vqwMTR+jBW2IhNIkgcxqUmsxUZjuWEd0Mn3mXxeFFf4j+OIQ18eZYW?=
 =?Windows-1252?Q?hiETcsIpZi6vvluXtcM8kdYGq03IqCn4nqM5roTEOUAn1tPkZcJmqLHI?=
 =?Windows-1252?Q?6dpOxP++jWHwTLbKl+KmP62eCdt0c6xU3LpT0+jSdJLaQOXCkv1wPxxx?=
 =?Windows-1252?Q?HrV9EYtnKrP1FX23ptMPuSMmj6m9DEqv/ru1tstrTDhcjGfQt5nybuQ2?=
 =?Windows-1252?Q?71EXISxyRgqdkR3OrkyFzmvZfLP2Jb2ArCfC1BamZI+erkI924GThbzp?=
 =?Windows-1252?Q?WpiDU7sjJd7bR0On9RKNR62rQIQ+4G3SyQaRDSwBq6n8Z1vPczs3tXlb?=
 =?Windows-1252?Q?k/RFyl/AYhmUAChmora9RCiqij9LWf2zLiZGcQGgDMPImwWcSpaN9b0t?=
 =?Windows-1252?Q?wzbvKQv1Pjc0L47Yveyvr0WQ28PMlhxpJiAOrWasB5818wBmyb4q0eTV?=
 =?Windows-1252?Q?d7l7PqrxwVdXJd+D3fYBiuiw+URCvGmILSMDv9odSTVHPapmPrVNiUYP?=
 =?Windows-1252?Q?aqb2X/fVgkF8SnBgVS0BS4aJVxJob/4CYGy386R8NZvHaxyV7AsgHsBp?=
 =?Windows-1252?Q?KjqAmbm0IeWFomtibjdmC6voRGP07KVoR38Q+ZZH1uxVzTeZ+jTwf2fw?=
 =?Windows-1252?Q?SFwzm55IGwsby7fC6OApIE+jHadkZRF594Hyd4e9NZY7Wvhls10JXk01?=
 =?Windows-1252?Q?42xGYkXftVSC5dFpone9OR/rbs9mIxEw9VTLJCq4FbZKrO98enGhFD80?=
 =?Windows-1252?Q?ExUWmD426nEq4kRGw+rJluRXRT1GX8qsjwCmmsn1o29Nu4tN3lAHFhN4?=
 =?Windows-1252?Q?/EkS+VuSfRFrW1Y9PZZPk6D8syMROZscFaTBaPysw8dAoAk1JNOvsKN/?=
 =?Windows-1252?Q?QwBNB0v9UzFxiXYRrVG4TOxruG3KAJsMFr813LFCXZ0DsVrj1r0YK/6l?=
 =?Windows-1252?Q?6C2oumrpcHgFdEG3d4y7lIiweQKw8ftCh3l566VmoR47lyqd9lMyaXub?=
 =?Windows-1252?Q?lby5wguuyG1hL5Vyg/YeelXOIflTDwWvY/6Okt5UfFq6m0yE5rYd+8z6?=
 =?Windows-1252?Q?IWj4fd2F9dtXOJq86cImxYDQegkTJxw38yx2DB+3l2OElijaVRlr2kU7?=
 =?Windows-1252?Q?Zf7abr5zggO6BBZCaCGeNcnEskuiZK07jUZ8AYr0PmpRIfuHfcQddDS6?=
 =?Windows-1252?Q?0OISUgMbvDUvYUzmjPmlr1nQYjP6UDIS6t+J08B4mjwJNCHH3bQQeN8T?=
 =?Windows-1252?Q?GCvQqVz3NCnQ5iB8E3nGi6dbFci7ib6MFRE4jbpGB4i176pqQ93G/rSE?=
 =?Windows-1252?Q?SZ7v26IawEPMQfe9OWHmTYUGznI/yLA4cglKPPP5Me0kdfY7Xl95MF4U?=
 =?Windows-1252?Q?qeZAeVkJ/tAWtmWSaxXaQDP/6bfsigxpzsR7X/eQM6FuQa/1azkPfg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8448.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722c6036-fb50-4220-d85f-08d9f85d13b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 12:48:09.4739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s88uNoCyGXvn+jpASHG27VYtysi/ThTp+cKQp6hbtj+BdwPaq8gFL9f2f9cbWIbbdKJvjUbzqhY7Xv/sc5HmRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4241
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of VMware's performance regression testing for Linux=0A=
Kernel upstream releases, we have evaluated the performance =0A=
of Linux kernel 5.14 against the 5.13 release and would like =0A=
to share the below observation. We have noticed performance =0A=
degradation in ESXi Networking workloads up to 25% and ESXi =0A=
Storage workloads up to 5%. From ESXi Networking perspective,=0A=
we were able to notice performance degradation in Netperf =0A=
=93TCP_STREAM_RECV large packets=94 Throughput tests up to 25%. =0A=
In storage, we were able to notice performance degradation =0A=
only in CPU cost metric up to 5%. =0A=
=0A=
After performing the bisect between kernel 5.14 and 5.13, we =0A=
identified the root cause behavior to be a "memory allocation" =0A=
of Mel's commit "44042b4498728f4376e84bae1ac8016d146d850b =0A=
mm/page_alloc: allow high-order pages to be stored on the =0A=
per-cpu lists").=0A=
=0A=
To confirm this, we have backed out the above mentioned commit=0A=
from 5.14 & re-ran our tests and found that the performance was=0A=
on-par to 5.13 kernel. =0A=
=0A=
Immediate before commit: 43b02ba93b25b1caff7a3457fc5d005485e78da5=0A=
Mel's commit: 44042b4498728f4376e84bae1ac8016d146d850b=0A=
Mel=92s commit git URL:=0A=
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=0A=
linux.git/commit/?id=3D44042b4498728f4376e84bae1ac8016d146d850b=0A=
=0A=
To analyse the performance degradation further, we have collected=0A=
perf stats between Mel's commit & immediate before commit while =0A=
running the Netperf benchmark and observed high cache-misses in=0A=
Mel's commit when compared to immediate before commit. Please =0A=
find the perf-stats data when running netperf TCP_STREAM tests. =0A=
=0A=
Performance counter stats for 'system wide':=0A=
Immediate before commit:=0A=
cache-references - 5,343,078,363=0A=
cache-misses - 26,632,656 (0.498 % of all cache refs)=0A=
=0A=
Mel's commit:=0A=
cache-references - 4,930,300,091=0A=
cache-misses - 319,495,743 (6.480 % of all cache refs)=0A=
=0A=
We have synced-up with Mel offline and performed different =0A=
experiments requested by him. He identified the root cause =0A=
of the perf degradation and provided us a patch to validate. =0A=
We have validated his patch and confirmed that it fixes our =0A=
perf degradation and the perf #s are also on-par with kernel 5.13.=0A=
=0A=
Performance data: =0A=
TCP_STREAM_RECV Throughput: =0A=
Immediate before commit: 16.394 Gbps =0A=
Mel's commit: 15.465 Gbps =0A=
Mel's patch: 16.461 Gbps=0A=
=0A=
Patch URL: https://lore.kernel.org/all/=0A=
20220217002227.5739-1-mgorman@techsingularity.net/=0A=
=0A=
Since we have received a fix from Mel for the reported degradation=0A=
through offline, we wanted to document this in this community for =0A=
reference.=0A=
=0A=
Since we observe some performance degradation due to this commit=0A=
(44042b4498728f4376e84bae1ac8016d146d850b), could you please =0A=
backport this patch/fix to kernel 5.14 release.=0A=
=0A=
Manikandan Jagatheesan=0A=
Performance Engineering=0A=
VMware, Inc.=
