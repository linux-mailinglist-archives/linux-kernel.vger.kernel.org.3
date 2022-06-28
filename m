Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD5B55DB8D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344891AbiF1Lzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiF1Lzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:55:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79FC31218;
        Tue, 28 Jun 2022 04:55:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F847B81C54;
        Tue, 28 Jun 2022 11:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEFAC3411D;
        Tue, 28 Jun 2022 11:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656417336;
        bh=9hGZwnMisUTg3nhyuy+3n294mJGPotZjYhIEsjJGGBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=micYraVTy9p5MyQKBLqN+ibHpkp4YKZX84WyK1tPgnlx4IRBhzLtiimiJOT/2PNB7
         Yta2y/pvMcPu/NVagQaGAEsDfSJJ9Th3kdRnAfvD8qOzsqSxmaUYCaFhgXkESqNuLD
         aD47/5hHrJKY21Q14n5SPHKjTzqZ+NK38bXCuoHk=
Date:   Tue, 28 Jun 2022 13:55:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] earlycon: prevent multiple register_console()
Message-ID: <YrrsNSI4+Gbjt9bm@kroah.com>
References: <20220602090038.3201897-1-michael@walle.cc>
 <2386f29173c6a6d31e3e07630a44eafb@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2386f29173c6a6d31e3e07630a44eafb@walle.cc>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 01:21:23PM +0200, Michael Walle wrote:
> Hi,
> 
> Am 2022-06-02 11:00, schrieb Michael Walle:
> > If the earlycon parameter is given twice, the kernel will spit out a
> > WARN() in register_console() because it was already registered. The
> > non-dt variant setup_earlycon() already handles that gracefully. The dt
> > variant of_setup_earlycon() doesn't. Add the check there and add the
> > -EALREADY handling in early_init_dt_scan_chosen_stdout().
> > 
> > FWIW, this doesn't happen if CONFIG_ACPI_SPCR_TABLE is set. In that case
> > the registration is delayed until after earlycon parameter(s) are
> > parsed.
> > 
> > Signed-off-by: Michael Walle <michael@walle.cc>
> 
> Ping :) Or do I have to resend this patch?

I do not see it in my queue anywhere.
