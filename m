Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A51B5709C1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 20:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiGKSNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 14:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiGKSNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 14:13:33 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C389104;
        Mon, 11 Jul 2022 11:13:31 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-31cac89d8d6so57850937b3.2;
        Mon, 11 Jul 2022 11:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/J7EoD7mYdsTByRR/hI1SV+TyZn6NehpwEWybopIbI=;
        b=FIqGpB85xJKRC5WkrCOUp/7iGRo00lqk6kJT0a+Dys9m2lWFcYyySY7HpOBgAutwWk
         iPqbHDzcSwzlJM4aRA+tl4VBkoZUMKy0nMXKlhLDXHwD3Dl0LDlqkpeUyBy6RIhEx/IX
         xGvCrph1Eu+h+6NNvmhR9nZUyC2iBuQMqMQLjIENcETbpqeSoLJySBZ2MCbnt1JELr+e
         nXc4pStjwNUdtBk8W+ANlby/vbEhMUVVMmO+w7vChBeAu3Bt7tlkHEVY+iMCTIllQ0c1
         VHv4rWlEgY2Ku4ptevRGlqxQGJKjrrzsVg0/vRDX+DxGws58SpGHqIfOyzHxSQuu8Joe
         yDAQ==
X-Gm-Message-State: AJIora8m58ORCYg8fMbQzsIxqHYbGeVsAltSBJHD0JaBUGdkcqOvS4Fx
        ipNMOcSmudcH1Zd8N/bW0z14yiPTsZA5ZoHE6bX8IvVa
X-Google-Smtp-Source: AGRyM1tvjZqjRkNtCWDo0HQG980jf81RlhE/PXfBozPikRsPQdQAcENArNyc68Nh0OZ0KJ53nQUOO0zToucVqELMZz4=
X-Received: by 2002:a81:5957:0:b0:31c:f620:17ef with SMTP id
 n84-20020a815957000000b0031cf62017efmr20027196ywb.19.1657563210199; Mon, 11
 Jul 2022 11:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <03096156-3478-db03-c015-28643479116c@I-love.SAKURA.ne.jp>
 <48d01ce7-e028-c103-ea7f-5a4ea4c8930b@I-love.SAKURA.ne.jp> <2646e8a3-cc9f-c2c5-e4d6-c86de6e1b739@I-love.SAKURA.ne.jp>
In-Reply-To: <2646e8a3-cc9f-c2c5-e4d6-c86de6e1b739@I-love.SAKURA.ne.jp>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Jul 2022 20:13:18 +0200
Message-ID: <CAJZ5v0g6+CR80=zQi=aTbJDc3FAMRAFUE=e-QURcwi_25zgAfw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] PM: hibernate: allow wait_for_device_probe() to
 timeout when resuming from hibernation
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        "Rafael J. Wysocki" <rjw@sisk.pl>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 4:25 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> syzbot is reporting hung task at misc_open() [1], for there is a race
> window of AB-BA deadlock which involves probe_count variable.
>
> Even with "char: misc: allow calling open() callback without misc_mtx
> held" and "PM: hibernate: call wait_for_device_probe() without
> system_transition_mutex held", wait_for_device_probe() from snapshot_open()
> can sleep forever if probe_count cannot become 0.
>
> Since snapshot_open() is a userland-driven hibernation/resume request,
> it should be acceptable to fail if something is wrong.

Not really.

If you are resuming from hibernation and the image cannot be reached
(which is the situation described above), failing and continuing to
boot means discarding the image and possible user data loss.

There is no "graceful failure" in this case.

> Users would not want to wait for hours if device stopped responding.

If the device holding the image is not responding, we should better
wait for it or panic().  Or let the user make the system reboot.
