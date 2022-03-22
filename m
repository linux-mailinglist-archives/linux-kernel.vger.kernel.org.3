Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0A24E365A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 03:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbiCVCA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 22:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbiCVCAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:00:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B24555BE62
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647914367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sAk9FMAq7G/qGtP6D8AGvXHRXy5lqx/zoAVECLpUuqk=;
        b=fbtRjgiVnpY3DmUXRqFYoPXm1gkknSAeMjFUXJ/wLWhZRTbzK8llYVmfYtv9W56hkiyLzI
        quMCdsfjtMNmesduUKfmxjXnxr/JDOWzS/Qv/8dqxWjIe4rp80il4Ri+pqjnza1F6LNf5o
        lqImrZMwKEN04wata3zpErZd8lSB8Vk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-af3s_oDDMdqohT8MWzCzbw-1; Mon, 21 Mar 2022 21:59:26 -0400
X-MC-Unique: af3s_oDDMdqohT8MWzCzbw-1
Received: by mail-lj1-f200.google.com with SMTP id q5-20020a2e9145000000b002497bf0eaa1so2791252ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sAk9FMAq7G/qGtP6D8AGvXHRXy5lqx/zoAVECLpUuqk=;
        b=59kgRDpqCe5OyageOq8JYJSGCzRYKjVtuyIteejs34ytgo+zd5mJ/R8Wt+uqR17eFL
         v3uj6xS9NPImdvYWILjcGSzEea8BfT3B3dLwP8zqb6QQpJM82KHgsiJh0T4ZEYuA4WJR
         geTb4lGj0sphAjwENfdMe+vjy3Rfu2uXGNt4ym60EqWt+3MXJ6Q1aMd9p8gehlROjX/h
         +61MGUVuQgNfEl4gST7RLqVl1sy700PsOrkPhq5MitryDaY5R5DT97OFtS+7W+j0E/A8
         6PJVeRnv/21BjkUfEJa2tvPP6KRgkKVt3HCSB9eHLuODSmWOzx19QvYSBjdO7cVZSIGV
         Vy5Q==
X-Gm-Message-State: AOAM532FFdWMxSore5QSDpBaXAOvAQfNxknSFIYMH2jB+mDgZ3ND0yMV
        CqUy0cjDwbLL3Wx8Y0H/EfXMpnH6MNiG2TefHm5vB0VG7RK0R4Ji+vU/USopWQtUaunI0huSM6J
        ZTqujLb10bSzH3f+Bnm2hDZjBU2gKVFlsdz2S6Pig
X-Received: by 2002:a2e:824e:0:b0:249:7e3d:c862 with SMTP id j14-20020a2e824e000000b002497e3dc862mr8338194ljh.97.1647914365113;
        Mon, 21 Mar 2022 18:59:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMrcRoYPcVBF7xK+Ox8ekhMvlc3FPY4gYx4yzyrVWKbXtWn7mI1az1lvn2avR+9/0h4SqQyr0XCODkhTkeqNc=
X-Received: by 2002:a2e:824e:0:b0:249:7e3d:c862 with SMTP id
 j14-20020a2e824e000000b002497e3dc862mr8338187ljh.97.1647914364929; Mon, 21
 Mar 2022 18:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220321060429.10457-1-jasowang@redhat.com> <20220321085317.3148-1-hdanton@sina.com>
 <CACGkMEvF80FuU0uD+RZMOrySQ0K2RZVh7Pmn4UhNtz_Exs3c2w@mail.gmail.com>
 <CACGkMEvLqox3QZxpxeQdrjBnM6zRr_wGfddoN45RUSsZEOe=bQ@mail.gmail.com> <20220321123420.3207-1-hdanton@sina.com>
In-Reply-To: <20220321123420.3207-1-hdanton@sina.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 22 Mar 2022 09:59:14 +0800
Message-ID: <CACGkMEt-PRCsBQ+EJVGeWGikJfLk-0M1dRPMqnp9YC5R4HYAjQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
To:     Hillf Danton <hdanton@sina.com>
Cc:     mst <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 8:34 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Mon, 21 Mar 2022 17:00:09 +0800 Jason Wang wrote:
> >
> > Ok, speak too fast.
>
> Frankly I have fun running faster five days a week.

:)

>
> > So you meant to add a cond_resched() in the loop?
>
> Yes, it is one liner.

Yes, there will be no "infinite" loop, but since the loop is triggered
by userspace. It looks to me it will delay the flush/drain of the
workqueue forever which is still suboptimal.

Thanks

>
> Hillf
>

