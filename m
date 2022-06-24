Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A27155A200
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiFXTjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiFXTjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:39:05 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63491522D1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 12:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=G2NikF/2bs7Kr25cPxu2AsOn40UQIgo3BOiq8YOvb8Y=;
        b=Owtz276RB1pcc6XNCAlxmcOjnXT8lwNRQ7zFZgZPQZm8e5ygnOjLgHd+57sA2VzLEok+NFmMRVnrQ
         3s6yB6czKHPxBxkWKalgj5X69e4DWa5tt5xNNWdFL9RFepfwo8PBY/pHAPyL709CkqShWEceewoFmd
         HDZhXwPzYwq5SxLAhtUGUpJUy6LNob+jjxU72Yf8A8AQXDGcWeTqWj3zmIWzfK47sFllfWuNvx5kfe
         vMpNonAL+OPKkbwoHWAisuPCbe9TzYpwQ7vMwft5VkTYk6cE2TnR+81nZmERSoEWBmRlY5g+Ykvgjp
         cst+57DgXJxAbvtL2lFKeBo+n5+rx8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=G2NikF/2bs7Kr25cPxu2AsOn40UQIgo3BOiq8YOvb8Y=;
        b=pOBBjyIKONSdNiuZIGWP702qB1DINeFiRXXtBKJuY3WhP9ohK3i4yNx55RXFakaHBIh3Gqzap7pYb
         COnjVROCQ==
X-HalOne-Cookie: 84d0f7bc642d4cc9db2f39a7067a35a84c26e651
X-HalOne-ID: 4bdb8468-f3f5-11ec-be7c-d0431ea8bb03
Received: from mailproxy3.cst.dirpod3-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 4bdb8468-f3f5-11ec-be7c-d0431ea8bb03;
        Fri, 24 Jun 2022 19:39:00 +0000 (UTC)
Date:   Fri, 24 Jun 2022 21:38:59 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drm/panel: sony-acx565akm: Use backlight helpers
Message-ID: <YrYS06BYJbnCGGJn@ravnborg.org>
References: <20220616172316.1355133-4-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616172316.1355133-4-steve@sk2.org>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 07:23:15PM +0200, Stephen Kitt wrote:
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> Instead of manually checking the power state in struct
> backlight_properties, use backlight_is_blank().
> 
> While we're at it, drop .fb_blank from the initialisation function; it
> is deprecated, and this helps make progress towards enabling its
> removal. This change makes no functional difference since
> FB_BLANK_UNBLANK is the default value.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
Thanks, applied to drm-misc (drm-misc-next)

	Sam
