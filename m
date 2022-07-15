Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3899575BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiGOGrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGOGrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:47:06 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AED5F9A0;
        Thu, 14 Jul 2022 23:47:05 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 163A522238;
        Fri, 15 Jul 2022 08:47:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657867623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CRJxTYWXPZ5JA1fWKuNn+jOkdWIehOfaUm8WdJ9gjCA=;
        b=ScBd4qhCTKZVKbldt2EiJ7l1++sNujZ5Kzc+HNtX9LxQYn1mRzgH5LvVBRPaPs9fcBJr9f
        104mPrix9HB4f0aUx7OFIDOBEhgVKq5iNB/M1GMKS2Ux+FFE4aswXySGouhWCl27Zmm6co
        12lIucsi+2mL6CyUXA+YCjGtjxWGW64=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 15 Jul 2022 08:47:00 +0200
From:   Michael Walle <michael@walle.cc>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH 2/2] tty: serial: fsl_lpuart: writing a 1 and then a 0 to
 trigger a break character
In-Reply-To: <20220715025944.11076-3-sherry.sun@nxp.com>
References: <20220715025944.11076-1-sherry.sun@nxp.com>
 <20220715025944.11076-3-sherry.sun@nxp.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <509669b26b5899088e9b77ed94d103ee@walle.cc>
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

Hi,

Am 2022-07-15 04:59, schrieb Sherry Sun:
> According to the lpuart reference manual, need to writing a 1 and then 
> a
> 0 to the UARTCTRL_SBK field queues a break character in the transmit
> data stream. Only writing a 1 cannot trigger the break character, so 
> fix
> it.

I don't think this is correct. The tty core will already call this:
   .break_ctl(port, 1)
   usleep()
   .break_ctl(port, 0)

So you'll have your 1->0 transition.

My RM from the LS1028A says the following:

| Writing a 1 and then a 0 to SBK queues a break character in the
| transmit data stream. Additional break characters of 10 to 13,
| or 13 to 16 if LPUART_STATBRK13] is set, bit times of logic 0
| are queued as long as SBK is set. Depending on the timing of
| the set and clear of SBK relative to the information currently
| being transmitted, a second break character may be queued
| before software clears SBK.

To me it seems that setting the SBK bit just pulls the TX line
low and releasing it will return to normal transmitter mode.

-michael
