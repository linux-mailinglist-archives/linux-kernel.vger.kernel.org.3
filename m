Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B894DA9EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 06:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353642AbiCPFiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 01:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237378AbiCPFiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 01:38:52 -0400
X-Greylist: delayed 165 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Mar 2022 22:37:32 PDT
Received: from p3plwbeout22-03.prod.phx3.secureserver.net (p3plsmtp22-03-2.prod.phx3.secureserver.net [68.178.252.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EAB5AA6C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 22:37:32 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.145])
        by :WBEOUT: with ESMTP
        id UMJ4nqLNFQy6SUMJ5nkJX5; Tue, 15 Mar 2022 22:34:47 -0700
X-CMAE-Analysis: v=2.4 cv=FaryeLy6 c=1 sm=1 tr=0 ts=623176f7
 a=7e6w4QD8YWtpVJ/7+iiidw==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=o8Y5sQTvuykA:10 a=vqTx_GAQ2IFItUb59xIA:9
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  UMJ4nqLNFQy6S
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=linux.fritz.box)
        by smtp05.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1nUMJ3-0006eR-KR; Wed, 16 Mar 2022 05:34:45 +0000
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     a.fatoum@pengutronix.de
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net, phillip.lougher@gmail.com
Subject: Re: Possible performance regression with CONFIG_SQUASHFS_DECOMP_SINGLE
Date:   Wed, 16 Mar 2022 05:34:28 +0000
Message-Id: <20220316053428.5758-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <c22a0f1c-883d-5122-ef88-0d7c57ab4e66@pengutronix.de>
References: <c22a0f1c-883d-5122-ef88-0d7c57ab4e66@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfCPa6kHz3QF4r1daMeurJ0E5vtl8V/SGuxB3hbNd8D4SknkTLfXkUIGtv9OMibeon9SSx9xYtp/yMhfkeiS6jzqexenC6CxqGc2x71fEUroplIES+D4T
 FWiihfwDS7ZtRcwcc1z8lbIUzWimpkcbn0DNJyVIjYmQB0f4SOnIm7jPQb/8r/Tmt6iPNWh1t6yg2D4/bw/kDHoJb2dl0hH1O3Q=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:

> Hello,
> 
> This an issue we had with v5.15 that we have since successfully worked around.
> I am reporting it here as a pointer in case someone else runs into this and as
> a heads up that there seems to be an underlying performance regression, so
> here it goes:
> 

[snip]

> 
> Looking through the original kernel configuration we found that it has
>  CONFIG_SQUASHFS_DECOMP_SINGLE=y and CONFIG_SQUASHFS_FILE_CACHE=y.
> 
> Once changed to CONFIG_SQUASHFS_FILE_DIRECT=y and
> CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y, we were below 40s as we want.

This sounds like the slow-down that was introduced by commit c1f6925e1091
"mm: put readahead pages in cache earlier" (Linux V5.8)

This commit prevents Squashfs from doing it's own readahead, which
causes a slow-down in performance.  The slow-down is noticable when
using a single decompressor (CONFIG_SQUASHFS_DECOMP_SINGLE=y), and
can be solved by moving to a multi-decompressor configuration, because
it removes contention on a single buffer in the single decompressor case.

This has been already been fixed by commit 9eec1d897139
"squashfs: provide backing_dev_info in order to disable read-ahead"
which is in Linux 5.17-rc1.

Phillip
