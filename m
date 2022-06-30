Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9172C5625D6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 00:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiF3WJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 18:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiF3WJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:09:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4023B50704;
        Thu, 30 Jun 2022 15:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tb7xc4sH1KrEahBlbDzaoJzaNufCKqUnLt5CgcUm9SE=; b=rc05lfPd83uqKfhWazhXrh5rVm
        7Nsk88URc5Sr95SF4omVfVbcV2SgUno9+YrPyMpVHKGKHu7OWrMQqudTTh674RmiF4T0Yd7weHtFQ
        9/xJIQ6u9FG/bSyzGKo8q4SwKrPuIXdmGfZU3gjlOIASf+ZOB12AtMxRZFXs9slUc5No8Fr8RxmeP
        oV0K8271MWFd7koNzFYYMeAK1gWTS4vCT/nKaoYX8YnYfiUngeLPdRsXZPD1eNk6E2KTNAuSIAM4L
        4ZTvJd383I5VygEQ6Jyo8gL8u/grSZ+w1wynE+8g8mn/nG6YIh/CH0zZG/7aJWuCi7Uum3t8+dRNR
        3nQGo0VA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o72Ls-001lnX-TU; Thu, 30 Jun 2022 22:09:32 +0000
Date:   Thu, 30 Jun 2022 15:09:32 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] kmod 30
Message-ID: <Yr4fHBR08VAVbs2E@bombadil.infradead.org>
References: <20220630153621.3fggpqrbyvunhwfu@ldmartin-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630153621.3fggpqrbyvunhwfu@ldmartin-desk2>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 08:36:21AM -0700, Lucas De Marchi wrote:
>         - modprobe learned a --wait <MSEC> option to be used together with -r
>           when removing a module. This allows modprobe to keep trying the
>           removal if it fails because the module is still in use. An exponential backoff
>           time is used for further retries.
> 
>           The wait behavior provided by the kernel when not passing O_NONBLOCK
>           to delete_module() was removed in v3.13 due to not be used and the
>           consequences of having to support it in the kernel. However there may
>           be some users, particularly on testsuites for individual susbsystems, that
>           would want that. So provide a userspace implementation inside modprobe for
>           such users. "rmmod" doesn't have a --wait as it remains a bare minimal over
>           the API provided by the kernel. In future the --wait behavior can be added
>           to libkmod for testsuites not exec'ing modprobe for module removal.

Sorry for the super late review, I was swamped. OK so the only issue
I can think of is that rmmod *used* to support the kernel wait support
with $(rmmod --wait) so wouldn't this be odd?

It is why I had gone with:

 -p | --remove-patiently   patiently removes the module
 -t | --timeout            timeout in ms to remove the module

You would know better though.

Also just curious, is it really terrible to just support waiting
forever?

  Luis
