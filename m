Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB06559597
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiFXIlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiFXIlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:41:47 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-oln040092064077.outbound.protection.outlook.com [40.92.64.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AF374E51
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUoL+vuGbDBwQfN8FuwEPBbKRxgaXcTT3dVZ/Ni3AeypwJ+GAa2PLMOnG6PwxF/iuSbcUMy1Bgy0g3O5CjTZ0dPy4QvRSlX+3yO8o2CiFDAZFVXIPKp6E4dTtca5aa65GCWn3EMKoxNfQJhXx3Lg1km1UAmGrKImNOJLRvKF6DTe52Rs6Ml1yzes0aUnohi2RDHEmUdE4T2V2fND2bpOCZzk9zg0e9OIM9JFj3AFBhwRy3Uy06BpAZRtHdR+p+W9CZeDRyG8xntbRh3ykkgriCHeHbfPv5MQhVvRe2GfRO0UQRlY1j1jecCWl1raattG+HcVMaanSG2cik3i6Rh9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwkhBfdj1J/+6qfL9byOCZSYxvjObqiSep1lpNugb4Y=;
 b=LjH6xQmhuejYDtueIWH8/WErFJ8PFO1oQARfyLs2M/DLWOVN/QDPGcFA8Jd03wKlTjHGtK06DFy3pL6M6lEdjPf2jrg92LpPHRyr/E50jrtFE6WtKHmEzOx+1UJVigP1llFUhQkhrT8Z399VqKrvqnl8985Ohdx027M+3Fx3wiSP9VdZdIn6W0RQt/8lK28j3nNpbE4HbhmQIqBe8ynFSv/4BQRfa7yFzKFxNlQY6M1I2VgSD95qb+Bfnj/g7EAXTQ4OzN/c2+0o+aKI8qJVo42o8j5xT42BOB5K3ZmEzzPaN1oDTNqstNv1iQKer7nMoA4Ttfpyad4dBUDOiR/QCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwkhBfdj1J/+6qfL9byOCZSYxvjObqiSep1lpNugb4Y=;
 b=tlTZ+wEsprg3HFG8BFoAst8mNdHJ+pEVomOZ50xeMloOroGlHCbhBC3JrWwXF8tQvZu7QWPCulhjrUQimCtM+Vj5cwrok9Ud+iq9RPJU+V6PlCujKAI1K+WSTgWIiu0G5cr08Fk7GzpKfk5y2IhxHMaZVNNXa5CinAIi2S3pHaZ0Fuum+P500pzhHVDI4BqfqKcRGmknWldPDMg0jNx4zzbRMRzw5qyA3vCjLXwOXFVpwKeRmms+Xl1rspCRElA70uS/bVp3A6AHIyuqLxbRWTmivHsXiyzfQiyURTR6F5dqBt8EjDiS76FuesT/LHTPHWXdpkda0Ipfl+ZO+UaDoA==
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:267::9)
 by AM8P190MB0962.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 08:41:44 +0000
Received: from AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397]) by AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 ([fe80::c0f4:a98e:332a:2397%5]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 08:41:44 +0000
Date:   Fri, 24 Jun 2022 10:41:42 +0200
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] Staging: rtl8192e: Cleaning up error handling
Message-ID: <AM9P190MB1299F18B717D3A5D3E6DE6D4A5B49@AM9P190MB1299.EURP190.PROD.OUTLOOK.COM>
References: <cover.1655975970.git.f3sch.git@outlook.com>
 <13b32131cd00a1f0b8793657a24ada71240a8350.1655975970.git.f3sch.git@outlook.com>
 <CAHp75VcQcKaYUP_JsmTFOY-pbOR39+TMw=5ADbb2BRGoMijCMw@mail.gmail.com>
 <20220624052118.GT16517@kadam>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220624052118.GT16517@kadam>
X-TMN:  [bIc0xoGaeR5LdBwXjs5hnb9/nnST5i7z]
X-ClientProxiedBy: AM6PR01CA0065.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::42) To AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:267::9)
X-Microsoft-Original-Message-ID: <20220624084142.jeyoux4dwofrytar@fermi>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af600962-43e0-4085-c251-08da55bd5dee
X-MS-TrafficTypeDiagnostic: AM8P190MB0962:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZiZz5DO2PTdFk/1kPfKttdw9oEKyie9Ay8pPGsbZT2arQvCgmSnEgaUmUEZRIZsIi8cHkD8d0Gnz05OXonED6TuwwUzqdfGFaWwNTemk8lIsgXJq7bVbXQ2K/HW6K5hehYXQwDgptBROxJCziu2CzEvyN4Cx6yKeVmf4X8anr7yvXo7+gM5Vl9g8h0TWnLODdjvKja8KItjptaWo8z7LouAElSQeMLIvunOAGemjsRJgXk33RKcRow1/8ekNeQPfaU6Ha4wLK7IJ6AJ5/HYDITPY0NnlRP7yt6HkIIVtWKZ8sevrw6RNrcL+xi2z9pxm4AVQHNbbx2ec4tBQ8XJATzXtU4A6ywxAnSet1nEp+mF7F0SVJPETcjPJk7F8uE9VAcQvFs8v2+qI1m0TD2FbjCFPjl5gRFy5a+XLRAYHu0NnquOyRFAh4creudiZ6X+TFQFkLSdIIbJQX0t2Y6TtfuU4rJXqURejZwRtrmPGct4p5833mGlSfMj6fvtZlIKdRNsw1MnyxZ+hrr9BK8N2kwtw8sKvVeTpj3PCMpc9LXbvBuBUT7A7J5JxTpaQh4/HSqKE3cO6ya2hZvKx9xHW1sqcthTd7rbaZysL0k77frS7hUMD+owH/PmIHXNuPbSp3LrsxFAna3A/mfaECg6iQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzdCT1FrR1M4bVlaaWtnZ1V3b2pDbGxIbGREMnNHbGd0dlhIalJ2c0ZRd1pN?=
 =?utf-8?B?aDhkVk41M21UNndGUHZ1dnlnejVqUjBjbDhteTFLK3FHVisxR3pPcTdMMEc1?=
 =?utf-8?B?MUY1ejloL3A2VnZqQlpaRnQzSzZWYkRvSU9yK2d1WXNkNmFCTG44MW1CQlhw?=
 =?utf-8?B?c0xvVUc1SmVpZnh1UU91cGxsMmJvWHJQYzhudVR0TzFSaVpkem9zcWdwNEU5?=
 =?utf-8?B?YlArVC8vT1pGUkJ2cWJTK3pUQk5QZmgvT0ovUXBaZFg3MWdqWVpnZXpCM2xp?=
 =?utf-8?B?L1g4MTVRaUczcDlXeG1ZZ2oycGE2aXg0eXBUK1o5eCtLR3hDMDkyL01saUV2?=
 =?utf-8?B?UDNpR2dQTGk0V1NoZXBsN0NrTlRJVWZNb1J1ZWFKNzhuSnd0eTg3RGwzemdY?=
 =?utf-8?B?SkZGYkxoUzhTZ2hMY1NjcUpZZ0hZL0dUYjRYdDNjMU5qcDhzNkx5dEF6cWR5?=
 =?utf-8?B?Y3JVTDBPTndib0NoZEVHbExCMjI4Z1ZWSDJnU0VsMnVjTGRwTUZIVjVjOVdS?=
 =?utf-8?B?WHhyU3ZENGdSRzlESGx1dGhWcWpHQTAzYVNEQ0NKZmozbndwRWdxT2w2RE1I?=
 =?utf-8?B?Q2pFNkNWRTU2ZG5KbFlvWHlEbXdCeUlQOVV4TjY4UldrZ0Ixbi9MbkhLYjh4?=
 =?utf-8?B?anRRdEYzSGtQU1dkN0tuUlY1MG96MHl3UHlDUUcvbTRhQjYvL3ZvTlBNbkZU?=
 =?utf-8?B?L0lVSFI3U0I3RjFmanV0Y005TVJ5dFprRWFabTEzKzVsejM3WG44MHBlV3NS?=
 =?utf-8?B?cUdaMHcvYTFxVDJ5Z3NYR0ZlQUgrSTBUQ1V0Qy9yQUxmRlZhUDJYZjB5T2VP?=
 =?utf-8?B?bmRBTkFvczN5NEFqMjQ2YUllZGxsOVl6R3k0T2JVcnhFSWZVckluNkMyOTJt?=
 =?utf-8?B?T2pDVXRLSGtHTHRrRXVMNVpzYm11dTRweVJxZHRKUlZWS3huT3QxZDBSNjI1?=
 =?utf-8?B?TEZPTnFiZkNBRlNZWGlCOXBhREp4U2VxcUVBU0NRV3V0b0xRajB5UG1NK1pk?=
 =?utf-8?B?Smk5S0lZWGF6cThsL0F5S1lEY3VZTWdDWHdUOVlyakNSazJQZFdlU1Z3V3Zp?=
 =?utf-8?B?UDlQV0o1ckpRNTloTkw2Slc4cWI3MSt4UE53SitQZU5WSDlUY3ZYL0Z3cTkv?=
 =?utf-8?B?ZmhGQy9mYittQ0U4MVlLRGJTNnlPOFV2ajBCTFlPQ1hXYjJJWml2U0xDVmRz?=
 =?utf-8?B?UXZteUFIem8yQm9tb3dKMmVIRUpnRTM0TU45a0N0S0NHTFBXclRhSVZHWWN0?=
 =?utf-8?B?MHdlRDlJTzdjOWFwdFhIb0tzdGRRNW1BbzNIaEd4emJ1MCtDd2FIN1BGR3pr?=
 =?utf-8?B?TVRiYmVmYU1KcjRHWGFxS0hCemtxR2UxR1V5NmJpaHNtZVRDNTBhMVRIUjZT?=
 =?utf-8?B?a1IwSmhQcFQzRW1kbXNaUVI0OHJ4OVRXNFF2T1NnaXk0RUJ1aTBseEtMdmJX?=
 =?utf-8?B?ekRCdzZEaFR1S203dll3dGF1RkVBZGY2VTVZMEJsZjJLTENkL2ZwdlJOVk5Z?=
 =?utf-8?B?S2UzK3dyM0JiZUJVOW9mZmRxVVNyZ2JjbDhzME5waVNsQTN6ekwvZ0tDZUc3?=
 =?utf-8?B?OGNzc3kzUjNvMU5RYVI0K1lidXF0NnhIVTdzc0tTTEJRVXNhVDBBVU5iTmNU?=
 =?utf-8?B?Y0xLR2pxMUd2U0dTMzdRYUhxazRiR1B6czFmekpxenRrc2dMbm5ReDZrMVFl?=
 =?utf-8?B?TGJ3VFpmbzZjWm9EeHFEMkg4L1NQSERLVCsza2hwZU9sMDdHSXJtaytnPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af600962-43e0-4085-c251-08da55bd5dee
X-MS-Exchange-CrossTenant-AuthSource: AM9P190MB1299.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 08:41:44.2592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P190MB0962
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.06.2022 08:21, Dan Carpenter wrote:
> On Thu, Jun 23, 2022 at 11:20:49PM +0200, Andy Shevchenko wrote:
> > On Thu, Jun 23, 2022 at 10:44 PM Felix Schlepper <f3sch.git@outlook.com> wrote:
> > >
> > > Moved error handling to one common block.
> > > This removes double checking if all txb->fragments[]
> > > were initialized.
> > > The original code worked fine, but this is cleaner.
> >
> > ...
> >
> > > +err_free:
> > > +       while (--i >= 0)
> >
> >   while (i--)
> >
> > will suffice.
> >
>
> Either one is fine.  You prefer this format.  I prefer that other
> format.  I told Felix he could use either format without expressing any
> bias and he chose my format.  That means he loves me more.
>
> regards,
> dan carpenter
Andy's advice is of course much appreciated but I prefer Dan's style <3.

On another note, the thread is quite messy now, since all my previous
failed attempts to send are now threaded to this one.
How would I go about solving this? Sending another v5 version, the v4
with [RESEND PATCH v4...] or does this even need any action on my part?

Cheers
Felix Schlepper
