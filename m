Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325B759E581
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242816AbiHWO5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243042AbiHWO5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549E230829E
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661257346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rBRONIqnt4E6MBax+RN8UNcJe1L53HfRKZaqNtIx+8M=;
        b=GsdQG1FJs3UY4S53yBmeY0EwRTaVfgsKFnuggOYAKNi8eXLm+ycT/Nc+52ZYcdhPSRmmlP
        3TNDNCb22Fos5J3sM0jDa5TPugACbyDBw/LWBCvYRfQ4KZtQuig10JfWruL5gmm87RBaqQ
        ioYuJvPXqaYV+YlHAaFD0PzNOhAkgew=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-495-51P4_ZG9OF6QLmn6ucQ6QA-1; Tue, 23 Aug 2022 08:22:24 -0400
X-MC-Unique: 51P4_ZG9OF6QLmn6ucQ6QA-1
Received: by mail-qt1-f200.google.com with SMTP id o22-20020ac85a56000000b0034481129ce6so10462494qta.19
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rBRONIqnt4E6MBax+RN8UNcJe1L53HfRKZaqNtIx+8M=;
        b=jCL7ttntQCKZjN9IHr734OZOWA2fZ8j0TExHCVLD/5Xm7RqrbyTBtY/U4NhkGhbhKP
         zxm6oxnXJuknZgF/JPCC6s8rlVPbg7i0ryq2K0jI271fTdIKTdlv9DfrgkGX3Dbg0TpD
         eLqXXkhVZ1TQS+Hz3gW6NpPD6fDs+NKDJ4efvmP94fLuw69ElRS8VDJ5OJjbv/hBk6Kn
         f2jlBCxAi9xuDgH6aGQLb4zf0fDFTXkudyEFdBmumsyjIYoWqvO4PzxeO+1hJDXXtDHo
         XfwlCSNFZMw2Rfr8AUqmbV8czyzZk2SxSH3EvorYkdpGnrK7rozeJgu1txmrKyuGClzk
         ZnnA==
X-Gm-Message-State: ACgBeo3jf62ZMGBl+mq9t5SWD3nkiYw1sJWrkQ1vrD1iXLcEOIivJN9C
        RCCJ4mK82SJajji6rfp01b1ga3BgsCH6Uy7EnUGAM3pAuf71r1VhXUumLnRCNIJR+8xmrPIRgJR
        isyioxMUYgqfAdePvpVHt+7krntld+3Z3gdYbiPzm
X-Received: by 2002:a05:622a:4cd:b0:343:65a4:e212 with SMTP id q13-20020a05622a04cd00b0034365a4e212mr18592698qtx.526.1661257344329;
        Tue, 23 Aug 2022 05:22:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5GKTbzDfd8wryS9ex6M02iafW0bT+KO4ivoTSlfqZwnK57plTGzb+b3/uHyQGZR/6c4pz3OUf4d7o+2xiJpKE=
X-Received: by 2002:a05:622a:4cd:b0:343:65a4:e212 with SMTP id
 q13-20020a05622a04cd00b0034365a4e212mr18592683qtx.526.1661257344138; Tue, 23
 Aug 2022 05:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220822071902.3419042-1-tcs_kernel@tencent.com> <f7e87879-1ac6-65e5-5162-c251204f07d4@datenfreihafen.org>
In-Reply-To: <f7e87879-1ac6-65e5-5162-c251204f07d4@datenfreihafen.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 23 Aug 2022 08:22:13 -0400
Message-ID: <CAK-6q+hf27dY9d-FyAh2GtA_zG5J4kkHEX2Qj38Rac_PH63bQg@mail.gmail.com>
Subject: Re: [PATCH] net/ieee802154: fix uninit value bug in dgram_sendmsg
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     Haimin Zhang <tcs.kernel@gmail.com>,
        Alexander Aring <alex.aring@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Haimin Zhang <tcs_kernel@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 23, 2022 at 5:42 AM Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
>
> Hello.
>
> On 22.08.22 09:19, Haimin Zhang wrote:
> > There is uninit value bug in dgram_sendmsg function in
> > net/ieee802154/socket.c when the length of valid data pointed by the
> > msg->msg_name isn't verified.
> >
> > This length is specified by msg->msg_namelen. Function
> > ieee802154_addr_from_sa is called by dgram_sendmsg, which use
> > msg->msg_name as struct sockaddr_ieee802154* and read it, that will
> > eventually lead to uninit value read. So we should check the length of
> > msg->msg_name is not less than sizeof(struct sockaddr_ieee802154)
> > before entering the ieee802154_addr_from_sa.
> >
> > Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
>
>
> This patch has been applied to the wpan tree and will be
> part of the next pull request to net. Thanks!

For me this patch is buggy or at least it is questionable how to deal
with the size of ieee802154_addr_sa here.

There should be a helper to calculate the size which depends on the
addr_type field. It is not required to send the last 6 bytes if
addr_type is IEEE802154_ADDR_SHORT.
Nitpick is that we should check in the beginning of that function.

- Alex

