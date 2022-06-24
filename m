Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCC155A211
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiFXTrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiFXTrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:47:41 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE478269A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 12:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=01lx53oXEjHB12EIpfEWhdf0NHxjveCZJS34ykm30Ss=;
        b=ZOWvTCZnvi8P2pj6UVgRVCSqgVRpbvGXApGsVxgHQ5/qAXyrUoigp18XhbkdprQA6qk+BR8Hk9CDs
         Bi0mMt6j2BnCVI6XSwPnPZPfwj/fUnrs19UXvNsqdCHFJcUaTKSm2hiBGtIpa1gsYwFLPvKtkWIBO7
         a+9MMP9yQ0cwPqET5UmWCieMyGBr3K+llVed06Jh3DvSR0UGJDSnO0bGbx7bQEQ5HDqZXtA7tWxJnK
         Vw5cj4j6pb3HmGEl2GzLCpjKtwut3xkS0FZQEp2tVbVivFHEqpABKHqX7MKJwzWUpU7Z5Md0CXOlQA
         9MseJX9bys8oB/z6OaNKO+2bEqnPs2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=01lx53oXEjHB12EIpfEWhdf0NHxjveCZJS34ykm30Ss=;
        b=6kcuP4B77m/2mVzBV51Mo1EuMCk9uDHHmhGlgk8oRrlw+w/fw7Gz6rrYEywGQEVr1b8HaKV3WukoA
         IIoppC6CQ==
X-HalOne-Cookie: a9df624f025a3f5ae97c156b21ee154a40fcede6
X-HalOne-ID: 801ce267-f3f6-11ec-be7c-d0431ea8bb03
Received: from mailproxy2.cst.dirpod3-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 801ce267-f3f6-11ec-be7c-d0431ea8bb03;
        Fri, 24 Jun 2022 19:47:38 +0000 (UTC)
Date:   Fri, 24 Jun 2022 21:47:36 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] drm: shmobile: Use backlight helper
Message-ID: <YrYU2KEubtR+pmkO@ravnborg.org>
References: <20220616170821.1348169-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616170821.1348169-1-steve@sk2.org>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 07:08:21PM +0200, Stephen Kitt wrote:
> This started with work on the removal of backlight_properties'
> deprecated fb_blank field, much of which can be taken care of by using
> helper functions provided by backlight.h instead of directly accessing
> fields in backlight_properties. This patch series doesn't involve
> fb_blank, but it still seems useful to use helper functions where
> appropriate.
> 
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
Thanks, added to drm-misc (drm-misc-next)

	Sam
