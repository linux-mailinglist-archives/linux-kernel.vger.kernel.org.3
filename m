Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B0258D1CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 03:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiHIBiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 21:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiHIBiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 21:38:11 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E960E003
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 18:38:10 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id u133so9562791pfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 18:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fD9PUstcGRUBFynoiYi6wXsqyCc6A0j4pDygBUDI0CM=;
        b=fJScjxlYFlYmg00s0gheP2AnAUhjAZCsjv6KW5gXPYxrlwqb0jB2B+MAS3Zi7ry2lw
         0ByFq1h38n7N+r9zjriuEG9XcDSOSndOKEAlND9w+zkLVaTGi+7BnRXloJtjIlNuFJnE
         wcOOsxCVwpJNtgoOP0t/PJIrhv84hlxj0rVJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fD9PUstcGRUBFynoiYi6wXsqyCc6A0j4pDygBUDI0CM=;
        b=0aKEztmP4xiN33Z40Cpwc3gBJBLfWZmvN9LXl/VwpvMTqaUoEv+r085t80V0IOmk5M
         tRM+rIg0lexlJfgeYpW+L/x/VLLsx7tbvYQio2fZvIFbw4a/oTcwHWeHX9DXLukVZj6t
         2oowFsLV6nAMydR5OeWNsEorzRmuDrKTLfsubeL3FQvYq0ovf3H2NVKFcwH49M4soOOA
         4lRY8tYzK/s0l40f44jfX96suCEDbQvG/hDmgO/BZzDVFZpI7+oBsfy4M79HpN1Dx0vS
         RaPIDIScrEuC6wV5dCofYyQxgfVVKDY4Iwa8uuYtIzGCG4Nu+PRFrtEH0oeOV4XclSwv
         11LQ==
X-Gm-Message-State: ACgBeo3dW8MQgaUtM8MMBxzQlyq8Brs3G/tNTJWQb4sftqkX8nEG4yAJ
        f3hsHNvNtixBsbQOQPBjD44/TXr8QP3azg==
X-Google-Smtp-Source: AA6agR5wUBA+PoJFs2fkTCcZmbENnHalWLsK8WBJ7azQloMCGIqsyzAJpkzotkg2K+5Ci/M0SGE+Og==
X-Received: by 2002:a62:7bd6:0:b0:52d:4773:a3de with SMTP id w205-20020a627bd6000000b0052d4773a3demr20792726pfc.70.1660009089913;
        Mon, 08 Aug 2022 18:38:09 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:8d43:c739:457a:5504])
        by smtp.gmail.com with ESMTPSA id c126-20020a621c84000000b005289627ae6asm9302567pfc.187.2022.08.08.18.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 18:38:09 -0700 (PDT)
Date:   Tue, 9 Aug 2022 10:38:04 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>, linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/1] zram: Allow rw_page when page isn't written back.
Message-ID: <YvG6fDHmVITsa/Kk@google.com>
References: <20220808165006.2451180-1-bgeffon@google.com>
 <20220808165006.2451180-2-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808165006.2451180-2-bgeffon@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/08/08 12:50), Brian Geffon wrote:
[..]
>  
>  	pr_info("setup backing device %s\n", file_name);
> @@ -722,7 +707,8 @@ static ssize_t writeback_store(struct device *dev,
>  
>  		if (zram_test_flag(zram, index, ZRAM_WB) ||
>  				zram_test_flag(zram, index, ZRAM_SAME) ||
> -				zram_test_flag(zram, index, ZRAM_UNDER_WB))
> +				zram_test_flag(zram, index, ZRAM_UNDER_WB) ||
> +				zram_test_flag(zram, index, ZRAM_NO_WB))
>  			goto next;

mark_idle() probably should also test ZRAM_NO_WB bit.
