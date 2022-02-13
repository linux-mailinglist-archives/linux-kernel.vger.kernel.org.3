Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383664B3C0E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 16:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbiBMPdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 10:33:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiBMPdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 10:33:02 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76215F8C2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 07:32:55 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id bx31so19066704ljb.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 07:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=f1OVYBJ4Uo8ogM4J/JOzZP0+MRYmTOMfv4l7hJHey9U=;
        b=uHf3RfU5Nwz9vQ6LZSNL3UXtT4KQt2FTqTB3BcnyI9r5IINzqIOTI8/uJv9e7+kTU5
         HnF/l4sXyiIqjsEYXUIl907R0gTLEUbR+YWlA0yUP7Mty/64OXTLqdO14wnMBiVlyWn3
         nwBpIMRwUQnEcezdWd3iq0axu7bbYcOpHzn1ocipkqBIFjXFKQf+HRQNdVTmPpYjszIN
         CZUtfbzWF3SNV7jwahxzywSwtdB2CQnaQQF45WPcIYxkn+UlR8hAiNb7wHlGwJtTgFzL
         4DCTWpKF39TVyydiJBJVJ/HPzjYGyyavdwQL/k4igVTgmUZe+fHmfjQWHVUI2s8E9AE0
         BJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=f1OVYBJ4Uo8ogM4J/JOzZP0+MRYmTOMfv4l7hJHey9U=;
        b=WkbG+ZgBeIwqBdKOJs/2yodpuRYHX0DwaPSEL5GsXJ+dP6eAxvc443UmA9D86W4DBx
         vwkaO20UqfmzHiJMeFDUDKwSCs5CKBA9OzSYo90z8frYy1K/0ZU6Il5IPqxPDpfvOBC0
         vc5kaV33Xxrme27mIEtAduCWusH9TROpgNfryzh+LMcBl3PY3Jd3I8Vl2Bu+4J4/Zali
         bXJ9f7ynPiJryayHHnbGVllg434+Ml5nDCO9HtubFmVhM5wj+9y/NxgzJcYNcarAMbXN
         cLJRNp9Y84l3+ZO6hWeF2ZS/cTJdaPuZwSotUMMWSVbp3Ad2CImwIcXgRamIQ0h0tGYH
         i+Ew==
X-Gm-Message-State: AOAM530vJbiFbwst5ga17BZYN8e501zHCKLUe9NeaezmrBFabWuTygUR
        PD+oNDpo/ubNp+jNHXk1D7Ugja2T70Ujcw==
X-Google-Smtp-Source: ABdhPJz5hFHpifG1UjEjJPDeE46TzbLjCROtI1DXwsoL1GpplUIwA5abpb+tqZC7vGYEYpL5k8U4wg==
X-Received: by 2002:a2e:a546:: with SMTP id e6mr6704048ljn.368.1644766373691;
        Sun, 13 Feb 2022 07:32:53 -0800 (PST)
Received: from wkz-x280 (h-212-85-90-115.A259.priv.bahnhof.se. [212.85.90.115])
        by smtp.gmail.com with ESMTPSA id f5sm1362483lfs.245.2022.02.13.07.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 07:32:53 -0800 (PST)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: Fix validation of
 built-in PHYs on 6095/6097
In-Reply-To: <YgkAfy3fQ1hq7nlf@shell.armlinux.org.uk>
References: <20220213003702.2440875-1-tobias@waldekranz.com>
 <YgkAfy3fQ1hq7nlf@shell.armlinux.org.uk>
Date:   Sun, 13 Feb 2022 16:32:51 +0100
Message-ID: <87tud2aijg.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 12:58, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> Hi,
>
> Thanks for spotting this. Some comments below.
>
> On Sun, Feb 13, 2022 at 01:37:01AM +0100, Tobias Waldekranz wrote:
>> +static void mv88e6095_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
>> +				       struct phylink_config *config)
>> +{
>> +	u8 cmode = chip->ports[port].cmode;
>> +
>> +	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100;
>> +
>> +	if (mv88e6xxx_phy_is_internal(chip->ds, port)) {
>> +		if (cmode == MV88E6185_PORT_STS_CMODE_PHY)
>> +			__set_bit(PHY_INTERFACE_MODE_MII,
>> +				  config->supported_interfaces);
>
> Hmm. First, note that with mv88e6xxx_get_caps(), you'll end up with both
> MII and GMII here. GMII is necessary as that's the phylib default if no

I did notice that.

> one specifies anything different in the firmware description. I assume
> you've noticed a problem because you specify MII for the internal ports
> in firmware?

Precisely.

> I'm wondering what the point of checking the cmode here is - if the port
> is internal, won't this switch always have cmode == PHY?

For all intents and purposes: I think so. It is just that the functional
spec. also lists cmode == 4 == disabled (PHYDetect == 0) for the
internal ports. So I figured that there might be some way of strapping
ports as disabled that I had never come across.

Do you think we should drop it?
