Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2310A5ACD8D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiIEIVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbiIEIVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:21:35 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AEF32073
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:21:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u22so7797351plq.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 01:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=QJJrkpuUMAiWhW4XzbfzTI5fC6bC6BtFi/fBmxaoJTA=;
        b=f6XX12/+aqewys372pQoz6A/jL49JWT+dr8npWMakmaFD+gfhU4xyR15G1USnL733p
         IgWris/UsiHHuZj3ofYqdFhukzZSbA9CY150fSLJxtISrBKx32pf7B2oq9zrWr82lUws
         t6Js1k2fxKpQWM9viuLXDmMUHA++QlY8B6O18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=QJJrkpuUMAiWhW4XzbfzTI5fC6bC6BtFi/fBmxaoJTA=;
        b=iIn6F0AICJyFpDncSVFrt4ZmXiFzWYVNokMwnyAD6CT4LjGfIs95AID6aPAuiPmJxW
         Lx1gmSZNsRuH+O/2l7hlJMZe7KOIA12jGxEvAjJ1ClkJ3GGG9SXrTiM7+6QO8nSpl157
         yyEV1QQBtWrvuri5w8pMNN7wNNhCk9RTWhtj1AYX+94uofQD1c9tNqOQFhqyfSUQyolO
         ifCyF1n+cBlQJiEciD93JQfriQ6wJYFbsJe6e3zHZrQ2yAwYqEWwn7vy/zFXtAstxCW1
         loDrN5Tc0tSLKIuZrdpLd+4bZ0ICuX4FWl5X8yzjASPkiCxch1h0sh33U5KYIS5Lok7q
         7PGg==
X-Gm-Message-State: ACgBeo0T+VUbXZxbs0tJ0bUj2QDBRiLu6Z7C2xi0HA51+JFHEFQAlTsh
        RalevlJZU+1wII4gfmFcyHtt9Q==
X-Google-Smtp-Source: AA6agR5AroDfDVIj7QlIYRSAnSG4/lXstugSOvJ/A+iboIXnwjzC5rplGgQkqK3HDdxa8WKlUobNZQ==
X-Received: by 2002:a17:902:f549:b0:176:c033:db03 with SMTP id h9-20020a170902f54900b00176c033db03mr305456plf.109.1662366083214;
        Mon, 05 Sep 2022 01:21:23 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:5167:aa6c:9829:64dd])
        by smtp.gmail.com with ESMTPSA id z127-20020a626585000000b005380c555ba1sm7288708pfb.13.2022.09.05.01.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:21:22 -0700 (PDT)
Date:   Mon, 5 Sep 2022 17:21:18 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RFC 0/7] zram: Support multiple compression streams
Message-ID: <YxWxfkh3mElrDMuX@google.com>
References: <20220905081552.2740917-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905081552.2740917-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/05 17:15), Sergey Senozhatsky wrote:
> Hello,
> 
> 	RFC series that adds support for multiple (per-CPU)
> compression streams (at point only 2). The main idea is that
> different compression algorithms have different characteristics
> and zram may benefit when it uses a combination of algorithms:
> a default algorithm that is faster but have lower compression
> rate and a secondary algorithm that can use higher compression
> rate at a price of slower compression/decompression.
> 
> 	There are several use-case for this functionality:
> 

Please ignore this series. I had some extra patches in my
"outgoing" directory. I'll resend.
