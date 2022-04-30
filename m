Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD91515A49
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 06:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382215AbiD3ESr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 00:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382221AbiD3ESU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 00:18:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C1AD1150;
        Fri, 29 Apr 2022 21:14:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8EAE60AC5;
        Sat, 30 Apr 2022 04:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EC0C385AA;
        Sat, 30 Apr 2022 04:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651292092;
        bh=pxmizclQyQseBkms6UHURmopQWes8Htr4kJkCw7niB8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Jl9SDI0keR5b/6tvEX7iksxIpsoBMSGA9i75+vxZdvUKUg4tXVkWMHC8Gbk44Ygxe
         qLR+S0eTN0qXqZzpPH18MXRh20KkBO0RnLoghUbHOVKPaHShXDhyPUypppBSAiNC5Z
         3OiXRUvUfJCp9FUHgUpvn+NTaWdU3ovvJbn3b+4p1Agw1n3tz/yHvv9jv6dfjnFAIO
         qRQnZyJ3ZVnq2BGVaMkMj/xN7Kox5x3z2bJM9/A18sQmkTCFQdqN09PXNdkicveNGi
         8ur3qe2x28uJ7B4WDWpGxTXVvr7xoM3AaTpwMVMd0amrUXk3iq78K4IhQv/kDnZUjX
         Qf29PQBpYswyg==
Received: by mail-wr1-f49.google.com with SMTP id t6so13055167wra.4;
        Fri, 29 Apr 2022 21:14:52 -0700 (PDT)
X-Gm-Message-State: AOAM533phI2oOT+qQN82s1LMsDvNUPahWdebKPRAJ3v2tzHKISOcbYKw
        lFidz53TX+fOFiSVOZsjQJR4QCqa7ujzV80fSsk=
X-Google-Smtp-Source: ABdhPJzokjuR05pG2AP2sTlYSOO1c5Wjnn5XONVcKecKBlo2GaPW2LTz70JKCARB7kyXtop2/AcMNJF+orTw2EEIxZw=
X-Received: by 2002:a5d:5889:0:b0:20c:4ad9:3510 with SMTP id
 n9-20020a5d5889000000b0020c4ad93510mr1639271wrf.62.1651292090561; Fri, 29 Apr
 2022 21:14:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:64e7:0:0:0:0:0 with HTTP; Fri, 29 Apr 2022 21:14:50
 -0700 (PDT)
In-Reply-To: <20220429081121.1640-1-xiongx18@fudan.edu.cn>
References: <20220429081121.1640-1-xiongx18@fudan.edu.cn>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 30 Apr 2022 13:14:50 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9SdLAB_=P_4L47Gfo_uAE_i98292Rut6=dfBr-zy3nGQ@mail.gmail.com>
Message-ID: <CAKYAXd9SdLAB_=P_4L47Gfo_uAE_i98292Rut6=dfBr-zy3nGQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fix reference count leak in smb_check_perm_dacl()
To:     Xin Xiong <xiongx18@fudan.edu.cn>
Cc:     Steve French <sfrench@samba.org>, Hyunchul Lee <hyc.lee@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-04-29 17:11 GMT+09:00, Xin Xiong <xiongx18@fudan.edu.cn>:
> The issue happens in a specific path in smb_check_perm_dacl(). When
> "id" and "uid" have the same value, the function simply jumps out of
> the loop without decrementing the reference count of the object
> "posix_acls", which is increased by get_acl() earlier. This may
> result in memory leaks.
>
> Fix it by decreasing the reference count of "posix_acls" before
> jumping to label "check_access_bits".
>
> Fixes: 777cad1604d6 ("ksmbd: remove select FS_POSIX_ACL in Kconfig")
> Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
