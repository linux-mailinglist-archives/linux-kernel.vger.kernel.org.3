Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B239150D4DA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239125AbiDXTiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239141AbiDXTiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:38:17 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA30218B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 12:35:15 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id w16so6537963pfj.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 12:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=cCbva5d4cTef7JnnRvcj+uHQQXUpXaA+2xK/VFzMO4w=;
        b=LkVpoRUG75De+9HyDx15Zr4GfiqqMgKd9qwzqES1FhWMMrY8+v5JTEzxsTQCCfk1jL
         K04ggN0TOWJdxqAzCY1Me9wMzWxsuc9QL7sqhmkoI7zBGn8lIOqHrv+u2X8UTJ1pC8jX
         tE5hm2Wlj7q5NBIT2o5vny1y8BdpYUBUgcBimpvOD0YtB7e7S2YA2LmSclOIXdUq9/Wa
         zdqz9bgmcMBM4lB247PUHYAnQYuu18CZ1xTGBnR4y7odqXfhd34vUzc7lXTpACXzaP7u
         d1Gr6APlLxwJTkAWqCCGLl1csIgXX8n3ATxRvJlNivuYagzEXFQNNpOFPw0QfncBtmdH
         PSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=cCbva5d4cTef7JnnRvcj+uHQQXUpXaA+2xK/VFzMO4w=;
        b=AG0rQ21GzlCptypYUFs+VCEWlo9LF4oc/Xg3JBr8OHGKtEzx38bh19I3aHVVB0bS14
         rP0aGgKWRuVZWKeNTWeWSMW60/+o5kbdRRgeLUPNkeqlb3LRht7mtnAYfNt5o+5PgGGe
         6z7MP0VEQkhwO1YHGxqi2xv3KBUD18P0VsCQOKhvZP0Exf5U4NIfk2g3wTUYCBfUVM1u
         qG8VRv4tSMmhabcEsXFIgx2F23ORNem8ujEuSdyb8G3+/suvDis+3BxDS7szdaRsT4+a
         +zqH81R5o/1s0wrsPD6UFm3Iy2d/UNWNqDuOEZGFpG91Acu7l/RzA3fUIjEsj+01Axwh
         aCVQ==
X-Gm-Message-State: AOAM532IDOe7LxS8l2Un2qDaRuVLh2G9xBq6oGcCmrSdmwG4RhcL+Se0
        9zmP1+vvGh/GwWrCfBZWT1WqLA==
X-Google-Smtp-Source: ABdhPJxAgrjUeROv5fCIkxRGxN9Ux15Tld23PamShec+lf7XaV4NluDJ54VcqeoQLkUeWRbRoE962Q==
X-Received: by 2002:a05:6a00:1702:b0:50a:8181:fed7 with SMTP id h2-20020a056a00170200b0050a8181fed7mr15459151pfc.56.1650828914988;
        Sun, 24 Apr 2022 12:35:14 -0700 (PDT)
Received: from [2620:15c:29:204:d4fc:f95c:4d79:861f] ([2620:15c:29:204:d4fc:f95c:4d79:861f])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090a734a00b001bf31f7520csm4222344pjs.1.2022.04.24.12.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 12:35:14 -0700 (PDT)
Date:   Sun, 24 Apr 2022 12:35:14 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Yuanchu Xie <yuanchu@google.com>
cc:     Shuah Khan <shuah@kernel.org>, Markus Boehme <markubo@amazon.de>,
        SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] selftests/damon: add damon to selftests root
 Makefile
In-Reply-To: <20220418202017.3583638-1-yuanchu@google.com>
Message-ID: <93c3f9b4-7e14-858b-bf6c-23e4f3bec232@google.com>
References: <20220418202017.3583638-1-yuanchu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 18 Apr 2022, Yuanchu Xie wrote:

> Currently the damon selftests are not built with the rest of the
> selftests. We add damon to the list of targets.
> 
> Fixes: b348eb7abd09 ("mm/damon: add user space selftests")
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>

Acked-by: David Rientjes <rientjes@google.com>
