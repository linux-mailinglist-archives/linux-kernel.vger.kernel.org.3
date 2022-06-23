Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B27855772F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiFWJzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiFWJzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:55:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 301142BB33
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655978121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LcK/ElvToq/GKGaUTeOWlSYLGB2z7CGdZ3c0oLrfcZU=;
        b=VGiiahHrsCsCTVkzbYOqEOsQvzukkbIb2MRBov05pAM/24Jdu7bu77/bXk4B+nqpfH+q+6
        eYpUGJfv771SqcyB40aCVAZgA8cNpDf0AzOjjcRK9Iv97EsGc5LLfqxkxZuTnKTVYVOqua
        XE50EGZh2eXTXCDWIrjxnLVA6N8DFy8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-ffpYzy0IMTS5oVwWBGW_aA-1; Thu, 23 Jun 2022 05:55:18 -0400
X-MC-Unique: ffpYzy0IMTS5oVwWBGW_aA-1
Received: by mail-wm1-f70.google.com with SMTP id o23-20020a05600c511700b0039743cd8093so1178293wms.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LcK/ElvToq/GKGaUTeOWlSYLGB2z7CGdZ3c0oLrfcZU=;
        b=KzdZSDdANKJYMAvX1T18ohtyxrSWDFm8Y3cdHUciIyCQleRJ1MWx6d2K3RgeXa/BYt
         Mm7nThNz0NJh14E0/IZJfRPGVPe1uvA38cA5s3MkHbKzMd2Tl6jV8Qw58Efz62ggpgcm
         4u99fCe70KtHDOfyisGGUPSvdujhKgenv8Tn4Gs9d69zhiyvTCjKw85daj0iUxh+ov9W
         OH77/tvZqTdli2Ni9AXcsP+ziN0QksQ5bxPkEvrl93ICtZGk468afO9mRJeukdQBVbVT
         z/7DLdJ7Iia5In8xV5PNsGhBSmMqjylid4T9qElygg+42WMASGmvgeAiR8+aCxKgSdO7
         ftnA==
X-Gm-Message-State: AJIora8jl0nh9/JPh4E0WpTfI4N5C8Y3HyRWhh72dBFrHWb1DEZJ0F2c
        0FqfaQYqK1x24C5NjvNZoy8cBS6A889+5GgrNfbhKGLKRk58IKZ1Z9v5xFbNekvmY9EXYKGIAHu
        rj0AspE4vvJgDQ6C8fTvGhJ3sVXJQiIQ5Bz0zQlRJ
X-Received: by 2002:a7b:c4ce:0:b0:3a0:2ac4:3233 with SMTP id g14-20020a7bc4ce000000b003a02ac43233mr3167191wmk.92.1655978117407;
        Thu, 23 Jun 2022 02:55:17 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tWWfknRvDP524lHe6dlXZBJVCYmj0zoYe2ybjVKioiQLsF7GQ7KgpdkDjinkKIxuFs8fmriuxQO2+bQbrXoaE=
X-Received: by 2002:a7b:c4ce:0:b0:3a0:2ac4:3233 with SMTP id
 g14-20020a7bc4ce000000b003a02ac43233mr3167181wmk.92.1655978117238; Thu, 23
 Jun 2022 02:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220623093716.13338-1-jiaming@nfschina.com>
In-Reply-To: <20220623093716.13338-1-jiaming@nfschina.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 23 Jun 2022 11:55:06 +0200
Message-ID: <CAHc6FU5h+QDHgvNupAmjsnhKDCAXCpdy-3x8Qk-x3qwLMWvwZQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix spelling mistake
To:     Zhang Jiaming <jiaming@nfschina.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, liqiong@nfschina.com,
        renyu@nfschina.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 11:41 AM Zhang Jiaming <jiaming@nfschina.com> wrote:
> Change 'accomodate' to 'accommodate'.

Applied, thanks.

Andreas

