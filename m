Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FBF588396
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbiHBV3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbiHBV3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:29:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABC91D0F3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 14:29:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4927CB820AA
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2AEC433D7
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659475773;
        bh=SGZd11R+IMi10UvAspXhHJm/sz8ulVf0IdRmfkUbaoM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EAknVLAxXRbcMekqZH/Z1acSSJw61MzAAgSXD+Au2gxiiopiJDAtCQiEPvFKVJ9pu
         6+vgMi6sslgax8h2Cx9pXfQrKHYz6CyMldcl5txcjSw0Amyzcy68RgolRMXv2jR8U2
         2I+pMBtm8eg79KPSvfpBA3kjq5FsZ2X53MzB0BFC4QaKl5V/Kc9dn3fELmv4ZiuuAX
         S/hvbpKTWls8oPW+TUMXWEoRg3vO+0pUYlQ53L2RUH5R5ZTF3dczOW1oZZ7h3TrCsT
         uqYHt+S6lAQzql6h11nJMPwOtTGsm4qhsWopFZjXgszWxHuZ8qY/e3d8Jazm0v3dpu
         sLDw3brQ4vPnA==
Received: by mail-ot1-f54.google.com with SMTP id c20-20020a9d4814000000b0061cecd22af4so10989920otf.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 14:29:33 -0700 (PDT)
X-Gm-Message-State: AJIora+m9wInceYn8twEtavyPgg/WXROfn57SGbpBV93zHB+i7EFcYpv
        +40ozKPOm7T+1T/99D5q8muSZxHuvl+LjKSME6BUFA==
X-Google-Smtp-Source: AA6agR4gDjxO8eQIdJP2ak/bQJj6aSqPJNBmfbIMRPjX7q3qBHZva2gJEgK5hCAMdBGldKbha+0RtVlrHChFByEI3nI=
X-Received: by 2002:a05:6902:1541:b0:675:4f34:7315 with SMTP id
 r1-20020a056902154100b006754f347315mr18285149ybu.65.1659475762836; Tue, 02
 Aug 2022 14:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220801180146.1157914-1-fred@cloudflare.com> <20220801180146.1157914-3-fred@cloudflare.com>
In-Reply-To: <20220801180146.1157914-3-fred@cloudflare.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 2 Aug 2022 23:29:12 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7Oxb8dhM6SotKfS30i2_=ONbd=LF2qB6ZCpYqRFtDx+A@mail.gmail.com>
Message-ID: <CACYkzJ7Oxb8dhM6SotKfS30i2_=ONbd=LF2qB6ZCpYqRFtDx+A@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] bpf-lsm: Make bpf_lsm_userns_create() sleepable
To:     Frederick Lawler <fred@cloudflare.com>
Cc:     revest@chromium.org, jackmanb@chromium.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        jmorris@namei.org, serge@hallyn.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        shuah@kernel.org, brauner@kernel.org, casey@schaufler-ca.com,
        ebiederm@xmission.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kernel-team@cloudflare.com,
        cgzones@googlemail.com, karl@bigbadwolfsecurity.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 8:02 PM Frederick Lawler <fred@cloudflare.com> wrote:
>
> Users may want to audit calls to security_create_user_ns() and access
> user space memory. Also create_user_ns() runs without
> pagefault_disabled(). Therefore, make bpf_lsm_userns_create() sleepable
> for mandatory access control policies.
>
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Acked-by: KP Singh <kpsingh@kernel.org>
