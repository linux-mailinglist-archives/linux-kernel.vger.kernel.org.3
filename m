Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DE05652F2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbiGDLBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiGDLBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:01:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EBEDD0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:01:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CDE6B80E42
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 11:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0F0C3411E;
        Mon,  4 Jul 2022 11:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656932477;
        bh=IHt85bKJbsXTs0dIvZOMIwOWJA58+2HcncvJ3PCfzTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cLl0yM2IPlS6RosBDJtApiuapm+3NoxAad4R1eZZ5IKNt4COrJtyOnMjBHJo3dBUD
         GfFadG7Cq2MtR8qUqyOtxk78e7fFE52S6CsCGWNcMu3Z7qdHfD4BNgHyrAM8eA4eQK
         n22j3XT/ZTBSoBDbGhIM0ZszADLy8/YJ7YSNH84s=
Date:   Mon, 4 Jul 2022 13:01:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Message-ID: <YsLIepAXeBKT0AF/@kroah.com>
References: <000000000000d9ff3a05bb37069e@google.com>
 <72e74af9-f1b6-e383-a2c3-6ee8a0aea5e0@I-love.SAKURA.ne.jp>
 <YsKW6VvWqvcMRBSl@kroah.com>
 <100f445e-9fa8-4f37-76aa-8359f0008c59@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <100f445e-9fa8-4f37-76aa-8359f0008c59@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 07:25:44PM +0900, Tetsuo Handa wrote:
> On 2022/07/04 16:29, Greg KH wrote:
> > On Mon, Jul 04, 2022 at 03:44:07PM +0900, Tetsuo Handa wrote:
> >> syzbot is reporting hung task at misc_open() [1], for snapshot_open() from
> >> misc_open() might sleep for long with misc_mtx held whereas userspace can
> >> flood with concurrent misc_open() requests. Mitigate this problem by making
> >> misc_open() and misc_register() killable.
> > 
> > I do not understand, why not just fix snapshot_open()?  Why add this
> > complexity to the misc core for a foolish individual misc device?  Why
> > not add the fix there where it is spinning instead?
> 
> Quoting an example from [1]. Multiple processes are calling misc_open() and
> all but one processes are blocked at mutex_lock(&misc_mtx). The one which is
> not blocked at mutex_lock(&misc_mtx) is also holding system_transition_mutex.

And that is because of that one misc device, right?  Why not fix that
instead of papering over the issue in the misc core?

thanks,

greg k-h
