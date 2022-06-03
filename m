Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B880A53D37A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 00:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349238AbiFCWIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 18:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245510AbiFCWIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 18:08:47 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010A628E36
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 15:08:44 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-30c2f288f13so95428057b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 15:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zut19pl/BUZXXaNZH5dMwhS5QkgGoG3FohWFDv1uCNs=;
        b=nco8FdQW1bEC2bR7g2JLLUI8UlhXzwHVOCndQpL0eLon5vBviKZ5PqfRDHUkp400DR
         C8d81xwFUPClu1pvpcynp7zc+xmb6njbOokhMMezgQAjfne8ZqV//0Swi4P8B1S1CQoa
         xNWb43r29E/mshrO46297uuKRbFUmSB7/zzU/+HQWtdFAtfa/6VYtaEe+2uFqayTSF0c
         io6FUXNSqh9c1JZdnjHOZXFoTvUHj27kXXYg55SnrowuI2MkNnp9k/wfGr1FT2xbap3I
         8aAec0spL9NdGPW/9H9sLzVUym+Q/ZZnp+QAF1a+gXz9KGhUBjiD0D0pkV/hPgkMi+JL
         V6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zut19pl/BUZXXaNZH5dMwhS5QkgGoG3FohWFDv1uCNs=;
        b=UIf6MCSBrbT7mDE/rkpZfEQ6LB7B5gxCrTafvWIUmmFavN0wj0e8b9OVlVP/fIIv3e
         RqIr02lojEKqe8bL7hNrYN/0ll2EizfNMPbf0Aj41RQqqpY2wTMJN45eARZsRwPcUPA1
         sP/G1l0p/ul5L15VXyOWJra7ee5BlqZcG25rYBeArlqMbKzFuH+t/DN0o97Fvrxq3igH
         +umd7tqv3BCoUuqoKvUNjbiYkTYjsl2Av4eRJfpceoTw8PseEzUjOFJt0e8cugdILpzM
         qZrgRypFjK/bIEQluUFuhZ/wg3p0yvL8Y6thhuneaZNt1HZ8G0+qVcHNODpz5MCR0ZuF
         2gKA==
X-Gm-Message-State: AOAM532LDdqGAZWoTk343UR/07NWNvr34OqSCghmIVq4p5UtwUnhI3Nn
        BpJwyvkneQ3aUxRl3meh5uJRhrA2yCZuIoxfk1iU9A==
X-Google-Smtp-Source: ABdhPJxp9XSrQ3uydko7NoT+bUVXFaQJnqXLo8ESZdE+AWI7zecnouRoldyyYyqzLVoZV38RiK7YVfZidbsdtmuiCAk=
X-Received: by 2002:a81:fe0b:0:b0:30c:7e9c:701 with SMTP id
 j11-20020a81fe0b000000b0030c7e9c0701mr13632194ywn.118.1654294124240; Fri, 03
 Jun 2022 15:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220526081756.32998-1-linmq006@gmail.com>
In-Reply-To: <20220526081756.32998-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 4 Jun 2022 00:08:33 +0200
Message-ID: <CACRpkdbZWSHRB2L0hSsMK6-3g7uXjd4+6zbkjbog8=VDvF57rw@mail.gmail.com>
Subject: Re: [PATCH] ARM: integrator: Fix refcount leak in intcp_init_of
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 10:18 AM Miaoqian Lin <linmq006@gmail.com> wrote:

> of_find_matching_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: df36680f1a71 ("ARM: integrator: core module registers from compatible strings")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Patch applied manually (target file moved in the tree)

Yours,
Linus Walleij
