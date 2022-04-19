Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A923A50722B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354060AbiDSPyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbiDSPyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:54:33 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E27D1DA7C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1650383507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L1izphotFERJwJFnYB6CAB3aiE/a/CarygHRryeTtIQ=;
        b=VhJc1PsPospENL1cmBXx5uZC43pMiUhkqZSoJMNrseENp3dYnPE5SHP4k44nLqos05TP30
        X0Cs6SxISAHZ/nHpi39rivNe4WA2xVFJK30tQqT2P66sIndY6KkDthK3XuBZ9YpmyeicMp
        bKqA0c+Pj8McPOnLrqINz8gvI8eWZAw=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-mlRJyHBxN5Seahg1TkMd0w-1; Tue, 19 Apr 2022 17:51:45 +0200
X-MC-Unique: mlRJyHBxN5Seahg1TkMd0w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdHOzGGJmZrk2ezQMHpAdOta4iz/YYPEn0zURE5sCBdSyC2F/Rm48NjsZLzxX8nn0SLyJFluv0QIzvL0zzLXsMzNBfKEJspWcl6dewT4f60lbRrBHM84JpqWCcN2w8pzV57iRYpiAzQrvMNb0FLtzvlGAsWI9Q2NAxsObVmB4IDCKPS4EFVd0lw/B+S0e9Otyau7rEYndmUNOGkeWpdwR7ydzdqzHyUplF6SRZD0HZV15GncYTOs0pHkdrWgpse4oPTYM9bw3qUF+LtURcIX3UCQWwnqVjYZ/Cmram/P2dBGwm1coH/pE81++gpU0poXG4pV/M7zT5XHV5MI0HQ47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/r4oVTSdZGgndO4tf+oD8E3r7K3rsGbzv4JkK240MJs=;
 b=cPbznRpIiq2Oy2fm/w7qR9407ul88xwR21vJQlkG9zm+wRHxAcchNx6nacWe0fanHfD2tVWtfNG3TFh4eu7f/OvyfykY+n5peZ359WXjfJ+ux5/Uup07AH0nOWNarqXRJsn8CdTEzsPs/9cSzX/aDYH6p4Yr0UObGXoelJDlCCMapLIMI2UdQF8upJS3tT4UBZApmabdDxuKt80hUNW/FxZOM17BEAadGGodCmFxerybkNYJ4riLz3kpEtKIq8vpLE3mGF89x4LSA3GyjArbUKl+XKBI4jeLvqX4LoQhd6BZwEOLIWLrYTM6jHbEyTBb9LkcOb7TGNQ9v5/HDqv6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by AM5PR0401MB2659.eurprd04.prod.outlook.com
 (2603:10a6:203:35::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 15:51:42 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::8c82:19c5:ce96:491b]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::8c82:19c5:ce96:491b%4]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 15:51:42 +0000
Message-ID: <8321b2c6-5bdb-2853-6812-50cd4e4d1bc7@suse.com>
Date:   Tue, 19 Apr 2022 17:51:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 0/2] USB: Quiesce interrupts across pm freeze
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>
CC:     Evan Green <evgreen@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rajat Jain <rajatja@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Razvan Heghedus <heghedus.razvan@gmail.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Youngjin Jang <yj84.jang@samsung.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20220418210046.2060937-1-evgreen@chromium.org>
 <9f2752b5-8717-8ea3-1462-69bcfe42bb0e@suse.com>
 <Yl7Iz/lGk3fITzMK@rowland.harvard.edu>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <Yl7Iz/lGk3fITzMK@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM6P193CA0096.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::37) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ea8d6b8-ca46-4690-9108-08da221c7f4b
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2659:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <AM5PR0401MB2659481E8F89C91E50A5B641C7F29@AM5PR0401MB2659.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bDeiwGseOMWVUwpgEiekRLGww4MlryZ9FF5VELsui9kwxykEMe3SEpr9gYvP9pv5O67wXiYFDVkqGXLLuK3bKLF10ifSCRyM/QCh9NIkckYtnwN7pxN4ajacds9QmLxYLnMqXmTf71YL4S7wHuiLFdHnjqq29TSQi7WEQKVOoy3dOFM8xGnpsoq/p+6DYu2npfImc4oOQeYZ2eBvb+HRegORHJO/U9usdICqvlbWvKtCNYySReMWmXjPueLgen0b0YoRca4i/LBi9d6PietJ/Dapf092s06EX+uORVpCid6M8X7Mak62QaTaD3yVU26X9TI/ZMZUzWi34DrVLpZBgRmeowPHU7qgQe05i+/pFMBmKW7ZOGUmKuNsREIMBp9QD6Rfs7XP+mBoSVfpRw0J5q8ranSpWO55rmLFhkdjEsqnhrqAxA87j+OYTJ4h4PooHwgCQLjzOmG/veNqq4++xsd4K64H991aDu7NK2aeHPHdbc+/fHCAqMPnXnox5v9SeQRM7y4Z0pZSyrOUFFW8mhgn+Oj5LuCNfkEsAFjXa/EcSqjzFySQxT8DrSHC8MXXiPyBxOHHb4Ps9JNkA4BYIhqVO4923jz1Dx4q6Cspl24w+2cS5rL8gG/XwC1IPsRzWowMnKacKfLa+hXwiKaBoeuGQy+TXWJmQNL6f8dHOfzoWiA147wip8htFHDRWLEw3JsgPsLXxUfspASO1ETtqhpAX6YxHZin+NCogprGV0k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(31686004)(2616005)(6512007)(186003)(5660300002)(6506007)(83380400001)(6666004)(6486002)(2906002)(53546011)(7416002)(508600001)(110136005)(38100700002)(8936002)(86362001)(54906003)(31696002)(316002)(4326008)(66556008)(66946007)(8676002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ymIS91LMkwtUFtmSHkeRBFq3ZCYEkc+/OekTCUVu93RKtFbwF/tQbkcGj7vU?=
 =?us-ascii?Q?NTf+It09WyiXdpFDZrPTCehro5Fqw3ryvhuK2MLPvz8IbSueplZ2maJ7AZa5?=
 =?us-ascii?Q?zZbvys8HUDWPpJxmlGA0ahblO3+CLuDcyCx0jmcWh3IaD8a2OI53vDAxY0ti?=
 =?us-ascii?Q?3yzhz68vfTG0gN7wmwK2EjiUHSapihdAs0tTM4Sr4RAC9YWYG+24bUgbYUK4?=
 =?us-ascii?Q?zA5RpKQYXYn4NConoxmxCxfyS1ULGWL/rLoYmhEuigQECcwWC8g6y9aFIrWC?=
 =?us-ascii?Q?cSLDrHfD17cOL6h+7Cfro6cQHsZS1oisLMbeTIDgTEBZdLDiTMe2uOE/Wql8?=
 =?us-ascii?Q?Ohy2wjQdnhysz0P97WUV4nhVJKAo43v55xgKGuBKp1IlVSzhzWy+JJPXspQN?=
 =?us-ascii?Q?eyP/aaVgt6IqilSh1puQv47sXMkwF/D5jzrQWOsFfAseEdBmu0ynQJT3iOhm?=
 =?us-ascii?Q?0q5RbnoQDFolfisIIuktOmCaHZgR3H0ptFr/qjjsWKssMWUcl1O8ezdy16zM?=
 =?us-ascii?Q?HrYcNFYJmXAmAB97PLrrF4/vwKmMRg0RzAKSWNJ1v4SbY0sq9g4NKPHHEKjg?=
 =?us-ascii?Q?vZmjlg2T+I7yAanUo74K02ZfqirwyxMgatH9wJcATAcCaiSLp9wijclTSyiG?=
 =?us-ascii?Q?YmOIxRgpx+lvR1HnpigAdmfWL3x1jGxREIP5yt2JhkmrJwpf/ONUpPqD/A2Q?=
 =?us-ascii?Q?as9HaFTLF8DcniMifNkLihAcH/104eNA9ISSgklY3cmY2lNpl6dYXRVZYQuo?=
 =?us-ascii?Q?dx2uaUsDr3LCxX0z3cBb7zl4yEdlhioEatzRzVqY8N+XQOJVTKCX1UJK/bqL?=
 =?us-ascii?Q?DmZaKcgPsKZWnZ+md7XyesLlp53sLm+M5Ze9LgYPNcAD8oPqp5rq5o0EMpJ+?=
 =?us-ascii?Q?fkAKapZxE5IsXQY+YlC/f7f0a24IbJcFUhEQCb3/0gbU+EdMQbt3DuTniTsk?=
 =?us-ascii?Q?r9Cd0QAFxveCV39iaFbxqW1HaB0pD+JWpcET5kwQV0Y8Zt3v26H7Ysvy7OuO?=
 =?us-ascii?Q?VzanAXuEtZVsAcQve5cB+XnvNs+C3888CXpPv0kPrTtbFOxFb6hAO0WkO/RB?=
 =?us-ascii?Q?7qRRwjKnH0cV9sWNk1qXs8/swGY2SGwfY2ZJM9XbbWFwYznqrKgDYxGxjwnk?=
 =?us-ascii?Q?Sx7iYOrtUFqNUqWv0CEa8SrQmjCiA9UXQ2DEUkez9WYn8P8otTdCgVsD09aG?=
 =?us-ascii?Q?Bd0ca2YbwsQBwoUHtkAwzWaN4HnMrA6YBZkYDTKeeY+H/aaZEWKTdKg55m4Q?=
 =?us-ascii?Q?Mq+97hdLsRdAHgo484mXRRI4JlVdwKYPwVR+Lac7PD3PX/NSlDcAY9WkKPZF?=
 =?us-ascii?Q?4Al2C2hv4LEXCyqDsDqmWbZnF9o+jCaOLH0NLVHPGviwUzqYDyqZAIyTApZO?=
 =?us-ascii?Q?iGSnQJZvGWPLtrWKVJLpLAFlN/aenuAf0cUWZfrNAGdC0+1MRE1s7dVlwqbp?=
 =?us-ascii?Q?9PXAGDxUSAabE7EadXsnUGZF6fzSaXTFVNlBz5sZkFiekbURVrBCSlr0+eoA?=
 =?us-ascii?Q?gV20rvxZDV3UYIlexYZKhkNOl+Pg6B9dUuJsuiDTxcxG20xWfIF+EYkVxoP7?=
 =?us-ascii?Q?YD5nFk6JVPrcx4fVWUmbyDh+jDHMr7N4Hf/RHtNmrRC4+drWgv+jJKE1/rSg?=
 =?us-ascii?Q?sGjw8kMtLa2vQVnutcus1KzUjy9uAOeTpWwpMPyl/+2Du9kOMcT7m451RQ/b?=
 =?us-ascii?Q?4C60u8UsLWe28oS7HlNa6KlDFtpXuFf5B4EmPEpslOUgazznZswCZxAf9bV/?=
 =?us-ascii?Q?9UnCt4nve9QW8mG/VR8yrRt7c8oP9glmvlz/r6QLSqlkLEDGTHAggprcFwXa?=
X-MS-Exchange-AntiSpam-MessageData-1: 82/EwXKBhezyig==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea8d6b8-ca46-4690-9108-08da221c7f4b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 15:51:42.0496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5na8As98xcSlUdb6puuEOp8q+HcgGDEgq4Be7q1hUPIdcur0SVnppCmO90oYehvcTEH5UohQ1xOUa0wO+v/FOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2659
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.04.22 16:35, Alan Stern wrote:
> On Tue, Apr 19, 2022 at 09:05:53AM +0200, Oliver Neukum wrote:
>
>
> We have a set of quirky devices that need HID_QUIRK_ALWAYS_POLL.
> They have the nasty firmware bug that, if you suspend them without
> remote wakeup, they will crash or reset themselves.
> I am afraid that has an obvious relevance to your cool patches.
> I am not completely sure how to deal with this. It seems to me that the
> quirk will need to be shifted from HID to core USB and thaw() needs to
> be translated into usb_device_reset() + reset_resume() for them,
> but I am not really sure about the optimal mechanism.
> We may not need to do anything.  This patch specifically addresses=20
> hibernation, not system suspend or runtime suspend.  A device crashing=20
> or resetting during hibernation is not at all unusual; we should be able=
=20
> to handle such cases properly.
>
> The THAW part of suspend-to-hibernation is used only for writing the=20
> memory image to permanent storage.  I doubt that a malfunctioning HID=20
> device would interfere with this process.
>
True, if and only if all goes well. At the time thaw() has run writing
the image to disk can still fail. In that case the devices will still
be needed.

=C2=A0=C2=A0=C2=A0 Regards
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver

