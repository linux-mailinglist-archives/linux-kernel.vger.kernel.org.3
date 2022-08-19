Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25309599D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349317AbiHSO0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349401AbiHSOZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:25:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C62E97E3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:25:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C69756140B
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C84BC433C1;
        Fri, 19 Aug 2022 14:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660919147;
        bh=wVDuKRUcKIT+J+zHm3pjGF+KsciSAfq/7YwwDDEViJA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mOBkmKTYodAez4EWZsTIFLmiX3gXBxBMArR1k5Xn/ZBDBmzFewDGnGTWKFhBBTfxr
         g+tqNewEeiOjN4bVSgGzIuyvCHajul+2QYP6sTDWtstMagwV8HoTteghCEIOW9FDUP
         pfIzSdAIOzcLgw+FDf2Kg1AFRwGFyBobvRd7l4X9m/BRN/iVhcgWtHM0rH5IkZCvPW
         PenCR3XyJHM6cflQ4+BEe+004oHfzcSo28gMjsHXlxGu4asLvUg6IpldC7ZuIV6oEd
         8BMOOeqq0h6N0pTZRCRQHipY4gm89aaKttie5w+4tap+SXQneGWlqGUgGwCscGXKz/
         nTMJJJlh0i99A==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oP2wS-004ISX-RJ;
        Fri, 19 Aug 2022 15:25:44 +0100
MIME-Version: 1.0
Date:   Fri, 19 Aug 2022 15:25:44 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        gregkh@linuxfoundation.org, rafael@kernel.org, jic23@kernel.org,
        "linux@rasmusvillemoes.dk>" <linux@rasmusvillemoes.dk>,
        tglx@linutronix.de, andy.shevchenko@gmail.com,
        kernel <kernel@sberdevices.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] regmap: introduce value tracing for regmap bulk
 operations
In-Reply-To: <Yv5eMcmNOmyLmd++@sirena.org.uk>
References: <20220816181451.5628-1-ddrokosov@sberdevices.ru>
 <20220818121515.6azkxyqetnunwsc6@CAB-WSD-L081021.sigma.sbrf.ru>
 <87mtc1wtjz.wl-maz@kernel.org> <Yv5eMcmNOmyLmd++@sirena.org.uk>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <5793e1a9ef6d5a8fafd3f22cda0bb5e4@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: broonie@kernel.org, DDRokosov@sberdevices.ru, gregkh@linuxfoundation.org, rafael@kernel.org, jic23@kernel.org, linux@rasmusvillemoes.dk, tglx@linutronix.de, andy.shevchenko@gmail.com, kernel@sberdevices.ru, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-18 16:43, Mark Brown wrote:
> On Thu, Aug 18, 2022 at 02:49:20PM +0100, Marc Zyngier wrote:
> 
>> I don't care much about regmap as a MMIO backend, but it strikes me as
>> odd that you end up with multiple ways of logging the same stuff (with
>> a memcpy in the middle of it).
> 
>> Why can't this be done with a small amount of trace post-processing?
> 
> At the minute we don't put the actual data for the bulk transfers into
> the trace so the information simply isn't there.

But isn't that what this patch should do?

We also have recently merged the CONFIG_TRACE_MMIO_ACCESS which
already dumps all sort of MMIO crap^Winformation.

Surely there should be a more common approach to this.

         M.
-- 
Jazz is not dead. It just smells funny...
