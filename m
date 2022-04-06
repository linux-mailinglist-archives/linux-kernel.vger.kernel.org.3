Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802F04F5B69
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbiDFJvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445308AbiDFJtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:49:24 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A68407E11
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 21:42:13 -0700 (PDT)
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F3CE13F1C7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1649220132;
        bh=Mt/wIr8VCHfxx+fAT86RPcS+1hpBF4cXlsZS+mb9xdE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=AJm7OcHo+jKsizFx5bgGTXdyZwZsHUTlzArajW5zO8k8CR0FhLLEsck1I1fTe58TM
         XNRhoBTnelVc64r2XZAjHTKZyHSPfE00Kg9JV6so2yA5jKek6rnjDYwiUvh8h6drDz
         W8WkKzPdHhJF0xPcvENmfNZNYsoCAUy7rSm1hpMUREVYvnY6rjU5cJQ0J/Uxd9x3wn
         Rtv+WvPYw5SAyyO7BP8YG6piwqW6s+yPKi4otdR/CPfTbzj1jQ23LTKmh9iLjCJh0z
         DouvyTkS/6Apc80DgXXVzebSnFR55Q7PM8RIC4iTMd8DLDTAy4e6KD9fCmbN/MEqFy
         jtnkBudDBNkCA==
Received: by mail-ot1-f72.google.com with SMTP id w7-20020a9d6747000000b005b25c9036fdso775436otm.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 21:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mt/wIr8VCHfxx+fAT86RPcS+1hpBF4cXlsZS+mb9xdE=;
        b=xm2ZHHmuCs3EMigHkHlap9dHl/9zCsBIqIRz+jlAfJpqJC2ZF3iYi6MJR0f4CC6bUG
         PxYBZon/8IBAWvBHmrgZZ9mSjwvcpjv7bPQVi0rX+TFvhED6ao/5RgeRgBifBogPp4JA
         tVVBS5nvXQzTdB1wKjOAHr+08F8vVPO9aSw5HiLSGH7c5VsJX7+T9VKnwxJ9K3rtwmIu
         ivlPPF+vUyvmBiXKHMhDF9Pi6ALOljrE6IeWlP8a7hsFy46RYloaTDJv5Gg1CnMlKpnU
         rD/aAov8M5wpcoZ511bCT4jo1txyeKAhy/NHPoJyfnNlKpAA3KpLp+HDqdhwuzcARCtp
         vdBw==
X-Gm-Message-State: AOAM531p6hByh+KAqc0fPd3+q5pKd/y9DFdGgtsI6RXDnyZs4BW4duyO
        09m29uzlhL5jCuz+1y7v+C+qjSfKXGokdIsPCd3aWXv5N02/8TjWNG/f8Y+XpdqJiWqNxPq6H2Y
        qfx67OLirCeCdxh27xwE3ESw0PIr99JCOUrdZNQFbJnk4aZJFW1GctDQXdQ==
X-Received: by 2002:a05:6830:2456:b0:5ce:7f4:c702 with SMTP id x22-20020a056830245600b005ce07f4c702mr2472250otr.269.1649220130605;
        Tue, 05 Apr 2022 21:42:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHon0m0wisgENa7vRcxIQKSklrsxRLeAHmcisDb0KZ+faoRnPeYjrTDc6wEXCRXA5PMWMjLRWCaPLy2KtTmTE=
X-Received: by 2002:a05:6830:2456:b0:5ce:7f4:c702 with SMTP id
 x22-20020a056830245600b005ce07f4c702mr2472245otr.269.1649220130353; Tue, 05
 Apr 2022 21:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220325035735.4745-1-chris.chiu@canonical.com>
In-Reply-To: <20220325035735.4745-1-chris.chiu@canonical.com>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Wed, 6 Apr 2022 12:41:58 +0800
Message-ID: <CABTNMG2z33a6FgsBPbj=cFN9umVdhF8nXwsnVkkF--PYbeGS7Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] rtl8xxxu: Fill up more TX information
To:     kvalo@kernel.org, Jes.Sorensen@gmail.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     code@reto-schneider.ch, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 11:57 AM Chris Chiu <chris.chiu@canonical.com> wrote:
>
> The antenna information is missing in rtl8xxxu and txrate is NULL
> in 8188cu and 8192cu. Fill up the missing information for iw
> commands.
>
> Chris Chiu (2):
>   rtl8xxxu: feed antenna information for cfg80211
>   rtl8xxxu: fill up txrate info for gen1 chips
>
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 104 +++++++++++++-----
>  1 file changed, 75 insertions(+), 29 deletions(-)
>
> --
> 2.25.1
>

Gentle ping. Any comment or suggestion is appreciated. Thanks
