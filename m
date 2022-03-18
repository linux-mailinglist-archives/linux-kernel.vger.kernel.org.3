Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190AF4DDFB7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 18:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbiCRRUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 13:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239549AbiCRRUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:20:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C3C116B42
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:18:48 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id s42so10085309pfg.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sBGpBMBa0UJuwiFOJKCwxoWgf6JBLgoMLaN2Nnq0+zs=;
        b=KUmCVWlLMYLmDyMRE4CpFWSleyDDDjFssGHPya2r9ftZDh6/a04ZyWVPCm5gO75USX
         QfubHM0efaktVDoAvWbawKeFJNIGOncvGoVkzfZqu4sk64H1WahN5lqJQgR55i0u8+zV
         SZ0yWOJUruLr7NCn02JTkTapBOGz3yBv1GZUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sBGpBMBa0UJuwiFOJKCwxoWgf6JBLgoMLaN2Nnq0+zs=;
        b=iUbbO8jK5AAxazUBeBPP0OKCD/xMaK2Oc4gf/TE3WBNOMo0Iw6C+YJg4Xr/y9BdP6+
         fNFWXgvuFWFwLnirJVV53jx3ySIUDxm3r3BticWsXj4B9vTATnf2uGsuW2Kl4ihlIG2M
         Bl/MzjKuyxjPOkCQX/JwRpmv2BEcEU7SfwhpnqiAe5N3xKlNKGgQHAMbEu+QDlo+844y
         onITbslJzRepJhsios+Irf4fnZlzUw6VhXHMatpuk6iCPzKKLg7ziRE8/URmxuLg/DNX
         bfYU+j4BtLkgqac02iAHhAeraaNEx1/ybDparusxgfGXovwbkP8isIjdGGN+Mg3OB6qm
         CTOQ==
X-Gm-Message-State: AOAM531g8mp4B/8O3QxqgnD31JjzShN2yvRzT30UCWqdwHpzxvnUlrvl
        EIl+xK3xajBR+ZNrCP9ZXmbWXQ==
X-Google-Smtp-Source: ABdhPJyAOU0cFjhA7nOVw4UJHxYPnMV7w0dxFwFxQEWYf82+Z4LL1/iuGptBQzxLR4WnRotx/wyt9A==
X-Received: by 2002:a05:6a00:1a4a:b0:4f7:be32:3184 with SMTP id h10-20020a056a001a4a00b004f7be323184mr11307114pfv.65.1647623927878;
        Fri, 18 Mar 2022 10:18:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d18-20020a056a0010d200b004fa2e13ce80sm8184457pfu.76.2022.03.18.10.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 10:18:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     viro@zeniv.linux.org.uk,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        ebiederm@xmission.com, tony.luck@intel.com, len.brown@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 3/3] elf: Don't write past end of notes for regset gap
Date:   Fri, 18 Mar 2022 10:18:42 -0700
Message-Id: <164762391838.2488263.14084209091132578014.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220317192013.13655-4-rick.p.edgecombe@intel.com>
References: <20220317192013.13655-1-rick.p.edgecombe@intel.com> <20220317192013.13655-4-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2022 12:20:13 -0700, Rick Edgecombe wrote:
> In fill_thread_core_info() the ptrace accessible registers are collected
> to be written out as notes in a core file. The note array is allocated
> from a size calculated by iterating the user regset view, and counting the
> regsets that have a non-zero core_note_type. However, this only allows for
> there to be non-zero core_note_type at the end of the regset view. If
> there are any gaps in the middle, fill_thread_core_info() will overflow the
> note allocation, as it iterates over the size of the view and the
> allocation would be smaller than that.
> 
> [...]

Applied to for-next/execve, thanks!

[3/3] elf: Don't write past end of notes for regset gap
      https://git.kernel.org/kees/c/dd664099002d

-- 
Kees Cook

