Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BD84E3350
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiCUWzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiCUWyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:54:49 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A03F82323
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:38:10 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6F11322175;
        Mon, 21 Mar 2022 23:38:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647902288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TEMN5oOp8pSsz/f4qOvx8LZ7Vw8/HeFkF2XWTUYxriQ=;
        b=BtjgrziDWJyVywDlXY3kCqPTQGKAeoqqVoErY5czyswMRNwE6++zFd01lSfoevNWfORAU5
        i/34WLLul0p9ATWtQxhvb+Vn0AFDBI1eMsTVPpa1dO6fTGKbgAz1/OXp5tg8JVT2C9ybC8
        g52amaC2MzGEQUgacAV4Gb8MPSeEsVk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 21 Mar 2022 23:38:08 +0100
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor.Ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nicolas.Ferre@microchip.com
Subject: Re: [PATCH v2 3/8] mtd: spi-nor: core: Use auto-detection only once
In-Reply-To: <20220321174251.ehhobu26tgoxrbps@ti.com>
References: <20220228111712.111737-1-tudor.ambarus@microchip.com>
 <20220228111712.111737-4-tudor.ambarus@microchip.com>
 <20220321121455.bpql7x4ebhq7s36l@ti.com>
 <b4e8c044-f16a-a72d-6047-c42cdcc253f1@microchip.com>
 <20220321174251.ehhobu26tgoxrbps@ti.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <148e6c16421e6a94a2ee41fa251130df@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-03-21 18:42, schrieb Pratyush Yadav:
> On 21/03/22 12:50PM, Tudor.Ambarus@microchip.com wrote:
>> On 3/21/22 14:14, Pratyush Yadav wrote:
>> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>> >
>> > On 28/02/22 01:17PM, Tudor Ambarus wrote:
>> >> In case spi_nor_match_name() returned NULL, the auto detection was
>> >> issued twice. There's no reason to try to detect the same chip twice,
>> >> do the auto detection only once.
>> >>
>> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> >> ---
>> >>  drivers/mtd/spi-nor/core.c | 10 ++++++----
>> >>  1 file changed, 6 insertions(+), 4 deletions(-)
>> >>
>> >> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> >> index f87cb7d3daab..b1d6fa65417d 100644
>> >> --- a/drivers/mtd/spi-nor/core.c
>> >> +++ b/drivers/mtd/spi-nor/core.c
>> >> @@ -2894,13 +2894,15 @@ static const struct flash_info *spi_nor_match_name(struct spi_nor *nor,
>> >>  static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
>> >>                                                      const char *name)
>> >>  {
>> >> -     const struct flash_info *info = NULL;
>> >> +     const struct flash_info *info = NULL, *detected_info = NULL;
>> >>
>> >>       if (name)
>> >>               info = spi_nor_match_name(nor, name);
>> >>       /* Try to auto-detect if chip name wasn't specified or not found */
>> >> -     if (!info)
>> >> -             info = spi_nor_read_id(nor);
>> >> +     if (!info) {
>> >> +             detected_info = spi_nor_read_id(nor);
>> >> +             info = detected_info;
>> >> +     }
>> >>       if (IS_ERR_OR_NULL(info))
>> >>               return ERR_PTR(-ENOENT);
>> >>
>> >> @@ -2908,7 +2910,7 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
>> >>        * If caller has specified name of flash model that can normally be
>> >>        * detected using JEDEC, let's verify it.
>> >>        */
>> >> -     if (name && info->id_len) {
>> >> +     if (name && !detected_info && info->id_len) {
>> >>               const struct flash_info *jinfo;
>> >>
>> >>               jinfo = spi_nor_read_id(nor);
>> >
>> > I think the flow can be a little bit better. How about:
>> >
>> >         if (name)
>> >                 info = spi_nor_match_name();
>> >
>> >         if (!info) {
>> >                 info = spi_nor_read_id();
>> >                 if (IS_ERR_OR_NULL(info))
>> >                         return ERR_PTR(-ENOENT);
>> >
>> >                 return info;
>> >         }

+1 for the flow. But is it correct that we just ignore any former
error and just replace it with ENOENT? Should we return NULL here
and let the caller handle the translation from NULL to ENOENT (and
keeping any other errors)

>> 
>> Here we miss the IS_ERR check in case info is retrieved with 
>> spi_nor_match_name().
>> Do you expect spi_nor_match_name() to ever return an error? As it is 
>> now it doesn't.
>> I'm fine either way. In case you want me to follow your suggestion, 
>> give me a sign
>> and I'll make a dedicated patch to move the IS_ERR_OR_NULL check. Will 
>> add your
>> Suggested-by tag.
> 
> I think it should be safe to assume it won't ever return an error since
> all it does is iterate over an array that is always present. I don't 
> see
> that changing in the foreseeable future either. So I think not having
> the IS_ERR check is fine.

But what does it cost to just add the error check now so it won't
be forgotten in the future?

          if (name) {
                  info = spi_nor_match_name();
                  if (IS_ERR(info))
                          return info;
          }
          if (!info)
                   return spi_nor_read_id();

          <flash model check code follows here>

And then let the caller handle NULL and translate it to ENOENT.

-michael
