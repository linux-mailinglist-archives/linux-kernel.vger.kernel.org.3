Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF1D55CF87
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiF0S4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 14:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237394AbiF0S4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 14:56:48 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C85710F5;
        Mon, 27 Jun 2022 11:56:47 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id bx13so3480737ljb.1;
        Mon, 27 Jun 2022 11:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ARUxKn4XTsqNqlAy2aX0A6ZVuWpKmpdTtIO20dOVpQM=;
        b=BliNVePpBli3h/YthLA15cMLrqof6B39zVoBefaaFJebdtUIDW/pbqEqZ/Jl1jvXJQ
         PeG5VgliQl8hSpL7rw20WI1RC84SY3eg0SDkUyRO/deyCaqvhLvHoXrh9hUWFFvVVdi2
         Mw2GT/81aO0BATv51wYFD+guejja2aQDam/hAOEfJUY01qPncPumwHUL8tkXr8GGgBqE
         87rL9x+hzmaAhx1pels6HA39ATpAEXJWymBvgo5fShTgotZGwR/D0tJMeN4abDyw7OfE
         meTKMV45t8Nari7MOGJOEJDVZoozzR4U+H1KtDqY9URslVZ5q9z+B8WpBaDHMFpK+emv
         r58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ARUxKn4XTsqNqlAy2aX0A6ZVuWpKmpdTtIO20dOVpQM=;
        b=ZnfJ+dsFbpIV2tKy2EALTZD0j7Vn7x+lbPoMomW339OPno1t1D7TZHbpAL2plzeyKH
         iFAcOonAn+YUAC6E5LKD44zjajbwhua9nQzMUMhk7pNyJ6nWFsJLxgGXNLzzUjgux8nd
         f7KALVWUQ23JG+VJYSTJou3PcVXXFsOSurDu76JHcZozI6BzT+ArRs18We3/w6pxx7wz
         KRVgTjdV13CoYT7ZkZ/xltkP1AOEYMTIZB7TysNdXf+GdxbcD4IpD0pz4I1LQZM2QB6c
         R+SoMB+iDB/hCQW0+TWm7hc636QytLsyAiBkjLjC3xdlK9Hm+HRKG3U+gQ4MHXNPIWK+
         Bmcg==
X-Gm-Message-State: AJIora9T616ETNN9azkojESbBn9WfQyTJNuvIZxss+2a9B5rRfMn23A7
        VfpNhIpUz31/DTKEoHuD8IA=
X-Google-Smtp-Source: AGRyM1vgAHYXy4qeoGrnp+BmbXNrssC4nZ3MYqp17PuiACyIX7i1fjd/BVaDSfsA0rlRARTnK0YdeQ==
X-Received: by 2002:a2e:8681:0:b0:251:fd91:41a with SMTP id l1-20020a2e8681000000b00251fd91041amr7426850lji.216.1656356205685;
        Mon, 27 Jun 2022 11:56:45 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id b28-20020a05651c033c00b0025a9de54750sm1487179ljp.54.2022.06.27.11.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:56:44 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 27 Jun 2022 20:56:43 +0200
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org, vineeth@bitbyteword.org
Subject: Re: [PATCH v2 8/8] rcu/kfree: Fix kfree_rcu_shrink_count() return
 value
Message-ID: <Yrn9a5pOvhvL/eZj@pc638.lan>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-10-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622225102.2112026-10-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> As per the comments in include/linux/shrinker.h, .count_objects callback
> should return the number of freeable items, but if there are no objects
> to free, SHRINK_EMPTY should be returned. The only time 0 is returned
> should be when we are unable to determine the number of objects, or the
> cache should be skipped for another reason.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 711679d10cbb..935788e8d2d7 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3722,7 +3722,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  		atomic_set(&krcp->backoff_page_cache_fill, 1);
>  	}
>  
> -	return count;
> +	return count == 0 ? SHRINK_EMPTY : count;
>  }
>  
>  static unsigned long
> -- 
> 2.37.0.rc0.104.g0611611a94-goog
> 
Looks good to me!

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
