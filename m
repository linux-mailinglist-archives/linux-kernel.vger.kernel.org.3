Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9D24A5E22
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbiBAOUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239169AbiBAOUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:20:22 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB7CC061714;
        Tue,  1 Feb 2022 06:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vv+M0c9/+vvHAR+4n1g8BIf5PSlzor1xcAvAWfIItfU=; b=SIxfSMxadV7NfMVsEZAOlZ7bqW
        8fFHaUAUne5GMPC6IEFf0JbJR69XkvYTs1lL5EzV3yCFQrtw0lj4Vzvl/Oblw0tm0In6LehDamWKg
        s7rRXO8qZAT0pTx8zO8AZ+1PHCkn3b0Q8/UA9iRPkzqvDqjVxBKzHj/1B98iiaAhOWW6VQC39cRYl
        2Bo8RqqQJvdXqY25oZWfA598J5HIJ+YLo37iUHyuvr+n0nVJuIc/e6Nwv9N5SYIFv6VV0k0B5Qa/r
        ZSZxLINoAjamzhzq6vJJkfFxUU+C/qxQeYGnM1rGo68tXb2Dwhld3ctf8ss8Sx/WntMYIG/BbVIC1
        QJ8zLzWw==;
Received: from [2a01:799:95e:a400:5d05:6ef3:cded:ad3] (port=55645)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1nEu14-00029Z-BL; Tue, 01 Feb 2022 15:20:18 +0100
Message-ID: <fb821f7c-ef35-5351-ebab-2801cd9bba2e@tronnes.org>
Date:   Tue, 1 Feb 2022 15:20:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] drm: Add I2C connector type
To:     Simon Ser <contact@emersion.fr>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <20220131201225.2324984-2-javierm@redhat.com> <YfhMESTylI1NTKDg@ravnborg.org>
 <4d9a56a7-da25-b411-61cc-372c6fa9011d@tronnes.org>
 <vbOCbsYZGDCHDj8wKOHAZ1u2HMTc_UKM5umAyMug7KZn5ABy4sDMMdNOtwLI5kH_ifctnfmzQejqC_HP1vhXNt6k7vEU0WqFVNUwKnibIn4=@emersion.fr>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <vbOCbsYZGDCHDj8wKOHAZ1u2HMTc_UKM5umAyMug7KZn5ABy4sDMMdNOtwLI5kH_ifctnfmzQejqC_HP1vhXNt6k7vEU0WqFVNUwKnibIn4=@emersion.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 01.02.2022 14.38, skrev Simon Ser:
> 
> On Tuesday, February 1st, 2022 at 13:58, Noralf Trønnes <noralf@tronnes.org> wrote:
> 
>> It turned out that I wasn't entirely correct here, mpv didn't cope with
>> unknown types. In the PR to add support Emil Velikov wondered if libdrm
>> should handle these connector names:
> 
> Opened this MR to try to make things easier for user-space:
> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/222

Thanks Simon!
