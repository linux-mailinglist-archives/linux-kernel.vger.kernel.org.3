Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA7950C7DD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 08:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiDWGyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 02:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiDWGyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 02:54:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DE55F8CA;
        Fri, 22 Apr 2022 23:51:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C6F6B80022;
        Sat, 23 Apr 2022 06:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAACC385A5;
        Sat, 23 Apr 2022 06:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650696680;
        bh=K/et5AaKBRLTBYtnLXvvukZr52M2pfPjJy2F2k300V8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=coRHeWIRmnAV7xb3syQDjEUvW8vLdNM4I37T4uJOt7KEdtkyq1AFj1lQiS/OuH9vg
         yzNIpqqmJklkc1i/xvekGW7Bcff9m9lSqzayeV+RjrA6idcxYQ9OlhPCq1Frr5uron
         oBXFiZrspQR8fSjShC1uMylq4Zm7xCEAhgKilsT8=
Date:   Sat, 23 Apr 2022 08:51:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, qperret@google.com
Subject: Re: [PATCH  v2 0/2] Detect stalls on guest vCPUS
Message-ID: <YmOh5I7ZK08LlM6D@kroah.com>
References: <20220422141949.3456505-1-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422141949.3456505-1-sebastianene@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 02:19:48PM +0000, Sebastian Ene wrote:
> This adds a mechanism to detect stalls on the guest vCPUS by creating a
> per CPU hrtimer which periodically 'pets' the host backend driver.
> 
> This device driver acts as a soft lockup detector by relying on the host
> backend driver to measure the elapesed time between subsequent 'pet' events.
> If the elapsed time doesn't match an expected value, the backend driver
> decides that the guest vCPU is locked and resets the guest. The host
> backend driver takes into account the time that the guest is not
> running. The communication with the backend driver is done through MMIO
> and the register layout of the virtual watchdog is described as part of
> the backend driver changes.
> 
> The host backend driver is implemented as part of:
> https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817
> 
> Changelog v2:
>  - move the driver to misc as this does not cope with watchdog core
>    subsystem

Wait, why does it not cope with it?  That's not documented anywhere in
your patch that adds the driver.  In fact, most of the text here needs
to be in the changelog for the driver submission, not thrown away in the
00/XX email that will never end up in the kernel tree.

thanks,

greg k-h
