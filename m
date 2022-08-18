Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE5B598642
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245150AbiHROoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245280AbiHROoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:44:18 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9532927FF0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:44:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k17so939101wmr.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+3dbFH3P6bvqViGYIfGXx24q609p+/zZUcUFtVnI09w=;
        b=L6mwgXeuMhhLgumt/3Ptf4T89zmo0JcbbGqfHsUYqVm99xFzBG7RCJyBKCkbPm1zqQ
         fFwCpgXUwa+PFojDFRcpYwXiIQSMfihC2nr3iobJifvqxNd4KIYp9GjbSpqaA/tpLN0+
         4nbKfZ2B9BaiF4WMV/Ut2iryuZYz7t7ic+KyBs+RcoHVzCrc0zlVodorn81Df7CnvEFF
         8g4IvOWMpLQtJCXPrnOOO4bntMzJq3djLPn1M7SkhfzQjiWqTwUmSlsj318Z8JFz+a6d
         9u5cNtXO9c5NV1sEqSXurbTw0KZ7edpToqaogOLEAclMCGXwTAxsbuC7sicfVIbQkJ3x
         Rm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+3dbFH3P6bvqViGYIfGXx24q609p+/zZUcUFtVnI09w=;
        b=RpvcRpoq1dQipLgiqm1z+AO0hwVhA8MRSFDsMN2sut9+jCeeXpt8kKyxBzACTdvZaC
         UFZCgPfWqRv0ShILkbkgXykSZ1YWdOMdm9n8wkVOoP1ZdmRwKxGyH9lwwYtN2oH8+6Iy
         cwkL6XKev1LCKNCOrVeLB1gHK8G5ABgiPFo4HjnDJ55yYu+SyLJ0FS/5ibTZ4jaNkkLq
         EtcTnWutnH4EyoYcmrLCNQLeDjD4pYoeNDVg7dhAN+1kvsSJzUIohKVFQcxLkE7ptxcU
         2tymk4gDwkq68uG4Ryze9wfrM1Zn+Z8Twab2dAukwuo9IEtW3SrEBgIFxnpoV57njv1j
         fPSw==
X-Gm-Message-State: ACgBeo3CP3PRDDnY7IjMxnW1SH4J4/KhKXRB9iqA3IdwZAWQu/8Cm9Ty
        ET6CYKoTD9xVjK6xQhFFSmDO9z4lv6jUGDOeXYw=
X-Google-Smtp-Source: AA6agR7FtpY3SYHALc0HRTGEVNcQG61WEvIKRoIuLFVjhE8kpDJE2AmXE5Cu0dESJH9vjePzqrL2kzH7Efg3CP0x6T4=
X-Received: by 2002:a7b:cb55:0:b0:3a5:41a:829c with SMTP id
 v21-20020a7bcb55000000b003a5041a829cmr5422048wmj.153.1660833853933; Thu, 18
 Aug 2022 07:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220804084135.92425-1-jiangshanlai@gmail.com>
 <20220804084135.92425-8-jiangshanlai@gmail.com> <YvwVbWfoV/bkFb6e@slm.duckdns.org>
In-Reply-To: <YvwVbWfoV/bkFb6e@slm.duckdns.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 18 Aug 2022 22:44:02 +0800
Message-ID: <CAJhGHyAy2OVd_q_dtJ+cLX=BuNOa4L7hPn50oj_Y7iwBuNEfRQ@mail.gmail.com>
Subject: Re: [RFC PATCH 7/8] workqueue: Remove the outer loop in maybe_create_worker()
To:     Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
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

On Wed, Aug 17, 2022 at 6:08 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Thu, Aug 04, 2022 at 04:41:34PM +0800, Lai Jiangshan wrote:
> > worker_thread() always does the recheck after getting the manager role,
> > so the recheck in the maybe_create_worker() is unneeded and is removed.
>
> So, before if multiple workers need to be created, a single manager would
> create them all. After, we'd end up daisy chaining, right? One manager
> creates one worker and goes to process one work item. The new worker wakes
> up and becomes the manager and creates another worker and so on. That
> doesn't seem like a desirable behavior.
>

The recheck is always in the same pool lock critical section, so the
behavior isn't changed before/after this patch.
