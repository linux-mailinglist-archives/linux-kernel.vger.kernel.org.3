Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F5750ADCC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443414AbiDVCg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386192AbiDVCgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:36:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CAF4B412;
        Thu, 21 Apr 2022 19:34:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D10B6B82A18;
        Fri, 22 Apr 2022 02:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E8FC385A8;
        Fri, 22 Apr 2022 02:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650594839;
        bh=uSHrkLY+dZ+wKF/t6k1olPqi38KWpu6Mopr6O6CB9PE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YSv6iuKjih2OATi0FEAB6NTD3yg8Uiz50zars69ikIxL9k7591IqZeT0kqu8oF+20
         WCczCSeDEZfVxUPVmjoqPOQ4l/CZ1mAQXk5OUsRwAXR3nCGmNxtjbWEanZdbhXCDwr
         eBf+gR4MADAa6NYKBiiPZtUTqiKWw8uEqdAR6oTFCCtqLcJbD0y26ZCt2kPiTiDWe1
         akoK0pDf9OmXbSDnGd7DMyLHOgUu9SnNUncCjY8K2mWW7UuxsC3tqVm78S/2S9ihdm
         mdOkbwqtBNs04Oh1xEqmXEFRLBZS1+wIvHJ8XDHgZHMZioGE0k0tRF+blwIwTpO139
         zFoZ+ahClPsBQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220411101441.17020-3-aidanmacdonald.0x0@gmail.com>
References: <20220411101441.17020-1-aidanmacdonald.0x0@gmail.com> <20220411101441.17020-3-aidanmacdonald.0x0@gmail.com>
Subject: Re: [RESEND PATCH 2/3] clk: ingenic: Mark critical clocks in Ingenic SoCs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        mturquette@baylibre.com, paul@crapouillou.net,
        paulburton@kernel.org, tsbogend@alpha.franken.de
Date:   Thu, 21 Apr 2022 19:33:57 -0700
User-Agent: alot/0.10
Message-Id: <20220422023359.87E8FC385A8@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aidan MacDonald (2022-04-11 03:14:40)
> Consider the CPU, L2 cache, and memory as critical to ensure they
> are not disabled.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
> ---

General comment, please add a comment around CLK_IS_CRITICAL usage if it
isn't very clear why such a clk shouldn't be turned off. Second, is
there any point in describing these clks in the kernel and using memory
to do that if they're just going to always be on? Wouldn't a dummy clk
returned from clk_get() work just as well if anything is grabbing a
reference with clk_get()?
