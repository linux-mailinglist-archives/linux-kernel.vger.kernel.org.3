Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFBE55E333
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345057AbiF1LVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiF1LV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:21:28 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7612E096;
        Tue, 28 Jun 2022 04:21:25 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 50C9022246;
        Tue, 28 Jun 2022 13:21:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656415283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o0W1KL9ji+DqAJcOrvQpkrdf1niwtlqNX9ZRyuRODlc=;
        b=Uw/+x6420mcEOIknrJiEYJ4HEZ9UvXxfVZ6Pn1XCw8CkN8ZGwdtezuxBiGXY9vgiFgK+id
        sco96ziMUq3tHBPtXx1MXH+QQqiDvIx8fvuL4jvAgnBNt55ZQvjmWQN85TQ3PPNa+fhfRq
        BeLUsNnjDbN9kU5q2xkTkA5N5rh6MDc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Jun 2022 13:21:23 +0200
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] earlycon: prevent multiple register_console()
In-Reply-To: <20220602090038.3201897-1-michael@walle.cc>
References: <20220602090038.3201897-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <2386f29173c6a6d31e3e07630a44eafb@walle.cc>
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

Am 2022-06-02 11:00, schrieb Michael Walle:
> If the earlycon parameter is given twice, the kernel will spit out a
> WARN() in register_console() because it was already registered. The
> non-dt variant setup_earlycon() already handles that gracefully. The dt
> variant of_setup_earlycon() doesn't. Add the check there and add the
> -EALREADY handling in early_init_dt_scan_chosen_stdout().
> 
> FWIW, this doesn't happen if CONFIG_ACPI_SPCR_TABLE is set. In that 
> case
> the registration is delayed until after earlycon parameter(s) are
> parsed.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Ping :) Or do I have to resend this patch?

-michael
