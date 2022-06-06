Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BA053F152
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiFFVCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbiFFVBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:01:53 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3C914CA38
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=Ka1TstOWIq/uwWbI0ltivqnySUBaQmYAJjhs5L+uFtQ=;
        b=LNfDtB4wj+D5BF2YFa+dsimjUyIRcnBqRJuc1gWVJJ2WQRGzCCK2/Fp7XmPd2x8CwqX3VFpy7xGJe
         /twRS6RP+Jl9wjBLOaLoykj2E48IOEbfGQSxCBTJDrEqg3uIods5z0+kmNkajaDRdqnOrnqSDY4qCx
         Z7wC90armxFFwKN1QPDnWZwnNU9QUjjxp6CcnFFNY6qKV5fkoqXbbcmEd2CFqPBPXOBt5WDEnY84on
         dEXQ9z8KV9CJfh/NIDcEZEDP+QyNzhjajPIn+xnm1zeFt7P5A0zYvsCMIq49UUrrPdQ6QUbM0ZlPUv
         tB3uf3WfVLZng5ZEHrh46QhC9oo7lww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=Ka1TstOWIq/uwWbI0ltivqnySUBaQmYAJjhs5L+uFtQ=;
        b=03czCzu+A+UQWWKkvZaMDlWN9f8keJg9Lub74nSGWSf9HSwJrZ5ek2baj1eWVW6pVVOJ0jqCx4tEJ
         OkQd9zXAw==
X-HalOne-Cookie: 21ab51b31a6fe080a3deed71589524505420b830
X-HalOne-ID: 5e400a0c-e5da-11ec-be77-d0431ea8bb03
Received: from mailproxy1.cst.dirpod3-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 5e400a0c-e5da-11ec-be77-d0431ea8bb03;
        Mon, 06 Jun 2022 20:50:59 +0000 (UTC)
Date:   Mon, 6 Jun 2022 22:50:57 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/8] drm/panel: Add an API drm_panel_get_orientation()
 to return panel orientation
Message-ID: <Yp5osTQK+HCN2Ads@ravnborg.org>
References: <20220606152431.1889185-1-hsinyi@chromium.org>
 <20220606152431.1889185-2-hsinyi@chromium.org>
 <Yp5Ti3ov/fnw0xeQ@ravnborg.org>
 <1c6e4d09-cf7a-2812-fd0d-09a21a275201@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c6e4d09-cf7a-2812-fd0d-09a21a275201@redhat.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

> > Please move this up so it is together with the other get_* methods, in
> > alphabetic order. That is, right after get_modes(), and then this also
> > matches the order in the .c file with is extra bonus.
> 
> The downside of moving this up is that it will break drivers which don't
> use c99 style named-struct-field initializers for there drm_panel_funcs.
> 
> I admit that no drivers should be using the old style struct init, but
> are we sure that that is the case?

There is no in-tree driver that uses old style struct init for
drm_panel_funcs - so we are safe here.

I just did a quick git grep -A 4 drm_panel_funcs to verify it,
browsing through the output did not reveal any old style users.

	Sam
