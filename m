Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79985521059
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbiEJJNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238442AbiEJJNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:13:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670202555BA
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:09:48 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p12so14441150pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XSWbv+Ep/+Movyv6deaCjO1wiUE43cnYmOPnE+KhShY=;
        b=InV8ymO/0KYq9HcbHPDzUpNCNY2tYQsq9hirMYdloDuxo6cf1pmiZ4s95TKpKxDEcb
         aToeQIuxQ+lqIYo5EPxdXoEEB3gw4t/q9aLkS7CBbxXq72/nwbAlod397u/fG+q2k3YZ
         VUHOVvkCCPVxJ//otLXECEBR9BTzlaRbFzQN8RvONDRstQAA4sIbVdfp0WMhQ6J2zpVr
         CcDT95pgoPn6/34BaRT7OechnYzMknBbMd4YOPvHxtSo6vdjvmtIZe5KZHabrfiOJinA
         Ucbbds97FV5W7f5LnN9uG6/GwHbyN05B7rK0MXV5N9FEDIB7wweTlUJkkrKWRuCimOOF
         QZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XSWbv+Ep/+Movyv6deaCjO1wiUE43cnYmOPnE+KhShY=;
        b=Nl6qyA5brAG6fijy6dJKJlIbkSJw00JPdtd0IMOmNbdwi/FohpXQVU9ON5uZIjMLQZ
         fxIYzMHgOAwrrqSkBulwwK9Ty9LpCFC+FagFGox3p88Z5RTwHP+4c8RICGdwclfRlr3e
         K5/6ATUSP6Wy8WZV5LPbeRbX8OTpdtJecFvIYW/QIP1p2sVeNYy1WZnogXqqr+9PWwcc
         Ewz7cJhtnPqQN2Zu80IWdzdPkmolTnupt8HIyIDczenh0eigcKYJLpM6l/QleHm9z2Mz
         lHYj+Wz6ejfXJwKJ198nlawUeFEYQf4+dWt9bM9XrubDbVV+dakUG0zUqNzdGDgqf6HS
         LVWA==
X-Gm-Message-State: AOAM532qYlT35pKlPZVXLWkfm1Rmgur+yU+VMu1IV7vzsjFjW/e3kQeZ
        2LGKqbNPVAKUMfCU3zrLld5YBQ==
X-Google-Smtp-Source: ABdhPJwXu+6bfJ2FOMd/hrpU0J6EJlp4sESW0BPiddeP9MlZQt9lZsG0xZQKTVaKRYINu2N3ZA+IGg==
X-Received: by 2002:a63:6989:0:b0:3c2:3c19:d661 with SMTP id e131-20020a636989000000b003c23c19d661mr16214262pgc.352.1652173787953;
        Tue, 10 May 2022 02:09:47 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id c17-20020a63ef51000000b003c2f9540127sm9896907pgk.93.2022.05.10.02.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 02:09:47 -0700 (PDT)
Date:   Tue, 10 May 2022 14:39:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jiabing Wan <wanjiabing@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek: Fix potential deadlock problem in
 mtk_cpufreq_set_target
Message-ID: <20220510090945.qhqomdqemrtrqdyo@vireshk-i7>
References: <20220510080136.11950-1-wanjiabing@vivo.com>
 <20220510081232.4u25qgryszzqblho@vireshk-i7>
 <61a4b23f-9740-6fb4-abd0-640d3353e788@vivo.com>
 <20220510085050.tza6rjvdkjsrhrjv@vireshk-i7>
 <340a3029-1ab1-0e64-0c18-bb2464614919@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <340a3029-1ab1-0e64-0c18-bb2464614919@vivo.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-05-22, 16:58, Jiabing Wan wrote:
> Yes, I write this line by hand.
> There must be something wrong when copying the subject line.
> 
> Maybe I should find some tools in git to avoid it in the future.

Add this to ~/.gitconfig

[pretty]
	fixes = Fixes: %h (\"%s\")

And then just do:

$ git log --pretty=fixes c210063b40ac

It shall give you:

Fixes: c210063b40ac ("cpufreq: mediatek: Add opp notification support")
Fixes: 6a17b3876bc8 ("cpufreq: mediatek: Refine mtk_cpufreq_voltage_tracking()")
Fixes: ead858bd128d ("cpufreq: mediatek: Move voltage limits to platform data")
Fixes: f126fbadce92 ("cpufreq: mediatek: Unregister platform device on exit")
Fixes: a3b8d1b12c6b ("cpufreq: mediatek: Fix NULL pointer dereference in mediatek-cpufreq")
Fixes: ffa7bdf7f344 ("cpufreq: mediatek: Make sram regulator optional")

and other patches as we did git log.

OR

Else you could do something like this to just see one commit:

$ git show -s  --pretty=oneline --pretty=fixes c210063b40ac

-- 
viresh
