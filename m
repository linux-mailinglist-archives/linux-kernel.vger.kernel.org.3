Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405AA4E539B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244532AbiCWNx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244514AbiCWNxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:53:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9941D1BE97;
        Wed, 23 Mar 2022 06:51:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FBF7B81EDC;
        Wed, 23 Mar 2022 13:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0841C340F4;
        Wed, 23 Mar 2022 13:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648043506;
        bh=y/8aIxPXC+g394fcpgBDvsF8AxrQH/gs1zJEIlzIc9g=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=MfjNFMEXIq1LrB14zwHXHCwqdSMMCMZ9E8jg8eprTKO/2iAnt4ATAFBc31PZKQfAb
         EM5/kRM3Pp1xXYRJzr+dKtZ6W6B3eUP69dIoy0m37nrQTUwa58mwi/dgPv1S6XLoK3
         boD0fPX1I9O5VLeGMj34Zl8FSzHc6eqQ4N/8qJs6Jvjn50oKYzbIB3T2R7iH1WSKl5
         7j6Bu4ETeTmbp/ncOcR5Sd82HLPndoHmCFyLIVezhEw940pGwHfviTahGKs3aAjtJd
         wUcuPfhEeg2rxng34BuDGfYDBLHlqq3e2SjnyIdoaUv5qAx4Cgmqb00HjyuJ1GG9uN
         kZODxA/Jni5DQ==
Received: by mail-wm1-f42.google.com with SMTP id h16so1002893wmd.0;
        Wed, 23 Mar 2022 06:51:46 -0700 (PDT)
X-Gm-Message-State: AOAM530qcM6BOi1iMal4uJSLIJjgLGmNWwg2a83hhQ1mARrautcNPLsM
        7s+tSsjwH5uW0ln65m2UZjJWnKpQ78KsgXjnhf0=
X-Google-Smtp-Source: ABdhPJzFk8Jniw3PIZb0IdWDB6+0zuAeveTEbvoR3GFK7Mu/1wULKttztobpAEmS/X/SmYLAL2n4C+xZcNEje8UmHWQ=
X-Received: by 2002:a05:600c:214a:b0:38c:aa5d:1872 with SMTP id
 v10-20020a05600c214a00b0038caa5d1872mr9816712wml.9.1648043505123; Wed, 23 Mar
 2022 06:51:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:2c1:0:0:0:0 with HTTP; Wed, 23 Mar 2022 06:51:44
 -0700 (PDT)
In-Reply-To: <577b4601aa5d62d222fa9387c5036f2504f40318.1648017112.git.christophe.jaillet@wanadoo.fr>
References: <577b4601aa5d62d222fa9387c5036f2504f40318.1648017112.git.christophe.jaillet@wanadoo.fr>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 23 Mar 2022 22:51:44 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_ZP6-dHFJ80cNDJBP+de=CeLrMqbwiHd58++qqFoESRQ@mail.gmail.com>
Message-ID: <CAKYAXd_ZP6-dHFJ80cNDJBP+de=CeLrMqbwiHd58++qqFoESRQ@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: Remove a redundant zeroing of memory
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-03-23 15:32 GMT+09:00, Christophe JAILLET <christophe.jaillet@wanadoo.fr>:
> fill_transform_hdr() has only one caller that already clears tr_buf (it is
> kzalloc'ed).
>
> So there is no need to clear it another time here.
>
> Remove the superfluous memset() and add a comment to remind that the caller
> must clear the buffer.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
