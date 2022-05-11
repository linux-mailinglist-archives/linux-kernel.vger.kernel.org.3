Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C47522A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 05:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbiEKDLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 23:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiEKDL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 23:11:27 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8398B45533
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:11:26 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p12so872592pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/x6uo1YySXVMLYO/GR/TQls5y6E3sKPi/YP3GhypGFk=;
        b=Ss4NkiyqC3bq8cAuffyQ0iwYDABhyU2Bmtws0Zju/x5ERdtwcC7kR2Yu87c3VuIEMK
         Us/T8zJF69f8JhtbzOnWhlkgyDPbnKmb7cAjhTh8x9mOSCQCo54/SoKNIjhP2UWbxKrd
         OhmjNkM2VQLEoTQxnIH6fIGpsOO/mb887TqU5x4JfO7BkiARzqNWh1dLHMbbjn2AKs2i
         Yr1nBfWNwwyz0TNZQJlo4nM/SVRIV7C28eZg2asClU6v9zEecf+z/IhjBSBT9IPtjGAC
         dhEorDpsEc5Q3azs/y6HXiDKqBKwlMiQt7uffoM/b2w3dfq8fDgAgY+sHRq3mFbFG2bx
         DLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/x6uo1YySXVMLYO/GR/TQls5y6E3sKPi/YP3GhypGFk=;
        b=KRs3Auq+lP3PTavUlfHVLCsTQ2+6VlEy6URohrP8ESheMdCdQWu86/Ona6p80dkWW5
         OdxVzCP5dxWemespJ9JebE8d7JSI0KFrVpYG4PDyZpnLNq8i4HfXh7IwH2baBdzxN4NF
         Cp3+7Dirrj6JO6L9NzeOdepEeVWwepPEDV7Yt+IXV5dJoRYgh6Dp13YIIS+gLXsINdGX
         hVqnSlp8SsE7arKsN9xs9Qe+kpM6NQj7/2SagJ7P7arBf1Y/NSMBCS5hxkNmMuUzzFgx
         KnH+6fJITPoA/PCHkRzYn2r2zF0JiP5OHraA7WO8gW4rWctJfIvlGg/LpyVODpBpEX7u
         Brjg==
X-Gm-Message-State: AOAM531OH+vUqTY9pMaYTfDBX0ClrTdJ2SAnWsGMMVuZq//QaXAtry7B
        8b6rQQL7oUVfctm0WHlz9AQr5g==
X-Google-Smtp-Source: ABdhPJxnKGmk6n2YenuG5EAv9qkr4u4nbDHBXiTYS9Yf0cFdI8i1GC36oqUHBwKgp7qcqEn/BpQGzw==
X-Received: by 2002:a62:6dc3:0:b0:505:895a:d38b with SMTP id i186-20020a626dc3000000b00505895ad38bmr23391446pfc.7.1652238686017;
        Tue, 10 May 2022 20:11:26 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a191900b001cd4989ff42sm438581pjg.9.2022.05.10.20.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 20:11:25 -0700 (PDT)
Date:   Wed, 11 May 2022 08:41:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Jiabing Wan <wanjiabing@vivo.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] cpufreq: mediatek: Fix potential deadlock problem in
 mtk_cpufreq_set_target
Message-ID: <20220511031122.kkotwq7co2vx5zqp@vireshk-i7>
References: <20220510090531.12438-1-wanjiabing@vivo.com>
 <20220510091212.olrvvjlx4jtm7zw2@vireshk-i7>
 <49566544-e8f2-ef38-288e-fcd276d87d3b@vivo.com>
 <20220510092822.j3z6bydurg7x5bu4@vireshk-i7>
 <0181c505dd94c599b270f159ca93442a4afe1760.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0181c505dd94c599b270f159ca93442a4afe1760.camel@mediatek.com>
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

On 10-05-22, 19:23, Rex-BC Chen wrote:
> I am not sure what's the problem.
> But I subscribed the linux-arm-kernel mailing list and linux-mediatek.
> 
> As for LKML, do you mean subscribe "List: linux-kernel;" in [1]?

Yes, this is one of the most useful email lists and mostly gets cc'd anyway, you
can disable mail delivery if you don't want to get emails.

I asked because I couldn't find your email in https://lore.kernel.org/lkml, but
its fine either way.

-- 
viresh
