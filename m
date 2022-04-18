Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344D8505FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbiDRWxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbiDRWxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:53:11 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740B31CFDC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 15:50:31 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s137so21482802pgs.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 15:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hlb2EMJVRbxJY9nryaoQfoqqjbD8gDeVs4kmOgbzyns=;
        b=Y15WH8ufHsPs909Ri+VdtpONn/6MTLfKFOuqPK6lFVv9bFYOcpty6TXA38L6B5zZiD
         xbqvGKqaIV+AH7Wh1U/QUc8OAc++oDlVkdkt+gmVTI4WHkFETQWBHhNUHoR7xiksgJcw
         3uSpRIu431vi6O3ctqpj6DAJ38jcLpLMI48xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hlb2EMJVRbxJY9nryaoQfoqqjbD8gDeVs4kmOgbzyns=;
        b=YoNcqX6nASjsIb+7Vu9ubh5Zd58/jTgY6g9ZW5D3It4T7ov8LVzd/uM8rl0zSuF8Zr
         k4dX5Wb6oQPus+QhEbCvNXsHXO3PPI0KXJ1o5/t68WDKUkj+sWFRzuurt+FAid2RBd+V
         D2aGGQupqbYLANRNUoVr351SD7MpfzR1shDsJzLuOar40Xi2/nGexe6OADUgzp75KNuq
         GUg6rYcfGSohDLP9UagLxM8JY3Vr9WqHhBNJr4K3EybLeBwUHNtx5gywf81z7v/bWvzb
         OzpqlJ0tA4dltzTy0Udise7fJF9qTX82crozJUvSbhc7IuVPevn1Xgaq8yWqMnebCFtT
         j98A==
X-Gm-Message-State: AOAM531Heu376KSqhdYJNezw80ecNh7XmLO79c/6jznCDl8juz4ZBuXm
        q2KWtgXXuObAxoWSmCp7AQNzng==
X-Google-Smtp-Source: ABdhPJxWqTDnAXR28mJKj5rBjV8r/WVs4S8ffaGYUrQssCg0Z7LQVgkmftgrfj3M5qP+BZGGofOiFA==
X-Received: by 2002:a05:6a00:b4d:b0:509:1ed1:570e with SMTP id p13-20020a056a000b4d00b005091ed1570emr14728356pfo.19.1650322231039;
        Mon, 18 Apr 2022 15:50:31 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6b32:a0a5:ec32:c287])
        by smtp.gmail.com with UTF8SMTPSA id p17-20020a056a0026d100b00505ff62176asm13415099pfw.180.2022.04.18.15.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 15:50:30 -0700 (PDT)
Date:   Mon, 18 Apr 2022 15:50:29 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: core: Sleep (not delay) in set_voltage()
Message-ID: <Yl3rNeaYTz0CPjmL@google.com>
References: <20220418141158.1.If0fc61a894f537b052ca41572aff098cf8e7e673@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220418141158.1.If0fc61a894f537b052ca41572aff098cf8e7e673@changeid>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 02:12:39PM -0700, Brian Norris wrote:
> These delays can be relatively large (e.g., hundreds of microseconds on
> RK3399 Gru systems). Per Documentation/timers/timers-howto.rst, that
> should usually use a sleeping delay. Let's use fsleep() to handle both
> large and small delays appropriately. This avoids burning a bunch of CPU
> time and hurting scheduling latencies when hitting regulators a lot
> (e.g., during cpufreq).
> 
> The sleep vs. delay issue choice has been made differently over time --
> early versions of RK3399 Gru PWM-regulator support used usleep_range()
> in pwm-regulator.c. More of this got moved into the regulator core,
> in commits like:
> 
> 73e705bf81ce regulator: core: Add set_voltage_time op
> 
> At the same time, the sleep turned into a delay.
> 
> It's OK to sleep here, as we aren't in an atomic contexts. (All our
> callers grab various mutexes already.)
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
