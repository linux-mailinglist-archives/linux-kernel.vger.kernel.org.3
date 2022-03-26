Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE564E7E3D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiCZAvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 20:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiCZAvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 20:51:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4AF16AA70;
        Fri, 25 Mar 2022 17:50:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 246C5617B3;
        Sat, 26 Mar 2022 00:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5A3C34110;
        Sat, 26 Mar 2022 00:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648255801;
        bh=MYZG7zfX7Wzo958+0h/Wy9Ix42WgtYW+LXSflItPzk8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=XchYimBZwdZB5p5U7RiixY+PxT65BlaoRTMsg6MXGAb1/kq/bRCVWRYrjX7y+milv
         Hr3UCJKSqD9/7xdKHu4ifuXdvv8SzldzeTAzcvJcbEKdSVBtVvlGlhd5EZQ/Sz1/NE
         zm//eONkZE4u3MdtPJooAGbocxHttraeGgJeY0r76WPlam3qTheNaAS0hLkc93B+fm
         joN/yIKLaibhmtc72TTXDlMelQcTXxqwcb5ruKeqyCMXBXD3Tbj0JJjA1HJGb8OzcA
         S6tXbdSqMHw6D/xQ7uRzcjHmZ+Ty/wavSrDkID+RS3TWqibXF/myg5CDpGjNFMtCwE
         TDcUysGGSpBMA==
Received: by mail-wr1-f45.google.com with SMTP id h4so12825909wrc.13;
        Fri, 25 Mar 2022 17:50:01 -0700 (PDT)
X-Gm-Message-State: AOAM530AyUXT6/UEUKMCexlT4mrZuV0wjHeL9qwv+jsYelt3CdpYJmum
        XplW3nJ6xZCdWCwVnzgP3xNG/mMvPDkm22H5cRc=
X-Google-Smtp-Source: ABdhPJzx6Be34R/RBppR3AjlSMr0dsY5yWSn48LeN5Uc7ypQxsIidxFpk4R2pjzeBWnUe94iXrqE0XVQLLKRK09WFOw=
X-Received: by 2002:a05:6000:1184:b0:203:ff46:1d72 with SMTP id
 g4-20020a056000118400b00203ff461d72mr11488471wrx.165.1648255799658; Fri, 25
 Mar 2022 17:49:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:2c1:0:0:0:0 with HTTP; Fri, 25 Mar 2022 17:49:58
 -0700 (PDT)
In-Reply-To: <20220324071301.60228-1-jakobkoschel@gmail.com>
References: <20220324071301.60228-1-jakobkoschel@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 26 Mar 2022 09:49:58 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8Kthuw+=VsGWMCYE4McX3JBarwf4p4UPH7czhkS=u6Bw@mail.gmail.com>
Message-ID: <CAKYAXd8Kthuw+=VsGWMCYE4McX3JBarwf4p4UPH7czhkS=u6Bw@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: replace usage of found with dedicated list
 iterator variable
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
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

2022-03-24 16:13 GMT+09:00, Jakob Koschel <jakobkoschel@gmail.com>:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
>
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
>
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
>
> Link:
> https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
