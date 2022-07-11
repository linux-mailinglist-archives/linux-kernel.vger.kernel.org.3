Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D5856FFAF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiGKLEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiGKLDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:03:51 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35ABBA3B4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:10:50 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 145so4307078pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8hQbQuIkXH2nGerXV36d8aZidSoI6QgUgjQAkOlJd1E=;
        b=HNqkU+6COV5zPrcjrdTrk/MnpONKK1qsXD/joQnTTCWeKDnbrIlpVu8fG8OTdmG0cu
         NbpQDgkbIzDhDD2e46iTwhJVe+PrFSF9dfCQciCUsS8xrR03uHUd0DoGp8S2bIkR4B2u
         fSKcJ6tHuDXTFJNG+Q99FGejke7l+U0ktxeCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8hQbQuIkXH2nGerXV36d8aZidSoI6QgUgjQAkOlJd1E=;
        b=CuovVjNnmGCawcqscJvQ2k2F0NwNgeASTEiLhSwgJqPrXl/ZKTn3vnkQIHgDSATOt+
         cakxTwZ1rsNBKL4MLjCVuvu3m9Fc++/OaLVyEDwcysFMGxH8Iba4ErGVg+qNMt8CuBKf
         V4p6bm6pr2kMBkBml/PBy2gvmEHas0YZ0+MGl9pZw8GC36F4g90IuhNrY7hRQY6WTDSp
         Oj1xkSDjrY2HD/3+0qIFMKJmPo8K8PaG0pm4BtX6L2gBqnO0sa93VC2wsbu91ehseug2
         qCTYzDY1IOnxm9+FqxL+PlONpS1dLNEnYAQG4lHqkAhasycsJL9vMyry+/v1kthdqJdA
         dijQ==
X-Gm-Message-State: AJIora/1F5dIVD7oJiudDNRp7Bdv645pwTRtxcmb40WErKB7fHQevErG
        VT76ecWdXFw3465jt7YIjESsmA==
X-Google-Smtp-Source: AGRyM1uzUJheRLsOh6g4rN2qYYRG9lFr0c+/BQ+0Zzqd4yX/KG08Rl0SlssZT8yQL6EuogWTW0hmrw==
X-Received: by 2002:a63:2a8f:0:b0:412:5278:b90 with SMTP id q137-20020a632a8f000000b0041252780b90mr15136947pgq.363.1657534250032;
        Mon, 11 Jul 2022 03:10:50 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:ef9b:8bda:6cfb:9c5a])
        by smtp.gmail.com with ESMTPSA id g6-20020a655806000000b0040c74f0cdb5sm3864633pgr.6.2022.07.11.03.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:10:49 -0700 (PDT)
Date:   Mon, 11 Jul 2022 19:10:44 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        todd.e.brandt@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: PNP0501 serial driver takes almost 2 seconds to suspend/resume
 (printk issue)
Message-ID: <Ysv3JNs4RwE7kAou@google.com>
References: <12fb98fe27e23e3f74a139e5e8eb83a97a343372.camel@linux.intel.com>
 <51b9e2cc3baf61a604bd239b736ec2d12f1f6695.camel@linux.intel.com>
 <87czegxccb.fsf@jogness.linutronix.de>
 <045ebee30af2b80aaeace1dab18ecd113e3f17c7.camel@linux.intel.com>
 <87tu7qvx1q.fsf@jogness.linutronix.de>
 <CAHp75VfyzMNMO2NRwXwSjAmQqBbdRG3+SzyFDG+90dmvmg1xLQ@mail.gmail.com>
 <87o7xwbuoy.fsf@jogness.linutronix.de>
 <Ysvbp8vz7R9hDNqx@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ysvbp8vz7R9hDNqx@alley>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/07/11 10:13), Petr Mladek wrote:
> 
> It seems that __pr_flush() does not check whether all consoles
> are suspended. In this case the progress is not possible and
> it has to wait the entire timeout.

But isn't console_suspended set after pr_flush() call?
