Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF4D4B7E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344277AbiBPD11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:27:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiBPD1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:27:23 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FC8F47F0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:27:12 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x11so952796pll.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d0obdckfO9b8+Ix1IY/Lb8K6yQUQDO+yNZYEILx4nts=;
        b=Vt0axjNtDBTkJFvT3L3U1EDAeQMYGG2vNbSuf+nVP3oueZwDcDFAjtvYl/OL6ddjwS
         nCc67BtlCaq31A83dVCTXufhRR+3Ta+3SXUPyes0svS5dYYAXTO/gu17MeAzbkEoJRLC
         fVxUlqaeaVT8/aMIEtQPb2QRTW7Wn2kU3q4SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d0obdckfO9b8+Ix1IY/Lb8K6yQUQDO+yNZYEILx4nts=;
        b=Lxk284sIaRSWuKTeZpWEGqXDVWBErR4M+vaQF5a3ffDwJHu5TopqCBHvcoeyKoS5pR
         sPZXRyjC/dFV1uq9JGexOALzSxu3lb/DdDbdsINZE9Epj93l7mICOLRNyxxXAlq5nNZ7
         XMGUTxSQcLmBE4wywD8QOW2DUYfZrWS83phRhFtTPVzgLWGnZiHS5xwIy24DHOSbBDRH
         pJlDTd+MVheATwJHQm9v+uYmaNLPYAXRSI806/i4den71zlHvfPsP3gprUR25x5eTUhm
         v6/V2mJ5GQlLAVd9BnlMTMdQqqDqwfHRc5/BtEn+mSZ8kaF5k1Uf05hn4E/5J7ekYxB1
         9U8Q==
X-Gm-Message-State: AOAM531f+ez8UwJvIzWoF8nL8nYfm5LDE3QEawXaCm1r2tnZQHPPvfYU
        IvlbfS3zpPO0gwZzAM0mlLHAcw==
X-Google-Smtp-Source: ABdhPJx7k39W2+ny5rSwR0OyG8U+HdeG6aBJmzYaInkA36C1D7rcETZ7j4JW454cLgsB0630zmOJcA==
X-Received: by 2002:a17:903:22c6:b0:14d:8a9b:a9ad with SMTP id y6-20020a17090322c600b0014d8a9ba9admr564663plg.141.1644982031515;
        Tue, 15 Feb 2022 19:27:11 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:c926:4ee:add9:bf67])
        by smtp.gmail.com with ESMTPSA id u4sm4446007pfk.220.2022.02.15.19.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 19:27:10 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:27:06 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH printk v1 01/13] printk: rename cpulock functions
Message-ID: <YgxvCiKeetKZ1U4K@google.com>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-2-john.ogness@linutronix.de>
 <YgZaMkUU5Ve2GV9D@alley>
 <Ygn7ZFnFL4QiQHRg@google.com>
 <Ygtyb4WFVlv/earX@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygtyb4WFVlv/earX@alley>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/15 10:29), Petr Mladek wrote:
> > printk has been using enter/exit naming for a while now (starting with
> > nmi enter/exit, then printk_safe enter/exit and soon direct enter/exit);
> > so may be we can follow suit here and use printk_cpu_sync_enter() and
> > printk_cpu_sync_exit()?
> 
> Interesting idea.
> 
> Honestly, I do not like it much.

  :) OK

> The existing enter/exit API is not blocking but "cpu_sync" API is.
> 
> This patch is about how to make it more obvious that this
> API has to be used carefully. I see the following main risks when
> using this API:
> 
>      + it might cause deadlocks, especially in panic
> 
>      + it is supposed to be tail lock (no other locks allowed in this
>        context)
> 
>      + it is re-entrant
> 
>      + it does not prevent parallel (nested) access on the same CPU
> 
> 
> "get/put" are more acceptable for me. They create at lest some feeling
> that it tries to get something and it might take some time. Even
> thought many "get/put" APIs are not blocking.

I don't mind "get/put".

The thing that looks nice in enter/exit is that enter/exit don't
expose any implementation details: is there a lock behind or not,
is there a ref-counter or not, and so on.
