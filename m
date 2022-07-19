Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B815790E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbiGSCdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGSCdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:33:50 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E318E13F80
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 19:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFMfJYA/sGZ9ADlY2XFofyNpXJwNKC5ZqN5DDQGURrC1ycV+djNe2bnuFJW5Ugc+D6TYlYQSxmr8WTq38HPVHOF1BDg2IowBnlwMPy9zpWxgvSzyvLydOsaRNGNu+azrYPve9rM0SwLGTJfdcpBF+6TMAyAeeI5XdboaHLyBg2pAfMPcqlK+OOQSnn0WMyUV13iVg/LapXexRO8csK123CFhRPebFyVTTaCGGev2pCrkMgxHqI33cFv7QpkCT2KAxHcdNqW2Opj0RGIO0eZCORQ6XgS5TdQxXLJdVvAkPmSQ29nWcCc0wYdDz6xflL4TJ3fke/nzT8wD9obCnL9zfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZDICR3BI3v9SnKUxVd9AhJoqkK/FxyodFl4cRPBQ9Y=;
 b=JQXSPPh68oOVSXEBhqT3M7Nk4FtYGaQgvHW5kWImUFsLUgASzbmvy4xqCOSuWFr3bKB6hRDJjn5diSRvsV47WEbrsCt8vpip8soOsN2VTnI5eFAIFzKEYWqPEr7T8YfVXdtziIUfx5QfsuCFTvbWaSmFHqAEVo83aW9da4eD9/FB1OJ8nNPrIPU43KwCjJawIrK/jS/xYYcNVDKw6WeKIoyo6ocv7yfOFOP2AvjJeeY8/NMHnXLjVG/6aRgz74zlirpUTYGj9B14F8nuBzQFfTVzM4FzP90HVB71PfxJ8ZeypJjOxwrXM4ra19AQq712PNq7kbnO/hcQSyvh4M2BoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZDICR3BI3v9SnKUxVd9AhJoqkK/FxyodFl4cRPBQ9Y=;
 b=S+Oda3fjPgn+S2rnckf7o6y5YqAsRlUFwOlfH81lMPopAYxc5lEjLdlY0Z6zzeMmjTT1U3jYDHvOO4+Sg1/5ifmsjujnJ938P9QoSlbbduj02ASz+axGMYw+pi17sm+EWUu8I3My0/2vjAtBdE6YnjXaRFDQi7sDFCOBh+QDmQQ=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB1386.namprd12.prod.outlook.com (2603:10b6:3:77::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.17; Tue, 19 Jul 2022 02:33:46 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b554:38a0:aa8b:819d]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b554:38a0:aa8b:819d%7]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 02:33:46 +0000
From:   "Chen, Guchun" <Guchun.Chen@amd.com>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Christian_K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Subject: RE: Command "clinfo" causes BUG: kernel NULL pointer dereference,
 address: 0000000000000008 on driver amdgpu
Thread-Topic: Command "clinfo" causes BUG: kernel NULL pointer dereference,
 address: 0000000000000008 on driver amdgpu
Thread-Index: AQHYmwEiamA40GH5sEuth42sw7Ztoq2E+cjg
Date:   Tue, 19 Jul 2022 02:33:46 +0000
Message-ID: <DM5PR12MB24695F88092ADF033A2522E6F18F9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <CABXGCsPRrUoNtO4J8H8aLWRCGGZkwHqtOZV9Edamd2pXVB0ooA@mail.gmail.com>
In-Reply-To: <CABXGCsPRrUoNtO4J8H8aLWRCGGZkwHqtOZV9Edamd2pXVB0ooA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35c562fd-7e6e-492e-e8f0-08da692f1b22
x-ms-traffictypediagnostic: DM5PR12MB1386:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T0f8/M3t1HGDIl3h/MgcXUhiVcgU4qJZ0AbxllyX8gtIZmMzgq0m8x88RfzizLizKiRtUos36+Qd4H4yfWOX3Ga+M6nQ1IjHGqyhX5EgOLIDXZxENsUlM1mVZ4PAC6ku9/t9GXdxDUkDB1JDO8dlDBAsmAHJHa7xOGRv8p4Qh4OGsGOSJpeDkK3uOruO0u4PC3Re0M91GJvlL2p654db27mtb34WMZGAIiwqW96nkklLhzHIvGOL1nycdyGHIdGIqficJhjubcVvZJTijZGy4E1BHtWpZZNkIwityyd/VUN9uh7ZqiQxp+P4ENJS9MrWs9hEKHIJSNhyt0J7XZvFKQ0YAYhJeUaah1rm36V/CUQnIs0e4nXVMjet2K2LnJ/h07Z+yCIHgx8Z8TVS2izBqBS+WMD+qtdFQPPhg3ZPCbmNlq3qWxOgtl2UEuv1dKvSVi9aykt7Va9oul2sGyaLVPS/Q20N1Ek9qy/Losj/ppogvcIPnGljAy0ilc3TgyCTRFEGHRnx4KDPkv60c6FfMLB4SV9uasLbN/6Nn9E9xF84W76U22N7MqwXf659LfuoBuvSgn2Wvdz9fJmACQ2JP5hPlpdCaSEuHhZxZQxBrDzSu1Ax2UGZIb3erXg+FCmcH9scwMP59FLV7x3o3vtlx0eNjT2luh2SZxJZtX0w7Is/mn29lF5tA+dxeq41UL/SoXKqbgsJFSHHmtVZUgMTT7tjJmDq4dBaSsFg48YvT1SQUiVXQOymJavSV9OBdgzz6mmkG1DPv2g+df45vB9AK9Uu03yAzr0T3cFY1SCEGRreV4vQ/EGVkbv+shSz7oxcnLGT+3UmlCdAOOPVdjGlGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(2906002)(5660300002)(52536014)(33656002)(55016003)(8936002)(64756008)(316002)(66476007)(66446008)(110136005)(8676002)(45080400002)(76116006)(7696005)(186003)(66946007)(6506007)(122000001)(26005)(478600001)(41300700001)(71200400001)(966005)(86362001)(9686003)(66574015)(83380400001)(38100700002)(53546011)(66556008)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6L+5HJUgGO0TBdzwT38a4qw3KHWbz+UGxvNbA9wrVTzhHlpI7zbblT1Dv7?=
 =?iso-8859-1?Q?/lhiiePehPUYnE0G8zSNzfyWehz4jdFz+WfqwEl78mjU/Awp39i8+zkZGE?=
 =?iso-8859-1?Q?xoF1ye2Oc67A4o/zSvA5IwAKoaa5fG5sK65w8+jFV00xh8smHLM9wt0x1h?=
 =?iso-8859-1?Q?W+5xMF+o4MbX2rcMOPnUvPM/n6MCEyOvQzdGejW031EFdBw/2+ED5OR7rR?=
 =?iso-8859-1?Q?JLsenVvsszATBo+fCXxsGrC5cs+aGtiifxC0sHtSgzXFi74Rdg3bsFDi4K?=
 =?iso-8859-1?Q?icVU9AF9T9MsRetl8jGAQlcV8XXpNu+283vF0eq52XaZoXjScIOxfWVxBo?=
 =?iso-8859-1?Q?r8HFcOu/CZj+Tg7aNcHodRiEMHQAFcdJJtMABzeW19iwZPhbpr+LxHrmc7?=
 =?iso-8859-1?Q?gNJ/G3mFtRzQIkbgpbdb1tgaps+NPPY9rQpz3mQ9x28fd1LGO4RezzptPq?=
 =?iso-8859-1?Q?MKIPApoQ4m0qrqDa+3euGpHA0GtIimMLFYAET9YLtBK7AvVQe7ZTWoTbuE?=
 =?iso-8859-1?Q?fAX5hzOZNF5lxtj5e5qaHe5AF69t9LK7k29CV1u3Zly7EzHsuXxkuPj283?=
 =?iso-8859-1?Q?pbnRFhDBJD++UANfrEl76IPYbOq1OKHKwz14+MLZJM2G1e8SNgHPpln9zM?=
 =?iso-8859-1?Q?7veJ6Yny4yIyjKN0PR8XvNcFjZLCYIHJS24h1W9pvkQwQ8v3SYgqG5tpM6?=
 =?iso-8859-1?Q?IFVyDxedeC85OblkRllrfqHsYfGLVsS1wl5sk/yTASTRvJ2lzGNIS+F8sY?=
 =?iso-8859-1?Q?kSPlm9q6mFhbXXqcCfkTYlZmxG0BsByVXCeimx+pN/S52NTsF1pqJftpMc?=
 =?iso-8859-1?Q?7irDcCrp/51xg33ZtZL7nPoKhWTK1585shPJlH0K8/qbsh/drLFSoVpxmP?=
 =?iso-8859-1?Q?5nbQ3cLyB1ImYTaywfHJuuYBMRqQ8sH2th9LyQZTGVnR0N4Kb0ZnY1fEq6?=
 =?iso-8859-1?Q?IPNYWbXGHZ/U6YsrIdvh+7l6E2bm+PCAE0PVAomhAGruHAO4SfWvSDxzpD?=
 =?iso-8859-1?Q?IjisA6MewHghmZrlLCxBfAsf07SW9cL4FbZiEa3/gKtNS60aQfT8spalMF?=
 =?iso-8859-1?Q?OhVCK2KbFGuV90KhfQzQd4q9ifHNkxfkgZsho9CJenT0GjlPIHYVIxmKiR?=
 =?iso-8859-1?Q?A5VyixSkksbTatdm6q5CHQllRl8S+Q4EessyvLwDxjbI2CdqhVThNsX0/g?=
 =?iso-8859-1?Q?vOcQ3lZJogQC24RZs/MptO7ANPm2zZeUY1mnMSGnUJdmMouwtF8TLW1AA7?=
 =?iso-8859-1?Q?a39YkzD7GIZPVTs2LY4hFyf8a5A1iL11s4W7ePXeg+BCq0YzzirkvuzzRf?=
 =?iso-8859-1?Q?U8N1Th4hlUI/33RyRTirj1accZUYk7zjaEHHteZJ5FvMQa692aiYG+VqiR?=
 =?iso-8859-1?Q?YtgX2dyDgPSt1gOt92nN7wzzztwkmP7iIaW8cNAQw37MG+35zUoOrvgrIt?=
 =?iso-8859-1?Q?vL2TytRSYgPcIHOKhrGI9xym1J57WMdB/m7nHNW9shATTMxW/3veY1O2Z6?=
 =?iso-8859-1?Q?O7QTE8OA2z0epOxX/QIBBBCwKQX9IvjbT/a11HT7Wq3ssa6kqP4LhS6LQL?=
 =?iso-8859-1?Q?RYRBvqM5tlH284EIwO18GualSMJ5vxfPi+mXbQFKSedULFLnJNPq+7fy4n?=
 =?iso-8859-1?Q?APlIPV87d/e5XCR6iTTaOjVD1itqYzbVzR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c562fd-7e6e-492e-e8f0-08da692f1b22
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 02:33:46.5686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EbaqxGlrgbzinYX7OoegBxD7LOk6OFBlX+bXxOseWYimWKR7xy2gJAtmLRkAxhQYZDhjS18URzaweNzxBuDPJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1386
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch https://patchwork.freedesktop.org/series/106024/ should fix this.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mikhail =
Gavrilov
Sent: Tuesday, July 19, 2022 7:50 AM
To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Linux List Kernel Mailing=
 <linux-kernel@vger.kernel.org>; Christian K=F6nig <ckoenig.leichtzumerken@=
gmail.com>
Subject: Command "clinfo" causes BUG: kernel NULL pointer dereference, addr=
ess: 0000000000000008 on driver amdgpu

Hi guys I continue testing 5.19 rc7 and found the bug.
Command "clinfo" causes BUG: kernel NULL pointer dereference, address:
0000000000000008 on driver amdgpu.

Here is trace:
[ 1320.203332] BUG: kernel NULL pointer dereference, address: 0000000000000=
008 [ 1320.203338] #PF: supervisor read access in kernel mode [ 1320.203340=
] #PF: error_code(0x0000) - not-present page [ 1320.203341] PGD 0 P4D 0 [ 1=
320.203344] Oops: 0000 [#1] PREEMPT SMP NOPTI [ 1320.203346] CPU: 5 PID: 12=
26 Comm: kworker/5:2 Tainted: G W L
-------- --- 5.19.0-0.rc7.53.fc37.x86_64+debug #1 [ 1320.203348] Hardware n=
ame: System manufacturer System Product Name/ROG STRIX X570-I GAMING, BIOS =
4403 04/27/2022 [ 1320.203350] Workqueue: events delayed_fput [ 1320.203354=
] RIP: 0010:dma_resv_add_fence+0x5a/0x2d0
[ 1320.203358] Code: 85 c0 0f 84 43 02 00 00 8d 50 01 09 c2 0f 88 47
02 00 00 8b 15 73 10 99 01 49 8d 45 70 48 89 44 24 10 85 d2 0f 85 05
02 00 00 <49> 8b 44 24 08 48 3d 80 93 53 97 0f 84 06 01 00 00 48 3d 20
93 53
[ 1320.203360] RSP: 0018:ffffaf4cc1adfc68 EFLAGS: 00010246 [ 1320.203362] R=
AX: ffff976660408208 RBX: ffff975f545f2000 RCX: 0000000000000000 [ 1320.203=
363] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff976660408198 [ 13=
20.203364] RBP: ffff976806f6e800 R08: 0000000000000000 R09: 000000000000000=
0 [ 1320.203366] R10: 0000000000000000 R11: 0000000000000001 R12: 000000000=
0000000 [ 1320.203367] R13: ffff976660408198 R14: ffff975f545f2000 R15: fff=
f976660408198 [ 1320.203368] FS: 0000000000000000(0000) GS:ffff976de1200000=
(0000)
knlGS:0000000000000000
[ 1320.203370] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [ 1320.2033=
71] CR2: 0000000000000008 CR3: 00000007fb31c000 CR4: 0000000000350ee0 [ 132=
0.203372] Call Trace:
[ 1320.203374] <TASK>
[ 1320.203378] amdgpu_amdkfd_gpuvm_destroy_cb+0x5d/0x1e0 [amdgpu] [ 1320.20=
3516] amdgpu_vm_fini+0x2f/0x4e0 [amdgpu] [ 1320.203625] ? mutex_destroy+0x2=
1/0x50 [ 1320.203629] amdgpu_driver_postclose_kms+0x1da/0x2b0 [amdgpu] [ 13=
20.203734] drm_file_free.part.0+0x20d/0x260 [ 1320.203738] drm_release+0x6a=
/0x120 [ 1320.203741] __fput+0xab/0x270 [ 1320.203743] delayed_fput+0x1f/0x=
30 [ 1320.203745] process_one_work+0x2a0/0x600 [ 1320.203749] worker_thread=
+0x4f/0x3a0 [ 1320.203751] ? process_one_work+0x600/0x600 [ 1320.203753] kt=
hread+0xf5/0x120 [ 1320.203755] ? kthread_complete_and_exit+0x20/0x20
[ 1320.203758] ret_from_fork+0x22/0x30
[ 1320.203764] </TASK>

Full kernel log is here:
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpastebi=
n.com%2FEeKh2LEr&amp;data=3D05%7C01%7Cguchun.chen%40amd.com%7C06749e19d65b4=
18748dc08da6918435f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6379378501=
84140997%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi=
I6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Dx1%2FR7m9Vy2XwkXKXsmEO=
eaAyv44ZKNsU4caZJOOSIvY%3D&amp;reserved=3D0

And one hour later after a lot of messages "BUG: workqueue lockup" GPU comp=
letely hung.

I will be glad to test patches that fix this bug.

--
Best Regards,
Mike Gavrilov.
