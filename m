Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCC64B28FC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiBKPSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:18:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351336AbiBKPR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:17:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D76AD;
        Fri, 11 Feb 2022 07:17:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C6E8B82A80;
        Fri, 11 Feb 2022 15:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCEEC340E9;
        Fri, 11 Feb 2022 15:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644592673;
        bh=Ws0enUbi4c/3fRwV8HT3WSmmmPjd2OSnRT28xJ7K5vI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oZx3H3RF6ZgmhGjP7zs+qUW3WzO4KaXwPj2mmoxVS5D1Cqz5l61wN04/2Q5V/QDX7
         5VGnVqIoYwaHMXlx3honnuE4URE0Vj2P8Zcyki0+Ch4B0mxV3r9rQnUiFw/BoVTk6i
         b5DLrulnT3B+oli22kla1GZG5GMQDh9TK05cL6Z8W5ZK0p0zkeJJLwHSyRcehov56m
         xEz4ZS5nO9zNWFJpkP6sK0OHmHBvOQCombNWuiowtQjOwgK1FV/Mke5WZMGI/dNSmD
         OxtZvSaJVyAPeGZb4d522ikeVyMK1VJxbedwflhim073s73jrhkIIrCncYCaR6jTPl
         4S2KK5stQGCMw==
Date:   Fri, 11 Feb 2022 16:17:50 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH rcu 9/9] rcu: Replace cpumask_weight with cpumask_empty
 where appropriate
Message-ID: <20220211151750.GC588079@lothringen>
References: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
 <20220204230805.4193767-9-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204230805.4193767-9-paulmck@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 03:08:05PM -0800, Paul E. McKenney wrote:
> From: Yury Norov <yury.norov@gmail.com>
> 
> In some places, RCU code calls cpumask_weight() to check if any bit of a
> given cpumask is set. We can do it more efficiently with cpumask_empty()
> because cpumask_empty() stops traversing the cpumask as soon as it finds
> first set bit, while cpumask_weight() counts all bits unconditionally.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Frederic Weisbecker <frederic@kernel.org>
