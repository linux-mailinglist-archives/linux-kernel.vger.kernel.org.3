Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5566952EFCE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbiETP5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351212AbiETP4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:56:53 -0400
X-Greylist: delayed 1389 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 May 2022 08:56:51 PDT
Received: from vern.gendns.com (vern.gendns.com [98.142.107.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70856B7CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3hmYwiverMb1N0J61Fi+8bzNM2DByfoLQaNKfPSLJ9k=; b=Ql9Sep6+YZYzeNT4c/2jhSUvgk
        pu0cmPSjxKPfjL6DXri1z6i9804pTe+syIlCTXqR/QGA7ydZOV0hX1S/ExFEsalEIuAHjRZkjXyoR
        l4brXxjojKL01gM75PAybV2oeWIcfcdpnsu1zbEAdiYJ9npo/V+Zq47sn7Wp4XvbIL9TuWmpxc3qz
        38U6YAwnEWq5NKnTqAObF0dVKw2stIQQ/7vuC5Ix6qlVEDl5YukGLOzfrhmww72MeUmb/HoGlH72Y
        iZFsZ1IiFTZkmyaJlAYX0eZsylJvWO6hfUevE1LEK+B2UD0l+vXYoiV8YCe9CbU03g64AM8q4ml5C
        eU28VhJw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:45970 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <david@lechnology.com>)
        id 1ns4d4-0003zy-OF;
        Fri, 20 May 2022 11:33:40 -0400
Message-ID: <cb4aadab-0724-35d6-0a97-dc4425f31bb9@lechnology.com>
Date:   Fri, 20 May 2022 10:33:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/st7735r: Fix module autoloading for Okaya RH128128T
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org
References: <20220520091602.179078-1-javierm@redhat.com>
From:   David Lechner <david@lechnology.com>
In-Reply-To: <20220520091602.179078-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 4:16 AM, Javier Martinez Canillas wrote:
> The SPI core always reports a "MODALIAS=spi:<foo>", even if the device was
> registered via OF. This means that the st7735r.ko module won't autoload if
> a DT has a node with a compatible "okaya,rh128128t" string.
> 
> In that case, kmod expects a "MODALIAS=of:N*T*Cokaya,rh128128t" uevent but
> instead will get a "MODALIAS=spi:rh128128t", which is not present in the
> list of aliases:
> 
>    $ modinfo drivers/gpu/drm/tiny/st7735r.ko | grep alias
>    alias:          of:N*T*Cokaya,rh128128tC*
>    alias:          of:N*T*Cokaya,rh128128t
>    alias:          of:N*T*Cjianda,jd-t18003-t01C*
>    alias:          of:N*T*Cjianda,jd-t18003-t01
>    alias:          spi:jd-t18003-t01
> 
> To workaround this issue, add in the SPI table an entry for that device.
> 
> Fixes: d1d511d516f7 ("drm: tiny: st7735r: Add support for Okaya RH128128T")
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Acked-by: David Lechner <david@lechnology.com>

