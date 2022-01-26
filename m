Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4D949C71A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbiAZKHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239600AbiAZKHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:07:36 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52353C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:07:36 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id i62so23428469ybg.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ED6xZ1aoXJLSNfOfycmDD/UZTD6F5UIAxuxHbpSpO6Q=;
        b=29I8vvPUfluAh9iwV5m8myx1+C7m9ajFGFE19XAriSAkpfiJG8aOONviW2Tq9FoVsg
         rdPVJrXJvs4VW8a2NYmumWTuO50FcQNS8cW5Pm+drWEbG1vrrBtd7UAh8ln01y/cola9
         F4hNMSc1/MZuc/RP509LmeT0mohQDqePglw7fRILTJiJzSzan6IaxJDH7gwikhjB491n
         T9/2C3ITf75ql0AN8yQnZjJFho4FC0UV5IK5uMxTLTaTFue7R+Fas3JGvDBF3VvRQVY7
         sJWs4+zaKmJi2BRrJcG0diL7jZoecNSQ/5jLLHAtgUAz4KQEMBcjzUVQPv+GB9PyecaC
         q0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ED6xZ1aoXJLSNfOfycmDD/UZTD6F5UIAxuxHbpSpO6Q=;
        b=cmyvmhLjoN11qJTcTaWCrsWP/QCatGbz/ezBlwTk22b5KqRJj9SR7/mTnmoE6j9x9k
         jOwHwLwwqn1bcHgcMHm3gMFwFZWSiwdumTCzazFYrmXdlblxL/sOgoHUgL2Dklu+aJAY
         tivnMzJ6TeTI1OnX1+oufHz1eEB1NtivlMOEhv+PAAhkomWHRCAnMr/5qz0Lo5iGAZ4b
         ykZxnG9tpPG3RQXJalTZnJODZ3/YPuO6GXb+lwsoL6kbyMEV4ceT/VI6t6JCeJl7CLhy
         yTURBpizD8D7oWk9leT5g6kfUUBY0oliOa7k18WfnOEpB26Jy5oCboQ2TFHL4qz6e1O/
         QEnw==
X-Gm-Message-State: AOAM5339b+JQDcxBjZMK/fgcIbNNzmSSy0w5P/hgMPVtPpLFvnwve4S+
        1qaFNH4ZNuEoqJe0M2/n9c6owEEPC/rRZqcGbmzJ8WLlwVotYw==
X-Google-Smtp-Source: ABdhPJyfMVEZZMn31mQKRhAO/W9jLqL75cv+COKEH+X2Yy1NeA/UZ0HSfnCkyye8kkUiZLgfDHl70Tb4BAnAuStHKmg=
X-Received: by 2002:a05:6902:100c:: with SMTP id w12mr20989024ybt.317.1643191655612;
 Wed, 26 Jan 2022 02:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20220126092602.1425-1-linmiaohe@huawei.com>
In-Reply-To: <20220126092602.1425-1-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 26 Jan 2022 18:06:59 +0800
Message-ID: <CAMZfGtUNeQfgV_Fv9OTiUAMWfhY-FFLTWrObcw2x+cYbp+4xsQ@mail.gmail.com>
Subject: Re: [PATCH] mm/memremap: avoid calling kasan_remove_zero_shadow() for
 device private memory
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 5:27 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> For device private memory, we do not create a linear mapping for the memory
> because the device memory is un-accessible. Thus we do not add kasan zero
> shadow for it. So it's unnecessary to do kasan_remove_zero_shadow() for it.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Good catch.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
