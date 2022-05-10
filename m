Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C49C5211E8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239765AbiEJKQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239683AbiEJKQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:16:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB7E22443A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:12:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7103DB81CA3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D4AC385C6;
        Tue, 10 May 2022 10:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652177526;
        bh=QmuWibf0H4i5Fp0lHfXG6BYh3c7qg5D5YVIiI8VF/j0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLj6qPy4zvtyH2x/7kfRGQc1H4eo53tSgek0rr/aPss3/CnT5dUQwR/glYHI7EMh8
         yLsMyjVz6PI7Z12r2H1yr1Cn8JSGkmZlTrnflVNMbSdhOdgpB0mdsFcXf8QdTT5tQp
         iEUWt2AZeKiyIC3aq2J1yGO3+0taoRYOxJDgwDwx1wchsSWPFUM7PgrDTrxvcG6tPo
         XzyrJpPfL6oWmGtfdzNduZJIAvbQs+z+lmc7thOfdZuA5upHNayL6XRrp76IK+4XRJ
         sJ5LwyhSMkQNHqrqA40li2Z8+5f49EGGNyvExttI1rEBIiuU6rlVxcN9Po5rGbnDF6
         9qzSLengJGJWQ==
Date:   Tue, 10 May 2022 12:12:00 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: fix printk format for commands
Message-ID: <20220510101200.kjbe4ibvscxaquoj@wittgenstein>
References: <20220509231901.3852573-1-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220509231901.3852573-1-cmllamas@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 11:19:01PM +0000, Carlos Llamas wrote:
> Make sure we use unsigned format specifier %u for binder commands as
> most of them are encoded above INT_MAX. This prevents negative values
> when logging them as in the following case:
> 
> [  211.895781] binder: 8668:8668 BR_REPLY 258949 0:0, cmd -2143260157 size 0-0 ptr 0000006e766a8000-0000006e766a8000
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Looks good to me,
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
