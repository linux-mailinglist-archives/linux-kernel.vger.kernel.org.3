Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00C258AE5E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240810AbiHEQsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbiHEQsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:48:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11C428E01;
        Fri,  5 Aug 2022 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659718077;
        bh=BwxgXFyMoX6LG4RcXS/FAfwlY+oHnVTND2orTGFFzTg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=VY4XvpIbVvbOGQNhkoQViFXEx1DZaUvp6CDdqM9Z8ieXT/ri0Aas/wsOqzvzjYKhW
         wGWlmGB1bYJI1eR9QI4KDJ3aWyAg7Yxw6H7FN45lSVGBJ581oJ5446zPxHrRwFNSx9
         c9Hx+f3QACVCuV2XUQCsev9DWfiirimdssBJdcaw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.139.128]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJVHU-1o08Bh2wEC-00JuGH; Fri, 05
 Aug 2022 18:47:57 +0200
Message-ID: <98c1755d-5b67-70f7-c569-431e650ece70@gmx.de>
Date:   Fri, 5 Aug 2022 18:47:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] Fix bugs in *_set_par() caused by user input
Content-Language: en-US
To:     Zheyu Ma <zheyuma97@gmail.com>, adaplas@gmail.com,
        santiago@crfreenet.org, akpm@linux-foundation.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220804124125.3506755-1-zheyuma97@gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220804124125.3506755-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k9hWd321fIJId4w8JA+DmGPit3IfSkp0j0DDxrSaFTDDz5RI90+
 rgYRcegevBKruvpsas6YTNL7Sd/n5FS79ygEB8ZjRG1Irc6fe/UruUExSw6XHsBnIcjCFhE
 mNWteMGBNNBGslWubvmFTWBCXvw5wcK8Zb1F1A0QZWgrGN3s9QkBiQAZpxcmn1iz7E65bQT
 3i+DL97ehXko+KCj9jU0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:flE13ZOQYvs=:2QDXygMtVdgKv5Y2vuUzR0
 M5KIRzzFTezbFLNsDpJQ5LG+juFdRUQgvBjsRGWPtRO5tkuWCV1vg82Sik9gsmFgl2EV8wJYf
 yxv0RYGeY1WZ+Z/puTueVm8i52U6XY5b816czI9oJqdfa5Kxe6TyXOid+nYtZhBGmQBZS7J2y
 6FYcbcZszrYilAwRCd41jM2/irzI6ahtpDj2Vk+6AVLFA3TyryTZwbZJx0qHEE6yUXeJgth6t
 CKEJCKLyZzk6pk8ZZTIAMAHORcVpoiP4ZtKRLxoMSfoqOEdITacEDsRudb7T8XqkmaXRnlqDs
 DcGnLFCXn5vqz5OVvSyTRpz7h5wq0bIy9n2hqx/U78qmSZf+ixIWct2roQbnd+aQJVZTwd5FE
 g88nuB1U9s5gRv9KRRqAsm/moGG4QGQbRPYB+LwxQNGNT7psUu8B0xX42IUz2BRiDa88+oTMF
 d3f1sMVMyOZiLuyG+jkf6GNXsCE7kflIlzTa/y7VJ+7fwIn/GlYhke2L1izcfqWu1S6+0uJc6
 VG7tW2i6z5b1C2uia0IW656WOleUh6UiBuM7hNKwgZqfQpv/mIlQ+joI3NEK11bV3ezv74XCL
 d4PrCa/BJ85hXp5ahUSl8qZtGGcvLz8RqkKOx23fSIdutWcGdGur3I0ED5c2XDmY3l6PtVhK/
 NtOk0Bse+3UnkCPQqTd5AW/s5kZBD4qB/HDjrPMosRtmwg8uPuSCXKw82yWa9p854y2G44NYH
 M/8RPpmlzneK//ZCxm9QgFKW3yK9KBQ7n/eswO029z5R65YZq9UeHyl2Yl/s1RU0vaVEaQGmX
 XgwfeBtqcvO2LBNzdS7yQFjXUy1jsUveUvMQPH3S81kfw03VGAHh5IXVOfsjP1t25kX1GEBYH
 zEmnwdbKHIFl6QzDGds40n/GYHCzAVlt2k82MT20zohKYSwMuCUbnIdoCEfcSFzvgks/VtAo+
 0fzzvznvlnqiBUPvMR5OOxPKvwRsajZpaQJQLM4vsN6jv7pgzzQxb86qyTU+QHp7QLU3/rUzf
 Y87R3BluQnWr4zfzxLlfOSukmkGMxZZZu64SYXGaV9kuX4BUOW5N5LwoaIRlTEetj74czxAPZ
 pZex8fmT9uFxIv00ASynq8Nws47fX20o8HUE1d8qYxeqvkvuJFWr8ifxQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/22 14:41, Zheyu Ma wrote:
> In the function *_set_par(), the value of 'screen_size' is
> calculated by the user input. If the user provides the improper value,
> the value of 'screen_size' may larger than 'info->screen_size', which
> may cause a bug in the memset_io().
>
> Zheyu Ma (3):
>   video: fbdev: vt8623fb: Check the size of screen before memset_io()
>   video: fbdev: arkfb: Check the size of screen before memset_io()
>   video: fbdev: s3fb: Check the size of screen before memset_io()

applied all 3 patches to fbdev git tree.

Thanks!
Helge

>
>  drivers/video/fbdev/arkfb.c    | 2 ++
>  drivers/video/fbdev/s3fb.c     | 2 ++
>  drivers/video/fbdev/vt8623fb.c | 2 ++
>  3 files changed, 6 insertions(+)
>

