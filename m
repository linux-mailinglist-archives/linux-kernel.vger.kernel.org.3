Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11105539406
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345737AbiEaPaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239001AbiEaPao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:30:44 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CD69A9A2
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:30:43 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y196so717756pfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wty3/IgPPk35xcokPXnVEpawRtBNlFQDwPvYaWDnAaA=;
        b=o83A29Kl4N+SzaFcC0507jutzLYYUvFnckNNUsaO9951XaKhecizldGfLKDi++aqVA
         uErx2sQaMJw4jNNHS4dTRSKJkBW74e6OXFhO2pH9oB0TgFC/KvJ4fJj2iKcjlHqGe/mZ
         TgP99snv+XxueOAmeYGEuu/M/DSVALniIq9rhkxu/Iy3S/TD8uIB59cBNOVEhc+8M6Tw
         0lwxJwvT8bBS8JGeB+JcU9qfmM3BIDzPveRrrBFbMCFIx8kP4FjablB4f4TKwLH2Nq8g
         IBWYNHKC8vctaM65JDy8QCQ/Tu+UEcYBZYHvhgOSFXuoo+iRAVJ/LKZsIWuz6cB4jWNM
         f+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wty3/IgPPk35xcokPXnVEpawRtBNlFQDwPvYaWDnAaA=;
        b=dDYcEj+iCPqPU+utTZ5Ri5gn/9k/eo4vJ67Ho8Ykwy4/dGyfRg4F0n7SZOlmo6P0ih
         B+uuOJlGHgOxfeCbRb9OhMrzLFbbDjoWZM4piNggkhXm9/HJXuZiW1CZq/Nw2x0ol2HL
         /JAjLhkAszVegYVhp4T3/ADAPplt4NXsD5MStoB3kggdGga0WF9unPRv4CfgJ15aTUfo
         nshyiT6/RqhiUAVdzPUbzHqzBcF/UaqTID0PTKpz98jrpKOE2QS7tFxlJGiBBiiZSaFL
         bRv+qrIuIsG7Dr5e+4JF0DZUl02d6OuD2ALGC7IFkxQyMkldLhIdgO6MCre0dIr2w2CC
         bYkg==
X-Gm-Message-State: AOAM530KSOhTHJbQeZ5YKgsgB8THiDXl/tSt0IUNHTTO19qhcySE3N5I
        gaHwi5BTx8z88QvDbVsQNzibiA==
X-Google-Smtp-Source: ABdhPJy+dsfmTWB7e6sW7rjHtIVp9Oy7bU3hboZZn0ow8fGFjKZt4BCTm8mUOtDxR+eeOH+Y9VcE7w==
X-Received: by 2002:aa7:8149:0:b0:518:f2e:220d with SMTP id d9-20020aa78149000000b005180f2e220dmr61949331pfn.65.1654011043146;
        Tue, 31 May 2022 08:30:43 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:94c7:fca6:824f:4dab])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902bf4300b0015e8d4eb2a6sm11335696pls.240.2022.05.31.08.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 08:30:42 -0700 (PDT)
Date:   Tue, 31 May 2022 23:30:36 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, anshuman.khandual@arm.com,
        david@redhat.com, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memremap: fix missing call to untrack_pfn() in
 pagemap_range()
Message-ID: <YpY0nEL2c2oHMqqi@FVFYT0MHHV2J.googleapis.com>
References: <20220531122643.25249-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531122643.25249-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 08:26:43PM +0800, Miaohe Lin wrote:
> We forget to call untrack_pfn() to pair with track_pfn_remap() when range
> is not allowed to hotplug. Fix it by jump err_kasan.
> 
> Fixes: bca3feaa0764 ("mm/memory_hotplug: prevalidate the address range being added with platform")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Good catch.

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
