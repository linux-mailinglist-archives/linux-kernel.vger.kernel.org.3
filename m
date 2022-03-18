Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9653A4DDA62
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiCRNXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbiCRNWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:22:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E5917C415
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 06:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FF3C6198C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D350C340E8;
        Fri, 18 Mar 2022 13:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647609695;
        bh=Vm35F8NaPW4AkClK5FRsDrk1EowlZfCpGghmiZsPsRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0EsiWoRregC4UH3nbNjSBWsCIpR9kjVoBUkljOb3mXromElfEPpFtVlyQ4WMZp+h2
         LLmJ99emv2xIHD8J99gNyk2amwJo8f/ZdlBFwRh1X9whawMHdV6MXqmx5rNCSZVfjZ
         mSlxOrHMe8HoNKJzxEgofsXXLW+sizAcpDZZljQA=
Date:   Fri, 18 Mar 2022 14:21:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH 07/16] debugfs: Add signed versions of
 debugfs_create_u32/64 helpers
Message-ID: <YjSHXJZAlntzmyKZ@kroah.com>
References: <20220227205608.30812-1-cristian.marussi@arm.com>
 <20220227205608.30812-8-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227205608.30812-8-cristian.marussi@arm.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 08:55:59PM +0000, Cristian Marussi wrote:
> Add a few helpers to deal with signed values integers; built on existing
> debugfs internal helpers as the existing unsigned functions already do.
> 
> Make the simple_attr_write() internal helper detect the sign of the
> requested set operation from the related format string: this is needed
> to be able to properly parse negatively signed input strings.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> Note that in the rest of the series I do NOT need the s64 WRITE/SET
> operations, that required the more invasive simple_attr_write() change,
> but it seemed odd to implement a get only debug_create_s32/64 API.

Let's wait to add them when we have a need for them with a in-kernel
user.  Otherwise I'll just end up removing them eventually when I sweep
for "is this used" cleanups.

thanks,

greg k-h
