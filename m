Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DC25ADE85
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 06:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiIFE2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 00:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiIFE2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 00:28:19 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA8758DEE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 21:28:18 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so3507643pjh.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 21:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=0CpPNG0zcDbXwiTjGR1QVIpcy+thYdlOPvjV+Rf1XO8=;
        b=bkXv+JX7Ce3U+ZqgB/7lXOLDmJBruQ9kR/pk17v6vGP1G1aHZuYjSu4ib99UJ24Tns
         rIq/7M5e4LGkWg0kQ+wH5lLxwf+EZABy+VS8qQbIBGdw3l55zDhoxdf4Kc9KUuZhoYCR
         CqbPXiK1Rrgw6q/Ei1dasP2XlBBMfQT9OSibYtkppAl85YtJ15wtEXJZ0dq/pS/szg+Y
         yhOxJ0XiN/4s136C1ZwWWauY5OspbnZQt+J8XwdYLF8lg4mR3H0JRdCJBk6Jp8wCGjX+
         S5ssq/AwbQYwWqQ64C/R5KT7A6iMEnhaJs3TSlFixjV5emnIjqAiQbK6lxG04cDUd8mG
         PbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0CpPNG0zcDbXwiTjGR1QVIpcy+thYdlOPvjV+Rf1XO8=;
        b=3AbavDOmdaL5ClHCHPf2P9vXTc4nCMe6vtRdjDH8Odn63JQo2ZX37QMifU2VjAIIS5
         UG/pUdYMfPUGUyliGthqfMzZlPNy6QpD8mi4Ohz8pHnUlsZqf0JaskyogEgUTXoBhwCZ
         ua+flbw2ftAtM0AVEpLN5hON9h2y99whMLhBRMgVXucGMoJFZewG+GaCmKkE19xZHpD+
         lOUYXUF9QMiv3fVf6pwlEDHvciuar8DSDdw872rTztp0OZouaPlFkJXtH+z8O2a10wht
         3H+Hgn7KT3fF65tDPvGwdUPRn2tqIGLgYUUIbatFHAK+8dqsjz5AfcCx91TkzjkdGlYr
         7Q8g==
X-Gm-Message-State: ACgBeo1QS4YWeQk0cYDltd7ZEiNhK3IpM4lfqxIz2vyfGZs2R2h1K7fQ
        3XW17CxkZhyhSX9QbKdM67HRTQVxB4SJamcs9qs=
X-Google-Smtp-Source: AA6agR4Ft+/ZEkB8w8MQnsGC/Z89MhiTEi/HWp2l7vumm8TX/fMV2UmmxGGPM0H/42iYnxJLu6luwA==
X-Received: by 2002:a17:902:9887:b0:172:7090:6485 with SMTP id s7-20020a170902988700b0017270906485mr52534426plp.63.1662438498147;
        Mon, 05 Sep 2022 21:28:18 -0700 (PDT)
Received: from leoy-huanghe.lan ([204.124.182.10])
        by smtp.gmail.com with ESMTPSA id p2-20020a17090a680200b001efa9e83927sm8754268pjj.51.2022.09.05.21.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 21:28:17 -0700 (PDT)
Date:   Tue, 6 Sep 2022 12:28:12 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Shang XiaoJing <shangxiaojing@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] perf c2c: Add helpers to get counts of loads or
 stores
Message-ID: <YxbMXAM53PzXfgvF@leoy-huanghe.lan>
References: <20220906032906.21395-1-shangxiaojing@huawei.com>
 <20220906032906.21395-3-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906032906.21395-3-shangxiaojing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 11:29:05AM +0800, Shang XiaoJing wrote:
> Wrap repeated code in helper functions get_load_llc_misses,
> get_load_cache_hits. For consistence, helper function get_stores is
> wraped as well.
> 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
