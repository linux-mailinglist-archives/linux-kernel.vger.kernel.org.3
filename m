Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC70550FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 07:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbiFTFXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 01:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiFTFXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 01:23:34 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BB764DE
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 22:23:33 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p5so3418768pjt.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 22:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tmO20+vl4kIvcbteq8fzQYnNYh54DQYjB9VAHNJDVLw=;
        b=Z5Le1NRpPfN6Zo329cD7UKnAIkpo1jk3bfFLnzZncO2VeaMNDQ+vK0DUoQwdfYKetO
         5uLjp060ytrvgRsKN3m8TaxMFsBhmFRTuG1Fg/edBljg1zkYtnalE5gdFuPhY7LJ1bu1
         Wn8I2Pmtx7A1R92ySshsPpozT9LQJCIt8iJ6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tmO20+vl4kIvcbteq8fzQYnNYh54DQYjB9VAHNJDVLw=;
        b=vRIkAUdHvBGyqtJzhfLVd+N459JiBCIyd614820i6PsIwXd2adjhN/1+gOz6xP9I+W
         US7C7O72+BMyMBqdoUumxS4jurdXGOVYPm6IqDeBMRe52YgPkmB63cepzkHRLBOd9+wN
         Gk0o5JiRPqvRVbNIzgDFo7c+ullK06Ux0mOVP3mleyQo6Sf88ma+WoiV3jc2zNn3y+B9
         x8ihY0so9164MxFJTIYdxYFpO9Bb7f7EHQhEyGuFlGKF58V0VBzM8cEgI+xqYRj173WI
         f4gaPV4pAtyW/kbMa8FM7Sl6SmoYUu9ejqsZ1WMGkTQxQ/agj1LmgI0p+upNwQ1P8RyA
         mWag==
X-Gm-Message-State: AJIora9VTh/SKYD//EM9soBKNVZUEFnahiGL/iOVu7wBkdwBX/Jl6ZmM
        3scG9Q/ldB/Ygq7en/elMko3qw==
X-Google-Smtp-Source: AGRyM1s0h/5f6s6T9SQWNOPdCJ740Pj7hL/HKDucyApKbFNystfQKyok7fdVxwPVOAsNSNtrRw+H3Q==
X-Received: by 2002:a17:90a:df91:b0:1e3:4dc8:46e7 with SMTP id p17-20020a17090adf9100b001e34dc846e7mr35691475pjv.106.1655702612933;
        Sun, 19 Jun 2022 22:23:32 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:b60c:9d67:b219:6c6f])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902b69200b00168eb15f4c1sm7619445pls.210.2022.06.19.22.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 22:23:32 -0700 (PDT)
Date:   Mon, 20 Jun 2022 14:23:28 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Boot stall regression from "printk for 5.19" merge
Message-ID: <YrAEUM20n3Rc4aOn@google.com>
References: <20220619204949.50d9154d@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220619204949.50d9154d@thinkpad>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/06/19 20:49), Marek Behún wrote:
[..]
> causes a regression on arm64 (Marvell CN9130-CRB board) where the
> system boot freezes in most cases (and is unusable until restarted by
> watchdog), or, in some cases boots, but the console output gets mangled
> for a while (the serial console spits garbage characters).

Can you please try disabling console kthreads and see how the boot
process goes? Just `return 0` from printk_activate_kthreads() (I think
this should do the trick).

> The stall example:
> 
>   ...
>   [    1.108141] io scheduler mq-deadline registered
>   [    1.108143] io scheduler kyber registered
>   [    1.163484] armada-ap806-pinctrl f06f4000.system-controller:pinctrl: registered pinctrl driver
>   [
> 
> Or another:
> 
>   ...
>   [    1.108155] io scheduler mq-deadline registered
>   [    1.108156] io scheduler kyber registered
>   [    1.162991] armada-ap806-pinctrl f06f4000.system-controller:pinctrl: registered pinctrl driver
>   [    1.163361] armada-cp110-pinctrl f2440000.system-controller:pinctrl: registered pinctrl driver
>   [    1.180827] mv_xor_v2 f0400000.xor: Marvell Version 2 XOR driver
>   [  
> 
> The garbage example:
> 
>   ...
>   [    0.920951] raid6: using neon recovery algorithm
>   [    0.921228] iommu: Default domain type: Translated
>   %
> 
>           gb@k+cFL/[    4.954974] DSA: tree 0 setup
>   [    4.955286] cfg80211: Loading compiled-in X.509 certificates for regulatory database

This is pretty suspicious. I don't see how console kthreads would
corrupt the output. I suspect that something else is going on, some
memory corruption, etc.
