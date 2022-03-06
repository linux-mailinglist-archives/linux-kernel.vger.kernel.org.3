Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428664CEE1A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 23:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbiCFWMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 17:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiCFWMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 17:12:14 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A707826575
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 14:11:21 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id s8so8090354pfk.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 14:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=DKK46qYk0LnbktAKTjtxEx+PEyyBU2ASIVtwk41+l4w=;
        b=LaGPuwll1Cg0kVKb8R43S9JDR2j4rsJRR1lPuSi43Z6JJGwJKckkfirBSi9dpjYqYc
         eZckIwipzfQzKTEdYfDmwlJFoWjhXtRwOSSo968BjUUeytVmRjy6y2N+LOFknv6w081w
         JSMJ7l5nxo7IppML3KGuZ4UrzcuYwjgV2zmb5gvXy41SgDQng8mqPGzl8dy/KhkdH0uC
         UH31rBF/01XpZra/WoFWcIV8kEgCjFhVDaUsxLqwOecvoaG1Y7N7/b85hlu7GNw6TV82
         1T92jWUM0QgBynYm57Z69JI3juPKtinm7ZdLUK/ch6ajuMnBavIO9hyiC21amIin04aZ
         9iLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=DKK46qYk0LnbktAKTjtxEx+PEyyBU2ASIVtwk41+l4w=;
        b=GDBQhzWkpekctzh1uAl8C7FODo0TiXj7uLjdb45RVQ8LaIS1wKaYZLjHVTQOHueDsg
         XOEAcAjwrdthdsn2Hx0hLAN7LBkn1r+izY7VrdAodiOQxXC07lgWPHvguYXI1Nfbus+r
         4lz+DBfZ3CowbsRR8w8cBfF22+92jG9a10BvgqZ0aEThVHeUkrSbUlHcJr3YB6WAaTJX
         ckh3Vyu9ISpL3Yk+JpCE211HueEUdwKsBSDVfpmEs7bCmwjK4gohfRkqKuTmQ0K8qkf9
         1P8JZDe4QTjcJF8Nb6GLCflIkUD8wCM1dUlVMOu2bYuDzBOyIb82CKzZbStlMmXzGW0u
         C1XQ==
X-Gm-Message-State: AOAM531xku/bd6bpm4e+ac/UI+NzDJOxbC71KwkOaQab8057wqn5/1Zh
        1aGjB0WOkWxpvVmS4KboNuFplw==
X-Google-Smtp-Source: ABdhPJwgkt7jMjWUybO7b2Xn0h4v5F4GGby8TpssyPhgVQ3ThrAF43kb8Nm8P1b8xncg4s2hfh4QGQ==
X-Received: by 2002:a62:1d48:0:b0:4f6:b805:4bad with SMTP id d69-20020a621d48000000b004f6b8054badmr10004953pfd.67.1646604680997;
        Sun, 06 Mar 2022 14:11:20 -0800 (PST)
Received: from [2620:15c:29:204:5f87:a605:2b59:e392] ([2620:15c:29:204:5f87:a605:2b59:e392])
        by smtp.gmail.com with ESMTPSA id 16-20020a056a00073000b004dfe2217090sm13047847pfm.200.2022.03.06.14.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 14:11:20 -0800 (PST)
Date:   Sun, 6 Mar 2022 14:11:20 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Lianjie Zhang <zhanglianjie@uniontech.com>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: helper macro __ATTR_XX to make code more
 clear
In-Reply-To: <20220306073818.15089-1-zhanglianjie@uniontech.com>
Message-ID: <88c427-faec-ba5f-4ed4-bc2dd0873ec0@google.com>
References: <20220306073818.15089-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Mar 2022, Lianjie Zhang wrote:

> Signed-off-by: Lianjie Zhang <zhanglianjie@uniontech.com>

And VERIFY_OCTAL_PERMISSIONS() can help validate any future change.

Acked-by: David Rientjes <rientjes@google.com>
