Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1F3522F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiEKJkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbiEKJie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:38:34 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875E649934
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:37:23 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id e12so2831592ybc.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J7qdb1hLqH5S/Qijzmj6Il1EkPWwe2L7oUVkXG05Znc=;
        b=dJOWwBZVi7xQ3DLFYimxYV6NWUkjRtnDp21YC96glDvJ7XtbuAr6oQBhLY6kKOcB1o
         93nhch2e5dIYHSHu4m2eXJF5vve5qNg+cEsEvIZnd2DvGRWv3WRpaGNNAqH46jgXjfxr
         3w6cXuxClKtZZDHqrskiHW8HwkPVpJvSgaf/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J7qdb1hLqH5S/Qijzmj6Il1EkPWwe2L7oUVkXG05Znc=;
        b=pgKBBa/48G6A/Cs+wXl6pA8Ageo6H1ywhHZly1b/El7A5o9qmwVRwj+WttYEKujgVV
         DBpgU729xJn7xSn93glGAVFsxvF3RkHCWrHbHM5MIe0+7cp++peyrNrxIABPHFd1MixB
         +fWEkB7xcdAhu3o72/B+mj2EqhzCyQQN/gSfvacfE8v05hxTzeK2J8hFAsjW7n5qgpJO
         jwCMOm6NnhOjrh5nh9P7g4V5eh1G4Q7LErS4z/hrkosobTTv8U9s6wcjIOkyNtBPAzJ4
         s0zEgLoFanaJIpWAYmnzw/V8J8OEEv6s8jUX/ZDIGzh7W0uRfbpXMFdCa21/pl4N/UU5
         Rlmw==
X-Gm-Message-State: AOAM533xjC96TqOPGaNBezy00We73Oz3WxiWAeXn3YQ6LTU3Wih6gXcl
        Ij8SnLRIIQBKVbt/6m7ndoKK6EJwL+jTy5kaRaCHmg==
X-Google-Smtp-Source: ABdhPJx+rswrjLDO8mmFJlrYKb01zVPGHK7SBm118TyWvbFUgfQzKgZC8gEp79UUSYh48Im8RzQ+SCSNDCQpXLSz9rc=
X-Received: by 2002:a5b:44e:0:b0:64a:c0be:c59c with SMTP id
 s14-20020a5b044e000000b0064ac0bec59cmr15610827ybp.573.1652261841760; Wed, 11
 May 2022 02:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220511013057.245827-1-dlunev@chromium.org> <CAJfpegsmyY+D4kK3ov51FLGA=RkyGDKMcYiMo2zBqYuFNs78JQ@mail.gmail.com>
 <CAONX=-dqY64VkqF6cNYvm8t-ad8XRqDhELP9icfPTPD2iLobLA@mail.gmail.com> <CAJfpegvUZheWb3eJwVrpBDYzwQH=zQsuq9R8mpcXb3fqzzEdiQ@mail.gmail.com>
In-Reply-To: <CAJfpegvUZheWb3eJwVrpBDYzwQH=zQsuq9R8mpcXb3fqzzEdiQ@mail.gmail.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Wed, 11 May 2022 19:37:11 +1000
Message-ID: <CAONX=-cxA-tZOSo33WK9iJU61yeDX8Ct_PwOMD=5WXLYTJ-Mjg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Prevent re-use of FUSE superblock after force unmount
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> No progress has been made in the past decade with regard to suspend.
> I mainly put that down to lack of interest.
>
That is unfortunate.

> It is a legitimate operation, but one that is not guaranteed to leave
> the system in a clean state.
Sure, I don't think I can argue about it. The current behaviour is a problem,
however, since there is no other way to ensure the system can suspend
reliably but force unmount - we try normal unmount first and proceed with
force if that fails. Do you think that the approach proposed in this patchset
is a reasonable path to mitigate the issue?

Thanks,
Daniil
