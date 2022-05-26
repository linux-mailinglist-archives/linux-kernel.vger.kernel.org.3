Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E25E534972
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343672AbiEZDrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242009AbiEZDqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:46:32 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193755003F
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 20:46:30 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c65so112595pfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 20:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jom1KNUFUVbdHI4yDCgycgylXLvzpYU5cnGJu6js2CM=;
        b=MMRNUHP/S8UsNnp5EuPIxQHhG8BxklSE0xitelM4Vg7GNPTndJ46XLTWbPnLeGrakA
         HjxaBvB9CVdpU++lWFhFVi0hQqi7XBEeBFJb1FmKXIr+h1mB2EKMXZFz1mk0SEq8VjWT
         R1tc4Ky4e6KwB5Vo848Wnai0OpxR/X1nTf0iMNrgLyMU6q7n7mA5X8YtWLfcHAeHDBDE
         U+JOWvfI/IlcjenYh/3rRmJtTzyHB1v2XgEjqyovAEbIPpcMjB4QP8y/dvtqQmSsPQqa
         5rCwn+uwTKxRosFLjRi2V7NRMrmRN5WXvExI48SNZzKaGvLRMnke/CoQ8QghFYZWFWO8
         6Y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jom1KNUFUVbdHI4yDCgycgylXLvzpYU5cnGJu6js2CM=;
        b=tOpPonIEK6BzFNGUo5WUvsMIYYJ5R2w2tG4EtXczGPd/enaEfVIJII+qseN5HAkhqU
         e1wZxEq5Xf/DcZv3j6cSyzjCxmKfMwzwc76CpUkY5iFxCbPQJYQxPWmki7eEFQrH0zRT
         eZfjmT1UuOYhAdNIwvnQm6xqzEJf6xlnJbd/3wTAs+81swckxQ2Irg/jUQFnybO6YYoG
         N6wlH0JdQy6TCrPiJsCDSdcyo0UBLvPIPVI5erbRi/VO1XGm1y4JFIK7f6aIN7NNC/60
         WGw9hhCvcT7l5RAdbLFSkw80oi/AgUa6+XYF7j4kqEJkUfcfnXLjweE7VO6gRvsdR7Kh
         MQCQ==
X-Gm-Message-State: AOAM532XOs8Qbmg9kkjB+zP69v+oZmYg6Xf8ZD7xKTLCnHWF1OQ8KYCK
        9gDwXsCBJeQdjmyncAvreIk9YA==
X-Google-Smtp-Source: ABdhPJxHOE/pVLHhv1OtO2tl/SSozB2v4lqIXw8a0u47UCTL/a5IU2HljI/TZse4Ei170dqVSM8sdw==
X-Received: by 2002:a63:83c6:0:b0:3fa:4034:57e3 with SMTP id h189-20020a6383c6000000b003fa403457e3mr16440355pge.177.1653536789612;
        Wed, 25 May 2022 20:46:29 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40c:3e14:bb57:48be])
        by smtp.gmail.com with ESMTPSA id je3-20020a170903264300b0015e8d4eb249sm200094plb.147.2022.05.25.20.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 20:46:29 -0700 (PDT)
Date:   Thu, 26 May 2022 11:46:23 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v4 6/6] mm: shrinkers: add scan interface for shrinker
 debugfs
Message-ID: <Yo74Dx77MltYkMsQ@FVFYT0MHHV2J.googleapis.com>
References: <20220525202600.2910982-1-roman.gushchin@linux.dev>
 <20220525202600.2910982-7-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525202600.2910982-7-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 01:26:00PM -0700, Roman Gushchin wrote:
> Add a scan interface which allows to trigger scanning of a particular
> shrinker and specify memcg and numa node. It's useful for testing,
> debugging and profiling of a specific scan_objects() callback.
> Unlike alternatives (creating a real memory pressure and dropping
> caches via /proc/sys/vm/drop_caches) this interface allows to interact
> with only one shrinker at once. Also, if a shrinker is misreporting
> the number of objects (as some do), it doesn't affect scanning.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
