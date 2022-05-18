Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0027A52B856
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbiERLEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbiERLEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:04:43 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2114.outbound.protection.outlook.com [40.107.113.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D83216ABDD;
        Wed, 18 May 2022 04:04:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izU8IUb8RmRdlu0kL+Xq0WL1RELk/9qmQ5IjM4jdU+PxXxK8kVbGVkaKLpws7+i3PZ9R7fjGsryOYVLi6BvIa4CEs0RaT7duN2lsoLjji8W9JVfaJiKZWt3/4+E+D8081fjICuptD7GILpzxWKuKSMUBlK7fuNUHtVCZXMV7FgIB5RPAbYUzjBF1HsUfAB/8QYi0qLzkAIl7Mzd6tZ2kgXKjmnYseAcV0Enw2ZCIVna3gHUEgKtrETd7DlkKzPjsd1fAQLJxOIxI3nCbx1PM6fAx9QTGUKAtXoss0vvIAf4yFE2yRBZStkZVBg6nkzPYsV3ojEUMtQvIHNbkQSeFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEaHsqfqObyBkblmt9uCLYqzE4u1hAboEcNfbSZIZCs=;
 b=hJee2v8xIMkcoqd1RdrtSckwwj4KryYYNTuOLa/YHCoCmMRokM84dQNxVUxbLVtb2r6aOKyfUO0DklonK6BfJeHifyqIiQF3KDQJKfXOtJCEkZ/gD2aw01s6daUmhVpqJD/en1LWG7FaYFObgTbAG4Hj/nS0Q/Wek9Apjg5JsjT3MoPu8THbJoI3zX+ZLzXHjDVFGpBA+KEs2NMbeFxdP+o9yflKUSRPAmzPqp6YXEfVn3Mj8yadVtxO3cjDb5rh3XQ/1l/WCc7iqkV2JdNRaq3EbPqg5J8KUpDEsCwb+Y20EMQRzTpzfTcfDMDYNnY9T1voQuEKLb9MpKsCila3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEaHsqfqObyBkblmt9uCLYqzE4u1hAboEcNfbSZIZCs=;
 b=eeqK5q0mPbokWtCX4MDgr0eVs6xH+Y2t49TOj5Q+3d7kob4YGhISXDbPIiq5EyfKX/RIRKs3uUDE0t+hzzTikZsgbvvPIHD0uGRkkKqjcAUiIYsZ755uYKZkqX8qQvA/wTQ3sxnLF1bKeabp5Q4kyv+rOgf09w8WBDRO1ZqCnLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 OSZP286MB0696.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:f7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.17; Wed, 18 May 2022 11:04:35 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7%7]) with mapi id 15.20.5273.015; Wed, 18 May 2022
 11:04:35 +0000
Date:   Wed, 18 May 2022 19:04:28 +0800
From:   Zenithal <i@zenithal.me>
To:     Conor.Dooley@microchip.com
Cc:     palmer@rivosinc.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, heiko@sntech.de, atishp@rivosinc.com,
        anup@brainfault.org, ebiederm@xmission.com, keescook@chromium.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        jiatai2021@iscas.ac.cn
Subject: Re: [PATCH -next v2 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing
 from DT
Message-ID: <YoTSvFe56tLy3M+u@Sun>
References: <YoS6qRhxGuwHmK7q@Sun>
 <YoS7bT1B/+JrEn05@Sun>
 <3e3891ad-2d31-99a0-bb65-1e6643ff6b96@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e3891ad-2d31-99a0-bb65-1e6643ff6b96@microchip.com>
X-Operating-System: Linux Sun 5.15.26 
X-Mailer: Mutt 2.2.1 (2022-02-19)
X-ClientProxiedBy: BYAPR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::45) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3057cf4d-1eaf-43fe-5b1e-08da38be315d
X-MS-TrafficTypeDiagnostic: OSZP286MB0696:EE_
X-Microsoft-Antispam-PRVS: <OSZP286MB069676F96C9A9E834DA0CC8CBCD19@OSZP286MB0696.JPNP286.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: piOdhhpUrAqP8TFomMlZ2gPW1OZ6NLQvfJpP9tSjf7cCT6lz66fdqScx3LhqWpY6OemQTJH+aWPvy4JnZbr4smIVs9zBtaFfvRUjCRtquGU0uoFASCk8JtvjOjRNRl7G3Fj0pLxxPvzhi1GKIkOsD9RAOV/NgBM9e9Q9awnl+81F6+cJR1RCNzNqyIYAOwnQIQ+DitxfBafRe1aPfgf13IhQnigVzvU4grSX8lua7EJbjFKeDjEIBCdO2WSt3FmHev1xAqpvafW57/fkNcaArwECkgVeA+9N6zCSmSPlieEmHVyndMD7UdteXWRYQUlSw6HULxF4aU+LRA2/2nbXPyBzrtmprsBO7rnsLQecBVajh9mjoiOdUTD+Wq1CCqMtYaUQDmRejuiwRA0IF+rpqmN1qGBHRz/hEBR+FKrlqRt7ZfguVf2gNyK/Ta9DlLjg0pbBO+aj9ZRxBheLo8siNRdhsIFDbNO4F/R8Wgw4oNozcWAzsJRwdI9wRZAygNuEoO96lzTpnzauiC193TWLD7ZdJHNvsIFw+kxae8hB8BVacG0rCSj3vL/yPrEnU3Fgbmg37fPW317HOEIghaaA7jykQzjGj6o4GCrlfDl9IDGzcaTFPf4+Dqc5B7CCxfuk7SN8Kd+JyKeLi/dUFvUjRSWVQ9t1f3LfPxDxgtX25gM/KGajmtUQOZLJZKe+eERNKTZqsmmULmxPtRaKjczXYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(7916004)(346002)(39830400003)(136003)(396003)(376002)(366004)(66556008)(6486002)(5660300002)(508600001)(6506007)(9686003)(52116002)(53546011)(6512007)(7416002)(8936002)(6666004)(8676002)(2906002)(83380400001)(33716001)(86362001)(6916009)(4326008)(66476007)(786003)(316002)(41300700001)(41320700001)(186003)(38100700002)(66946007)(49092004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MqsGa+pjCsXq6IlaqZZg/MCQr56q+M4+A0cpGaKeK4LBRjAF5TQLwAF0QaFZ?=
 =?us-ascii?Q?TAOCBFvb13GyP/otpylUXOgqJ+BnVcWtcx5cmgRMkIwd8M0ywTDTfZaZKi9O?=
 =?us-ascii?Q?q1LQUykokF+h0jPJWtcxL6u04FhGRcKEUqHLGGRuTQsuEg2oDWrW4evbo21R?=
 =?us-ascii?Q?HaMtBHvMF9aOyVqzStYqeWG7LWtJCP5iTQ+ae7vsCzhK3UWi837NUB40wv5Q?=
 =?us-ascii?Q?cVHzfRzzjcxDzKl/rFMZ9y2IoziWtP2UXPHesEWTHtV9K7ps4oy6bGrRlb27?=
 =?us-ascii?Q?NyhIxvcM0+zPakUCR6LeUu8Pu9RoQhmrb1Mp4+nIavXAaI8friugWVGqldTZ?=
 =?us-ascii?Q?FE/1yYtBCx/Xx8Pr7VJ1RzWzgG/TqKvLlkx8NUKoE4/prfFD526qLVxJbknk?=
 =?us-ascii?Q?qw3al43wKfbBkYrLq+VvE9rs3UtWIA5CaoeBwB7oh448FJKZt1fImiojYjzn?=
 =?us-ascii?Q?qKU4Q3BKqxjBO0oUPIl6mAG8zPXkINtRf/RR8V8hMvJ3oc0qNsQtI0S1tEdi?=
 =?us-ascii?Q?4n7Zwn54ISXPrWyXXKWXX1Bz0D9ZSuDszb+p/UK+ci8vd8WmVeWWEGFxqqAu?=
 =?us-ascii?Q?9AD1a+3psK+mYIcSXcRHPgH6b8C8fbLJYVfvpM64VswWPzZ3Gm+gDek34jvO?=
 =?us-ascii?Q?02zo+RnybaUD13iMgYZKwkzCcCPCazJQRSx1ocMQYUrNI8gHI/ALTxMGH/6Y?=
 =?us-ascii?Q?vyn55d5NM3KJgMLpFRmX043zmwiZK/BSZRtKItDtEIdmIJsaLJBJ1tBbSzEY?=
 =?us-ascii?Q?ZKtEpNs7G+o/OSAg7e19JP2a7peJ5uxEEi2TNSmNCMGoAtH5p1WJLPCXr2pV?=
 =?us-ascii?Q?QHJbH2wH4fwhY5mPdUkU4hgU1V7m3VQvERXKQc7ErhJd8+Cxiq4yYcds+12Z?=
 =?us-ascii?Q?SLT2mLu6NsBpq15IqhdYLggUplexvcVf80B972KCgEbFa/btSApyy90JHEmM?=
 =?us-ascii?Q?eqmKjDcwK7FDLzs7Pqi6uvWELMMXhpxIrj4ZHrXOPG9mASSivb0MquBd2N1a?=
 =?us-ascii?Q?CPeYwEYSgu1dke7R//KT1pgEHqvvW8Wp1JDLAVAq4NM408yxFzteOw52PPTB?=
 =?us-ascii?Q?/YJeBpn5GANErDF+XN+1CqCf4rqbLTEzH4Us+vax6SqXj8/+JvmW7Owme6gm?=
 =?us-ascii?Q?idRbxUIpFoXueK5LlHJydJsbLqLqk8IPajElft4etoevdOf2Lfjx8FrXkGh8?=
 =?us-ascii?Q?BV3IxQq6/n1PmxW3EKSJLmb2hbsBoLn2xCszqX8UCjlF9WxiCxhHwd2kH1GU?=
 =?us-ascii?Q?1ODKtKMw4td17JbCodSuYLh+0Ce0PcPejv8W8yMoLk5p0Ivb0lYsNjbLbeIK?=
 =?us-ascii?Q?2pCquEWQJ/nV3xE0FDDcD4ahScjkIzgbViGNr3vq5cj5YG0CZEjsJDhY+Hrj?=
 =?us-ascii?Q?L7tH2h0fcHbuE6KlflW8XLM0qGfprx52Onq0+4GyXXKCq3zQ7RnaSapelHwd?=
 =?us-ascii?Q?E7V9ZJ5jRjzow6FRwnZrPs8MTvxKkxzDO/YtEJ1maUwOXgNoKecc3T5BpI0Z?=
 =?us-ascii?Q?pEn6l2cXYacQzyEFLZ+FG3Aizk8rzu+EDxHXc6vvERZYsb21Mkq2auA3RYhx?=
 =?us-ascii?Q?ZZV/MZGJ0pxEwYVsKg0Wq7cBoT4gShyE7ub6z0qzshjZNCEWUu2/LDoPPS75?=
 =?us-ascii?Q?OPWqVzQMKC4eUXzVF2lChMndNnklT6E46OXjSUYJb9/2bmyfUyN3mu06UrOy?=
 =?us-ascii?Q?AysC1d9JBLzamZ08b8JG7wHWqIfPcFhhoZ2jm+pvVP43pDJBeQP+caNAnR8M?=
 =?us-ascii?Q?u2ZvOklFXg=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 3057cf4d-1eaf-43fe-5b1e-08da38be315d
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 11:04:35.1208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8snQcHzQVOXuuUTGOIia6WS1SJVLzRQ6x6jMweHB3Fc6v+SrfD9ltBIXUHFjCfH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB0696
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 09:50:18AM +0000, Conor.Dooley@microchip.com wrote:
> On 18/05/2022 10:25, Hongren (Zenithal) Zheng wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > This commit parses Zb/Zk related string from DT and
> > output them in cpuinfo
> 
> Similarly here, the typical "this patch" comment.

Will fix in the next version.

> 
> > 
> > One thing worth noting is that if DT provides zk,
> > all zbkb, zbkc, zbkx and zkn, zkr, zkt would be enabled.
> > 
> > Note that zk is a valid extension name and the current
> > DT binding spec allows this.
> > 
> > This commit also changes the logical id of
> 
> "also" makes it sound like this a separate change?
> If so, split it into another patch.

No, adding Zba naturally changes the logical id.
I think it would be strange the first patch appends Zba
then the second patch moves Zba to the beginning of the list

> 
> > existing multi-letter extensions and adds a statement
> > that instead of logical id compatibility, the order
> > is needed.
> > 
> > There currently lacks a mechanism to merge them when
> > producing cpuinfo. Namely if you provide a riscv,isa
> > "rv64imafdc_zk_zks", the cpuinfo output would be
> > "rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed
> > _zksh_zkt"
> > 
> > Tested-by: Jiatai He <jiatai2021@iscas.ac.cn>
> > Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
