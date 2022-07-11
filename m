Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201DC56D23F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 02:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiGKAjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 20:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiGKAjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 20:39:44 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50752AE41
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 17:39:44 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso3505590pjk.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 17:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2fElT3TUUfTkvZi/G2RoJ9lMYoC606bPsyi+o3zjy8c=;
        b=ql7Pki+UT8IO+fnKHaA6Y55yZD9l9MtPXav2xIiJ2xzaGI7VWlgxemvH4fnkcKslWR
         mV0/iapMDia4C1acYl2TEyd4/vLDJWnw1z5obudrZh4WtKbh9ReUcodJHRmiw7/AZNAy
         9gXR0Eho20adSgJBuXurn4DoEe4ZjRu0tbUuksNWcnj5ip/nt6D2a90Gxbx+TwJYbtgI
         QdvE5xYSHqSNzXI9IEa5I9U0EhcHuPh28wR7aqhGWFzzltUJo6J+i3bZndMWtalRmP6+
         s2VyOqZoO9fkEtz28CwUAa3CuwS2r8fUIiYNNy1PkjKfk9TZev3/Az5zeuSGECj/E4ru
         X36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2fElT3TUUfTkvZi/G2RoJ9lMYoC606bPsyi+o3zjy8c=;
        b=5Z0RmHOcczTp1h4KI8xlbUBR8bmFkKnCCHVlya5zHWyWqCQR+ol+hELl7qE7xM48p9
         QmPRDyCrSn889/rX7nznoRLYNp7NfXpcxgEmb0rAo5iMdjYJzNG7yUnxWhkIPIin4fqe
         GRz6XimYFiynMPlKQsadcWznAu359WiXjXrjcFfFVd+LhWyMHJ5nbM8XQWWLWSVDoQrf
         +fMScafCv6lpCBHztlmDXWCB+QfkmoY0pJ6isIGMWSvxESRe4eExFpEnIp3bEkvm8gJt
         IPRgZ3yVCT8bgTxzytbFqgyPb9RdjHg8lK8pXXbgR6xFT+k9nXf+nrrVemR1sRXpG7KP
         fSTA==
X-Gm-Message-State: AJIora/DxAmAQF0NFuiakcKndEhojUz/P5pYv1nnDJiaaYorBkQ4l1gl
        64vZq+7OIAW0ZfNlYOux+QFWnQ==
X-Google-Smtp-Source: AGRyM1uFiuRHj/H3ttvp2s7eTl7nOVFw9gmkfTWwRUq2hROwTRqJuymncESvq6qIS4Y82IJuLe2vmA==
X-Received: by 2002:a17:90b:4d0e:b0:1ef:6cba:6699 with SMTP id mw14-20020a17090b4d0e00b001ef6cba6699mr14672979pjb.145.1657499983554;
        Sun, 10 Jul 2022 17:39:43 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id x9-20020a17090a788900b001efb8804720sm3388605pjk.46.2022.07.10.17.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 17:39:43 -0700 (PDT)
Date:   Mon, 11 Jul 2022 06:09:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, Ray.Huang@amd.com,
        Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Jinzhou.Su@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
        Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/14] cpufreq: cpufreq: export cpufreq cpu release
 and acquire
Message-ID: <20220711003934.rn2igfoxtpcsiocm@vireshk-i7>
References: <20220709141940.836412-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220709141940.836412-1-Perry.Yuan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-07-22, 10:19, Perry Yuan wrote:
> "cpufreq_cpu_release" and "cpufreq_cpu_acquire" are only used internally by
> drivers/cpufreq/cpufreq.c currently.
> Export them so that other drivers such as the AMD P-state driver can use them as well.

I don't see your driver using them, what am I missing ?

-- 
viresh
