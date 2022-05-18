Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652CC52B845
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbiERLA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiERLAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:00:54 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2127.outbound.protection.outlook.com [40.107.114.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7C3166D54;
        Wed, 18 May 2022 04:00:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNxN9y/EFqqZ/Y1xHTV666TB9Tl556cB7AKmW8lueDSUdCZcf+CVJ0NUsdiZhZYGfrmFtLqZk1o18YDNRbMCUj5jbfbXCzQBZI73Aac//+r8W2a0VSNaj3FiXZvF33v10N/GX80zlKfSBhp75hNsqnFFDwLyJmqTZAFXqkEADMi0N/afTao2DolmihoC9pGLfHnxLAWMdqswBjEeavGWd1onZWNzmqLh+u/Zqlyv7ozS4dNH8jMX/s9YF6Qnpn1ZS1yKVsiNpB4BVOXmnUACfsS+KnsoGI+ukx/DVxrzgdwdVpfGBAN6ujpPGbWQFeC0UiVYZy+yrnyIUU9bu2jXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Wv9vBvlZOu+u1xwrxiZ6ViA+T1hxmTvNSDTkbwPc/c=;
 b=LeZiSdLm0M/KArCM+50C0t8LKA5Fr3TFRPF6S9Y/qRUAo9sD5gkjqMsFKFz6/35fmEflwvMnEQdt12HioD7lZswf9J3kxkwL/58l4fUM8nbRY1N/PjcC1wc39zj+2idTShBs2VARFiAcyU2DBNOUIl+ko3q40IF38Tk/No0mpJIwotlpo6TZrHY9MYapivIAWtZd8U5Ug4qTIGJgrLgaiOOvbsauGMKwWSYwR1T+slO1h7iwINNYsCUCkrIX1C0UIO80d5dnggOmOGtaaB02iLqhfxYJjcYslQsmnNPnOSDhjE7dCFvHECWrDgj5AdiUK4hfgkItml7TSOkGt0OwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Wv9vBvlZOu+u1xwrxiZ6ViA+T1hxmTvNSDTkbwPc/c=;
 b=k2Tn03ygn19y5bdpo/bcwZvQOMo43/tc24DPgNO8Y3zgBo3ktHW62ax29Edxq8ggquUmPSsFThEQu7KhEqz1PjX1hzXOFMwP1zzESjLsY3QHzXBeLB09YdKNK1ctXjAe3ExFeIcv/E5y38JBOhsrzPPo+Sfyp3OE2pKqzbfIZBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 TYYP286MB1161.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:de::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Wed, 18 May 2022 11:00:45 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7%7]) with mapi id 15.20.5273.015; Wed, 18 May 2022
 11:00:44 +0000
Date:   Wed, 18 May 2022 19:00:37 +0800
From:   Zenithal <i@zenithal.me>
To:     Conor.Dooley@microchip.com
Cc:     palmer@rivosinc.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, heiko@sntech.de, atishp@rivosinc.com,
        anup@brainfault.org, ebiederm@xmission.com, keescook@chromium.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        jiatai2021@iscas.ac.cn
Subject: Re: [PATCH -next v2 2/3] RISC-V: uapi: add HWCAP for Bitmanip/Scalar
 Crypto
Message-ID: <YoTR1aBcscG+oe0W@Sun>
References: <YoS6qRhxGuwHmK7q@Sun>
 <YoS7lgTmcRT0q9y+@Sun>
 <fba8ab6e-17bf-1fe1-ad5f-339276907298@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fba8ab6e-17bf-1fe1-ad5f-339276907298@microchip.com>
X-Operating-System: Linux Sun 5.15.26 
X-Mailer: Mutt 2.2.1 (2022-02-19)
X-ClientProxiedBy: SJ0PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::17) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37bcf7e1-2957-4087-b5e4-08da38bda7bf
X-MS-TrafficTypeDiagnostic: TYYP286MB1161:EE_
X-Microsoft-Antispam-PRVS: <TYYP286MB1161816C9491BDB5A15771B6BCD19@TYYP286MB1161.JPNP286.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BkiYJ71eZscW9jWlehOpwB68WNbgSj6aUTs879Mt/1SveH0PbfcDP+M6RgvESkZ231A73CFDD9h6UAuk2EcSNz+dyKubQkaRfpBgb5AoV5en3awJbiE+aOEg5hLvWP2CBQuRsYP1H33GIoh3e3Y5p1ckelZ91J5c4cGVTJVgwYTOxNXrad1ch32TGTHzP70XDVibiaVO2YPhnAPxRQnNMDl6M+j2Q8ddZLUYjrnVeqPOZw9QqGUWTdyBJF7nqyRl30D0vFzqEkO3jytFS2I2JaCxfKt/JrCMJo+kxCCbQoyMD5JXPY7VTFIfYoo3LH2XEbEFrW0srkjnL8sCyGqD3hb3TnCODKzxk4zbdeO5S6D36GkK/MO6T4TTA7t9GfLUuLP7h3Z4ExDppcj0WcKDNFv8OhZbB7YTte2KI93BtVl4f4rv0E9GZFaXncwvZPGnwTYOtuqW/MhgboMLqjlW0zXNsemOOt0ViNwXzpfD9nrcsxNX1n3ZL/rWkYBH2ZOKGVkX0/ZCE6v6VSVwHx4A7/jyQyFo21fpfFJ9+HP/18wiqjBDFKflkENp848DVab9fV5TwWJmx9gR7govbCd2utbjJQsD6kyEcMuipcLXdhD+Oj4KB9UFlL6qp7fBsTHF+wBtXppVYFP/jl3ExxjNITTgUzJvlHRsUO3npupkk1dwzoeyj+4g6APk4L0JAQfCWl5+g0in0J8BTMIliaoqh2aM3vPcIDxSzGeDujta4d9sLxXO3Zt0KSrzyZZHig/zJF33mYUcTdavh7rp6GO+H16HWWYT1EWW5wxyB74PtX4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(7916004)(346002)(376002)(136003)(366004)(396003)(39830400003)(33716001)(53546011)(186003)(7416002)(6486002)(52116002)(6666004)(83380400001)(2906002)(508600001)(9686003)(6512007)(6506007)(966005)(41300700001)(4326008)(6916009)(38100700002)(8676002)(86362001)(66476007)(66946007)(66556008)(786003)(5660300002)(316002)(41320700001)(8936002)(49092004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/9z3/+OT9gnshGKlc8zb/U+NpnnuoH6b6WVfdhnvpCeNsfQnmoXuzwVQL4Aj?=
 =?us-ascii?Q?rJM8Z5qoIJpEZIg4Pg4oPAXFBSU3Spih0qpzgweYgpVYgdJSYOT/phUc08p+?=
 =?us-ascii?Q?dMqXG7zogPmLFz+08p/vcDIvG7t3S7zvx6ylIjiWZiCLZV53Oi4mXXpFIHZh?=
 =?us-ascii?Q?syTW+eRboZdyA4pY1xTPgWu1MhOe1x9X0qhQ5d2mCmnEkZSqqgeKKIoiQ+On?=
 =?us-ascii?Q?xc4zcd/vIDYq4Dlhyfhdi7hhORpe0Do0Oe7GFDmExspPOoMFoR5VtZcCO9Rm?=
 =?us-ascii?Q?HrQMAw0nE5ltgYn1kgbta4itiKNKIc2Q8pXlP7ZMiNkD8QXcLuHz99FUy1nN?=
 =?us-ascii?Q?HFea5zmf9NDSWQxeNlL+IlNGLVzBVZ3LVEKEsX+t1LBmH6LrfqS2UPWzkhZ7?=
 =?us-ascii?Q?PTWSWsYbLDtsUfaJTKV70j5Xt+s29h90YgQpE7aW6vz5E+O0sqpWca1wafpp?=
 =?us-ascii?Q?k/lfxaqzlfYgZc+ZXG/avp9JtIiAOWlDCOBpITF/IBSggAARDiSHZcp+TjFc?=
 =?us-ascii?Q?Y5ogGfjzPCfAuOSLjtVMQ//e11pI/SFOPLSgqzYIAFWXDe0sV/s0lh9NmVzM?=
 =?us-ascii?Q?ZchuXgVUXs7FMZbMM1jtjV5azvn6fRQ9ZcEmG5UAN2XoIneuVWNsyd0PQc/2?=
 =?us-ascii?Q?ZdnRdERpRJgOC/V5e4U4pStWDAQo8R/C9nbWpQ8wuscCp18AGj6162t26jiy?=
 =?us-ascii?Q?1eBNoHClG/RDOIHyjLTfOCxQaseECXrgDYWaJRplezTe0yQOBO0X13hEyVqZ?=
 =?us-ascii?Q?g6pvkZlIagPstSqToKT6veFCsoEm2KBD6HhMeBg3ETsAZAizxeRZZj+WxuRf?=
 =?us-ascii?Q?2UuVlASXjnH32wsEqaupthMnFeqKX4DaS0JqhfIaC+Gr9QcErfZ01OTqGEDx?=
 =?us-ascii?Q?AnqCo1+BGCiEterdDJCaarRz2LKBeRoYbJ7q3v7rEqv4EHG6mK9V8AtE/ynn?=
 =?us-ascii?Q?RAjJFFqMzv8ajU/RLaEDTojGUnu6H8oG0D6ygF8DhjjVhVTF1wISJmxtebns?=
 =?us-ascii?Q?Aq4KGM8gSgwaBxRoeQJPHBxORBRcAWxZvB0IMTJBM8tGVkOvvqja2H3+15P9?=
 =?us-ascii?Q?fAjd8lKd5YzxMzeSibcLNxJ5k30B9M3VLZcpZMMip5GxzHCtLfSjchLClWrD?=
 =?us-ascii?Q?8zo8ir5ChEzc21joPrqx/EW9+4DKxiNOphCxPXShyE3LiolEBjJ2piL5Qw65?=
 =?us-ascii?Q?pd3iG+d2Tr4Pe3/l/CkLkVstsDwqm05dtfuGeXF+3SdRTepXJk5G/53igGMa?=
 =?us-ascii?Q?1XnI9U1bMqFHEwjXG5Y6+1a4RN/oAfL9lx4XNc74gTQ/rueyGNPEJ2TCg8nS?=
 =?us-ascii?Q?7+z/Ml2lenm+2U3EUdBwnEK+8+1Brurj/ZToUg7E+/7vKm0QApNG0vTVK8+P?=
 =?us-ascii?Q?q/A733qGTx7s96gsoA5YAfl6XkqHiryDXUNzTu+CQy7FvzudCj0EWnsQaYZa?=
 =?us-ascii?Q?lUsc78TfwKHCjxIQEOo3DUDueYTBGMPUW50u964VVIWJmta59cGHCDqW1z58?=
 =?us-ascii?Q?l/4uV6y4FY9EQppuNbUKhR6ksioZnnGlAOTB+ny48M88Xy6Gw/430s1lhDdW?=
 =?us-ascii?Q?KoQnVuG8YFDvhOJ8bPhcthXeCH+6PIz/Kb4JIrvsGm8OoKrxet+m5DCMnl4q?=
 =?us-ascii?Q?3Lxi/XhLhTayJZDAWZy4ASYGUWp9Gf+bwUbOUU41J/cWBsqY1qP7/VLRc9JC?=
 =?us-ascii?Q?N5IVhkn5jbq4Zd6Xain3N4WRaDtFSA9DhFUaH2nVQOl7NlS1azu041UosvNP?=
 =?us-ascii?Q?IrkXjKq5ZQ=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bcf7e1-2957-4087-b5e4-08da38bda7bf
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 11:00:44.3348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09nH2ix7WJaq6lRpIprgWZbvpmdKipXAm22Kp9udtYrfnmbc9rX04anCe5urNEm7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1161
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 09:39:53AM +0000, Conor.Dooley@microchip.com wrote:
> On 18/05/2022 10:25, Hongren (Zenithal) Zheng wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > userspace currently lacks a way to detect whether the
> > platform has Bitmanip/Scalar Crypto capability,
> > this commit provides a way such that the userspace
> > can detect it.
> > 
> > RISC-V currently still has no mature mechanism,
> > but no matter how things in the spec changes,
> > (no matter how "M" mode things change), the kernel
> > still needs to offer some API to the userspace.
> > 
> > More discussion can be found at
> > https://github.com/openssl/openssl/pull/18197
> > Userspace currently has to use env var to detect them.
> > 
> > This commit along does not assume any specific mechanism
> > below kernel.
> 
> s/along/alone?

Thanks for catching this typo!

> 
> But I think you could rewrite this sentence to make it
> clearer, I had to read it more than once to see if that was
> actually a typo or not.
> Possibly swap "This commit" for "This interface" or similar,
> both here and in the first paragraph.
> Maybe something like:
> 
> "This interface does not make any assumptions about the
> underlying hardware"

Will use this kind of description in the next version.

> 
> Thanks,
> Conor.
 
