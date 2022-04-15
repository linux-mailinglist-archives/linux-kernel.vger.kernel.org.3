Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4645025AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350525AbiDOGhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243518AbiDOGhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:37:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24AD36E24;
        Thu, 14 Apr 2022 23:34:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 726BC61F9B;
        Fri, 15 Apr 2022 06:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644EBC385A6;
        Fri, 15 Apr 2022 06:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650004471;
        bh=qOkWjTm4jX4AvkPwppg3cnPY3tsk8Meh+/ejuV0aSaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qab4SoV02o5s+JFFSNc5BEgvyjc7BB3oKR/q0QtT5pYYHQn7YvFCdRII+zSaYCdlf
         Y24KZjR2JpXxKXLLLLzSCwiSmwwEeyLn8SnYg8i/WaAo5YNrDa5WYw4iThlmFUBTmO
         zGUpnLdZLzd5lfOVNs/C1Wbdd4CfO7YfWsBs8tSQ=
Date:   Fri, 15 Apr 2022 08:34:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/20] tty: n_gsm: fix wrong behavior of
 gsm_carrier_raised() on debug
Message-ID: <YlkR9IvOO7clhMWV@kroah.com>
References: <20220414094225.4527-1-daniel.starke@siemens.com>
 <20220414094225.4527-19-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414094225.4527-19-daniel.starke@siemens.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 02:42:24AM -0700, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> gsm_carrier_raised() returns always 1 if the kernel module parameter
> 'debug' has its second least significant bit set. This changes the behavior
> of the module instead of just adding some debug output.
> Remove this 'debug' gated early out to avoid debug settings from changing
> the program flow.
> 
> Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
> Cc: stable@vger.kernel.org

Why is this relevant for stable backporting?  It's a debugging feature
only, and you are changing how it previously worked :(

