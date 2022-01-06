Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEAE486B3C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243882AbiAFUeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243881AbiAFUeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:34:21 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC72AC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 12:34:21 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id z30so92319pge.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 12:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Ln44DHb8404iMOxunr6mPX5EmgsiBEwipUEXxbuVNjI=;
        b=DQrvlfvktSk4zjpicBjma9GVINQJNuLF504O+C1wLw0IQRkMxxwyk6W76HniW1nIH8
         xegCovbKM+QxUcnfMd9+gR+k/dsyOmNls8cueebFTnxo+GfGGSkhGIL0e5hrkboYNPXf
         wU3U/VhL3cJYxQKvtwaHqP+toY2nEHRfdCI/PF1u6ickuy6uPCPmeh5HEfOyBvq49qvU
         PbmevCtM2Pg6DLhSVsSJCdgbwYCYX9PceekJEsDWOkxEb9GoK/9mYgW4tj3EXWik3pQb
         XAL/hXMIC3Jf0IEvopQJltZ5mSI+pDeFz3Khnqz9WiilBFZssm3jQvgmXo17F/Ph0pJF
         3u9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Ln44DHb8404iMOxunr6mPX5EmgsiBEwipUEXxbuVNjI=;
        b=XIJD2ZB6CubOYzay6ms3Cx/EuI/E4tgUD2uXZeYJv1mEZynE4XstKuk+AC09FUhLWN
         RVnE3V6/d10WIFAD1XW41Hy6wWZE3nJGABRZrdGtoHYMJttCbgzgltVWfBNTuUxwoJxa
         id0A8hJE4TF7YocJldoSlTtfwoqqvCyIANhbH/7Om3t6IKwTrbrsuJYLM0jR/wBt1Kon
         f5ghm4P1K9Qhrb3ERQEEEslsu+/PcAcpuLJEZDu1oKPZqpetgRnf/qF/wCcUzjtBTQ0v
         XuI2EwZMXvt4Pw3xujj5O/bsqsKZpfgnX6aKI6ymQqIZoNHnRjrbjP/GBh47t0vk/bel
         Ytig==
X-Gm-Message-State: AOAM531RJVktV7yl25d7UY9825LIKQJy8mRUJd0o/F5h9gTz3gJOX42z
        Y8OO5yR+qSUrpVzG7iZFRvwZTd+xLwXERQ==
X-Google-Smtp-Source: ABdhPJyGTR+KVRoGhIAPgPcaQMJKQNKtBUHSqZ6DnPnVDBl1oXoNx7YTmFVUCdNvp55qp6uxKlNOcw==
X-Received: by 2002:a05:6a00:1305:b0:4a2:75cd:883b with SMTP id j5-20020a056a00130500b004a275cd883bmr61255458pfu.44.1641501261123;
        Thu, 06 Jan 2022 12:34:21 -0800 (PST)
Received: from [2620:15c:29:204:6f61:b5ab:91b3:14d7] ([2620:15c:29:204:6f61:b5ab:91b3:14d7])
        by smtp.gmail.com with ESMTPSA id m14sm3458417pfk.3.2022.01.06.12.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 12:34:20 -0800 (PST)
Date:   Thu, 6 Jan 2022 12:34:19 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Jann Horn <jannh@google.com>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3] mm, oom: OOM sysrq should always kill a process
In-Reply-To: <20220106102605.635656-1-jannh@google.com>
Message-ID: <ae727710-7298-ca63-fcb0-9f8b84d94bee@google.com>
References: <20220106102605.635656-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2022, Jann Horn wrote:

> The OOM kill sysrq (alt+sysrq+F) should allow the user to kill the
> process with the highest OOM badness with a single execution.
> 
> However, at the moment, the OOM kill can bail out if an OOM notifier
> (e.g. the i915 one) says that it reclaimed a tiny amount of memory
> from somewhere. That's probably not what the user wants, so skip the
> bailout if the OOM was triggered via sysrq.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: David Rientjes <rientjes@google.com>
