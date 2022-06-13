Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3DC547FDC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiFMGv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238389AbiFMGvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:51:06 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30A31EAF3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1655103008;
  x=1686639008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lU9y07l9htX2Ezpv/Wvu2OgEPWWB1En/PGmEDFqjdJQ=;
  b=fRhApd4ArXD3ZG3tGMvwHj3q3mVES9eQQ3RJz+k6CM50CPYApPGSw8Dc
   5JSe8AF89GVg42zwXcrX5iHvJ9wHwJc+XA4QOYrPJ6ZQMnvK9SB8xF/8W
   fJKCQfdqwRlzvt18kc4iqupgNk7GSCF3126fjQ2SCNDV8ahjA+7VpqB1/
   e5Z4e54UXDYmubhDMYghN48w43EVNCHmQkXy5HPNvAE1BxIrz4G/6Q1Sx
   JFocgTKqAev0Mpc0KP5rB58n6Pdrz+zlpHryZHFZ6cp3IDftFQtnD3P/O
   eovElCL/+66tupSr8Fp7Ld6QT8/K27ftzhMnAQxReXGrDKxx/50BgfjPb
   w==;
Date:   Mon, 13 Jun 2022 08:50:05 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        kernel <kernel@axis.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] um: virt-pci: set device ready in probe()
Message-ID: <20220613065004.GA21804@axis.com>
References: <20220610151203.3492541-1-vincent.whitchurch@axis.com>
 <20220610203029-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220610203029-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 02:34:04AM +0200, Michael S. Tsirkin wrote:
> BTW Johannes I think you need to spec this device and get
> an ID - what's the plan for that? Current hack of punting
> this to userspace isn't really any good long term.

There is work ongoing in QEMU to add a new vfio-user protocol to support
out-of-process PCI device emulation.  Perhaps an option would be to use
that protocol instead in UML too in the future?
