Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8F5585848
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 05:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239608AbiG3Ddr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 23:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiG3DdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 23:33:24 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8E8EE2C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 20:33:23 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31e7ca45091so67442777b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 20:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=z7ruzMhRmh2YgpYMQNik2P2JjiDQ9hsKGh9nOYZ9DAM=;
        b=B3EmRh5qL/jgn/76GduSFcql8ABQv1rTAzqqT1T9oe5c/nHAnI/jMYvZX2uhnG2DEi
         r1c0ce8tjx4f1jb6mw7oPROUmRmJooHT95UPkV2HhqcNKe/0E89CsKk2ZKQje7iDAZB0
         aua7sgkaatxXCo7QUgBkCMuUGZPgNgPHbqniUia+65kAlYaZcLwHstGuzpS+VH7Zwx/o
         miQdhMMzgtyRxF5Sjb9x7InHlB90KpRd10AvJoXNgjzt6bGT7MsAPysPpZiQLUtSl1Wv
         S2LKY0ytm3DX4YDTjlbRqiZD/5cowPeXC8JTX3GzNZ1ZHo07vg33b638XU2EZg+uoY21
         4lDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=z7ruzMhRmh2YgpYMQNik2P2JjiDQ9hsKGh9nOYZ9DAM=;
        b=mv+Y0KF98jS/t8vgsl4whenpnbchEV9PnedajpJLUw8LrsJuqiHD1nPLjR//b7G/4N
         qBRrllZg8UyvRdhVEEI02rkC664Yoyt1i33nvUEbmv+nnbe6dsBwaupstHxUqbeCg2JM
         GIV6K+YUohul5EwqGMMModYD2uUH5jnahG5lxw6N8VDGX2szsSRoRsJY9VH6/dgs6qUR
         u4E3AFCGZLSNRe7EVel3c455RvGzD1AOtW/ioIUCccVsb+d5kb53qojEzoiWyDB7UWwt
         Ja5SWj43fs0QEmWEqoggVNChrses8rbzRVywrJgOSWuGqw0GLsdFlyZwM/NhzVlwie3D
         23IA==
X-Gm-Message-State: ACgBeo2Jq2qrsKR7aQMBWRuhXPGoo51xx5Nit7XiXZpod7uZrSu0SE6W
        Ackx/SQnyDupBFMsG0kdOxesnZy0M13gPuFITp8=
X-Google-Smtp-Source: AA6agR5jqXwkf+sodICjizbPOhaMY5XJ3r1zxT/JVi2kE+M6V4nzcMeGRanApNOS+9wjpil8ZM+9nOscib+mZrGHS7M=
X-Received: by 2002:a81:5e42:0:b0:31b:6254:1c2b with SMTP id
 s63-20020a815e42000000b0031b62541c2bmr5796260ywb.35.1659152002918; Fri, 29
 Jul 2022 20:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <YuDdHMaB6jWARQzA@kroah.com> <20220729035230.226172-1-ztong0001@gmail.com>
 <20220729035230.226172-4-ztong0001@gmail.com> <YuOLybUZ8cBWntY/@kroah.com>
In-Reply-To: <YuOLybUZ8cBWntY/@kroah.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Fri, 29 Jul 2022 20:33:12 -0700
Message-ID: <CAA5qM4B3eHt9BkPzvOuEA0_E5QanCWMzrqLJMaRDAnfAR4bw7A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] staging: rtl8192u: fix rmmod warn when device is renamed
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, Zheyu Ma <zheyuma97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 12:27 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 28, 2022 at 08:52:20PM -0700, Tong Zhang wrote:
> > @@ -164,11 +164,19 @@ void rtl8192_debugfs_init_one(struct net_device *dev)
> >
> >  void rtl8192_debugfs_exit_one(struct net_device *dev)
> >  {
> > -     struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
> > +     struct r8192_priv *priv = ieee80211_priv(dev);
>
> This change is not relevant for this patch :(
>
Oh sorry sorry, my bad, I will move them to a separate commit.
