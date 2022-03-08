Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89654D1B2F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347732AbiCHO7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347727AbiCHO7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:59:25 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66594D639
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:58:28 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id o23so16649853pgk.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 06:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EIHQhGYe/IonazUedNQ9rn4Tds55qiYeJd7kQTIiE5g=;
        b=ZQgN0a4LPlKegr1ijG2nqH33XlXESjk/Ncxr1LCMdLVuR6X2ASC3+ln3mZ1aiKcRAT
         kzFZMu2XHFUYP8HMgA3Ry3lV+WvnixDHFgjm27HFVMZSgArkxcwbWMoekNNv+uY2dsor
         USxv9QQwoe0xiCaVQzoOMpjSIJb4s1spjnLFIsYmZ71rePg4U5xW1b/5HvGnyQaP1A4w
         wXCcOJlrFMgYPbKIHnWr5xkh/v93M45SXMFm4iT7NZpkjFOdcL+uF+Lwx7O9Iz+nn/qZ
         aIgF434Qd2l7+A9OC8Wo+J1omCQFfvNnPmssOn4U8MnDLrDJIpLElfusVEDrQ7WGhQHQ
         YP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EIHQhGYe/IonazUedNQ9rn4Tds55qiYeJd7kQTIiE5g=;
        b=4TzgPW+3Fn3MM4K+ZiireydqZxzppbDdAUrwCWgqyjOi3wRiIHfYt6QYePctmGOrGh
         73zkN2WOh4Ecg/9rYcsI5hSIIueMBBtoLJCCBeqm/9ewXMBqqpKTXRd/8EwX2yP0NV0Y
         k1qU78/xUQ4laHms/f0mwTFXDoT7KCXChK24P+vjRcpKHdSazod1eVkF6i93LM/yH1WC
         3mnB6429fBsb4hRiwYxoN7+tiDn88IsxN0qP+uiNAbsc49P5UfpcAi0PQ+4BXk0jvgsM
         e8UiP1Y/12usto8ifquHP0MWmRgx8hisX70LI5KuRQk7r0QSzt/KjOSerBXOVYFJeB/X
         Agtw==
X-Gm-Message-State: AOAM531BWH4ah4q/07DsLUQ/BVc5FK7I7sPLnL7E1PZ6eGRlYs/RdL7l
        91bsqEMjq0pCw13xYWl+4nFUyA==
X-Google-Smtp-Source: ABdhPJweKxejzgCbTQK+V/ph5Npc6K34TF7/oEOan+2RR9GjqBKn1W7x1Hfa51D7eGEiJLl3km1crA==
X-Received: by 2002:a63:4a4c:0:b0:375:6898:f6b6 with SMTP id j12-20020a634a4c000000b003756898f6b6mr14589068pgl.83.1646751508333;
        Tue, 08 Mar 2022 06:58:28 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id t190-20020a632dc7000000b003759f87f38csm14952418pgt.17.2022.03.08.06.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 06:58:27 -0800 (PST)
Date:   Tue, 8 Mar 2022 20:28:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lianjie Zhang <zhanglianjie@uniontech.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cpufreq: unify the show() and store() styles of
 attr
Message-ID: <20220308145826.2s4gc2m3feqvgajl@vireshk-i7>
References: <20220308140917.56923-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308140917.56923-1-zhanglianjie@uniontech.com>
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

On 08-03-22, 22:09, Lianjie Zhang wrote:
> From: zhanglianjie <zhanglianjie@uniontech.com>
> 
> Usually /sys directory under the file, the corresponding Attribute
> contains .show and .store, and their naming style is filename_show() and
> filename_store(). But all naming style in 'cpufreq' is show_filename()
> and store_filename(), resulting in __ATTR_RW() and __ATTR_RO() macros
> cannot be used to simplify code, So need to change naming style.

I haven't received the other patch.

Since you are going to resend anyway, I think you can merge both the patches and
instead of the "Unify" part, just mention that you want to reuse the __ATTR_XX()
macros, and so renaming is being done.

-- 
viresh
