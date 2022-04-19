Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E535071A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353808AbiDSP1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353806AbiDSP1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0492D38BFF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650381862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cp3erbdHIxI8pbHHBBO/snHJsYK0Yd+hp7YCIMU9Eq0=;
        b=YoVRtGcbkL379lkEC0QaoHO5yOsaCb18pFKgLc1sqVNbs/di8iSGBrPg04YzVkY+uzkYlm
        j2oBlD/WE/raTFWFdzV0TYy6RKmeJ8XkG6/Qn5HdnT05P8QvbEvObBI1JSRu2Ni8Mm1ke+
        Z0z+w7aSoFPdHSQB+4+hMaeAG2KS6GQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-hdFINmWuPK2ng3KFzN80eg-1; Tue, 19 Apr 2022 11:24:20 -0400
X-MC-Unique: hdFINmWuPK2ng3KFzN80eg-1
Received: by mail-ed1-f70.google.com with SMTP id cn27-20020a0564020cbb00b0041b5b91adb5so11197844edb.15
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cp3erbdHIxI8pbHHBBO/snHJsYK0Yd+hp7YCIMU9Eq0=;
        b=4+UcZbITgY1pIph5af5ykZnUfqdTzQQiif0o/J1TkcH9GMggc8B8fSUvinUwxz3t5D
         GTeqO7C5YLYj8kxBto0IkzH6Hljbf6W4Uy4WgZR6kp+ML/kMTMxg8dU9F1yHjTlfZRsu
         PIT3ZWe/T6ADY1I5hk15WDDW1Crw8Z0hIpccjZmHoApfZPbjCp5z5AHqW6YATq8Pz6YK
         G3yex41RAHl1Q9xCWGyD6N83i8crVbU5Hwhr6uhTmfft9jk78lO5xWvr0Z3DRloDihyM
         SjbqyHMbnXwCv6+54C1YczROnxDFscvivX/jFlXW+VcaVVDID0fT3NgbKWYqELYS0k2m
         Acpg==
X-Gm-Message-State: AOAM531RZUmYvWPeHUFfMOebLyWVt0dHuuCue9L7XZO4gcnIGNOmEqbW
        3Vht+suHEEAGaHB9gKLsg0seuJUBASeE4zdrwlcak/qhcZeR0Xw65zYv+/NpoDExZ8fw65KFr9R
        MFnJo5Xv6ML3/ARjBqvB+wbTd8ycPFQZDBHdwYkX+
X-Received: by 2002:a17:907:8a03:b0:6ec:8197:e8ac with SMTP id sc3-20020a1709078a0300b006ec8197e8acmr13305418ejc.379.1650381859452;
        Tue, 19 Apr 2022 08:24:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEV2IgUHFtehd7uHS7lnxS/tYG3PBuNMrvIeNlWN6+XHPGaya3+IKBxGf3ipbReX5cmQisNirCElxQhR5nhVo=
X-Received: by 2002:a17:907:8a03:b0:6ec:8197:e8ac with SMTP id
 sc3-20020a1709078a0300b006ec8197e8acmr13305391ejc.379.1650381859157; Tue, 19
 Apr 2022 08:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <YlWWbpW5Foynjllo@rabbit.intern.cm-ag> <454834.1650373340@warthog.procyon.org.uk>
 <Yl7EyMLnqqDv63yW@rabbit.intern.cm-ag>
In-Reply-To: <Yl7EyMLnqqDv63yW@rabbit.intern.cm-ag>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 19 Apr 2022 11:23:42 -0400
Message-ID: <CALF+zOnxxvDPd6L=W6N0WnS_jbYLBDfENKTousT36jQ37h_Vnw@mail.gmail.com>
Subject: Re: [Linux-cachefs] fscache corruption in Linux 5.17?
To:     Max Kellermann <mk@cm4all.com>
Cc:     David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 10:19 AM Max Kellermann <mk@cm4all.com> wrote:
>
> On 2022/04/19 15:02, David Howells <dhowells@redhat.com> wrote:
> > I presume you are actually using a cache?
>
> Yes, see:
>
> On 2022/04/12 17:10, Max Kellermann <max@rabbit.intern.cm-ag> wrote:
> > All web servers mount a storage via NFSv3 with fscache.
>
> At least one web server is still in this broken state right now.  So
> if you need anything from that server, tell me, and I'll get it.
>
> I will need to downgrade to 5.16 tomorrow to get rid of the corruption
> bug (I've delayed this for a week, waiting for your reply).  After
> tomorrow, I can no longer help debugging this.
>
> Max
>

FWIW, I just noticed one of my unit tests is failing with data
corruption with NFSv3 only (NFS4.x does not fail) on 5.18.0-rc3 - not
sure how repeatable it is.
I'll see what I can find out.

