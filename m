Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B784C3AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbiBYBL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiBYBLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:11:55 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4254B1ED4EB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:11:25 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id q11so3404590pln.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=88hkv3OSXeqX0vz3SW+Res2AknL0SrraTbrIeEDLRx0=;
        b=I6iiifEovV+wuCY9SDP0FO7wFWxQqlJyQMG/0i/IFDzK/X0CZwUWvbj69bLqNiTd9W
         fXAf7+UW6J9D56m+YUOKOsGYHv/aot1JZIsqzen1sQt9xu0fpim3CqGUDp1ZbTaLNNUA
         QaGsBXVEPKZv1KMgXh0Cg13b3J/PPG+KtreCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=88hkv3OSXeqX0vz3SW+Res2AknL0SrraTbrIeEDLRx0=;
        b=ubfaPjGfK1jZKXbPfl9dGNq5MR6zJ5C0uCqOxaVXjoh5XrVHxrKiwZQiTUhKFKO7F3
         TGM2PN3RR6DwjR/sE5wVpO3cgGRWbhIRu5G7vZR/jRF4RWK2aEp4xcQnWdsPodm/iqF3
         AGGL/1m7HFt4NO8MvGnrIuuDsHuBnEZkMXHuUrR27c0SW2VLE1bQUfCkHVx8qWQYF4zw
         JGSu1ZnOdLfwhTZGtNi+4Et36Fj0/9CJu1Ft4vjgxJ9AS3fsY7ErtpleKwF4dN4SpFcB
         j63q5+/3Hq0H1ezqsQ2vk5olvVBQenESSsULoxYXNeVmm1hPL5e19c3q82GWxqJ0dQRn
         kLZQ==
X-Gm-Message-State: AOAM531Y99oNfbVUqftc/D31DydVwQFODdSczb/MoseaTiFgXhoSEwAd
        vk70uwdn5XyiQsm+KLLfjRyzHA==
X-Google-Smtp-Source: ABdhPJygTkHlkE/7Oii+EvOYy0K6/Ls92pEbgaUCEUdLGx3H0HrW37Wz0BmFrEukMgNhNTFdY18MjA==
X-Received: by 2002:a17:90a:4682:b0:1bc:236:7e46 with SMTP id z2-20020a17090a468200b001bc02367e46mr744486pjf.212.1645751484785;
        Thu, 24 Feb 2022 17:11:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y17-20020a63ce11000000b0036c96df445fsm652492pgf.53.2022.02.24.17.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 17:11:24 -0800 (PST)
Date:   Thu, 24 Feb 2022 17:11:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 20/39] x86/bugs: Disable Retpoline when IBT
Message-ID: <202202241710.B35CBB06@keescook>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.189353523@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224151323.189353523@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:58PM +0100, Peter Zijlstra wrote:
> Retpoline and IBT are mutually exclusive. IBT relies on indirect
> branches (JMP/CALL *%reg) while retpoline avoids them by design.
> 
> Demote to LFENCE on IBT enabled hardware.

What's the expected perf impact of this?

-Kees

-- 
Kees Cook
