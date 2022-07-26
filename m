Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4518A581C30
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 00:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239768AbiGZW7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 18:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiGZW7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 18:59:16 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB0D3138D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 15:59:15 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso379259pjo.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 15:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=I3+YpxkvXtfzvqLFK6EpVVyvFGo9ppDiS3sGt5NFMLc=;
        b=fPuSdIlSJzfbrMuzeE9NlLytdovFjVMciuPpoivUujWqIlkem7Zd7xe1FQ58wZAD4x
         YR/60HaR4FRPtbX8+vfP3xCEihFnvZ68U27oRXyEUYbNo2EECDGPX7DiSGB4DFwiMGZi
         hEifeVvPuOUWqBWcb6UpFHFzEBP7fJHdEHLjgb+C+BgGmI0tDUUTItkIZv7PAUM19fhZ
         ckRiXtGfKy3JCZeuqbAox/XTxmrg2PhnJAuMKQpdAEOou2qBinb7qY3Xuaox6Fd1yamD
         cfEWW3SeTdcDGmzbJ0bcNXTmYuVb/sc4z/BVCrFsMoG2JQuV+OuORuiFTVKN2zZA+AJ1
         iwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=I3+YpxkvXtfzvqLFK6EpVVyvFGo9ppDiS3sGt5NFMLc=;
        b=JFxDCg81nXfcezj3N3sgUwx9LhKKbm0jKJ6XtwVxb9kE4aO0vwKgYRDNgJTRURRGs4
         QlVkas6aOaFsKnbdo6L48gOLydCCH3FwrQJVQps5B3RP+pV9FSbt5sFtQvMaRbMVhC69
         HfQzucVIVVxZQaz2X6GctfgXb6pt0wZQ+XdKlmXgaJ5Ktnqghi9aDi1Wi8+lWZLZTiQO
         ydv4pIiEpSdKXjqxlmiKFbWHkmuZmdGasTHQme1UVHkkywtM2kSOQlXx5dXlhO1KFdan
         YJxtnHoR9ApQVH3RXBgoY7/NngqGdGwCNyAzs2s3nQvboVJBm5sf4VJKGlafOH0Fq9NZ
         sQMQ==
X-Gm-Message-State: AJIora+hU1FcyxrMAX64sI1X+i5brNycFx6XJEZD4JhL/F8XelWRVjhe
        nmLUUl3d/HStyPGv8iwjc1c=
X-Google-Smtp-Source: AGRyM1tiUsjQQeJIZQ5KzvCsnmw2TJ6FM5z5fQ4S/J+vo98hPuAMKhmmClur9cqoIpMGllX5OFJm1w==
X-Received: by 2002:a17:90a:760b:b0:1f2:3d0d:9b64 with SMTP id s11-20020a17090a760b00b001f23d0d9b64mr1325008pjk.74.1658876354975;
        Tue, 26 Jul 2022 15:59:14 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:370d])
        by smtp.gmail.com with ESMTPSA id a24-20020aa79718000000b005255f5d8f9fsm12151791pfg.112.2022.07.26.15.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 15:59:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 26 Jul 2022 12:59:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC PATCH] workqueue: Unbind workers before sending them to
 exit()
Message-ID: <YuBxwJNvysduDmLG@slm.duckdns.org>
References: <20220719165743.3409313-1-vschneid@redhat.com>
 <YthDjPq3CtWc+o0/@slm.duckdns.org>
 <CAJhGHyAso+JH+QMXcfKTyOqq4yBD9Vc19sBbebEXohHe5znL8Q@mail.gmail.com>
 <xhsmhv8rqfu6w.mognet@vschneid.remote.csb>
 <YtuEJLDkO/lATYeb@slm.duckdns.org>
 <xhsmh8rohfq6m.mognet@vschneid.remote.csb>
 <YuAkroXHF+Zg45KU@slm.duckdns.org>
 <xhsmhmtcvehmx.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhmtcvehmx.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jul 26, 2022 at 09:36:06PM +0100, Valentin Schneider wrote:
> It's the *something* that's annoying to get right, I don't want it to be
> overly complicated given most users are probably not impacted by what I'm
> trying to fix, but I'm getting the feeling it should still be a per-pool
> kthread. I toyed with a single reaper kthread but a central synchronization
> for all the pools feels like a stupid overhead.

That sounds like quite a bit of complexity.

> If any of that sounds ludicrous please shout, otherwise I'm going to keep
> tinkering :)

I mean, whatever works works but let's please keep it as minimal as
possible. Why does it need dedicated kthreads in the first place? Wouldn't
scheduling an unbound work item work just as well?

Thanks.

-- 
tejun
