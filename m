Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186AF59C8FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238804AbiHVTgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbiHVTgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:36:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9CE1275E;
        Mon, 22 Aug 2022 12:35:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 868AF6122F;
        Mon, 22 Aug 2022 19:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E425AC43141;
        Mon, 22 Aug 2022 19:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661196948;
        bh=59bb0jYFlSosGYQkwjxBpEccBGa05dy9L2UhBEaYG+I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e4u1X1JWq8Fq35+G7oCT0frCJtoXcIPfYBzz2ocV72fIPDu635p+trs2/NJX51Bw+
         dgo+DWNHq1pD50EiRAdBEzkcKK3vT+9Aacb/Ii2b7sNZQh2VEXp1Stfw/xPvBSP7TE
         yEUSUZpbiCwhm85IZbW8DzLkomsacdzLFaXZh2aCVKqStx6LceK2JZBqZEkdt09Oru
         Jn59ZTfbqB/+T6ZGRuwTfYcwfJcS6gnjL37YLHkn3qHx4o6q7ptzcqvSp2vy9foITX
         lmbGxorMtEcb0WFe+XxpFFX+6N9/xgRjbImvwZc5tNJQVc9dwnZy0o667r1FWMrLcm
         IoN/gGcnWyy6Q==
Date:   Mon, 22 Aug 2022 20:01:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 4/4] input: joystick: Fix buffer data parsing
Message-ID: <20220822200120.543ff801@jic23-huawei>
In-Reply-To: <3HE0HR.IPKJTTCKEJUA1@crapouillou.net>
References: <20220817105643.95710-1-contact@artur-rojek.eu>
        <20220817105643.95710-5-contact@artur-rojek.eu>
        <20220819185339.7f488ad8@jic23-huawei>
        <3HE0HR.IPKJTTCKEJUA1@crapouillou.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >>   		case 2:
> >>  -			data_u16 = (const u16 *)data + idx;
> >>  -
> >>   			/*
> >>   			 * Data is aligned to the sample size by IIO core.
> >>   			 * Call `get_unaligned_xe16` to hide type casting.
> >>   			 */
> >>   			if (endianness == IIO_BE)
> >>  -				val = get_unaligned_be16(data_u16);
> >>  +				val = get_unaligned_be16(chan_data);  
> > 
> > I obviously missed this previously but these are aligned so we don't 
> > need the
> > unaligned form.  
> 
> Yes, the comment above says that it's used to hide type casting.
oops :)

Thanks for pointing out my lack of observation!

Jonathan

