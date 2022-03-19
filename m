Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE0A4DEA31
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 19:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243938AbiCSSvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 14:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239382AbiCSSvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 14:51:20 -0400
X-Greylist: delayed 27184 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 19 Mar 2022 11:49:57 PDT
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F67621D7EF;
        Sat, 19 Mar 2022 11:49:57 -0700 (PDT)
Received: from darkstar.musicnaut.iki.fi (85-76-3-17-nat.elisa-mobile.fi [85.76.3.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 90D401B005E7;
        Sat, 19 Mar 2022 20:49:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1647715795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UZiM45VyUb2qyeM2RPKLOiRoIP0g6aqsRFs2FjvcgMs=;
        b=nxWUY/hMxJdb2PwmYVBvX+fR1NveAJnAKYoJFBJAG/GUG8xvSw2fz52G6Xo7wKHVSr0qwn
        y39uFTLQKpAJ2LOb1jdTkPjk/Zt5T5jreEhYN8yP4TF9UQhAyQu/oY1k0KrkW8wEcc62wx
        hgWZdU0Ir9TEgYVwQvuA77rpIIpnzBAWdTNFDE/OOASjwzPcwCHVKHWp8J5ObeXTUrPPQF
        Duxt2vtLvOlF83OUlNBDJVr7FW8Gx/lf19F0Wjk2lqqS05+WB9Tp3Q8fhmjAXMDEKbV9Rm
        JQ36TlD+HL+7kDAn5ARVDvKbi+A8x4ygbfpY6IVeLZ7fg8GsHqUwI2oyqpeYEg==
Date:   Sat, 19 Mar 2022 20:49:52 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Paul Walmsley <paul@pwsan.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC RFT PATCH 0/4] ARM: OMAP1: clock: Convert to CCF
Message-ID: <20220319184952.GF1986@darkstar.musicnaut.iki.fi>
References: <20220310233307.99220-1-jmkrzyszt@gmail.com>
 <YixWZ+IiN2l9jmzg@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YixWZ+IiN2l9jmzg@atomide.com>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1647715795; a=rsa-sha256;
        cv=none;
        b=XXxZOctinU4m+znhMMf9d6S+wOdBCmt0XyYtVcfB49SQV+My3T/COD9lnwqsHqGmemMSKt
        xUDRk3eFN4xj4Yux0YCVP/m/6Y9WwNbzDvxSa1ydkD1n+xmpirjWvZTydgl3mC/bAkZTz3
        OE7QN4T3EazF7J9VmhmkHSy5jEaPkcAo5kGTQifvI4qRdFJWRHIBIl+HJVkszX/osqg7Qw
        EyUck589BQEubVQwgJ+9kfzPJyeYPOjAdXbHI7OIffaGDKYhJcDXbxlMjrW24x/4lc3OS+
        mVsbOA3le7oxnC0zYMp1VvmDIiN16CEbqDKm8LeYxUaM6XGdyWlucQc1J9dgsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1647715795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UZiM45VyUb2qyeM2RPKLOiRoIP0g6aqsRFs2FjvcgMs=;
        b=UYpNc8T8xI9LyrGirHytNxANqphjTTOj7resU82lQ3iQE5zo6nFg23tVN4gleAXzWN9YZS
        PXjwkOj10cw49XsQDTm6mMsTiVWCPbuoCjgZfUFG6Nb3s0lIL1CYM1ybfAMJNZFbUiOAGU
        c7mS7Cnx23qRqn+qyW+ncAgS++2xTayKtNvic4hOA1bSXrE1U+AgNBIBVPQjkMI5xazmH7
        v9SsbokuHStuXPoaK/wmYE4/4LxZxJu13UnbAZpVzYXKEjyNxEfDwD2Ad5mQxuoaKh4bTe
        tl9s6P83zykboVBrXzizFQ8eGHwvU4W1LvSQqe+B9Fj24rL9q6ko5D7/FfLBRg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Mar 12, 2022 at 10:14:31AM +0200, Tony Lindgren wrote:
> * Janusz Krzysztofik <jmkrzyszt@gmail.com> [220310 23:32]:
> > The main motivation behind this series is planned resurection of OMAP1
> > camera driver.  Since OMAP1 clock internals have never been visible to
> > drivers, that driver used to use v4l2-clk to expose a pixel clock for a
> > sensor.  The v4l2-clk code has been recently depreciated and removed from
> > the media subtree, hence the need for an alternative solution.
> 
> Nice :) This will also help Arnd with building multi-v5 kernels.

This will need more testing still... The patch 4 is breaking at least 770
(the display/fb doesn't work anymore).

A.
