Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86034BC6E2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 09:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239666AbiBSIDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 03:03:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiBSIDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 03:03:13 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2095.outbound.protection.outlook.com [40.92.99.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2645675C
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 00:02:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNB67SInhc6/SOiEIN84f5HrZI46ZiTRnEg2sUhznjbeEKqlN8U1fQC2+Ybtg78c2HPSmZR8winmdKUULGQbiPWagLf0g8sNOiPQv8sw5RlprtkW0TR87W5yZdTzVV3nXV+fk9cwoJql3cE0FG4YBztH10PdiLnXiFySuaQ1+6DFmNHb8VPHAron5yvnLpJcL0gv0kQxPbVIRuGJlBJdGL2mHMBw0/d5K9PXc6LDSiLHV9rwxOXjCQ7UimFV1ZBYlNv0lmbaP+laeoFtdxHl5+hmEqP4GjeON9SdKe55uNC/EGSavJ40KPsfsAvgKyhWD3ee5B9AuxYhM1RxnW3/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6bs9hNPpRrWxzwGzn3o6fBsChAz86A9JPBrJa7H0uY=;
 b=NeTQ4MwgqIeVwJ3AILOsIm3OFwEuXDiX42lgRUJuClipABdVfdhwI76s1eJcNBvqJ2XUaNn7/WYkoKXVPC3GzLSOg5bV64R8vZbBUqdFvK/K7wTfl7L50kXtrALSbkgYA+zQ98LNpg9jYghh7UYDNANEhOxWGgaPk/YskJ1tW8fF7I1HLuK50AH4tvUozyAc4g/O2uOUT38lsvmec+MM/80qzaUKVjG9j0akrezSJC/8u+FuTmxwAFsS8I11rcYG4naZrzZ7qCysCMYCWOp6lO9/F0Qiw+p8igvedSwycSVkt7eJRre0ymS3ytpPDJIn2NSYRdqKrRg7i+lg9wr/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11e::14)
 by TYBP286MB0062.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8021::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Sat, 19 Feb
 2022 08:02:51 +0000
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::41d6:4a04:e5c9:86a6]) by TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::41d6:4a04:e5c9:86a6%5]) with mapi id 15.20.4995.024; Sat, 19 Feb 2022
 08:02:51 +0000
From:   Oscar Shiang <oscar0225@livemail.tw>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v11 00/13] extensible prctl task isolation interface and vmstat sync
Date:   Sat, 19 Feb 2022 16:02:10 +0800
Message-ID: <TYCP286MB19133894C3D15F11A9DB62A9A1389@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220204173537.429902988@fedora.localdomain>
References: <20220204173537.429902988@fedora.localdomain>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [lbhfPHQc3AL+L1SkSMRNKOo+MsCf/pQj]
X-ClientProxiedBy: HK2PR04CA0056.apcprd04.prod.outlook.com
 (2603:1096:202:14::24) To TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:11e::14)
X-Microsoft-Original-Message-ID: <20220219080210.75774-1-oscar0225@livemail.tw>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df6c097d-bcd2-4e74-5dbc-08d9f37e3986
X-MS-TrafficTypeDiagnostic: TYBP286MB0062:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E5ySZlvZjwTLzbqO1HWSuPrEVKLGMjIC0dlAMzMT+OkWP8y9W9uC3fgd/72xAQxLILe7YYOMgzkKbVnfD1setAxofLueKBvTcD+W/n0L9itGIEI+uNPFubLJPJ3e4sRKSBGYr8ufMOhxGdD8gU0vi0wG4yumwvHQl4RkZZ0y2ChLukC6Q0lHEKADWBSVFePfgtkUkFfXhNyPSGfVJGHOcI3akqf+1wvlJFjMgWpVAZktizFh52i6aYG440vbup7p28SLKcZaTfae/mlZrCtsTdLsrbiLS5QscVnQry7CGFId8Tfu6nCF+QnTRkeQPmd+QErjWrv5tAr5NCQpP4PZKjFKsP+5HQbzluXh68VJ+uGJgLV0wjb2cntoB1nqvjKRjr3koP0ef0h/6XarBLbOdBSlpAncuElyen21kS/mnmgHnQ5iPsGLefABNhf/yPvDYcAvi+k1pc5zQmcHR5WSOPVFFCXDzJEoKUsmNYn9DxdBo6IFaT9R/trATMs5q/fxCrpm3o8BZ2ZdLL3qYomS3hjE7dXS/fLq3eFmv85XlejifB6p94Cyi+L6nCTnCFUodmYIXndU5fKWinF2iyAxOjuZskhD2UHTOIcJ5Sk4v1jWVrRUoN0UQY913PbAVbsy
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IZdKkkYgiwozQWmrkH4aHB9f0lTBc/lozM3iC0UsSvc1omGk4gE+Sko5ZOJO?=
 =?us-ascii?Q?Ip4d6y/1qqgjkpy9WNwctIAQ0Vk9jbJ+JM1rVJ7qcHtMjpAmFgLW0D1yjVvQ?=
 =?us-ascii?Q?IUw4H3zqwrTtS/kDjzvtA18qvdC5ir800mDi9INUi7YQGTCNK13Vz6/LtKaZ?=
 =?us-ascii?Q?aYFlCArGn7zIejmzkN83vgD8AvQnu3YqlIceVg3SlpbQff2FILH7m7BITnx2?=
 =?us-ascii?Q?slfv14Lr7EcATymRIIJB80Ibmk55i0uIAI2Hncs46mgWW6UB6UsT1Yuvhq/t?=
 =?us-ascii?Q?rRTYPoBDm4qh+FwuRm5ntMKLt085Y0tCLfWSLZzS6MosxzZVMeK3e02qL5xp?=
 =?us-ascii?Q?N3ye2z/9iWuvExCJl/Y4EWoMi/BdVJGO3hc1GLXvo0npwJ4bK+Xd0pNPZDsA?=
 =?us-ascii?Q?8dQPHT0ZUKS7u56HiAuOGkDbdbor/uPDD3wraSQsCZIATzSSPZjH4zyoPwZZ?=
 =?us-ascii?Q?xzutn/trp2ltiIurOClO2Y4SxAU+Gl3U2jIBbdLNHi0nO2e/YQ6qEUdqCtCM?=
 =?us-ascii?Q?t1w9vPNwqkz6qtBVhgejRah4mr9d0QlkfJj+t2YPyax032pB9dMK0/Fq6rXe?=
 =?us-ascii?Q?B9ty4CHhTQXqTBoA6IjjBZ5clY26NsBm2DtaK6CuYQaJBrksS0ZKtG8289FH?=
 =?us-ascii?Q?MnAstroleXq3Gmq7IKg+aWfm57HdTYYNKjw27Tiw3MCSzSCOOn+5OwCFptpU?=
 =?us-ascii?Q?2VY5ulv/ybm2cOpQ14jqAmVtfLSZpbZUVRBmRJzYy7NHRERiBzf2SLsZtaNP?=
 =?us-ascii?Q?lttd+b5T2glOZCLbvhNqGeFDHgeTgfJX0WJ72IxV8Q76zt21xJO7PG4SO4bb?=
 =?us-ascii?Q?IKgCI33wTJK1rz8aX57d0uglpkTJUBi3nUdgQtMKy/lwOU2PbPibRbfn4fa+?=
 =?us-ascii?Q?OODRBJ/0Q1UkhBvjFRpwKtEEzxvIOTM3zX/xgMmboDOztSvJaJE9+RYIJQ3j?=
 =?us-ascii?Q?dRL3uGfThv7TlN37196JTg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: df6c097d-bcd2-4e74-5dbc-08d9f37e3986
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 08:02:50.9452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBP286MB0062
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I tried to apply your patches to kernel v5.15.18-rt28 and measured
the latencies through oslat [1].

It turns out that the peak latency (around 100us) can drop to about 90us.
The result is impressive since I only changed the guest's kernel
instead of installing the patched kernel to both host and guest.

However, I am still curious about:
1) Why did I catch a bigger maximum latency in almost each of the
   results of applying task isolation patches? Or does it come from
   other reasons?
2) Why did we only get a 10us improvement on quiescing vmstat?

[1]: The result and the test scripts I used can be found at
https://gist.github.com/OscarShiang/8b530a00f472fd1c39f5979ee601516d#testing-task-isolation-via-oslat

Thanks,
Oscar
