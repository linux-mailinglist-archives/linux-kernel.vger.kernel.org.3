Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582914F4961
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiDEWMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385663AbiDEOSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 10:18:43 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7567524F14
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:06:40 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id z33so18718611ybh.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=icqYVBohFnFJ5oHU+nslboiajB+SnOBn5hI9MsTTjY0=;
        b=mM//HIZLG1UpdS/W5Yy5oOygxhC5rnGWHf7ARQX2GQL3/AyfTsSmLzf/7ahtZbvV/+
         J31q3h7p95gD1CyKhPFKcNo521T6GI58bHmk51/JZ/ETQBhQwlmXCaRzHBMHBAPNlzVR
         XHRBa2JLFjQv1Zhyds+BkZ1ahlUzMQdAjNbPU5qpI68wwYx9JU72nZv3D+OVeiG0V4vt
         SpnqJyUQPuFpU7ksk645ui5I94ErGcXSkPaFBTWQRggi9XmaTlRR4ak2+cuhzsRWgr73
         HYQQMTkrPDn0nkSvoCWvGmGNU1rhhP9FqwyZJIwfa3C6ZMLU/Mk7CK0ZkwWC7vKGMyPq
         KlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icqYVBohFnFJ5oHU+nslboiajB+SnOBn5hI9MsTTjY0=;
        b=FoBiXJxP/Cw+cewa5kk5mCyoROhCIBrvUvYexglsy4PQSiJctrjvPR1CGW2omx5g4Z
         Wwna/AloQpTyYxMjU6eRVcJkE0CFyWhS5XBW3jm7TpgmIRIqrpKLbJ/R1oh6J6XBXJpY
         R+Ll2B0UN25VITCfnvwvRXzNffwoOdwjfsR1u3K8sx31SVMzuX94fLH0EC6WbRrPa/D9
         gxVmZtt7AWR/CG2XSIhH3IDcBxM6VzhobWmhi5sTtzHFsuhVd+LEV6Q3pfLaoqhjsnuL
         l7nDHuNzjsAm57arsqqbj/1tY6l7lXs1Df+BnLZY9Xlebll3yLWmlpAQezf1eZAdTtBv
         vxSw==
X-Gm-Message-State: AOAM531uik5181a/0tlcE79PC5arnX+qP07URxn7WF7FWKxi20eGdXEe
        PpWA7T4T3+W3O7RN+QvmxeLNRJM7khOfeVQOJP4=
X-Google-Smtp-Source: ABdhPJx/No+FakBF2W6Q7NjIKNVgdeDDfalX0yfWAyYloetqiOxeiYnltU3PjsBP6kphCcUsdhyh3MxaVwUUvRHe5o4=
X-Received: by 2002:a5b:8c4:0:b0:633:e30a:8ade with SMTP id
 w4-20020a5b08c4000000b00633e30a8ademr2441915ybq.517.1649163999198; Tue, 05
 Apr 2022 06:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <YkHXO6LGHAN0p1pq@debian> <787d309d-f0b6-4f27-ed31-6811fd7c9293@suse.de>
 <CADVatmM0mP9u9H_LY8qm+ZpezyELdeBSWqQameZnb0dP7TUsQw@mail.gmail.com> <1116eb70-516e-13b3-0697-4af00430bae8@suse.de>
In-Reply-To: <1116eb70-516e-13b3-0697-4af00430bae8@suse.de>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Tue, 5 Apr 2022 14:06:03 +0100
Message-ID: <CADVatmMdBmU9E4XEnc8Y=JdvUKVvVgawJWtHqojW5hFHkkfaJQ@mail.gmail.com>
Subject: Re: regression: NULL pointer dereference due to 27599aacbaef ("fbdev:
 Hot-unplug firmware fb devices on forced removal")
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Zack Rusin <zackr@vmware.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022 at 8:46 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 31.03.22 um 10:25 schrieb Sudip Mukherjee:
> > On Thu, Mar 31, 2022 at 8:07 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >>
> >>
> >>
> >> Am 28.03.22 um 17:41 schrieb Sudip Mukherjee:
> >>> Hi Thomas,
> >>>
> >>> We usually run boot tests with linux mainline HEAD commit almost every
> >>> night on ppc64 qemu. And my tests had been failing for last few days.
> >>
> >> Could you please provide your kernel's config file?
> >
> > Thanks for taking a look at it.
> > The config is attached.
> >
> >
>
> I was able to reproduce and fix the issue locally. Please have a look at
> [1] for the patch.

Thanks Thomas.

And I can confirm it fixes the problem for me too.
Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>


-- 
Regards
Sudip
