Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1908A562D6F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbiGAIIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbiGAIIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:08:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CC92F660;
        Fri,  1 Jul 2022 01:08:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05D13B82ECA;
        Fri,  1 Jul 2022 08:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D29C3411E;
        Fri,  1 Jul 2022 08:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656662894;
        bh=dNpmdEv82tTTiiopZv816eNCZ7Jvuv6t7bmOcATfpaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZA/tZ2l23iKXVIvrBTLcDCWF/AqZsEno2jARGEs3MoaTVspxuWz6SZFIhqr65wncF
         nWP1lGsDGYaXZOiYirO8U7vXSo8QJQhfjCl7AlImr6xuH9ufZLzYYzgcztATjej6Vp
         y/T57I3DlR0hiqrwuRvCKOczQRAv/fzbPD+1FuHg=
Date:   Fri, 1 Jul 2022 10:08:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] tty: n_gsm: fix user open not possible at
 responder until initiator open
Message-ID: <Yr6rZy1+/ZHxOK+P@kroah.com>
References: <20220701061652.39604-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701061652.39604-1-daniel.starke@siemens.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 08:16:44AM +0200, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> After setting up the control channel on both sides the responder side may
> want to open a virtual tty to listen on until the initiator starts an
> application on a user channel. The current implementation allows the
> open() but no other operation, like termios. These fail with EINVAL.
> The responder sided application has no means to detect an open by the
> initiator sided application this way. And the initiator sided applications
> usually expect the responder sided application to listen on the user
> channel upon open.
> Set the user channel into half-open state on responder side once a user
> application opens the virtual tty to allow IO operations on it.
> Furthermore, keep the user channel constipated until the initiator side
> opens it to give the responder sided application the chance to detect the
> new connection and to avoid data loss if the responder sided application
> starts sending before the user channel is open.
> 
> Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> Stable backport remark has been removed compared to v3. No other changes applied.
> 
> Link: https://lore.kernel.org/all/20220530144512.2731-1-daniel.starke@siemens.com/

Not all patches in this series would apply to my tree.  Please rebase
the remaining ones and resend.

thanks,

greg k-h
