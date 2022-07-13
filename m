Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779A3573471
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbiGMKjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbiGMKjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:39:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA5FFD218
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:39:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dn9so19080071ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QIHulqJCI6QS+uVnMeeckx+ivdKRcKJrp3Fznv1diRA=;
        b=b39JIh5Sn80p9Cwg5CczCcll9xxOtCpwBU8EkcKlvxasF1TGM7spzJvVWQIH3+MQN2
         NkjNvqVpZ6lve4jSZ83utKSYsP8h1Olo2uWm3y55yvlLvz50se+/MKxCEgjSKbAWzuY6
         OO+AzyW2wsKjAogwRcyLpW6pMmZ8xiM6MTwpBFR4HhU8YkIyNa5hW0xgAZdhIXKMg5qN
         qnT6kms49QQxRLNzRngFZIs8CEYQfdhG/h15zgWFt77g6ENFq56QyKyg0g0ggEIPcmcc
         eptKoheTXinZKNx6tbzOdabE1KS7Im2Pje8bRQLy9zCCL62Tkejy15eidgr7QS92QLC9
         HhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QIHulqJCI6QS+uVnMeeckx+ivdKRcKJrp3Fznv1diRA=;
        b=7SLuYba5iHQvh/HHHaA5snB+HxUmZCAbMqOLFFLvlxjWJwnSiDj6ILcdopj9Eq7QLD
         AP02QtZY/5AISHWP6GQ1cDAWSj3hZ++2eW41aC4ZpmXG8EWII/y/PUJDmaoT4yIlXur2
         F2VYzte6zaDSolTsZVK4OWCdBAvhKM9c4bQYf3OQe7NeuhWICDsxAj7IlA1SjTOZgoCC
         PEXGY9jgXn/54GgVne4/z1rvJuLELBfjgNvk9LYJsBRgnn9HcjfT1fDuWJN9CFCzfAMI
         1HGjulLs65M8JeJ5veVXoTS8wgc/jvK2M4WyeMQhMjvvs5geEYA9MQAQ6R3l7ClgPxMk
         JSlA==
X-Gm-Message-State: AJIora8W2kdQTpsqHr6QA6hIXvfKGICpPNywoXVSIFc3AIr6NJwY/++P
        Z21yU3CVbbV/pAKi9+BaZPi1smQow1OFWXkswGJc
X-Google-Smtp-Source: AGRyM1tg7nAPmOCQxALFa3BTiCVyybPUfjZcPF2mOe+x/k9WKNSd7G90DvHc7x20Dc3t7OOY9yRx2gGpj+toZuzXBVA=
X-Received: by 2002:a17:907:a056:b0:72b:1964:fbcc with SMTP id
 gz22-20020a170907a05600b0072b1964fbccmr2820402ejc.489.1657708754817; Wed, 13
 Jul 2022 03:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220706050503.171-1-xieyongji@bytedance.com> <20220706050503.171-2-xieyongji@bytedance.com>
 <20220713015352-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220713015352-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 13 Jul 2022 18:39:04 +0800
Message-ID: <CACycT3uu3DWsLTH8b4GhTLS74hmduH5ugaKGEqaoBrdQckyPow@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] vduse: Remove unnecessary spin lock protection
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 1:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jul 06, 2022 at 01:04:59PM +0800, Xie Yongji wrote:
> > Taking iotlb lock to access bounce page in page fault
> > handler is meaningless since vduse_domain_free_bounce_pages()
> > would only be called during file release.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>
> vduse_domain_free_bounce_pages is not the
> only one taking this lock.

Yes, but only vduse_domain_free_bounce_pages() is to protect
domain->bounce_maps with this lock. In other places, the lock is used
to protect the domain->iotlb.

> This commit log needs more
> analysis documenting all points of access to bounce_maps
> and why vduse_domain_get_bounce_page and file
> release are the only two.
>

OK, I will explain that we actually protect two different variables
(domain->bounce_maps and domain->iotlb) with one lock.

Thanks,
Yongji
