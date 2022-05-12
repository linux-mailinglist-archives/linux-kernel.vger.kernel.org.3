Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94CF5249A2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352326AbiELJ6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242619AbiELJ6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:58:18 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9C322DA3C
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1652349495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lbHGPAq29nFShlt5lWOpyfIMtk3fCo+d12TNHCHf7pc=;
        b=YlgpOAFLR+EShPoDecvpL63BHBjl5w6UsivQBEx3TZNRh701SMFOIkfZxAENwzJMr4qZva
        jyaV92E0yQ+NhLjxj+JDVB4X2Pnj8lTAE7goDjIzdMDnHVmjRevloD8wGsRUtk/1HIKwQ2
        bHzMPMvkXzgU7VHXpK4JCzFMYive62A=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-OgycDxIzN9etk7y2Z9ypMw-1; Thu, 12 May 2022 11:58:12 +0200
X-MC-Unique: OgycDxIzN9etk7y2Z9ypMw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwQM323yx+NJkwbc4cOs2AND4TDfsWQuJIf1G606t/byhHW7cAlg9+cjkJgv0eHN1cMF57rDcZVL3Pv5w3W6dRGbSr+iS/k7yTXT44hh8IqdxITeF/bW+3TCmwX6VEaqFRH1XrmmseuGysXAyYTvJ/sHUN+FynYiJ98vrRVeE52WMCuRE0XxCFW/IdReQ19JkugqqnlNMxQOUfx5eGxeJUan3rYDkLSFJiFXkqgCS2Hb9fsQR4sshcS3QMOQbeohasIW7TxxZfoqn1KIFaBXjo47s3ln2wnrrry8A+RKIQ/b+A+bo0eJbgU+ZpB+sW/+zQirtbeIHbIsX2817goEJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbAg8OpAozI3jCFX33T0VaketbiUOB/F0s0LytrIsIo=;
 b=IiKBBH3bLfZk9UEDwOZsmmsFjvGj1c08MPL1S0caxKSVfgchneUny16sHU5IhRMYJaz/2on3xUjhWwXCzv5wPpy7/PBpts61xmqW0VKNyDfwSA06o7O53WaVaWBgCaEKrLraB4SRafgE41bfUQC02qrc4rziZFaJu2aivi4Cx5tnu+VDRtr5wbh/2clJOO97clupBFN8hUn/yUmukMcADzRiA9NuwBKrXEwqgOwuNjQpO/v8MD/NCHP/1sRcKn2WSixnfoSHD1oIENvOZfemis0kAmujh9+9t9cH0KkbSnI2SC6Ap4+oC4BPK2pbv3RbJdgIWm8SQtUZpxiMsyYwIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by VI1PR04MB4574.eurprd04.prod.outlook.com
 (2603:10a6:803:6f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 09:58:11 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::343b:67a:e003:8bbe]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::343b:67a:e003:8bbe%6]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 09:58:10 +0000
Message-ID: <23cf0d6b-3577-b9c1-e20d-e54b6823f309@suse.com>
Date:   Thu, 12 May 2022 11:58:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drivers:Modify the return value to void
Content-Language: en-US
To:     Zhou jie <zhoujie@nfschina.com>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220512093210.GA6602@localhost.localdomain>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20220512093210.GA6602@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS9PR06CA0750.eurprd06.prod.outlook.com
 (2603:10a6:20b:487::29) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c6624a5-5368-403a-7071-08da33fdec00
X-MS-TrafficTypeDiagnostic: VI1PR04MB4574:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB4574A3627544F058D8EF95A8C7CB9@VI1PR04MB4574.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7fHvlx1C6h8eUzd+qSExHZk+JFZrHRoXMNvrl611N0f3ETiqjW/+TtMfCJsOMevTCpjrugesIaeCaa/Tto3mTpca8J3YA8wWJjKHoKRV3rSX/a8bjTUeCa1Sm4Dm8iWO3cvHvhJHUDuXvlv3tK5yVx/ivCAPMw9Fd9yyE9jaHxXar7U45MDPqkvqqckUZTympRHNnH90rtDfUAels64vacfD68AxNTXNFr0nngFWnfPiO1jW09d5F+VS2uhlx8xOhs8/WZ2xRH32qvHisLJ2Zw1/WsNB0GVFYk+zS16mEN71YhBuyOoYLAMGo7BN0F2p4+aKB2at5FvYD4+ZgBt+jCSPAPCKoncYbBOuzIHiA+qyKQR5aaGw+T18WMHM/8jUXqYiYmYGOn3WMI9E0JeQLElQVyXBBIo3CSnNeY3cijm8GnJRZ3/ub5wZWfy2DXg1p0KQbfqphTylt4BX1d7OQxGgrm4ZoMUdLUfCxB5iGH3qLOLSTYfWi09DQuOc1YnBd4m0bIatm+uQ8EO/JQx9dmQivcGpFKDtyqqISLDgcAL7ShX9NA/RuZ708fKwNkSSzAPr6g6stw1qNq17o783O0HBYBMtjBfzNC76sTimtujdhmQhLjSBUJjln8OswtXINam6GlfBRYOKTYi6H0Cq/kE2jCyR8bbTma/H5kAzSq6HpOPozk3DfmqIVlbxHZWrrFcqP/UC5coOhd9b0NuURh61QAd0TgZCg9u4HaIfb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38100700002)(8676002)(66556008)(66946007)(86362001)(508600001)(4326008)(66476007)(6486002)(110136005)(6512007)(31696002)(6506007)(53546011)(2616005)(558084003)(186003)(2906002)(8936002)(36756003)(31686004)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SJyfhD/d9Nqmt6mFl+L1R+ut3gwyFahxa1ezNbpOup9MKNGHP+TKhECdXQR9?=
 =?us-ascii?Q?MZIDKYIvTK0Wjt/dDFWJYwCfzLNay5mY1HhkWS+YJ9ZaZY/WR1z+Y5UYj5G0?=
 =?us-ascii?Q?vdEf7vxsJS4CF0ty4uF4AJJNZDtStrymKN7dkbWsoPYa+6JSP8iD1n2UEhuR?=
 =?us-ascii?Q?kMCMPah1wDfjcNMQeACEBKj59MgEd2ShFLbLnXONQbGQM7C745fyl5yJNd3m?=
 =?us-ascii?Q?mWkOsmz5cBj9zaLPBm3wifYuyLtu9vt4OeA+A9ER6EO+snaQW+whClGcfx8i?=
 =?us-ascii?Q?9mgk+zKKkA7QdP//GI112dgvkxIT+hVkkDgsqjX4O0vlkYhW4Lu0crEj4lwp?=
 =?us-ascii?Q?zXypjuoCyitMuiExHsLboRb0qxiYcaFjHQap3uP53dmF6tYi7bUQ9IX/0zVr?=
 =?us-ascii?Q?JlGp9iIfR9Sl7qF4o9yVi2Y4oV8E7+UTeLOsMPxkrXIgMjw29EQDBHBKaqjE?=
 =?us-ascii?Q?YNncxE3Gks2DNHLqeyuqn79OpGPxbzSUjCmvlzi02xLIJI5y2p0m6TCijX6m?=
 =?us-ascii?Q?y3QcgDnZyTXpFp9VhU4sSPHxhjyXSGaAXFZvL0WQ2CTKtGbADnOpZT2xKpKn?=
 =?us-ascii?Q?2S2FiKtfX3K+TioVTe5+3c+R66khbvy6iTreUcM+nJlFlDqsRSVYeUkdDuDn?=
 =?us-ascii?Q?IdsPvThDnWEXFbHGlgzwD6bJLqJ8u0Ho5q+4TwY06mWH/iHi5BY7BDHyxaIH?=
 =?us-ascii?Q?8Yqg1lzI4muy/mMDKCYvM/s6/AdCVa1oAnM8e74Ri5YuXMROOstvcRnCR6OU?=
 =?us-ascii?Q?UqrGD2EaeDI1Jpbl39rePjdXYdYSILpCVE6pConq9AVmt3YU3T3rOeLF5KKc?=
 =?us-ascii?Q?RG96mUd5dUq6g/fL2n7fQzw0PQCzi+7T2RhEQV7Piw65wwM0OnZt8Jxm2yl2?=
 =?us-ascii?Q?9pHj68lPGSSEDeSCezU8Ucs+OV4DIW9V0l+4pdTAkkhm/+eN2f1u9iH4kPvw?=
 =?us-ascii?Q?5S6OeomQBjgVXIlTxA6JsMDPwFZo0L90El6hhrokf4nKwJZPplE/rsNMWdo1?=
 =?us-ascii?Q?fuVQhaGpRlHyS+NQuuEy4IYb8trl6KLZcyaew2nduoDUqSL6EsT9HaPr9+2g?=
 =?us-ascii?Q?WUyZUSVVFjj7U8JW0N5+HBXTThfppUZqpvzCAuGOcELo/0zDPjLLb5rfpgG1?=
 =?us-ascii?Q?NhtkEmYxCZHzdwZOv02WVCCv6KAdO4kyxbL0W588cl8kxLZKtc8FwHFMma3x?=
 =?us-ascii?Q?DPoIe2KkVp+UEI3ttWHJiwmKNkmV4wYKha8d24xRvAGcHL9VDtt4zXcBTJv8?=
 =?us-ascii?Q?15VVlp7/+hOZKYterGkrUuPu9n8ItDmbFJjUilfyvAqEfLYgTliFgpgv5k3d?=
 =?us-ascii?Q?0TaTAERYIArB812L6ZQcJNZOUp1roBCWlkauo8w6TFBj5t2j4edCd5CBF5Wh?=
 =?us-ascii?Q?gtr/smmLuYBSvs35NOIGGvTgHranohay8OKbbw7s/cq4eZbMg+dt2J5vTzXI?=
 =?us-ascii?Q?8mAq8A6ZgJwvKyxzRFG0qDp4FZR7N5n1XDTMPvjmCDleFMec/BLwr6X1SzmF?=
 =?us-ascii?Q?IrTGMj02/t0BF8XagCfOTf6mL1EZpvu5aAdxSYFbRDPUQAiDIAEosL8NUj1k?=
 =?us-ascii?Q?WpRJXcdapR9IYbZKIPlEO2qTADoTaWya2ai6jGdStCGCtEjEr/1qBcUGw7fd?=
 =?us-ascii?Q?e+71A7yWoYvviWP+gOu0RB79T1snJVmx11NG/79e/mrP/V8odKSU7RNvlwt2?=
 =?us-ascii?Q?t5f12AMTyUQtSHj52PXLa35gtX+xh133dX1/FLLFFC7evXi5mdKDZtQXgwGp?=
 =?us-ascii?Q?H+XmDYhUUHhE4nRTCVpD62sMY3O/GiKI4ePYEK8uwX9nOZwz3fHAo/bfIh2a?=
X-MS-Exchange-AntiSpam-MessageData-1: GVPbYmhkSvlwPQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6624a5-5368-403a-7071-08da33fdec00
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 09:58:10.7728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4a5P+mU1jBw1+X5HjF2hqPWRh7vmmsuuMmDfK/NzTAIhEepWkjUQ9s+v4Etw/92V02vqrHinICm+ttjKIqfdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4574
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.05.22 11:32, Zhou jie wrote:
> drivers:Modify the return value to void

Hi,

technically the patch is obviously correct. Yet, it is not a good idea.
write_mos_reg() can fail and hiding errors is not a good strategy.
You'd better propagate the error.

=C2=A0=C2=A0=C2=A0 Regards
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver

