Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD734B79B2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244322AbiBOVO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:14:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbiBOVO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:14:28 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99487E09E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:14:17 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id r8so3174458ioc.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=XXedcp2yhbUzo3O92znwEibtv2eEO56xS91b3yWI2ys=;
        b=0ZBGtyXpprvtwB02Ug9plwdlXTZcNgMbVrrfq+GoCMWZsFy4kMhFPR7Ik6GYKsdWWm
         8apaMiJqABQECCkZYmE9EiOcpwvPr/is8h0+UHwGOiQP+w2GavCXrykeRgJ3xVqO+tha
         /A+W/eXYZmW49+PRRnIzK0IUMHotFOGZHJv1EOQT749nDlTZyVsROay0wxzG5KdxVcni
         lCifbH5uZtwvXmI9r1oCfmotaVmTwcLQniKLwKT2Lz11TZ/G9p4iUjmeAewQJoAwU7b4
         wz60283Of2U+JnK2Hh6lvdOPr36mjlvJe6PwKH3+NbchhhoCL3VoaCJBt3PA7t/EjDlB
         bYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=XXedcp2yhbUzo3O92znwEibtv2eEO56xS91b3yWI2ys=;
        b=Ve/h1Md+5XhBUFZu6T2HHoTHHcUXc/mZHPsdKzYZxbKiJZ3kS2VPA3wMbApQSwygqH
         4H5nbTAayObungRfTU4ka67oH5NfXlnf/KUBNyaL+g/p8X2a0bPtZWZhnXH3Q9AA3/Yf
         KkBTs97FLs0Cjp0C5wJKFkHmW32Knkk5Uh7wKiCRl3FDlICxRbUUEDADi3y/GPzMprVS
         P7qPL5MtfE0zQMROPzjLZzOVjAT4JrHxYOVOeS+DAXKpCQf8zT5UIFP4dXTvj5KljUTp
         5x8Gw+Kzs66xtu/w4RCtNvwiMGLKJznsLOUm6dBcrHYpsIfOkADNwsP5JYrstpRWYrbe
         eatQ==
X-Gm-Message-State: AOAM530FxD5X/ZoEMAendq0f+xaCudCiLRUxbHNUpOSfWcG4j+fQpuoP
        QrKLZoOyz6ameYv6PRNEcjmv5Q==
X-Google-Smtp-Source: ABdhPJzoYPw1Q4I4tDZdScQxnpjehFexgVWCQnCHRKpXjX7xIIZqHvMbhqxNZ4eJvcYXakCkhL59uA==
X-Received: by 2002:a05:6602:168c:: with SMTP id s12mr486266iow.100.1644959657041;
        Tue, 15 Feb 2022 13:14:17 -0800 (PST)
Received: from m1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b6sm23928798ioz.43.2022.02.15.13.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 13:14:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
        boris@bur.io
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220213085902.88884-1-zhouchengming@bytedance.com>
References: <20220213085902.88884-1-zhouchengming@bytedance.com>
Subject: Re: [PATCH] blk-cgroup: set blkg iostat after percpu stat aggregation
Message-Id: <164495965641.2684.16928611518978800084.b4-ty@kernel.dk>
Date:   Tue, 15 Feb 2022 14:14:16 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Feb 2022 16:59:02 +0800, Chengming Zhou wrote:
> Don't need to do blkg_iostat_set for top blkg iostat on each CPU,
> so move it after percpu stat aggregation.
> 
> 

Applied, thanks!

[1/1] blk-cgroup: set blkg iostat after percpu stat aggregation
      commit: f122d103b564e5fb7c82de902c6f8f6cbdf50ec9

Best regards,
-- 
Jens Axboe


