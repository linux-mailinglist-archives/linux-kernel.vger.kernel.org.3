Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27385A4197
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiH2Dwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiH2Dwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:52:41 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E37402CE
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:52:41 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id z187so6970003pfb.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=hC9a6VjiRDFmPP4lAwhT38/UuH6AeBV07jfmc/Byr20=;
        b=Dd12flyZ+5uXKdEJoxw0VkPK1uNnHuxvoffdJHrKvPxeYnspkg75e7F0B/W48pdnkn
         M6u5tT80aQqUJKRRDkisT31khpytUScXyW9iZPXOoEdvC13sUT5D9iw/+ractzd9cX8e
         xensOxDk/HntRpCtByRQjJqG4rJMhSZQEsfTDw/lKZUM+r6Ufl0D6cPcjIVfFEt0pzdr
         ko37cukAmzALSinOHt9+XuqFZ5pBlPwrPCsUfIutBym0ToX5nssHufeIEuRt97MBULqN
         omt7zk5ZylzyfKV0GXcvxaeGm8W10awf5raf+aj3KMg89Cop4aR3vDf0hZjK7XQ7z0z9
         vTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=hC9a6VjiRDFmPP4lAwhT38/UuH6AeBV07jfmc/Byr20=;
        b=EuEPD9lirSZH2ZW/+Aa0bPI9UYQRITjQ2ORJnc8G+9l2vTESy+7Q4kqbCOyEickrNy
         PrlV/H4qrOSjz69E/uGBwPwAm9Ogk5UFfvsrbL9CutiJpzSSpVslOzRhS3rUr65HBZRZ
         6tiSO5c31+52xHpd3S0Vm/UozYPsoV+eUXhoPLR/fIt1gmCP5AAUkQcT68GImPj2Ll8q
         3AHK42ub9Pp8c5K+INskMPLaYcWjpG/KEA6qc9TJqoruTUONhloreGmYvgiGCD+XkYrX
         xPzS77bRYq2wmYOkUWm0Wvuc5GLZIwTN72X+NC6hF0oqhZt9m6FWggIFu30HI3SRu3kt
         0aTw==
X-Gm-Message-State: ACgBeo033b1Kcc+lXwBgFDIF717ct+bt4le/O9wFA6YqU1eunFPxwAVU
        qGDI7ENfUgT5/D6NT5El+cQqqscL40dcZg==
X-Google-Smtp-Source: AA6agR5SCzC3RHmi6oq0B9IeD1j2PdMx96DkGBY95dwliMrogkMMF1CSI7VbfqXOs8qBIyRLTMAmJg==
X-Received: by 2002:a05:6a00:8cc:b0:52c:7ab5:2ce7 with SMTP id s12-20020a056a0008cc00b0052c7ab52ce7mr14497792pfu.28.1661745160541;
        Sun, 28 Aug 2022 20:52:40 -0700 (PDT)
Received: from dell-PowerEdge-T440 ([183.14.135.208])
        by smtp.gmail.com with ESMTPSA id s16-20020a17090a075000b001faa4a6691asm5443857pje.30.2022.08.28.20.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Aug 2022 20:52:39 -0700 (PDT)
Date:   Mon, 29 Aug 2022 11:52:33 +0800
From:   Puyou Lu <puyou.lu@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Robert Richter <rrichter@cavium.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/gic-v3: do runtime cpu cap check only when
 necessary
Message-ID: <20220829035232.GA13376@dell-PowerEdge-T440>
References: <20220827051328.GA18042@lu-N56VJ>
 <87wnatra83.wl-maz@kernel.org>
 <20220828075610.GA30202@lu-N56VJ>
 <87r110qong.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r110qong.wl-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2022 at 06:11:15PM +0100, Marc Zyngier wrote:
> Well, what you got wrong is that these instructions are stepped over
> two branches when the caps are finalised, and that doesn't appear in
> the disassembly (you need to look at the code that is actually
> executed).
> 
> Now, any optimisation of the sort must be backed by some performance
> numbers. If you can show that this has a meaningful impact on a given
> workload, I'm happy to look into it. But only if you can show that
> data.
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

Thank you very much for correcting me, and sorry for wasting your time, I
got it now.
