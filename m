Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F55F52966F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 03:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbiEQBDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 21:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiEQBDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 21:03:04 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A58D3ED0A;
        Mon, 16 May 2022 18:03:03 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 202so15607196pgc.9;
        Mon, 16 May 2022 18:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FFnrYrR8btBvbK2FeC/j5VXcaMZlzan2Ot1C6tFuF8E=;
        b=TLYqtL/qWUEIAQNVfIfY7qhZdSRy88dfPqpG6VBa6IhU9g71r7r3CQ5l/9i3bOpk3z
         3oju48qHYqB4tx1KrkE8SlRiC3RNmIlZ2lippuBIBW/5qiqo8BWIP+0IVVKjFV3mmQ5Y
         3hSSZXqBR3UGXPxeVuiErVf4x7CkiJQRbAO+TU9sKlYk99tXHmven72WtqXAaN0NDTRy
         6974HLSj3JdzlZpVSW8JJrxeYg8JpZK8z+h9uX2Y9op3eC6kH4i9yA005jreAvEV+ljv
         XVxq1yUITdte0jaKK/YjeyJW/tOvFyqasHpdym/7SWmYbgLFbv7EIlzpqnroIb4CkR2s
         fg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FFnrYrR8btBvbK2FeC/j5VXcaMZlzan2Ot1C6tFuF8E=;
        b=sW/9w8yfkiKiotFTIw2oMaMoEdNkIOQ+R6568puXwsaFMkVYq7qfB878iBpgLwC1j3
         RJPoHZ9ozV6hFuMAqx6Tin14xvcw/sqHT/3NsNoqroiNHCfNBf9gbGIQJiirpAHNyus5
         sO+t5gnGrF6tuE5gnq6FbMRIH+5QX3f50tDS5YMwO9qBjRC97WKOmOLtWrSCmZxhMgiM
         1NAW+rNu6joVTFWuPj9blON6VUrpfSxyWXyJnKGM4Cphp5kudjRJkOT9OW8Dl2Qdw5Co
         DVQ+7Y/C1TP6Tj6B/XdLNBjO2Cz8mPCWI81fdN85uo/W2tjzJj0j+qkVA+sAHXMBpr2Y
         Wg5A==
X-Gm-Message-State: AOAM530eIV/AgQWzevNeW3kQnPh8D02f9/8Pw1GXs+7Qu2alLz3CJ73x
        wif/DJs+OpnnXQRyA8tiQL2YUnKGrwE=
X-Google-Smtp-Source: ABdhPJxIhi8angBGgKVD+iGxGFgtn4wr846sa87J7D9O24KBw/u7GHlgd8+kFwCAkh2DZ3OQrRQ4mA==
X-Received: by 2002:a63:4f21:0:b0:3f2:678b:89e1 with SMTP id d33-20020a634f21000000b003f2678b89e1mr7319416pgb.596.1652749382497;
        Mon, 16 May 2022 18:03:02 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:62fc])
        by smtp.gmail.com with ESMTPSA id i76-20020a62874f000000b0050dc7628132sm7728981pfe.12.2022.05.16.18.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 18:03:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 16 May 2022 15:03:00 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com
Subject: Re: [Phishing Risk] [External] Re: [PATCH] blk-iocost: fix very
 large vtime when iocg activate
Message-ID: <YoL0RHmU4tbS2f/F@slm.duckdns.org>
References: <20220516084045.96004-1-zhouchengming@bytedance.com>
 <YoKb7wpkz3xoCS6s@slm.duckdns.org>
 <bcd0956a-9aa0-3211-801b-1f1eace6de79@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcd0956a-9aa0-3211-801b-1f1eace6de79@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 08:57:55AM +0800, Chengming Zhou wrote:
> #define time_after64(a,b)	\
> 	(typecheck(__u64, a) &&	\
> 	 typecheck(__u64, b) && \
> 	 ((__s64)((b) - (a)) < 0))
> #define time_before64(a,b)	time_after64(b,a)
> 
> I still don't get why my changes are wrong. :-)

It's a wrapping timestamp where a lower value doesn't necessarily mean
earlier. The before/after relationship is defined only in relation to each
other. Imagine a cirle representing the whole value range and picking two
spots in the circle, if one is in the clockwise half from the other, the
former is said to be earlier than the latter and vice-versa. vtime runs way
faster than nanosecs and wraps regularly, so we can't use absolute values to
compare before/after.

Thanks.

-- 
tejun
