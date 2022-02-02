Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701A04A6E07
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 10:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245545AbiBBJpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 04:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiBBJpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:45:49 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1449CC061714;
        Wed,  2 Feb 2022 01:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aDMiXkwi3BfC3SPPQ8t8xXhg90+eUFi719hnxoui15o=; b=AKYee4MOwBLIxJGWS2Fd5t6CKY
        5bUwgpmi90bHHfELNxvmRp9fT11t3EECIoR8gYj/7pN4CTYqzdoyLtEim8611KNh7YeWS9FVd2XYs
        jV55GZtHBN+qFeqZUbyCUOMho19C/+3xLp3waKRqvSxwh6APVoESDgt37zgg253fLHarycQNZ0Yx+
        9/xKBiwYbfIQLHleRjOPLrFnM1oy9Qw/ZgK9P+GvHPf0v7P4/PSzy7QjoE4ZZqZUuPNyAQrQQyKIv
        fhXd1tHCUsh0QUaU7KxEHcLtk52Gpu8od+e043gXijMYpkWd9/xDqabWGxgzJaoJD610KaClFOVc6
        Cmj8mHRg==;
Received: from [2a01:799:95e:a400:cca0:57ac:c55d:a485] (port=49944)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1nFCCw-00049C-ED; Wed, 02 Feb 2022 10:45:46 +0100
Message-ID: <c6100ec3-b511-17cf-c542-e124c14fb334@tronnes.org>
Date:   Wed, 2 Feb 2022 10:45:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] drm: Add I2C connector type
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Emil Velikov <emil.l.velikov@gmail.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <20220131201225.2324984-2-javierm@redhat.com> <YfhMESTylI1NTKDg@ravnborg.org>
 <4d9a56a7-da25-b411-61cc-372c6fa9011d@tronnes.org>
 <4966d03e-ee0c-5130-3819-05a90a8f6d06@suse.de>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <4966d03e-ee0c-5130-3819-05a90a8f6d06@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 02.02.2022 10.14, skrev Thomas Zimmermann:
> Hi Noralf,
> 
> since you're here, I'll just hijack the discussion to ask something only
> semi-related.
> 
> IIRC the gud driver doesn't update the display immediately during atomic
> commits. Instead, it instructs a helper thread to do the update. What's
> the rational behind this design? Is that something we should adopt for
> other drivers that operate over slow buses (USB, I2C, etc)? Would this
> be relevant for the ssd1307 driver?
> 

Async flushing is only necessary on multi display setups where there's
only one rendering loop for all the displays. I saw what tiny/gm12u320.c
did and Hans gave me the rationale. The SPI drivers run flushing inline.
Info on the gud wiki:
https://github.com/notro/gud/wiki/Linux-Host-Driver#asynchronous-flushing

Noralf.
