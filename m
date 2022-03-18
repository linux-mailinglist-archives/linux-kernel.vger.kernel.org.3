Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34244DDFF7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 18:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbiCRRbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 13:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiCRRbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:31:45 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB7A37BE3;
        Fri, 18 Mar 2022 10:30:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q1-20020a17090a4f8100b001c6575ae105so5980879pjh.0;
        Fri, 18 Mar 2022 10:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1wKylVeXOlh5a/xJZmfHNeqpE/OOU4LWHviEMispbow=;
        b=P7nIf6UKiM4fPEnynbxsjHAS81Z785zj3unC6tm/0AIdEzo2iqXmIxKvDUN4qN1MlO
         2B8BLdVBKoTlPUQaagv2upR2GiuihkW91yTU1SSurPeoSjxGKOoMyNX6cJbCoU/oLRlC
         2SPZNVFO/rGoBfHy8o/zKCyXVmmk+lv8dZ95gmq4Dou/oMsk8W94xifeOuv4RPiaOffO
         cpwas7YgFlUe15Wks32njZ4PWyBA5uT/nXcqX7uWbUVKPUml+YOVQPE5Ur3IyM2TG1qs
         sU0g4Xzc7t9bEH5YN+mBalXGlOL+qjIR+uA9v7q0XB76t5+QGqWcIcOVgqfsNmiQSTai
         k+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1wKylVeXOlh5a/xJZmfHNeqpE/OOU4LWHviEMispbow=;
        b=blsX4Nk3SpbPmyjasuLFL7oIDrXnTB3Hz2sDI7MDeDwirLqygsyrLCX6eOXaXApl/H
         BjOjbJ5Thoc5Pyf/eSSefgtNc0CO3lC1HKrNmHfxVK2FxPc0VuPcJ+EId+EBap9KPoDb
         CMV73RjtZJNMI22G0huWfkzwszj50JmlTCy55MhiDan/A3Q9l7zrluPWa/Lz4xBqF0lu
         1ktAKZYX2nWVN5G9sg5LixQLtdzoM5FiA7BT7HMRuVgdmPT/UvTRneOvk/viqMycLkSs
         PG7qDctdnF1/OBkNv9WHUb/obExoW6X3z9Bj4HyvAgjIksLe0lttvc92Rry64RJqrW8+
         epRA==
X-Gm-Message-State: AOAM530gSof/05LPRLicbiRn0wUTlgqqrQigUIjnunVpfHxrh4kcI7J7
        pGBO5pHZaLMIJ/s6CQvguoM=
X-Google-Smtp-Source: ABdhPJxD78C0n16ixwFCcF6HT6dXoMQUwcecD6VhKWgf3/RHBUjz/buDYder3UAVjtffqmkbxj3KwQ==
X-Received: by 2002:a17:90b:3a91:b0:1bf:261e:7773 with SMTP id om17-20020a17090b3a9100b001bf261e7773mr22740003pjb.155.1647624625297;
        Fri, 18 Mar 2022 10:30:25 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:20b4:90a0:8e2e:6022])
        by smtp.gmail.com with ESMTPSA id h6-20020a056a00218600b004f65315bb37sm10665223pfi.13.2022.03.18.10.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 10:30:24 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 18 Mar 2022 10:30:23 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: Add a huge_idle writeback mode
Message-ID: <YjTBryFvhCZXXJ5/@google.com>
References: <20220315172221.9522-1-bgeffon@google.com>
 <YjS2SJU7VE1bGb/F@google.com>
 <CADyq12wQ=vGaGoqt5RXJ5aYM1tQJ2BCT8cav-ONpPrCc85q-5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyq12wQ=vGaGoqt5RXJ5aYM1tQJ2BCT8cav-ONpPrCc85q-5Q@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 12:51:14PM -0400, Brian Geffon wrote:
> On Fri, Mar 18, 2022 at 12:41 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Tue, Mar 15, 2022 at 10:22:21AM -0700, Brian Geffon wrote:
> > > Today it's only possible to write back as a page, idle, or huge.
> > > A user might want to writeback pages which are huge and idle first
> > > as these idle pages do not require decompression and make a good
> > > first pass for writeback.
> >
> > Hi Brian,
> >
> > I am not sure how much the decompression overhead matter for idle pages
> > writeback since it's already *very slow* path in zram but I agree that
> > it would be a good first pass since the memory saving for huge writing
> > would be cost efficient.
> >
> > Just out of curiosity. Do you have real usecase?
> 
> Hi Minchan,
> Thank you for taking a look. When we are thinking about writeback
> we're trying to be very sensitive to our devices storage endurance,
> for this reason we will have a fairly conservative writeback limit.
> Given that, we want to make sure we're maximizing what lands on disk
> while still minimizing the refault time. We could take the approach
> where we always writeback huge pages but then we may result in very
> quick refaults which would be a huge waste of time. So idle writeback
> is a must for us and being able to writeback the pages which have
> maximum value (huge) would be very useful.

Thanks for sharing the thought. It really make sense to me and
would be great if it goes on the description.
