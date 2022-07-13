Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5C7573931
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbiGMOua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbiGMOu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:50:28 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F0D2A96F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:50:26 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sz17so20282752ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PFfpDJGT4PNf8FSYCBYfqXx0Q1xvxmhJUB5l+xgWtvQ=;
        b=pIPeyIaox6m0EXw/IH9l//aBnuftu81VskGFUdVXxGuqlXehJu8DcdWIyjsGlkooiU
         4AIFXvWJaDnwd25nKsYCHqZNBGmWjujUludVdSVOgYpwLpzWQhZDZ2FJ6UWNXUpMgp1t
         3iu7VPa1mxafmejeAQ41Jh8GpK3C9jIv4GQns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PFfpDJGT4PNf8FSYCBYfqXx0Q1xvxmhJUB5l+xgWtvQ=;
        b=5lyFucdTDeVQHcUA9MeVeeTaWGRyoYOIixtumJi6x7yojVpVmGNvJ4iOGDgOyLrs51
         wLiIgLCpE61phFNkH/59ivk5r/CaIr47hdeKvQ9c92cDshvEHXV7Y1K269e64rK5le/h
         ry6shH9RLqRoDScXyPZO83DjerrmApflIo7Tb0h2/at5cVHX1l49293IQ6r83AdgUO2d
         IOQ5YS6zhhHJ/jHPXG8EK8sgndJy1NxJzSC0ZhWtVAlfIc6xny1RUqd7nEb/yAe5bfKd
         xqxP6AmR8GaedU7z9E5D9m4vZNm1Nn/VU3YvYnStJLHRkxCnOytdTc2zAJt2hNyQ+X+s
         yc5g==
X-Gm-Message-State: AJIora9Pfr0+ia7ivhyOfhjqy9LM6gbcy1xHGa312utdV5wvzGenfLlF
        0w7hx8zWkc7ToAE0WBexZaYdzA==
X-Google-Smtp-Source: AGRyM1vHVa1QVOqctlVNbsSYF3nfBtpJmh2+U+f3a78unuHF6Qxh1Lc/2D/beRfuqjRd/l8BzC0h+g==
X-Received: by 2002:a17:907:8690:b0:72b:552e:67c0 with SMTP id qa16-20020a170907869000b0072b552e67c0mr3787036ejc.600.1657723825485;
        Wed, 13 Jul 2022 07:50:25 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:b372])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709060cca00b00704fa2748ffsm5094321ejh.99.2022.07.13.07.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 07:50:24 -0700 (PDT)
Date:   Wed, 13 Jul 2022 15:50:23 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: design: was: Re: [RFC PATCH v2] printk: console: Allow each
 console to have its own loglevel
Message-ID: <Ys7brwCVmQ2iH9xK@chrisdown.name>
References: <YoeQLxhDeIk4VSmx@chrisdown.name>
 <YshL2M8VdIEONDdc@alley>
 <87o7xz5su4.fsf@jogness.linutronix.de>
 <YsvgDRQICB3nEc1l@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YsvgDRQICB3nEc1l@alley>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek writes:
>> Of course, it would mean that the type of option would need to be
>> specified. Something like:
>>
>> console=ttyS0,115200n8,loglevel=3
>
>I like this. It is longer but it makes the meaning very obvious.

Yes, this looks good to me and I'll implement it for v3. Thanks!

>I just think about using ':' instead of '=' to distinguish
>the assignment of outer 'console' vs the inner 'loglevel' parameters.

Agreed, I'll use ":".
