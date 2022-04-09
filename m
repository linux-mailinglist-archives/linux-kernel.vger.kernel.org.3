Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF8B4FA8E8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 16:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242310AbiDIOJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 10:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiDIOJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 10:09:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FD726FEAE
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 07:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHMkR5N5Q5dYUcOteWMqVvrDePmSx3TA3zDk93Ez8beFI+pMyIeNBfVQXMsEyOBXUXVwZx+9HXcJenCI/Txe2N+B7vuEMfl21KSheXxXiDSxA1/o41EaRbzfgliJS/Uk5JKSf8MDxs97M7/LkZCRSN1e/FED5CgtE9huJXuGgJGRmRwRW7I7Sqi+cOs5roCuhlGJJ1vwgo4WBpfaAIxfQ3RtbpA2hhtAJmecVrsG3tCaUN7As6p0RDC0swZR1kCFRZWyfAF3atSlnGP9yJjBtElnn47RjQWXp0sc3K1vmwlRTIM2cOceaq6xh6t3bQbSMOks2fVrkVY84NkHnbZBKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaJSwDsDQlmFvP+QvJfwunCS22TGqsKUihvQM9VJPLk=;
 b=D58TUF35shYILFmJv5za56x4JqLyTnBk7lZXScMNayHcAZMeZ5BclnpZAEAGIG0q3EOS7qTokIV1rAOY/uIkg4bJQUMz392puDIcEFMymm/JhQhjhI5EL5nGoXDVGu9EfQ/QB0SSLXfQACszEBMTo8nMPg7gKa5AEguCE2HNWBGyDxxy2jmZq1yG7zbvOIpRnVhPEmyc7pgrMLBVfuCk7c1diU9xwTe+ze7Eah+PG8AzFPUdo0sXQyL82q8OX0m//XJ3qYLkaIY0z7fnn6QiDN12hymtOLOa+LpLwZa1Nirj1rtAbVR1ftRBWb0eiPqMCTzzXsKNzKNqTgkY51jQLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaJSwDsDQlmFvP+QvJfwunCS22TGqsKUihvQM9VJPLk=;
 b=jOLNM/1LxFpdyMWC3xtLrgS78JDdtIWcvynKgpf36yZzW3dVHENQ/TTgu8eaq3jS+V7AVwmPX9x5n1RqqFKy8PgZaf04AvawS6v5sirQ/nED+FbAmjiCZ9qoOZaz5GCioN23TxEmsSvigsdYjrpNonnRw2ZWssThhtDWyhLX5sM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by DM6PR11MB3386.namprd11.prod.outlook.com (2603:10b6:5:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.27; Sat, 9 Apr
 2022 14:07:19 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::24bd:6fda:ce8c:191d]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::24bd:6fda:ce8c:191d%4]) with mapi id 15.20.5144.028; Sat, 9 Apr 2022
 14:07:19 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaehee Park <jhpark1013@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH v2] staging: wfx: use container_of() to get vif
Date:   Sat, 09 Apr 2022 16:07:12 +0200
Message-ID: <2419031.jE0xQCEvom@pc-42>
Organization: Silicon Labs
In-Reply-To: <20220408074424.6e862f3f@elisabeth>
References: <20220408032349.GA2132476@jaehee-ThinkPad-X1-Extreme> <Yk++AMDTu7LCbjHu@kroah.com> <20220408074424.6e862f3f@elisabeth>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PR3P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::29) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1a9f2e2-d1df-4a52-47bf-08da1a32429c
X-MS-TrafficTypeDiagnostic: DM6PR11MB3386:EE_
X-Microsoft-Antispam-PRVS: <DM6PR11MB3386EE5A762B99002BE0D95193E89@DM6PR11MB3386.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4iGkCHesWznUBFlQF+lIss2/k2LY/NNHLHSkOe/5hzAyBbbdInDLaAwqf/ZTW1TIL4kuuaXjXCvVuy0PrZhyKok4PtvO0Sr5iKzXQcjBbpUDLRge27JOuVfQbfwHyKzdyC8OZ6T8Aep9bq9iVlit5WxmjSTdydn/JGDRKBAhoWXrnGcKTUbu4t5Q/cl0Q8OyfHAaq+rPTEtmylw6m8MZHB0Yhv9v+KfE3dPrdawjdSY5fMczsVlnKl1k4HsiRUndR3RQytpsOvJBbREhUSdCwQQpYaV7n8pz9YcXjeD3h1/8USknRXO5e3VX1JbLxWmedK5nMyTCP2XknZuSzoormjFhKSWjRrDk0g6pm+Ch+lGHPlr8MYMLR79ZkdM8jh7z3XoWAp+9JII9GfNihr3cHPKuQNQP8uGIZALWR4Jj4B6OrHlDIbVigU5Wyf3EIERMFvrvQ+DFUqB6gKCT0xBB994sGM28TMfbZce6gdXefgNkQn4xKTk4DxFzUZ08yJHcYWKaBvQYDWqcO5/3TounmkjcFefhN3QkpvTuUzfFFmbO7XLFu+RnuMouyn4lgrD13orhlQo4sFUCOWFKSkc1spbyKKkpvQUGeq8shTQcWnl+cluxLPOLZHoZn2NK4Tu1rkhBRtgsgEC6ZlXOhZ1dFuCsnFGjAZeVONf9AmQkYkh36kIHmSlII8pe2DbN0bpLFrJPhI1h+aw4bK47eUZ6Sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8676002)(4326008)(66476007)(66556008)(8936002)(66946007)(36916002)(38100700002)(6512007)(4744005)(9686003)(5660300002)(186003)(86362001)(52116002)(6506007)(110136005)(33716001)(66574015)(6666004)(316002)(6486002)(508600001)(2906002)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?dOv0h82Rgl9jrxjGEJWwgwn/DFJVHpPkjkdeIRkvjUeRiDW+k9LkxoQOw0?=
 =?iso-8859-1?Q?jwGWNABiZQBlMFPKV6+7OhVNMd9L0Qx833II3bezoNsWmDuCz1zeIrz7Dy?=
 =?iso-8859-1?Q?c/HocCksh51S78nYOqGoU8mIhMBN7J074lts95y5bgLcz5d9yTT7Cq2rtl?=
 =?iso-8859-1?Q?i150rDh+BOMxnIC/WqvKZXoXSzh6YI1G4R81vFkC5krXZ2f4Gr9MLCws4f?=
 =?iso-8859-1?Q?XB14hgMff48pkScVs+78c+NVG75ytJ1I1Xla0CQfpKSZLhGsbaCZkn6vlL?=
 =?iso-8859-1?Q?D1Wg1ZEBjoKvt0HqCNfwOw99/+WXDEHEny1g2EoH200+UMD7AJpMNtjULg?=
 =?iso-8859-1?Q?caj1S1za/dX5rSY+vTcDlKOARxY+040PLrfDT8vuhAYoUU7bOGmeZgotY1?=
 =?iso-8859-1?Q?PEO4ekaIcZsfVpf5wwFTu/Ok9UeAbH0QHh3k1laxR39Y/JTz3HL5JiN3WD?=
 =?iso-8859-1?Q?y1sOwNz6uptpPlhp16s1EjfdeUKIgIySKim6ZX5Z+60tSKwt0h+n6BzjFq?=
 =?iso-8859-1?Q?y/+wSXzj7HXC/9IujN2Hn2HSCpSAedUHEX4Fgb8WTFl9029XEVBuZOLM3o?=
 =?iso-8859-1?Q?xmSeL2Jd4hlaUI+ST224qnMQXsmdcAEQeWZP+jp7KksnFxTHlS4K5jIyN9?=
 =?iso-8859-1?Q?8Y5ZVf0X7P+mdsIw8XGkRuEgOL3seMpQrqZAuiW3t8fD7qC5znPLMyfF9X?=
 =?iso-8859-1?Q?WOZaSXyexhidJo9CPROrHXOKfcksRW9yyf+uPeMSz++jUKiKUFyCQqdlcQ?=
 =?iso-8859-1?Q?tnMHh4oFqMMvkqqgXlhlZwuzJ9FbBM4Dzh+Na8CTzf2vdkXqQj0SXf11sn?=
 =?iso-8859-1?Q?oBQbcFn5AMBaAVww+xb8ITtHSRrwCeHbC0btKUVhU1whjg/6Vpn31kn0vZ?=
 =?iso-8859-1?Q?MD6M6qlhTDBL1tOMkzFNYZNAWGyxeHRb+2TyH6WVCbre6Q1hRRXNSvQAip?=
 =?iso-8859-1?Q?N7DgsECD4g91ciPjJ8lpUsjiOxdi613NZ8A4C2X0aKvtukH2YW5x2H+L/d?=
 =?iso-8859-1?Q?lvgyUDyy2qtqEbY87w1XWlZ7yIbeAn8G8xwSjRviqLqWIpXGYbxw2gzQCy?=
 =?iso-8859-1?Q?r3OJyVQpbg2ZqCcqlbgY2wmu9bwxu9ENq7tKDqX0X1ybVTgsk5wWMA5Jux?=
 =?iso-8859-1?Q?7eOYmPHQ9DFWE1tVxk+uw1ZeKYb0zAapfPD6HgR5xDkCdYHIXFu1ZTNm10?=
 =?iso-8859-1?Q?FIjQKAAJJb1VVMxG9FxW6v8TYYYLbm/vHbClCCVqTHw4ZbS4ocE0GWqEWJ?=
 =?iso-8859-1?Q?iiE9DBMot1o6Zgb5PUsHFdgg44l+m1Eoqe5jvrrX4UWU/Epk07HvpdHqJK?=
 =?iso-8859-1?Q?FNGOJ1/x9+R6BvOU3YoQkMeWpva1EWGbDYZSBmP25Mj/QiRXmSFik4g8fo?=
 =?iso-8859-1?Q?WeoM+1jyno0ElkpNlQ1uso4LUJ1Q4xSvB8JHtb0HToSEyG+y4GfQVWpOhs?=
 =?iso-8859-1?Q?AuJwAZmn/0o98HaHlAWS3ia5nqtjLHkSp0lAVcZGt/wMqp1BbpLSyi6aex?=
 =?iso-8859-1?Q?JNWeCvLeWNEvUXI0WjUV7Zgbgz+ASA/7duQqjUBczxJXwxijKcFvIpWa5x?=
 =?iso-8859-1?Q?HgQC5jCaW2WVSM3WRJoU97j8bJiB5d3qjOJUreauKLSJ4YW4LGoELHflAA?=
 =?iso-8859-1?Q?EuzFCDDrxRAZEwD1HNRSFkI3UE2f/KgR8cx2qDUrEmyrhe2sc4gmv1S4sQ?=
 =?iso-8859-1?Q?uF2KdiJAklv2K/p3jh7AVAjaCOVYvS0Rh3uBYHxLX+Jj8gCSqsTpX94iQU?=
 =?iso-8859-1?Q?TyXnkTuLcjacclGgeS6TNRgW8pRiyINYJj40OddGNl2WjOuuCC8qtMmk2C?=
 =?iso-8859-1?Q?J3geja6bNOIRToV/TtHyIY3QbdPs0L9vlQKPWXeJL9dFgmsZNsoKxPhY3l?=
 =?iso-8859-1?Q?Ck?=
X-MS-Exchange-AntiSpam-MessageData-1: /rPJneUQAucS5Ff5NlLrwN9ciQZ1+ncdUQY=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a9f2e2-d1df-4a52-47bf-08da1a32429c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2022 14:07:19.5977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66OZ5ecculhaLPXULL5FkkOfp9jrM/tKy+A5041FC6C4voyKkbFpb2ztlqRip98lgwGRTgKnp86VI8QurPJuGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3386
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 8 April 2022 07:44:24 CEST Stefano Brivio wrote:
> On Fri, 8 Apr 2022 06:45:52 +0200 Greg Kroah-Hartman <gregkh@linuxfoundat=
ion.org> wrote:
> > On Thu, Apr 07, 2022 at 11:23:49PM -0400, Jaehee Park wrote:
> > >
> > > [...]
> > >
> > > @@ -61,7 +63,6 @@ struct wfx_dev {
> > >
> > >  struct wfx_vif {
> > >     struct wfx_dev             *wdev;
> > > -   struct ieee80211_vif       *vif;
> >
> > You need to test this on real hardware.  For an outreachy-first-task,
> > this is not a good one at all.
>=20
> We discussed about this on the outreachy list, and I suggested, as
> Jaehee also mentioned, that maybe somebody (J=E9r=F4me?) with the hardwar=
e
> could give it a try.
>
> It looks a bit difficult but it also looks almost correctly done now. :)

Absolutely.

I will test it once the various comments will be fixed.


--=20
J=E9r=F4me Pouiller


