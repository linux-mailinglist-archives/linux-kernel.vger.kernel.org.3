Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFC35323FF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbiEXHZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiEXHZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:25:26 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C5E97282
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:25:23 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id o80so29434792ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xZCIrkeqp0UwfkI67/iqYr1O2x3qcCrd77cFyqemvpY=;
        b=wPGM+6wvYQzYXBkWVp8pdxQXBtD/ig4S7bFkR4MsUl8/n209nSMc2p6HwXgKOnXj+D
         ThJnMq7NlzkZjYSoPm6Ifd0zBwYm8MEKfW8EggZbOhp/7M2n537sCmgt+NBdXyiSh7ac
         nVg+WInShACQygT+fCQYlmxe/blylLO/9gZkSURSBULrET0L0I264rZ6jQPVnWjZ7qcO
         eRXcqloMgDKLgCMsSFWqaHyHnh9iQp4hf0fPLWEysE6pkKLR/Wc2h5Tsphxth3s7H32/
         8d7upo29RQfEk3Li2JWGMDUFPK/nuTrqZ4VKQBEVOoxqIxlekxO6gkYTUy4+7n0tGoQi
         H9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xZCIrkeqp0UwfkI67/iqYr1O2x3qcCrd77cFyqemvpY=;
        b=4nD9zNdM7kgb2PjNuLkoYc6/N8OHxr/FhtQhsnaNCHAbjCraA7FcgWCQGmMjXCLSOq
         5OCUqZ3vDKsDkLNxctv3R45IQROHt8f5AuAC932utG+JYjTUUyju+lCtm1bHEl3HAOSd
         tD/w5avygR1XtBmleqatxElqCj58nGEtf78dVbbUXoZDJc1ACvrybQC2lRCJEYRZ9lLn
         NaGapBX4LjSoAWJpkv+594JB60Af+M4GYvTa9Lq58Y518zpAgPNIck5J/QzpL03DfIs3
         MVCND9boCO9cldXLei14yVsPmpABkT9jAbxvJOBc8dD+mrnyemvWgbKZcN3g7AwNxj+w
         8NKQ==
X-Gm-Message-State: AOAM531T5ivciHM04L+fBuMFjZEu1CFBd+P/yLkyHdYu/8rLLCWFv/Xk
        mvb2YVeIxXt2T25n2UQfDDYdGoLW9zlxVSC+GS6A4A==
X-Google-Smtp-Source: ABdhPJwFN5Fdjz70SrDy11N5VCDZyj5xhzGfdjsLgg+5DDgCd8lOElEQAznjGeYKxpSKIfJZw74EpUQ29Ud03jgE/Gc=
X-Received: by 2002:a5b:691:0:b0:64d:ab44:f12e with SMTP id
 j17-20020a5b0691000000b0064dab44f12emr24771949ybq.533.1653377123012; Tue, 24
 May 2022 00:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220523140205.48625-1-linmq006@gmail.com>
In-Reply-To: <20220523140205.48625-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 May 2022 09:25:11 +0200
Message-ID: <CACRpkda=YCUCVzHLn9YHANsNk48PHEBUmP2gvPhh-S+4rCikbw@mail.gmail.com>
Subject: Re: [PATCH] mtd: maps: Fix refcount leak in of_flash_probe_versatile
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Mon, May 23, 2022 at 4:02 PM Miaoqian Lin <linmq006@gmail.com> wrote:

> of_find_matching_node_and_match() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: b0afd44bc192 ("mtd: physmap_of: add a hook for Versatile write protection")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
