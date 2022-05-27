Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7449E53576F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 04:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiE0CCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 22:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiE0CCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:02:39 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C66E276B
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:02:36 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id p190so5712288ybg.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLVM5M04ogJOWvvIUakGdD/7uvbrF0wvEXO55MVQn6o=;
        b=MOzvEHzkfUJMgqFL+j5IV2q1nuRb2MtbMjiD+zYsp6mGt3oPmYgt1ld5HhMfnzHJFN
         QLeRDnopafhZuYoyUF4/3g3L3+4PF1hy4f5zaW6pgR11Jp55KfmEpxFHS7IF0fpAxLz/
         dOJtgRjUfUVbaIjMMcLgDuAO4151lQvQGYUoMjoISepzCqowRFXra3YCvTOGGLRbVRVa
         YypGj9qC05pYDyfH4UMLBTo6QzkLqjT1SSCpamnRMm417otM2duLc3CDJP2PV1coIsF/
         9nmHZcoTy4eJPdFNP9A91rnwrLoRDE73wEbL2F733jVp5lq4TkDrU2LzuDi8zOhxorGi
         /5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLVM5M04ogJOWvvIUakGdD/7uvbrF0wvEXO55MVQn6o=;
        b=sL4hye22xfrmnXDaOatApuj/zU0cahb627YPjKvABQYRDCf5bQENWngJo3tLljLt0I
         L/NA3X/0izLhNCeeSyf4o1Gw17zz6nPMO1DvQbqD6OLrWkcjM5rq9Euzb+ZjtP/K2s81
         lNyyu01kRwvx3r9UR5rdaDy3KqAAlHi0m5NYgGhSvI9G9D/kZWmuQDMdEKi/kxp23CIn
         Kqkh4VRWbnm7pGJQtDCNxMhnHsBmEVLDMclWAVeFSQIdvD6Bbm9yp00Ptg/TyweaBz4l
         f0+Jx0queLjJEjIg8st/1Z1a0Of5kCgFY7snAySPS4ifqBBY63qKXneo7RqhyaTrwGbk
         6G9g==
X-Gm-Message-State: AOAM532Yl+OSoM8OLSQ6q5p/qpVY1CTmDPmCLqFBUYc8d80NolHG1kW5
        4ocOSrUaKEKlYRCrWaGYIWY68/8U4+qQ9dyqxqI+Zg==
X-Google-Smtp-Source: ABdhPJzZJ4SKEJIIyQ1V+GQ0AHiSOcWquayOx6L9O9Y+qeoR6A2uIky13CXX7Mb+1uUiZShUvs7Z1gtchU5vCAX6Gmk=
X-Received: by 2002:a05:6902:282:b0:64d:e139:c9b8 with SMTP id
 v2-20020a056902028200b0064de139c9b8mr39788503ybh.6.1653616956223; Thu, 26 May
 2022 19:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220526143539.1594769-1-bh1scw@gmail.com>
In-Reply-To: <20220526143539.1594769-1-bh1scw@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 27 May 2022 10:01:58 +0800
Message-ID: <CAMZfGtXj2jOQBAExT5B9BfmkO0Xo1KP-TQ3fzrhz_abUcegRYw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use PAGE_ALIGNED instead of IS_ALIGNED
To:     bh1scw@gmail.com
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 10:36 PM <bh1scw@gmail.com> wrote:
>
> From: Fanjun Kong <bh1scw@gmail.com>
>
> The <linux/mm.h> already provides the PAGE_ALIGNED macro. Let's
> use this macro instead of IS_ALIGNED and passing PAGE_SIZE directly.
>
> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
