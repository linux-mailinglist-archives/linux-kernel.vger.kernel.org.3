Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42592512DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343783AbiD1IH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343614AbiD1IHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:07:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7681C9D4E9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:04:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A049B82B35
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8839AC385AC;
        Thu, 28 Apr 2022 08:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651133069;
        bh=a4NV7CQK6Y90eH2eoXqtxoTPh+hLluRrEcM9Svhipig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A4LSuu97UOwolzLArNy1m00e0wSNj+xL9+j8kHVdHISRsj4VK4HVv1Wv9r77cAJyk
         kECIWjHun6ASGD0enxC2oREBdR5/3lDApaYe2RNGRJLYK0081GrKV26vyuIz9/7IdK
         9EkWrX8scGXD1pymVAWg8Uk/ItsuOg5lzuvt6WRSh0GIQcR9jZkmGn3akFuNSssw2T
         v+/3tXM2a9JCVrJ21fnn/36WUTp0wtGCwBtFZVnMyLXh0Vpw3hh9eevTL3ZFX6oAKw
         nkG/cuWvjLVhSkdTq76p/yhn6DNKuuXGPdCgWDa6luLziS3cKEwPxsVrVAtFS7YgUn
         jnZZvs59IMDTQ==
Date:   Thu, 28 Apr 2022 10:04:24 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 1/2] seccomp: Use FIFO semantics to order notifications
Message-ID: <20220428080424.p3ltkcwtk3icvq6n@wittgenstein>
References: <20220428015447.13661-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220428015447.13661-1-sargun@sargun.me>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 06:54:46PM -0700, Sargun Dhillon wrote:
> Previously, the seccomp notifier used LIFO semantics, where each
> notification would be added on top of the stack, and notifications
> were popped off the top of the stack. This could result one process
> that generates a large number of notifications preventing other
> notifications from being handled. This patch moves from LIFO (stack)
> semantics to FIFO (queue semantics).
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---

It has a minimal user-visible impact in a sense but I don't think it
should be an issue. Makes sense to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
