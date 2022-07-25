Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097CF57FF53
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbiGYMwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbiGYMwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:52:11 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2115.outbound.protection.outlook.com [40.107.21.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5767363F4;
        Mon, 25 Jul 2022 05:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQ2B7jqevvD+1KssV4tm99p64PZjIjAuAconcUJPyNqxHlN7S9UrsDgCefxbtBBY5/Ou1NN05H8UPibaYqI6u1NmTZc27Vl70AFR8mQ8U6KuVsp7ERwTDg7SvSv+YaGB4g0EofJDb+sbiEhbvocaNMMdWSBiQOSQ9tE5OgvLSlX6B2E8KCRXlVBU9xgJfBqHni+FNXe42w2SDkO06J7MgWb+mduyKNeR9dEfAU9e9em3lkDtdLxHAUcUEuRaKVq2re4gFit4c0mlTqxOQhNooPKLWDxPKaSgDmGWrP2EcP3BS6O+hsbepN4C/cpyqL6Kt8rcGK5zHdOvKUEsFJAusA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNXVl602WJVP8MaUpBciWZxu73mDg8C35PvtRJeSQAY=;
 b=a3rbGfrQyrSSn6BwpK6GVp3Y2z0Q0YJuCMPXr0l1Jpo5G+SmwcwPwQfnUisEtdq/bxFNMiahwWllJ985njtyfbwdnGDb/tfvzRc+FNYw4nyO8zejU8ogy5VnlJDgqmZvQUGWATvgYf7j+6p7Q4maFCSCE6dvy937lz1FaJo1J1jIHJxIcgDEn43YIHoQXHyvzmde6TMy9GzDegBm3hfoqFxBeG6hD7Nt6MjvCybBJVqxb1zWwgh1WcDv4iL2rAVgLU0OJ1GuxuFK2npk81y/zWfeTsBbAjEvBnIbzWiXpLUDY65taorBh2SbRCToqHZaHkMgvCKDM2JWml75vh6juw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNXVl602WJVP8MaUpBciWZxu73mDg8C35PvtRJeSQAY=;
 b=Z3dpJBhalg6vjPA4TXihjuD4c7f4qgvACnMBBBappDwYQTvqQJZ88gBt15X/ufmpjFxeEjhTRFPkSpA9yWWAdyPUA6sj24KThv91bYZ4MS1M/ZX0wYbyZ/UC/FEXj/eEmjUFEEfALBnY3UwoECuKKkhAp4ZHTYtcwnUP8TJZCVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DU0P190MB1931.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23; Mon, 25 Jul
 2022 12:52:06 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5488:868f:fe1e:ab76]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5488:868f:fe1e:ab76%6]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 12:52:06 +0000
Date:   Mon, 25 Jul 2022 15:52:02 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     broonie@kernel.org, enachman@marvell.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        lnoam@marvell.com
Subject: Re: [PATCH 4/7] spi: a3700: support BE for AC5 SPI driver
Message-ID: <20220725125202.GA5304@plvision.eu>
References: <20220723102237.10281-1-vadym.kochan@plvision.eu>
 <53b307a3-67e0-2acd-5d4a-0970f717afa7@wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53b307a3-67e0-2acd-5d4a-0970f717afa7@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: GV3P280CA0114.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::32) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43f5fe9d-b46d-4409-536b-08da6e3c7ad7
X-MS-TrafficTypeDiagnostic: DU0P190MB1931:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2f6PuFA7xSP1/8rWTm081jHCSdNr7Ot2TNl34x4IjFH4jzqXIY+4bFT/rng2Ck65OSjCbtXEtipcYgXAPolgfpEt3xo4ptFB0U58QMelP5xB1HEH0w4Sg5+55KSzwO6Sr8PJiUPGtJxJ40bP2fQA4fzuhH3NftpvdROG6BPnYStBMbBjv40WuibkXfjCcK3sfJ2tZ4w6kKvHVO3XJlmrv5hX9Atiuy8wNbqPAdpWM5gUQGBSKl3yPyRIg55f1crAj9oS4DjNlXEU3o0D3is1vLfnD9KIKQLhRFMHfWUWGgGlUoEusri+aZFIltpoa1CKLIzucvsRz1AFEP17RUSix2v8CJ2INm6IaTEWXBGme9aCCrQVtIa6ez64El0d2KLdca+nhTCDKmESWWPnpvNJAHtADRGDGRq/Alxs8Cw+xA/0X+STE9+cGeEi28TSbsaA/bdvN7WAlvB1Ua+SdVL5caHfGE8vxlKoyz5fDOVkpHlEg9Hb3TC+SP5rUtJ7ABi7hlECS6Gu0Y9hGdcvtgcG73eurI1WxCyFWJyQCT1PYt599h3Agma/Ea9ZoXTX++OuTycWrcSQxEUfa69Zn/2qPqJwAX7M6XFubCYv/AgJVH+Lw98ErxtwB7x7BnvBoTBQkddaUjto/cLY5ASbjUxHWmTPWVtm5Qu1zS1wD2kBiRjcky4fkENtFj9RXUoQF+vkGxH1epb8aTCwi93T8lm1W5PgfG+eFler31F1N4JCJ0d0ucPXDmlAFZZQpdKVzfj2DknUO3aigvLtmzA344NS1+W89XKUOj9vf2ON+FmvFls=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(376002)(396003)(39830400003)(136003)(6486002)(6916009)(41300700001)(6666004)(478600001)(316002)(2906002)(66946007)(4326008)(8676002)(66556008)(66476007)(5660300002)(44832011)(83380400001)(8936002)(186003)(33656002)(36756003)(38100700002)(6506007)(1076003)(2616005)(52116002)(38350700002)(26005)(86362001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yOQJflnkg2sKB2Iniv7t4NiE5DvKvh8HGLTgdaMNm81x3jgLRh6IaILAgK?=
 =?iso-8859-1?Q?6nJNOpeQA7TUghin0HwqXOcyVDwCEackk+ZDyV4JBEW3LZTNRRVq7Ytpus?=
 =?iso-8859-1?Q?WQ9SVZddCJJbEqL1eYLNnmfNDeZ4Xs8CUV0emuUcpqOARYkoC1lP7o5Nsn?=
 =?iso-8859-1?Q?PsJEjT2tq/lBVIRdc8Sfu3TMdKUuQfTGYc6DPfo6hTS4ECuHqwfyaEIqx9?=
 =?iso-8859-1?Q?g/h5TdgGxpw8F36s1IsqSKWYqiLH/4yeBmBFKbe7g34HobdBSopBbHCrQS?=
 =?iso-8859-1?Q?F8jrSe7m8cyBjv7ddtv2/yjuZuuHjVRV6fyDG90JH2OXpOEN9svBbgJtPW?=
 =?iso-8859-1?Q?BvU73/b/22IaPt7QKjP7wPGeJvq3MDUksAsGFDsw48cpCNCIXe0Bm9Mzfz?=
 =?iso-8859-1?Q?IvxbynxE2f6jf1tRAn9a3GeWYXDTji+I4ucTjLvhhp0W1GEl2GmzlAhpoF?=
 =?iso-8859-1?Q?ld5yqZgGDtSW/F3U/reCwDeo6/iMq9+kva2tIdBtwRWK9SAoRvd7lvI3t1?=
 =?iso-8859-1?Q?0ESrtvUzuJayCQRotcmjqWX/uzBl/cBp+szhtnsBPEiCWv0op03O+iLcUy?=
 =?iso-8859-1?Q?Gs9C8m9RSpHXbMidH+blmqv3W0BDMQmyTrq4sMnX4MSe+4ZmDV2H3fXTa6?=
 =?iso-8859-1?Q?9mTngIgiUM/aQSa0qSJbUvxitnnxLCkhpo4PjwWm0vbE3RP3N3O5GehJMJ?=
 =?iso-8859-1?Q?zLBNhpAmJYvDFmDBEguTpVtykKd4JQFSllQUetj8kADB3S7PfOz/aLLS2I?=
 =?iso-8859-1?Q?NOtwUjB9Q/QRLm8dFj522ZOym4y1GBHWQyptOnvVygKeIFfdj099qIcF8X?=
 =?iso-8859-1?Q?T68Q6o6LFWU+tKRXZx3v359U4IzLqPUS3dyo50rfYI49EiM9dch6u70K+E?=
 =?iso-8859-1?Q?S47+Te9SIvFUG2lNQvQXSlAmZNQjvNf2wRRBPl7vJ9qgDXx6+gyLsdWnwe?=
 =?iso-8859-1?Q?cCOUdvuNCd3lrWVhQ72mvNh+BNIAqhV4j/bvsEBcoUe9iuAzqcGvWZIE/G?=
 =?iso-8859-1?Q?eNOLIhMcXo4iAMryqSdKEu4eyWLv/7rs/HnApDUF5lw+3eA/KQ0rjsCFbh?=
 =?iso-8859-1?Q?fjNn57Iu3Ln+wfR83E5nRU92jcqmD6+a63AUvFLmnut/0BfohoJ3nx4RZu?=
 =?iso-8859-1?Q?n2R8i/F/MpF/WctNSRlC2BtzFgE3/hEy0vc35ZujXgga797bK/HX5dYK1w?=
 =?iso-8859-1?Q?bja5hAyPjvi+39UQ0X1XwXZjuJ2eebizFISU54ME+lEBKNnkL/I/k4J/87?=
 =?iso-8859-1?Q?KefjqCnUO3D+++e0ed2xYhSaXY5kYsvnJmz8BdZsYpXgG/7NJ0wsYGHCFe?=
 =?iso-8859-1?Q?DneSi5F22LLxEjL2VEiYhSSsuFEn2s8wgoHLjujoO/G/ME5JDFM94Htpty?=
 =?iso-8859-1?Q?/8QcyW9uTnqyG9edV6I/j4xDf8cXD/eK1FnDlytL+cLRSGw/3S+AFqxHVY?=
 =?iso-8859-1?Q?4Nmf0CDm+m+fsbD1s8oo980l8achQYZM0AVJXB4zTdsZuVn5vt5+oQABWP?=
 =?iso-8859-1?Q?i1TbwNxi4MPennIObJkcWFgDylv1PWiIbY+ChT/YsE4ZqmDMfTEkbicp96?=
 =?iso-8859-1?Q?Jtm3A+1JZw8jZDdmRvYh0oWdSEAReTF+9r2xvdi2hhmKByAAEeVnvmKe5K?=
 =?iso-8859-1?Q?NJ0R5D1DAxZTwC8IYVK+SSK/ZxhQdsjLY9K9wnj4L3mMYShvJduWVSrw?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f5fe9d-b46d-4409-536b-08da6e3c7ad7
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 12:52:06.6558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/3cu0OXJ8z9FRViiU7NcWb3jeB1NNLrCDWe6L5Snc4Su1AGcKrYLySWzykpTuE2E0wzbPhtfY1tAkGqc+hiYr+TG0z4bagwFlSddcaJNdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB1931
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Sat, Jul 23, 2022 at 12:49:55PM +0200, Christophe JAILLET wrote:
> Le 23/07/2022 à 12:22, Vadym Kochan a écrit :
> > From: Noam <lnoam-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> > 
> > Tested-by: Raz Adashi <raza-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> > Reviewed-by: Raz Adashi <raza-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> > Signed-off-by: Vadym Kochan <vadym.kochan-Nq3fbkz6jlnsq35pWSNszA@public.gmane.org>
> > ---
> >   drivers/spi/spi-armada-3700.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
> > index d8cc4b270644..386c7959ea93 100644
> > --- a/drivers/spi/spi-armada-3700.c
> > +++ b/drivers/spi/spi-armada-3700.c
> > @@ -497,7 +497,7 @@ static int a3700_spi_fifo_write(struct a3700_spi *a3700_spi)
> >   	while (!a3700_is_wfifo_full(a3700_spi) && a3700_spi->buf_len) {
> >   		val = *(u32 *)a3700_spi->tx_buf;
> > -		spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, val);
> > +		spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, cpu_to_le32(val));
> >   		a3700_spi->buf_len -= 4;
> >   		a3700_spi->tx_buf += 4;
> >   	}
> > @@ -519,7 +519,7 @@ static int a3700_spi_fifo_read(struct a3700_spi *a3700_spi)
> >   	while (!a3700_is_rfifo_empty(a3700_spi) && a3700_spi->buf_len) {
> >   		val = spireg_read(a3700_spi, A3700_SPI_DATA_IN_REG);
> >   		if (a3700_spi->buf_len >= 4) {
> > -
> > +			val = cpu_to_le32(val);
> 
> Hi,
> 
> even if both should generate the same code, should'nt this be le32_to_cpu()?
> 
> CJ
> 
> >   			memcpy(a3700_spi->rx_buf, &val, 4);
> >   			a3700_spi->buf_len -= 4;
> 

Thank you!

