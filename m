Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333C151E047
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 22:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443617AbiEFUwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 16:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240336AbiEFUwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 16:52:42 -0400
X-Greylist: delayed 73 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 May 2022 13:48:56 PDT
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AD96A002;
        Fri,  6 May 2022 13:48:55 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 4ED98560541;
        Fri,  6 May 2022 20:48:52 +0000 (UTC)
Received: from pdx1-sub0-mail-a267.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CADA85601B1;
        Fri,  6 May 2022 20:48:51 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1651870131; a=rsa-sha256;
        cv=none;
        b=tlZm0qFWyqtcBqH9fobXqKDw0JWU7GgU0vi7f4FbQSi5kgFeef5UDXcxfrCDtW2C+HYFsN
        g/yg8pQYEGAE4X3QxRcNS6yuNM3iyd9jz8nYB2n0abGPO2yKrglUTXQgWg8SUQ0Q0Ae8t/
        jYpYltM/bFX9Tz9mXkum2gL3NeANkSW28ebieQhjBRJ67cC8mtwl3CtWwKWxGoxSzMVC3M
        KPXM6kEth5x3jrImvlfL+Uq/6P82LnfOaELpldmJmpzhF1yUozDg40XqiyrsMmjKlnaiko
        /tPBdqo8W4+6vSC7uNwkTlLPfTklXw7swy8U45A59cCQb6EzVLR7EesYqA9P9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1651870131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=d03LEg4EiHb0XA8sVn3OfFU5E4GP5cp77bojf6DOcbo=;
        b=mJ2qbK+Xjou9YBwiNgVOkRcoPG5LDGn4+fW8dhfP0hgSpgSoP04cKl37cQu7GKhmbE50bg
        3aNeVT6JhfdKMKM7rWqzObs32Td2GrBeB545Hf57wzecLWnqajj0DBzx36iTyF0iuEk0kv
        rjrKPfSliNJzjLboxQmUemAp+pY8/yS3Qg5b2cZdNg4O9PapxwN/scue+zuU+3eBQV6CVA
        tpTi+UB2TeW4BN68wJ1l26P4v1z31hXQBAAcWsL8zf4MEU9bC541JEXJ/ocndhxTUvcTPO
        JGVzkNA3RUlpZfl/vby5t/GEWgoKKPPopoLKM9vuWudu7VHYswutBfdmjRyR0Q==
ARC-Authentication-Results: i=1;
        rspamd-c4dc5ff8f-q9969;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Little-Abaft: 5aceb7dc1f514589_1651870132140_3751359075
X-MC-Loop-Signature: 1651870132140:3846452387
X-MC-Ingress-Time: 1651870132140
Received: from pdx1-sub0-mail-a267.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.115.45.49 (trex/6.7.1);
        Fri, 06 May 2022 20:48:52 +0000
Received: from fedora (unknown [69.12.38.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a267.dreamhost.com (Postfix) with ESMTPSA id 4Kw2jH0fNkz2M;
        Fri,  6 May 2022 13:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1651870131;
        bh=d03LEg4EiHb0XA8sVn3OfFU5E4GP5cp77bojf6DOcbo=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=yedLvVeEXNhf7fWWi4gP1x3EcpZ3OrvaB5Tc+poz/mBIOBf0iY4m3eOnwdmiryR30
         4sDAjEabEMjHtSQ/xQrdjlKYxgMcvQqZr36MO5MVcrgj020BokIsFE0Sp0P7iX0MpX
         HFFZhR3iNytbpmN9SG11VQ8RodnesWkWgG6XFZDwNq4SfyX7XtEWkpqPCzRdaQWpz1
         hcLhtPqIlfy0Kdu+c9vDxXQoWPXziib7NTnosdVt+Mspl+d9PHQyC1VfG7ZPaOaavl
         +457r9P0F/xbA6p+eI95wnP+j3bYy6zibsQOLL1xig8j1TUOFDlhbIwO4GBrzUa9cK
         nummamTv/WDig==
Date:   Fri, 6 May 2022 16:48:49 -0400
From:   Ian Cowan <ian@linux.cowan.aero>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: acpi: clean up spaces to be consistent
Message-ID: <YnWJsS8OaCJssz89@fedora>
References: <20220425021407.486916-1-ian@linux.cowan.aero>
 <CAJZ5v0hb9Goj9N+VCfAB9Fy+HA7EqG=Z+XJo1t53KcmF62-PbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hb9Goj9N+VCfAB9Fy+HA7EqG=Z+XJo1t53KcmF62-PbA@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 08:34:09PM +0200, Rafael J. Wysocki wrote:
> On Mon, Apr 25, 2022 at 4:14 AM Ian Cowan <ian@linux.cowan.aero> wrote:
> > @@ -190,12 +190,14 @@ static int acpi_ac_battery_notify(struct notifier_block *nb,
> >  static int __init thinkpad_e530_quirk(const struct dmi_system_id *d)
> >  {
> >         ac_sleep_before_get_state_ms = 1000;
> > +
> >         return 0;
> >  }
> >
> >  static int __init ac_only_quirk(const struct dmi_system_id *d)
> >  {
> >         ac_only = 1;
> > +
> >         return 0;
> >  }
> 
> I don't really think that it is useful to add empty lines in the two
> cases above.
> 
> The rest of the patch is fine with me.
> 

I just submitted v2 removing these 2 changes and leaving the others.

Thanks!
Ian
