Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD74583ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238525AbiG1M2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237660AbiG1M2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:28:37 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2130.outbound.protection.outlook.com [40.107.10.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657506A9C0;
        Thu, 28 Jul 2022 05:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnVkY7grwtSd7upN70v98noSw5pur1xHKHe6Iso/Xz9JHel0dsJgDv1bBn67m+xFRfXQZNMnVr6s3pYScVd+WnCuUEmHd3q6dG6FOTUm0t8UOwH8sjxJTyOgvRpcX42G5/7pU1zs9thGiMDSb331E99QD3AVGTfm06MqafPKNj7WrONsvCf7opFVgB/EogPtkZ8TtBU9eH4nESZsfTqgc6Ey0i2hLX9k6Q62YnOWCLdlipZrw5K2bks5i5zz0rR9QCvTOoDuFfjlKNw/R7aiyEfEPocpghghORnlz+qxSNl+fApsRUlfbZhHKMeZ/HbLSR5WaOTcES9G1k4eSb4KYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jn9iV1nNbRKFfkFX7cFLbJfg6LNrD/01+KdkKZ3HM0c=;
 b=LMR3hBk1jkPgXIFOYVv+7yr02bh1FQ2bIalqRCdHSPk+MM7VfCv8wDopVb+FZrPUwpD1xeBCR+S5RhhdAZuMloG0T1iK5acLuyiuxJBrVMUk30ZYyWcIwMy3UlN7e7wmrqd4X0UXBi7bT8+yq4qyXpq4kcDsOG4pkfkQ1PTIN82U02CgUULrzLVfMfYTlEa48VvieDAFaYylh2DUmTNjdr62hppC/Sq1bdP+T/Y+LtyxnIu2Ug5UL/Kl1sAJKsJM8hiYbDXxTimmiWy52DWYTaLIvVyra05fYAx4vaGOXJSYTL3thcZXFY+sWC7d+qr2O22Ojgp9X7NhlUPJYZ7bHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jn9iV1nNbRKFfkFX7cFLbJfg6LNrD/01+KdkKZ3HM0c=;
 b=OfzcrFdSwKNAD1FpOpeRHHI+bSblR006Ag5sxdtdXVX53tGxEToez44jRJ5rGSNaNy5WULWCxdkHegDxzT41664CCjRyhHd5IsbFYmWyzaH2Q5NpLZnx8qMYLszMYXexzWoTsPWw0qb9ZQI35jnyKGJQtTwzevvG5hMCBC4DaH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB4051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 12:28:33 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::d82f:88a2:e7df:453a]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::d82f:88a2:e7df:453a%5]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 12:28:33 +0000
Date:   Thu, 28 Jul 2022 13:28:25 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Olliver Schinagl <oliver+list@schinagl.nl>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] [RFC] Rust support
Message-ID: <20220728132825.000017d0@garyguo.net>
In-Reply-To: <YuJ8lWGKXEk03u3M@kroah.com>
References: <20210414184604.23473-1-ojeda@kernel.org>
        <fae4873e-2ff9-df35-0ab9-34bf4417b717@schinagl.nl>
        <CANiq72mRxM-7griYF+0FWqYoSoNL8ad=L-i6a2-GsaCeb0C6qQ@mail.gmail.com>
        <ba8cb315-9d73-2f45-8bf9-d9473d369dca@schinagl.nl>
        <CANiq72kz+Txauo+103_-fN_J8PhhCdJUH5XepShUQmJzW6a4tA@mail.gmail.com>
        <5c0bb1db-5589-32ca-ac22-4aafb3c15751@schinagl.nl>
        <20220728112114.0000003a@garyguo.net>
        <YuJ8lWGKXEk03u3M@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::22) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 418244e4-3c1c-4ac4-72d5-08da7094afb0
X-MS-TrafficTypeDiagnostic: LO4P265MB4051:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SsVKdxAf8LO/qCtnQ6mhGXsy1mRK2v2/tt/Z0WkGkFqQ2Mbc7bWfcqtP6PVhM6bWvBqb6ls2lkGcLZ5mM2k8TFnfsfLrXbNFApC64N8WB1rfy5Khsg9DPjiXCTBY7UugMQEJi5mLRwD4cDxCYaqDS3oOvXYxkoAVbnVj/Wn4RA8RgsnNTSXuhf9reVl3rnk3ZrR1vkxrSWX4D3OZJCVZx/DO2+nszGxEPJEWz/zhb/vtdLZUqva21Rt/EjETamlcARaPK556vhYKwXAReDQ9VSZ8Ag1Sf6CcPnWPJeQMH9/EbNHSxjFBZ+roFf32uSo5rbeC5IGS1knnxrqruas3ELwhgDJ7C5DXqjnEivbCDQWywm0VCN045dpVN4iVZILNPxKLuFsSnuqbfhCkLcRss4MzbN2FFbAN2UzKfRu+mV5reedx17FZrf73tvARdvhJ3BXBa/xTZHscrTyOZVJMHNdi2Y62qxYGmZkXFt4FuXaGNe+yEIBOf5UZhavoBz0ZvDYqyhYGGqw29spZVentaSNvffsj/eRwfYy3+Uh0YhcBa/ejyZKvZAYx0JrkdZ0M2CvsuHTcnaUvYY+oxUEHyXGvloA/vpMNE9DcKz2clo4CIspFoSJ1U+hRUndtELI39D7/buZo+AaOnRi2Ls4y109X1iLwtY6kVjMpz4Lj6VbDQMv7nC/RYf3vhOfd0Wfn5qYwuSKoDX998aXGG3QKFFtfgR5uDAHvwhN+vgsJFnc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(39830400003)(136003)(366004)(346002)(376002)(396003)(1076003)(2616005)(186003)(4326008)(8936002)(38100700002)(5660300002)(66556008)(66476007)(8676002)(66946007)(4744005)(2906002)(6512007)(41300700001)(6486002)(478600001)(6666004)(54906003)(316002)(6506007)(52116002)(6916009)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mq9DNAtK9HvXCbfUMDxtqkQ3lAxAVKRG0PLmH/AJaChHGRc8WfiDwL6YR2qV?=
 =?us-ascii?Q?saoUKhEH7S61ftXBakMyZljlD/8nlEbQ+DHQEXkPCjY7kE0KNe96j1dTm8fB?=
 =?us-ascii?Q?QyLRPrWaDwm4a0jC072OF1v5FaEv2zTvEcMUdL3UT2qg8l/REFZ8Jw/vI6y8?=
 =?us-ascii?Q?/yfwR91Vv/EwbhzHdpsIdjDGCgIE84HwbSCqVcxmM9OWaasg95pgc3SptArP?=
 =?us-ascii?Q?NLwitthtPf/X+20LP2M+sjkdBk+YLWYAdc1t8co80XZ+6FBKDHT5lBbcGA5U?=
 =?us-ascii?Q?f39rvhsSTnQjP3znZcE0VgEsthZoyBN8aKREDoxtPrSM9fCeFIkiXQ2gBRf4?=
 =?us-ascii?Q?IlEjS1lqTXFWDfoSWYxOtKVE+/biYOSMwk1wHRJDs8rg8NgI0XmnN7h835B/?=
 =?us-ascii?Q?/rsPv2LD3SPli2cdiyRaQnED9VB84fcwCd1T0i3SkkZe8aK6StPHi3Rlj47v?=
 =?us-ascii?Q?GBHKh0lxNrmlWgILocl1DDIO8lrjkjscftSqU7ad/zmF16uxbPLxoMP01cG5?=
 =?us-ascii?Q?J5a9d9ffSKv1N96OHedcJEo7bPVyjR9EIxk81iWFZk17QEtPkIsFcGVjtbrU?=
 =?us-ascii?Q?XLCoGxKhNOwVLB3eg667mH+XesZOY3qDxlzMNslONzCEchnNBRlkfwEyANry?=
 =?us-ascii?Q?agSb1cfbZJpKmE2b17eOcT0xts0+E+4HIDr4pI6u+Hf+ewGo3vB3k8PB1gX6?=
 =?us-ascii?Q?9pYwcgzRIzwjwL5FGwGn+mvWv3VYcMBiQAsRGhArIa6p/0o6OuQ3hp9Ko7ls?=
 =?us-ascii?Q?NWCjPmPNYxLmr8c9HCsCBLKQBbwtyUnFAJhsHXpD00iMtaTCcObGMafnt+VJ?=
 =?us-ascii?Q?xDc4sTBNG2TxEoI34QAWrxjfCcubvgw2tTs0W4il5G//W6g7UNu2L8ZyChwH?=
 =?us-ascii?Q?mBLvtcCkPWkc4Z+/k1erB1i7xNFRLhxawhza5RU4v0EtwkNFcs9JKUjB/kjD?=
 =?us-ascii?Q?XpWIK+GuK1hQycNhVjq8asHIB/Cz4ud1X95oWC/rSn8A/arupYYKSa1GCQki?=
 =?us-ascii?Q?8T4a3NqzNACVLokGMnP3on+glUXDidjxoWeuiu9FlEX4vOjyFHmldxU/jrCp?=
 =?us-ascii?Q?li4ecNhMOqyT4f+5sbvVZRfBVhTqhEujztaQcd3N5be81RnXYfZZFLYEN2fY?=
 =?us-ascii?Q?tc7zglL3MihLoKikA4KZpMH8ZecEJDa2ICRvG+WVlDzaiTN7Sk2VSFiJQzae?=
 =?us-ascii?Q?8HBI0dP1Xg00A9kek7N+Ot7p8zLayaLWnHMEB7Rw9K09Qy4tf3VboKVWhPOQ?=
 =?us-ascii?Q?bEbydNRYFNlcfImDlEAdFw6+1vTU+0zs7dNccm525eLxq5Fe7ReFpjAtQXT3?=
 =?us-ascii?Q?nUlKQ6X704YoppELliFYILstKhKZMfKPuTOThDH0fSXVDj3KVxM7ji3mVkE8?=
 =?us-ascii?Q?mRFV3i5yBdpD5khGD7Qs4FFentGw7SWB5bdHmHQkezX4FlfxePw6VlEf7/N/?=
 =?us-ascii?Q?Xe/iLvynJd+iDNAkTjK40OvFA70xBt91pRJXPIrWxy4bMdKuVoEPz5qQHFyr?=
 =?us-ascii?Q?Jpp59QOkrB4UXS9JRpxzgeoS91fiWjk4Spc/+d1NVGjfKfRwxPSoI+CAb5tM?=
 =?us-ascii?Q?k+q2yAywR7JVYVjvglUi0228ANNAuyRML1IqjBrs5vGJCzUllEhUVNnfEacw?=
 =?us-ascii?Q?TbP6sYbJGd+KEKIlqgJzwIdMcGzaKSEJNFubDerpw2Bg?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 418244e4-3c1c-4ac4-72d5-08da7094afb0
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 12:28:33.2500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmDa1g7VOvTzk2bq5h0gdXn5k+r/8KrD4gvpFZwYWPAcdTEwK+y1q52W5ojmMHBrrWid4LxY0RWELTXPkZYWAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB4051
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2022 14:09:57 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Jul 28, 2022 at 11:21:14AM +0100, Gary Guo wrote:
> > Rust requires braces around branches of if expression, and C
> > doesn't. So in kernel coding style you often have:
> > 
> > 	if (condition) do_something();  
> 
> That is not a valid kernel coding style, and our tools should catch
> this and prevent it from being added to the kernel tree.

Thanks, I stand corrected. I do see those patterns occasionally so
presumably that gives me wrong impression.

	rg '\bif \(.*;' $(find -name *.c) | wc -l

gives me 3362 results though. Most of them are from fs and driver
directory so presumably they are vendored or legacy code.

Best,
Gary
