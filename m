Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD044F53A4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 06:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360079AbiDFDYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1848894AbiDFCbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 22:31:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D165281800
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:43:51 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bg10so897282ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 16:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X36HQj1LdgkQAMwZzANfVUgblBsGtLHfwYAsRR0i/ew=;
        b=Zi0E2ZlzseKVb6sCev9d2YhYNu/Z2WUojP6Qw8USVJxwD964/CRjvhO4MlUIaJ2HC2
         MoFzNfK+IG0ulRp4tQu6eQo1UhkopbiSIpTgwgCxvJfHAUCedUoRtxnaxURe5t4PsG77
         o46Hoc/HUtql5g4zlGov43CeCg8/CzmCOpx0LNI0dvofNwaX9eoWqK6ozaCsKTszoBGK
         WsklItCRyDRyzuw7+mYRiTGrYAlNimViLfFyH+DM9dipbl4AMVakd7ANk1gCXyop1oNc
         GiJ8rzJDY8hTggnJL/f3JzRdECkLaAiB0z/nHLNaG09hoonEb8yA2E576ImLm8kz5BcR
         5VeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X36HQj1LdgkQAMwZzANfVUgblBsGtLHfwYAsRR0i/ew=;
        b=h/mdcyrc84FMZRJsCf4Q3h8i1ta41y57+GAIb6odMB2jGMzV2kv5OGbKwy//cqWYWQ
         6OJwilRKVvAXAXlKyYvnpP5TccCwavm1E94yTPx7hpw+XL7IMi7uqDKknnYtyGB7JWCy
         JgTzEI8fpTIP+wgJe2VYwZF6I8w2u3+FXrfnq6aZ34+Xcg9esOtfT4giRGncjjTjpmnK
         ED6H1K1QIxYM8ZA4sC7N2Ax1QSSshNKinoLtrSDbf2SpVwCTKpDS9lAEM68ye7s1owSB
         EifFVTrlj1NjKthf0CgAdcnNJXnq3uP+yEDXHXQiLO+FfrE+khgxHaR/pjJ+UirhJupV
         kEFw==
X-Gm-Message-State: AOAM531BwtHFToGnA8SH9PI5+pqj6+inGePJQLMTJ8hfZWZk42R3snz2
        sbJpsD/FOzLIZvgrEvQJmO1E6+ZK/9M96xkHjpDH+J5x
X-Google-Smtp-Source: ABdhPJwO3X8poVm+xxBPbrfVobzJgdAaWT5SfbyLtrpVrwQiXpQbzufko0zCj++kEAoxalsWxS7vuyYFqAsvummFbUs=
X-Received: by 2002:a17:906:6a04:b0:6e4:9b07:8d30 with SMTP id
 qw4-20020a1709066a0400b006e49b078d30mr5750282ejc.658.1649202228640; Tue, 05
 Apr 2022 16:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220405164031.2160888-1-steve@sk2.org>
In-Reply-To: <20220405164031.2160888-1-steve@sk2.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 5 Apr 2022 20:43:36 -0300
Message-ID: <CAOMZO5AZDS31g8NxMzt+XRDXCiZqK0+kfVTNdherPQOHhWhGCw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: use simple i2c probe function
To:     Stephen Kitt <steve@sk2.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Apr 5, 2022 at 1:40 PM Stephen Kitt <steve@sk2.org> wrote:
>
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>
> This avoids scanning the identifier tables during probes.
>
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
