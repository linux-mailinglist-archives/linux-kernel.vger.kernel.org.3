Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C344E8034
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 10:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbiCZJyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 05:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiCZJyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 05:54:41 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE937270850
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 02:53:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r13so19625057ejd.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 02:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8L+jZ6rI/hIaqFsPeBM/h2Qk4gIWDXElqI2aBslvgOU=;
        b=SCqvsxxSW3gGPttWOvSTtYuI9OT7OCiGiE7N8ZtZm5NAzkYY4s+72pHHncAcXj1yRR
         sSAW7OmmITT1Ds8wtTbJyVr4QB6tC/GrYCqApRU8WPJJvjdN+tBHBnwabhFpAROZVgX6
         ZCJqP5FNiQ7SMvKgLTd+Jz4ryTjEldt7GxKR3h23qSEMaVBXnVIwImn/VJIS56qfAafZ
         VFs+gCyftJkdks1jiYZWA95jYD47DL8HWDGKfBx3h8cj7MjvrEVhOEF8116nCl6LJ56/
         U4pPbCE22HJEzWsu8gJE82tCSSOntoeDJcjYtPbmQcJz2wBInTX90SbJ5S4K7lOo7K1I
         NjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8L+jZ6rI/hIaqFsPeBM/h2Qk4gIWDXElqI2aBslvgOU=;
        b=OHQynX5E9hm3k00FIXuRv3LiZkHY3X1kKm+5ziEg1sMP0auUMyjPTITu81ZrTcBMSV
         P3ZtEq/JR8XsPC0aIPHMAYjckttjdloiVNiA9VMyXayGPYpr052CD5qxGj1DRMFCrBd7
         QA1mYegmxhTkvAnY0yN8Ccu0Q1DnMYw1zIF00mWSB1RQ1o3iA4cSET6yZgb0bznwS8JR
         qi59pA0p40xWNblQqrsjZYTa+HzjGL/6y60mnAe04M3O/n8pYPatcA5CAgRHOG4nieMk
         jjPoXoYee8ioDRHRYgWEaUcJTEzm9FdqsX1KrOnOZf0bof4URdQrDsmGsrPxXYh0LgTa
         CQEw==
X-Gm-Message-State: AOAM531u2DnQVGyN5fGZui7PSLHaxB2w9gdczOJvfkfhFSwFfKBch0Qh
        tZTsJI1G5txTBFeSQLFcXAk=
X-Google-Smtp-Source: ABdhPJyel+2W1F9MiFIusEjOPauBJVIXeiF7/mY+EVCEVRWKgT32rmtJ9FuDIYdDVyJH0jLs+qYH/g==
X-Received: by 2002:a17:906:a20c:b0:6ce:a87e:5013 with SMTP id r12-20020a170906a20c00b006cea87e5013mr15833751ejy.379.1648288383284;
        Sat, 26 Mar 2022 02:53:03 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id v5-20020a50c405000000b004161123bf7asm3847227edf.67.2022.03.26.02.53.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Mar 2022 02:53:02 -0700 (PDT)
Date:   Sat, 26 Mar 2022 09:53:02 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mremap: use helper mlock_future_check
Message-ID: <20220326095302.n2jcsgjfjt7mwkkz@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220322112004.27380-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322112004.27380-1-linmiaohe@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 07:20:04PM +0800, Miaohe Lin wrote:
>Use helper mlock_future_check to check whether it's safe to resize the
>locked_vm to simplify the code. Minor readability improvement.
>
>Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me
