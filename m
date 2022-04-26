Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FB9510547
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349026AbiDZRYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346855AbiDZRYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:24:20 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75D33BA74
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:21:11 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x33so33152052lfu.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vY6n+jio0gwvbbRftwZVfFCV+8S6O4vtPz4jG39i3+s=;
        b=TWgNkRLLNcjl/XaddvkQE1EterU2lrL5fehRf6oIDjTGVr97VNKpW0uo3KsGV3D18N
         HnGn/22GaBBZj3uDR7VLh6dk9maG7nV1HxvquyIXqhfXVAORSOyRhrOBwOGWlmWqx7CZ
         YAFBhI4mT+hhYOcbEIg8podME13jpUF1xd9+2iORyI3MPGLFURtymQEiszOrhzRqq78/
         8w5RIseWywi/QHWQT+CI9z9PF6SWES4MpGMWFqI0Qy4ROgyjRyxKWQwEwZiJeWJ2qaUt
         3RLVAStRE/oiOk0nisyZFuUCyXiZiiT46Oy94aqcE60akyN6oADQpk5NlS03rRBYzayI
         kowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vY6n+jio0gwvbbRftwZVfFCV+8S6O4vtPz4jG39i3+s=;
        b=18VpPX1nA3R0f7zBCuGfQwxKZtZl+THSQxCADXMk7IJQi3mEkXC4fwMpuLqxYjU8/6
         dSqJJbuVssYHuhow3Xt33lkzGJuY/sgI1ApC/ITI76Odo/jQM1BV/81YgpwcIQ2Adhj2
         OhzreQcXjrotkD71PJDY/HYU+5Wuxv20Z7eDFQdtp6eWlaM2MEYqPf8PP+/BGvwkdGg/
         xnNEOcpL9Ci0Y9rsgUJGYtXodSgr5P1yFbGfxXZGpawtWK/fmgpUueQd3xNo6goLnzKA
         xIROlvlLiMWsn7SaxPap1HXg7/Lii57LABRC2udXX+0lJubee/2k4XT9Ban05JsA+1bl
         lSQQ==
X-Gm-Message-State: AOAM532HE/duUSDXImNpBdBb55ucGUB3gPCSUGWMuHJV7pxMHVKdMD4N
        yGBtW1n/dLjuFL3DD+u8v1B2l2k6TELGS0oAWuJ5YQ==
X-Google-Smtp-Source: ABdhPJyhWp+J5ybWMVXvAk8ooMs7uPcSI9Sm8SIIWGzIh31BZvVfqbRuznmM+sw9qijUdRJPxFo3eCsyVhjuM8uWQu0=
X-Received: by 2002:ac2:5223:0:b0:448:5100:e427 with SMTP id
 i3-20020ac25223000000b004485100e427mr17402224lfl.87.1650993669901; Tue, 26
 Apr 2022 10:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org> <20220424190811.1678416-14-masahiroy@kernel.org>
In-Reply-To: <20220424190811.1678416-14-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 26 Apr 2022 10:20:58 -0700
Message-ID: <CAKwvOd=SsRq8YJ7V6XQmFLhOYvvFk0B+Rfftpc_=uEEUfSq6ug@mail.gmail.com>
Subject: Re: [PATCH 13/27] modpost: traverse the namespace_list in order
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 12:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Use the doubly linked list to traverse the list in the added order.
> This makes the code more consistent.

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
