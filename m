Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC29D539588
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346626AbiEaRnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238878AbiEaRnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:43:05 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8DD2A253
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:43:04 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n18so13480227plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3WxQn9E/7whni2mhVaroiI/yQsUs4wjticHDb7nV9zY=;
        b=d2wII8WbOHvtxl7uBrOtAFysBbDl0gxdbNJ8vpXmxGcAyeAZP/rRvrZY3X/HGSwcQL
         12AqzGzDT5oaQI7RYD7Nc61tl76vB3o97KxtPLRFYVo1/BaujqCDnenDiGl6KvrJjPg5
         vuAZ3TWoZicnpwuKVzJih16grbuIwinxf1831xa2/xmhDWNxJu2hQY4KRC3BxUgBu5m7
         j2gpRWcWx6fwDGIMfdExxjFw3hlp6EGHBeYFRo54S53xg8Ap9cRB1HgXIg2ryQGmVejK
         jqEVzg1m/p0CO1qWHQD37Gi4w5BfteMGOrviag7DHRYo7Cy3QLSjxBmc6yEZI2my2b9y
         ssww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3WxQn9E/7whni2mhVaroiI/yQsUs4wjticHDb7nV9zY=;
        b=fl2aIZblv9uS+iZtjdO9aMa/3exYm7TEfJwOxy7O/N5Zx+QgVgGJepeM9xV2BOU99D
         7buizRJeiUTHhUpztPji8HjPO/L+e/zaO2bj23Qygf5CvWoxcGk4FuEqqkVk6ddBWtin
         E5KaYovVVkVTvQBZIVKPHlStQFqlQUsDHKxSFITDPv1kOpJDRUvgkX8eOJsEKnippH+8
         mLRaRcqyvemQMvHDPnDOpqFE3CE/aUQh/0QSr3JY2l3MSWnKh6Avvm0zwnylwGB74RUI
         bsJqlVACfnSealj5nq9p3GLsrOVQWxoi0T4X1lrjcfFgEmBAxYDOZUb5nyAQ4F8nIKXP
         UUBg==
X-Gm-Message-State: AOAM533OcXRg4QeGk2Y2Y+VDsFuqPDCxGaSrzC/NTbdgWBpmpvPDl2xV
        FgS7d5bPwHIyeVzVlPeqJJFJ4C45Xl8=
X-Google-Smtp-Source: ABdhPJxHJHzQo8FmvKN/hvqO6eSV7wXRfR1G/UCFS9Z6lSjzquwSqmAD3BLHKwILzRsa06wO8i2Lfg==
X-Received: by 2002:a17:902:b418:b0:15f:713:c914 with SMTP id x24-20020a170902b41800b0015f0713c914mr62588635plr.171.1654018983785;
        Tue, 31 May 2022 10:43:03 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:987b])
        by smtp.gmail.com with ESMTPSA id e18-20020a056a001a9200b00518285976cdsm11071470pfv.9.2022.05.31.10.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:43:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 31 May 2022 07:43:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Geraldo Nascimento <geraldogabriel@gmail.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: missing NOT while checking if Workqueue is
 offline
Message-ID: <YpZTpXiubZUG14gJ@slm.duckdns.org>
References: <YpKA5Bdk1Cm6KgKU@geday>
 <YpLLnx8/xpZIPMbi@geday>
 <YpL2rHUXd0vf8IML@geday>
 <YpMDmZZ7IpEhjywp@slm.duckdns.org>
 <YpMKY88/2tTK319E@geday>
 <YpMPPyIZVlBwUrNe@slm.duckdns.org>
 <YpWVz51hyMo+w4a4@geday>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpWVz51hyMo+w4a4@geday>
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

Hello,

On Tue, May 31, 2022 at 01:13:03AM -0300, Geraldo Nascimento wrote:
> you were completely right about me being wrong. It's a real shame to me
> and I am only asking for an apology in case there were any doubts.

I don't think there's any need for shame or aplogies. You weren't familiar
with the code base and it just takes some effort to pick up skills for good
bug reporting. I'm sure you'll pick them up in no time.

Thanks.

-- 
tejun
