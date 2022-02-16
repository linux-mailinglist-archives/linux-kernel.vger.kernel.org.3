Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67D24B8047
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 06:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344665AbiBPFpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 00:45:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiBPFpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:45:30 -0500
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17F5EDB48A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1644990317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BTs5n6RX81YnBQUYKticih6iQvMxAK1KN5lhMT72/9A=;
        b=SNoD9srgSPaJUrM3VQ0jI/zVoCOxgQmd7b5lW6gzZ7iIq+jIlWMNj1wFytzVHQXbjL+wIT
        bCzafB8JJ6kvS1p6ZYaegebp8vdVKj3yElEFGUeyeLRaFtf02qxvVIH7yP/fnQ5SWWpGLK
        nwoaT533P5igK2fdKnTm6O+HAsjxMhs=
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2053.outbound.protection.outlook.com [104.47.21.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-286-kY1ctJ8HMWaEGj5I2GcOdg-1; Wed, 16 Feb 2022 05:45:16 +0000
X-MC-Unique: kY1ctJ8HMWaEGj5I2GcOdg-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by LO4P123MB6370.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:29a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 05:45:15 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747%8]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 05:45:15 +0000
Message-ID: <378824ab-3cc9-dcf5-b9ea-5e49b57792a6@camlingroup.com>
Date:   Wed, 16 Feb 2022 06:45:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] serial: imx: leave IRTS disabled if using modem-control
 CTS
To:     Tim Harvey <tharvey@gateworks.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>
References: <20220214213020.685-1-tharvey@gateworks.com>
 <9d5cff18-5493-f6dd-4bd6-9bafa2a503a7@camlingroup.com>
 <CAJ+vNU0sWGsQa=YwLE9Ng34-DhJF=YR3oTV+q--KcgTMCjBa2w@mail.gmail.com>
From:   =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>
In-Reply-To: <CAJ+vNU0sWGsQa=YwLE9Ng34-DhJF=YR3oTV+q--KcgTMCjBa2w@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0481.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::18) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2821fa5-297c-4312-3587-08d9f10f81c3
X-MS-TrafficTypeDiagnostic: LO4P123MB6370:EE_
X-Microsoft-Antispam-PRVS: <LO4P123MB63700512410C29F9CE0F62AD92359@LO4P123MB6370.GBRP123.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: Li30T8KUaKH4MbIAnc/+82G0tjM+c/bQd+lffROvUu0oUWy9kjKQysZKEX07/y9A/Rt39NOltiONAg1nebf2oKMLtmZGKdRswB5hdMwKFXRkEQXzPVf7DumgpsvAyFE4Ioc5xwNx4XYGCdVg82W6l06BZ78r6h8QqQc4yzEl05BjVf3T5MPdZ95+dgq+QiZvZXUV+lb+diFRS94LSn7TUUXZsdbsm/+kjDLPbiB64CtkV+6vB98yUnivLJVierJsHebIz/5NIQ1DdkDkFIQpU8pDcc3gqLieeSfHa654hVlqvQqhMvNqPIAuezP/i0+Ba+hUUzLZrnPbucjX+BLWxvC+1+SSb+UIp/QMcMnMOvKJvz5KzJ0FbjwTV/5LqUxRGPbR2UdnEKdo4rk3yB5vRElpSewAXClxHKm9Tc2Han1HlTE7gDAxor5F+g13NVPOGdUpt7UYle2gzlwAbZgHsfFXw70bGoKhdLA2LrYN6z8xaScEOqVHK/1YGPJqEtb+Mc0Pka1Q2Zf+UfNse5/9BsxKseXbq4GOVYcwfQ6m+0ZXyvnTctE/6VuNsxRUAjzZgeAk4s7+/snSNxGAP4f87oUSdn82LUB+0Zlci9p878zAcCL/azxSSWzwwp4Fu3d5Vdt0ckJasQRnNW+RjLR2EEu69fWs21DVONqH5gxoadOg0a+j0JNuQsmXtGETxrUtJrfLTKdru5OzllESvOGhexvRhyYe8oYNRyHzm035fqKA1/fkoBqZe8y5WBwex+v2etNuG79ythQNS/5Df/jzIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(83380400001)(31686004)(5660300002)(8936002)(2906002)(186003)(107886003)(4326008)(6506007)(36756003)(53546011)(52116002)(316002)(26005)(31696002)(508600001)(8676002)(86362001)(6916009)(6486002)(66556008)(38100700002)(6512007)(66946007)(2616005)(54906003)(38350700002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4I19ylRA8C0Qf++kJIov8htgrm256J/K6XfnontnJPhb/DM4DaD6RKqCSUHf?=
 =?us-ascii?Q?seVEK+bfFr6McyhDOOw5a6J2NNekuP5iQzz0rG9X2nbOboPVEdgr4Uu9+pmu?=
 =?us-ascii?Q?BU2KT1cMq4niisX7RZTxa6gbfFpOdhEi5Fq3XcmVek7nvRkHkeQq23l0Rjqe?=
 =?us-ascii?Q?idtAJX2W4k8sUIIGGq77UNc88BucSxp+E0DPmraAj4dD5s8xPhU9X1EJEeCT?=
 =?us-ascii?Q?OHHQUFF7Yl9qX418rojxaecALErwS9kf+1M2Bors+NmuEe61atDA7FIPKOhm?=
 =?us-ascii?Q?aGzLrYiEhma3Lf+bYb1ixvkOgAEE5wb+uh73hOO1t2tDHqgQZ0irCjR4qgiZ?=
 =?us-ascii?Q?R6jYVPPSZPbU3AJQaADMYLvO2UnYrgW1AeA7HTr4E5PcCWYw+YLs/tzkber5?=
 =?us-ascii?Q?HlDIFqu6wI4EckfkWbLiNLUE5Cmid7/vDJkTxUl2acJH6BqrZMwgeIvFIK7O?=
 =?us-ascii?Q?RTBEeE81LM5qiwCfoiFhieuR7+kiFjYPPp3UfjWPVMHTZ3gTPhWxJcZGEuJf?=
 =?us-ascii?Q?M1nLswoH3MvFGRu7zS0gvbbYBxwx2SK4RfMOKx+g5WHPDX1Nwar57oOAbhRV?=
 =?us-ascii?Q?vt9Z1fsa36bFBFeJIoGDxpJPhubXZS5bE9DwfHGOwChtvkNx/VnzMC9Hn2Wb?=
 =?us-ascii?Q?6950sf5fqKGNcPGV8m4aIc56IjZW1kNVu0yRstehExGFaDzOB7/5lwQhcNnm?=
 =?us-ascii?Q?aQRwP5pmdAv528lcEwDIAleZT1XMkVkUVou/SOG/Qnfd9gOITxkON0sQW9BQ?=
 =?us-ascii?Q?2q0GN7aRtcuJ1eeevOG/q0TPZDdbzoOOB4GIBE7JDGMsi7+pIs6J82q7IDmy?=
 =?us-ascii?Q?Ak/WXohSEv8mJMPL91KvOH5j1+dh6XY8XPaUKJI9SUfHpU/ZG8jo/Qan6UgQ?=
 =?us-ascii?Q?gGpIY9oESGi78L5UOwVSsXZxk/UV9Cu/Phw/fVglE/jrKsc4yLK+QghfUZi1?=
 =?us-ascii?Q?Mavrh0Rjs/O79L09p3elnQQ4DO5urfiqYacWqkxgNKJBu15hO8vbALfcEJ5f?=
 =?us-ascii?Q?e55yH6mnUg+JkkcFJpXpp6ogG3jl5X80VAeJLeDDQ8PfpD8Wmq8w6xu8FhV2?=
 =?us-ascii?Q?AMyrmupaC4iUhLU5g6qa9sCxiia6ufKOJ4t82wZ43prF5H2QTgCAcd4oXImC?=
 =?us-ascii?Q?KSxNfxnFSz06R+Uq62Q1Z6co8NTNdCJhuiwquWSbwSOnyQ+teEa21v37+lNu?=
 =?us-ascii?Q?BpjZUbVWYxTf+U0tQXW7D9gBvs1FtbUkcSAf/uVnPLpvK19JeuensUOQggX1?=
 =?us-ascii?Q?05at0xJEz2X1jZ8j0pL/hSGjAistNp1X/T4/l0A19WqZlRIX1wpftO3aCkZS?=
 =?us-ascii?Q?xEs1LFUluA1CiJtdtWe97MGwP0EfSri06JG/WkOAFJ/jZTEkC6vE+zZ8fd/t?=
 =?us-ascii?Q?0f2tXh3IqtIa91cfkkhglG0JpO2HmMnXZSEVD/LD/3HDKv2jwx3P0f2D6wsH?=
 =?us-ascii?Q?O11b/mLpLj7j6JXCPABd9DxrJsyH4RBZQEJHosTTIgu4wusLcWmclS58C1it?=
 =?us-ascii?Q?ZnjXP95F6CHlY+xMHH+MhAg/tn8SyQ+z9lzjylroE4yv5eQlrl5i7FLsiL+r?=
 =?us-ascii?Q?vO8wH4rERWHQ/ba3fFuJJ92+Z94VjtaappfOX+H8AtC6/KuWu0+c5B6Z81K6?=
 =?us-ascii?Q?WZKv+JzHm47/3H+IDcxE7mU+pVzH3BGN/9f2gxls3NGBUPJ7CVSs66T7EHiS?=
 =?us-ascii?Q?z0uAHQ=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2821fa5-297c-4312-3587-08d9f10f81c3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 05:45:15.6474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjqG8WIS9sWPmIjdMTInneOI5Dm7cjIQgxZrewHgYzMQvPNgOL/vBYj+idvm90tjZ551Y+3no9NWJXDGKlwdfiVvihUhfJI8Tk0DpcnSKQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6370
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUK97A341 smtp.mailfrom=tomasz.mon@camlingroup.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.02.2022 18:26, Tim Harvey wrote:
> On Mon, Feb 14, 2022 at 10:03 PM Tomasz Mo=C5=84 <tomasz.mon@camlingroup.=
com> wrote:
>> This hardware flow control sounds quite limited. Once CTS becomes
>> inactive, the transmitter will still output all characters from TxFIFO.
>> Transmitting whole TxFIFO already sounds quite bad, but that's the best
>> case scenario where gpio interrupt is handled right away without any
>> delay (so more than TxFIFO characters can actually be transmitted).
>>
>> Does the internal RTS default to inactive when it's not pinmuxed to the
>> actual pin? If so, then controlling UCR2_IRTS based on CTS gpio could
>> halt the transmission when the TxFIFO is not empty.
>>> I agree that the increased latency makes using a GPIO for CTS
> (software controlled) not as good as one pinmuxed into the UART block
> directly (hardware controlled) but without this patch GPIO for CTS
> does not work at all because the internal RTS defaults to inactive
> when its not pinmuxed. For many applications the latency is not an
> issue.

I think I didn't write the message clear enough. I agree, that the GPIO
handling time is something the user has to accept. Usually this part
alone is not that bad though, as many receivers are capable of receiving
more than one character after deasserting their RTS output (transmitter
CTS input).

The general expectation is that the transmitter will output maximum one
more character *after* CTS GPIO change is handled by software. This is
not the case with current version of the patch.

With current version of the patch, after CTS GPIO handler finishes, the
UART will continue to transmit up to 32 characters if not using DMA.
When DMA is active it is much worse, as it will keep transmitting all
data already submitted to dmaengine.

As the internal RTS defaults to inactive when its not pinmuxed, the
software is able to freeze the TxFIFO (and thus DMA if enabled). To
freeze TxFIFO when using CTS GPIO, the software has to clear IRTS bit in
UCR2 register. Setting IRTS will thaw the TxFIFO.

Best Regards,
Tomasz Mon

