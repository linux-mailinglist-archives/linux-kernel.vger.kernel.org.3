Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEAF5233B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243119AbiEKNF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbiEKNFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:05:50 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9BCDEAA
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:05:48 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id w187so3904536ybe.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=alN9NUxZowEkDstVYOnVw32DS4I4mSVC05IaVQ1sfiU=;
        b=NHbVLSb/IvYbshil6PcaDeTB9meK9lgGB+X9ifCZP+TCL1N3KBAZhlTd0GhktiOhkO
         cJtPG3u7bW8cUQ7YGT1ptX9+VyXecVcV5Y6ZXRdjJSSfH8HRFEOz02hDo4Hfqu0dQbAN
         Si4jvVk1JSJDxKvCLpBLZHl8Pa5bCknaZOJF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=alN9NUxZowEkDstVYOnVw32DS4I4mSVC05IaVQ1sfiU=;
        b=T3AuhbeESyTY60ZIvBvEahcoQgNdX3PIRya5a0+onO0GtIzGi4pS5U3k47E7k2v2M/
         G3Vv1LpSMbz/nKlSNPFhXXuf/5QacOB/ZXOjyxYEWsUpq2I9tSjLaY3CrPuEdgbYnbCQ
         oXPX3c/5O/1qgZrQxU/iW56gQOMv21QbAa4iu7nFGpDEoC4Ibfo8emk9CdiWerAnig0j
         VUYDDdeiXFZvzBz7PTrG83q6dYcrwtwMkpNvb2RNHzvYR9nnhm8gywEDNSxiWfq1bvrv
         WbAkfRb0Ebi55NVP9hoDWHOorxhNUM54FAawWyGG7gnGE3cUl1yd3K5OVjRmLQ9u5wH1
         K2UA==
X-Gm-Message-State: AOAM531DgcsHAqKTmSzIp8nkULIRtA37A/MTakiA8cp2x43T2kktiyIk
        tjmCVuc38Z+2Zy7SUSNHAmUEqsC2V5kv7jV03mNtqA==
X-Google-Smtp-Source: ABdhPJzkrcZMJilZKt8K7MTZ9r8G8qNFSk+3YyiZ6njw2XzhbTqbGkSKb6Y7yUx68sby8oqrklEVUwTAuqBK+A3Br4A=
X-Received: by 2002:a5b:44e:0:b0:64a:c0be:c59c with SMTP id
 s14-20020a5b044e000000b0064ac0bec59cmr16451795ybp.573.1652274347928; Wed, 11
 May 2022 06:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220511013057.245827-1-dlunev@chromium.org> <CAJfpegsmyY+D4kK3ov51FLGA=RkyGDKMcYiMo2zBqYuFNs78JQ@mail.gmail.com>
 <CAONX=-dqY64VkqF6cNYvm8t-ad8XRqDhELP9icfPTPD2iLobLA@mail.gmail.com>
 <CAJfpegvUZheWb3eJwVrpBDYzwQH=zQsuq9R8mpcXb3fqzzEdiQ@mail.gmail.com>
 <CAONX=-cxA-tZOSo33WK9iJU61yeDX8Ct_PwOMD=5WXLYTJ-Mjg@mail.gmail.com>
 <CAJfpegsNwsWJC+x8jL6kDzYhENQQ+aUYAV9wkdpQNT-FNMXyAg@mail.gmail.com>
 <CAONX=-d9nfYpPkbiVcaEsCQT1ZpwAN5ry8BYKBA6YoBvm7tPfg@mail.gmail.com> <CAJfpegtTP==oMm+LhvOkrxkPB973-Y80chbwYpXSiOAXBDhHJw@mail.gmail.com>
In-Reply-To: <CAJfpegtTP==oMm+LhvOkrxkPB973-Y80chbwYpXSiOAXBDhHJw@mail.gmail.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Wed, 11 May 2022 23:05:37 +1000
Message-ID: <CAONX=-fQvBczRk2HV1GXBoypq7_QbUX9JXc2AuDMQ+-qfYW32A@mail.gmail.com>
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

> I think it would be easiest to remove the super block from the
> type->fs_supers list.
I will try tomorrow and upload an updated patchset.
Thanks,
Daniil.
