Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04484AC415
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379810AbiBGPnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354436AbiBGPi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:38:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538CEC0401CF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:38:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5A6B6149E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4498C004E1;
        Mon,  7 Feb 2022 15:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644248337;
        bh=RTvZKxiiVb4DkndrEqiIDyBFoJwkTFHw/l8m5UQFWBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LbdsYVt2FV8bRWojeV2R3PTQUMumkhGQtqRdk2aVie2hIT9esB1HKCuPakXKuz4zX
         xkuwhlhp/BXCSREg6Ls9UCh1iAjGeY3e9E5uWyqOw4Cad3NTwal0Yd2+wpGpOjXbgS
         IsO0/QUB9nQOi9chhM1uXRfBWt6h9Na/R6W8UVXnAcyTjbldJ3wyGgAvS6OH6qK396
         2GCEkMKIW0nMzMy/gHONkjYdPtnDxbWku7wZEwUL3yJt7G8k5BmadOVb20zdzRZ6an
         X11yXJjVrBPX7tExR8np6DaCOLv9ihsqTs+jTGBbeEbyTErwV7B2z0CrfRt5edZWuL
         elMkDjHUluKcA==
Date:   Mon, 7 Feb 2022 16:38:54 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: Re: [patch v11 13/13] task isolation: only TIF_TASK_ISOL if task
 isolation is enabled
Message-ID: <20220207153854.GB526451@lothringen>
References: <20220204173537.429902988@fedora.localdomain>
 <20220204173555.047244789@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204173555.047244789@fedora.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 02:35:50PM -0300, Marcelo Tosatti wrote:
> This avoids processing of TIF_TASK_ISOL, when returning to userspace,
> for tasks which do not have task isolation configured.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Ok that answers another of my questions :-)
