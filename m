Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4A04CF178
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 06:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbiCGFy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 00:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiCGFyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 00:54:53 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE1D5A09F
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 21:54:00 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso12691373pjq.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 21:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KSv9QIsbfJiXaQGiCs/s147I977dhsO/G6YBwREearQ=;
        b=GnoeXDKSBlOj0dhadpOgL+mFjtabPoQW/YITgrVBmaIFj0cW7156yGSR5Jw/Z4zL+z
         GTzWkX6zfKHZikSLY93sxT22xyWpbKlLagtuawmYCz7SjIH1+fOCqs9hlfSDiaOMNr4X
         GBHwF59iAzBRfbSWYz0ILrF14PAPfFyQ81bBPqsqyWZGth0DUTae7YO2Lsp5DKEeVhIl
         QQjSF2zNo/yqlIJBERJ7pt/3ZRYqf87ZskcxarjXPlPqNeOVpZafjVr9i9fFQdxp+jnr
         iXSsXgEIaEYNref588SmFpBluFCAlPOWeWiimAGNj3Oyc719H2fdl6JQPwo30kUn23pg
         UK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KSv9QIsbfJiXaQGiCs/s147I977dhsO/G6YBwREearQ=;
        b=i7hCgC3pJD6jBvmnzxiGoypTsmwb+tQ6b47xKTqenIIXYLiEbjE+6zAYbZDmT5WUYz
         gIaiG2f1S+R249pGWqp3dzfkZfY6q6EAGe3/MY7QGj4yhhxKV16IPr9i8FNgQpLR8aXc
         QAqFKLPvogqc86Eth0GIl5GfGg7hWyEeOTJSDZ1PtEfweQYfvOHH+pm2wtyiTO9Xbw/0
         8HfvqTk+aI8UxOS1C4g/u7hb+8dmHxnMeo5XZ+E1n5ekH7g7QleXI+g0ExE85DVK44MB
         lNqEylaUSgVtVT5l3YUIgmxalfeuKOVT/fn6IQh0TsE0lHsPwfb//RsYf7YCfsN2gt/r
         4a2g==
X-Gm-Message-State: AOAM532NSLf22qxHMOq3ijWHxtYijPqwHxI4Xgl+KweEVrcYCc/ICV2R
        8mVEOuM5cTOKomEZLBA+503MhWgMt/Qxcw==
X-Google-Smtp-Source: ABdhPJyZ2QYIfNhDpZrFweq9RDTxMUQsmX6gTtBZnR88Eo2V3/JoiZYfCyM90fyh37U5e+2/lf59Mg==
X-Received: by 2002:a17:902:e5d1:b0:151:df53:1a5f with SMTP id u17-20020a170902e5d100b00151df531a5fmr6116020plf.134.1646632440222;
        Sun, 06 Mar 2022 21:54:00 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id m79-20020a628c52000000b004f6f249d298sm3448363pfd.80.2022.03.06.21.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 21:53:59 -0800 (PST)
Date:   Mon, 7 Mar 2022 11:23:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     zhanglianjie <zhanglianjie@uniontech.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: unify the show() and store() styles of attr
Message-ID: <20220307055358.cmehf5odv4lo3sdx@vireshk-i7>
References: <20220306021250.64315-1-zhanglianjie@uniontech.com>
 <20220307053931.kkhnxrujljynp5cz@vireshk-i7>
 <62259d22.1c69fb81.5ba55.5efaSMTPIN_ADDED_BROKEN@mx.google.com>
 <20220307055216.gh3aiivz7o3tvomr@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307055216.gh3aiivz7o3tvomr@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-03-22, 11:22, Viresh Kumar wrote:
> On 07-03-22, 13:50, zhanglianjie wrote:
> > Usually /sys directory under the file, the corresponding Attribute contains
> > .show and .store, and their naming style is filename_show() and
> > filename_store(). But all naming style in 'cpufreq' is show_filename() and
> > store_filename(), So you need to change naming style.
> 
> This is something that is present within the kernel and not exposed to
> userspace. I don't see why we would need to make this change and what
> good it brings.
> 
> I would have supported this if cpufreq itself had different names, but
> for this one, No.

Or is it that you want to reuse __ATTR_RW() and __ATTR_RO() and the
current naming doesn't allow you that ?

I will let Rafael take a call on that.

-- 
viresh
