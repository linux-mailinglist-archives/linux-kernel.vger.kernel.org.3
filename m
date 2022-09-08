Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613195B173F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiIHIh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiIHIhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:37:55 -0400
X-Greylist: delayed 73302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Sep 2022 01:37:51 PDT
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C25A3D25;
        Thu,  8 Sep 2022 01:37:51 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4MNXZ51Zd7z9sc3;
        Thu,  8 Sep 2022 10:37:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1662626269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f4us+pJEqzub7wmeH+UhTxueIPZj885ZENsFSgxJanI=;
        b=hEVG/3rasu7nuJRAgrNApsUR9JXXpeO1wjgSPt87DlmP+kOBlUR0p+jz0J14+Hp1IpEJtA
        9+J7koOccn3frfMFLFCgKfbLqjnOhcC2J+gJJA8oPn91c9PKGn1nHdrr9+MHAlp579o+83
        1RcEGWTVTtb0jwXogIS8JkULwSuqvRIIooJufDwkvdXdw9Dr50dX9XmNKRUwitjVRHuFjr
        c9rngQ9L15QKRKB9YeEozqr5HtLlW6fj14r80UwUyefKwp9HbLToYiWzH45SRdcZFVGEM7
        Wxn7JDIfmps1ACdNxt2c7kNq07REq1B5V9fJZvp5AvuCr7mAaWKtetIqBlDMrw==
Date:   Thu, 8 Sep 2022 10:37:48 +0200 (CEST)
From:   torvic9@mailbox.org
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
Message-ID: <147120848.119190.1662626268898@office.mailbox.org>
In-Reply-To: <3097d4b8-a9d0-878c-3b95-5499ed943576@gmail.com>
References: <2047607620.67144.1662552964865@office.mailbox.org>
 <3097d4b8-a9d0-878c-3b95-5499ed943576@gmail.com>
Subject: Re: [PATCH v10 0/2] Introduce block device LED trigger
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-ID: 4abf74c99d295bc50e7
X-MBO-RS-META: mwoerzmbfhsm6tpk4cec81kee4d5rh6d
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Ian Pilcher <arequipeno@gmail.com> hat am 07.09.2022 15:11 GMT geschrieben:
> 
>  
> On 9/7/22 07:16, torvic9@mailbox.org wrote:
> > Hi Ian,
> > 
> > with a heavily patched Linux 6.0-rc4 with kfence, kmemleak and slub_debug I get the
> > following splat at boot:
> 
> Sorry about that!  I'm not sure how that slipped throgh, as I was sure
> that I tested the new version before I sent it off.
> 
> Basically, I messed up while cleaning up the function parameter names,
> so you need to apply this:
> 
> --- drivers/leds/trigger/ledtrig-blkdev.c.old   2022-09-07 
> 10:00:26.194484681 -0500
> +++ drivers/leds/trigger/ledtrig-blkdev.c       2022-09-04 
> 11:36:16.107690614 -0500
> @@ -540,7 +540,7 @@
>                  return ERR_PTR(-ENOMEM);
> 
>          bdev = blkdev_get_by_path(strim(buf), BLKDEV_TRIG_FMODE, 
> THIS_MODULE);
> -       kfree(path);
> +       kfree(buf);
>          return bdev;
>   }
> 

This fixes the issue, no more errors.
Thank you!

> > I'm not 100% sure if this is an issue with ledtrig_blkdev or something else,
> > but I thought I'll let you know about it.
> > I have not been able to test this on a vanilla kernel yet.
> 
> Defnintely my fault.
> 
> > Other than that, I hope this patchset gets included in upstream.
> > I have been using it for a long time now and found it very useful.
> 
> It's really hard to know if anyone is interested in/using this, so
> that's great to hear.

When and if you send a v11, you can add my
  Tested-by: Tor Vic <torvic9@mailbox.org>

> 
> -- 
> ========================================================================
> Google                                      Where SkyNet meets Idiocracy
> ========================================================================
