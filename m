Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3360157FB19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiGYISo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGYISl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:18:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2D713CD6;
        Mon, 25 Jul 2022 01:18:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7F24934887;
        Mon, 25 Jul 2022 08:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658737119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ALibwgAWKKKf+nl82ThMaWJHT9hHX0icSdtwHeZzTEU=;
        b=pj9ovp/royIpfTWh3iB8Ep2o6J/AOQfy0QgRXi4aes/tqAMA3ZMAoAPJ7Fuf+Q3raeo02b
        wZqQyf4MIOSDgXZC2+wBmxIBwAVKREk2VWngHk0cQLTfJpsBxx9002MF7KiDuRu6Sp3n1+
        Sg2dwKq4bLxx+VmErdQdSJehRaMetoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658737119;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ALibwgAWKKKf+nl82ThMaWJHT9hHX0icSdtwHeZzTEU=;
        b=WNSBYtzQKn7bOWFD1PINezOenaSwQ/t8ppJ3akshjQSQekEc40XU40nSCmzOwoRmd9VkWo
        9JBtU3XdH/YFT8Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6951413ABB;
        Mon, 25 Jul 2022 08:18:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fWo9GN9R3mLjbAAAMHmgww
        (envelope-from <iivanov@suse.de>); Mon, 25 Jul 2022 08:18:39 +0000
Date:   Mon, 25 Jul 2022 11:18:38 +0300
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] clk: bcm: rpi: Fixes and improvement
Message-ID: <20220725081838.nd2tsjcw4uiapl5k@suse>
References: <20220713154953.3336-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713154953.3336-1-stefan.wahren@i2se.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07-13 17:49, Stefan Wahren wrote:
> 
> This series tries to fix and improvement the Raspberry Pi firmware clock
> driver. This mostly focus on clock discovery mechanism.
> 
> Just a note patch #3 depends on patch #2.
> 
> Stefan Wahren (3):
>   clk: bcm: rpi: Prevent out-of-bounds access
>   clk: bcm: rpi: Add missing newline
>   clk: bcm: rpi: Show clock id limit in error case
> 

Maybe is little bit late, but still :-)

Reviewed-by: Ivan T. Ivanov <iivanov@suse.de>

Thank you!
Ivan

