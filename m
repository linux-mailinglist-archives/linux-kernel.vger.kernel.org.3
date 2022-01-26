Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4992449D22C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242153AbiAZS7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiAZS7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:59:21 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2C1C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:59:21 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id e28so524518pfj.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=htAuwYZ3OmGEPnY+LJpYxP5vH8dhFgPG/7ZJxqa35es=;
        b=O2aQxJZIjAKkjNGzGHhqLHYiQDC5XpLrw6f0sTdmJB4nDn1Q0YR5rLicYfEb0qq/Ae
         0AdN7Uwu40HVyvWuAJ4LMhM5/hloFln9pZ9kbXIRR0ieJTnJJIdM2LpOi3SqlCbs/Cac
         4s/ubThgXjHw3ydfZYl+saxLYEmyiL8POKIfvvCV1zveDOPgeVe1TVX1iuccg5JYKzFQ
         wti4+eoxOtjqIP2H+q7e9CuHAPLKF+0qbtlqRgR9DiOKhxgGZfpdTgQr8jf/xruEzoIm
         kuF+km0KISTlOLAcjFeOu4Sl72hbEFTeXhAJLD/FcvegzxfjDe6gyUgKzfb1xjXHRdu4
         o1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=htAuwYZ3OmGEPnY+LJpYxP5vH8dhFgPG/7ZJxqa35es=;
        b=NHvB/OKF/1JBCiDWVl5QHjh9AaTONLov772p0QJrSpvvUYwhI/E5AukcrF+4YKE6U7
         r+15CjCtgeyA0gj+RkYtN5wjZgWrrnfzaIItULhehTQD3MGHRvoplDwRdUcb554HsuNA
         YC++mbD4yo0GFds+zqB8iSQ9ZStI6udjXBZRJizaCiGQiwI+mKBpig5Dkoo0kvQDGfE8
         j6AHO1iXm6XNCaS1ITBkPOv9b1tiMbeGTMcwuruCBoT2zc3lCQQR69CFUoVzYqcEJhhm
         hRBkbtoITX/Byh6RPJt0MZpZiYdH1QDETMQ51mKwjb0fxpuXY7x5uIZfuQZI4z+aCeqN
         tcHQ==
X-Gm-Message-State: AOAM532jGAe15Cwbgy+DxdgUbzR3gjBxZUDWpyIS2B/nWrL3GXkQXNTV
        GE/wghgR+F9NcAiBKOgFm5bIvOw6AGT5jw==
X-Google-Smtp-Source: ABdhPJxAMrmNR7jfqJlI6sl/Pyg0blwMw4uOKY0mmR1MA3vQWxAwn6j5TVX/bMHosc/Z0AaoDXkndA==
X-Received: by 2002:a05:6a00:1755:b0:4c7:f879:5577 with SMTP id j21-20020a056a00175500b004c7f8795577mr18026880pfc.71.1643223560646;
        Wed, 26 Jan 2022 10:59:20 -0800 (PST)
Received: from [2620:15c:29:204:925c:a455:6d75:1ac8] ([2620:15c:29:204:925c:a455:6d75:1ac8])
        by smtp.gmail.com with ESMTPSA id s9sm11829470pgm.76.2022.01.26.10.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:59:20 -0800 (PST)
Date:   Wed, 26 Jan 2022 10:59:19 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/highmem: remove unnecessary done label
In-Reply-To: <20220126092542.64659-1-linmiaohe@huawei.com>
Message-ID: <119c7436-6f-dec5-9b5f-fd4c299bc8be@google.com>
References: <20220126092542.64659-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022, Miaohe Lin wrote:

> Remove unnecessary done label to simplify the code.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: David Rientjes <rientjes@google.com>
