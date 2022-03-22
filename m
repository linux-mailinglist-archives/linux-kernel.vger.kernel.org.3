Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109804E444D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbiCVQiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbiCVQiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:38:20 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8AD5C369;
        Tue, 22 Mar 2022 09:36:51 -0700 (PDT)
Received: from darkstar.musicnaut.iki.fi (85-76-100-34-nat.elisa-mobile.fi [85.76.100.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 789CC1B002D3;
        Tue, 22 Mar 2022 18:36:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1647967008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RNrNBemsZsaG7NZqTZ3MCUPdFOPCvyRw2+V4JUFQ0Nk=;
        b=AwQeGd4204Vkw2568/3IwnUQBQ0Fh1dXtTS6xgcE5LdH4O44DDujrzanA3Ztya+Ibx1nNf
        JyapZaT+3E4mNaK8XtkSDXDB4EOWkTPjxDydWRqxlICq5KxJc4eqJlxzrXJLF/cRCqUZrf
        x4V7AZ7+tzZWU7IpoqcaUskfjCf21Cvwh6CbaQYH+dl1lDUZXPkGNKy/1HmHSFgmnTEtOb
        4fWa4oUd/Q4vKk4vsxACXhQWFTAyBKri4h7BCo+I5SwR22alCGwKCC9yJ0V8bjJVMa2Lpk
        fdc0v0hlSPhAK45pi8KQOJBm4PA8QpjZqXf8MUxhJR91vUyxj8Sjq5tyvPaPdg==
Date:   Tue, 22 Mar 2022 18:36:46 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-mmc@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2] ARM: OMAP1: Prepare for conversion of OMAP1 clocks to
 CCF
Message-ID: <20220322163646.GD297526@darkstar.musicnaut.iki.fi>
References: <20220310233307.99220-3-jmkrzyszt@gmail.com>
 <20220321215416.236250-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321215416.236250-1-jmkrzyszt@gmail.com>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1647967008; a=rsa-sha256;
        cv=none;
        b=l2ZnGsGINPS9lZ5lJlSl6lZOgGL7Q607SYPV0J7WR6YGktBvdwhgSHlOmX5wRAHk7ZfcLc
        zWtjZl9vuQ8iZacCUsrqZ+A1kGWNR+XopLUfhq6z4OojVlDNVy+DO6pAEkD2VsFi4gdBwY
        gW1AKxorc7PrNyH1dQJmHyt53UaFPwYDrpa/8uLCUJ2vjL9PcWxdevZZwdnAwYmepKjI5R
        ZnmhP+hd3sLudvP2V9GtzwtgGlUhnU+ZbFcY+J9r/BScbaJCeFfyYojSKrAbgB7XAN0pWq
        tZWDfB/LL1en0FbHwSw/DMl44aemO9uXJeoIXxxlUkebpSB6zKugvTu7ZJELXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1647967008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RNrNBemsZsaG7NZqTZ3MCUPdFOPCvyRw2+V4JUFQ0Nk=;
        b=oL/5cvCYEppmlz4BJVPwqBpl81I2Z6QgKsr1OROeI8lunAjaoDigGvxhxH32vZ/zvJS32+
        BDZ6ooMIZE1UsrSiwxmWSUbT6Tcu93Suy4+zbuXo+nXdRIg5GRwRx6SMS/LmjsCoLo6HyT
        9u0ITw35hSb4Mznr2j+ojp6dBv1OoviG8VOl390BQiNhGlXtYN9C3FU1pZU2iWPeFSdReh
        X7PkfpGOPTbfe12YpZz7gagw/3UkqPdBSW+ZvgjsMxxfpG/ZH+1H4Ig2hPZqt2oD/iZml7
        V6yDtD0vk6EH9/pO08Zsx2Bjsa+ZOpz2OGYNEdzkbYnttQmBh8szxuKjg2mMEw==
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

On Mon, Mar 21, 2022 at 10:54:16PM +0100, Janusz Krzysztofik wrote:
> In preparation for conversion of OMAP1 clocks to common clock framework,
> identify users of those clocks which don't call clk_prepare/unprepare()
> and update them to call clk_prepare_enable/clk_disable_unprepare() instead
> of just clk_enable/disable(), as required by CCF implementation of clock
> API.
> 
> v2: update still a few more OMAP specific drivers missed in v1,
>   - call clk_prepare/unprepare() just after/before clk_get/put() where it
>     can make more sense than merging prepare/unprepare with enable/disable.

Something is still broken. When doing kexec (using CCF kernel), the
kexec'ed kernel now hangs early (on 770):

[    0.853912] MUX: initialized W4_USB_PUEN
[    0.858001] MUX: initialized V6_USB0_TXD
[    0.862060] MUX: initialized W5_USB0_SE0
[    0.866210] MUX: initialized Y5_USB0_RCV
[    0.870269] MUX: initialized AA9_USB0_VP
[    0.874389] MUX: initialized R9_USB0_VM
[    0.878356] USB: hmc 16, usb0 6 wires (dev), Mini-AB on usb0
[    0.886230] initcall customize_machine+0x0/0x30 returned 0 after 29296 usecs
[    0.893707] calling  init_atags_procfs+0x0/0xe8 @ 1
[    0.898864] initcall init_atags_procfs+0x0/0xe8 returned 0 after 0 usecs
[    0.905883] calling  exceptions_init+0x0/0x8c @ 1
[    0.910797] initcall exceptions_init+0x0/0x8c returned 0 after 0 usecs
[    0.917602] calling  omap_init+0x0/0xc @ 1
[    0.922393] initcall omap_init+0x0/0xc returned 0 after 9765 usecs
[    0.928863] calling  omap1_init_devices+0x0/0x2c @ 1
[    2.568664] random: fast init done

Probably something is now disabled that has been previously always
enabled by default/bootloader. I'll try adding some printk()s to see
the exact place where it hangs...

A.
