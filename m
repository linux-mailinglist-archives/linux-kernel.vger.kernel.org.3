Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ADA510C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355963AbiDZXB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244571AbiDZXBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:01:55 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFCB67D36
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:58:46 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2f16645872fso649167b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L4eqHWSN42ueWZ89KsFRMnxsq+gg1YBjDPu+hpKQi3A=;
        b=mvx4yW7S0NUOQCD9L2yGJOy9tKusa3h5GHrRZ0OExjnpg1PH+Wlsh4dxjojG7q43zT
         EABQ+Av3CJ/9HnJFry9Y3iZl0h7GGIc6GqlELDC3mXdLpEapGlb3RlCsc7zBDBVEAtO7
         6yFi6IGWA5rzL09NkX+GiT19A2OeHKq4p0TAKcPNd5WxPOA8p9dG2rVUcj9tJrpoNhjr
         3D9hSXSK2CPFTQWQkvQlgFDQx6bl/GD/YlZXLt4mL5D16cceSy0wYeINzZQrIgfaxWJh
         GVz/dAjTVacyio2J6cy02tPjnzJFGU2oSoxm5kOA8cLP7Vi8kTa29zd77IyhPiROpFgd
         yy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4eqHWSN42ueWZ89KsFRMnxsq+gg1YBjDPu+hpKQi3A=;
        b=5CUsHFHnNmSRrAfy7jwaD3A6H8YQMFCec0Wdvrz9NsVYILMbIVR6QgUd0WDzIDhkCy
         BhyH/F5W3xI9xz+69jZSS7s8V8oXdgjEzTF1up+ohwH3FzJwHVOlzYxjkrQBpAGnyDrV
         8nHuB4rTlSWPoYdHCx7cHofEI5hejzzNtXbAl3g4+QDbh4HspW1iHKnn1xxfVgJZ0Ilp
         5XKqI4ZTTHHIDqbzB3YGNuV8qrzJS44tlAvvGvEVUn65k9lLiQNXIUtCeg3EYZKbLAzj
         yqrNEJetEExTi73fLz7uRCXtY3MSPWcQVaaR9vLaO9Y9Ln9sOFATqiv101qS9rrpC/ds
         OyGQ==
X-Gm-Message-State: AOAM5321L6fGGYBgrA15rLJCZYCpHTaMtF9rORdSd/WrKaoQEUf/1k59
        qDdgb8yqlqIC0dVHDAVClHDyjm7SRz/QoCEGCK+4
X-Google-Smtp-Source: ABdhPJxcB8JiZrX3abrVoRVZptJtZb+xka4JrPXoQU9HvLnqTul9wm0iSxbDZDgm23+xs5WBvnb7TrWAwgDIYXas1f0=
X-Received: by 2002:a81:1a4a:0:b0:2f7:da21:ec5c with SMTP id
 a71-20020a811a4a000000b002f7da21ec5cmr13587990ywa.312.1651013925644; Tue, 26
 Apr 2022 15:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <8E281DF1-248F-4861-A3C0-2573A5EFEE61@fb.com> <20220426065917.3123488-1-bartoschek@google.com>
 <20220426140919.GD4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220426140919.GD4285@paulmck-ThinkPad-P17-Gen-1>
From:   Christoph Bartoschek <bartoschek@google.com>
Date:   Wed, 27 Apr 2022 00:58:34 +0200
Message-ID: <CAAQBG5jnvSxcjwr+L5nuxwh87bv=D=tzU325W2Zp3DVpn-VmcQ@mail.gmail.com>
Subject: Re: [PATCH RFC fs/namespace] Make kern_unmount() use synchronize_rcu_expedited()
To:     paulmck@kernel.org
Cc:     Chris Mason <clm@fb.com>, Giuseppe Scrivano <gscrivan@redhat.com>,
        linux-kernel@vger.kernel.org,
        "riel@surriel.com" <riel@surriel.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 3. https://lore.kernel.org/lkml/20220218183114.2867528-1-riel@surriel.com/
>         Refined queue_rcu_work() approach.
>
> #1 should work, but the resulting IPIs are not going to make the real-time
> guys happy.  #2 and #3 have been subject to reasonably heavy testing
> and did fix a very similar issue to the one that you are reporting,
> but last I knew there were doubts about the concurrency consequences.
>
> Could you please give at least #3 a shot and see if it helps you?
>

I have tried #3 and it works well with my testcases as far as I can see it.

Christoph
